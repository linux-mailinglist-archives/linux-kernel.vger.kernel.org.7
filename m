Return-Path: <linux-kernel+bounces-863055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB48BF6E54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EB83A98B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F1338935;
	Tue, 21 Oct 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HO6NUCU5"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8E33892E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054663; cv=none; b=GadNfIdo1vqyz7RjFbzNSg8KDdS7XkG7fsGLVRdJeIDTGCZGTsAWD8NcmoAqbteaazfPNvkJtvCV3t0/j6HGXz2aJkHt0HLoGvX0apicINiBCn7MTxlsr7zKTPrKiB1WphpenLeyTnl6WqA1elfCkifOfgJBTtHPpJx47vHfAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054663; c=relaxed/simple;
	bh=rdLLYhnz/5uqn7buFD6pzFSbbx+bpgXyOsq7aLCDz9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q2w/y3qUSZbIIKPQ/nCZLLQxU0w6g0YMaRwmb6050TyRiUQNmDBwI1d5MYSEB9zV0B9e+vt4b8cMN+uigPEPOd5c2SW8PbI5hRMzUapBjkXXiIvA9dKqHwkPiOQgPzWdKpjqTDnIuznqNSh5Qea4oBe63lDNLpAl2vRyjVfuNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HO6NUCU5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427007b1fe5so3693515f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054660; x=1761659460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pj1UWMB1Vw7tjSrrq36RtqXa78b52SGuEyk/FfhX/0=;
        b=HO6NUCU5c8+ykHKyKzohptzbcbrlXofhGwckN4PnH5oVYnRPMiGheMU6hafswb0QPE
         CQ3oO+sEcU0+D0O9MuuVgd2mrbLSAkerubUu/nC/Ixj58RcLepQPyh+N0EJqBKgoWpga
         7buIe9/3P1MjBAxU/zd7aVp3EztEvXiMFrE9qrZj12u1TkhhtSU7fsqy1sUwrRYWVBwT
         TVJYRkrbiOqPmOJJhzps6t/ZlHRou50+Rt0pCwKSY9rZNKCJSCVUtVR6mCKkeFGcWox9
         Swe2Q0j+gmom53Kil5NeMNXSi6L9psWXbUx47GVhqW7Foof9Tg/mcyErKFKYPk0qRPBr
         nyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054660; x=1761659460;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Pj1UWMB1Vw7tjSrrq36RtqXa78b52SGuEyk/FfhX/0=;
        b=iStwcaS87wfnFdB2yAO7rpH1lGfSPTZv8XQCCLsZ756TXyWxybAA+o7fG5hh/m6jyD
         Vh72zSyM3t+ooJ1QfPYmllBCOggx0Imlgub9t2evdwu41S8D+Pzb/dqPg/deUomiDUWB
         WcVP/cX+AeUPJHv/dOABxCG2+8zhghXU51SpeR8/1ogh2mby/JKMcmC3qD+vA0JxdNTE
         T8aL8F6xWPAB2owo3iE2JqlNW1pMj979dvyESzd5j9D7vOzyeUBAGi/jSzwsoRria/G6
         3li7wN0BnpZ8WZm46VfDhEfCWParhMrf9Ah5kQ9oZwY/RXMtUFFvrCtqOYNSeK95FqoD
         QWPg==
X-Forwarded-Encrypted: i=1; AJvYcCVJFsmt9OIzh0CY75MuQao14quemTSvcyguYl7MT5YZn1ONPiyYgIjCKVsX+/V6G7EGptWku9WCXJyEtsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5g8f7vllb+GtE6bsv2SQZENrDioEquH+GQVSTwxg9cNuSdrt8
	xyy6ab9XQQQUN3SNsLFhInVvzOnlAeR6phRxcFdKikewcMXprpBf8nEXxA9gqPKCrg1l0k5JE5I
	cAxY4
X-Gm-Gg: ASbGncvEvFcLh0hzcHAFxr4wYli0ygu3LAGSRXfoJD/eFJTfMzKKzuDgpamE+K7mTrs
	lzFKLFh616wBgJ78MfHpxweLdEB4XZZ3fARrHXvAD+sO03lKDGan/ONu/EC1StnLfS9AOaD7JKy
	AP8QCzOX/nnju4VpA7X5uRxsv0RO2tYnonuw/NeUd4ZmAA9B7JZHqPVBnxyHCYFFX+ql2Cgh0ET
	ft8GU+Od9Ssyx4BKgs/sp1yMwaE8YGknUAkeU/6sOLJSvOlhTvvrw4TprwH0205o1eLSUuTqA1C
	Uvo1H1FIbxKSdILOKkenInT/LN0LT1HtpMa2yUzWLXZl+yN27l70111NRhTf7pTZoztpmvr/whw
	Bio+6iU88B/gKawE1+DgAqN3aAymHGMlXoC92TISw5QQfXvo0C46Wp8tef1kWmPPmPVsU5dWiMi
	E83jPGf0Kn
