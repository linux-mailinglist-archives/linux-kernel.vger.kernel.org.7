Return-Path: <linux-kernel+bounces-811500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B5B52A01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27853189C462
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B048260592;
	Thu, 11 Sep 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="k50nhQrr"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD826E16C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575934; cv=none; b=QAFgD1LeDaWEGLN1EFzUaRNEbpI/UNOh7VTwQ8serQdV5yhRu/WZJrew3vA2QGRc4ibdLZDP5NvqBMfpy/TmUdbZvCA2dqlifqRR+fWNQ1xkDAjftNH61fg7sAiVItX2C1EqcN038Fl5hEnIJ/FZ4a7m8lzV8qYz4DtZDcuAcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575934; c=relaxed/simple;
	bh=LvP6xvP6ZpqgZqS6HIHSDKtto3Kcjz+TrfwBMvXJT9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u77BighUGFzd8ZREMzUwP0tKAFj/0jLF2IRLYIvCgph9pk1GN+wSSLk59e+wqYC3llInSyjR1O5xN0SVYkFm1LOnWrU73GlmG7zg6Xln/YAAFKRbCeR1hqVR1p6COigLRkWRa66J7vwgufum+3JegyaNgbtTTohw93/eGQkXN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=k50nhQrr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445806e03cso4676925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757575932; x=1758180732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZBzkNSMlmIkXR7v+DqjmX4bPRcIBLEhcOlgv/ZqaSw=;
        b=k50nhQrrVm3DVAFhHz1sT0VyRdwLo7eagqLRFFGU4M4mvA6a9p+1kvYuozO0W8Z/+t
         zTOVKSZwz9o9oLNiG0oVez/Bx2Kl2h/bzZzDmdcKjuTZ48ioBbv8PDfTmfgn5tdc6Y/F
         4ntLthC4L28Ret5KeFpGiXSckQc0buHrK/9ipCppmkxxaG0xpVKpAfWXUPYOg4SjMY3I
         ZoofkrXmaQbFMtGHquAVFJ2t2VrKf4YoqC8lk95+99dtcHYUQcvdToctMDvl/YsON/Iq
         +93Lu0MvHa0a+ozQ8l4HW0/TROz3KLV+kQAcSgiYBX+dY31vsppu/HE+gOIMl7zjzm5J
         tHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575932; x=1758180732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZBzkNSMlmIkXR7v+DqjmX4bPRcIBLEhcOlgv/ZqaSw=;
        b=VlPRkV9YydKLyDdJe5sGnt5DxbUVSSkEk5isfN4yx9ncAIXiUVXqDeIpxlRiIGQady
         ozCD4avcjGHRMPbbvFB2D8mdXzK2vQYNWPu2DuFjSKVgPoSsskopMOenwjKCv6x883Mh
         iSkrJ8bH2QYIs9H7COTSucxpQr8OyqvnjgZiQu+PGk3eCY7drhaApoE/+icejF5Y12SP
         66SmmRyUiEVMA09fo4COw7JYcWVTgLK1hKIx83/CQodHc/MTaJ4mJkOGZrip93WihRc5
         FDdwcNzoAGPLcdgztm/sG7gnrcOBI55v1gtLdPkbNIrJLw4eFBmLe9Vyu7JvAK+UVnq/
         LRzg==
X-Forwarded-Encrypted: i=1; AJvYcCXL5RTGnf9hZ6VzeI51lBaYJaSZSMKMwGsf0z6AkW6ERbOU03kzc70mahfjQHJvcSaDNdgo/dE062V/WFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPigrHVG+YOtkBoFj/doyv78/jeBUb+yoEatA2dNf8mpImB2H
	0qT/xnGx9zizVmeZfnPY6o5yi6bjejK5fhCgD9LhPSMq/rkLD3r0nZv6gU398m7sLH5m4RrCju2
	eJ4y4tfw=
X-Gm-Gg: ASbGncs3KvPAVRzWzc/IEXFXKkcwsWWctJGH4x3WqEm4XSwoZNb3AaJecjOALWkyV56
	7XXrzXEnC3l0/vwEH4wLDqbV8UcN2rBxgBjmnfoLSp/Eu4nlQGDCFdjygRLLk+64nDfcJRK0ALy
	mW9hd3citQn5YHHE5i+I+eWYMPOvOlbPt0rhpHL7wvBNgy0Pjf+DPs6vILHRiyzySdQD2mXaMyn
	OcggEMFKnwfXVCaD86ZxrOK5q+PBnm5SLvWVRX8wud+QBN0P1hHcnN+dgkljBWvuyP/69vtJWmE
	O60C3S8qpg4Eousk5G3qrBh8v5ugE89kRA84XjVeG+mub7dTeaNh/IHlj9kmeu17Sm2M1hUCvVC
	/+H5oSWOrPvzj4mr5vD6eWQYYkt4pKAVFMLClXNOBdXgzBSw=
X-Google-Smtp-Source: AGHT+IHb3fEzi2I0Xw68tnhgTa5p89puCkcqtSm1frcG1ldvJKNL158VkcHDDriI2alZgWwrHA5Yrw==
X-Received: by 2002:a17:903:990:b0:242:9be2:f67a with SMTP id d9443c01a7336-2516d52cef2mr261971415ad.11.1757575931815;
        Thu, 11 Sep 2025 00:32:11 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ab4345csm9667835ad.96.2025.09.11.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:32:10 -0700 (PDT)
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
Subject: [PATCH v2 1/5] lib/base64: Replace strchr() for better performance
Date: Thu, 11 Sep 2025 15:32:04 +0800
Message-Id: <20250911073204.574742-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The base64 decoder previously relied on strchr() to locate each
character in the base64 table. In the worst case, this requires
scanning all 64 entries, and even with bitwise tricks or word-sized
comparisons, still needs up to 8 checks.

Introduce a small helper function that maps input characters directly
to their position in the base64 table. This reduces the maximum number
of comparisons to 5, improving decoding efficiency while keeping the
logic straightforward.

Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
over 1000 runs, tested with KUnit):

Decode:
 - 64B input: avg ~1530ns -> ~126ns (~12x faster)
 - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/base64.c b/lib/base64.c
index b736a7a43..9416bded2 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -18,6 +18,21 @@
 static const char base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
 
+static inline const char *find_chr(const char *base64_table, char ch)
+{
+	if ('A' <= ch && ch <= 'Z')
+		return base64_table + ch - 'A';
+	if ('a' <= ch && ch <= 'z')
+		return base64_table + 26 + ch - 'a';
+	if ('0' <= ch && ch <= '9')
+		return base64_table + 26 * 2 + ch - '0';
+	if (ch == base64_table[26 * 2 + 10])
+		return base64_table + 26 * 2 + 10;
+	if (ch == base64_table[26 * 2 + 10 + 1])
+		return base64_table + 26 * 2 + 10 + 1;
+	return NULL;
+}
+
 /**
  * base64_encode() - base64-encode some binary data
  * @src: the binary data to encode
@@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
 	u8 *bp = dst;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
+		const char *p = find_chr(base64_table, src[i]);
 
 		if (src[i] == '=') {
 			ac = (ac << 6);
-- 
2.34.1


