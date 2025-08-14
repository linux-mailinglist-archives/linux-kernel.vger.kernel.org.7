Return-Path: <linux-kernel+bounces-767725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99496B25816
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308BC623C51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DC2FF65B;
	Thu, 14 Aug 2025 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOVR/Bm/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A152FF677
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130505; cv=none; b=PtSuPWi1BWUrkLrTrlpDSNbxzJBSd7mWJJQ/Tz/qN3gIXINQuXhLYCA9iXDUk3lAI8nQwcqW3B7lFtqkGW+ZLd5bx317N/60vpRMezVv/WZlFBsE9i9DgJ0ikIEIREhToNnDdLzuvuoarhQJqY/k0ggd6O1s+S+J8negk0VLJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130505; c=relaxed/simple;
	bh=zwJo72iTk2tgFMJYTVRLk79sFfVI+zpiBHz9nT1PoVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pcXWxcE4o+lAo/a+6WFHcrV07uLgFijSwm51+Rg9ehXX/70LxFu6/5tFcWmSZgMxEpMwbzClHDBO8bP0VeOveqG9sSUfyAvZJW2ln4re2phYjfUyDqnk8PonW8rpARMQOA2/ZdLnOL7RkhujNgzj8IJt9wK4eIOrMa+dyjjvLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOVR/Bm/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso2553195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755130502; x=1755735302; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Js8h6ldMj+gdFZOOeslA8bqfXFQEBcc6o5WLKiebJLY=;
        b=DOVR/Bm/r0eN+Soz+Y3N2SXB8jkRvWWtup7un/rnkyOR8PdaGD1K/OQXpVMSBLtGIt
         nLsMZssen5RAxbfBq8EIzqXmec2aTqHBUOB2C4wTiJ5m+pqR37nNjqflxKzBRJk5n4RV
         Hptxpa8QkvJJDKpD3qWhDt0ig6ymqrA4mNi5cugLO2a6ikgZZ9Q+4UjCIr7hImoXcNrf
         95V3N/UDx32zX79ky71WFTs8P6QUx4FzPICnVE2OCodT+STgFTwmJ86avFLjm9rLNanr
         Ul/FS3C4Rxd+qOxDOYnecr6+uzSA6C5eYA0xRXs3mOmE4hHlMzSY/LvLXBe+R4gTQmc1
         +RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755130502; x=1755735302;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js8h6ldMj+gdFZOOeslA8bqfXFQEBcc6o5WLKiebJLY=;
        b=F10IXnWHt+qlS9Pf7vIxjCXpeMYXDQgWPs9/zxcf6OondNTnhu+bBy2A4A/OhelaFV
         uN2+ze26/2AaWsrtE/2FiujIgX/0LSTT0jmZia4cL7UJZxxfLwHISpm+qe3J9MJWQhiL
         PTpTcYEn0XHykMY66CH82FSmzmpsqWuAOlE0RTXiYS8ajFZrkxYvdpT8+I++EAvCsWkO
         FK5FXjFJEmC1w3m+ftPnFUABb7PA33Q9CmnAiL/J410b7TI2PexfU91P6d+g5R2cNN9n
         SJcjTAb7o/EaJIq0ADRFbomnQfYAukz3EZy3zg55T+ReYOs+O3WeM19iI9bYaRafKg6s
         p2nw==
X-Forwarded-Encrypted: i=1; AJvYcCWlC2zxw/IFBIk+TB7i5H8QQj2V5rKh8yy8KsXTZlNc6ElNydRqFEt8r19kmmZokAn7Atf08AwqY4Uh+ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHRcEVFkGcBcdwNG9bDwgLHGxrcgFkOhyCe321ayUv/GRKQmV
	TXapRtoEr2QWBCxRobTwXEhCKfSDBKMrTq6R3dSOSmUNUiCqiiUSMMcXw8p1mdzqEjE=
