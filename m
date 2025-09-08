Return-Path: <linux-kernel+bounces-806699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E1B49AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F8207D99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685312D7DC4;
	Mon,  8 Sep 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO+PjgDB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40C26E711
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362197; cv=none; b=DamHecM0GiSXQc1Z9gW77tgF0NSgpX+HsHgZd/+SUsNvuadbOvOB+5YUo9UxVd9ZG1CkhwiLVgFCxFfwkf9KXdJNI0rY4hdmwKn/yJA/8VkdLYWdNeW5GueQmoAe6m8H04UAcOutoseS+yhjVs2i3IHgrffd9cNhpxuTM9f27pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362197; c=relaxed/simple;
	bh=1YuuAoUsR01siboK02Tf/4cTnTTJSuWiVrPrARReGpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHQsTnFfip0TMFvwV91huo+WJzB3ErqfBHlNVhCrA6Nw9r2BAlMHT5ahyAcA/A/Nf0QDxvG3Sjklu9WR3yna13WHUGrmmQLxTKAKnxHD6YZHZxxyV/nz/ehbGj0iqtA6VOYH4WYWs+EHgInQD7P+BCWQmDRF8xiuodSndLRI2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sO+PjgDB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32bbacf6512so6683195a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757362196; x=1757966996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB3mttQlljbbkLy4J1oG902kb9s+z+iu7LLfGfGucrA=;
        b=sO+PjgDB8R4SjObbI/DAI6UkUUHvZgeQUQ0QH+hkZabbbT9yVF2lgXqRpEHZ9jCFze
         XPS6j3XdMvtvakqRC9aPZAThHDUvm6fBpwjOMXLUWaRDkMDbqvmSyHwc00F1J9xvToda
         w1vF6irJhSiztPIHTnfOHGQzmqTOEz8Zu6dp79ctHv8E7xgKvL9/4q1SuU3u+xPqGqrF
         M7L9h8FfTbgOw5HoeM+y8fbtu87RZDMepzH8hGZU62sl0JAU7KIqXxoCPLO92KIRxN3u
         ED6eMwWjgGkN1XFn4TmH8pN5mMiR1jz1zD+HG5ECpxHRex3+efuedO6eVJrS0S8emfb0
         LNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362196; x=1757966996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB3mttQlljbbkLy4J1oG902kb9s+z+iu7LLfGfGucrA=;
        b=M3DvumIYw0AIssruQcnon+ZVR1BPyQIutKlVmWwDFGl1Tn1eihr+KwkuszNiBUMSEI
         H1fTBYQeAZhfMOTOxVqGhzqWWqDQ3xuZY1JHBT4GxX0Etvv0cG5pbo6ZF30z6C1bSLVF
         K9sW26ZwUT4s8ivKm7cryHa2X4TzEFemT8DpSKODFONf+sGxbOuLRytP5Z47hgGpwfYg
         MAN+V1cADV7UcVf2CmoXtyxlx6nxspdOW25dl3YKAbt/QPVsdfs15RImMCo9fYGma/Eq
         L45U7BdulH499q93YszRcV3372fu1nCg+7mBmbbzwddsIKo64BkNz4jQ5hctWpRrlUvq
         NJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCX/2WtE0w0wXvSVmSXBna3RIT/caHlAS8+qjH/cLXkO9nbPwtJe25cevouZob3z9SEYeGwR+bjjS6Fn1vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDo+6xsJC5yPCdlwhPyvxtcdf7geFeAFnHsRGuvObnHw7TTx3H
	UtKF8RpPwpFCaOyQVRTCq6imhgtBVIByWjpQAJvxGVuv4cKZJuprbrZjQ8uRYz6E4XSRLlK7GOn
	VDCS2kA==
X-Google-Smtp-Source: AGHT+IFXWsl1Ykqzi9UP6IBXwVSCJf8ddgaZaFEEnXIqKb005Q2xiohYRyg/M74Z97YN+iSqXZxGERzLKgw=
X-Received: from pjbqb11.prod.google.com ([2002:a17:90b:280b:b0:321:c441:a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f83:b0:32b:a4a2:27cf
 with SMTP id 98e67ed59e1d1-32d43fadc90mr11914265a91.31.1757362195854; Mon, 08
 Sep 2025 13:09:55 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:09:54 -0700
In-Reply-To: <28d5fb22-5b0c-4bf9-85c7-1986d9cc005b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828005249.39339-1-seanjc@google.com> <28d5fb22-5b0c-4bf9-85c7-1986d9cc005b@linux.intel.com>
Message-ID: <aL84ElCqFIRF05JM@google.com>
Subject: Re: [PATCH v2] x86/kvm: Force legacy PCI hole to UC when overriding
 MTRRs for TDX/SNP
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=" <jgross@suse.com>, Korakit Seemakhupt <korakit@google.com>, Jianxiong Gao <jxgao@google.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 28, 2025, Binbin Wu wrote:
> > Note #2, relying on guest firmware to handle this scenario, e.g. by setting
> > virtual MTRRs and then consuming them in Linux, is not a viable option, as
> > the virtual MTRR state is managed by the untrusted hypervisor, and because
> > OVMF at least has stopped programming virtual MTRRs when running as a TDX
> > guest.
> 
> Not sure if it needs to mention that with this option, Linux kernel will set
> CR0.CD=1 when programming MTRRs, which will trigger unexpected #VE in TDX guest.

I don't think it's worth bringing up, because that is a very solvable problem,
and orthogonal to the issues with using the untrusted hypervisor to store/track
the virtual MTRR values.

