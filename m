Return-Path: <linux-kernel+bounces-742161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED132B0EE20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F7E1891B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA0286880;
	Wed, 23 Jul 2025 09:10:36 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722C284B59;
	Wed, 23 Jul 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261836; cv=none; b=ilygEQtikE8KpD8gJY/fLdT5M8cjjyUrHgyhtcd3wjuypTGDCPPvKiuTAZIlgXefR7y1whgigNzusQCl8X2+LdtMtJU4KDW7SpPU43ZYfKbTuwX8hQ9Uv3uqEpofNn1riWb6BGPIqovHLr4MA5oCtYHiuRhURR2YiQRarKWb8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261836; c=relaxed/simple;
	bh=Hrbi2C+hTff4G+83NVvHms4IBIh/TN74PB4fHmkevs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgJhxQgditvF/e1UnpN/8rGzWom7pjN/3C+DUPpYM/Gid17L9Aa+iLKm++idPP/Bw1jN3Pp1/spX/qGgCj4TYgEraAZUbs5sV4sJWNV0JzcvuxMHp6O+VBZVDRa3t+KgfBhlBSayAJXe/pnFbj3MXzPaNT8kQL0mw4x8LMuPMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz5t1753261780tbeaa28bf
X-QQ-Originating-IP: awkAxcCUL62rHzR5gGKIYUznmEvNu7djrobXMgCqJlI=
Received: from localhost.localdomain ( [183.17.231.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 17:09:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12639370633705829095
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
Subject: [PATCH v5 0/5] ASoC: codecs: Add support for FourSemi FS2104/5S
Date: Wed, 23 Jul 2025 17:09:29 +0800
Message-Id: <20250723090934.480055-1-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MWUTOgANNX2v5REthzLHOJvFnArKB3OrCalxwUeegP1ZLQk83bmao/ha
	EYctkYMATN+9gxB3u6AEjThItm/MlSXX8QmOEv5DQt4GF9WrArfBo7osYq+rnfCWd7NVp2R
	JoUCJkuQncAFp2Pmn/n9iDnHK1l7M7Bi1gUdOq+qtoOf4cw29kD3M2drz6y5v/iA9UVGMQj
	bfACODo6rZ7R8MoFTli+thMhAcJSRSj6M38khbKOaW+O3DlpJ/srOAOoX3Rb0X8xcTk3EVa
	WC11KHiOIiHDAYBp+RZ9wBJqsilL33itNc/lO56FmoipFJ7w/9wjWcGsVOrhIDyaDPLoiMW
	JE3TiyenHcqV0vudJnShAY/N8wZynQ2a6ch2/QE8o9NQXUEN00KAAVmleXbX8kslMIUHuXU
	EWQ4dvczWttf/dC1Z3CRqoZPMmEmtgYMImYIYxoGRwYI+JiIIirm0goN3bn8VZQlOoN+dZy
	aHOwtspXcyeKNVrEbwmhQoMIqVuBl+66p+2ggguCPlCiCj0RX1lWgroRjPTlHZPbXYGhfRq
	mpUVKND3SuGSbhVqezMjZ2kYvBHDZvBSYNbQ0VLwrJVvlP3FaC+tGGHgTuTaUfV1gK330jl
	EBLIDEtkGkas2Y4fjTbV4AAOm/o+q+w1NJpwwPibGwsWVDiyUQ/S0sZM13D5AqEGKiXh1fa
	z8M8fynaObHnzIrnMjwtIJkVR0q5vUb83YMS9VosMKV9Bq0/NOENoS1rCwulcucMa5qiMzL
	D3ZK0skq4/zK7SC2fWWN5rbgLwPaRsPx3p1qLyMpwRf4ZyCYay+u6c3ILf74mYcN7Y2j96I
	dJwkul3OrJHCrCrq2moRTqtgB034/HwbjyJR+uc9r/v30MKrMiJkXq1d+5wOYSBiuj5EFOg
	N5fnOzxqsbTH3fpUqR4afS43dntovm3vlzNVtdXjx4JBctDFG4Wqsx4tZmBBE+Uzm7vIhda
	6ZXFmbOixKeSwgrwGOv4xI6G1fDMCBMtjcvolP2EZ4AzhjdOwvgLjTusCFBac8t77imzL4o
	FNgRJGVvCTkOILATcGTcpOhdPAzn+Tiy/Y7KgQAMBsQe2uT93CwWn1j/R3c+vqSz6ZvcaW1
	iV6ctsVP/SWoxriHb4VG3s=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing
FS2104 can deliver 2x15W into 4ohm BTL speaker loads,
FS2105S can deliver 2x30W into 8ohm BTL speaker loads.

Most functions have been built and tested on EVB boards:
ARMv8-A, Linux version 6.16.0-rc6-v8

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


