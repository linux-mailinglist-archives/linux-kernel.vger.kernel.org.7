Return-Path: <linux-kernel+bounces-726802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F7B0116E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8910A5678F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DBA95C;
	Fri, 11 Jul 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1f7YijG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C12AE8B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202818; cv=none; b=iCVVBk7zhruE+gRH3kKeeAvOMwNhFfujLpFRup3B6xe5AHbF9R78oYA8CFSER26GnRoVheKXoX/F4Y0vhmV+QAMeLeg+T2ho/00s5BIuqBruHJM98k6hE165hXRQf4UJNmNjFk00uUCv+2dBBCnWZBOvzanwwZvInLfUiBTx2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202818; c=relaxed/simple;
	bh=Yn7aK+Gtg5vwN2OrZxJqZteeXqHgSbdBnyyQjvw/fCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KeqOt1soF+e4pA/dfkrR+YV7uFRiviq49b6WxgXRCncdrhtZuthfO8bomR8/9l22iQF0yjFYNGujqKYGpMyUCqQqpRAUg13G4h2ndJ9UCeSRVmBRyXJ1iqMUzoAKp2lnZhBVNrK8bwy2ws24vBYRbDOCTDXy9fpgHsuR+TvswXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1f7YijG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453398e90e9so12237045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752202815; x=1752807615; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9fO9S6Ip3l6OJZpBg21f9D1VRI+E3BXOK5zK8Ozazs=;
        b=b1f7YijGnkeQMb/SbLyQmbcc+GbdxnqAHu6gElkGLjJs2q6qN1+WTEBPD5k03+Pm4m
         gdXpgRnY0v0GXLx2R4Do2pIj53Rgt0syOiVzY6c/rs1P4AFYsxZ2UiRWY5segtu5Khej
         CeO1AwMjMEG1pfpJ2JZgnJkT/lqfRaR8StErd9qIZzRwTL1bHjrd68qay/b9IK2UMhRm
         Qwx0YXQr75dA7JtTKIGi/GkJYsKmkZrxYAE07D6yYXL+cw7ZUSv/S5vAtQ2cA17xoWsV
         n4DeyeWRqhC5cJGpLcVcTqj0BullTWlRNrYzA53X8aebsKzKlec1sbOXcvUcV9KpE2vS
         Z1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752202815; x=1752807615;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9fO9S6Ip3l6OJZpBg21f9D1VRI+E3BXOK5zK8Ozazs=;
        b=UKADNgpigiscE8OT6XnR/qKptZ3AEXpsfkdvVN2H5IWaW0CFSxeuoCMlK7Yk2fhi0e
         EiaEyOeMc+0WpYoc0PujOFw/I1oJAVBT5Bj6zi/CD88vPm8xhaTa+mA7GibD55hrNbU7
         mRV2bYMOYdBtbK7xM155fyy+c6EFT34dYynB2ZoeI6+3jGJK4IqRUHhFIxP4RzTCm8Ik
         LDaNL0aLWSbw4fqf1haYcb+Sq+EpPlnYty5r7gbPwC4o2bFKXhiPJ0jP/53GPRtPJ2d0
         e2imtLJ4rO2/wwkK/PbBzxY51Y6oXY/3zdAA16ln+e+daWMr0o2gpvs6PvUAT5lEN95G
         NgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6jk+CntaX1Ck98T0rXTjhoXaYW4xcPeQeet8fxKxKDF05ZrVCuj9gOoQNqdWboz2pmLQjNPSUmgHS9SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhF0LNZPRzwROWj4eQZbBH0qCdX9OisxpHcw3FmRLlcxGYCkge
	zejt+TUkh5xmQt6vlPS8N/6mCBxJajexkL4K5E4wrCUwqOeICb+RbHyZ3KGfBEWabsI=
X-Gm-Gg: ASbGncu/E4M5hajW6caiMy/qu13O6yYvNFrNpxqtrh3wpPYq+Qy3OBHMZYfuamZx3o9
	FQZmaJIGgSvKFzvulz6jUrd5DtIXKVAI2hN79MtAci3Jp1EG/GgudfJ3PR6X4lQ6D4rsceAjHmd
	mHcqcgwZ4tGTb7GMm5m6CUC0fs2SsAZiMvxb1eijvOKHqBWYuzOn5JaezrmK0c0SNLlwY3UkKLO
	PAz329SUBpose3vDh9d9poJHEh5opNxC6+DlCKtRLvNpHK/Uk4gznkj86X3WwGDipMoyB8OS5Q6
	YBcyuTLV/gFDPNkWUCrjcwRxR6aZoHhOYPRIW/K/FpEkpgy9RSSS3Tb2YzZHvScUC5s4v/NPkb5
	QZMlJ2rbRXAXxluXbAn4ycuNyMzgbLg==
