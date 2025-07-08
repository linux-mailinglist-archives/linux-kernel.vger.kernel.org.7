Return-Path: <linux-kernel+bounces-721468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0CAFC99B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393F8188DAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5CD2D373A;
	Tue,  8 Jul 2025 11:31:07 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AB13633F;
	Tue,  8 Jul 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974267; cv=none; b=ahN1GzR8arqI9VOvRh0pCRzr36P8pc30lQaxaMIUngElYgZKXM52W4iW5tohJyVJFiQ7VYXqMOk3KxX0K6URWuiS26UbAhpK2DjgEIA+1qkWp4XG85ZyHI/q3s0jG8XbR07BudcoQXViiShqaYRikbnZMEbZjG2KvlKoh6ayc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974267; c=relaxed/simple;
	bh=LymYIJme+Ez7oZqlzVtyvBtsCMJq0OBfvyJ1HduLZ5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RPsdwNgKpU9kpH3rYfez9WU4Uei51rO2ibbvMkUVVgZ7lHxOT6UnIMgn/GUGbZNX2GEcBsukTFjp8Q9mXYOMRtba74xIMIsN50lyBGooYo6p6yxj1ZsmcUQFOY2D0x6+w0gVcmzKXPx6EzCvwC2jezfnL+L6cmPrdauU9CwUj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz15t1751974215t776b0db9
X-QQ-Originating-IP: IaXggDYYqP4Q+bo1yopKjjWstnZmfwYr2RBD4mHcO4k=
Received: from localhost.localdomain ( [113.89.234.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 19:30:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5261513458296798822
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
Subject: [PATCH v2 0/4] ASoC: codecs: Add support for FourSemi FS2104/5S
Date: Tue,  8 Jul 2025 19:28:57 +0800
Message-Id: <20250708112901.25228-1-nick.li@foursemi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250703035639.7252-1-nick.li@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OOYO4i1Nbl+Hws7b/EIM4tPr+420ZeHrGAyXQnDs6gGBRfl5c6cIfJZu
	5g077LgB6WiyPyQNnSEsJe/6CZ+r6VE9crSdlooBuLR2g4XlMToc17jCCf1BUkLik8NDrOb
	9WJRLbcML1BuqG7mFWTV5CHZ/Wg7yiNSgyc5IO9pzbXZHOFui4poj8VCuaK8qZbMxfgSPJg
	EKJkSviMntvZ2z22Vgouq7EuUZVlbRrUCGWLMi9GUNSAbCF0dQYeSOICFcbeZyqatibU4Pd
	AXTQMTwc1UX/o40dOtbRRDWNPuKaAG8CMvLUoeVnqUQ0ZzKx7BGHroCVxU6Caf4tl4OH/PD
	X/Zfe1kYBZDQ5wgA/bgZzPfn2o2URnsynBQsVg2xjsqZ6PTlP66lnf+CUYM8quYg8PU4RJq
	dQOsOQ/mKNXtHS8iO9NF+K2ETKDLRyogkkvxfx4qEKsrAVu0yr7CUSGN4qVIwN1TMyLr9Gj
	X+rokINwaouoxcjuF1GjIbu5l/js+4nfdn/7lrBrYZ3cnjxF4gAUx5HhwDBuaaonFB4j+4w
	Fu9t794d0XnxVM/emWEjN7UIX7pXRi8otw3RgWhf1aXe0F85fkM6gf7IpMgpvgNOAJfscBy
	yL8rRSs9yMGfIXSPY5xansC7NmxpRQXF2jpBjoAYXwwzwNSvYt5YM1Ke/P2hJVTzYSNGu3+
	XWfUq2kmnecMx2In6d3rUTqibJ7fAcZgfKYgpD5XdmmgVrOt2YM+WhVg9hn5iklc/pa91Kp
	W+rOoBwuFuayf2bDur4R0gP5HN8YWdyVn2OJ++2f5Qm55JIMkKso3CZ8d41H1x+ajPa2hQ0
	idXCxLxelrrmnXiiLYA1bnH6eX+3nkfwH47kMgF+d1YWYO2guQrY+w1y6pbDfMb0G8CKfsa
	t53zEerORfi8fVvijwWscOZsiEVxUM6R0xhUODqOJs/18t/wS1XGaOWFFUnKOQvBXpcL86n
	Wt16zWHGEnxjmMsy7eh8of8V2km2fnu8ktXOzpCL3Lx4TjEZ/G0OyxhS3K8kNl01pH/NVMN
	o09REVduwUiw0+TVaxZirK95I86Be7voqE2UiNAMo6v9xKBmegs+OWY+0Y2LYakXbbwebhd
	huWDeY4AS1N
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing
FS2104 can deliver 2x15W into 4ohm BTL speaker loads,
FS2105S can deliver 2x30W into 8ohm BTL speaker loads.

Most functions have been built and tested on EVB boards:
ARMv8-A, Linux version 6.16.0-rc4-v8

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
  ASoC: dt-bindings: Add schema for FS2104/5S audio amplifiers
  ASoC: codecs: Add library for FourSemi audio amplifiers
  ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver

 .../bindings/sound/foursemi,fs2105s.yaml      |  100 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/fs-amp-lib.c                 |  265 +++
 sound/soc/codecs/fs-amp-lib.h                 |  150 ++
 sound/soc/codecs/fs210x.c                     | 1610 +++++++++++++++++
 sound/soc/codecs/fs210x.h                     |   79 +
 8 files changed, 2224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h


base-commit: 870bd70790beeaff6ef016aece922e540675836e
-- 
2.17.1


