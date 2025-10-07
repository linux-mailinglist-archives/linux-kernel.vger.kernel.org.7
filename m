Return-Path: <linux-kernel+bounces-843667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91022BBFF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30B2F34C894
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C1F4165;
	Tue,  7 Oct 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0dVm77e"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DD1FAC4B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800374; cv=none; b=WMLhfdU/4izeoSFmuN730dEdyPChlwTpN0Bid30T5S+UxggYanG7ozFmTJ17bApvBrFQEj6UUYXI+xL8AlvLLKhg7pBB9Vkw5md49qfSTx0okibhYBwwop2OgX26rGE1FZyfOnrI40D11fzn+MLIqnFesSs0KeIKy3cPaTkbWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800374; c=relaxed/simple;
	bh=16DquKhHf4rKURRSNctoiZxsdCnEHoGlUqmScEx09GE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sc36hqcJbA18sVnWdhsoBEwKN9uOe1EGnK1hnHZTvOnMFRRkBVpkwlo4Uu9zxZcPWH8+Q1TGMrCQ5qi3RmnMBfwYOicLpAf4P9dVhkTCpAqiT418Diwtw0kEstEpbO451ydl0gtXhruMOg5V7zhEVk6nuo/l5VQ7SyAAqY+wToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0dVm77e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so52839825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759800371; x=1760405171; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSNduwIg7jI6jqDFPflXbxR6x1FoXK0RkqCfhQ+iHV4=;
        b=S0dVm77eoTZP1SINrrdGH3u9KkYmYstgGSLMvi6VbH5zztldflqG5ErMqizS6X4ocl
         ng8uWjJOBEtIyFCbXUHbRZdnYeBPzKYNZZKUvrmTZX5qHN2FeYYR27VxIGVk26uxdKKP
         YqjI8NS/AvSj2l3c3KDGsG677K3VF8tEMWIa9rk2LZwpMkp/CxquvCX6Ow4JbKWJjdox
         0ncGTFvkYT2e+AIdC/wzPE59GbijlVrJsyHamujulHk+tiGudrM/rfCRchrFF8U+JLts
         DSTHFIpIE/doTAauq7KLTcKYid+peWzYDid1D1uMY8+BQdvJAER9fyu9ArfiHjm9z1Pn
         hlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800371; x=1760405171;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSNduwIg7jI6jqDFPflXbxR6x1FoXK0RkqCfhQ+iHV4=;
        b=jQgI2xGTUl31qIncIeforAvtR1mTeyR/DCJyEyQTSNGly9Vz05rt8l/L2eVlRWvZQb
         og2UzGSBhBpWIHTs4PTy/5F+Rrqd+28U1icICEpB3qjO9Bm7Aw/QITkJmdnEWtdOwnxQ
         NpmqzRVcl/w4iq1MYfMl73kWMWVPgd/GVVnygtFVKVDPFvDfV5BkbiJ7+kENuTkwV56e
         vEOEroAJu6NYp+QkO1nnViy1kS7eb6PS8kZ/20eZMJwSdcOVanfIoFKrduH+75GPkefQ
         BprV6R4s9yTVfPUEzVckX7UDbGs+SR5YVdZMz6Ye0Q/l6KrVZgfKJadaWsqyHavJWpTA
         X5fA==
X-Forwarded-Encrypted: i=1; AJvYcCUnDXXEiVmBsFUunAkozDZx4ytXieBHWHTuX0dMERMtdJpLyDUAUEWMCahyDFL5LCwcxxiO+JfZAhUsDIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziW2eniFYZSyaGPxyL+jn9PtqgGddOtbR86Eud5FFfwal31ne3
	GZJ8P19CrtzQqoOnc0jJhiIaL7dq0MYYQF1yBEmwhiz1A+vXEzOurAoQbjrChbyhLpg=
X-Gm-Gg: ASbGnct0+3XdJgndvVFauTvpFt6umrNM/5VsVocIrSXkK6dYOWs1EHJDiXq9+OAayC7
	LuhP86rnoc17N39rbENXm4aDKkekweEJbaLXI83WfyNC87BH/hnn43j7laZR4g0x+qf9MAbqy5d
	mcVFn2Kg+EMqJ+GKK50US868VJA7Y/FCcx8N40Q90CoIOa8kxI/0qm12cTBSCwZA8IwXTKLW8lZ
	NDbo5p37dqlWgynPaih+5PE4n1fKG6fs+6jnRh/w3v4jF79okyx8azVr2sL9VUixcEEEWgDWyjs
	c5th9BHHsP6o/DhptzbQ89oG9NNXteyo6uwFXOwj9yrGtBPitkzOYTpWGVcO92snRcQQY0anWne
	5+FCw82On6GKVIzcqb+/SkCCtsRrugAVd/XTLTUOH6Jmj7OqNkjboMkNTBA1CQnqV20w=
X-Google-Smtp-Source: AGHT+IEqCjJVNQ+4Qs4Y8SQUQR2vF3o2dNkE/MGT5wV1/bzYlB/WElOfwkhccFVlq2M0O2ZMoNgvfw==
X-Received: by 2002:a05:600c:350b:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-46e710fe3a0mr87258455e9.1.1759800370875;
        Mon, 06 Oct 2025 18:26:10 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d52a71sm7410915e9.1.2025.10.06.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:26:09 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH 0/2] Sndcard compatible for qrb2210/qcm2290
Date: Tue, 07 Oct 2025 02:26:06 +0100
Message-Id: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9s5GgC/x3MwQqDMAyA4VeRnBdIM8twrzJ2iG10OdjNFEQQ3
 33F43f4/wOqummFZ3eA62bVvqUh3DpIHymzouVmYOIYiB64+sgcCNe0MA+EteQknjFL7LmPInq
 foNU/18n26/x6n+cfXO2mxmkAAAA=
X-Change-ID: 20251007-qrb2210-qcm2290-sndcard-da54245aae3f
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

This is a small patch series that serves as a preparation for
adding HDMI audio playback support on QRB2210 RB1 board.
The patches here are for sound subsystem. The other series
will focus on qcom DT files.

The previous series where one of the patches here were taken from is
https://lore.kernel.org/linux-sound/20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org/
and sndcard compable patch was added as new one. Both are basically
done as new ones.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Alexey Klimov (2):
      dt-bindings: sound: qcom,sm8250: add QRB2210 and RB1 soundcards
      ASoC: qcom: sm8250: add qrb2210-sndcard compatible string

 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
 sound/soc/qcom/sm8250.c                                  | 1 +
 2 files changed, 6 insertions(+)
---
base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
change-id: 20251007-qrb2210-qcm2290-sndcard-da54245aae3f

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


