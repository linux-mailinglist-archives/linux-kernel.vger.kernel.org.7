Return-Path: <linux-kernel+bounces-736843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FAB0A3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FF6A80358
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B22DA749;
	Fri, 18 Jul 2025 12:13:27 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791382D94AC;
	Fri, 18 Jul 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840807; cv=none; b=DOe9S3R0vtnwUNeRbvOKtTQ5x06XUaFSAGUTc4VPneR9/lOsbFNOjIEbjm82hi99LVzz0vOc/aDVQhu2bjDZNE7e0HitREdk3LYVSc9RdT8MFK0m5uegW82KLDjiyokdJZWlvgwUGqp+pMnaklVWtWZ3jaEaW/E7AaStyQ5P+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840807; c=relaxed/simple;
	bh=pBVPNWtVtjI1p15b6aP4VBROKwt8/S9Nf3f84zVndks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQgXe5xVzOtojYX/tP1e9ux+YCtx7U3kL1tt44GBgvi/jcrZoS09Rkcqe5uPIDHkDRHW82BP1lAVixDAr5Ba43WgqgK+m+Rh39DJ8XM40KucarObXfvLKicKbzgVjFicCK0cDx36y/BXvmmfqJJLkJeENtjMK4A884J3qZUeWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz21t1752840746tbf9757af
X-QQ-Originating-IP: PPIwgGEIBqM8YLEfeYXu6wN30F1EqE0P3vRzYxGbCRg=
Received: from localhost.localdomain ( [113.89.232.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 20:12:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18405222021285224978
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
Subject: [PATCH v3 0/4] ASoC: codecs: Add support for FourSemi FS2104/5S
Date: Fri, 18 Jul 2025 20:12:17 +0800
Message-Id: <20250718121221.76957-1-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MSxnj+21UW7c2box8nSMmFkFqSviLB2OK2heorGUCXGZsN8N1JNN2Djv
	IG0kffq/FBiT8ivJ8aJ0Lfuai5Btfh8fnSpRuYofzY/Hyk3SK0/8tuUwoPIuPldNBFJIGVK
	tAGyexJdRovdEWYrpfdvhNl/Pw9rBkcj7QAbcasmatxWkdStNQ3PIRDXF5HOjb6qIEIWJ7z
	0qVOGN/KO4apSLkv+DRul+czqlz2bhtX5SF+0ul3aW6oTFKGNUgtihj8t0XeJAWWfSHUs+1
	HHdo2xeYAfq8WK8cML1xVsrJ6aGeqqlj8zcF/NQ12Y7x80wBT+jvLjziRpVMu6VPoFB1iZA
	LtVAznAgbQyhcVMptPWhh5NQUD8H7oVg7TNNifx2c/dpf51VCdQHy4xAYLhowKsQI7ljrXO
	7/LI5WukjEQu7cG5QIOVzM9PhRiORXmygyG8/g+HCJQEBs0LqWTXznXE/lh/P5lyLYGBIr8
	mOPnDeelhlQy7diGPfJErAc0rjZbh7qq2oZiKcyIgx2/bMWn3zg8R1jeANdJ9SYLeUvoJcx
	ntWQDFdDXe6h2PH6eatN+JiJuGS2aZG2iMUfyj76spP5NUY1WcvUMD9IWEZvgv0JLcGDINy
	N1qo35S0yv+/i/T3hh024USIaiHKovQTBUkGa4oksjYQjLaV4KovvGIEOM3EJFlRgT1JBKz
	IcVjW6a2h+rB4HiMyG/AqCMYi3244hAjOOadpPh0bSkoD9R+0aqQJEQEW75dP1OKmLrNLvI
	GAbkNKfsfM14NgqFu4bxTrC7StR6XlLL0ZHV59j5Jrqa8og90IN4ME59f6o7Df+C0T+uV3G
	JsbxjyUtYoDQvWF8+FSHvP48rGJYN35O/p7G4p1GBcyDkDCcMCqooH80S+MyOtbSCoC5hLd
	WV//tVWk3k6ri1vAsmQS/oiBvgjk5iFJLpEWFiURph+4tUSzOcuz54FOucEJVdK4HbRg2Er
	w93JdgCMTGLgiFywTAXRLNdLJzCceafojkyQR3eEbDc8O95LcOSxzv7iqWWP7RN94M4B4vR
	K9KF4WiQ+Bhbwke3048uxHJbYJpRl3IR2NUBczCTNqG0AOdqYS8GKEtz2ebtlqFK0YfobG0
	Jj1HpxwT95FimzhSRb+BbJ0jboIc983jXzbrQLUBsVx9/uR5EzH924=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

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
- Use description words: PROVIDER, comsumer
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


Nick Li (4):
  dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor
    Co.,Ltd
  ASoC: dt-bindings: Add FS2104/5S audio amplifiers
  ASoC: codecs: Add library for FourSemi audio amplifiers
  ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver

 .../bindings/sound/foursemi,fs2105s.yaml      |   99 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/fs-amp-lib.c                 |  265 +++
 sound/soc/codecs/fs-amp-lib.h                 |  150 ++
 sound/soc/codecs/fs210x.c                     | 1574 +++++++++++++++++
 sound/soc/codecs/fs210x.h                     |   75 +
 8 files changed, 2183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h


base-commit: ed73a24357531e1747a6e140c329015da6429629
-- 
2.39.5


