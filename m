Return-Path: <linux-kernel+bounces-856832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F4BE5333
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6985A356230
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156328A3FA;
	Thu, 16 Oct 2025 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s4Ocho4l"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F723C4F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641957; cv=none; b=ALihK0YAPNlnXckFhv7SzwjO2dB0VVsIxwVtZirTc08uCa2cujHQGo2nMEpLscErQBzIQlKW0KGpIE60qa/R7s7V/zdfQu8iFvzfUrthJdT53XSGc0fSXTEAUz2w8xPcnDMIfKXbQgmBaEsUwZeRaaSB67sz+BpjNhskmaUvue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641957; c=relaxed/simple;
	bh=oOozblnTVlgXmAtgaZk3kUik4BWU7TMOnrv67VelEsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaqDZbqJvnIlCG2gr7EAR+rx986hUlfq24hc2t8R1yO6+QnlMtnDOh7oQQ7Tb50VuyinEfe0zuFpU8L+jbmZRN66SnQ3IQ270OQCaGnHTRKIu9x8fuumnhFoPaR7rLJygAkU56zQSTAV5G1JRjmqgaaX+yOA4jEA1FWaIGwD9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s4Ocho4l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so16727236d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760641954; x=1761246754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQNxV14oMdvtVXEEmpkzU7J9wlei8oikZdqc5XqRtHU=;
        b=s4Ocho4lBQJ3ccU3ePOJ3DkqF5Y869sKyUxTLa3IGqemm0DyoVxi2RLUEC5Z0tJ27u
         bazBmQQ+ihQ8wROPwwad+vINHmWB0HjPfweLc+B97Zx/Fmxxu9It/G4ES9aXqlo+ZYG4
         RSAhtO0BhB0svKSpOfVOLqIanK3qXqL59eubsti2Dm03I4qDajOOqIh7zLf0qMAJE4fg
         kT+LbwuoisYsS1gL3shXAicsE/pLSGcGX7WlYr0YGazB5k4sdxWWD1IZlLXc6Hauue0z
         6kjEkX4yIUPclJcIjng65dNbdH/Aw1ZyW7mfRY8AOOURVBxLTfY1JEjSnKN4DmLZQHaN
         a+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641954; x=1761246754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQNxV14oMdvtVXEEmpkzU7J9wlei8oikZdqc5XqRtHU=;
        b=pf78Zbk/4X7Thz33nkJPP5FsQZRbkiNTXWw5nei5qNsyQH3rzzEEDcHTwKrRlRsAju
         RWOqvJDCrCS0n32Byq3U0+OmcYAniQsaK9HbpiRTRLY6ohe+snsUsGQygaY1NL/dbu5q
         M0DMxca1KQ218M7RJ74WpSu6DfSMruF5DF1uTEC1AZtFFwjUN58K5AmLsbw41lXrQtJ6
         tocfTDDoCsc1bJZcJ6lA4ygZO57+kGPLEzak91B5S74tLEMF40IBi555HRn86wjTyJuk
         PSW9LZnu+Ds7em2lTMc/5cjKqmJEMx9XU5DmWfH4K9jQZ+fJBgdSHbkPWEi06yWsqwg2
         s69g==
X-Gm-Message-State: AOJu0YxYNSw/LABxiSu9pV0L1vFTKoihsw4+QW182sJqCnVNwaasCez4
	Pf6FoPGmblXIA+Esgvdi5ffOWs9GPiwGXiSGOH8805OTAjUesbZyVVMbXePkPbgsERI=
