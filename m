Return-Path: <linux-kernel+bounces-867218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449BC01EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8912F3B26A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489C33030C;
	Thu, 23 Oct 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AahZCQgi"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376A33291E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230923; cv=none; b=sdkZ5nqvqUGnpRiE6sr5Nxeq2y0+KJXTxb8uvV81MBmoOymbIlMRScZ8klLfQlqrdUknCEWn/OzzqLCFmsyQmXch3GGK+AR9r6+8WBYj5WsEx4erz+BXkLq6bJ4oSKxLeJqDBttNwFFPV9t21af/6H4SiSkqHgo+q/HOZuOycrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230923; c=relaxed/simple;
	bh=dkFalx35Mf7Ek+Fkx2R9b5eye892DdLAQIXR7osART4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc0noZR/8QBWHtOQIWshaPLl4WW85EMSnZCQE/X9S8szdzTGV8CdGaRqrRIQI2G8cZ5MFac/xCrvCyhIusOxb/kTUx8+ZkIs0NxegGYVgXBFFIOf8C2Y9YQ3VLZrnKkMGfwyGTW2+zu6g1aYLrdIDwaPJ4ZG2pLciUzmDkMy8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AahZCQgi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33d896debe5so1160157a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230922; x=1761835722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIyY0jwm6XINDoeFBx1e+QKbqj3iHSEYcQQKVDLzBek=;
        b=AahZCQgigInt18CzimkQzS7fm1Jsg7vvjabfSvE+CtBKINbREkkUtT/drKmlvuHJeu
         xss1X+cqxIib5+ki4zGVvBjRQxhLOQjnUbkXksj4d0ewo3jTfYgo0IbTFrb1qDor6E2d
         0P/On70TnntK6c1Zx6WhvNKUskjKYqRSKDiBsR1pWK9r5cmCsD/dOvgaUSuINGxAo6S1
         tkmcl+yv5/289leB6N+gQhIm90J1z871YfSLHBRsdg/f+oAN+WcOXut8figzin2nPIor
         dwSTbTDQk2VLoWwtVXKWSqFFKgmKojHuHygIwhKVvVg7MGnQIX6Kg2q7l/7kq2HGsniZ
         Uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230922; x=1761835722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIyY0jwm6XINDoeFBx1e+QKbqj3iHSEYcQQKVDLzBek=;
        b=Z/6xgHGpziTd44ps954T5IMdTunzBZwYIXX7zZdJmlEEsfQoB8U276XoGKiEw4HqH/
         LhRYU1jAXMEiZJCmeBjlqM36c5VXV/7M8uwNvMH457sjS/e6kkg9r3tLjkKvY3YJky9D
         2QAWSiYd7b74I/ge3RdZHU9RO661wp/i16gMDkGzs84cgOq6irTOeIuwp6l9ysxV2XBT
         a1CjXra2vV4UoP5tuwq+kKHqhBFaK4YMhf8zx1QsL+mD2IFzQudybGW/T4owNxnJU3Tj
         wSMwEyB0UIBs+y85tZ+udatpxx/lnLKXCkxmgle6iZdaqFpdYr4e0UHPEqaZTLK03xLK
         PwWw==
X-Forwarded-Encrypted: i=1; AJvYcCXbE2xyjZ3Uv7xGzhEnHFuT1gR4cCY+U6KVXbuOVoLVhVesBsHgfUXJpjNhNQuXThx+F4qUjU1D+wDe4DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwScyFQ+KpWDRKLH4sV879WVtt9aGiFG8BfHGkZqGZ8XT212rG
	ExDhbym9heZ4g5e4W9EZ9eeMJEOUIWpEqS4Btb4PP0Ge40jldzmNHgc5
X-Gm-Gg: ASbGncsG+NcnqmsFgiLD8PhMgjqj3OzdXczPxoEdeTF5I/X1apNsDTzQ6igJ+mPZ/eh
	cg5q9QBv8bMpCg9o40fNvhRDjoTuxOC1DhUMP1jwElJ52uPadnOJlJ6MhhFBcHkbby4VvdIk893
	JNBgyydi1upvN3Qwovodbr/2B5H2DQ7oaCKg01zxr/b9JWSPFDYpmXDNeG/I4FyB3A1VEr70hjl
	3GQdxiwreNQJ5NSkdtUB5gIa1GpWiCNpbupDC1KY8NcMf0lm3x6Rw4066pzEheLKw2iNCf0iGDN
	Da+/Ql/emXpEGPBK2xsdtAV7nNwuS+uusa7E2DDOixSa59YgDAWMuMUaHpXA0Bmyt001/15xzvd
	hVGQLYSbZ6SkboeXtEa/j0DiaZGwUoR2BmafZX5I+P5H2FCcC8EptY3HwiSzStGsfwFQDOVKU3Q
	C6Iq4YBmBzZmOzqQkXuARvtB8=
