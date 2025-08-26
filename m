Return-Path: <linux-kernel+bounces-786374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1054B35902
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88B16F82E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FB3126D0;
	Tue, 26 Aug 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="USQXV8qF"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5330BF67
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200850; cv=none; b=ErxAkAYMnahlyPnVtzxISwQEZrE5+bqvHm0CEnqty4QFuDMgd/XZLKDX6E5xH1CHA684vu11Qmhsek+1Z7k3w9xgbgK54PiPi1q9b0oH67Sm4DRG8hnl/jU98o7buN5FacLCJCZtXMRSdyKxkQ/BmlpD5o70+VLvZDM0wRVzGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200850; c=relaxed/simple;
	bh=o+jb5g1N9AMYY67V/CA+UNo1y0YqSW+9qNLomu8Ob9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Lyu7bGtqpDlQ0UMlpmHz51zyrnjnXisHmoZuxP3zRafyDbVC12b4ZTuRmXVbq0A+TgG2R5pVUQKC5IX83R8MDV1pnRcTNQN1AnLsWNKaaVaeI6XIceO2/IkINn9UMJc8mEnhlXGy6blQXpRDKmcTja3rzK6i34Gj5KyCczUr8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=USQXV8qF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so41472865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756200847; x=1756805647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HW2HUDWRHT4i1n5wE3yCr0uWi9l5RmK2kTtTDTdtzZk=;
        b=USQXV8qFOiuOjoAhVKHlJO4RST1Mg0DK9BuGkFgNtHAK+JCDbOHl2/mxZcDqGtwWPk
         /p1EblM16OQG89cwGpPqeuJKtwAWuDS9PmGINzYo8wxoqYwZXf8opIgZE4uj9CoTT1Z4
         zoSRZ7iAulkt5Bc+3vsBthkZUss6yj4g8eXFnEdx0mTtQNycUL/59VPzWIWwZW1M2zII
         L0u3fd2GQBEAspnwiJD2koXac32MMTdTdmbrMNMJdZY4FfeJ6pqE1WN7w1ytFykU5DX3
         Y3BBUDgnSysWwSZqMCRzjOPdk8e8O+8BDJ2dSMUcOh8vgBHUu0XnBtCMAm1g4R3D+KF2
         Tc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200847; x=1756805647;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW2HUDWRHT4i1n5wE3yCr0uWi9l5RmK2kTtTDTdtzZk=;
        b=qJQI2gTKYOhCKtUQAo5ggDVqxwjy9Jx7axe+hq3NfGobdZwyMgKi6bGFsdpsS9I/Gk
         kBO9GsDedrwi7MMR8+25GB2ukcYGVOHkLIM6JM7UVyWoI/eP/tuKKskFSJjblIt58A0C
         dx6aTsIiRoBmnGyxW9PGJbN1w18EGJ63G7H0FjKT3vT96OHsWsxVi80XMNH1x9bPHQ68
         eEdqRG1J5IH6hshk9DStqvc8YKCcSZSenRjnI13UgHTrSIVtJWF1AOwRq8pVuh6uwj++
         QLcgR40lD0n60lSji+VZqgOHhUvCj1O0CF5071agauWdVxEs1XSnUs/Q/MFD4PbW2GfU
         XW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMoVwZngrI22vd5dkk89/BnFMtd0rSNo/pW7sNg7hM92C1MMDCsyzsi6qCe01UIP1oSb7Bu1vgE3GMmn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03k0wDc1IaLIio+/3xqxEbuVvs46z/XN83m4gG1ieJbEuCRF9
	w/KCke+pNwJKE4I4h4g9VooxBkcCa0QzBIuCB4LbaGRgSq2dM50m9MYRE3UjAcXyfcs=
X-Gm-Gg: ASbGnct855tuCcPx2rt5up/VACPhDLnRd3x3/TYYCI5rTV0HVBt+Dq8yB16+LPWxFCL
	agsaAntuQt+iCLhbJpTsAcLxpM5TfqSeSxnW8NbnEzFDyDG+AoMqAB3oL+dBEHzjjjrRvvmjhAS
	hrDYPUSfpSzwqGzkMhmvlmsTV3HrHn72KfRJisftz5INn6z2ZTNdJEBULdDpKdKQcggT94BATwQ
	Pi2+722utP/hyXZs7LEHACFbq4GY1kQKeB+1dp+1H9WjiztFUIK1JFkz92yxK4hc6iTOQj2citF
	2HBbr+15DqS56hzbPf6IxCmJEHgYVMO3gSWxay9l5EQMY+erFFyWW3QFgT427GEz5/H8GJUba5z
	7q99p+5/9smrhuAjjQaWxbhbmmOjDQqq+l0WPDDgwhrE=
X-Google-Smtp-Source: AGHT+IHbSrfiU+FOdt+Rd4z6vofZ+29eq0hImMmspUzv4cDgX3oovhP+aFGkM7q4vl/8i0/3uo6+QA==
X-Received: by 2002:a05:6000:240c:b0:3c9:9ec0:203b with SMTP id ffacd0b85a97d-3c99ec02f4bmr4771108f8f.27.1756200846753;
        Tue, 26 Aug 2025 02:34:06 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f7fe29b0sm1680228b3a.9.2025.08.26.02.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:34:06 -0700 (PDT)
Message-ID: <52288605-a16c-4a93-9e80-66d32de88847@suse.com>
Date: Tue, 26 Aug 2025 11:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] module: show why force load fails
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
 <20250825091545.18607-3-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250825091545.18607-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 11:15 AM, Jinchao Wang wrote:
> Include reason in error message when force loading is disabled.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..a426bd8a18b5 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>  	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>  	return 0;
>  #else
> +	pr_err("%s force load is not supported\n", reason);
>  	return -ENOEXEC;
>  #endif
>  }

The module name is already available at all points where
try_to_force_load() is called, so the new error message should include
it.

Additionally, we should be careful about the message. In the case of the
init_module syscall, the missing modversions and vermagic could mean
that the data was deliberately stripped by kmod because the module was
inserted with --force, or it could mean that the module lacks this data
in the first place. In other words, it is not always the case that that
we're reaching this logic because of a force load.

My suggestion would be to use the following:

pr_err("%s: %s, force load is not supported\n", mod->name, reason);

-- 
Thanks,
Petr

