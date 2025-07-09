Return-Path: <linux-kernel+bounces-723830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D729EAFEB79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4135B56450C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3E2E92B8;
	Wed,  9 Jul 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USGXwLDN"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E32E8DF2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069830; cv=none; b=auGm5NwnyIzZ+76abP3+Hv4QFbcGhqvNLZ2lywL4t0KR31OZ4u/oOvT3267lQS4qjfSUzF6u6Oq55BqERehQGZyygupx+rEBvRB2FPx5UGAMAcjf8wvyB6iKyVh8ed6MmUbf1iiW0I+Xe/HPe/ywKJGehZnoXtjQ6Y70iv5YUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069830; c=relaxed/simple;
	bh=B4BEBVfO43SbmgceatslkYpp7eXsXn0FMJ6j+FiP5kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YYSzXvXR7e+MLoNlUdpXzQaVI70OT1G8S1FpdilQIJikMu/x3/tSMSWxMaIKJ6nl+Mv/GVllSiUtWqNu+/Q2DRUNV4RsjUBKS1pXmy2sx/aTNxXvS645KL76F5v6ZnsCNmjBP7b9KaexD+GHNPmNrCcnUN9+H8sIA8uVu72vJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USGXwLDN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fb347b3e6so6476643a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069828; x=1752674628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hykxadXvTSxtN5RusGv413qm2dHa+a46+Kml5di85rU=;
        b=USGXwLDNlnWRprMHIWtF8fdYb1MLxe55+OrBRWiWP33kXKLqiiDNf6vgx2OwsBm/RV
         iP3nSrXnDzAsmmf+IGaln4HkllajWlRcoXi8oRImTrhiNHjCMCsKPTEhm0fsMNvGOAku
         9Kr5iYV5JLKviA2PmJoceUbvDSW71TL+gi9s8LlKYbZ3jbN0gxpr9Jo5YrEqVPFZcH5u
         aUUhOTRUJB5sayCQD0S1QvCuWrI8xsZLR0nGfBsS/B3HB4ZkcFgK/vzxAmPl3I3RAoH7
         yoqmYGRQaPG7atXtkZB+xoPC1avNzzIQVjnfgyBbT6XQbFqmBPqZi4bQO7G4oZRh1u7l
         JLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069828; x=1752674628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hykxadXvTSxtN5RusGv413qm2dHa+a46+Kml5di85rU=;
        b=aqkw4gTa79A2o7sRRfa3aCCD1yXOQMSk1Dd8gZoKaK/yYgjpvQ5urag21Q86G3cOse
         jSy3GDW6PZ5m1Y+dC2MnPsgAhI2gSthTTo/xWsle5RJ7qBivzyxIGiKrb5LXU7lKdHtR
         gFgT1xG+UcYu4XZiFnr82l483egqmv23dBPtCNnvfDr2BunfITBBGcDUG2AVhqV5Onxs
         D1xtngpm1CzC9sy8ncDmPCcl9KiURxM3XZorayz+2qnSD5xrWxv+J52btI/nItPbiBlW
         PdiktqVKtiyYNvG/SgUZYa/BkaGDGfFnmEtgPS3td6FQdMwVVaqqJd1Xp1lrW1bzZ8Id
         cAUg==
X-Gm-Message-State: AOJu0YwxcOjnKF0eOUl+H4VaviGunFytl50XoO3aCzmzs1/SgoPYcW7p
	w6FvtMpoxZdrhAm2DeSqvR1SCkz0ZH0Zsu9G0OfLNtLRW58+UIgEES+BQ/AzEk1/hz8hQNdHyt1
	j+HX3bQ==
X-Google-Smtp-Source: AGHT+IENVhgeJ8BB/CtSoknldCEQ//74b5hlP1X6+EAiK7+g1oePobK3Aftm1IJA21KDRMk2vShoory4ir0=
X-Received: from pjbrs11.prod.google.com ([2002:a17:90b:2b8b:b0:301:1bf5:2f07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e98b:b0:312:1ae9:152b
 with SMTP id 98e67ed59e1d1-31c2fdd0249mr2655621a91.23.1752069828232; Wed, 09
 Jul 2025 07:03:48 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:03:46 -0700
In-Reply-To: <20250709033242.267892-2-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-2-Neeraj.Upadhyay@amd.com>
Message-ID: <aG52wupjDpEMChr7@google.com>
Subject: Re: [RFC PATCH v8 01/35] KVM: x86: Open code setting/clearing of bits
 in the ISR
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
> Remove __apic_test_and_set_vector() and __apic_test_and_clear_vector(),
> because the _only_ register that's safe to modify with a non-atomic
> operation is ISR, because KVM isn't running the vCPU, i.e. hardware can't
> service an IRQ or process an EOI for the relevant (virtual) APIC.
> 
> No functional change intended.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

