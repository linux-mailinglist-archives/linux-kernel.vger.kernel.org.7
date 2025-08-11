Return-Path: <linux-kernel+bounces-762417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6611B2064B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAE817C9FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA9283FE6;
	Mon, 11 Aug 2025 10:47:22 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AE2475CB;
	Mon, 11 Aug 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909241; cv=none; b=RHi+74eoU0jY/G/QIbGk8lzLj07qqIxr/3/W8KqY477o1biwKl4TGCV2+kvocP79TB3OHeOAaGIVLKBNlt0HujJHKD5gQbyQuCoihFrbMiHTtYzajmgTWtvxOUDzta2Oc7G92ePiLiqXi34fg/dkfM2AEIvuT1X97wxNw5SdIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909241; c=relaxed/simple;
	bh=74lWnkUybeUxa2r9paZdcWUGPAOvMciUy5dinkbH8eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjeHe6z+J/WDyNQIFtWZqkEfq0zA++DYm/ozguJXzBhRoZHb3avg1E2W8f7mUF/vigJHlWL9gS7jFv4Fogk/xKO03Wt24XtHVEwAV3Rv+zYmd4uxFJqgaFxhaAUVSumXgflddosma3gNuLoBpjyJUN4HhMrEQxSWiRq53yvsNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz6t1754909173t54a502d1
