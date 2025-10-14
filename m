Return-Path: <linux-kernel+bounces-851834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DEBD7665
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720DE19A25F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2312951A7;
	Tue, 14 Oct 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV8F+kJC"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F9264A8D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419132; cv=none; b=fFWfD3WnyEcRfHpjxOEtMePsUZOOX8Il0fI6Qi+GcgFtcraKXbip9c6wWd0F6hoU2FvJN5/u9/cOiMtB0yXTeczahJWc/03wclRmbILUEkdC/kDVZc/e0WyAB8c3VhI69o4U9uXun8WBj0+qzACTmVXsAe0JXavme6xCqb8SLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419132; c=relaxed/simple;
	bh=3CsbX3ia7XbNNJuEoF3K6A0LkheE9pazmG+LEn8/eYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUBscdkZuHuR2IO9mdFHMZXofj6gwchP5z+vzY/UO4trrYahC4h4v1AerHknQgqqs4MIoY7vzZ/+hlBFf2OjGWzE9fv9ohtMYHG1LjXq5V0xbVKCNJyiKews3yhudRC5kc2CaN7yun7cmjLvSfDlncXNT6F74oLLtWi04MbrONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV8F+kJC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b63148d25c3so3232318a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419130; x=1761023930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YUjn19/CQ3vmkmWPkMBT30HWcB60PaZmZPU21N9sok=;
        b=jV8F+kJChhMemODZzFCIkE9v+fPGj1db+dQyE6NTrl5dQ7fXgM7UiE3DOAEJhqS2JH
         /9suU/GKVjtDN0XogYMDhMba8PZZQovjLESk36ih6NR6pLBKK+pBdtbdaQsTEm9z45X/
         Vru4fyaPtlag8qTcddr/wwqNEOD4/LA4dM6G2q7AhHXDn78xj1yV7j7gJQTLLxXIC9W2
         32NNDtORZsVVxN+vdFDI1aoQTerVZBNFgw6udjWUKfEFrptiMXExgDxEB7nVIkukFJV8
         wEQZ/nEDfyrUrmjR4YN3sBBnsCfFOX6vDlsaCJAzLoMfxzIviCh+vtfhLLawPSFhNskh
         i46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419130; x=1761023930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YUjn19/CQ3vmkmWPkMBT30HWcB60PaZmZPU21N9sok=;
        b=fsfAXyqzhX0M7IwCbPTp4sgM8QKtsxYee8jaIvsjAUOOWR4ZyKjLELQsXDoU5h39xp
         jlmBJvFaF8srgtflmcSHlNxBG8u3CobX7lppb1cbabiLPkFyB7Nvhu1BPDU4A+oQkFDR
         vPwuIqituDWGPaZO/keCu9KzYEJJjNNi6BJvPe1F+EFIxoSnui4upZvmqEOz7bbhbORe
         bq34X/CibdVWpCvB6x303VV7MlztWbmN3S+beQgScJrBf6MqohRMGnlD5AVriX2XRSrJ
         p3kHsPH2RwMHYBDrd8XWZ93MPN0iU69mXJyT4csgctTxmv8MoYm358qgxN3Jd3g+kphK
         exTA==
X-Forwarded-Encrypted: i=1; AJvYcCVBN4th1v0J6tiuXpURN69seugCWNyT4wtGHdve3o4DIijevyzj47HzBECKGMRBZozGgKuOHD55i16O6HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiwubFM9TRe8HBJK7GL0NmRfLpGpzYjHvQw7WYQaYfhSpuL+r
	Q8kV4Ft9SlvFDEDe+rPpfsH3R2+U8elhAfwbtv4XgB0bo1pDmC/WXvo+
X-Gm-Gg: ASbGncsUzdFJg32HQYXyJ2SWiYBqvCOLKL3qwDutUIM1oruvHTXcPKjUsHHrWNd5ZXp
	aL1LIDQV8OnxbbpQLJQ72KK9l7AlRUsSF05AkIiKUtdSltOZfJQsgV8jt/QUsNtvy1oLEZnIGXr
	N54BYbVCLpz5sS9rCvI5nXlkUKarb4BWCMh2I3gfuc74PV9EVIjd4IHdGrVG8qUvyzFdvfbNTAd
	B+p4DdzpqlPBCVEFqFkEjmJ9yWeZCbUIXJfzNLxf5CBXmR3wVeUu0ULffvpynGnRp3jf66cTeQZ
	BKoTShV+ZBPgGUgqijMfBDgKkMUjRiZV2mlA6vqHsQTAtj2jW4rBWnoC8sCwmfuwle/qCNix5bx
	JjzZCe6MUAEu/oy3KTH+yn8TMl9eqWk+kFClHHYogAFGjVSmy2PyN7RmHwb2s
