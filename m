Return-Path: <linux-kernel+bounces-859806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F038FBEEA63
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96980189A1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FA1F4C8E;
	Sun, 19 Oct 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR4ermD3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4897282EB
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893243; cv=none; b=iPyMcOio2yRi/IZPa04lQEZKJTSEPkTV7FWFLLa63P/+P9BLYS84+zW3cj5EL4QU9dX9FU6GMMBFloxWeOylEiJFUFLImd9iQmPnnDjH/AVCV48ultZuHDKvKvEXu8khiIDwPs2mS1SMvtax2nui60SRoumzNIYLqLTuvqACG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893243; c=relaxed/simple;
	bh=PjDgNxlVxpxvR/toQXufEhgWxKZPOIL82AgrEwXPxEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKy1TzviFJIXTeytj4mpMc6QCNPJQFCjvS6/zI20Fbi/EgGsRjHIOdcLZ79ECGv3rqDvmaSjfWQ1WKrjxWHMnSj7AhJ9gkOUYYb9TLg/DWFJc41e0hVtmy8oSI7eAbT9KPNcmw1lhiRDDYl6N94IxIV/VcKkHczZv8yg10J2XKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR4ermD3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f04816589bso577410685a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760893240; x=1761498040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1WbXALuGbpcuO9t7Qwi5yHTQM+NY8K1Dfz/3nuG1pE=;
        b=XR4ermD3fHK61ZGdIi6YEf7r0voAQtO13H6y17xAT3uYM7LMw6rvDylJMe1AONK2q8
         kg6OIFClDNJqNW4/3RNFqpG3tovbqpuu7LcRpwwi3s3C8W4JoH3eCP0W9oyZv5IHESGh
         sWUdiwgDGL7hNpN4VZvl6sMG8HGMMiDIXtwPgiQ7St3jnt0u1Pc/Vr+08o9fjPoma17c
         INFc+TS3RQ/XAgN1iCqvH0ehhi311/TIpyUWFNP4QmmAJ26IUsYfdBWEzcC93YUAQHUH
         llGxPxN9DpsinJ/6iII16BMObVvaSuch74vDYW72V/HgeBvrgwxyeBlQbm5LfePpN3/E
         dXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760893240; x=1761498040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1WbXALuGbpcuO9t7Qwi5yHTQM+NY8K1Dfz/3nuG1pE=;
        b=WVRAhr3f1rCG/2lJUcbOqSrhKVuLaUXexjkspiSr/r1/kI3YaDl4FTUL7zxd/1ovLf
         eSefgX+kHJUTIrYNxJ80ZYSJw5F5NiOMmgoZUozKIoaWpf6RZcDFNvZ1F1Fj6+SS3oCu
         wFNVlCkqIne5zkAkXz9OQyYS/OCNfmJwWPPtTLKnELjNdPtoVtF0VaSGsMjUDdq5IkPz
         nxTljD6+h8itUfj4v6d1qYaOl2nQummMamCWhTUwSsnjo+ZuJ2J1hQcxk5Uc6geR826d
         AdsLcMqIpcduMm4O/2PDgM530NIMnCeskf8RaueqCHmCcy2GwoboGnWS18WeAnOAS312
         B6oA==
X-Forwarded-Encrypted: i=1; AJvYcCVyt0lzRm3utXRFVlkLw9Fth5fRVHGrnRpWlPQ2u/CgylQwJwzAIOO8TNH0SX/ffpway/wf28SU6FXnT2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ehNUAnz/pe3W73DiEm2z+NDiEtKSlGfFAjYxpKxDVUNOHzNn
	X45UC2DcpuDk+xDHum1J9FFjb5WgpZl63b7bDTJVwm796roYsyl+CZjA