X-Gm-Gg: ASbGnctkKU+k9U49jHznjWGaFghNeBGr2BFuYtl3YPl8kV66bhVIrv+ZzXiYcLuxST7
	Y31WcQj6uBnPP7u5u6WHF7HwfEzMjN8O6xNVOL4oEUyJ6NIN/1myQuE+xedI5xbNeSxoV6f12Xg
	Fcta1IdEKx/zjR+iNgApLJGHRUbqT7iOXh1FCrLGsi64yT8kWBQCx0dpTupnwygOMOU9V/gk7zW
	T7SZ5RMilN8PIkPXTLcEno2WlTwd09W6NzcQlyHA2K/LUiZ/yV7hLmw8ls5pjW7pOYKpbsJSFvp
	eZdCuGdmmpbBXPkrfroBLhWedZi2ourCUxNPh/x947fI/Se/+CWZGggJT6Z8LlaCm3uCwSyjBHv
	UrT8legt8HYC/ZoJYVXl1j7Tem4rd
X-Google-Smtp-Source: AGHT+IEE/qJ2A+EGcLK5KKpvuXaOVb/kTUWQl2Zzg8RdrlyOQ/B0cgj/6qwXHlkz+00A1J55dDOw1w==
X-Received: by 2002:a05:600c:3541:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-45a1b655a8cmr4647785e9.28.1755130501766;
        Wed, 13 Aug 2025 17:15:01 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:7f3a:5ab2:26aa:831f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a540e1esm18449065e9.28.2025.08.13.17.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:15:01 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v3 0/3] Add PM4125 audio codec driver
Date: Thu, 14 Aug 2025 01:14:46 +0100
Message-Id: <20250814-pm4125_audio_codec_v1-v3-0-31a6ea0b368b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcqnWgC/4XN0QrCIBTG8VcZXmfocWrrqveIGKJnm1BzaEkx9
 u653UQX0eX/g/M7M0kYPSZyrGYSMfvkw1hC7CpiBzP2SL0rTYCBZAoUnW41B9mah/OhtcGhbTO
 nDKzRRjDmnCXldorY+efmni+lB5/uIb62N5mv6z9xRSlKaISwNTSGna5+NDHsQ+zJSmb4MJrzX
 wwUhgtU3UFIpbX5YpZleQPo0+7TAgEAAA==
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
 christophe.jaillet@wanadoo.fr, Alexey Klimov <alexey.klimov@linaro.org>
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
Changes in v3:
-- added qcom,pm4125-codec compatible to qcom,spmi-pmic.yaml
   as suggested by Krzysztof;
-- added braces around if-else branch in pm4125_probe, removed coma in
   pm4125_slave_id[] as suggested by Christophe Jaillet;
-- slightly re-ordered header files in pm4125.c;
-- reworked how driver deals with regulators after Christophe Jaillet
   noted that it is broken, devm_regulator_bulk_get_enable() is used,
   it looks like there is no need for regulator_bulk_{disable,free};
-- PDM watchdog irqs are moved to separate (new) widgets
   as suggested by Srini, therefore audio routing and events for
   HPH{L,R},LO and ERA PGAs are changed;
-- extended pr_err() msg in pm4125_get_micb_vout_ctl_val();
-- small styling code adjustment in pm4125_get_compander();
-- added/reworked pm4125_bind() to add error paths
   as suggested by Christophe Jaillet;
-- removed of_node_put() in pm4125_add_slave_components() after Krzysztof
   pointed out that of_node_put() is out of place, it looks like
   of_parse_phandle() gets the node and component_release_of() will
   do of_node_put() on dev release so no need for of_node_put();
-- Link to v2: https://lore.kernel.org/r/20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org

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

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    7 +-
 .../bindings/sound/qcom,pm4125-codec.yaml          |  134 ++
 .../devicetree/bindings/sound/qcom,pm4125-sdw.yaml |   79 +
 MAINTAINERS                                        |    2 +
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/pm4125-sdw.c                      |  547 ++++++
 sound/soc/codecs/pm4125.c                          | 1793 ++++++++++++++++++++
 sound/soc/codecs/pm4125.h                          |  313 ++++
 9 files changed, 2900 insertions(+), 1 deletion(-)
---
base-commit: 43c3c17f0c805882d1b48818b1085747a68c80ec
change-id: 20250626-pm4125_audio_codec_v1-02ca7a300ddc

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