X-Google-Smtp-Source: AGHT+IFq6wr67qH/uGO3hBDH2oknXsC+DV4koXxpX4MnvU93BRmy377dpIqcZLgtKEVXCYORZWyXkA==
X-Received: by 2002:a5d:5f82:0:b0:3e8:9e32:38f8 with SMTP id ffacd0b85a97d-42704d8d596mr13039582f8f.14.1761054660187;
        Tue, 21 Oct 2025 06:51:00 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm20124378f8f.36.2025.10.21.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:50:59 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RFC 0/3] ASoC: qcom: x1e80100: Add sound card support for
 Dell XPS13 9345
Date: Tue, 21 Oct 2025 16:50:43 +0300
Message-Id: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALOP92gC/x3MQQrCMBAF0KuUWTvQpJYQt4IH6FZcJM6vDoS0J
 CiF0rsbXL7N26miKCpdup0Kvlp1yQ3m1NHzHfILrNJMtrej6a1hQUq8rdUM7IfzyMghJnD4iC7
 svI9zFAcHoVasBbNu//5O0+1Kj+P4ARJAmrZzAAAA
X-Change-ID: 20251021-dell-xps13-9345-enable-audio-799bfbd7e7ed
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=rdLLYhnz/5uqn7buFD6pzFSbbx+bpgXyOsq7aLCDz9k=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo94+6bhciv61eugRTaa0thyKn4Odp79VugQm6/
 +KHKm7InfOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaPePugAKCRAbX0TJAJUV
 VoYoEAC/wDSEaoYU8yjuc2Yx3niR1EiFYljIEeRvCaJMVM/CS17mfo9OY5KNzlKE2mwLK9VHvqI
 og/Kwj0PT9B531KqA9ZRU338PzAhtI/MlJyKEHSalczvbSSmE+cPkd28kO7/TGiJDoGYF5RUbIk
 YWScPBswFwdB5RLnrZl3F6bx0QDrlieTjKyTOnZUZpCSB9dA/oT6Ux2E6Q2CTQEfEOO+hBfzgX4
 mcQhYeGzg0JdLr/HaB7SxBTA8HGO4zpMT0Gw5aaCyUBxMvT489VXAdd0I9UDK4Q92FdZYbYL3Ht
 pWFISA6VNab++XdP3f3mqqqnN5EonpTSzJkYxZebiYBRsFG/R5SJZPmO/WYfu0Fw5F2mdfatQ22
 p49MhwbuD+4JlOGRLP3LMkrdehCBW14DdQfFsOinugY5en8kl/8hiZAtTOxvhTkv2MVdcNi6Jcd
 /NKUT6sjHnb7D8dcia3QdiMXVdoFB59KDwA9IssfhQ9wJ2dS2FtgEGD1GxryhlnQIx4gRoK+gv3
 0C8+3EZ/P8Mj172qsy5KHZIYAuYWvBhJfLmFVCbVFvSS93WpZ2pmTTxN+H281+r7im+gPpfSK9u
 WkiMoSwpA+9BytdzNl4Jom0siTth3b+xP/zk0ZOXp0vBnXM8V1aoumi8H9WBGHTJmz9VF+CWjIM
 psH9VLlejLM6prg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The current X Elite driver for sound card is mapping the channels from
left to right on all X Elite based laptops. The Dell XPS13 9345 seems to
be the one-off when the speakers/tweeters are mapped starting from right
to left.

So rework the driver to bring in a swapped mapping for 4 channels setups
and use it with the dedicated XPS13 compatible.

The devicetree node is included for proof-of-concept purposes.

Sending this as an RFC since it probably will need more discussion
before settling on the approach on how to handle this properly on future
devices.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      ASoC: dt-bindings: qcom,sm8250: Add Dell XPS13 9345 sound card
      ASoC: qcom: x1e80100: Add Dell XPS13 9345 support

Sibi Sankar (1):
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Add Left/Right Speakers and Tweeter

 .../devicetree/bindings/sound/qcom,sm8250.yaml     |   1 +
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 139 +++++++++++++++++++++
 sound/soc/qcom/x1e80100.c                          |  49 +++++++-
 3 files changed, 184 insertions(+), 5 deletions(-)
---
base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
change-id: 20251021-dell-xps13-9345-enable-audio-799bfbd7e7ed

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


