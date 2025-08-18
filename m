Return-Path: <linux-kernel+bounces-773297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC6B29DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604937A1CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320B30E0EF;
	Mon, 18 Aug 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qyOGGBP/"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425F30DD32;
	Mon, 18 Aug 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509337; cv=none; b=iVrWc/x3cskGWHbA2o2jg5hrQ4ax3PCg1mgqcXXIzwF7B95EZvc3f9GF2fQAvc+EgrTG5xe9GRBZKliwFph9Ws/m4nNvm5WYom8p+COcTlFKNZcq/m96OlaOgqmZtILvaNMw2/UNpN1vBqe00wvuopR54zi4xMgF1u5GhmbC4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509337; c=relaxed/simple;
	bh=Ix8rQX7j+Djeow/6d/c6nvq5oESHFJilL/KybCgSlgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OzgF2Ydgc4lDnLCiCbBj2Tj/jvLQVqqi39Oa9Mi2VMBAmA60vaYOV5EGVTPL0spE76hNoJvFnfoe0yFGmnqfXbkR3pf+BIZSUEn/UzHYY39nN7TIOrqB/NM7MdhuB+mmwm67b/wsyc3g72bzPZYB1UuLVq+dL3sTBKfuOHjp4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qyOGGBP/; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755509316;
	bh=9FmrJjqg/fw+am1I+fhbZiD9RUE7Ro4CHVIAUBMnukY=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=qyOGGBP/hn5Wk5FtT/1ScBM0oIM4LhRh9JCdpJGFECU+a5xiLhns/pItogFMKKDMC
	 rjg8T2fGKchIC/5XUmJgT27KeaCQABg8C8UEJXh2v58y5jNWMwZV7S2PIO6c+s+mAd
	 e0dVw07wrwwFEf6OkNSJDd6Xft9RLEYvOZozQjAA=
X-QQ-mid: zesmtpsz9t1755509309t6c580f51
X-QQ-Originating-IP: cKEs5s2CY18in1J6kPHzPGnr423fzsum8U+lBY0rnm4=
Received: from = ( [14.123.254.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 17:28:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12055654906655040144
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 0/3] clk: spacemit: fix i2s clock
Date: Mon, 18 Aug 2025 17:28:19 +0800
Message-Id: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPyomgC/3WNQQ6CMBBFr0Jm7ZC2lFRdeQ/DopYRJkAhLRIM4
 e5WEpcu30/e+xtECkwRrtkGgRaOPPoExSkD11rfEHKdGJRQpTgLjZ1E13fIKmJDnoKdk4FEZIS
 +EEljIblToCevR/deJW45zmN4HzeL/K6/ovlTXCQKNLVTJT006bq49exfax4n62jgOXfjANW+7
 x/sbrXMwwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509307; l=2086;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=Ix8rQX7j+Djeow/6d/c6nvq5oESHFJilL/KybCgSlgw=;
 b=aVYL6kUleE+B4XSTi5WfXl0yVT2LMvgB+NBhSsLqFhYKv/I7ewX5NwYNxGO+PiNQIR32slhyb
 LfpvAk33XQNDefyF9v2KUvgkSO5wVWUP0ih9HZ9ym8owffx6k/a6sC/
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N10XyoOyIIl0qJlBfOUj9zmUJS2acQKdoWHkIeHB89D6L77TxqFP9PQI
	GVVAa/vuyScHRIo7MQZfWaafsm1FUImiRzByDLoWufRA+kGFqVMogbpgMWA389Cmub+jrmx
	da5Uzddv1FHN8d+7WDH0HZ4qxgHvfHN4cxDB2jGUHLlSx+JrKbfr99uQpJEPshtSlMhu3ez
	cw+WHmcoUS4yQxHQhiUYpRGW6X+Nh1kQvATA3Y2u3pHIl7f9veyZdFDMOtsUQnFzRM3vhiL
	UwE8MUWHA7/54f8q7OkmF/YU/pn0pxi3JZsYJC0/vaKZGrXfaGHWmU4L4u0vqQAvv/aeOi/
	TDpYn2nPWSvbpPJcDLZpI9+4WOO6ZyJ15gs+3wXio3STmN+a7BeplBh9Cnb5HTPaxuUV73X
	aW2x6lLz53SCNxaaXSSse5ENaE26vaR7lr5NxB5bJcyqvDhJuyJqiKmEh5c86+A6dvc/2ub
	Nj1+IXr/rYYzQa1FJ61Wl3PJfR6w9Y+CeqRZKoJKDELuoDDp8PNUSDfLkIv3iXZCoxraXen
	tGfyjT0UWWS+Vh9LeVd+jzgni6GvExYjGemCOqarARS0fnjgTpO824hfv4ZKHFB3j3GmwWC
	xNXSg1W52wvmvpueeR+ruM66yt5mmdV/jrDxUIRcXOFfm17Vaj4R6Wt8YMKAIgze6fQLgUj
	m649Knag/3vTuNTJbpUKAVJaaMZfN6+1bcIjOkiR31p6eIZcID1Y0bNMlPHJyvSsppUdUmN
	1pxTdoe9z7IxMTmfwZWKEg/F8VkdSyuIZZYjRkygmmTjYQyJmMycMJvdIFx/0rA0xIWFAcI
	nWCWhGnjzBfMnPZfAnsB6MZiMW4dAySf1cgR9LnkJxDiUyOFQbMwKRJlCCPMhSPB5IFdIIP
	6VDHQz7ZsLTqghc8tUtywkwgNyVC9lfrTzWNfYD44mmazZBGpEZpdXrZ4wH8F7X5pAZLCq8
	cgx3gtbAI3dr0HTbmyerumMsBrMU2tPh0hNc7iSGKrjX1pjj42man2wVkxLd7cHQmOZzxno
	eN2alJqpcmBbNdRuj9p+FPx2ewSmWQrIsDurtTYlCkQvqifG8dAi+anQ05QGoWEfXdNrCM0
	1j0FzcEyXgd6HmGAFal/RM3j9m07fKayxJxtAuJDBHrM7BnVyux5ZNUJGEmSfcAFQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

 drivers/clk/spacemit/ccu-k1.c                  | 33 ++++++++++++++++++++++----
 drivers/clk/spacemit/ccu_ddn.c                 | 12 +++++-----
 drivers/clk/spacemit/ccu_ddn.h                 |  6 +++--
 drivers/clk/spacemit/ccu_mix.h                 |  2 +-
 include/dt-bindings/clock/spacemit,k1-syscon.h |  4 ++++
 include/soc/spacemit/k1-syscon.h               |  1 +
 6 files changed, 45 insertions(+), 13 deletions(-)
---
base-commit: e3324912fe5a05a3ea439df476625e7c8efc2b9a
change-id: 20250804-k1-clk-i2s-generation-eee7049ee17a

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


