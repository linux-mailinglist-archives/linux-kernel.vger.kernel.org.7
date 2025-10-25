Return-Path: <linux-kernel+bounces-870059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10DC09D26
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A40D584BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EB31194C;
	Sat, 25 Oct 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L47YjkAC"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DE315789
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410472; cv=none; b=gS8j8S1a71NI5/w2X8L5/YSdAsNURM7XvEiAz/oKQe9oqHlTm2haC4yjqG0fLrbrjFwSUj66TM1qXKtgKKLwx/fO1UPfIbZ3RieYTfr9QNQtSf1XEs68Ki4LRlSo6N+A0VQPURwv5YWkM8m0YDzCxqIcp98oNxj3FyY0aGvJuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410472; c=relaxed/simple;
	bh=D84nUkpISPhfH1Ms4tl5/Hw+IaaftxzZv+6ev+Kp2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr15gNaLol7hSXoB+WvVTIU1WpN5Fv4vWIAWR33TkOFph/RD7GmIEzSIC+cUaXGBjUIXs9aS+5XzXxgk9lZnR4dllB5EuQL1oF140049rVec3qDXhR2jB6IrezJ653tc2m3xzdWJdEHIHZTwvl/bnYtBRuUIKp3+0/wpO2HNb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L47YjkAC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-891667bcd82so404831385a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410469; x=1762015269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SI4944tmBFmU7KoVih1y0isAHqVxAR8yUSqEtfDae0=;
        b=L47YjkACejz1Y4+ttUd3BvqLxbiUtV6rru4b28XnY9s89anzhUCVxsVeGNI9aYTsz2
         ybixOlT7lFYdlB6s8LK99p7iNPc1X/OMmF/ZufOzsxPIqzfRK3cJOzRmU/AN4UyPbseB
         wgsSvKGPTwzvJj5HX6xnIVZHm9twsXnkgro2vmuXX+QXcooI2JwRT1PWLoWapgllSuLj
         qO0L/KLaB1c0+KCZ8qnNN3/tvprqpALWGCR8kyVTVy0TuGzkP6KIj0ug6+I0NSGOqSyX
         BkRwVmKIwdasnJwdSWcTtD9RjkIdaYMfOeNvYs8SgvFRAtGxXFhi4tDA7bFSf6s9ebwS
         hy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410469; x=1762015269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SI4944tmBFmU7KoVih1y0isAHqVxAR8yUSqEtfDae0=;
        b=iYeW+rvVtPz0qiKrLkP/qGyIBTfKTjMlcUifdUoT5vrgHSm72KMMq5sL5L6XGygjhn
         D3j8HRpDgOYi3ut4xJ/T+rWnV/yYGuYEItG1ufYA1Bh5NMxWOdRipL/ewfCFZncKw6Sl
         LkZagfEDPcfTbBgzIhlHo2ViJ0EBYd8P3g0uMYs0Hg6Z0UC8mZ8O0EBOTNaq56t/Eaki
         +ZX8iw+o0hwswmFjpFuSAccS/8rYRliS/zTu6oyYxn0Db+EdeAxSZVwLhQBzT86vkvez
         dJ0Ktnlkj1REZtLSkNCoprJXfYa1LgN5k4bSTTGI6d5BovUsKoQLL+m4f17QA+JVVKoG
         J5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX6jz8Xy0i/3seBHbPDshS9rqobe9tCNNpalyzuaSRtU/G/RY1A7W6zXscywa4PxiUXWceTLz6OxF51o1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycF2WUVBY0mwPcihRxiNELvr9cDDlNTyPy/nlnO8xisKrDsPdh
	VY0acOi+1hEdrcFYqkVCMakR3xA7DBslzmhL05Z8UoE5+zOkj5Qool0k
X-Gm-Gg: ASbGncsV3x3zmQDCCL3py4F2KYu+c4OJ4DeBt8Xb/NYGnD9jU5qRVz3x7kjXFo+v5LM
	sTSpEwyYq0l05Ovru9XdYCoqoB5nFZI9trf4b39buapPPsM+ZPOH7/5tY5V8yXCtyovwpN+h8sR
	0Fr6DP+okSXOmzdMck1/A0Xpfo/8WEaIuyMJFweWUB04lEioYZ6Y4hGpQOZCVrUNyOqA8vEo32w
	WQUv61CJkSdgAtXV6FvFWXYxfv2jjAxsgVnXNKvFY69FrC2SYUroCOkDl6h/fxn9tWe+PY0oUKI
	T1lKyACGiAexFZEzI/XZFSBqd6Uv3TrZ9Ojl2jhNUzLMWKIUdNoxSYw1eIv40p1GAiL5TIxsqBB
	Un2CfFB8HXxd0VVAKWC1NkMfkjXNiD5uRpD+zL9sgpNXU3IG6gnMJ6OYhW36MjEvNpX2Jynyil0
	Ha6m1JjjA=
X-Google-Smtp-Source: AGHT+IHKHIQ9LbaP+/C3YxY1PuYJDoDrDeVpEVRry3GCVvQrvkqZnCWFlPH08io6/ufIBsMsF6TVcg==
X-Received: by 2002:a05:620a:31a0:b0:891:6a36:1bf8 with SMTP id af79cd13be357-89da08560ffmr911543585a.14.1761410469301;
        Sat, 25 Oct 2025 09:41:09 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f261747cbsm173632685a.54.2025.10.25.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:08 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Haren Myneni <haren@us.ibm.com>,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 14/21] lib: 842: don't use GENMASK_ULL()
Date: Sat, 25 Oct 2025 12:40:13 -0400
Message-ID: <20251025164023.308884-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK_ULL(high, low) notation is confusing. FIRST_BITS_ULL() is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/842/842_compress.c   | 2 +-
 lib/842/842_decompress.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index 055356508d97..83b68c85904f 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -161,7 +161,7 @@ static int __split_add_bits(struct sw842_param *p, u64 d, u8 n, u8 s)
 	ret = add_bits(p, d >> s, n - s);
 	if (ret)
 		return ret;
-	return add_bits(p, d & GENMASK_ULL(s - 1, 0), s);
+	return add_bits(p, d & FIRST_BITS_ULL(s), s);
 }
 
 static int add_bits(struct sw842_param *p, u64 d, u8 n)
diff --git a/lib/842/842_decompress.c b/lib/842/842_decompress.c
index 582085ef8b49..0520f20f4121 100644
--- a/lib/842/842_decompress.c
+++ b/lib/842/842_decompress.c
@@ -115,7 +115,7 @@ static int next_bits(struct sw842_param *p, u64 *d, u8 n)
 	else
 		*d = be64_to_cpu(get_unaligned((__be64 *)in)) >> (64 - bits);
 
-	*d &= GENMASK_ULL(n - 1, 0);
+	*d &= FIRST_BITS_ULL(n);
 
 	p->bit += n;
 
-- 
2.43.0


