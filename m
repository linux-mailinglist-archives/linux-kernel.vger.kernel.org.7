Return-Path: <linux-kernel+bounces-853598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D8BDC10A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1810C4227CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37730748A;
	Wed, 15 Oct 2025 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnOhyz93"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B7302CC7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493205; cv=none; b=eyWb9gdvR/X/8E1n44K/0Rl/WhMCOLGN864XY/UtdO0gKKdJLs+l4jSGZdkRihmpLUrL4qMH5uoHvmBhhZZbQEUjmlw4HY2RDqnJ6Rt7DLgCwetTZNSvvaDP0AOhgv8ECB8T4AFhLmL9lmziGzg8wUaG72BUJUOwLdf4v8IX82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493205; c=relaxed/simple;
	bh=9RRIxNvkdJzZEHQcDLQmeYeLTnGKYUa3WGMGZiJeAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV30G4empjb/4So/vaQCrVms2WhKeCufVm3wtC0KfMyYxFjw12nGSukTCj1lUIR8RyZDKBPWKtOIQ01xN+V7v/FgKWRL+jIZxsKAFvAIRXZCC288jdEybX0wV+FYpg3s2iJpRQOuTFsk23HY+aPKj+3rrptZI3WBf7Jcwh8N8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnOhyz93; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2531819a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493197; x=1761097997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=AnOhyz936MVwprfv8AfzeB8rgqXUFnCesu+hA/7GHZip2quvOBMstkonHszmwxEo8e
         h7S6q6qtDqpCFVU+50dw+BeIQyhJbJ+2IzrpG24OenoJp2Bv6slhYhLJU8JID/Ia4d5F
         Xxu3hYvLSieJ8LRh5uxVPFQJnj3SJLzpmyaJ6o4C9SvNK8tomcDp/XMkc/VM5xrLKIfe
         pjeHTHMDL6o51U8pua3sCXPnV1qMo7eWeNzPFndNvqH3IIYiYmGhdw5t+BserYu7S/qU
         vulvyw/hYTL4+8Rr1qE0oMqgviypMyBau9iLfPG0jJZCZnG6m/AEnqpjKO+BK3YJY61A
         o4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493197; x=1761097997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=nU2VmXEzTvV3hqRbQxk6L2ASD52rXhiAdSjVOVDJ4zroTrLd424ETSbC9t66Wm5fCH
         R4Wxz8w2/zI0tqFPN6hW/1cRumn6LYDwmDZNB3ewaqcjNV7EOIl3/rmsiK1h6WYwsbwB
         8pvx3HQ6op7wMOApiESZGEIRNSlb3ch2lfG7EAtdBp+tUQxqgx/XWHkZ/sasWzG0CDR5
         YjlEX9zBhzlLpjGZ/ZD2pslJZx7cawibxuCUrvYap9RMeWOD2+AYu7pX1mmZC1PlIb4+
         xmSh3pQnNY5va06Nzf7opemPB9s/jvLsHTCZzo223kabySKd5CIsKdoNv6ZdvRc+pqIq
         eP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+RSf+QND9A6FFQX3Y7GabDxl21nCBEjA9uV3zW10mRm9xPqAmm0Y8bNQNVpgm+ZU6smCtBfrNBrSh0/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGR1MLf62cQmWBxUiIX8LNUDq5GLXCYa9h+MSzzJ4jg5U0uU7G
	CtHrwEZJwyumi7qagyR0dJpTsc/J60Ickdtnx8CoqUVqgaw8zBZWyYv8
