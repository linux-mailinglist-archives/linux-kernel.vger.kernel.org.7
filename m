Return-Path: <linux-kernel+bounces-885673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1659C33A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B62464D67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1D28468D;
	Wed,  5 Nov 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBqY/or0"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79B23C512
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305811; cv=none; b=IeCq6TR8UTavaKTqp5BPdDvsQaaXIoFx18EG7SWb2SCChkiNRhvkQtnW+jdwAWRzg9FWsfid9yxsiVGgZNhbtmm5Z++YihNk0PMkzvaoYiqcNVLYUg4yNO2Q53dwTEtIj9QwSd2hXLPXR/hhYKCVEfnwYWU69IbRC9D6ktBa+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305811; c=relaxed/simple;
	bh=yCIkyL0h8kHUFJCTSyMV+CAW54KfpLm6K2H45fUhKZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFGsA9ZVIEu6n1m41MGEe6Qg/sR1AnG8tlxHqqWDvVWVIb4tEQgFdg9pye+mC35jUpawlbWIOT7FiyAfHdcWQtO/NrHTtGMEG2kfIeXugk/vRDOmsJLshXTj8Cxmqob2x0c+kxNaP+k3/mBMqYDeuKvJIQZ9J1Gg71TUTMhzEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBqY/or0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786a317fe78so6631257b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305807; x=1762910607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++wGl6enUw/dRP6YEy+waldxVwK8Dc+ChAEagCck49g=;
        b=dBqY/or07iDvxPtc+MG+dOBb+UIttyvVsX0qd+7HffYqxVfQuf53ekC5v0nGmVUigx
         aVG2aoDMq4LwMvj5T/RQZpbaTAnPhC06C8/aN/W90TaJ4NmPLNhQhVS3F24GdHLPpBin
         Mucifdvh2YQiiN+FuzxetELN5cBdZKNrmKCK9intXQItXjPZ7P45q0mHRNyAFhHcCQyk
         +m7a0jvuryS25COdeiFxA7OetXAOzCny1nS2ZjQ9wqeMSuCUXPna4T36aiQbG0q8NB7T
         5OQdDr72xb2W9acG45zbK+x53HeiWqh5QJYP/rY2H6gRtBu0IXp2C+wygRQ7J3u6IMw9
         CuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305807; x=1762910607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++wGl6enUw/dRP6YEy+waldxVwK8Dc+ChAEagCck49g=;
        b=R0al9abM/zHPDcXI7fWiMzpDN1fQJER+orwritnUtcFj1NQzgixyjpFnm8eOekuWiD
         UFQ6Q8f4YnlRXnk9Hxb9hHen6dK3kAF7ZZgsz5zxzYEzqg6kb7yLkwiOljsYvthqUWQ/
         wrEFAvXXwrEUik2tU7ulLlPjztE4kz9OLG/strd/viuTsio3M9c0qHDYTlwwRoFfrgJs
         dZgv1APEptAtMBKwuRRS/mOSDihxP7y9lQOdz2vV5s3j4kIB7yqANP4qeifNUWr/6dTv
         3KET6gi6/1CGzIjzaPeJQAgeQQ16S8DObyIMAT9xyFUr13qzukkvKKYuYU9xZFTAWR6K
         Mb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjVhKPl/h6w1N3vywT4mCmp9Re3dgdqTIB53Adz6StU+NtK61UhTaRbM1LkCUhPIp8S4sZZDByILqV6Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvB8PTKVmO4Xth/v5Uwk0doXg8vtpqtwxzsmRlKG2Zgey7ZEtK
	1haHUUH9RqLUU+TA48cDWkLBZacHo8KAFFpMWRw5E5ctojCHA1pzogvM
X-Gm-Gg: ASbGncsYLAwDCoQKCC+yr5Sw4e5rpe7y+FbmwLuP/hlT9ywg5r8zfKI+gREHWccWMg+
	ddy0ClerfsygWdnGc7GUAu/dpfkop6OeC9iRWuhz9g4H/ey54EJh7aQg0ZZ1RbYZRLtCtaaXccr
	MfXz1L9hWUcjV1H3pva/Gt672/PjbXtjyvYDGIEGOQXlgsbAP3pl2sQx6WvonPtB/1/fDavcAmi
	OWi3pYRkbV6WY/g1vOpRQGYFGbXyZQL9OUJL31H9NpxKhLehRrm+mgzWl/GMQhTrpNchflgX1JQ
	zB5md0ao1IRdShrCyBLKKqpOqttBNYR2Itv5hXWPEptqckHhNidPvA0ZTxZLs1j8oKvcYMJViHK
	hdlsWjK/CeipbtSbY2o8svSvcJQwC/kiukV3/NiZhdUzfzQR9hxWrCz18sCrHciP411kLw0ETaC
	m5rFR51svJ5+c=