X-Gm-Gg: ASbGncuMrwQmT5NowwGJZKB+XkH2TG+r3DUJglSJNuBSGTGBjdDbxhtxcGLrbOuiWWz
	2vo4tAOB/xsI6txoMvMKicT3Guti9IykbmCfGgeKAvVAHc5oF/tBN5NwNGmQQQOFoqWXijZmvp7
	ZOBIKCbfkkWVZiMKZVw3+YSbRLqS8r35LoLR3jDrAdkDGjKY905yyr/rp9hb0zgiPmyJrNxNxeZ
	SxxmLOaVPi3W707s0/ptAmIrA9WEgOoSDvoW4YzvzI1kyOplgJtMslqCX8bm9cVb+hifHSWLJtP
	q0l9uAN0Ku2DvMFyqgWVTuzku/IAplhfKMbt9xjoFqNM5YqsySfDKovnYCPwSk5LxY4tzkZ59Rp
	wIX3i8Z7g/rKAZLXSO2VwZ+85CQ5rvJ2I3WctZdeDGlfAAifv7ipz8E8wItTVoOikijpa25zHF5
	s8eUB0JTj838+xvA==
X-Google-Smtp-Source: AGHT+IF4pq4PxQqmtKO4E4OsIVb1+IunUUBbkT5Zf3jvPepuTm4doaYmgj46bpXYCtJDfNkY/xDyDQ==
X-Received: by 2002:a05:620a:46a9:b0:891:9b1b:2792 with SMTP id af79cd13be357-8919b1b283emr942055785a.81.1760893240464;
        Sun, 19 Oct 2025 10:00:40 -0700 (PDT)
Received: from localhost.localdomain ([47.85.44.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm384446285a.29.2025.10.19.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 10:00:39 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
X-Google-Original-From: Peng Yu <peng.yu@alibaba-inc.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peng Yu <peng.yu@alibaba-inc.com>
Subject: [PATCH] net: set is_cwnd_limited when the small queue check fails
Date: Mon, 20 Oct 2025 01:00:16 +0800
Message-ID: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limit of the small queue check is calculated from the pacing rate,
the pacing rate is calculated from the cwnd. If the cwnd is small,
the small queue check may fail.
When the samll queue check fails, the tcp layer will send less
packages, then the tcp_is_cwnd_limited would alreays return false,
then the cwnd would have no chance to get updated.
The cwnd has no chance to get updated, it keeps small, then the pacing
rate keeps small, and the limit of the small queue check keeps small,
then the small queue check would always fail.
It is a kind of dead lock, when a tcp flow comes into this situation,
it's throughput would be very small, obviously less then the correct
throughput it should have.
We set is_cwnd_limited to true when the small queue check fails, then
the cwnd would have a chance to get updated, then we can break this
deadlock.

Below ss output shows this issue:

skmem:(r0,rb131072,
t7712, <------------------------------ wmem_alloc = 7712
tb243712,f2128,w219056,o0,bl0,d0)
ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
pmtu:8500 rcvmss:536 advmss:8448
cwnd:28 <------------------------------ cwnd=28
bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
pacing_rate 27764216bps <--------------------- pacing_rate=27764216bps
delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
rcv_space:57088 rcv_ssthresh:57088 notsent:188240
minrtt:23.319 snd_wnd:57088

limit=(27764216 / 8) / 1024 = 3389 < 7712
So the samll queue check fails. When it happens, the throughput is
obviously less than the normal situation.

By setting the tcp_is_cwnd_limited to true when the small queue check
failed, we can avoid this issue, the cwnd could increase to a reasonalbe
size, in my test environment, it is about 4000. Then the small queue
check won't fail.

Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2..8c70acf3a060 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		    unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)))
 			break;
 
-		if (tcp_small_queue_check(sk, skb, 0))
+		if (tcp_small_queue_check(sk, skb, 0)) {
+			is_cwnd_limited = true;
 			break;
+		}
 
 		/* Argh, we hit an empty skb(), presumably a thread
 		 * is sleeping in sendmsg()/sk_stream_wait_memory().
-- 
2.47.3


