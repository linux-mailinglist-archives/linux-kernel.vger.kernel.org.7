Return-Path: <linux-kernel+bounces-795873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A0B3F8D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4E18902C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8F2EACF2;
	Tue,  2 Sep 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENG7PRGQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E682E8E03
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802180; cv=none; b=pEL/5Q1EmCPRDt5SeMw4sn4TpYe94zV37v/XdzaP8CS3bC+hT9y9o3uwSc4GTnNVXUD29ZVgk2KZq7ZC2XrUZvhzFmRrPH6OPyKhqX50TcRx8hkNA7J9Q+HKCV3sAG8oaGz/s+m0HVkPJFVly3An6zCfuDvmYBpgIiKjLOlOcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802180; c=relaxed/simple;
	bh=QnfwVPV7sl+XBZzzZ+jUFbEpa7KtnzFZK0GxLBS3hSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B0D229HT3QofHRzpEcb9xsPDBATXpRZuAl3MZGUGUmzLOP9BGsmHA3a+ppHo7BE6X/ghye9B0dBEpcSGy8m3nz83pOnLwv5QgLtqxVF4qzyp0HA66Ve/yeCk37ELygN9zTGpKvMucZpU7bY3NVeY4ormkyIZ08mqIVwntuQkALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENG7PRGQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b8af0b8deso11169165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802176; x=1757406976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QH+dNhuwk1lL/MGBDy4gK3rPW79vkNW7Vepzh60wxeY=;
        b=ENG7PRGQTj/xbeHGJTGCdFO2BryXM31uFX+W0tZ2BFk6MEDCuTO4ZBIguGWKjrFxyu
         uFBxNlNP5KbSZDxK4pFDK67gYhwyLn+1692jJ2mbRsl3VP6NxSSFpTkyONt5fqCx1tot
         9Sinc8bZheofIwnQ9YeWgG3szPHLsX4IRVHhYL9WPmv7LwTvtnkrUtTKwoPdBRq8xnAf
         nHZsz0jGcCCFZ6VIg7rOCf7t0fC0RUBy604MH5YQj4RZ/yvHuwD37k8k4lZY+5cN3o2w
         x20/G/kwTmynbrc/qCkOcWMtyEcvYWrnv56WftP69ozgCNWkUgl7g6SNdFaOpHWwybjN
         CBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802176; x=1757406976;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QH+dNhuwk1lL/MGBDy4gK3rPW79vkNW7Vepzh60wxeY=;
        b=iFgaSvsgBtTPzuWf7ZBHvB/lfgD3wJW/t19ob4hG7AMOLW2mDrzoPMuJlEyuWtY5IO
         /eneVs5pMudLrhwqOTSgL6Up8cvkSJelDZ3KeFJODiQeIaGt3usE0xx/DK6XccpL/90R
         g7Dhh21wXFdpgU9p+eBMy/uCkXZCQcN8iPyooP0r/cLO5IWWn76wqM1zDS5WeBJZs9uS
         elYj+Rb0dt+rWXYsVgFbPdaCF8Pdcyx1E6hg2d5VNkeMVwTQkaVTKA02nxPvHVP2khIw
         bV0FI6ood+pgTOn/URj2LoI4Wv2evlEb1smgga5WLU7dVi3aBudab/ItLftNesAy74ly
         VLtw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DGS2Vm6MZ+jIkGj6WYvGjB3hognDWTltZJZM7QV1aDSaVkbZTqZuPjmlOcFofvb53MoaqJg64IpmnNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyus+59sx8hL4dAdelGrhF4HLNDrRITAky3mlC8dbvhkAFAfpN
	nRLsNpV3SZzW1b90fxmqnIgY/d/Vq9OlQA2DE0zWqI9SItsODadVX3ZNOfyFQRH0/o7/lep9M6E
	mFxGkhrCA601TM46fRQ==
X-Google-Smtp-Source: AGHT+IFrwiLMwac2efeWQGD8tg+3earadoHpSjr59iffX99070qwvna5zy2O9EDiYznHm5rt2CVI2cPNwcE5eb8=
X-Received: from wmbep10.prod.google.com ([2002:a05:600c:840a:b0:458:bed1:8923])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46c8:b0:45b:7c09:bc0e with SMTP id 5b1f17b1804b1-45b8549c7admr85100405e9.0.1756802175884;
 Tue, 02 Sep 2025 01:36:15 -0700 (PDT)
