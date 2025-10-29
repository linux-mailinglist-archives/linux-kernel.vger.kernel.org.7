Return-Path: <linux-kernel+bounces-875708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6EFC19A67
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDFB43435B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43262FD7DE;
	Wed, 29 Oct 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="AB5iWV8n"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8832FB087
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733245; cv=none; b=cfLi08rttTi1Erw+KTwvFQuCQSJgI6v3ccA7+d/WgCStyvIs0GonYdGfRwPty0bm1Eh474EldI8MSjLglgKsA9cVPKKFuGBA6fsyVEouIw8UPBUML+zxgH7DZbuiKIXe6+afgcXene6MrGVYRhldryWgDxb6FjlgiDRG+lKkuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733245; c=relaxed/simple;
	bh=TIf3na/elRX8csqXIacwGrcO6olD5UumqtY8yMupiVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrewnIzDU7HlisJd4Tlqx1aYCemdU6ynGJKkamwXRKO/MSRZfz1DM6A56dvU4gQ0vYlittbYgCjXoqhhDCEfzXcA7s1E9d5x/mQMOC4+U2hb3nc4rESwdqc0KC3Ly6mGx3ouPmlSyom2nfWeYPrbOmRnzlHM6+47HaouwaNjOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=AB5iWV8n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so782114a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733242; x=1762338042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muPZR2EFB0oSgf5LU8hlA8LwOzFVPmAYEO5+iKyULIY=;
        b=AB5iWV8nKXz1+ifx388tW7elioLcbfE3N9OLL7GPJtzIWYW9Nr3e8AJ8AbQ9TP282Z
         w18u7b3/HCIatZdyLD4F82a2GHOdMT2wPBddmAdD6DU/P+3K9AwxCHbezmLfuxbWQP7a
         gAdwDnF+sLj5pw/SBQ+adMBFOLwPuE5tH6jUwiv0WrM5JQXf30foUb5+TLl0k0/1273w
         I3GUBS/MjY7bj4ucs0e/XhZFShe9F9biOt18MDgt01aahdrcEnjLK3ZvQo+gcK5lPXEY
         Df6eWmNUnUpxdpDLI8GczKLQHngrcAKqVB6jF/02wxmYxNhAFjgkslq0YNJbVmc5fW/B
         1Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733242; x=1762338042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muPZR2EFB0oSgf5LU8hlA8LwOzFVPmAYEO5+iKyULIY=;
        b=f/xBJbBasETdUkONkhniaVeI5ldV0jOcym4MAXNQo8lCjC1mcZ22X8cGeKx3pHhjUG
         yB9ylpGg6xPNjPe9JpZ5hsaYPhnaXB+130BDcQsgScjW4UhKMs/W2HctQ+4l4shwaFxm
         jFi7whxPOpOOdCsZYz8h6zPSaTjMJoypa/RdJ9BBTVOKhX+okEhVCSwT5ehoXSwIbBEo
         TwVmc2isPlOlQb7Rv5NL5XKC6B687gZQ395DYgQ77TuknymwouRGyr7yD5EKAt+mNSXI
         h+ex5ttG/MAsyoJtosT7G45TkYMWe+7Yg0Llf4IKlbzNIZRvGd+plPbcvmsHeRdxL9IP
         5CEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnJDNIh6NSvT6xAD2rjcobcW9LwBnLYXmOw5Rqrz2LB65aLA9GhKnE/dej03Z7wBOjp0C8u2y4aN8EhDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClMpaJ7tBxbuwk18ffVp7BeN3TciUi6Jzd+j+WWaZd7RGerD9
	+W+p+W77JTgzCxFi4sScLqQ5xT4O+TuBStD48JDy34WGhMTD3shS2xaWj5HbLbYlTsM=
X-Gm-Gg: ASbGncszAwPZyC5oRngp62kV3Vo8XyaghAjQsmfw4VJrjAVAOS61DFKZlwGtgXrw4VM
	LvjzCtwLyoCDwYvGMpIwTQBt9bFZC6a5mWlz6GvShYCXDAscYMaNANtRfrAvN75aIlMa21A/fIH
	Y0eONgiY+YNqZ0mKYJK+M2O6dtQMLS1/AUPjjtmEs6XAzuEP4O30ge632Vuenw5J5xOxptV/blQ
	HsGAQvMXRZBj6HqdEZNG641lF/jrsFJkYk0zRrKVWKc1SccxpQLf92bKvtUwrsD/cW1F44zk3Qn
	MrtgUjGlKgpt0w1rvHxebAAx9piuI7pNvFVkHxo43x0TbP6awignV1vwZCeInH4xAWz30SL+UPo
	uYFV7FOw7/0PfsSz205ZptI7AKNnl1zySnzkzsWYGVIJ3vVlv4qcRgLdzhZVfG0408Kpl5dtUfx
	ibGrJbrLVBEjTogCAzgd13CkFA
X-Google-Smtp-Source: AGHT+IFrDmoqflAy+Vvmh8+Eo6wG8f+LzM2aUxs5UOYfH1wyy2050pHKCKkM65jstFpCS2r3tIFSzg==
X-Received: by 2002:a17:90a:d448:b0:33b:dff1:5f44 with SMTP id 98e67ed59e1d1-340286bc834mr7455074a91.6.1761733242563;
        Wed, 29 Oct 2025 03:20:42 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed706449sm15024924a91.2.2025.10.29.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:20:42 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v4 2/6] lib/base64: Optimize base64_decode() with reverse lookup tables
Date: Wed, 29 Oct 2025 18:20:36 +0800
Message-Id: <20251029102036.543227-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Replace the use of strchr() in base64_decode() with precomputed reverse
lookup tables for each variant. This avoids repeated string scans and
improves performance. Use -1 in the tables to mark invalid characters.

Decode:
  64B   ~1530ns  ->  ~80ns    (~19.1x)
  1KB  ~27726ns  -> ~1239ns   (~22.4x)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index a7c20a8e8..8a0d28908 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -21,6 +21,21 @@ static const char base64_tables[][65] = {
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
+#define BASE64_REV_INIT(ch_62, ch_63) { \
+	[0 ... 255] = -1, \
+	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
+		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
+	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
+		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
+	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
+	[ch_62] = 62, [ch_63] = 63, \
+}
+
+static const s8 base64_rev_maps[][256] = {
+	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
+	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
+	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
+};
 /**
  * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
@@ -84,10 +99,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
-	const char *base64_table = base64_tables[variant];
+	s8 ch;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
 		if (padding) {
 			if (src[i] == '=') {
 				ac = (ac << 6);
@@ -97,9 +111,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 				continue;
 			}
 		}
-		if (p == NULL || src[i] == 0)
+		ch = base64_rev_maps[variant][(u8)src[i]];
+		if (ch == -1)
 			return -1;
-		ac = (ac << 6) | (p - base64_table);
+		ac = (ac << 6) | ch;
 		bits += 6;
 		if (bits >= 8) {
 			bits -= 8;
-- 
2.34.1


