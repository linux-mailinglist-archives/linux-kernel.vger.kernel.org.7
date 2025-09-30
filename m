Return-Path: <linux-kernel+bounces-837644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFEDBACD27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C34B16B332
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887D25228B;
	Tue, 30 Sep 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H0a4/G8R"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BB22332E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235255; cv=none; b=JcqGVowXE3vxpqaGtBrVUvSCQawygBTD7dtfQwxbZplApwp+bQ9pJNspRCmeLDtlenV5L8ifZVYO9ttbouQiIaVTjc85rLl9q485narNiSCj96hkubVyuLiXDVlWbGfsyKsFVHJW4IDmzznxZtka5gDHd89j5wzaLe2dTcGcfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235255; c=relaxed/simple;
	bh=OsXGZpjhn/bcvoR4nyicnkd/6UvKt5+0TaTkZnyK7gw=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Ibi73VgA+TW/y6uS+wPHM3j0kKG2wZi+ZWKl1OL+k6CCgL5tJJ431u+TMZ6V+aIjlWLGg1Pdix8rsFQ0NYDS2XycM0hro7LAQNTRvi4bO/Izd+YbFucQDmdoRBhoTOpvV4fbvNuTLzDAfQ6pOF1O7XDdqJYeqnOQmGcKdt8wtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H0a4/G8R; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250930122731euoutp02147e0e1d036ad74c5ca937bb38a074e0~qDyPwSli62140121401euoutp028
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250930122731euoutp02147e0e1d036ad74c5ca937bb38a074e0~qDyPwSli62140121401euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759235251;
	bh=Zaf3CvVE7vDNtuforIU/AX8V1l2za6jRnyAi7V9DPZE=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=H0a4/G8R3TYJ0AuMPhinlZLL2iloUNBh4BJiKfvjzTC7u1U96akSK88N8nbvnh5Lx
	 KwjVf0MN+ayfhJUcYvNdHbLffJUHD9jXCPfD0OiunkBUVBidc6e70/tcHvJR+1jiZm
	 uQhPCuTcLLN27p/zQeQayk/BjjTjcdSoXjMrcUVk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250930122730eucas1p11afe23eee92daac1023a826768b1f92d~qDyPOjAV12445224452eucas1p1h;
	Tue, 30 Sep 2025 12:27:30 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250930122729eusmtip2ae44be48f37c522de1ee16749443ad86~qDyOH45bz2176221762eusmtip2L;
	Tue, 30 Sep 2025 12:27:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 30 Sep 2025 14:20:32 +0200
Subject: [PATCH v15 1/7] pwm: Export `pwmchip_release` for external use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-rust-next-pwm-working-fan-for-sending-v15-1-5661c3090877@samsung.com>
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
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
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>,  Benno Lossin
	<lossin@kernel.org>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250930122730eucas1p11afe23eee92daac1023a826768b1f92d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250930122730eucas1p11afe23eee92daac1023a826768b1f92d
X-EPHeader: CA
X-CMS-RootMailID: 20250930122730eucas1p11afe23eee92daac1023a826768b1f92d
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
	<CGME20250930122730eucas1p11afe23eee92daac1023a826768b1f92d@eucas1p1.samsung.com>

The upcoming Rust abstraction layer for the PWM subsystem uses a custom
`dev->release` handler to safely manage the lifetime of its driver
data.

To prevent leaking the memory of the `struct pwm_chip` (allocated by
`pwmchip_alloc`), this custom handler must also call the original
`pwmchip_release` function to complete the cleanup.

Make `pwmchip_release` a global, exported function so that it can be
called from the Rust FFI bridge. This involves removing the `static`
keyword, adding a prototype to the public header, and exporting the
symbol.

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/core.c  | 3 ++-
 include/linux/pwm.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0d66376a83ec350e0c3718959f4d794efd71595a..a33da3dff608fdff91251e5fd07b0dbd295be022 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1600,12 +1600,13 @@ void pwmchip_put(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_put);
 
-static void pwmchip_release(struct device *pwmchip_dev)
+void pwmchip_release(struct device *pwmchip_dev)
 {
 	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 
 	kfree(chip);
 }
+EXPORT_SYMBOL_GPL(pwmchip_release);
 
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cafc483db53addf95591d1ac74287532c0fa0ee..d86061024b52172edf3845bf9252a966f120e365 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -485,6 +485,12 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
 
+/*
+ * For FFI wrapper use only:
+ * The Rust PWM abstraction needs this to properly free the pwm_chip.
+ */
+void pwmchip_release(struct device *dev);
+
 int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
 #define devm_pwmchip_add(dev, chip) __devm_pwmchip_add(dev, chip, THIS_MODULE)
 

-- 
2.34.1


