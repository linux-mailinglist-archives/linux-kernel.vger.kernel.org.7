Return-Path: <linux-kernel+bounces-778360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD8B2E49B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F275E256F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E3279794;
	Wed, 20 Aug 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7UFMh+u"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A91274671
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713055; cv=none; b=TA5STqe9TuQLWy6tXLexNE7KBOBWWNcgNAuyc3bSjwuN18uQl2CFOSIYDJqFBC3aZzWHZfaCpt4SmUE5xPsyhu4WcppwkWk66syHbt0hP2a8HC9s9/UcJOyEkuRjjgs2/oABpNTFJsKrmk6XwLpXuli3aOeinubSMkZV0orGbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713055; c=relaxed/simple;
	bh=OpFpKI+KtlmIT9oYEBNy9nRTNf0yv3CRnBX+62DRQw4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jaQF8iux/Y+R2k7TSg5gxqSOCWCLcN0KEEn4UfJCqvOkz7Zq8L68X//lScIpOMMr7T6fbG3y3FPKoLkT01EN+fG+S7X3hWV4Lidg9M/7evJtyfwFGPzXnt/LogzPIMLLgq5xwG7cw5Ltt4VyDH23DvKgo+x0+I5ViSQN/jxdb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7UFMh+u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so857025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755713052; x=1756317852; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/AR5JOfPXOoSWz1scRPUv02h/vmF6EJ2WDbLA90+dU=;
        b=P7UFMh+u3+qZUMXsFVqBRmxNwYYrVqeWrFiQJ2fi71wFQ4hUPQG6h3dWef+ZtvnlGn
         Fy/PDrX8UD1rL+zOnrs50zBsoLaAZujAHTOQj7Y6LvjkFUb4JnRU0bfaz/vXAY/djs48
         HskhBZ2RwEmwUgEIiLprvRB7qfOYg740cTPU29VA6Qx4Po+FvDPA+6zbgVOCnXIgn1KR
         4N4uMvlQpTVJrHRNd5rplXy2D3HpgXzYzTryVoeYMYoL3PVC179l/oFvBxICzHRROdbc
         j3+mkoD7mcwEgDebtiUv1vl4rAHMA6Uao3xOAmmh19euqj8kq7YIQnxvFd0EI/umd7gr
         8Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713052; x=1756317852;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X/AR5JOfPXOoSWz1scRPUv02h/vmF6EJ2WDbLA90+dU=;
        b=vs49BaSKVD3gy6cWPRz2lbGPqPWJktjOaLGMsraGNkEMyUCNU04qdwuN8y6qrat4RC
         L/BZzm3ZrKJfxBln69XTA1lhDO3RBw4SEgbusEuH1QV/tyHDMrTG0tsv0yMwUkwZ6Ymj
         1PfgjwDAZcp7aNLdxicyQuMVJTlVg5dnhjs+mxrEoBLMXDN3Su1MBa+ahoXcUdBlplYi
         uXizIs3UofldnooXjMtSt+nTnDbBsA/n0mIgEJsLhuntWhJDo0JSt1LxlNicZMh9qCLF
         cQv9MmTnuSFr+0JyelIoQzgxtAiD3wJqFXzNtdO2+AlY99XtY/lKI5SbEVVcYS4TGD3g
         I0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm8IBpD0uibmUDfR9gfTSLK1vuwMLBTzefhcktaqZT9C7+XmwR81hRiftN846HVuHHe8jzwg7GA3JSAe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MN3cGdxbXXM+5T+4+ZEPy1avy8oGeYgWbyD6Wrp7EYfD1Gzd
	kT1tBrsE9KHTi/mLf0X9ngRd7eT2LFXvMUkp9D4ZkcWODJLsI+ieI1WOx5nA/LhwOPU=
X-Gm-Gg: ASbGnctJkSS5hpAgF1TNaV3S6KLfHOFRW5IrmJGRdGY0f1g0bp2sSxfka+/cmajJyKL
	N9t+HWKRY9E0hKWWGlGADPfB7oO2d/iIPe23dNn/xNWxOpi6ZvVbOGA0eMWmgntjmPd9KkqSv9l
	PBctP5sXRRhwH6fodPqeivhqExGcu62342xBiJBpIm9uldaZh3YEPOl2laRWLm8EXqJE7GaAohD
	MKDE8NoCL7W4khiu36IcT/NNHq/rmmg4kZPn/l8IkqTN/Ft5mpcxNpDXockBmD55ZKonXWyBDYS
	rQwvkPTKP1yVtrgzACnolxVw7hgSrZC1Q7t84eQRqTDmrjZGePLqjWbxF+tni9yi7exvLZkRg/t
	0918gi2TQTVDrCtc07dY4rAkuEos=
