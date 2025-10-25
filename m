Return-Path: <linux-kernel+bounces-870034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06589C09A79
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A00DC348914
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB030E0E0;
	Sat, 25 Oct 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyICDsI0"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FF30AD15
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410007; cv=none; b=tLO0P6DeokMwLwx1C03DahTGCeUoMRSow9aTgxDyYfIqBK4NJDZ0xySLn8IY2AHoJBDZ6FxtlM90vCfWL2wLfJQy3gv0PKh798ElJck/UGgmh3YphrWHYcDx1XMZXzHDHL0VkxgI+kxDay/RxhiB21K1n7wAzxQQFv+6lfv8NUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410007; c=relaxed/simple;
	bh=D84nUkpISPhfH1Ms4tl5/Hw+IaaftxzZv+6ev+Kp2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjyLMnkThx21zxtaqyjNgz++TUVbZm9JTP5HOlZJB4AcF0iipu/ww9ZLxwMnd1yt8ug8AciDeTv3d2kO8dhffPz5YAoXdjIq/ekqjUYwCfIFsrV7ZYy4St4bEouykbt5pHcSoraO0bgSmRfbQT8agjqsRwQ5veBDrVd0nazxj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyICDsI0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87c103928ffso30450596d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410004; x=1762014804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SI4944tmBFmU7KoVih1y0isAHqVxAR8yUSqEtfDae0=;
        b=KyICDsI0aArKWfsJpRBFDhudAeA+Xl9SyHa2qnJttJZyFZE8un2Hq2OAXzwXX3CUVW
         +EjrBurHYvnV7+/KaXuzCRE4AZjun9cnSi5Pj0PYLAGRwIEV5OpvezY/SHhY0992twLU
         Lvde9CxyvymxD26crgWS4ZPceQT8++st2as9u9GHAJVjg40UT9VAmRnyP4BMhxkWHEoX
         crpYR1s/l6njnE3oXQjH2lutBvN6oVXVxcm2yQTJIa1QXD8WQctgTj16Nmhygs275ScU
         gIqGg5GDE0DdqCCFVebDBpKVGtyiLxjmgT6JseD2bqIpl9x7C/S1xRixCt7la1SkFe8K
         40Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410004; x=1762014804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SI4944tmBFmU7KoVih1y0isAHqVxAR8yUSqEtfDae0=;
        b=kuH+kMjMn3ZlJRVWU93KVZd5BvtyTJeFZI6mtVUvgR4Ldwsj38i0zPZ9dSgmISXok+
         5T9Uc91Erklu9DcMlB+9ydz53TVjykDDaGI+kf1wc279er/O8+VC/hNZk3FF1zenV2+F
         zopehjmZ2Bnrx/ICt+uktrOwNnOgcoHdxME5ASzOAthaMK85H1v/dUPnHp9fKPQeE0Wz
         pnjvekv8w0ADkOq5NnqG2v0XarB2H3RUDh/XnFnGO4bFdpYmjSbRN7gg2mTFjrKuVSAW
         kEjX8sHl5tg37rTdALBLHkRnlAEKr8RdhzhOe8NGTV2c+jKkYp22XSdzyXIG4H0Tp8yt
         W5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAYwEVs28eYSjcuvQ6gWABrCq55c9XDi4HHWzd7pwQIxppSX0H+nXve43gYwpxrildriNYKwZxSTtyZvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBpB4gEFHhUn7lw8hkdDj7qFBtfqTWTH3X9OXoUUi5aIJfCr9
	TFkLIcar5j1DmgxoItkTHhghFy9/b4u75XdH1fd6da/ilIuZ9TE8pbS1
X-Gm-Gg: ASbGnctMbZnpkk3M6PwC1yLFVPOtGmemK4PGwheYSHB5JqTg3/mdQ0OAFoM9xDCzbec
	5FqPhkYEP8zxpNcG8zbk3H1P87RuC0Joo9m2kasr1l9qbxa16RLD5fHoX3vaP/yVS9ACVOFQq2p
	HEYwDDr56JOvJWE5o3wPxfq8pWWquuKGnkjweGcOT9bP/f9GI/D1bxaVzQyI8EN0gXpBzifkcLY
	6KqNli/RWENo8VdsXihNVW7nTDIW9U+kGtDcmdyYIClfq2SUZNJeKCvK7ao8gEO6IcWEaC0Qtp9
	MeTbC7+cKegjxS6zhNNUkEZoIfNxQCR23fbg8jSUISajU3RFAclFUX7pIOxN2plOlDrbS/1XImM
	p3232icBTo+58FiEqjUYCntiJJLPGLxPNDQ8QPoDu+4GBm0x9ZhrgulyvZk1tk5AuCvj8AXDM5C
	cNM5fVpB8=
X-Google-Smtp-Source: AGHT+IH+pYoj7JDrVlr9V1K521EK2v4HXmacCPBcsmD1pov0NzWw0TEKhAqqwTmJ6pEikmRZLBQ+vQ==
X-Received: by 2002:ad4:5ec8:0:b0:87d:cbb9:5459 with SMTP id 6a1803df08f44-87dcbb968bamr327845146d6.40.1761410004528;
        Sat, 25 Oct 2025 09:33:24 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48d91a2sm16538466d6.17.2025.10.25.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:24 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haren Myneni <haren@us.ibm.com>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 14/21] lib: 842: don't use GENMASK_ULL()
Date: Sat, 25 Oct 2025 12:32:56 -0400
Message-ID: <20251025163305.306787-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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


