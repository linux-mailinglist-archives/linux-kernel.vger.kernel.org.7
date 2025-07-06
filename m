Return-Path: <linux-kernel+bounces-711747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C969AEFED9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B604E4A519F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD927EFEC;
	Tue,  1 Jul 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZQAt6TtC"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAF2798FA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385726; cv=none; b=pBeP6WBcJ0dbmZFwmCwcEq2S08qPnLlILUrN8DYZA9UuarzVn9oXpf6bBEeztg1ZZrTypBVmI4B8Avw1cyYjJ1xqLKiJA3NYd9j1ynGM77GoSmUivBXWMGX6ae1CEjxHRANgQBu9NBRXZcG9kxE8Y8nthu46Kzq6VvoAR1bKCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385726; c=relaxed/simple;
	bh=yNpjB9RCPYu8yuSQ1YGzgp3ZJQQOJydTGLTUmWj3om8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=mP+hhxEllUUpep93WkUx/mYeWhspLVcgHBLmz7B700/A12a+bLJnZArsuag3YEvlzyFVzI3K2NQ5WYGiBRxrrr55UbpdqjUG+LMsWxAgfhw19mWPX1pPJhhXJTNxUOPcTWTcZSmymX+0jNxUYaxin3WCWMcjJGCdHNiZYFS5Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZQAt6TtC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250701160159euoutp023392d49cf0e9b9fc08ae58816ea0c9b1~OLAhg0c3e2669526695euoutp02N
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250701160159euoutp023392d49cf0e9b9fc08ae58816ea0c9b1~OLAhg0c3e2669526695euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751385719;
	bh=9Vo2d35sEyLP44uYKj+D2S0nhQkzl0XSExM9Iiwegts=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=ZQAt6TtCcCcETmRmK1KxRG1jJwEG0EuQyjwiykWb8sSRXP8GBB/b/mACARZxLX/R6
	 uv6xPXBY459Kz6XnfS/iNABH7koUEGgbMkT/g4Awrrsh3onJ7sKxylhXPUOp9l6ouQ
	 XPYCxGNi1zvRCx4TTRiadjtHSq1Tonk57CQ+m5Os=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250701160158eucas1p1402f4cb2ed2b4d0d672d47f5d3beb3d1~OLAgxb6Yb2273322733eucas1p14;
	Tue,  1 Jul 2025 16:01:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701160157eusmtip1c29a1b313849ae8a233003c533485342~OLAflrnya0876208762eusmtip1e;
	Tue,  1 Jul 2025 16:01:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 01 Jul 2025 18:01:38 +0200
Subject: [PATCH v6 1/8] pwm: Expose PWM_WFHWSIZE in public header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rust-next-pwm-working-fan-for-sending-v6-1-2710932f6f6b@samsung.com>
In-Reply-To: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Benno
	Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250701160158eucas1p1402f4cb2ed2b4d0d672d47f5d3beb3d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250701160158eucas1p1402f4cb2ed2b4d0d672d47f5d3beb3d1
X-EPHeader: CA
X-CMS-RootMailID: 20250701160158eucas1p1402f4cb2ed2b4d0d672d47f5d3beb3d1
References: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
	<CGME20250701160158eucas1p1402f4cb2ed2b4d0d672d47f5d3beb3d1@eucas1p1.samsung.com>

The WFHWSIZE constant defines the maximum size for the hardware-specific
waveform representation buffer. It is currently local to
drivers/pwm/core.c, which makes it inaccessible to external tools like
bindgen.

Move the constant to include/linux/pwm.h to make it part of the public
API. As part of this change, rename it to PWM_WFHWSIZE to follow
standard kernel conventions for namespacing macros in public headers.

This allows bindgen to automatically generate a corresponding constant
for the Rust PWM abstractions, ensuring the value remains synchronized
between the C core and Rust code and preventing future maintenance
issues.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/core.c  | 26 ++++++++++++--------------
 include/linux/pwm.h |  2 ++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b86f06ab2a324ac98115845f72d9386966a0a3b8..c1e8ab1a0945889d92dada003060b8b109f2a138 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -210,8 +210,6 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
 	return ret;
 }
 
-#define WFHWSIZE 20
-
 /**
  * pwm_round_waveform_might_sleep - Query hardware capabilities
  * Cannot be used in atomic context.
@@ -248,10 +246,10 @@ int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
 	struct pwm_waveform wf_req = *wf;
-	char wfhw[WFHWSIZE];
+	char wfhw[PWM_WFHWSIZE];
 	int ret_tohw, ret_fromhw;
 
-	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+	BUG_ON(PWM_WFHWSIZE < ops->sizeof_wfhw);
 
 	if (!pwmchip_supports_waveform(chip))
 		return -EOPNOTSUPP;
@@ -306,10 +304,10 @@ int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf
 {
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
-	char wfhw[WFHWSIZE];
+	char wfhw[PWM_WFHWSIZE];
 	int err;
 
-	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+	BUG_ON(PWM_WFHWSIZE < ops->sizeof_wfhw);
 
 	if (!pwmchip_supports_waveform(chip) || !ops->read_waveform)
 		return -EOPNOTSUPP;
@@ -334,11 +332,11 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 {
 	struct pwm_chip *chip = pwm->chip;
 	const struct pwm_ops *ops = chip->ops;
-	char wfhw[WFHWSIZE];
+	char wfhw[PWM_WFHWSIZE];
 	struct pwm_waveform wf_rounded;
 	int err, ret_tohw;
 
-	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+	BUG_ON(PWM_WFHWSIZE < ops->sizeof_wfhw);
 
 	if (!pwmchip_supports_waveform(chip))
 		return -EOPNOTSUPP;
@@ -650,9 +648,9 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 
 	if (pwmchip_supports_waveform(chip)) {
 		struct pwm_waveform wf;
-		char wfhw[WFHWSIZE];
+		char wfhw[PWM_WFHWSIZE];
 
-		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+		BUG_ON(PWM_WFHWSIZE < ops->sizeof_wfhw);
 
 		pwm_state2wf(state, &wf);
 
@@ -809,10 +807,10 @@ int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 		return -ENODEV;
 
 	if (pwmchip_supports_waveform(chip) && ops->read_waveform) {
-		char wfhw[WFHWSIZE];
+		char wfhw[PWM_WFHWSIZE];
 		struct pwm_waveform wf;
 
-		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+		BUG_ON(PWM_WFHWSIZE < ops->sizeof_wfhw);
 
 		ret = __pwm_read_waveform(chip, pwm, &wfhw);
 		if (ret)
@@ -1696,8 +1694,8 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 		    !ops->write_waveform)
 			return false;
 
-		if (WFHWSIZE < ops->sizeof_wfhw) {
-			dev_warn(pwmchip_parent(chip), "WFHWSIZE < %zu\n", ops->sizeof_wfhw);
+		if (PWM_WFHWSIZE < ops->sizeof_wfhw) {
+			dev_warn(pwmchip_parent(chip), "PWM_WFHWSIZE < %zu\n", ops->sizeof_wfhw);
 			return false;
 		}
 	} else {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2492c91452f9641881e9923e5a97e0705047da59..8cafc483db53addf95591d1ac74287532c0fa0ee 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -274,6 +274,8 @@ struct pwm_capture {
 	unsigned int duty_cycle;
 };
 
+#define PWM_WFHWSIZE 20
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM

-- 
2.34.1