X-Google-Smtp-Source: AGHT+IEXALud1vKs7yhSWKIJW7KB5/rjyWchLWdA7m4PkitrT3UlKVgb0yRvPH+Kg5clS7uGqXVOgA==
X-Received: by 2002:a17:90b:35cf:b0:330:793a:4240 with SMTP id 98e67ed59e1d1-33bcf918506mr28258906a91.31.1761230921710;
        Thu, 23 Oct 2025 07:48:41 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7f1sm6045716a91.14.2025.10.23.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:48:41 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [PATCH v2 2/2] net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix
Date: Thu, 23 Oct 2025 22:48:05 +0800
Message-ID: <20251023144805.1979484-3-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251023144805.1979484-1-wokezhong@tencent.com>
References: <CANn89i+0bmXUz=T+cGPexiMpS-epfhbz+Ds84A+Lewrj880TBg@mail.gmail.com>
 <20251023144805.1979484-1-wokezhong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add packetdrill test to reproduce and verify the permanent FIN-WAIT-1
state issue when continuous zero window packets are received.

The test simulates:
- TCP connection establishment
- Peer advertising zero window
- Local FIN blocked in send buffer due to zero window
- Continuous zero window ACKs from peer
- Verification of connection timeout (after fix)

Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
---
 .../net/tcp_fin_wait1_zero_window.pkt         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt

diff --git a/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
new file mode 100644
index 000000000000..86ceb95de744
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_fin_wait1_zero_window.pkt
@@ -0,0 +1,58 @@
+// Test for permanent FIN-WAIT-1 state with continuous zero-window advertisements
+// Author: HaiYang Zhong <wokezhong@tencent.com>
+
+
+0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0.000 bind(3, ..., ...) = 0
+0.000 listen(3, 1) = 0
+
+0.100 < S 0:0(0) win 65535 <mss 1460>
+0.100 > S. 0:0(0) ack 1 <mss 1460>
+0.100 < . 1:1(0) ack 1 win 65535
+0.100 accept(3, ..., ...) = 4
+
+// Send data to fill receive window
+0.200 write(4, ..., 5) = 5
+0.200 > P. 1:6(5) ack 1
+
+// Advertise zero-window
+0.200 < . 1:1(0) ack 6 win 0
+
+// Application closes connection, sends FIN (but blocked by zero window)
+0.200 close(4) = 0
+
+//Send zero-window probe packet
++0.200 > . 5:5(0) ack 1
++0.400 > . 5:5(0) ack 1
++0.800 > . 5:5(0) ack 1
++1.600 > . 5:5(0) ack 1
++3.200 > . 5:5(0) ack 1
++6.400 > . 5:5(0) ack 1
++12.800 > . 5:5(0) ack 1
+
+// Continuously sending zero-window ACKs
+30.000 < . 1:1(0) ack 6 win 0
+
+// Key verification points
+// Without fix: waiting for packet timeout due to timer reset
+// With fix: this probe is sent as scheduled
++22.000~+23.000 > . 5:5(0) ack 1
+
+// More zero-window ACKs from peer
+60.000 < . 1:1(0) ack 6 win 0
+90.000 < . 1:1(0) ack 6 win 0
++16.000~+19.000 > . 5:5(0) ack 1
+120.000 < . 1:1(0) ack 6 win 0
+150.000 < . 1:1(0) ack 6 win 0
+180.000 < . 1:1(0) ack 6 win 0
+210.000 < . 1:1(0) ack 6 win 0
++0.000~+5.000  > . 5:5(0) ack 1
+240.000 < . 1:1(0) ack 6 win 0
+270.000 < . 1:1(0) ack 6 win 0
+300.000 < . 1:1(0) ack 6 win 0
+330.000 < . 1:1(0) ack 6 win 0
+360.000 < . 1:1(0) ack 6 win 0
+
+// Connection reset after zero-window probe timeout
++0.000 > R 6:6(0)
-- 
2.43.7


