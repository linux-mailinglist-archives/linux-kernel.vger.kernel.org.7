Return-Path: <linux-kernel+bounces-863900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ABABF972E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E277C35380F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CB1CEAA3;
	Wed, 22 Oct 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXE2nZnh"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F219C556
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092425; cv=none; b=AGaYOd3r+otzqGNJbRNrRlyyuR/+FWAsfwZR+/yBrXtr40ZmTzsxVJ52x07JOirlv8ArADDDq+U3g5CccphonuAejuvhrgb3yqIzxEaVnjcl6J8q4k8eeuAikPzr7lE8Nsq17yV0ilLdThF+Fs3DYDsznxRf9XZ9PxntaqOeLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092425; c=relaxed/simple;
	bh=BRXShLW7W5/j3n6WXYzW3QS+Q7LioQIoXr7V3X8QlnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q31WZt6Tep+m369rEv3omGZujHGheIjSuwPO1XxvP9jgrhMGQRhoxPTlmF0JK9G8RPYYwotOt3LefkidJf82Hirei3ZYC/OLjord2rHq5wo4EkdycwMCcldxd0xk4Bq5eQ3YWQFThIa9+BRPSVulBdjYlm2H/p+0nyHgYqc9NnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXE2nZnh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b57bffc0248so359354a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092423; x=1761697223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh6p3zPmQiUeUqLIm43PW7u/eg9Ryz3Ek/pj2nzImMM=;
        b=KXE2nZnhkem3LmJNhkglie6PeX/ZuWvOGV3X0MET20RmDD+gFiVV4vcRp6q/e16luD
         NLlg496/XIoFYgrhISvc+XqVGYNoxetJn+UD5DgYwxC0CzIoEc4tJMwsPCk/QHriqQF9
         HEcTXSs6/EgGR9/ktX0eHld4fig6k2R+xTPX+P+BrUihxh9wZftYlwfUmRfWE42E7n0f
         /g1fIdSg9MJBOPUQ0OZwz3rlQkrU4T8kCl/HLpXQ1EhAMEgB5enyMZn+0fi1WCnwyYx+
         JiVx8QzniwJcUqVnsDIAwd102+aC3/WZM6fRUKQHdEcAkU2AQCBVEEdUEj3rnhMO3HXD
         s8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092423; x=1761697223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh6p3zPmQiUeUqLIm43PW7u/eg9Ryz3Ek/pj2nzImMM=;
        b=KAXuxl4c31Z2Fl4YktIu2+RtyioOy7YNGueGY7CpH9Svn0LZfzmedFoGFGEL/fd1QJ
         VNQmGetzH1FzwKkPc3cfhdfK8gtHoh1bpqsje6ef9OLLKMHcrHseZuCiTEq7ViHHhHpi
         y5Mydjg9z+N6TSaZs/XKynJfVNwYC4xXpV2arKqDjkqhYapQ9pABQfWo9Fu5g5EVuvGY
         mLqyOLvUJGDfNJiN3ijkebo0yCBvgy9VFnFBHYK21GilFSADqGniqYeI/66AN1tELKOO
         QjjKqOLIMmd6do81cQXw4Je6b9b0FI0DFANthtCHmC6q2gZaJcGkRgpzvgfsq9RkNrM8
         c74A==
X-Forwarded-Encrypted: i=1; AJvYcCVpPZBUc/iQwE2483Yn3wPldsi6GZpZ0ZFZ8xcXtgd+3fuRhyYJH3TgJ+1n7jHAlL587xTtFtOA/7l+P9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3fDnCdn2QVKOqaeF98RLaoTNEYLVOYJS+eraKvTbcak7pOnO
	lnrz5gdKGDMqkuCP3nQgJou7H7shabbJAGjX1Og9qzIHd2/7LHPunKRT
X-Gm-Gg: ASbGncsXl7hZx34APvQ6XKnu92QjlctgbQHcYrPCclytJ+SiXMa26oaxIylRjtfKbM6
	UFssUFfDyYQvIPPBjk62XvQCSNiaKnRrjQbh1FKEjhmecrZW1HDbFdKlhZPTohQ6bQ/ozbCeiEK
	q+GJ1Dxfl5ynVCjQo6iKgZWiId0ZW0eFyJbXTQVo1KtMGKbx3ZuALG7R5i0odeSwf+4bLUF9taN
	nslLuJuwQcGbt3jKySjxsLQH/CrxCDTLDovccdJ8UhYLbB5Hx8gy6sLScdl0uBL/xCGO8Eevzyv
	BxwT7IRyFGmKWv4Ngv5OskAUn1hdfQ/iN++SmF/9GYcvkx8QtddDad7CDkxcrXaxsljVHlu4jsI
	8J00q0gdB6/UtnO5DXD1L1OXJ5TQz50HXEDOlmFHfkYhgMZIukeIBMp9qgXlUdXJOUuUUb+bFYc
	+yZ4wjkXG+
X-Google-Smtp-Source: AGHT+IHNz+zoQ+2Bi98EPbJTECbCqeGyTGzZFef/KyQe6e5Dp6oW7yPraB1RU49wPYv0mxci6bnbpw==
X-Received: by 2002:a17:903:249:b0:267:44e6:11d6 with SMTP id d9443c01a7336-292ffba4632mr18972615ad.6.1761092423350;
        Tue, 21 Oct 2025 17:20:23 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm120759805ad.91.2025.10.21.17.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:20:23 -0700 (PDT)
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
Subject: [PATCH net-next v8 2/2] selftests: tls: add tls record_size_limit test
Date: Wed, 22 Oct 2025 10:19:37 +1000
Message-ID: <20251022001937.20155-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022001937.20155-1-wilfred.opensource@gmail.com>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
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
V7 -> V8:
 - Drop TLS 1.3 tests for the removed getsockopt() changes from V7 
---
 tools/testing/selftests/net/tls.c | 141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5c6d8215021c..da1b50b30719 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2856,6 +2856,147 @@ TEST_F(tls_err, oob_pressure)
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


