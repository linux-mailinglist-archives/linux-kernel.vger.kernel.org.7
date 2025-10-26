Return-Path: <linux-kernel+bounces-870494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973BC0AF71
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F287189B0E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5BF26C3A5;
	Sun, 26 Oct 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV0C/Lji"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00601188713
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500830; cv=none; b=TIUuLo5ZqgxP0rjGLsuN+52V08HCBoHKa2h4mDHsL5/7NE66EDMfZp/FDKXm76l1YTk6FPNlbX9V79RpxjmQPlRV6G4J+6sDyc7iDJRkUd5RYFCz2dJUOenZ5UU8pCJ2BhZF1IqEf3aIhqPrbTz33JY64u8eEr7xLoyPD2LRaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500830; c=relaxed/simple;
	bh=a+5TfOJqZaa7uINUuLkBAnYsuEfoCPkWzUliS6FwM7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvXv5RSh9hPEF70rXDgyw3w+7ZL8qrTCqosb4Yjtz+efe6rXikUpmIN27wblCijZaWxGZSSQmBHvFzRaVeJjbzXYx4BUxeBa8sc+4WCcaRydH/kcPds1f1nVckN/64hdeIz16hRQZ1tpujp+M2WkxoI5SXLXahlQQRaWHXxZbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV0C/Lji; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-269639879c3so33300365ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761500827; x=1762105627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=KV0C/LjiZP6gTyvZ+exzxXK9vCzPEreIHAyBr+17kfxupcEcFvP7xRof15hazqiaLU
         ZtIAGM0Op+fO24lNEMrNfbx/yo3MOqRhVbOqsB84YVZJeS4i7VcLlvrCF7qepThcxLhC
         jKBIMbsogONHJaY9qveUTIPplz1NTdOeXAXeSwziely8wVaN2rQCwZ5PRTRPIErEUaXf
         NmJ89+Aw7sOfhIGTQp11Cb+EOfcUOlCB9CthIAvs1jLR7k0LZHlrAM/O8WPZ9FZUIHjw
         L2MEV8sBkzeoEfPnvUwfjjB7ZVc7dj5Oe6LFkbdz6ZrfZZjgjkKGqZNSuHsXlUn7Foh3
         JHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500827; x=1762105627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=YliDslNsjjRcse4w4iZKYyT1fyc/Rhe4tQSHVStTY2uHLoCKXAzNcifhw3sIGQAzdA
         jWQtSDDpmRaHC+B6o1G7IvQpZf9RCq3SnZeifQDkS9N8eSgFdJbAJnjwEDV3PjisIKAG
         SsUQbu1/UZvvFjvFQcnVhK4vRNAqRWobKGpr6HyEuUh7QO3bTNMTkbVT2sKO/L9CFrPY
         gH/b3VbEinq0P5QzngPPjK2N0JLcPZvuNoeXBC36+85r1rw8XfP3UMlm2qAHu0L9/Dgy
         wceOeKQgn6yxRgKozGOE1f3k3jXRMoeQ/AgRxfjnfHAhCt+5DQxAWvye52jkdZkzJSl8
         IMzA==
X-Forwarded-Encrypted: i=1; AJvYcCXoKYq24HgtRQl/HOyQNHTfBI0rW4EZXaG0wtp86CwNp4/TAkutGtt4J4t5OxKo5plj59U1xw+SotLi1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1B4N/Wu5gssPdlaiLamElCBjm8SxaACv+plz3t7GOsReypswI
	RiQIgWfoGtepRvFD5VL0CVrt4SRQ70llK0ywsLBRxb6yXbc52LQV1J2Q
X-Gm-Gg: ASbGncuFYtrzOp4u1eUwUt2+U8Tp2/ZcuRIpliPztHwMPrnt1aPNcXD4Ns+4Y6MfJKA
	13tDFwPlqiDjlsfyns+qKlrq1EcInc4FS+MwcD2TR2zkfngUA0pkWhaC9j+BvAK+IN/hnJgK/vu
	Z2mZgrLhc6Vl0ijVnnPyZBoy3OlFBu4voMywk5mwrmpxwkk4MPrwvM0sAp0uxLsTkd2EiLeuKxy
	M6F458ONrYKafOEx+bygn2zng4Mv9NpLAxJozXTTfhGB1P+dIYfdRykZ/upFIfArBeT4qESSVbA
	88Zc4dhyI/c0axA1uZu8lr/tHlUT3t+1ngbfPH2H72TEQ6DaD/K64te7+Evmbj5I3W6M89jLth1
	a10sbBBk35vynywguLkywtD2m53Iej4vWOEalSAFsUes0pKPsC5tqbh6BRrubyehwQtX/hlQlL2
	n1SHyf7mkMz2TDSjEFsoH/4ntpVdFjJw==
X-Google-Smtp-Source: AGHT+IGwYCSe19Ty4P2Kg68LQK9vteTSxPeeGBo2iswWXXEumD1EpQASl9RMMGaFry0bwrT+Y8+yLw==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr503829555ad.47.1761500827212;
        Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09855sm55131445ad.30.2025.10.26.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:47:06 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Sun, 26 Oct 2025 23:16:49 +0530
Message-ID: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	int sd, ret;
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
 
-- 
2.51.0


