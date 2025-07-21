Return-Path: <linux-kernel+bounces-739706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD23B0C9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ECF3BF740
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D62E1C7E;
	Mon, 21 Jul 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atDA6pPE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D51FE44B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119755; cv=none; b=cDMI/hZU1Ue/8KenJhv4ykjjL0Q45pT8PTyfM8bv9+wFWX7OIAe3rZ5GgYCCFj8H7CfA/7wlBBT2fs1Y6+bl5F1PFB8wi/MYyPzKBmf/B1Vt41r89/EVDnbkJzSEgFFOEeANmq6H9r0kCwWzEFvDHbqokz574otVTC25Tu1fn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119755; c=relaxed/simple;
	bh=VG2wzmevee0WfQHyvXWG2mOKD385wpS7AUm/tMug+5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wqf5tx3F7FshtTFAwu5bj6qiQDc4pCJWT0o2+m0bVlnpnCjvjn7WkaDntxkgDiEurL27IBjIkbLRrp8wJP6MKkic2AG8hrfDA2Fecgcnj8XCB8zn1tpYPBGgnk5WH7d77SFczMVSJ4/WTIuXiroSnbVp0aI/+oxsgFwzWHMF6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atDA6pPE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so3447991f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753119751; x=1753724551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgw3RSPzbscvVKyiKcWT4fnqoMhEKUNE6q9sRAePU5s=;
        b=atDA6pPEI6UFSPJoTqe/QlKYGTuponJ2bHHEf8Zm4K+XLjmrYk5yoiaKxeJk7PN1V8
         FVOj/9jNaMDKhbMEdEKF6fs81FJFXn3PA4YlW7bb/NMrZVOQz9Q9+aBUm8KIY9DLJBjy
         mWU71P+mR1ny7RDiO5QpzYff8uozrPZh/brICQs2dCJpIgz4TLuUD3BN3PXkAoZEgu+G
         2yTaQQWhV0R61GFXa6+nSqhCnGiJZCQxTe1D0TEVlNoJjutgItFSLvc7KNOzZYKJPf0v
         +vP2Lr9e5sPyubdQ1ikN0qZ6LCleisPBcz7ns0XnyMBS3lH8qLgurfxv6Sbpn0C8tDNd
         zZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119751; x=1753724551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgw3RSPzbscvVKyiKcWT4fnqoMhEKUNE6q9sRAePU5s=;
        b=ZJXTbEKuNKprnzIrQweaDP4QVnMovPC9ng7d6OJR0Cj4cJvlNiTHBzREgle5/rztGX
         JGDBV4ZN7ieG+Ok24AifKDyFIOUYEC13ppmZxYyQmb9rDdamklOpMjURiTS90G41i6CK
         GM0uEacXed7UkuIqaUFAQMfspl36fq6NTQhvUsxXcBsMvIOaaWR3A+CoJUu9cDx/kswT
         oE2nAlgcnpaBwvsHyvQpemb6u9pqKnjpj0PNEGtrg75r5pUi2t+TYwUWt44OkKGlOVks
         s7GkG8jxGkTdA2i+ebvh7PSwkT5gL6ZL7Q3bRvC0xrnLRPHcUsAx1vsU0q9cEe98Lf5+
         UXiA==
X-Gm-Message-State: AOJu0YzyI4jjJuJDnHMnoHxx6jnsQfwBj0ZP5uqhEWjYzXJ6tBjO3kQB
	HkTqOW60ojJK4j3oHqd7049kfCHVjKy6A8Ssf/9ZJm6xPYT3/9rbtflXOrH1HA==
X-Gm-Gg: ASbGncvU3OH8umoGHY2G8PEWigqXgM1PKgY6juc3ha8cWrFY2A6C0aYncnqmaXYRXFT
	nmLoSU58J6fOYoPD7cZ9oLQ1g/x0NjFHQAdsLiU/YPEk6EFU4FAy9ANeL9CJR165fbGgAEfMKwK
	/aBoaeRGkmXcXxZs1Q3tEE/IdJSKpHweyN4o7qjMjTdNHZEyxNJQH3USjTMpvg7M1qOkc7INZkb
	ITt1GG66+P/py45JlKGADRo8j8/amyWW0bG1/wzizYk2rd4589aUNYbNAjLGf5q0p2vsp3g9Tif
	Nr+vkKBm4gSo+b8FXC0NlZdcFa5NiHkGZHkB2WXArkn6dcXjGOdteoqVsnKArLs1gx0J6LJ1RkK
	LlFIVJC0LbNP8/9lP4fggZfwbQIlY4BMj
X-Google-Smtp-Source: AGHT+IHxymeBCyzjQxV5IlRfLMbFJ8rOGHq2OhxGUE9ayPXxvNyj59eHGtvERLsB5YN24QAqWl3ahQ==
X-Received: by 2002:a05:6000:5c6:b0:3b4:6577:eed5 with SMTP id ffacd0b85a97d-3b60e4b832bmr16369194f8f.12.1753119750843;
        Mon, 21 Jul 2025 10:42:30 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4294sm165928435e9.3.2025.07.21.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:42:30 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	MengEn Sun <mengensun@tencent.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RESEND 1/2] ucount: Fix atomic_long_inc_below argument typei()
Date: Mon, 21 Jul 2025 19:41:43 +0200
Message-ID: <20250721174227.28002-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The type of u argument of atomic_long_inc_below() should be long
to avoid unwanted truncation to int.

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: MengEn Sun <mengensun@tencent.com>
Cc: "Thomas Weißschuh" <linux@weissschuh.net>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8686e329b8f2..f629db485a07 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -199,7 +199,7 @@ void put_ucounts(struct ucounts *ucounts)
 	}
 }
 
-static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
 	long c, old;
 	c = atomic_long_read(v);
-- 
2.50.1


