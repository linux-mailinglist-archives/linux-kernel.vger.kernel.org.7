Return-Path: <linux-kernel+bounces-816756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92DFB577F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECDE1892B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB43002B8;
	Mon, 15 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b4IBQ8fL"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1A2FFDF1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935257; cv=none; b=E5yvLdAni+Q6vR3lUPR6UB/96nr6g5H/liDkm7zuvYEcQROd1JuWDTFUZ7S1XDNuU0DUyaBuSzd3P6Sm2Nw3aFbmk9H0NWHQfgvbj0plA8gI8HOqjAp7xPkc/WiHSTLNLDu847IF1Cu3sS/n+h9HFW9xiWho9P17VSqSXLY2Mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935257; c=relaxed/simple;
	bh=J3F10zRnpKnuAj4S2pqmjyaRJP49KEWPXhlxJOPQC9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtcdMWp4bWCXkQKArHY5WrrkGixUcOzHII9vDJzelvx0HLg2HIylFxIPp+vFiYn4g+fHX2/44mLeG5A3Dy19ijSUcEADXXRRon621bZ2eqL6LepKjSpg1iC7f79NthgM1o848/uzKd1r4i16uzAEL1dEItlzdynnoLGRRUrdy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b4IBQ8fL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2866478f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935253; x=1758540053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJf/ucgzRUxUaxAWwmWGqmQ3ACFUoR+52kqOB9OiXaE=;
        b=b4IBQ8fLTevdx395G4Bl/w+nQK1sUY1hjLK1Sc4Unn460eQrhQvmZWWCfCocJ4QVN9
         7mOgezKf6aDsTOdCCIOqktxoKbKYIbevSjXtxpkV8EFEzBbv723puLxyS5W4NIqWwNGN
         xXAyO1+AXAU6XfgV2RYRyXOCbvhc4jALdDovNbeJ1y9YAAALbK2lBT227C1tzBROZU24
         J+38BxXg26LkkiQCx1eR55diq1SCNkyuDUbrPc3S+Fw3LHZIKiBGA1ZERfDACws5rjuu
         weJsZBc5c7K8/LoWt0OJF2I5M0DDrgDhyepLW183BoBBWPObbHg0M1ZM0ny9ZZh/vcs+
         esJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935253; x=1758540053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJf/ucgzRUxUaxAWwmWGqmQ3ACFUoR+52kqOB9OiXaE=;
        b=SO/F1Q7vuTc9HsR8erVrbgPrKfhMdwDPxVoygAv92QQantjFWnNnPw85289HT3M04o
         37slc5UmVK3km6KM6C9+kZAhbDV05TYplMFUlyob8bjBBPvqEDaHO3u1QzyP7QOhueZ9
         R5ytjSCBri6FYAgyNvrXejHo2xNIbwvNVN2bRyweMUVfjy4P/qJ5YimzhslpWM7pVpwF
         7leN7gkte1Le/o+k1UegNILn2cIGrotoK/hP92vkA+j6dfL+5Qo58hFlWY42vSuuXnZS
         ZOU7WeRxmDWrmIsJrq+gUXJYMgBYGrHxlWUN1t5nTvRSOOp/NBx87OcJ7HLl82ZdaQDt
         u5lQ==
X-Gm-Message-State: AOJu0YxHU9in5TFFhDtV+0LwJmktya6C0Y2fyFwJzkajbZlQKbGl/Kyg
	F7Nwg9FfNE95EBuupnpRWrYxEQ9hfzjJaUJ9OJKv4T24PTBd34umGvGWuxRv5aC67eniQQCM0mx
	C5nFW
X-Gm-Gg: ASbGncusHINmD3TJZdVqHPZwwp1K/S6NTRGJ5hh+SfNFUGAKon4gtcaGJ5rPeei/8+4
	38szRthYfKdgOaCofP2fnRwJe1BDMoTIcWOgpUCpdcWUKXIywN5FRaYoOyYQmzynj7ni7Ly42/x
	PjbnDtNphnVdinb1bP4OK46w/L0SKttjYYRyb2ejGIKrPdBphLGxjB3bnRiFWSb5a4Pa2HZzm5l
	3qe0toNiTdXIyYZnPBlQEQheamFwp0WZPNMLnEcgUIokqoWTNpnzYtOecZUr9vLPgw8mopHUYQZ
	NvCiOWwZ5/H3ZXyT6kZmVnoApIUWzGF04brQGgpxCQcxSH4xtttyaexxgsEnK/VcqTRYCrbpkj3
	TfuV8ejMglG1za2Pov8Dh21PrFPEQPIVEv7gqbH89pyEfYfildByfWN5HZjU=
X-Google-Smtp-Source: AGHT+IGGrtsi1YVwelrA5TAFrGZsAy3Is90xfeOq5sIBAIGcA+737MLpFmKndZrCR2zuam0h1ScWlA==
X-Received: by 2002:a05:6000:420a:b0:3e7:5f26:f1f0 with SMTP id ffacd0b85a97d-3e765a13179mr11188457f8f.40.1757935253584;
        Mon, 15 Sep 2025 04:20:53 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:53 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 15 Sep 2025 08:20:33 -0300
Subject: [PATCH v4 4/5] printk: nbcon: Export nbcon_write_context_set_buf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-nbcon-kgdboc-v4-4-e2b6753bb566@suse.com>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
In-Reply-To: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=2627;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=J3F10zRnpKnuAj4S2pqmjyaRJP49KEWPXhlxJOPQC9M=;
 b=h/diGfwcFJ0Z1Zp3VAuIdCk1s9ZDkC5qvQHws1jl44XvahkMmsGdMsm6U51P5yy6l2g/KBhTw
 uwDePS7EdyZChWYAcgdIWStX2/3kzv6e5ZmE7kymWZo3riTgqf0Yo4z
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

This function will be used in the next patch to allow a driver to set
both the message and message length of a nbcon_write_context. This is
necessary because the function also initializes the ->unsafe_takeover
struct member. By using this helper we ensure that the struct is
initialized correctly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h | 4 ++++
 kernel/printk/nbcon.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index b34c5a0b86303e2fb4583fa467d8be43761cf756..e0fc2608bd9d6a886f5ddc56d26f19b21ae8663d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -602,6 +602,8 @@ static inline bool console_is_registered(const struct console *con)
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+extern void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
@@ -654,6 +656,8 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					       char *buf, unsigned int len) { }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8644e019e2391797e623fcc124d37ed4d460ccd9..085930386d4c4accf69214d341c950aafb5d0b32 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -855,7 +855,7 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
-static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
 					char *buf, unsigned int len)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);

-- 
2.51.0


