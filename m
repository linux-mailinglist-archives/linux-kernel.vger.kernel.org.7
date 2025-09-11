Return-Path: <linux-kernel+bounces-811197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513CBB525C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009711C81165
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB21AF0A7;
	Thu, 11 Sep 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="aAQV3YwT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63141E868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554355; cv=none; b=rn47/N+hEpnpFW2mMwUF56bontlyOzVzd7UyGie06LoW44cITMY8cX49yumbdzBfMxq5s1h0cldrjGIfi47SxZqexWY1PyzJkIIG6bY0LpIkoRJSRq1+eblGSwVoCe6DwGv7H8ZSVS12CK3t9jgabXfPjp0eKiwdgOG0mH2sF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554355; c=relaxed/simple;
	bh=gt3GR6UyNV4r5aWJH1c/czhKwwGNAbJrSYBdjDVgFTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=im8FBK8Yok2+AZw+KH+Sy1lWsjzyKeKi+wYzX+nJK0Z+QFIQoxwG0rDKtQqC8HNy2hmTVKkFKuFGpsTzg/HPx1rsRU/yX8gXDGnHSGPMdtGX/8+nJEj2wHry8vyM+rAQRWWZhXupSHwN6ae+7eiErHx8Qn1W0p5atCFWIbGl/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=aAQV3YwT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so166643a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757554353; x=1758159153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7fklzYjVNvYCZiRA4x1n5IM9vlGT/qGXCUa+CJQyus=;
        b=aAQV3YwTqfUb+2/U4d55TD369Z4eXVEp32FgeR8XCeBa110DPjLlnLnLF7JlWbtu34
         7g8B0iZRNiSCc+xqfSQ4AQDGLYehQqT74aqtCWX/fPJfCGa6NetG3XoCD7iWk1/LXCmJ
         eKIWrWKXCGFw/Oik9esEOGKhGa4rrTqbvgtss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757554353; x=1758159153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7fklzYjVNvYCZiRA4x1n5IM9vlGT/qGXCUa+CJQyus=;
        b=MegjkxT5/lXizpvMQ/V5hvPv/hcAwoj+cYEilyoLZ7RRLyHpTv9vnYtRwWDc/GQnK/
         EPzrLVmTymRfKruBTatM4EstVJOdOLJXI5iy2EsKg327CglYQL3kCXvqw7WHDfHwcUA3
         gNh4g6/3ftl50c+uQNRzb8GHUkrqY0QIUt/kxCGZAkE8VvZtZ9cahecgC+TPXRSkdFjw
         YOaqeqA53W21PFNf41uhnX6JD+6Nn0BBlyii7vTxkhkiPSDCuJuLYc3mEhzNadDYsUKz
         pmNE2ErU9IEgLWmQsTyIWQisZnjLISQQCDF0APCKUlR/wOCoa8JFONW/d7rLAVcGh63/
         r9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWTtG/E7wPYM+3m1i7mnNaaW+0JrggpQVcurmR4rD5KGMmUYuQJo5tyCR5KwW/g1zpvD8xhddnMGwWqROU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8hEPiWuGBLX5CryzmgsidobVPsEP+aNJ6Rkvmj1gAwcXnEin
	+zQOOV2D+zgiDXCJ6Ys0BKJ1HtE/tQTENNt7yKwfKwzUtl7I9gut2HfMoXwd1/wvi0c=
X-Gm-Gg: ASbGncuUp496pbPGMQWVQKbjcPOE9WhEGFFfhEh6DaEV4cHxYy+7y5C4QvDklC8ZO3q
	QET5gf1CpF1ypvcV+MObpzpiMdIQujSuMqYeYKH/2W7cGaFqmMhAslIutRrL2u/SG3nF/AGeBip
	EWJktXZk932uUHpXYpfh2uJcEe2Lgarket2wTWU26RpNbwLIzmdd5YoUMexnCIKNIhGllP9hi2P
	yGJBAUeXDlR+us1dV1b5/vxz0SdjG76Kprlttv1b+SGQuOI0QP7vF7hj3llt1TzCx15hW6BjeS5
	RcFRy3632JJeCP+2htpqf/ewR0xv82WO/70Kkvmyy8V0R7hhIV9eLSgkglAhA8Kth9ILuM58+Wr
	qPwF/xeah7RcRO4n0Hgbut/bVRnBJq03O78EPjezfzDD/G9A=
X-Google-Smtp-Source: AGHT+IGVzk8Rw8wjMXsAOg5SJVgGImPV2xWzKMH53ybxu3zPYT01rllustu1fvGYT2aSN48iChrnrQ==
X-Received: by 2002:a17:902:e74c:b0:24d:3ae4:1189 with SMTP id d9443c01a7336-2516e69a677mr259875935ad.26.1757554353058;
        Wed, 10 Sep 2025 18:32:33 -0700 (PDT)
Received: from fedoraserver42research ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53a1sm1061285ad.2.2025.09.10.18.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:32:32 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH] net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR.
Date: Wed, 10 Sep 2025 22:30:52 -0300
Message-ID: <20250911013052.2233-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL pointer dereference can occur in tcp_ao_finish_connect() during a connect() system call on a socket with a TCP-AO key added and TCP_REPAIR enabled.

The function is called with skb being NULL and attempts to dereference it on tcp_hdr(skb)->seq without a prior skb validation.

Fix this by checking if skb is NULL before dereferencing it. If skb is not NULL, the ao->risn is set to tcp_hdr(skb)->seq to keep compatibility with the call made from tcp_rcv_synsent_state_process(). If skb is NULL, ao->risn is set to 0.

The commentary is taken from bpf_skops_established(), which is also called in the same flow. Unlike the function being patched, bpf_skops_established() validates the skb before dereferencing it.

int main(void){
        struct sockaddr_in sockaddr;
        struct tcp_ao_add tcp_ao;
        int sk;
        int one = 1;

        memset(&sockaddr,'\0',sizeof(sockaddr));
        memset(&tcp_ao,'\0',sizeof(tcp_ao));

        sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);

        sockaddr.sin_family = AF_INET;

        memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
        memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
        tcp_ao.keylen = 16;

        memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));

        setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao, sizeof(tcp_ao));
        setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));

        sockaddr.sin_family = AF_INET;
        sockaddr.sin_port = htobe16(123);

        inet_aton("127.0.0.1", &sockaddr.sin_addr);

        connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));

return 0;
}

$ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
$ unshare -Urn
# ip addr add 127.0.0.1 dev lo
# ./tcp-ao-nullptr

[   72.414850] BUG: kernel NULL pointer dereference, address: 00000000000000b6
[   72.414863] #PF: supervisor read access in kernel mode
[   72.414869] #PF: error_code(0x0000) - not-present page
[   72.414873] PGD 116af4067 P4D 116af4067 PUD 117043067 PMD 0
[   72.414880] Oops: Oops: 0000 [#1] SMP NOPTI
[   72.414887] CPU: 2 UID: 1000 PID: 1558 Comm: tcp-ao-nullptr Not tainted 6.16.3-200.fc42.x86_64 #1 PREEMPT(lazy)
[   72.414896] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   72.414905] RIP: 0010:tcp_ao_finish_connect+0x19/0x60

Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
 net/ipv4/tcp_ao.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bbb8d5f0eae7..abe913de8652 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1178,7 +1178,11 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 	if (!ao)
 		return;
 
-	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
+	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
+	if (skb)
+		WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
+	else
+		WRITE_ONCE(ao->risn, 0);
 	ao->rcv_sne = 0;
 
 	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
-- 
2.51.0


