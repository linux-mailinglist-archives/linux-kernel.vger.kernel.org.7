Return-Path: <linux-kernel+bounces-856216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC98BE382A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A906B584465
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4791334386;
	Thu, 16 Oct 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1DxaPLZ"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41C262FE9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619249; cv=none; b=HYpYVEQG9v3+8dEtWJilLWsdh5Wu+8+CKhjCwRSOMnX6WuIw1tUPKUw9FbATHG7QjmGCXDudummesKTQk5RmIGehAFda167Q+VtUv/mARffU1lRKHBRUOLm7l1jncKfVJlK3ADVrx9xYSpxyIGvF3wO3E4KZPn/RoJh+hIq6Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619249; c=relaxed/simple;
	bh=02xWtP8jgtv+56tf5rCWPxlK4KrnJ/X65QlZU3iE1KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r61mnqSEp5HJtSbuXvzGOj3BzGYSWsPAn07D4bY3J7oyZUdyguZ4W9LSk0fhJUtaCftt8LkrT2ejRs9w+iXlaRtcXe1HDsiVE6v7VCu1Dkj3igFU6r1cOVblCsX3odDv05VgDOinJWJg7PEjfbjgparYhQQieIiaSdaCFPVbLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1DxaPLZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so623751f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760619245; x=1761224045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QydqXtcKOrJO6HFcjmy3pq4ZYiBmoe/JsOUdaXl6rgo=;
        b=f1DxaPLZQIhURK2ZQJeMxqud/fdr+4STmi3bwIvian90l4WHGlEpOagcPh9QMHoHhu
         aB7zKj3LxXgz+ZUKp2ZeExO8AMuRVVckGsFzR4d3RSLYzyBWSx4dke0HM2POdFEbdKgj
         sctyKxsv+41JQtSJrfYEaBKXpYHOj2YfC59WNQhTwekfsXCcLm8CA5eoNssJrXATzePc
         33WqakfLu9S58RMFVGpKPYecVKlGGmj4jWg353UlDfLElCOtHjaNAedlsSgz246/9dkx
         dPDqG6Q5uK0Gr35C8cziJHSE+iY4czYGryNE84l4m/s2orIEHIJkFEDUTDG+ihEBiSyz
         Ce1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619245; x=1761224045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QydqXtcKOrJO6HFcjmy3pq4ZYiBmoe/JsOUdaXl6rgo=;
        b=XOf8lkrJlqZ8otPcoLAEHBFE5BmXr8KCa6xEl8dyACUi2xNH3vSfNJO8Q2ch1QgGkm
         TFviEa6KjRMZQ0nlrIZwalh1vTt61sDZdJKJM3oHAV11MLAhPsDrGyX9O7sxCh4n7L6A
         rCG1zBi88uWcth/Ri9O5PbuhuxYbmLfb8XongQuhAc37G4bg1S6k6tITPamAzLM33hhg
         RdC7dosR/ulBvA3HfBHkScfioLHBW2vVpyJig9/G8mGZq3GzfVdCEaNzCkkvLsb6hKDw
         nyMHT+4gc8Act7/5G+tXs9PbaCYEQP3eBr3W0XRstqcbexDwWZaNkpXLUS5/+RJzyzLq
         VqQw==
X-Forwarded-Encrypted: i=1; AJvYcCXrP2MHrxWCC0WkK7f9nW6HgI2ElkvBygSp6qKSvtSN0VY0Mz48sPdoBOAI4362/hBW2zIbdTWty2bSrMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti4jWkSH1qpp0F+HPxTWHPRUdX9UYLJ5i/Ccqs4eKYZU9FA4Z
	He45zRATps2Vvxl9gPTDYu2+C2plCpBiS2RhQMhR0gzKohFcmEbbj0bEkDMaAhinNWj6qr7VkX/
	mmGuyaaq81YWaUA==
X-Google-Smtp-Source: AGHT+IGy4FY3Mof3DNeUIeQNoz0mW/pNbCcDRnOKerX5YwlmVMZ+FGjr6nv56Lt4OnKiRfLxkk5nIL9tXvQztQ==
X-Received: from wrnv18.prod.google.com ([2002:adf:ebd2:0:b0:425:6e00:e053])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c0a:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-42704d8357dmr32f8f.5.1760619244702;
 Thu, 16 Oct 2025 05:54:04 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:54:03 +0000
In-Reply-To: <20251013143444.3999-8-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-8-david.kaplan@amd.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com>
Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
From: Brendan Jackman <jackmanb@google.com>
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Oct 13, 2025 at 2:33 PM UTC, David Kaplan wrote:
> Add function to reset spectre_v2_user mitigations back to their boot-time
> defaults.
>
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 1f56ccb5f641..4ca46f58e384 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2056,6 +2056,18 @@ static void __init spectre_v2_user_apply_mitigation(void)
>  	}
>  }
>  
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void spectre_v2_user_reset_mitigation(void)
> +{
> +	static_branch_disable(&switch_vcpu_ibpb);
> +	static_branch_disable(&switch_mm_always_ibpb);
> +	static_branch_disable(&switch_mm_cond_ibpb);
> +	spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
> +	spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
> +	spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_AUTO;
> +}
> +#endif
> +
>  static const char * const spectre_v2_strings[] = {
>  	[SPECTRE_V2_NONE]			= "Vulnerable",
>  	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
> @@ -3844,5 +3856,6 @@ void arch_cpu_reset_mitigations(void)
>  	spectre_v1_reset_mitigation();
>  	spectre_v2_reset_mitigation();
>  	retbleed_reset_mitigation();
> +	spectre_v2_user_reset_mitigation();
>  }
>  #endif

I think this might be failing to account for task state? E.g. if a
user boots with spectre_v2=off then we ignore the PR_SPEC_DISABLE calls
that would enable IBPB-on-context-switch for that task. Then if they
enable it via this dynamic interface they probably expect their
PR_SPEC_DISABLE to take effect retroactively. I don't think it will with
the current code, do I have that right?

