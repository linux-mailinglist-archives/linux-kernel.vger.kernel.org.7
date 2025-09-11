Return-Path: <linux-kernel+bounces-811294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E5B52714
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E837B6EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFD248F69;
	Thu, 11 Sep 2025 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ESPUOSDc"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55C23D7ED;
	Thu, 11 Sep 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561692; cv=none; b=bqo3UtKbcrUyIqHmZ0kkYNtYXnXT6qh1VaDr1qbMFmNo9Uto54s/16KIiPRWZ0+41zQZheieGWORr3BEsT+M29sztQR2wzEIyXRN6YYcp2NgpXLBzDLUJ4Fcsdl/p2/ryg1MnpKfwi45+6PlScsMoJ/LiZhtOYS9q+bFx+qC7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561692; c=relaxed/simple;
	bh=SNF4Ar7l5ETepgrEt9Tdj64fl7ZYHb5tuOdDXioZJkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aFLE+U9fL3X962S3rNsrMJyd6PXTDONLSTGs7g94bhJ5l0Krj8B+V1+sgf2rewuxg8zsfy026dWgA22l+z8dnyAq06zyKbe2waMhLLyUwTw8U2Cwy1mpHnsB+81MTrIee8qkDUPDI5yt7ce0j+2WjyPbMp1jyZElkD04H88wvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ESPUOSDc; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757561654;
	bh=2utoiyW6erBlq4zsT91AaE+a5OP/Nh3b79cTCxZ9ax4=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=ESPUOSDc1rmLoj3wZjIDzUoLsBgV9tERSoBeJndb1r9Eq+8xN0qwwRxBCIjXWhPE0
	 OfI3NOBmE86c66sdTkYnOCpt7hCahQjlQkXpidwfaL+mSalcQP6mdXpdbW/slkc1+J
	 e4iTNJaroaA7XS+aUTul1rJv6IsFmScdAcVpDUK4=
X-QQ-mid: zesmtpsz7t1757561647t366c31f6
X-QQ-Originating-IP: d8qjj0eJlWiNFsCVgMt96ZLpG7+Y4mEGway5wqCSaxA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 11:34:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10692195372425010115
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH RESEND v4 0/3] clk: spacemit: fix i2s clock
Date: Thu, 11 Sep 2025 11:34:02 +0800
Message-Id: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpDwmgC/3XOMW/CMBAF4L+CPGNkO4ecMDHA2qGMVQfHfoVTI
 EF2iKhQ/ntNxMDQjO9O77t7iITISGKzeIiIgRN3bQ60XAh/cu0RkkPOwiizVqUi2Wjpz41kk+Q
 RLaLrc0MCsIoqQFsncvca8cP3yf0Sn/vD/mMnvvP8xKnv4u90btDT9iXbGXnQUkkbvFmjJlAot
 mdub/dVujqPC/cr310meijeOF3OcUXmSl1UtTEu/1zNcvTOVXMcPTmlLSEERaj/5cZx/AMVQi1
 DaQEAAA==