X-Gm-Gg: ASbGnctljZyfVAQKTKuDhof3RE7Q18iXnDjuD4cafiWLo9M3guLw0zF9QXWFjqN6GV1
	mGXD1KVSLahLWKPvXAYB3OSMhbERzKrIxZh0HXEKN3vOoNhE+K8naW/eAd7AdQu8rHhGcI3oAhD
	BNiNHteGKA9Iz4LqMb9hWW94QpKnkf2BR19vEHyXWJLtkWemVMpjy/yLtTtFrm6gAcBvI+UY1Xi
	0/oS16+Nh2iLpkTJFeA0CVywAGdWdY4ErPIWAw0NzkyOLFMch7cPave7/F6cMj0LZlX9TA/+ybl
	tiTcgGvp6rqJQKEC0L6x303LJaVy7pH9jXPoAIfluMrV2jQJFrZSoV6KFZPC4iDuwo3AN4RhH/m
	S+0ehXRG7E9Tnj00J/KmwA6FbrfZd4zZAbrzsykds1M3v28ZtDa6V7DLf
X-Google-Smtp-Source: AGHT+IEta6vNkL2qYn4xecoYbGeGh0tvTz8Mzn2/SVZLfq79W+xm/83cjsbfvmppODKW/1L9yy+I2g==
X-Received: by 2002:a17:902:ef0f:b0:27c:56af:88ea with SMTP id d9443c01a7336-290273a5f20mr271822745ad.60.1760493197148;
        Tue, 14 Oct 2025 18:53:17 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm111789325ad.37.2025.10.14.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:53:16 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v6 2/2] selftests: tls: add tls record_size_limit test
Date: Wed, 15 Oct 2025 11:52:44 +1000
Message-ID: <20251015015243.72259-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015015243.72259-2-wilfred.opensource@gmail.com>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Test that outgoing plaintext records respect the tls TLS_TX_MAX_PAYLOAD_LEN
set using setsockopt(). The limit is set to be 128, thus, in all received
records, the plaintext must not exceed this amount.

Also test that setting a new record size limit whilst a pending open
record exists is handled correctly by discarding the request.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 tools/testing/selftests/net/tls.c | 141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e788b84551ca..158dec851176 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2791,6 +2791,147 @@ TEST_F(tls_err, oob_pressure)
 		EXPECT_EQ(send(self->fd2, buf, 5, MSG_OOB), 5);
 }
 
+/*
+ * Parse a stream of TLS records and ensure that each record respects
+ * the specified @max_payload_len.
+ */
+static size_t parse_tls_records(struct __test_metadata *_metadata,
+				const __u8 *rx_buf, int rx_len, int overhead,
+				__u16 max_payload_len)
+{
+	const __u8 *rec = rx_buf;
+	size_t total_plaintext_rx = 0;
+	const __u8 rec_header_len = 5;
+
+	while (rec < rx_buf + rx_len) {
+		__u16 record_payload_len;
+		__u16 plaintext_len;
+
+		/* Sanity check that it's a TLS header for application data */
+		ASSERT_EQ(rec[0], 23);
+		ASSERT_EQ(rec[1], 0x3);
+		ASSERT_EQ(rec[2], 0x3);
+
+		memcpy(&record_payload_len, rec + 3, 2);
+		record_payload_len = ntohs(record_payload_len);
+		ASSERT_GE(record_payload_len, overhead);
+
+		plaintext_len = record_payload_len - overhead;
+		total_plaintext_rx += plaintext_len;
+
+		/* Plaintext must not exceed the specified limit */
+		ASSERT_LE(plaintext_len, max_payload_len);
+		rec += rec_header_len + record_payload_len;
+	}
+
+	return total_plaintext_rx;
+}
+
+TEST(tx_max_payload_len)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 limit = 128;
+	__u16 opt = 0;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(limit, opt);
+	EXPECT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       limit);
+
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
+TEST(tx_max_payload_len_open_rec)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 tx_partial = 256;
+	__u16 og_limit = 512, limit = 128;
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &og_limit,
+			 sizeof(og_limit));
+	ASSERT_EQ(ret, 0);
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, tx_partial, MSG_MORE), tx_partial);
+
+	/*
+	 * Changing the payload limit with a pending open record should
+	 * not be allowed.
+	 */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ASSERT_EQ(send(cfd, tx + tx_partial, sizeof(tx) - tx_partial, MSG_EOR),
+		  sizeof(tx) - tx_partial);
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       og_limit);
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.51.0