X-Google-Smtp-Source: AGHT+IGaEbm5lxh/HwCuu1DSYJL44jeb5U5tWSz8nBNZJovVDaU49e+AZFJiTTKfmSUnqgzmD+dUbQ==
X-Received: by 2002:a17:902:fa0e:b0:28e:cbbd:975f with SMTP id d9443c01a7336-28ecbbd9928mr202109685ad.1.1760419129464;
        Mon, 13 Oct 2025 22:18:49 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08d0fsm151575385ad.63.2025.10.13.22.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:18:49 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/2] net/tls: support setting the maximum payload size
Date: Tue, 14 Oct 2025 15:18:25 +1000
Message-ID: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
maximum record size. Meaning that, the outgoing records from the kernel
can exceed a lower size negotiated during the handshake. In such a case,
the TLS endpoint must send a fatal "record_overflow" alert [1], and
thus the record is discarded.

Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
support. For these devices, supporting TLS record size negotiation is
necessary because the maximum TLS record size supported by the controller
is less than the default 16KB currently used by the kernel.

Currently, there is no way to inform the kernel of such a limit. This patch
adds support to a new setsockopt() option `TLS_TX_MAX_PAYLOAD_LEN` that
allows for setting the maximum plaintext fragment size. Once set, outgoing
records are no larger than the size specified. This option can be used to
specify the record size limit.

[1] https://www.rfc-editor.org/rfc/rfc8449

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
Changes V4 -> V5
	- Change the socket option to TLS_TX_MAX_PAYLOAD_LEN, such that we can
          limit the payload length in a generic way, as pposed to strictly
          specifying record size limit. No functional changes other than
          removing TLS 1.3 content byte length checks for this argument.

        - Lock the socket when calling do_tls_setsockopt_tx_payload_len()

V4: https://lore.kernel.org/netdev/20250923053207.113938-1-wilfred.opensource@gmail.com/
---
 Documentation/networking/tls.rst | 11 ++++++
 include/net/tls.h                |  3 ++
 include/uapi/linux/tls.h         |  2 ++
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 62 ++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..dabab17ab84a 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,17 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_MAX_PAYLOAD_LEN
+~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the maximum size for the plaintext of a protected record.
+
+When this option is set, the kernel enforces this limit on all transmitted TLS
+records, ensuring no plaintext fragment exceeds the specified size. This can be
+used to specify the TLS Record Size Limit [1].
+
+[1] https://datatracker.ietf.org/doc/html/rfc8449
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..f2af113728aa 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -53,6 +53,8 @@ struct tls_rec;
 
 /* Maximum data size carried in a TLS record */
 #define TLS_MAX_PAYLOAD_SIZE		((size_t)1 << 14)
+/* Minimum record size limit as per RFC8449 */
+#define TLS_MIN_RECORD_SIZE_LIM		((size_t)1 << 6)
 
 #define TLS_HEADER_SIZE			5
 #define TLS_NONCE_OFFSET		TLS_HEADER_SIZE
@@ -226,6 +228,7 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 tx_max_payload_len;
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b66a800389cc..b8b9c42f848c 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -41,6 +41,7 @@
 #define TLS_RX			2	/* Set receive parameters */
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
+#define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -194,6 +195,7 @@ enum {
 	TLS_INFO_RXCONF,
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
+	TLS_INFO_TX_MAX_PAYLOAD_LEN,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a64ae15b1a60..c6289c73cffc 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -461,7 +461,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_max_payload_len +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..b481d1add14e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -544,6 +544,28 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval,
+					    int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 payload_len = ctx->tx_max_payload_len;
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(payload_len))
+		return -EINVAL;
+
+	if (put_user(sizeof(payload_len), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &payload_len, sizeof(payload_len)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -563,6 +585,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -812,6 +837,30 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+
+	if (sw_ctx->open_rec)
+		return -EBUSY;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (value < TLS_MIN_RECORD_SIZE_LIM || value > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	ctx->tx_max_payload_len = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -833,6 +882,11 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		lock_sock(sk);
+		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
+		release_sock(sk);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1022,6 +1076,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1111,6 +1166,12 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 			goto nla_failure;
 	}
 
+	err = nla_put_u16(skb, TLS_INFO_TX_MAX_PAYLOAD_LEN,
+			  ctx->tx_max_payload_len);
+
+	if (err)
+		goto nla_failure;
+
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1132,6 +1193,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_MAX_PAYLOAD_LEN */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index daac9fd4be7e..e76ea38b712a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0


