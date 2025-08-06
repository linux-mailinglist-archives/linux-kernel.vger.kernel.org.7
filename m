Return-Path: <linux-kernel+bounces-757405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B02B1C1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EBC18C0A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE821CC79;
	Wed,  6 Aug 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/akv0+p"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89721CC64;
	Wed,  6 Aug 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467396; cv=none; b=NEFzHFUWSQxoIn+IM1D9Y/vY4iz6CfP3Pz737SfX8KsZKV3Tp5D+6YuFg/wle/Jpxd3Hv41pMyCzPoBs4WOME1nj0yzp1gFE7wW2LLsZSIcU7dJDLuMCeIT9/3Ha4kPxCs0+4Vh1B3ZxWkHEc8JxwtcgfwMx/mUiPByLj2vBs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467396; c=relaxed/simple;
	bh=mxwhW/LgIW3LqcR+Fr+P20a30aa6bLS3i9JEuWlpNNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPYmkGlE82thHkEV937vn0SaLof91qy+qsIW1iDvqnSuiCkTY3GCDFsGMX3IiXPnI5LLy9euBO7hCH2w82Kb22tenfQNMKyS+O/v6mrnTAePFPqEtFRECJGznVgxdfVBPtiIRD7A1UAnR6pzG6/SVeD4hO5tC6C/o5GJgVvUSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/akv0+p; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b422863dda0so3624252a12.3;
        Wed, 06 Aug 2025 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754467394; x=1755072194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxwhW/LgIW3LqcR+Fr+P20a30aa6bLS3i9JEuWlpNNM=;
        b=j/akv0+pa92nd0v1I538AeM7/N+7t5hPM5kHPnI+on2TN4uOQ1JuV40+SsQYbbpdPJ
         10OiTslXmBEuwhDCEU2tgy/7eKimsRmqfraQjQ4/d5EFm+5l4RkgtyY4jQqd+SvskwR2
         cdGRjWnM66MHHZPGFfwyk5btWqKmDZX1DexIQcc7b4NwZhcAxFHuR/EE9NzhF31sxNxg
         d03f4zmkfRyRzojTsHxSvHM4aeQgLhW0d3dDcqp3iGPLU2Dc64XJT8oXxTnNWsGaux8I
         6YVoD6RHXCaURl6P1d2bbfn/ZHPHUKhKpQL8TawjgfMLWrwQjA6eiCtvBM8397oVN4hX
         WJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467394; x=1755072194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxwhW/LgIW3LqcR+Fr+P20a30aa6bLS3i9JEuWlpNNM=;
        b=khIz4tvQFkxDQVI0rQ24bVkyntE6hkgv1ceinOjm8kElXvl5rugWUxAN/GFowaF0XE
         qF606OszNVQDryZzA1PnXwEUNKr8IIyDQKZHkm7HMdEIw1BIZhS3KCSy3dR2oi0P/DUC
         Q480uvjAQ4ArrTCsVJqxTUfV4RzSbfiL23MzwWBU8EX+agqWf9JBMqFU5VtOPp/nS2j3
         2Srvy+3x/tEci+mLfgpAQnzGYGcZ9HMzw3VO/i3jiCGve3rL1OZ5/RzPWAApyQzHCsNf
         Cpa1rYtkq4o/UuqksU12LBaVf7opC0pp+k4ejcNfiRfg+LLIOup/U7VPTtLriEIaKaRN
         B3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO9mJKtF+BmuXhSAGdLM4zcxcWi1fJp4GRHDCd7lnNrkkxBTi+uxYyEy0g0Pn4mvB4Y6ZoHiIAO9qhxlE=@vger.kernel.org, AJvYcCWT0yaJgxSEdy9A0s7Rq8Cdl9Oq4tXA0W5VQxUBFUVrRc5peJ/wCZmQr2zB0a+fxWECJ6FloM7k7GUJCv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wDouXPBC3mJgwoViAFKj2nTj6ambvi/JvTMp8iKKsYM9EST2
	RXippRjsXfO6jLwG9WgMZEMgmtJsJEtY9+CGCCMwJX2k36EuidgmjKKSPJPAiikYfDyX54kk2SA
	bFll9s3wf3Zwll3lqdo+d8zFKGqE+RtI=
X-Gm-Gg: ASbGncvxqiJhheavpLezjm39zp0KtHWZRoY1PYdHbI2hmLrENIml7ifT0JS9q1J6OjL
	jUm+D/CS6oYJM000qeB/OHXYxHVewufCI6MpLDg9H7PosqLIsd9L8TJzg6Q0XJcuShVU8vgHr84
	bGlK5+GGw0RAzi2oXZt9nPeo8DQD/topWFDTP1l+YMmkWtXe8cueAEG2jBXILj1kt2T0vwhIAgO
	9Ch
X-Google-Smtp-Source: AGHT+IGN/epxF1k5Rei1FpC/BRWg+FClZI6Re5L8Wi9/3SOxZcU722vABqtiu3JL1q5hOj1GSrOTay1RynD3blfSsQ0=
X-Received: by 2002:a17:902:ccc3:b0:23f:f983:5ca1 with SMTP id
 d9443c01a7336-242a0ae476bmr22183395ad.12.1754467393754; Wed, 06 Aug 2025
 01:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pndpldam7tf.a.out@axis.com>
In-Reply-To: <pndpldam7tf.a.out@axis.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 6 Aug 2025 11:05:18 +0300
X-Gm-Features: Ac12FXxwVAvTH8GuNuBL-sO0VmVAVyE57Kp1iye_BVOcxHVgrYKsjiw7CFUOjY0
Message-ID: <CAEnQRZBpG2gVGG3Tp6yLcueNFw7R+KKLhjOmwRa9j8rw4QRuvg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: SOF: imx: Remove error print for devm_add_action_or_reset()
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, kernel@axis.com, sound-open-firmware@alsa-project.org, 
	linux-sound@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 12:33=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.com=
> wrote:
>
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
>
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

