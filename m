Return-Path: <linux-kernel+bounces-740391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE0B0D3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B41605E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160F2C159F;
	Tue, 22 Jul 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="eKmk7hNG"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC728C5BD;
	Tue, 22 Jul 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169850; cv=none; b=VQ4E9MH0avKqqQcOKsjt1xAi/pPVpJGS75ke2rn1+muYI9lVYvp97B4lj/1u5oHMxvhQNHSXD1mbWZB6joEKYtWWQLGcV13SAvtXI1Ms/tiT2nQwfZwRU6P77LdqcjkdHFfPCt5Q5diTOTdaWRV43x2F067qknlTMz0CxjwgH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169850; c=relaxed/simple;
	bh=1EK2TQsFCA6A4Rh5b5WVVEqCK3IkUuA1s0DimdzqhBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=doPnOhoPYSb6/7vEPHT49zhPPqG69FB5ruj9qBpOF3AYte7La1Yl9l7S23C1fF2mKxd2X28hBD4c59og2JY7YH6nNiS4GjKXeWrmPYit/bYCRb+3+L2gn0vmLn4npIhIoLUiajvEUVSgWcluuGbsCIpYq7Fro8bkYr1ytikG5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=eKmk7hNG; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753169829;
	bh=pQ0rrp8kQpeiLV2GXPkNYYVhyLLgxjuHpx2u2oAf54o=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=eKmk7hNG47wZhbqGZY7NRR0pJ6Yd6akWfuxo5X83Cn0Rxtn/eXnub3S5PzQ8+vWyJ
	 Bq42S/qdNGz4qgU0n5mjnbK0L3mx3dI2I8DOaPrmtOuDYlYhBQt8jzMtDm7rASzDX3
	 JJ/Q/KZr4RKGanHXYsV/T8zxdnXWyUo015jxrJvI=
X-QQ-mid: esmtpsz20t1753169822t9cc06cca
X-QQ-Originating-IP: o/6alvnXRlytoxVwMjxbpu188hGl4Y8IZ2m7pvs1yY8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:36:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3472028324407458743
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 0/2] clk: spacemit: fix sspax_clk
Date: Tue, 22 Jul 2025 15:36:29 +0800
Message-Id: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0/f2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3WxD3eScbN1Mo2LdVBMjc6M0wzRLQ9MkJaCGgqLUtMwKsGHRsbW
 1ADGwC4pcAAAA
X-Change-ID: 20250717-k1-clk-i2s-e4272f1f915b
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753169819; l=1511;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=1EK2TQsFCA6A4Rh5b5WVVEqCK3IkUuA1s0DimdzqhBc=;
 b=CTQULKaJ7/EjE652+6Wzwt9+vLnkF0x+lT+4hZ+GRPFNvj6L07fYzAjrjnWRajGOzpU/Xx05C
 VFmJL1uAPltA3TPbGZ8DBw0dpsEJhVQKGmbHAqDsmGLU0W7P6pUmkXa
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NnnkygtrMG+qS7QcHiAl5iHK/Y1OfqDGRj8gmtLCwp2AmEnynzPU6haR
	z9Ru1tshzE5Mb83G+R2EKp5EAQf5PVzHqNClkeOu30PAwJYTrr6/0LNbgSH7ivXpHPsyhwQ
	87x5is0SCWhzsnNLbpoJM0ouQptazQrXcxMgKF48DKgaCCkkuGIt3s1126Bw+1xslscy9QS
	OpQIWP4xqEjcuTtg4D54fE4yBduGC4UjtY6vrQ5A+l6pKoIot0YNY6CVGI2GtxPDIccQqGF
	u83jIPiDOBJd2Lafq/T8KyhANoIxzKRKGuTfRtvqCUXm+gky1NOPNkrUYgUgb0JiSsseFSr
	TyiNeZUG6JFZwdD3dkiMRpct7CV3sSGHq0BbrbrI0Aj62ceMea7Xt/cyc1oCkcLKCoUPN+0
	KWTY7l0CnM2gzWTAntgShCtfhqZCj2Pk6dvsejx6oAg0I2hV4Kt/3Y93P6xmyUYczDbk6nM
	QodZaQLt1KaZVSxFTYIIN1/hS9XZ37e/7kqonPLrl6H52KD5aAM6lfdPsMz4+YOEfRLxeBs
	LKo0SE9C+oH/llt1F5U7VJh+UzFV/p33DQAmCK0GFSXOrdyPe022dTNuwEnu9SeQtEzL9F0
	SkLmz9rIUI7Yf9zcXXjcQkXGkmR0l45cK4E1amgyqXEO86uAyPdJyXVIOteLBoRTwux9YFz
	1HgDjUyj5fM/FbYCRyuFzARdZzWlMGKGL+5/Np8a5cJHv8AUT1VcCXouFRyNBAtJP02ZMPd
	Z36N5fW3gOEnQ/ykt/nTlVkhXok8yyQMok4brRsD5Q6F8npZm3+GowFecPZy/+rn4ro7OgA
	jR2sWeIGUNbqwqLnDGzjwwj+WlMV++hZevVPKOE42y1+NytaQPTp3NmCn5UwkgB/SPLoBfu
	NKQIH4/A5J9owlr2MI0FJQd5reii9xV0nuj43RSepmIsycPaqcVO7PN9XKf+6lLrNYk2Xt6
	Qd7Lnmbb8jmaBM83aM2hHW9jCaMb1VgKc/LP6IBZZowNtGMdiFlRHps6xMME4iJiluJr304
	fLi0ExAPrxmI6cGjehTCxbdYDu1+PH6gt6hzYnqrJoPSl6W5yami5ZiURoCmkHqXSxjjaba
	Rm0ywG3Q48x1n2AFQwKW6NNl9gaOlL7CQNe3sU/t229
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In the SpacemiT public document, when the FNCLKSEL field of
the APBC_SSPAX_CLK_RST register is 7 (3'b111),
which is a reserved value. And BIT3 of the same register is
a reserved bit.

But the documentation is incorrect. In reality, the value 7 (3'b111)
of FNCLKSEL is not reserved. Instead, it indicates that i2s_bclk is
selected as the parent clock. Similarly, bit 3 is not reserved either.
When FNCLKSEL is set to 7, bit 3 determines whether i2s_bclk is actually
enabled as the parent clock.

In all other cases (i.e., when FNCLKSEL is not 7), bit 3 has no effect.

Importantly, whenever FNCLKSEL is set to 7, bit 3 must also be set to 1,
otherwise the selection of i2s_bclk becomes invalid.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Change log in v2:
  - Use dummy gate instead of new function for sspa
  - Add Suggested-by tag: Yao Zi
  - Add Fixes tag
  - Link to v1: https://lore.kernel.org/all/20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com/

---
Troy Mitchell (2):
      clk: spacemit: fix sspax_clk
      dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA

 drivers/clk/spacemit/ccu-k1.c                  |  25 +++++-
 include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
 2 files changed, 79 insertions(+), 60 deletions(-)
---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