X-Google-Smtp-Source: AGHT+IF4HffwmvTz6VUbz/+5M+jcK4ZI8rIXlBiu5vgtpE5f8sju5xfz46Xbc5v3IHdDPzI90a1fDA==
X-Received: by 2002:a05:600c:4447:b0:459:db80:c29f with SMTP id 5b1f17b1804b1-45b479ad42amr23982595e9.1.1755713052212;
        Wed, 20 Aug 2025 11:04:12 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:3a9b:1de2:5440:9326])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789d1dsm8464172f8f.49.2025.08.20.11.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 11:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 19:04:10 +0100
Message-Id: <DC7GC0UEKZDM.2C8KIM6TFLMHK@linaro.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Patrick Lai" <plai@qti.qualcomm.com>,
 "Annemarie Porter" <annemari@quicinc.com>, <linux-sound@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>, <kernel@oss.qualcomm.com>,
 "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>, "Pierre-Louis Bossart"
 <pierre-louis.bossart@linux.dev>
Subject: Re: [PATCH RFC 2/2] ASoC: qcom: qdsp6/audioreach: add support for
 offloading raw opus playback
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>, "Srinivas
 Kandagatla" <srini@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250616-opus_codec_rfc_v1-v1-0-1f70b0a41a70@linaro.org>
 <20250616-opus_codec_rfc_v1-v1-2-1f70b0a41a70@linaro.org>
 <c4d934c1-0218-4147-882f-279795bcd1f4@oss.qualcomm.com>
 <DB2HSWQRGFZM.JVPTBYXCOTKS@linaro.org>
In-Reply-To: <DB2HSWQRGFZM.JVPTBYXCOTKS@linaro.org>

On Thu Jul 3, 2025 at 3:33 PM BST, Alexey Klimov wrote:
> On Wed Jun 18, 2025 at 1:34 PM BST, Srinivas Kandagatla wrote:

[...]

>> Pl use audioreach_set_default_channel_mapping() to fill in the channel
>> mapping data.
>>
>> Why are we not using channel mapping info from the snd_dec_opus struct h=
ere?
>
> Okay, I was re-reading RFC and can't really get my head around this.
>
> So first I came up with something like this:
>
> 	switch (opus_cfg->mapping_family) {
> 	case 0:
> 		if (num_chan =3D=3D 1 || num_chan =3D=3D 2)
> 			audioreach_set_default_channel_mapping(ch_map, num_chan);
> 		else
> 			/* mapping family 0 allows only 1 or 2 channels */
> 			return -EINVAL;
> 			break;
> 		case 1:
> 			if (num_chan > 8)
> 				return -EINVAL;
> 			if (mcfg->codec.options.opus_d.coupled_count > mcfg->codec.options.opu=
s_d.stream_count)
> 				return -EINVAL;
>
> 			memcpy(ch_map, mcfg->codec.options.opus_d.channel_map, sizeof(mcfg->co=
dec.options.opus_d.channel_map));
> 			break;
> 		default:
> 			/* mapping family 2..255 shouldn't be allowed to playback */
> 			return -EOPNOTSUPP;
> 		}
>
> but I don't think above is correct at all.
>
> After re-reading the RFC few more times. It looks that channel_mapping in
> opus struct has nothing to do with channel mapping that we need to provid=
e
> to DSP here. The channel mapping maps "decoded" channels to output channe=
ls
> and seems to be needed by opus decoder logic and in some sense is interna=
l
> thingy to correctly construct sound for output channel from opus stream(s=
).
> In other words if output channel is present and valid then channel_mappin=
g
> describes how and which decoded stream or streams (coupled or uncoupled)
> to use for producing sound output for that output channel.
> This is described in https://www.rfc-editor.org/rfc/rfc7845#section-5.1.1
>
> The number of output channels here actually matters for us. We can constr=
uct
> mapping for channels that we pass to DSP based just only on the number of
> output channels here and let DSP to figure out how to scatter or downmix =
or
> upmix them to its own output channels.
>
> Conclusion from my understanding:
> -- we shouldn't mess with opus_cfg->channel_mapping here, it is needed fo=
r
> the correct operation of decoder, we shouldn't call
> audioreach_set_default_channel_mapping() on it;
> -- mapping output channels to provide the mapping to DSP might require so=
me
> rework or I need to look into this.
>
> Or something else that didn't came up in my mind yet.

As discussed during out-of-list chats I'll update it to include mfc module =
in
compress-playback path that should handle the mapping to output channels.
I already have a change for that locally and it seems to work, at least it
doesn't break playback.

Thanks,
Alexey

