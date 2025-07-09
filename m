Return-Path: <linux-kernel+bounces-723843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904CAFEB91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150A05C30EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D52E8894;
	Wed,  9 Jul 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3OokrYm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A92E7F21
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070016; cv=none; b=c/F3zV0dUomXl7/VPhG/k4VCcNR0U7q+omQWaJCFnd0yBSuagi+RoerwR5HpaaGaubhdHjyHvIi7pBIKCJRBVD4BG2QTRhRuMdBFQyVbkYj1IG7KFaVqEtRQhiEobbA5Dl9td3ld0KXm9DypyO/RTCdSMcTWnLn1WSJNaHvXUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070016; c=relaxed/simple;
	bh=hkntFlFAHX/8LClrortGJsunMQhI9Rf+tcTEWjk0YoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGLYoGNASKWkdR/GEwhFrcrwrp9SfWFyf13Ie19mBv21YMoTs4iqzK46UAInKkM+GScij7AGyh96j1lTYYjMYswOGrYZL2LxKuL+IXBSW46xzjmHx3yl1nRbS3bjhL5L+uDP3CWaQ+pBkh9WF2At958Veb/Og/Mag5pto/+AIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3OokrYm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso1005037a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752070014; x=1752674814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8fWPt2BfkTPkJ9RpJOZFh1liGwFojbw+uk1VvqODzg=;
        b=J3OokrYmX6HWOzk9nRg/w+JEis1zh89IA6vQ0vjsG3C1JXQBLB8+V5vqVFp//q03DB
         6CFlmbWqfvVgiz7fwoFDkssgbM5LvzaFsLOdmlzKO1RQnQiSHrJJMNb6QgW5xauC7E0G
         KRGEWX2smoIWPYM0uxPYKsNY6gjEYjrpUeCAczZzGK9D8zYbram4J9Luzj0CZQbK1M0h
         ijAX7u4cON4dhGX4YQ/pW4BT9YplgHSnAdb74vrXgxIXdKCQyOmKY6Y0fXdabp6V8CBa
         UBcOICRQV0rDtgfm+PSNNCcJzhuo4y7FaFtz0oDW0U3GlJ4Hbp2+yrv1bq9eTplen0t1
         EifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070014; x=1752674814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8fWPt2BfkTPkJ9RpJOZFh1liGwFojbw+uk1VvqODzg=;
        b=PT9c3Ir3YSF7uNV8cKS9BX3nico8CKwaoiC10a+/dc0F1Ersu2Ep4BVBjHF1yyFy6C
         7IwIu49vw9v2mZ4WPA2ZsEDrR9TU/NT5ZFqliEa+Tiidsnjc3e2ZRbRHVC4OTsbdxq6s
         Xh8faoFiI6fbQl4x0Nz0+BKDlYY7KjE/WOzFjZimefyaSKqV5zDZCHbyVwjIcpSKjaNe
         JrVRKozRTRoFfInaA65RA5uX+5tvAeUAt/ggMMeBjXaP+SVYtgaecibmqM29TKFmkvXz
         nxTyeN0TNmhl3KBiuAfJjFY/NRuyaZ8tg8Zz2MZ4/Lo7AAKB76R+Xz0/LeQBr/jaTDlB
         E8lA==
X-Gm-Message-State: AOJu0Yzq3p3JDCEp/nBYfHsnfWC7bNgJHGkuXvKvQ3GK/qPofbzRkW95
	gUXef8Flh5Kf8SHYp/xFpH2vl9C9JQgearoF4WxhZ2LtUXWFjbySk1dTKVLy6vPGhMusL4Nkh+t
	sd/Y16g==
X-Google-Smtp-Source: AGHT+IGIWsx7d/E56vX8/ELK8FvDCsCc7kZDsZlRa7N3LnxbBm/kaiz6qFgCJN+q7ZZTN94p0dGqXi8ZWKw=
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec85:b0:302:fc48:4f0a
 with SMTP id 98e67ed59e1d1-31c3050462dmr4342914a91.0.1752070013937; Wed, 09
 Jul 2025 07:06:53 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:06:52 -0700
In-Reply-To: <20250709033242.267892-12-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-12-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53fJ9VlLxurnKW@google.com>
Subject: Re: [RFC PATCH v8 11/35] x86/apic: KVM: Move lapic get/set helpers to
 common code
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
> Move the apic_get_reg(), apic_set_reg(), apic_get_reg64() and
> apic_set_reg64() helper functions to apic.h in order to reuse them in the
> Secure AVIC guest APIC driver in later patches to read/write registers
> from/to the APIC backing page.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