X-Gm-Gg: ASbGncvlefCE8z8LMPYc3Tu7iXMTtdlXk3A6RrgfLA/MYD8NlLsjB2R8N982wd3fVAN
	0QihOgukjCxjTszXZxeN1z4gFc6qikOvmSQQJVFL3UYUlDgLI4/k+uA8ff3+/jlDN99R6MHp0ZI
	Avb4sF0QMnAAqL6OTv9IPb20ZBpVCqxGovnJ0F3IVWzhllLZc/KjgALcj7IiDR3uDGyp8bfELAy
	WMvXMHGRpHXsfeGQD9OshvWZDNU2BLBQUD++BbBSJ+5aZD5xEakVMrpRgOcYdJ6uaedWdFRWIon
	KqmCMqWYywzEfZXKvhkclosDUvFTWJTTUSlG9/EdQtbqeW7CcEhAkr4ogWdVdmjyt8YFEv9cIx0
	yVdQwME7E6ipJpj0X0geyi2JiL+9oj8qX/ltJCtFQ0ky0ck0P0JEAEs41Q2cBKAC2wa9H2cnnEm
	2p1NNkm5J29HxCIjOd8MxD5Va+rQ//1gcqgXGNVktfcJgTA75dTRcno5tBMVwCxctOpk2FpA==
X-Google-Smtp-Source: AGHT+IEsD2ILKIHNJPld9BRX5aE5fP1A9+zkS21n9Wd/GD33/P/fMWpS1ih3YMfeLtpbkSftfD5r0g==
X-Received: by 2002:a05:6214:1cc8:b0:820:a83:eaff with SMTP id 6a1803df08f44-87c2064999fmr15479326d6.64.1760641954260;
        Thu, 16 Oct 2025 12:12:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c22122a54sm3163526d6.16.2025.10.16.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 12:12:33 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:12:31 -0400
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	peterz@infradead.org, mario.limonciello@amd.com, riel@surriel.com,
	yazen.ghannam@amd.com, me@mixaill.net, kai.huang@intel.com,
	sandipan.das@amd.com, darwi@linutronix.de, stable@kernel.org
Subject: Re: [PATCH] x86/amd: Disable RDSEED on AMD Zen5 Turin because of an
 error.
Message-ID: <aPFDn-4Cm6n0_3_e@gourry-fedora-PF4VCD3F>
References: <20251016182107.3496116-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016182107.3496116-1-gourry@gourry.net>

On Thu, Oct 16, 2025 at 02:21:07PM -0400, Gregory Price wrote:
> Under unknown architectural conditions, Zen5 chips running rdseed
> can produce (val=0,CF=1) as a "random" result over 10% of the time
> (when rdseed is successful).  CF=1 indicates success, while val=0
> is typically only produced when rdseed fails (CF=0).
> 
> This suggests there is an architectural issue which causes rdseed
> to misclassify a failure as a success under unknown conditions.
> 
> This was reproduced reliably by launching 2-threads per available
> core, 1-thread per for hamming on RDSEED, and 1-thread per core
> collectively eating and hammering on ~90% of memory.
> 
> Fix was modeled after a different RDSEED issue in Zen2 Cyan Skillfish.
> 
> Link: https://lore.kernel.org/all/20250715130819.461718765@linuxfoundation.org/
> Cc: <stable@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  arch/x86/kernel/cpu/amd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 5398db4dedb4..9c3b2f010f8c 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1037,6 +1037,12 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
>  
>  static void init_amd_zen5(struct cpuinfo_x86 *c)
>  {
> +	/* Disable RDSEED on AMD Turin because of an error. */
> +	if (c->x86_model == 0x11 && c->x86_stepping == 0x0) {

After re-examining the results, this was also observed on

  c->x86_model == 0x2

Maybe this should just be disabled for all of Zen5?
I will wait for comment.

In a stress test (link) I found that my Zen5 chips have a bizarrely
low rdseed success rate anyway - so it doesn't even seem useful.

./rdseed_stress_single_core
RDRAND: 100.00%, RDSEED: 3.48%

./rdseed_stress_multi_thread
RDRAND: 99.99%, RDSEED: 0.33%

Link: https://lore.kernel.org/all/Zbjw5hRHr_E6k18r@zx2c4.com/

---

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9c3b2f010f8c..54f07514674a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1038,7 +1038,8 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
        /* Disable RDSEED on AMD Turin because of an error. */
-       if (c->x86_model == 0x11 && c->x86_stepping == 0x0) {
+       if ((c->x86_model == 0x11 || c->x86_model == 0x2) &&
+           (c->x86_stepping == 0x0)) {
                clear_cpu_cap(c, X86_FEATURE_RDSEED);
                msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
                pr_emerg("RDSEED is not reliable on this platform; disabling.\n");