X-Google-Smtp-Source: AGHT+IEQJ9WEsquzTbokNdx5L6vycggE3/QvpfsVJ9sSnQ7RONk0w2fr5nFci2oGs61wzZsC3j65UQ==
X-Received: by 2002:a05:690c:6111:b0:786:61c6:7e71 with SMTP id 00721157ae682-786a41b3d21mr16312747b3.33.1762305806699;
        Tue, 04 Nov 2025 17:23:26 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8ef92sm14967307b3.5.2025.11.04.17.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:26 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:23 -0800
Subject: [PATCH net-next v6 4/6] net: devmem: add SO_DEVMEM_AUTORELEASE for
 autorelease control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-4-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add SO_DEVMEM_AUTORELEASE socket option to allow applications to
control token release behavior on a per-socket basis.

The socket option accepts boolean values (0 or 1):
- 1 (true): outstanding tokens are automatically released when the
  socket closes
- 0 (false): outstanding tokens are released when the dmabuf is unbound

The option can only be changed when the socket has no outstanding
tokens, enforced by checking:
1. The frags xarray is empty (no tokens in autorelease mode)
2. The outstanding_urefs counter is zero (no tokens in manual mode)

This restriction prevents inconsistent token tracking state between
acquisition and release calls. If either condition fails, setsockopt
returns -EBUSY.

The default state is autorelease off.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         | 51 +++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c                          |  2 +-
 tools/include/uapi/asm-generic/socket.h |  2 ++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 53b5a8c002b1..59302318bb34 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -150,6 +150,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_DEVMEM_AUTORELEASE	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index 465645c1d74f..27af476f3cd3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1160,6 +1160,46 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 	return ret;
 }
 
+static noinline_for_stack int
+sock_devmem_set_autorelease(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	int val;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	/* Validate that val is 0 or 1 */
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	sockopt_lock_sock(sk);
+
+	/* Can only change autorelease if:
+	 * 1. No tokens in the frags xarray (autorelease mode)
+	 * 2. No outstanding urefs (manual release mode)
+	 */
+	if (!xa_empty(&sk->sk_devmem_info.frags)) {
+		sockopt_release_sock(sk);
+		return -EBUSY;
+	}
+
+	if (atomic_read(&sk->sk_devmem_info.outstanding_urefs) > 0) {
+		sockopt_release_sock(sk);
+		return -EBUSY;
+	}
+
+	sk->sk_devmem_info.autorelease = !!val;
+
+	sockopt_release_sock(sk);
+	return 0;
+}
+
 static noinline_for_stack int
 sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 {
@@ -1351,6 +1391,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 #ifdef CONFIG_PAGE_POOL
 	case SO_DEVMEM_DONTNEED:
 		return sock_devmem_dontneed(sk, optval, optlen);
+
+	case SO_DEVMEM_AUTORELEASE:
+		return sock_devmem_set_autorelease(sk, optval, optlen);
 #endif
 	case SO_SNDTIMEO_OLD:
 	case SO_SNDTIMEO_NEW:
@@ -2208,6 +2251,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = READ_ONCE(sk->sk_txrehash);
 		break;
 
+#ifdef CONFIG_PAGE_POOL
+	case SO_DEVMEM_AUTORELEASE:
+		if (!sk_is_tcp(sk))
+			return -EBADF;
+		v.val = sk->sk_devmem_info.autorelease;
+		break;
+#endif
+
 	default:
 		/* We implement the SO_SNDLOWAT etc to not be settable
 		 * (1003.1g 7).
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 052875c1b547..8226ba892b36 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -496,7 +496,7 @@ void tcp_init_sock(struct sock *sk)
 	xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
 	sk->sk_devmem_info.binding = NULL;
 	atomic_set(&sk->sk_devmem_info.outstanding_urefs, 0);
-	sk->sk_devmem_info.autorelease = true;
+	sk->sk_devmem_info.autorelease = false;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index f333a0ac4ee4..9710a3d7cc4d 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -147,6 +147,8 @@
 
 #define SO_PASSRIGHTS		83
 
+#define SO_DEVMEM_AUTORELEASE	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))

-- 
2.47.3


