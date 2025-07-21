Return-Path: <linux-kernel+bounces-739073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7605B0C170
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534CF18C1E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F52900AF;
	Mon, 21 Jul 2025 10:40:02 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60E28FFCD;
	Mon, 21 Jul 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094401; cv=none; b=IHU5lnfHG+NNaK5OOzVxs1Zsi0na7KPHwq5+N3dHrOFw9loa65ZZVG7k1u2q4Eo/9s4/Hqrio0uzSQMIFahFo+vgImWHnXoPup6V58w4wxKymc/wZhWeZbxcR0WsZIpbIzQH7i2OwK4hePRU7roN8hShutX8cnYyRMmxO0Zhgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094401; c=relaxed/simple;
	bh=H1W0pqeQxw8AWbGmsEsUGvw/bKSf3E5qBKHzdHc689Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsWyCPMEaGHNUvozrgEgt5x+OuK11wyx1uGgXs09vyxgiBuefBuDzQ4/vypKlCtCuv3wblPpoBZKgEy/AqtmIwob4XBbO2jui0LrticApHdfp/Yp+vhZTcz2OsCOzCf+niHzMcQZP+JT2gXYUc/g3RjC40W94Ga4egxBiYxEFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpgz7t1753094348t04ff833c
X-QQ-Originating-IP: lp/HNeAsaEzNby3rIXE7ZRE8R6io7QwLW8SgkUXJoic=
Received: from localhost.localdomain ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 18:39:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11538204947286758838
EX-QQ-RecipientCnt: 14
From: Nick <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] ASoC: codecs: Add support for FourSemi FS2104/5S
Date: Mon, 21 Jul 2025 18:38:01 +0800
Message-Id: <20250721103805.531758-1-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OBATINHf7lTMm+OTyxcigpfmyugEMMMBwpZLcE0AZvyb1Y5vBXo5kHb5
	RqEcELdcFNDnE+LTsqUmkHEqAYnK7hRvwYAQfnE3qjJ/SfKP+mvskIREUMaMMRKTKoQKUWJ
	TAZbaURmLBEkgEX3mMRL4zehku+8VkUp+xELg5OjWpFSVWW84Aqxgtjws1SlOs7DJRS0Eg/
	Qok+s/zx3ttzuzc9evkz/IISILYITbQde8mzRhtU6Nq09PO6PZPi0XgtBSRFos2TPe4z5gv
	2XYXQoTchlX5jDjLA+VWW8K8CpBK4nVBQeAZIKpSO2qySl3u3JUMfDTNYlX1vDr07YowBzS
	tTezIQrOIZcPKB38J6pVH1Z6xcyvR0qqfEVAYw9w8N1xifrK4+T7fG+lMW17jhpcU10oZrg
	e5ltd6gSW1QnjOzipbPOuUCmn05y7Zz6t9/EaB1JRwLj9QcWru2Kg18eYd2FkqYmzhx+QDV
	Ae9NlZ99HoGDyIAAX294sWRFpDd2/fsRU5VealJiLYHsnRRXl8DxWtkIq40gPKT06LqkTY0
	DY3/nKcZBAOGcRiT7D1UvYyVrAq9RnspkH+dQgXJ3TrJTMGXtJiV/jOcQvYePOmuiRdecfl
	R4SVDY2U77ZMUGZeel4yVKntNB/Ff80wgq/5adGq1w1p160oJHz57wglATnovIAxBROPCLk
	yH+RYAmxcpAnWtDIZGBwFHphUFqtTZYWI2UgdwP8vgQbBCrSNvq9WyhIfyvmeTZkinsFBHm
	iAuYibSVi5KD96kHlEvxmgT4NWpcwqjvGGvsrzF4lZXoDYoli8jH3oDQkktnLc5Zk8wx+Ua
	YojoyxnKLUc7jh3dyZI/NDnAkYIUNHSN0lbjMqA+v7ZetsGCbddCG0Pv3IbW8GxVdYl8KUD
	XEuuZPnfFjMpti/4tKO10j0Du92XoZ3uLnalUnoeqqTLmfV6/PLkxkPtsrVqGa1rNN1KJTG
	eRoL3D1CDJ/rELpmbG3hxJcWD261qYPV3j9muO3JK03bR45Vk/3woVEKk3loUFciVWSqPjx
	usEiMPMDatLr/jUiMkVGITqUyEq5VD3zFocQ3LXaFk0dlsASc4s7Jzfhs0eMQVQe2Ii+v/q
	5JL3sx7rR7lerpGMqCQQhM=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing
