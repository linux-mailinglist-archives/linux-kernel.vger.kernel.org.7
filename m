Return-Path: <linux-kernel+bounces-776638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77CB2CFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E0A3B1C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507F2749F1;
	Tue, 19 Aug 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jiiniF5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F526FD86
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645357; cv=none; b=noDwUo6JguOL3Wm/mnz2cPClUqzbfgiNfOdS9viNsjeWtgcVQC5SmqXc2wLGqyXaw1NBr2LYSl33pFvPnaDgSwWG/Sfbmjv1WAw3QrRVQypf/wSTTZBO58AWNmDKgB1YMqyXqnCd6FAQbEzg1WoU0/FCvTVWoNn5c1A8mWiIeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645357; c=relaxed/simple;
	bh=NO69rq7d5HUh7N31HaJu2N7TJPqjMuDJlwxFXJM/PEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=muBOeTBCy6NOZ3x+DrLK255zvEvX1uVWR7AmdQutmEr28xX/UMOAPoNiOz12LjA0D506xhNZKBOaMY8YIqgVkYC0HipIs98VsjMfpra5r2UjHuHp9MxwJjt88fJ0ZAUkeHv0+YjTH6eqrbySmb4PSdkY0ESt53MoA7GvfYZLPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jiiniF5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457efb475so67303365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645355; x=1756250155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0DUi8ibOczq1f4cubQAD/UGcZ0gSQdUjEwCmiQNclU=;
        b=0jiiniF5PNQN+L/lP5Ij4gxIKdLW1U0Jk5/76Yr3aaKa4rtgr+3Uu9L1ynNV8yJnJv
         PYImhFu8DxueJxyXym9MgRdN5WSd+r5pdDQmT6RQkY6FwHhoidaxU9pntC0oI9DnhjxL
         7ivOFo7QvUANISrNdyxyYz5Dsr5WYkYuZEMVguROyZelVP4Vx2QPG8vGbiTkOiTH/81z
         10Veow0tt60uzpwr+pN+bsBA3YWVQ1CCwMzP9SFhDn65y2lqawttkepwZ9Kw0vw3CcYo
         H55kqftKYcb20Gn8pgz9Rkva+5idxiLO9rOtrKUsEv2Wqw++ExNMUQiSNpKFu4dlsiVq
         ax4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645355; x=1756250155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0DUi8ibOczq1f4cubQAD/UGcZ0gSQdUjEwCmiQNclU=;
        b=Ym3ot1xut609+k/1I9F834mt+m8I3UMCcslNnlrmkPkpZ0GcHPE5jw1gbtwNQoqsq6
         fQYI6SlW3xmBXIIoNRDr1dk6WD8BZgUZRgIY9bRO0r298THpLPZ8JU0Nnbccz3888YgQ
         I9f9Y3xmwn1bdMAAN+M/z5BElSf4I+iu01L1NBMoRlsGoE19BbPNCAiUq5nIJBQhEWDK
         XS50u903/pLUuBjlptQ3/ko2mDo8VDcqsWObFISKHk8p8JnprqMyhDgDcAKwQXf6ggc5
         WVEYuau2nyh64KC05ak9DZPTiatqLwqVMXFF1aiznU1VooAkmLFp3mYGPp0u0TOuan1/
         K4zA==
X-Forwarded-Encrypted: i=1; AJvYcCVb03QsDKqAq8S8mMoP2MxfkpCxJAG8AUb48tlyiSLT20X2KC8SHHz7xjYs0zM/KioBYVryLvqlREbMQ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsT8bu84SQFGVTBalHpUEI+hAM8w+hoQZiVsSnBPlmYydGC9P
	Gzkc47rxXYlVmK6yCHVJ2E4uxsGh88Hl2VX4cHtxlkra6RF0FM1teymWtDBeDsiA3cnxZK4oOyO
	6TrQTNA==
X-Google-Smtp-Source: AGHT+IHcf88wRiO1+bkleq0IuKOV9laDBxE+jirJg6ycDufA1xP3QL4fw1Og2N36QTHGeFtGqJnDCCaMSGU=
X-Received: from plgq10.prod.google.com ([2002:a17:902:eb8a:b0:23f:efa6:2e49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:234:cf24:3be8
 with SMTP id d9443c01a7336-245ef2341bfmr7178255ad.28.1755645355614; Tue, 19
 Aug 2025 16:15:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:07 -0700
In-Reply-To: <20250728152843.310260-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728152843.310260-1-thuth@redhat.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564466081.3065897.4757741827876819544.b4-ty@google.com>
Subject: Re: [PATCH v2] arch/x86/kvm/ioapic: Remove license boilerplate with
 bad FSF address
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Huth <thuth@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 28 Jul 2025 17:28:43 +0200, Thomas Huth wrote:
> The Free Software Foundation does not reside in "59 Temple Place"
> anymore, so we should not mention that address in the source code here.
> But instead of updating the address to their current location, let's
> rather drop the license boilerplate text here and use a proper SPDX
> license identifier instead. The text talks about the "GNU *Lesser*
> General Public License" and "any later version", so LGPL-2.1+ is the
> right choice here.
> 
> [...]

Applied to kvm-x86 misc.  I followed the conversation as best as I could, holler
if I picked the wrong version in the end.

Thanks!

[1/1] arch/x86/kvm/ioapic: Remove license boilerplate with bad FSF address
      https://github.com/kvm-x86/linux/commit/49be82d4ad2e

--
https://github.com/kvm-x86/linux/tree/next

