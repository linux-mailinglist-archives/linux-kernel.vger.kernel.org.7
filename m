Return-Path: <linux-kernel+bounces-723839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DCAFEB83
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02060188D7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A02E7657;
	Wed,  9 Jul 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTxIKlRN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C42E7174
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069985; cv=none; b=k68QHRzlzUWDtIOX+EGZIPfG0ntQOfh/uJFm8c8b1SuQLiBAse35Qymewp/h9c+lkcz4EYa+IkRfxxyWsnz7TwdN8cz+kfnEZdRYyQH0ssi21eJ3tp+QywA7AD+FIgdZ9H3OOQbdfMMbfEt4J+ncGo5UM96e/KrwXfdjl1+oB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069985; c=relaxed/simple;
	bh=WDjc3gj4jQOgT0wQPLLNSrhraX36b/fAJ5t6OlsrilA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jr1hWVdxxc369sjzZ5awlRBRqWVSLD4Arc7J+HoRTy4rWRX4wemtAQ+Za8/CyTLZTzaJQ/uvap1AX6ajKGjNMHW3SvT/CEJ2+zxMhosRqaLyOWoH9K/vkhWuQgp0TJqAPZ7bq6IIY4ea1BO/p6DAlH71m2ErZqx1CeWeIRaJFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTxIKlRN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso5677811a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069984; x=1752674784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpVhcnqQ4QopgzrrBAwITtPwYaxzjuUgzAB3u2opJd4=;
        b=PTxIKlRNhS77rr8ToV4HuRPyqWpMY/EmYGAPmXSorPzFKYUnwZsQvvhBCZgffqcokS
         NFPRg/mupUHnQHeYk5CrsiqJnTDWFIe4fDuqteT3bW52osTMz+ofoL0+VTy52Gad1MME
         ZrzM2zid9A+TBdu65grxfZOI09u+Pe3NB2uwvFJPhppjlhU1VNmyX7Ry/hSZqKL+CMnw
         jC8jVly32lmzQpe3dhMrokfbymI16uQNV7d6kb1EHI4yCfEc4K7vxL9uRbn6c4Qy8OYQ
         SPd0/yChiVrd3Gn/d2WcHeZYQKN4TYfrFl0IS+4quLhnddgq2/mWkmWuujFmxyqh1mPg
         2h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069984; x=1752674784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpVhcnqQ4QopgzrrBAwITtPwYaxzjuUgzAB3u2opJd4=;
        b=pkYGveNcbu5vg2RFhsWdQrYLEqqsDtU1I3XFQefuEGDCdF3tDx9Ef1X6lgiZxMBKq+
         yBm7JsIzIManzuEKWL4Csf3Zvf6b2GIYXTHJwpDckzqq27GuBp+3Jdm3I8WhtQd67UL6
         Ema41WeFgp1fFlExVuEbXL2iDZna/2/y7tw+sk0M22fzkt/w7jX2mGn+utmE25xe1VLq
         B+YLR5jSCvvP1ZZI5398XCF6Tg3qws8U92Tly8MOWO6AhQDf2hsnfc/Z4P+Im4umvV/x
         yynQdY8yb/fMtm8gqDtAuI45x+BHK1FqNaFRQ1EBAPXfZX4AC6nD8F3TmxcAefjka7Y3
         yYqQ==
X-Gm-Message-State: AOJu0YzfpUDDh2NGNy0Sgqz6zsFXgf7UjzJma8kH7b1EbKQTflPg2zlv
	B9ye9UplEOSjxFkVABFbTNDnzM/hFsmGyNMcZ71KjgF6nmwjf8U+A6SAw4YBL+deAxOcrCn9x4Z
	APwItVA==
X-Google-Smtp-Source: AGHT+IGHAf/W0Pdlaq5GH+DDJpvg9O5Pkb7w1Gmd8Aste4OllMRWIMmZLxVBD8UYx6G+uWRoqyjy3+F9l2g=
X-Received: from pjbnk16.prod.google.com ([2002:a17:90b:1950:b0:31c:2fe4:33bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8c:b0:313:d6d9:8891
 with SMTP id 98e67ed59e1d1-31c2fccddadmr3702955a91.3.1752069983670; Wed, 09
 Jul 2025 07:06:23 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:06:22 -0700
In-Reply-To: <20250709033242.267892-9-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-9-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53XtIe_FPwi7Aa@google.com>
Subject: Re: [RFC PATCH v8 08/35] KVM: x86: Rename lapic get/set_reg64() helpers
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
> In preparation for moving kvm-internal __kvm_lapic_set_reg64(),
> __kvm_lapic_get_reg64() to apic.h for use in Secure AVIC APIC driver,
> rename them as part of the APIC API.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