FS2104 can deliver 2x15W into 4ohm BTL speaker loads,
FS2105S can deliver 2x30W into 8ohm BTL speaker loads.

Most functions have been built and tested on EVB boards:
ARMv8-A, Linux version 6.16.0-rc6-v8

v3 -> v4:
Fix warnings reported by clang-20(W=1):
warnings: variable 'ret' is used uninitialized

v2 -> v3:
.../foursemi,fs2105s.yaml(patch 0002)
- Drop "schema for " in the patch subject
- Delete the description of the property reg
- Restore the property clocks to v1
- Keep the same order as in list of properties

.../Kconfig(patch 0004)
- Write the help of config symbol with at least 4 lines

.../fs210x.c/h(patch 0004)
- Update entries comment to C++ style
- Use linux/gpio/consumer.h instead of linux/of_gpio.h
- Use a private lock instead of a global one
- Delete driver version and log
- Drop checking of pval in fs210x_reg_read
- Drop most of the debug logs and unused codes
- Drop registers dumping in monitor
- Use fsleep instead of usleep_range
- Update mixer to a standard control:
  PCM Playback Volume
- Add 2 new standard controls:
  DAC Mute Switch: Mute/Unmute
  DAC Fade Switch: Fade enable/disable
- Fix errors reported by mixer-test in mixer:
  Effect Scene
- Integrate the operation of reset(sdz) pin into chip init/reset 
- Add DAPM event for playback:
  Start/stop device in DAPM instead of mute_stream
  Start/stop delay works in mute_stream only
- Drop use_pmdown_time in component driver for DAPM event
- Add dai ops startup:
  Report format&sample rates in constraints
- Add dai ops trigger:
  Start device in trigger when we can't obtain/control the bclk clock
- Use description words: PROVIDER, consumer
- Add a sysfs node for monitor period(fs210x->check_interval_ms)
- Do the initialisations of delayed works and clock in i2c probe
- Prevent new work after the device is suspended
- Update regmap cache type to MAPLE
  Define volatile registers
- Simplify the logic of getting and setting clock
- Simplify the logic of getting and setting reset gpio
- Use dev_err_probe for error logs
- Remove fs210x_parse_platdata and use fs210x_parse_dts in fs210x_init
- Drop null checking for regmap in i2c probe
- Add a suffix(instances id) to dai name
- Drop compatible of "foursemi,fs2104"
- Drop ifdef CONFIG_OF and of_match_ptr

v1 -> v2:
- Adjust the order of patches according to the dependency relationship
- Rename yaml file to foursemi,fs2105s.yaml
- Fix some properties and error definitions in foursemi,fs2105s.yaml:
  sdz-gpios -> reset->gpios
  fs,fwm-name -> firmware-name
  Delete fs,dai-name
- Drop "dt-bindings for" from subject
- Update the driver code according to the update of DT schema
- Fix warnings/errors reported by running checkpatch.pl --strict
- Fix warnings/errors reported by running make dt_bindings_check

Nick Li (4):
  dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor
    Co.,Ltd
  ASoC: dt-bindings: Add FS2104/5S audio amplifiers
  ASoC: codecs: Add library for FourSemi audio amplifiers
  ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver

 .../bindings/sound/foursemi,fs2105s.yaml      |   99 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 sound/soc/codecs/Kconfig                      |   16 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/fs-amp-lib.c                 |  265 +++
 sound/soc/codecs/fs-amp-lib.h                 |  150 ++
 sound/soc/codecs/fs210x.c                     | 1583 +++++++++++++++++
 sound/soc/codecs/fs210x.h                     |   75 +
 8 files changed, 2194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h


base-commit: ed73a24357531e1747a6e140c329015da6429629
-- 
2.39.5


