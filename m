Return-Path: <linux-kernel+bounces-862521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C58BF5838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47CB18C73B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A132BF24;
	Tue, 21 Oct 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0mU7F9S"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC232B9BF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038989; cv=none; b=KHceTKyanISuBZ4Qf7u8ua0TrQOH3pBfm0T53YuSUbv3cgdbm07i1wHtP9u1dzoUsthpHUB7+S6dV6BPhtUx8dp91qr3bpembjarDmh6ZXHQce7xOwZc3DCQDQlDWNERhk27kcYrLoPfH/5nEbVH7HNyXPP5jSy0CjANP+Tyctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038989; c=relaxed/simple;
	bh=a0aYEnjhpTG92+dnI0WBlUVlRCWAmJ8S6jfAl5OV3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSCiTDCxVXbxxk78cGQsOU2nvErWNG8HWXzxmhHLuMHSdPw9iYfz4YYcQZtGTuGyVp22v0ciVOTHp0rP4qebCM7Tp+8LF0vCk7IJ7LSDANrNZkw5b18r2oT09So91UwbwEw20lxqntndEyi1ZiGAO51fcrIh5VgPDrX2/vR+isI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0mU7F9S; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290a3a4c7ecso57368735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038986; x=1761643786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvR5jT1gTJqYZoXGVwpmZ3jCtyBD10kX3ZPMFN21KF0=;
        b=m0mU7F9ScuY9yV0ke51OMEnR8mn6fnRzvNVB1pZPpObxmNZOcRhNAY4ic7cKPqwGsW
         RepEORdMPadhq7RyuDkxN0eYNGjjc7DelhO10IMeKcvf9ms0banPOZeOIOBy9vy78o6R
         kWBTA1bl1zpoTDKttQTaNfvTOfODb6uSOCLanSc9Zwdz2diOEFYZo+/nQCUQNqTcl0vN
         WybJLuIxSGnxdzqb1H9/x3fUVeWMU1xhRL1/RqC7+WDEQDAufDWjN9C9VPcXshUrMwi6
         i/HU2VXaoGbYqu22edL+lmM+wMRq3rcwAmPqbaka6CT12IvbRJr9JeirO7JP4a7+75iq
         dnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038986; x=1761643786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvR5jT1gTJqYZoXGVwpmZ3jCtyBD10kX3ZPMFN21KF0=;
        b=WzULfc3eMJAVnG8vM/jDwQny0G5dwc3UUpqOyOLDqBSBOFcRHcurNBNeqLfX5zRaV5
         06n9W79X8cv8moiiXZr6j1V7nNdamEqvQ2LXLa6N0h9+kL56FD2GgGllhkCc1Z4K28cG
         ydTzXe5i2yMmsrJJ1aLdzrM+gBiWidzJA92og9yZEdtTFgWGHJZYrEQufBy+XX2GOl3z
         5xTdDR21FzXi5QTCcjwJWjpZilY4stLtovQpwR9nkw/NJPONSwP5UW8yomBetnNJ7ygA
         P600xBrLgLEQr5pzDJNzcCpuIGUNlb9SMVkVsMhJ/YkIltJMHMbMy4NItbtVxnCeGJD2
         O4gw==
X-Forwarded-Encrypted: i=1; AJvYcCWkzOyyH1T1Id4vG1usWvm2H657YBGlx2YW7jkWX69AHSXbQB9vQ79laPufff+3K8gT80vgML1I0suKv7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLE0wBHMTfFG7MCfX1QfP764H4v7AjwShjO90/xUZfVyTg9rS
	+vqRh+1uYP6spmPt2+WGPJV9dccYdaMUijWD4AbcgKPYM393kU2JFI6q
X-Gm-Gg: ASbGncu5zJDHsKe85O/fEZDT0/F66NEUqYXcTUDvBmb3/scejSC/83j6uehmEXd38i0
	CfuPUc/4zyzKOuDmm5nEyHexHSxMrPx3qr48Tp55YtZoze+BsV9qhhd1xZECuLjfw8A3LnHR3UJ
	+hPldkkCvYFpYIuCn0EmdnVE04jOyTKR20QsuA9dcbZNBNubIAY0zU6RlPtAOUlc7Y2azKdbAWD
	rmZWx8Yg3IooFgSrT9OsqlkzejPHtn3TxtrH4xWAiq94g1MXQ0pBuusvI/0gWG/DTOdgIqPEg8y
	nkCP5qmvNzEVENvaSXbvV2QYeaylVR70ls7IGBqMNkxrX1o2zl4p9lCuSgcm/Ss1W37+y2AQH9x
	g3dlTWi9tNZLDhzUITxZUwaCl1KK07T0APyv8cUrg8N/etjRQuFv1rmVAsp/Dv9JPjLQIvU5+vq
	hYmvL9bEFhIRbhByU=
X-Google-Smtp-Source: AGHT+IGNpCqiz7TPzWCbt9/AmNXXOBYfhN0gHSeI/H2uNi+8T0qW2fZHA/ppMSHGKcSUDizFe+92aA==
X-Received: by 2002:a17:902:c942:b0:264:a34c:c6d with SMTP id d9443c01a7336-290ca121a65mr193635025ad.37.1761038985547;
        Tue, 21 Oct 2025 02:29:45 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc83esm104497195ad.38.2025.10.21.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:29:45 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v7 2/2] selftests: tls: add tls record_size_limit test
Date: Tue, 21 Oct 2025 19:29:18 +1000
Message-ID: <20251021092917.386645-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021092917.386645-2-wilfred.opensource@gmail.com>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
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
V6 -> V7:
 - Added a TLS 1.3 test case
---
 tools/testing/selftests/net/tls.c | 192 ++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5c6d8215021c..d256668b35bf 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2856,6 +2856,198 @@ TEST_F(tls_err, oob_pressure)
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
+TEST(tls_12_tx_max_payload_len)
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
+TEST(tls_13_tx_max_payload_len)
+{
+	struct tls_crypto_info_keys tls13;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 limit = 63;
+	__u16 opt = 0;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls13, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	/* TLS 1.3: plaintext length should contain the ContentType byte */
+	EXPECT_EQ(limit + 1, opt);
+	EXPECT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 1B ContentType -- record header (5B) is not counted but
+	 * we'll need it to walk the record stream
+	 */
+	overhead = 16 + 1;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       opt);
+
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
+TEST(tls_12_tx_max_payload_len_open_rec)
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


