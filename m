Return-Path: <linux-kernel+bounces-722537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CCAFDBCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7B2541145
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDBD2367A9;
	Tue,  8 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlDyNqb8"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEA22A4D6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016769; cv=none; b=EZfyH6t4BELvSshdaYRN07zThFQRDpH6xGGFo8AVW8m3Mwyu3U9AmbGJbJa7WD88VGDSz7ystky3fg0HHWZAOMWnECzqhI+CrRFsZ/D/AS5n90tbbQc8TIj+5yEdDQ+fP6zOCR9kCbV4nbdcZ4bBPYi6FmOZy3aPP7a4Oafphas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016769; c=relaxed/simple;
	bh=mwiBV/idCsfvmqTx5HF7RZa0gRG17/5zmvzm5kr+mN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3tMJKcw6cfaIl28WQN+fYzlklG/4gz8jEkMd6B+XfZLcTTs+SEMlKyM6rLaCqfZ780Rf6l1CITLmtx9AMGQI6qwBqYyMGU8RZ379mBwCqRLEpB+k7jpnRf1QsS11luIk2tDVna1lcRSmUAOsDw2//n+hqHCHSY54mEVRMbpkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlDyNqb8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b391a561225so1971736a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752016767; x=1752621567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgsOVk6pnapxxe4lX2gYfSETOXV/rR5QZNVYZlGdS4Y=;
        b=UlDyNqb8r05INxdxAN/3Hhf9ZgPKVGJhFlaNLetNaltDIXFAlKhcJILgrtv7upkL/2
         tJBw+AjSuRkLsGZRCTCDjPPsxwYcbU/GiIyzLYTgnRNd0znqj6bQBKahvD/hCJzs6XZ7
         fpuFsKqxYjIWDZ07rEG7Wxu/wW39oImL+P8XNUmmXMeiPyyFIcaQeXv2rZ1lBnoiU5oq
         bE7E5sDONTdr/vWxFyLk616BSzLeWFnMSFoQu5Rp6dHmkuxOZC8nhYGbUdjJ6/+E79Wu
         uwTLTQ2AK9Hh2GLzPtcOsseKMQJjA5nSxUfPtdQHdrrphL4QkRr8qb+4bVNU6yqeWJxr
         bagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016767; x=1752621567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgsOVk6pnapxxe4lX2gYfSETOXV/rR5QZNVYZlGdS4Y=;
        b=T1UfL4CHns6lvDCYwIFmDVWAuv0MCZgn5GCS5mTYFecD6ru1SmAU9JCfp6zmHJSURv
         Auho1/qm8Jq8/78D7QIEGINmN8dhLXHefORQ0W5+dFgPOzMIjiJE/AcwmpUv9dmtKRNo
         ylXWWa36WQDhdjw7cO8mR1jPIxVsB2Uyfew6gPxUpvomlp5xJp/gO2q9NzP2leZIAj04
         rmQPU5FAjdiKl/z5+U5SrcHNg8HOtmXZFoetIpD0wkfGbsxVAQ5N2FkZgksCSklzRjNK
         WazOYlRNUkc3fdNIXL5THJgumNAnnTLyVArSiG68XExmV+FZIWE39s0nJkXI4+5V8mLL
         Z6dA==
X-Forwarded-Encrypted: i=1; AJvYcCWnUPn5CH08G+Tr0Li2iNgKdCPgBuPNft7jskRnernPxUBa9SEYfhuILbS9ljTxEO3csGyB1ShzBqX7Aog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypmwwnHTJZJNr+B+CLsROdq9VtiKJtedCV0vB9XxaWwG4IY2K
	0t69tr5E0+Z1ZWD/ObccgLuHNot6HMZ69RH06XYqYWanmJ24zyYx+bQAxMJaX4rHXahkF1x5+bq
	MCG/txg==
X-Google-Smtp-Source: AGHT+IG7zQ9XnoyQh2yDcqTLoCaQHm/hoQKLOGY9SduXB9ruG6XWWO/q3+eH/SYCDCMEMoV6oiKscoNj9RQ=
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:311:ff0f:6962])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5202:b0:312:1ae9:153a
 with SMTP id 98e67ed59e1d1-31c2fdc8eaemr639128a91.25.1752016767675; Tue, 08
 Jul 2025 16:19:27 -0700 (PDT)
Date: Tue,  8 Jul 2025 23:17:20 +0000
In-Reply-To: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708231926.356365-1-kuniyu@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Date: Tue, 08 Jul 2025 15:54:02 -0700
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>

#syz test

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3760131f14845..1882bab8e00e7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -30,6 +30,10 @@
 #include <linux/splice.h>
 
 #include <net/sock.h>
+#include <net/inet_common.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ipv6.h>
+#endif
 #include <net/tcp.h>
 #include <net/smc.h>
 #include <asm/ioctls.h>
@@ -360,6 +364,16 @@ static void smc_destruct(struct sock *sk)
 		return;
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
+	switch (sk->sk_family) {
+	case AF_INET:
+		inet_sock_destruct(sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		inet6_sock_destruct(sk);
+		break;
+#endif
+	}
 }
 
 static struct lock_class_key smc_key;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 78ae10d06ed2e..cc59d0f03e261 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct sock		sk;
+		struct inet_sock	icsk_inet;
+	};
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
 #endif