Date: Tue, 02 Sep 2025 08:36:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHqstmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMj3dzEgpxU3Zz85OyU1ALdAt1ES2ODVAsz02RzsyQloK6CotS0zAq widGxtbUAO4ntmWEAAAA=
X-Change-Id: 20250902-maple-lockdep-p-a930e865c76b
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QnfwVPV7sl+XBZzzZ+jUFbEpa7KtnzFZK0GxLBS3hSs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBotqx/CYGhzcPznFiE7UDh9XQoTakkyebBpyup4
 FA6tih9P9+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLasfwAKCRAEWL7uWMY5
 RszmD/0RBaQV9WIxAvZ+VnmbMFTKWuCAP44AGbTl/3sQk4GNwQFQY9uNosttG4sVrjzvQo6CTyW
 ssJ6yEm0Q6z6beDpkId7DyPz22AG9PkO3nLxJaI4tge9qKiw7MPDxBhMDBxirdYiD8VBhMqICaW
 RQJ3GrQrlFmgfmxgF/P2Lq7tVEuevZQ6Y63z5/iNW7b0HM/a3cRaJj1wKSqvkGL+3Dy6GsKBSAj
 jsofZrZAXvHnbRViM86JVCRcK8Rl61lRiaMAC3iMbhV3molQB5qWSEQFBscIkLoa6UBLhKvLuUC
 PvU2199QpdCFl3rM0ahASdsYrb0hDkTUljpLu4SOv5hGDqNofoSLg0TqG4CyVevrnmNXynEEY5F
 1twK6PR3dbAhfKze01E6Y8cTRxgeJtgOR6xgLV59rnY1Jhb7n83QZdODGrKnbFpIG9Gq2YMQB1T
 wbTbMi2yVf9ZxlI5ZF2aGhPuIHMtFx8kc5iigDyHNLojAnN8IeN26oGF2jgUJgvUMGdVnaXOd+/
 bSIsPhTcucBM5bW1YKhe2Ya4XH3nGT5eDwAUfIL7wUinYIayPZeUe/oL/5f3MninIpDJg7phLyH
 8oCWYTXP7b/Pd44KqJIdOgcSPrWZACiOi+Wn3joeYeNQxwsL9Zx8y+KYwazcLdY7MqunZopAdj8 ZrYZJc1g8fHGUPQ==
X-Mailer: b4 0.14.2
Message-ID: <20250902-maple-lockdep-p-v1-1-3ae5a398a379@google.com>
Subject: [PATCH] maple_tree: remove lockdep_map_p typedef
From: Alice Ryhl <aliceryhl@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Danilo Krummrich <dakr@kernel.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Having the ma_external_lock field exist when CONFIG_LOCKDEP=n isn't used
anywhere, so just get rid of it. This also avoids generating a typedef
called lockdep_map_p that could overlap with typedefs in other header
files.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Originally sent as
https://lore.kernel.org/all/20250819-maple-tree-v2-1-229b48657bab@google.com/

But I'm moving it out of that series as it did not have the intended
effect on the Rust bindgen output. However, I still think it makes sense
as a pure cleanup patch.
---
 include/linux/maple_tree.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bafe143b1f783202e27b32567fffee4149e8e266..8244679ba1758235e049acbaedee62aae5c0e226 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -194,7 +194,6 @@ enum store_type {
 #define MAPLE_RESERVED_RANGE	4096
 
 #ifdef CONFIG_LOCKDEP
-typedef struct lockdep_map *lockdep_map_p;
 #define mt_lock_is_held(mt)                                             \
 	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
 
@@ -207,7 +206,6 @@ typedef struct lockdep_map *lockdep_map_p;
 
 #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
 #else
-typedef struct { /* nothing */ } lockdep_map_p;
 #define mt_lock_is_held(mt)		1
 #define mt_write_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
@@ -230,8 +228,10 @@ typedef struct { /* nothing */ } lockdep_map_p;
  */
 struct maple_tree {
 	union {
-		spinlock_t	ma_lock;
-		lockdep_map_p	ma_external_lock;
+		spinlock_t		ma_lock;
+#ifdef CONFIG_LOCKDEP
+		struct lockdep_map	*ma_external_lock;
+#endif
 	};
 	unsigned int	ma_flags;
 	void __rcu      *ma_root;

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250902-maple-lockdep-p-a930e865c76b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


