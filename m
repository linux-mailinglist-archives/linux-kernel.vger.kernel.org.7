Return-Path: <linux-kernel+bounces-893039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA923C4667B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A553BCEC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A13081C5;
	Mon, 10 Nov 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kY7ctgAR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pRC4uOmz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF22FE585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775811; cv=none; b=Jd2YqEh4JUKcVHLWlAx/Qg/uAYb/FKXcAd1XTOHgIPoPD5Z853ydVQ0DLGpzuCVsnMAWwJokml0zA+nPmExOC34SSpG3ekg2GMwq3R1IDN5fDestfIrgYp+Vj2mGO0S+888sE62T8J6h4ygmzymHTPVi9Slvwk3XPLtN292P2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775811; c=relaxed/simple;
	bh=HxHsjc+P+REkvmdbWcZldA6yaRA3i5VZ1XGKbPUnJQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y0I7fDMifXkIw/cRjvM5DYtrsemed5bz+aPUXurNB4LWOhNWmTm2ynU2ZaS6GM4f2RlwRer/VwhLvq3Mh2wRIEY0c36A7BZc9dkUt34sIRcoZYy8A3heGr3zBD+JeTiXPxVmV5GG5khsJJpySlg0FRKqsswAacVm6kHOvEF4q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kY7ctgAR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pRC4uOmz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762775806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b4bLupQzkMhqg0W6n4NZA/lMojvhlsJtEpo02wNFuyI=;
	b=kY7ctgARE7grL8Fz6GWeYmv1OUuHBdjvYx33jx7iku4qyA/aCFnm3PUn6M+bwL9J5ERpkw
	VZS8AVIIiccL2JmpyOnz4O6dT0876Ztvzn34qRZMk2PYaeavEYTWtXIJULSHsv8Gt/Yuv3
	KCqnlimFZrMPQMSBtgUfAq/RGdp+ErZFj3XONJZhkuseqAWFe3MdIAyjw+gtXMiixW2tWh
	3/t+sLIKHf1711Cn37HeWvn662BgK51ml9EJMUUUQ/kOL8bjlEX9qOPBNLSzN77Pe1SKE2
	MB5hmkgwGfDKnISGVNaW6ydBCB3tDMiO+ahdCeVJ8F4CrCZ7G/9S3o5btAetlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762775806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b4bLupQzkMhqg0W6n4NZA/lMojvhlsJtEpo02wNFuyI=;
	b=pRC4uOmzt3CCw81rrito5wkqJLGd7NEq+2cYOo0EDCoWbb0WNAkjWAzE8p0Hk62qhvC/5z
	jVJSjbKuTiM+RxCg==
Date: Mon, 10 Nov 2025 12:56:34 +0100
Subject: [PATCH] random: drop check for static_key_initialized
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-random-static_key_initialized-v1-1-5343715a5986@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPHSEWkC/x3MTQqDMBAG0KvIrA04ivTnKiIyJtP2QxslCWIr3
 r2hy7d5B0UN0Ej34qCgGyIWn8FlQfYl/qkGLpvqqm6ZuTJBvFveJiZJsMOknwEeCTLjq8403Mj
 1Mo7tzVnKxxr0gf3/d/15/gB9oA5BbwAAAA==
X-Change-ID: 20251110-random-static_key_initialized-313a87bb59dc
To: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762775806; l=1284;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HxHsjc+P+REkvmdbWcZldA6yaRA3i5VZ1XGKbPUnJQg=;
 b=KsVEU8wFRlAZHvlO91iOON43lbssgi5Kkp1Bt7ZB4t+zywzLNO2r473iOH+bhAOI1L1SjgF3X
 JyvXS8cLj9pAi4uOYZtjO46UMS4x4kr9Ldf7OnqruBR9L4J1LI+6d1b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Commit 77b644c39d6a ("init/main.c: Initialize early LSMs after arch code,
static keys and calls.") changed the initialization sequence to call
jump_label_init() before random_init_early(). This condition can therefore
never be false.

Remove the now unnecessary check.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe436c8102968392278d5cb5544f06..1ab7f169780aee3537ecfde52f43daffc4dfc95b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -741,7 +741,7 @@ static void __cold _credit_init_bits(size_t bits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-		if (static_key_initialized && system_unbound_wq)
+		if (system_unbound_wq)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251110-random-static_key_initialized-313a87bb59dc

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


