Return-Path: <linux-kernel+bounces-661509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81878AC2BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 01:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D241BA80D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630521D5A9;
	Fri, 23 May 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNUvomD7"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8E21C165
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041536; cv=none; b=nKY8460/pRZVOcxPyJ+Lpf08QWVhcGFqi+E7w8nciMZxI+0Hn7kmWEC4ZlPfsxJYcNR8ybOywlyyAp0rxBz1gxO6eI7uxqA3tQNKDIR3HEWo6krQMSdX/riO58F7AvCuhQqaB13Xp0Za2QN+apLX6WHuQVa33pCq96C+bir4bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041536; c=relaxed/simple;
	bh=0WyWdlblD1opyDXTAcioi+FN4eUkunAJc10HflKJZ/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O1SspBEiV1q4WUxdicCz7zlavQ5tHHMlWEfO8GqY9qm/VQKdyhCkt5OHjof4giPUNtRdz9lnHA1JdBii8Zw37HxAbLTz29MtnK9AMD3znK6aYEDXA3kNO77cDeprXNMnZEKoxOfhSSxsfwt7XCg3eSHjIEajry+4k3v86mmMDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNUvomD7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-745fd5b7b65so230331b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041534; x=1748646334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGa5vpAckjVMn+DJyOLrdnNXFOJ4oaSqmPoGO5u/7eQ=;
        b=lNUvomD7i7tGLs/vaOZUxg6uA6poEZN8LRuzYQd4pL/PAo4Fom3TB3R04f8MBjcyjA
         N23tYzilqGHH/tRF79eP4vP+MUmxTg7TYp+LeTjxlo9zRaRLVu3SQ+CgUiTaK3KVsth3
         43YN09MakutY9jpxGqONFlJSkpRniEjzBKINHDT9eEr/MrcU2mIEXMwLeqyXp/4cl+ML
         gbGTGmWGEu/McnGQypnKZKAowzKwyxUZHXWOQ6zyg7W75upQnprlTuHdN3lw7CceQeGd
         hoWrjv55FGZ16JYdHhBH5//EeZ91yOIaXy4TXl+5Pkf++CgsdCzPJImXlrse037JqBsR
         0l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041534; x=1748646334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGa5vpAckjVMn+DJyOLrdnNXFOJ4oaSqmPoGO5u/7eQ=;
        b=VPcxcZHOiS3y1VK1aUlR2QZYlXy8jBdbl3AUGMiy+1vyGK1ETsjpBrhiQyUJ4fggBG
         p1cDx2mCXb3FFlBkxTv/Ygu61AMDlkmQgnut31oavg0TUF8yB4tQHj3TCuCE+OogY4/n
         XWsXsvubC2KTg9b6QCQJHDnACp3Do3lV0d+aVl64Tm/PUtUvYVtJy2l+YPczsxiakMdp
         1EY1KCWHXBuk101WzXMigKsPpv0p3QOJYpWsz6rDRkL0VVuv0n8TMAXxa8JuxKWYxEVA
         gGQyc4Qmk88rcf9kjmtvMl7qc/B6K8cSK7NObSHxI6vI1hIXJxG9vYeeOAY1opkPrOTQ
         c/UA==
X-Forwarded-Encrypted: i=1; AJvYcCVmSsK1BxR67oeqFLJRB36JV4EzFYUdl+QzjCKXSA48z2TyEKFFxfqZhcowUAvIh5XwY05VFVvCjoX4w+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEov16muz4sBjlmEK3DsRPwfEgPydDK/KrsOLwgqcAoOdVgpj9
	0glBtl1e7TIj71FU+dSH2Qh1jGWERVChyurbPTNPnFpiBtrZxTGH67go1frVzIRePgFQwEdhVw8
	45b/tafHpgCn9Wbiuqfblw4chqw==
X-Google-Smtp-Source: AGHT+IFiPOxxNaYi6AA9Ymvqa8x0QHUR555swbbPaDyHWJAxkZVauCz0orPrUoUSiBGG+ARldTE4WLtzf4erBOqE5w==
X-Received: from pfpk9.prod.google.com ([2002:aa7:9d09:0:b0:742:a99a:ec59])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a84:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-745fe014bf1mr1931755b3a.18.1748041533972;
 Fri, 23 May 2025 16:05:33 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:19 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/8] net: devmem: preserve sockc_err
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

Preserve the error code returned by sock_cmsg_send and return that on
err.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Remove unnecessary !! (Stan)
---
 net/ipv4/tcp.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b7b6ab41b496..f64f8276a73c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1067,7 +1067,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags, err, copied = 0;
 	int mss_now = 0, size_goal, copied_syn = 0;
 	int process_backlog = 0;
-	bool sockc_valid = true;
+	int sockc_err = 0;
 	int zc = 0;
 	long timeo;
 
@@ -1075,13 +1075,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
 	if (msg->msg_controllen) {
-		err = sock_cmsg_send(sk, msg, &sockc);
-		if (unlikely(err))
-			/* Don't return error until MSG_FASTOPEN has been
-			 * processed; that may succeed even if the cmsg is
-			 * invalid.
-			 */
-			sockc_valid = false;
+		sockc_err = sock_cmsg_send(sk, msg, &sockc);
+		/* Don't return error until MSG_FASTOPEN has been processed;
+		 * that may succeed even if the cmsg is invalid.
+		 */
 	}
 
 	if ((flags & MSG_ZEROCOPY) && size) {
@@ -1092,7 +1089,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
 			skb = tcp_write_queue_tail(sk);
 			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
-						    sockc_valid && !!sockc.dmabuf_id);
+						    !sockc_err && sockc.dmabuf_id);
 			if (!uarg) {
 				err = -ENOBUFS;
 				goto out_err;
@@ -1102,7 +1099,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			else
 				uarg_to_msgzc(uarg)->zerocopy = 0;
 
-			if (sockc_valid && sockc.dmabuf_id) {
+			if (!sockc_err && sockc.dmabuf_id) {
 				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
 				if (IS_ERR(binding)) {
 					err = PTR_ERR(binding);
@@ -1116,7 +1113,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (sockc_valid && sockc.dmabuf_id &&
+	if (!sockc_err && sockc.dmabuf_id &&
 	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
 		err = -EINVAL;
 		goto out_err;
@@ -1160,9 +1157,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	if (!sockc_valid) {
-		if (!err)
-			err = -EINVAL;
+	if (sockc_err) {
+		err = sockc_err;
 		goto out_err;
 	}
 
-- 
2.49.0.1151.ga128411c76-goog


