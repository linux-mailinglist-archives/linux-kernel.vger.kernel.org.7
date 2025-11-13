Return-Path: <linux-kernel+bounces-899457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5EC57E31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00BF4274D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE912238D52;
	Thu, 13 Nov 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8adYPZ8"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0421D3F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042112; cv=none; b=bs4OpicvEAhmDtzc6OjpdTzRsDfQzYwY8o57RBHQULa2913jpBZ6SZc5jwQ6JQJvRe5LAxZH5W/8Mz7AeoQbzhWAwWvRpwGqk5H4i5hTn3zbGihrmTQu70ORywN/vQfSZztoeh0oFyExt9gFF2kfN5LJXs1sHHQTcP39zZjbgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042112; c=relaxed/simple;
	bh=uW+IuG/Sf7T8gkkGzx0AcLdnK9/ZQ8qHnzJpOQ624do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCJwoClxd/BNUMdoeyCVCmbUQez1yA3CS8abe21HrZ67Yj8yS9tphlYXz0UoLDv+oAh3k2Q3quEg5yZH6HCi+MFzNCstcIMBWpKZswLr6O5Aqt3XOL4dMr3dbUXm7OuGjol6NHcJUAK6iI3lI0nf/wZ0eXU+ZqDOEHzFN7hX0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8adYPZ8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b725ead5800so102960466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042109; x=1763646909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMshJ9A2DIKrA2Zogs2Cpxc6fwt/f5x2waGapESpvZ4=;
        b=L8adYPZ8zHBubLDnvFEl8Nm0l1WG4yo7GFmPIsLbIdnurxbcBHI2RHMsZiF+cZl3Kg
         XcNLyhEebeXket5My1EUyss4y4u+pl4nHYXXr1Albehl3Zca0dZgU7gaBYL+WeiD9UUX
         KVq+TNfuWyYNTpebKgVGoANZv4sTbKQgjlstcvfnYfyBSV8+7Sow2BD5GTY/iLLyM/Fz
         TTaGv8240yNAHn/06CWenP1UC0VfwmCXtISo6ZBi4FARZOj4j6w3Xf/f7ZkF6FSDaR39
         wtAd9KcRBUYSqzY6hbQVKlOqNWvXrskWS72pTi9bWD2tNlba5KbFnB+s6jvjFnAoUiXS
         bm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042109; x=1763646909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMshJ9A2DIKrA2Zogs2Cpxc6fwt/f5x2waGapESpvZ4=;
        b=I5Ve5n3TtevvI1G/mtNrvTxpgITVSVz94d245W753kosBrzYJQhKnPcjaY49g4TKne
         pTyolk1eRXvg79YTi9nQoRttaCZld9CHo0aBkRPgFT/fuUG4p1kRgxMYYLtQ8we7EAX9
         vZoWzZiWkBGW4JLTwIbHA4zd05UjTlvdRjy8tb/+59BeC9t2dHikn1R2n4RuHweVB7kU
         aholNRgRwtaF4Mre0k2pNC5yEIDZDjp86GTOhYA+XC/cpVRVGrrXMluTh1kQ2nGvIxaX
         VYygW7Zt2FfwLnaECxE0dn+x2Z0iW+yO7SXe6ryqhoOv+Hck+znI/frhd2dEqaYqQCpP
         86Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxErOas14jgb+PASM2YLTHzhXbLtMeX49owJjkEqUDBWZPSMW1YNVCFTQ9rwkUIjvpkD4fWCjCfJU78A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZy9H+BYv0YITTILz1/914oC4u6BUKRQY7CI28YQFmaw/jy7lA
	IG0XpIXv5e0vafYzkL8dDLfr2z5mj4xHAljaZdCtymcXymSukXvRzcMo
X-Gm-Gg: ASbGnctc3i70U8Xc1hify7c6iUO3RC7/AiDKjHBTod5dV18+s0lNhJuw/7vpza1ujxf
	cAVe0XVR1Lk4TILJOfhKYMbEp8JN4U4h/4lEp7pcuWiqvmy2+Q4Ps5aQtCHIeAq9YdQAvBDtLSS
	+iYCqrREjolRs5/I/V8fZotC7P14hneoM3jqsnm+zacTlS7Lsnf4rCFdAyYfH9t17OccXrHwfBP
	XME8hxmMORb0nwuDGgoINRl8PuYnhHS8zblLoY1lW89kJXn/5h8RmcXRJPErpZ65jg61EAHYDD3
	Be3BuPK8ViFFaXByVbz+mGjfAJYope8m8ivMLKvZ6fV1PqLBdbVcDtvkvTsZYUjemDYMTLPourm
	nWfS070nESr9U62xI61AMqJfWnuRd64SgL3viXojM+o6ZDp/Ex6O2W7pxmRWKfCzD6Douje26zh
	8NpWar3LWEgdzwYV6fK2Pm9fGCmybkvw+RPKFO/Jyk6njcj1m8H1mn6n3UGM4bo66bnF5i3G6gj
	9OebRw153QCsKt0PJDuMtZD2d34dO2FaDC2O0FzgFGeDQ==
X-Google-Smtp-Source: AGHT+IFjLNMTWll3wOMHJj7C1o2xo2PeNqA8MwVTUyKTH4gfY4gLjSKxihlZto1PIt7UB0ETL87owA==
X-Received: by 2002:a17:907:ea5:b0:b73:5e4d:fae0 with SMTP id a640c23a62f3a-b735e4dfe66mr32565966b.23.1763042108849;
        Thu, 13 Nov 2025 05:55:08 -0800 (PST)
Received: from codespaces-334936.m1k4x3cq3poebda54cltipn05g.ax.internal.cloudapp.net ([20.61.127.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41d9sm171201466b.27.2025.11.13.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:55:08 -0800 (PST)
From: Joep Duin <joepduin12@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joep Duin <165405982+joepduin@users.noreply.github.com>,
	Joep Duin <joepduin12@gmail.com>
Subject: [PATCH] fix MIC buffer sizing in selftest
Date: Thu, 13 Nov 2025 13:55:06 +0000
Message-ID: <20251113135506.18594-1-joepduin12@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joep Duin <165405982+joepduin@users.noreply.github.com>

Signed-off-by: Joep Duin <joepduin12@gmail.com>
---
 crypto/krb5/selftest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/krb5/selftest.c b/crypto/krb5/selftest.c
index 4519c572d37e..82b2b6a3607d 100644
--- a/crypto/krb5/selftest.c
+++ b/crypto/krb5/selftest.c
@@ -427,10 +427,10 @@ static int krb5_test_one_mic(const struct krb5_mic_test *test, void *buf)
 	memcpy(buf + offset, plain.data, plain.len);
 
 	/* Generate a MIC generation request. */
-	sg_init_one(sg, buf, 1024);
+	sg_init_one(sg, buf, message_len);
 
-	ret = crypto_krb5_get_mic(krb5, ci, NULL, sg, 1, 1024,
-				  krb5->cksum_len, plain.len);
+	ret = crypto_krb5_get_mic(krb5, ci, NULL, sg, 1, message_len,
+                   krb5->cksum_len, plain.len);
 	if (ret < 0) {
 		CHECK(1);
 		pr_warn("Get MIC failed %d\n", ret);
-- 
2.51.2