X-QQ-Originating-IP: gP1au7LchbgFtd053a5FT0xRtO11SCYj7mI4AVIXK6o=
Received: from buildhost ( [183.17.229.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 18:46:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2318197574500668316
EX-QQ-RecipientCnt: 14
From: Nick Li <nick.li@foursemi.com>
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
Subject: [PATCH v6 0/5] ASoC: codecs: Add support for FourSemi FS2104/5S
Date: Mon, 11 Aug 2025 18:46:05 +0800
Message-ID: <80DE83927D6EFD94+20250811104610.8993-1-nick.li@foursemi.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MacKlOQbIuFYKvcVEf+L62TBJ5Z8W/s/fIgj6RO0aKl9rlxCxjuNBlu3
	JMHzFENQsVkAIHj5eDDJQpXea9KkmQgxWtbP8vKWSRPZAXL5s+KBQWUYJMkngsFh1lgLjEO
	cHzG9qlq5x0BdTtVXJjDd37c2RibKusHF7deZD6MME7H7AV+RmuV8L7r0l9rVtf9IB6Fp+7
	sf69XI+b43+L/VZKYzzKFdi1LNFx8RSOBGD6IAENOjGstNUjd7SBh0dvVji5hRBG6lQKtOl
	I2+SSc2dbfDSRoGOzrpNTggEP0DtzJGdTAOZVL4M1Yp9oshQfFpqKnzmEH6tGwqgSfZgXO6
	VTbvSL/UySJ2VwlDnEefUYAB7tM5M6eqgIgwSdgxCa0r+CSIv0Y45Skw2VnKmgG58LhvBbV
	/CE/cn4lCfR/sSruGfpSiHxkUqcG+/HBLAOsy8uziEHFVflQmwYW+jvJXA/UYux30wd/XzH
	e7J7A7KKMX3+6qG2hFSarlYBPu/sZUGqXQBNoJidtsV/USg1yLbY88/zUFKoYKYodBfKm3D
	E0HY7hstGmxJoinTqKChJUFJvG54IcsNJKjI9tpSv+k291iyyO8mrRzFvRNaGeX06Xh3KNK
	KcGBUXEr/+wcBGezherfUiHM4m1NnTPhdoavXHcnNEGEIvm3DULilYgWsopMClJ5OlrqYSr
	WIxf3KqE0zdLskADxXT/mM9gY5OhUkXrhxpU4FZTQsK0fH3s7ZUQjTcCflT8FR4d/eHUMCq
	T4RwebtnC4DQYrPKiZxtMQeuqQUEwPTfWXR9RDM0vgNXPoXXbOHCtubbgNFSnO9+UPX2IGV
	Bn+4CqWaNgnyvf0ZAei1lemC1CKcFGEaFH/IGudYvtcZ/GhWFKSHaHx0VH8T9pytxKGsh7W
	dDffWtzFqI8+s0x+XP1A9Xjl6iKftRJXYXp2HODM5fCpxfRMv/nh65TbxTxkEVchN95zkBB
	sCva8naBDKtZSwYPGvNtDwXQWJQxU5ZJ+BbqlQPF/5FXJ5JuekCsaK9LssL/AtleOOdRENl
	Ge3GURtpEcws+qQu5v6kR/xbvuw0KR9Hyx4/I8RMcq4au41QVkv1/CjKXNwZOyDromltRxu
	+g2usxlIXYB1HxzyD2l+DsiSVrqPbZfXW9+B57cGSTiRbF0BBjEKaZmveDyxXHWxg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.
FS2104 can deliver 2x15W into 4ohm BTL speaker loads,
FS2105S can deliver 2x30W into 8ohm BTL speaker loads.

Most functions have been built and tested on EVB boards:
ARMv8-A, Linux version 6.16.0-rc6-v8

v5 -> v6:
* patch#4
  - Fix warnings reported by kernel test robot (Mark Brown):
    warning: unused variable 'fs210x_of_match'
* patch#5
  - Sync the MAINTAINERS with the branch for-6.18 of upstream (Mark Brown)

v4 -> v5:
* patch#0
  - Update change logs of the cover letter
    Add the related reviewers after the change items
* patch#2
  - Add supplies(pvdd&dvdd) to section: required (Krzysztof)
* patch#5
  - Update MAINTAINERS for new files

v3 -> v4:
* patch#1
  - add reviewed-by Krzysztof
* patch#2
  - add reviewed-by Rob Herring
* patch#4
  - Fix warnings reported by clang-20(W=1): (kernel test robot)
    warnings: variable 'ret' is used uninitialized

v2 -> v3:
.../foursemi,fs2105s.yaml(patch 0002)
- Drop "schema for " in the patch subject (Krzysztof)
- Delete the description of the property reg (Krzysztof)
- Restore the property clocks to v1 (Krzysztof)
- Keep the same order as in list of properties (Krzysztof)

.../Kconfig(patch 0004)
- Fix warning reported by running checkpatch.pl (Krzysztof)
  Write the help of config symbol with at least 4 lines

.../fs210x.c/h(patch 0004)
- Update entries comment to C++ style (Mark Brown)
- Use linux/gpio/consumer.h instead of linux/of_gpio.h (Krzysztof)
- Use a private lock instead of a global one (Krzysztof)
- Delete driver version and log (Mark Brown)
- Drop checking of pval in fs210x_reg_read (Mark Brown)
- Drop most of the debug logs and unused codes (Mark Brown&Krzysztof)
- Drop registers dumping in monitor (Mark Brown)
- Use fsleep instead of usleep_range (Mark Brown)
- Update mixer to a standard control: (Mark Brown)
  PCM Playback Volume
- Add 2 new standard controls: (Mark Brown)
  DAC Mute Switch: Mute/Unmute
  DAC Fade Switch: Fade enable/disable
- Fix errors reported by mixer-test in mixer: (Mark Brown)
  Effect Scene
- Integrate the operation of reset(sdz) pin into chip init/reset (Mark Brown)
- Add DAPM event for playback: (Mark Brown)
  Start/stop device in DAPM instead of mute_stream
  Start/stop delay works in mute_stream only
- Drop use_pmdown_time in component driver for DAPM event
- Add dai ops startup: (Mark Brown)
  Report format&sample rates in constraints
- Add dai ops trigger: (Mark Brown)
  Start device in trigger when we can't obtain/control the bclk clock
- Use description words: PROVIDER, consumer (Mark Brown)
- Add a sysfs node for monitor period(fs210x->check_interval_ms) (Mark Brown)
- Do the initialisations of delayed works and clock in i2c probe (Mark Brown)
- Prevent new work after the device is suspended (Mark Brown)
- Update regmap cache type to MAPLE (Mark Brown)
  Define volatile registers
- Simplify the logic of getting and setting clock (Krzysztof)
- Simplify the logic of getting and setting reset gpio (Krzysztof)
- Use dev_err_probe for error logs (Krzysztof)
- Drop fs210x_parse_platdata and use fs210x_parse_dts in fs210x_init (Krzysztof)
- Drop null checking for regmap in i2c probe (Krzysztof)
- Drop the lock in i2c probe (Krzysztof)
- Add a suffix(instances id) to dai name
- Drop compatible of "foursemi,fs2104" (Krzysztof)
- Drop ifdef CONFIG_OF and of_match_ptr (Krzysztof)

v1 -> v2:
- Adjust the order of patches according to the dependency relationship (Krzysztof)
- Rename yaml file to foursemi,fs2105s.yaml (Krzysztof)
- Fix some properties and wrong definitions in foursemi,fs2105s.yaml: (Krzysztof)
  sdz-gpios -> reset->gpios
  fs,fwm-name -> firmware-name
  Delete fs,dai-name
- Drop "dt-bindings for" from subject (Krzysztof)
- Update the driver code according to the update of DT schema (Krzysztof)
- Fix warnings/errors reported by running checkpatch.pl --strict (Krzysztof)
- Fix warnings/errors reported by running make dt_bindings_check (Rob Herring)


Nick Li (5):
  dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor
    Co.,Ltd
  ASoC: dt-bindings: Add FS2104/5S audio amplifiers
  ASoC: codecs: Add library for FourSemi audio amplifiers
  ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
  MAINTAINERS: Add entry for FourSemi audio amplifiers

 .../bindings/sound/foursemi,fs2105s.yaml      |  101 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 sound/soc/codecs/Kconfig                      |   16 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/fs-amp-lib.c                 |  265 +++
 sound/soc/codecs/fs-amp-lib.h                 |  150 ++
 sound/soc/codecs/fs210x.c                     | 1583 +++++++++++++++++
 sound/soc/codecs/fs210x.h                     |   75 +
 9 files changed, 2204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


