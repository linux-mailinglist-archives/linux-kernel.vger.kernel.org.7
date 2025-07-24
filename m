Return-Path: <linux-kernel+bounces-743626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF5B1010A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C321CC5C57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF02221FB6;
	Thu, 24 Jul 2025 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="a797IIi8"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DA20F088
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339568; cv=none; b=f97O+/KxIGg7COgCnHue8kQ8FIbr23nH1Iwegbj6BCfU1LP9EtAcUObQc1dQFj3HtPw3P2U7EA9MCNgc/WbCV97T6uE1maGhWBBSE+IcwFQ0tiPFb/YVSXtk6jZxYaQyksNnJvLD7cYiEQ0zeUhjwfN6frUniFOvtP7EmII3cAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339568; c=relaxed/simple;
	bh=E8K92WFLqixwgt8J2cex/loEksjjno4gWYC7Q3w7a8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G6cfLn7SixiFuCeGw2yvnbcCnZHI8QZv1EWW9XHNAElQvbNv/27FoAzYaE1tRCtWLiEdzhQWsskkBXDPhCCzvxe8qGGhhagexqET2RSa6oH8r6b8QwXlZE/sUVj9d+1moaN++Pv959d1MjSpqnaxQbLVH+BqDJtuuisTmxglpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=a797IIi8; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae708b0e83eso137278066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753339565; x=1753944365; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O05wjEScA4kxCQO8+MTTv2LGUA2bVFgF29zptnElwW8=;
        b=a797IIi8N3j5cNCflbBeedwgZ+4BEGPc8ZuLFQqDrJpHsBvRjT7it5c6GWTTCe6M9+
         CSeoAAh9CsyUGQwpEemgRnaA0BuWG9r0VVnrsvVqwqi5T+hHGRgt0h62ZkelpnWRibIP
         WQastMIl/Mpmb1JH9gdkd2P1QCkoyn6/RXW2BKs6vY6QF5ayAxsFTtF+P8RWbXWx/tWa
         iwkncC9uhXG2BKuomXFXO5O0T2Pbg1ZM7gHA32+pC4h80xtWIl5Y74XCCBAZLfKVtusi
         L/V7vA01Lb10Lr4yurpoBKIZ2QUkE5C9cp8ga8+wAWi/W0VHoECKVjJMa3rMkVuISVxp
         0xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339565; x=1753944365;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O05wjEScA4kxCQO8+MTTv2LGUA2bVFgF29zptnElwW8=;
        b=kFeLIamYjhGA9oIIQvSVY/ud7Fa5VlGDKZ+lGNjzEv1MVbvh1C5ymzgD4Q9Kf/iWwD
         zWBiI81TC3dmXKjMPM8ZevOrxoX0N8AItoH+yp6YxabGBukV5bjPN9d41/OXq2R8S/is
         5pJJBKNkNOhpqB1UBMqTkrU61eaMv7YBWvILTN7fj/FrQpsETGiIRmJYokhhZ0mgRf1w
         gSzDCvXtu3WcD+gSnbPRQbuKlQO8vsrx5zw0m6gM8jsNIqg7nNVX1NGMil4s3cg08PNR
         xduAWFY9Q9wgDHocMDOECrzxDAxbbfBmfeRU/Eo5xLKZBjX4y88uChiTQEJ1zYLqYc02
         e6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUI+pQrOn02sGQBWlHoUn3VZgeSONzO45o0m6RvjcX87iqxxPyMFi/hZ4vhlNb2MOXZ2KbHlJeOwtVMv4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzowj/8HGtzFwUs59BpXxLf6iWhlGQIPEikY/XhL8+9674sccLR
	mc+HIB5OUDEN9AxJCSZQlMX3XdZp5aWRWx1ev4QIk77WNqPhSFFW9ZVjKpvGTNgBd1Q=
X-Gm-Gg: ASbGnct+me5n17AqMhdA7p+A5ukajX2POeGX7aMJah3S1L6fplcaNn6HbBvw0C85vb7
	QmiFt/bXWjJwJuMWOWg5UJA4UA1ty0PPUM00IXkWic5azdt0bI/fr73zT6b3c6c7OKPM2FmXZz6
	ZJau82ilhrGEZjSOPX+YosWXYBXvF0CVYtNizodVVG+f7q55MRt54xwP+vJj+3qcK22Et/g/aL1
	HXLqgytGsDru13jurHIM0HlASHjJyj3PHKcMYbXXWbDwkIH/b1NshU/FHPsPl8tzNP51yW+Dkgy
	AmC90egJBmqJSU/AZ+vam1j4hHBS63UmZ+8hlpew2V6diBaYHmySvclwd7yIcf1/8FVpyUrcSni
	qgLQvyVr/uxTm6nJdwuotjFUOrzCe/so4vK44RAxbNgZ4Ttcb1tWH3NAMM3FJmhFjWiSJj4XbSl
	WZ1A==
X-Google-Smtp-Source: AGHT+IHOJhHzF3e38nSkhr/JtaCTAW1NS3tTTx4AD/Gh7AcSikLRvVdo/lBTRPnndwMlCRIqVf21aw==
X-Received: by 2002:a17:906:f585:b0:ae9:bf1c:50a4 with SMTP id a640c23a62f3a-af2f866213bmr566893066b.36.1753339564518;
        Wed, 23 Jul 2025 23:46:04 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42cc4sm63770166b.139.2025.07.23.23.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 23:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 08:46:03 +0200
Message-Id: <DBK303WXZ3OB.8SX718AMMYH8@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Wesley
 Cheng" <quic_wcheng@quicinc.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] Enable USB audio offloading on Fairphone 4
 smartphone
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Mark Brown" <broonie@kernel.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723-fp4-usb-audio-offload-v3-0-6be84ed4fc39@fairphone.com>
 <175328933413.84720.17376811405962157319.b4-ty@kernel.org>
In-Reply-To: <175328933413.84720.17376811405962157319.b4-ty@kernel.org>

On Wed Jul 23, 2025 at 6:48 PM CEST, Mark Brown wrote:
> On Wed, 23 Jul 2025 16:03:37 +0200, Luca Weiss wrote:
>> Updated description for v3:
>> Add the missing bits for the sound subsystem to enable USB audio
>> offloading on the Fairphone 4. This is mostly sndcard enablement now.
>>=20
>>=20
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>
> Thanks!
>
> [1/3] ASoC: dt-bindings: qcom,q6afe: Document q6usb subnode
>       commit: b102c9d89fecd72be83eaab9b384285e2d0dc940
> [2/3] ASoC: dt-bindings: qcom,sm8250: Add Fairphone 4 sound card
>       commit: d664e75317e19bb79b6d207f7729e35eca504a6a
> [3/3] ASoC: qcom: sm8250: Add Fairphone 4 soundcard compatible
>       commit: c58c35ef6ae62e36927f506a5afc66610b7261d9

Thanks, appreciate it!

Regards
Luca

>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark


