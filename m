Return-Path: <linux-kernel+bounces-619717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E482FA9C062
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05601BA2E72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CE233722;
	Fri, 25 Apr 2025 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cI1iGtz1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3523278D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568455; cv=none; b=OnZS03D1RdQ+lb5JW2zXJ4ib3h16xrXhV+Hggj0ckAVLSt4iaNJ0y83fvF/e6vpaiLIleUy3lYRx7N4+8ZndGSXQNV4PESdzd3MXuYWMN6N719o8yaaT361y/8UjmjTlsoSYkMQ8Q3U3d/WvCAIjNjzhhrT3C9MO9uinDsT0bYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568455; c=relaxed/simple;
	bh=IG5EYBIkkvxAjFWHA58vQMRAHNLYBMvaI/+axls57V4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VB4PIF4fxhGqd7DFSn4+Ozuly8mhR+Tim+7GvQWyCCBuVXhf5/2euSNyMdYiz7zjpv1Vnlc69uxVU9qvqFsOFcZGYnus8V4RpE8FGJs/I7EPLG79Z5fbombC6BUKVWcFXDxysXvsHqkPBMzaFeIMmd7qz6lZZqnI2sKADVwSt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cI1iGtz1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so1441215f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1745568451; x=1746173251; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwsfA2vx1w0Hd+MxkBOwMy08bPVFTSGUVL5IKHTSRSw=;
        b=cI1iGtz1IjGdprJaScSGS8CPYpwm/AHEfdJoZRU/q8qIvHOWz8lM0au8s075QFAYlX
         6S3HbVEhZCemaDOfDPwgiov/kQqRf0/z07U7CPIILT+KA+3I1kkuUicIRZeB1J8Hqrbj
         23mIgwjCHJD60Dxa+KtgOjDhgWxYScFyoRYGN3IruGS+uH39KfS2h4dw12r2WV6qCYym
         rjkRYYTnCezc/c/dRYV+922AbdDYszgRDHrW43jbnY8vlxwrVdJ6hL2lPA7BaUpt4v5+
         zrr0yLzpn7pPOvCvaV6yXqdBp21dUysARbg8fYoAB6xntpLwn3tuDfeCDiH6C/oQLl4e
         UkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568451; x=1746173251;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwsfA2vx1w0Hd+MxkBOwMy08bPVFTSGUVL5IKHTSRSw=;
        b=BXwVdOF6CcaK9DuKQPLsw7qi7JiF+JT8Uvs3bHztfUEKXJm5Mtj1Vnpa5qqPef0vPt
         +hs6ZdoeB3zKH/O5wP9mTV0GZYlTT87hkXz6G3c43yqvDIB4JqvZAhEhD4EG0fLJhd5V
         V3dsWHG5teTZjQE3AwmanSeBKZuqS97sh22PD5flXVdEtiLn/sneiBLA09yIErYAEzux
         VqPlOQdgpUyL5ZeAF4nPCu2ZTmOm02Kz1DukiqTZBLGin0k+Hy4ZRvpsjpSAzFu0JpoJ
         ULJaW/0kYX9ddYu4hN+K8dXn941QgdkMa3MN6m/iihu30sHp4bgv5q5hT5vgnkz2ffdM
         p79w==
X-Forwarded-Encrypted: i=1; AJvYcCW7kLtxQlMgUT0HXM9XDXH/L3wiiYtt5l7M0QUJX93nJyGC0Y6x2VrfcDii++OoirQO1v3k5/BuA6JFpyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47fahEVINUgOThUhBdMBMU1cipViQzWpIRwh4YlBJdtPCqqVi
	fVXCnThscce9hU1eQ98U2+sBF5ZVEz7WH9r2YYJUVZ5++M1wGGOvSN5fUDUjA7yy8/XUCd3D2Xb
	H
X-Gm-Gg: ASbGncvLfuncP3cSpjp9zBnKoMbvSB6czAzzubLWtnRBhCtu4P7orSQHyoRDOk3NCkX
	b6RQl/+oaXuvtHQRCYAygff+qmI2QIFPIMoZ6UEx/wQxWf0kI/6lCGWL4g2QY2Y5cgN1iWQEY+L
	BWBubE673Ej0PKh9sZYVo8xmjO5hhmpWDxt2KHNmCL1zrE81qEHZtX2iksbaFtTMZcEr4hqMgFN
	ewKOzi9lg5oxGVzdHlF83FR0AHEsV5DSKwmbz/pvPSC6cvm6FfcR+0qhSVaFB/eX5NGjAYtbaZy
	Ai7MYXWd6wYqo2IqPmyGQ5XM7fzpT79HiRyRXoXAnP1Bxd67Ib2UoWJRhTjLdlTAfxNrRHqEyB3
	GmWZtfng6l6pVpcXceT492lotgJKWozXUmbrBExB6qslqYdPR/WNP/hbwj3WEVxyXMuc=
X-Google-Smtp-Source: AGHT+IED++efpf5n1mpdrpKSqo0nctSBfmgC5H7SE7rg0sC07MwBn9G01Iz8pW4KpUWARaD7Nc47rg==
X-Received: by 2002:a05:6000:4203:b0:39c:2669:d7f4 with SMTP id ffacd0b85a97d-3a074f39913mr987084f8f.43.1745568451325;
        Fri, 25 Apr 2025 01:07:31 -0700 (PDT)
Received: from [100.64.0.4] (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e461casm1593513f8f.74.2025.04.25.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:07:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/5] Add DisplayPort sound support for Fairphone 5
 smartphone
Date: Fri, 25 Apr 2025 10:07:24 +0200
Message-Id: <20250425-fp5-dp-sound-v3-0-7cb45180091b@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxCC2gC/3XMsQ7CIBSF4VcxzF5zodBSJ9/DOJQClkEgoETT9
 N2lTVyaOP4nOd9MsknOZHI+zCSZ4rILvkZzPJBxGvzdgNO1CUPGUWIPNgrQEXJ4eQ2q6VppG6S
 90qReYjLWvTfueqs9ufwM6bPpha7rH6hQQNCdGtjIuG1Vf7GDS3EK3pzG8CArVtgPEMip3AGsA
 ih0KyxKrlDsgWVZvmKzgnbtAAAA
X-Change-ID: 20240809-fp5-dp-sound-b3768f3019bd
To: Srinivas Kandagatla <srini@kernel.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

Add the necessary sound card bits and some dts additions to enable sound
over DisplayPort-over-USB-C, e.g. to a connected TV or monitor.

The UCM files can be found here:
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/master/device/testing/device-fairphone-fp5/ucm

This series - in spirit - depends on the series enabling DisplayPort in
the first place, but can land pretty independently, especially the ASoC
bits:
https://lore.kernel.org/linux-arm-msm/20250312-fp5-pmic-glink-dp-v2-0-a55927749d77@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Simplify return qcom_snd_wcd_jack_setup in machine driver
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20250418-fp5-dp-sound-v2-0-05d65f084b05@fairphone.com

Changes in v2:
- Revamp series based on comments on v1, doesn't have much too much in
  common anymore
- Use sm8250 instead of sc8280xp sndcard file, so port other required
  changes from sc8280xp.c to sm8250.c
- This also changes the sound card compatible to from
  qcom,qcm6490-sndcard to fairphone,fp5-sndcard
- Link to v1: https://lore.kernel.org/r/20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com

---
Luca Weiss (5):
      ASoC: dt-bindings: qcom,sm8250: Add Fairphone 5 sound card
      ASoC: qcom: sm8250: set card driver name from match data
      ASoC: qcom: sm8250: add DisplayPort Jack support
      ASoC: qcom: sm8250: Add Fairphone 5 soundcard compatible
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add DisplayPort sound support

 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 31 ++++++++++++++++++++++
 sound/soc/qcom/sm8250.c                            | 27 ++++++++++---------
 3 files changed, 47 insertions(+), 12 deletions(-)
---
base-commit: 7f1dd4e6634d085f3c9652d4e0f1903659fb96f9
change-id: 20240809-fp5-dp-sound-b3768f3019bd

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