X-Change-ID: 20250804-k1-clk-i2s-generation-eee7049ee17a
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757561644; l=2351;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=SNF4Ar7l5ETepgrEt9Tdj64fl7ZYHb5tuOdDXioZJkA=;
 b=x7NrYgZy0INESJO4u4DkM9OXnGiX7emJ8ezFJxaZXuGZGIjmJfDhEjoF8OzvKmgD0mkgrL2K2
 w+aFZZoGAOfAlF1PoaGjZxqpmTJ15SzK99io/PWyBDSh8wTuqM0E0zO
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Nc4Sv39/e83W4tor1UZ0MMb8rHohoQIkO/PZxIF/hP22FLHzLwvY8gkg
	GI8IMiWW42Ojn4a3qF+6io5aQAXnpuVKLlCXPsjL6PgbjOvRKWnneX93NIVPq5BgrSCEnkq
	Vw/CoiyhigppgcyVpc0tV9/NgxX6inItd0XhctDDGWZGT4QGLLzYwpC/p1v2mAjXsFafZJS
	6Ru6jP5A/iyirHxTXuDnucW33lXup9xs2cmYDQnhoMIxjTKTw0un55mURnp9w1ZlceOo03D
	b66QfOV+TqRpptGA27xsuO79bUD317KCiFUkUg9T48SzT7JQ+x7/gIkTZ7gT+Eid4h9RttH
	oTYo9f9U1cu0RfI8/js2AiQzQT9+nLs7FCYvnc+85xA+OubECnu/ZCOLXpmGIfi+cjGxU4T
	w3EWlhIG+miDNWkS0Dam0UDY8T0aZAlik+sjOafvKcAMF7H3qwxefq6P56Xrk/s3PE1uLYJ
	IKQbGLGRLFxW49/oLCxninHCWLmpDCtMyrolrUvIfwty0wzfCCQ9y7Dz1QkkCSaglAUgpVn
	5Nfz93M2GKuhBq9ijP7gPknDpgVsijp0GpQqDERvCPtECQ8N8Qq2VZe3m49r146UW7f9QCY
	joLwJavKjf5MKgnQLlH7CERb0KopviVGBKhyqZ7E6LRKnjSfvj49n5CRSEqcHde3UfjQU8Q
	KFkDS6TzLmSCXQL19gVDNAP8vHp1tz9UJsb/NzZZymrG6MZYSq23AyNMxndwgy5Kw2H/js2
	iboLZlSbOZuarCHNWT9Iews7jI42e127L8KlUwf4MJ48paAEhTUt+KB2sHiS5HEfuk4yQo6
	uAKyrDc9g2ZjCC62JArCXbLXoTY45OfZOJw7OYCr2yfaPtOvgnKe0GN7ZM5AFENkbrInymu
	lahCRUOyix3jo1Ng87xyBfExwKRUkHAxkuGwj38AwLuAt3PufS8kx+7FZVD95wtcZgdMrOP
	HhG1yyE2nLMp41dOGNIhNIrKokxfFqGiu+cOq2GWXazj8h2cx/Z7YeijqSYuqFUHTszFj95
	zwuGkQWW3SUsTmkRJbhJrkEo7oN2MrvNSmiTomnVGHKyQYRCDdgPn9pA2vweoxPpbweFhxX
	jps3uprY1Kw7XvXTlE1dIE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Previously, the driver defined two clocks for the I2S controller:
i2s_bclk and its parent i2s_sysclk.

Both i2s_bclk and i2s_sysclk were treated as fixed-rate clocks,
which clearly does not reflect the practical requirements for I2S operation.

Additionally, the original driver overlooked some upstream clock sources.

To fix the I2S clock, this series also introduces several new clock definition macros.

The I2S clock hierarchy can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Since v4 of this series has not received any comments for a while,
I'm resending the patchset.
---

Changes in v4:
- drop the erroneous change in ccu_mix.h(patch3/3)
- modify comment
- modify commit msg
- Link to v3: https://lore.kernel.org/r/20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com

Changes in v3:
- remove factor for CCU_DIV_GATE_DEFINE
- introduce I2S_BCLK_FACTOR as I2S_BCLK parent clock
- adjust consumers in patch2/3
- Link to v2: https://lore.kernel.org/all/20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com/

Changes in v2:
- remove CCU_DDN_GATE_DEFINE
- remove CCU_DIV_TABLE_GATE_DEFINE
- move gate of i2s_sysclk from DDN to MUX
- introduce factor for CCU_DIV_GATE_DEFINE
- modify commit message
- split patch2/2 into separate patches
- remove reformatting in k1-syscon.h
- Link to v1: https://lore.kernel.org/r/20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com

---
Troy Mitchell (3):
      dt-bindings: clock: spacemit: introduce i2s pre-clock to fix i2s clock
      clk: spacemit: introduce pre-div for ddn clock
      clk: spacemit: fix i2s clock

 drivers/clk/spacemit/ccu-k1.c                  | 32 ++++++++++++++++++++++----
 drivers/clk/spacemit/ccu_ddn.c                 | 12 +++++-----
 drivers/clk/spacemit/ccu_ddn.h                 |  6 +++--
 include/dt-bindings/clock/spacemit,k1-syscon.h |  4 ++++
 include/soc/spacemit/k1-syscon.h               |  1 +
 5 files changed, 43 insertions(+), 12 deletions(-)
---
base-commit: e3324912fe5a05a3ea439df476625e7c8efc2b9a
change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