X-Google-Smtp-Source: AGHT+IH4CmNtUhkTrPRG8gJIFlT89/SoRuA9SyoLr/hOCP51o6IZKBdDkgR+lzOVlTMC+QOF7LL07A==
X-Received: by 2002:a05:600c:6297:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-454ec26a7aemr10802535e9.15.1752202814695;
        Thu, 10 Jul 2025 20:00:14 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7213:c700:e4ad:f2d9:9dd9:cbf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50fa9b4sm75424355e9.27.2025.07.10.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:00:14 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/3] Add PM4125 audio codec driver
Date: Fri, 11 Jul 2025 04:00:09 +0100
Message-Id: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADp+cGgC/4WNQQqDMBBFryKzbkqcGItdeY8iISRTHWgTSVppE
 e/e6AW6fA/++ytkSkwZrtUKiRbOHEMBPFXgJhtGEuwLA0rUssVWzM+mRm3s23M0LnpyZqmFRGc
 vVknpvYOynRPd+XN0b0PhifMrpu9xs9S7/Vfco4I0dkq5Bjsr+wcHm+I5phGGbdt+IrmLeLsAA
 AA=
X-Change-ID: 20250626-pm4125_audio_codec_v1-02ca7a300ddc
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

PMICs like PM4125 have in-built audio codec IC. The series here
adds support for this codec driver: DT bindings and codec driver
itself that consists mainly of two parts: soundwire devices and
codec part itself.

This audio codec can be found on platforms like QCM2290 and
on Qualcomm QRB2210 RB1 board.

We are working on this together with Srini
(srinivas.kandagatla@oss.qualcomm.com or srini@kernel.org).

This driver also has a bit limited support for concurrent playback,
since line out path is connected to left input channel.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Changes in v2:

-- added rxclk dapm widget, fixed/changed RX1/RX2 widgets;
-- added comment for pm4125_wd_handle_irq();
-- registers access permission routines have been reworked;
-- changed pm4125_sdw_* functions to static inline;
-- cleaned a bit pm4125_{rx,tx}_sdw_channels;
-- got rid of most of hardcoded magic numbers (for the remaining regs+values I don't have documentation);
-- updated commit messages;
-- pm4125_tx_sdw_ports has been updated;
-- removed of_match_ptr() and OF ifdef;
-- removed couple of pm_runtime_mark_last_busy() calls;
-- removed swap_gnd_mic;
-- removed __pm4125_codec_enable_micbias_pullup();
-- reordered sequence of calls in pm4125_probe() to make it a bit more logical;
-- removed excessive regulator_bulk_free() and in error path in _probe();
-- re-aligned for 100-chars length;
-- removed of_node_get(), replaced with of_node_put();
-- corrected some dev_err() messages;
-- corrected some comments;
-- removed legacy "WCD" from stream_name, replaced with "PM4125";
-- removed null callbacks from struct wcd_mbhc_cb;
-- removed "HPH Type" and "HPH{L,R} Impedance";
-- pm4125_codec_enable_micbias() has been updated;
-- pm4125_micbias_control() and pm4125_codec_enable_adc have been implemented;
-- pm4125_codec_enable_dmic() has been updated;
-- cleaned struct pm4125_priv;
-- some rework to pm4125_handle_post_irq() and pm4125_regmap_irq_chip;
-- updated Kconfig+Makefile (to make things be in sorting order);
-- new patch: adding new files to MAINTAINERS file;

For dt bindings:
-- I think all requested comments from Krzysztof were implemented;
-- squashed qcom,spmi-pmic change into previous patch to avoid warnings on dtbs check;

Not done:
-- Mark suggested to look at reimplementing this as a child mfd device from
MFD PMIC without device tree description.

- Link to v1: https://lore.kernel.org/r/20250626-pm4125_audio_codec_v1-v1-0-e52933c429a0@linaro.org

---
Alexey Klimov (3):
      dt-bindings: sound: add bindings for pm4125 audio codec
      ASoC: codecs: add new pm4125 audio codec driver
      MAINTAINERS: add Qualcomm PM4125 audio codec to drivers list

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    4 +-
 .../bindings/sound/qcom,pm4125-codec.yaml          |  134 ++
 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   79 +
 MAINTAINERS                                        |    2 +
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/pm4125-sdw.c                      |  546 ++++++
 sound/soc/codecs/pm4125.c                          | 1767 ++++++++++++++++++++
 sound/soc/codecs/pm4125.h                          |  314 ++++
 9 files changed, 2871 insertions(+), 1 deletion(-)
---
base-commit: 2ae2aaafb21454f4781c30734959cf223ab486ef
change-id: 20250626-pm4125_audio_codec_v1-02ca7a300ddc

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


