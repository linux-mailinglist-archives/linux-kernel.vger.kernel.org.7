Return-Path: <linux-kernel+bounces-723837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8BAFEB95
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8675A5ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC72E716B;
	Wed,  9 Jul 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDa9Crzm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65622E6D01
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069970; cv=none; b=Xx9LOKUeXjGDgIdkUjBkWeZB5Om5wG43UvTqYJhAaHsGLTzXTVBfFy8oQDvOl5nzXS/19TIyn9sKbIqI0N6Ir3mXVb9ENJbvz08njmCytm1t2c0qIhrtVCyvJYfId/htxsTT7g5rl7pKK+k9Yc5bhJh/bHhdVwU065Le4nxHNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069970; c=relaxed/simple;
	bh=y6xqr/wBNWhU0qZp0A/9KgmB0vwEU0Tbgf2ufBCTot0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9tMS3gcBSa6HFRWAdwSgPP5gFQw/62vyS+Rn2YZQXlS6lXpr1PMRa+ExpWdfDfTmCZWsi7M/hwRTYEpnw+88n/gIbKoChJQPG7jeYzBhz0HhgfT7bz7XOjaH6eYhFFBakiN3Y41LlgllBmnKDo7FO8qaw45L/2SAshTjS/IGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDa9Crzm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3122368d82bso8580104a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069968; x=1752674768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlRzbsbIQZ4T2BRMJH6FD0A9BGwUR7v2I2NL5oQaD40=;
        b=GDa9Crzmg/tbVQWFuCN3i5y+GpNS1qCN6rnGfAryKGFwQSkps4ZRGvhK/gb4mWfZDU
         NGEH0HqERXqBpF+gt630dZxEgoLBpxw27GMxFZ78qkiMWqtWepOHlLwi+TSkdtZvsOTA
         ORDD6kC51qMKsuOPa7vKn+tln0AMexzWDm4z/yRS1vVI8LBlBt4jfjZy+EzxMcfYqPnk
         6AtihbO9OTGqACYjcYTSfiphF1FtkUHhojmgzWwDAUSnpNYh0X9pGl6zOiVt5fORQDG+
         u/CG7I935VIxoKUMWdwDsvanFiSSv3Vd3+ZS/0CGxldWqCg9EBsxuy9FWV0H2kLWhbzt
         Pc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069968; x=1752674768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlRzbsbIQZ4T2BRMJH6FD0A9BGwUR7v2I2NL5oQaD40=;
        b=O48PDx07wXQw2m/xXYh5xnpkTBcd5X9uDltVvluuznBwsxXK+P/XHOunYmqkFHrGyR
         JP1HrMikzJTyvMX95H2iQLMteJg7xfnmv+v1mysnyfc6fBJgkqcyZSB8XEy7U3ryXiWv
         bQYIZ9mWHHJf7gZEt7XS58qtSDkfb3FO/oGGLheSytR0dDevlVn9vzgVGzLvhtNKZu6v
         s71HLfni2ZGJ5kyf2jF0lQ/gA8g6uBX0X+f6LqX74TTHw4MDpKug+c2qtlZlI8jccb8A
         iu1Zg45K2ssyATY23RAGbhugiVD/D+NbIz/9JuJQJ9BHv2iJ334G84kunExxGeIZk2KS
         LUXw==
X-Gm-Message-State: AOJu0YydDLFC/GzwoGXIbz3EKUhbiS2f93cb1RK7P71lmDOFSrzwIZnE
	pW85J4UgpWfe+/uIxxbO/gPkmziMy5BqexU9sflhBSrN1sbi6PVrxs6AJQa2edlVUqrvi4EIZpt
	MFKoFLg==
X-Google-Smtp-Source: AGHT+IE0oSgaxWq0fZDSOwOBPIswqkFjMD5haT9ucE9SRBQPhdVVhvHREWsvywwcFfqohS2D08NmtNBBbnI=
X-Received: from pjblw1.prod.google.com ([2002:a17:90b:1801:b0:31c:2fe4:33b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5147:b0:311:c970:c9c0
 with SMTP id 98e67ed59e1d1-31c3c2e4517mr54015a91.22.1752069968097; Wed, 09
 Jul 2025 07:06:08 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:06:06 -0700
In-Reply-To: <20250709033242.267892-8-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-8-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53TnZw5H3Tffb8@google.com>
Subject: Re: [RFC PATCH v8 07/35] KVM: x86: Rename lapic get/set_reg() helpers
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> In preparation for moving kvm-internal __kvm_lapic_set_reg(),
> __kvm_lapic_get_reg() to apic.h for use in Secure AVIC APIC driver,
> rename them as part of the APIC API.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

