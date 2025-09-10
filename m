Return-Path: <linux-kernel+bounces-810666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A81B51D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA265A02E47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B93375DE;
	Wed, 10 Sep 2025 16:24:33 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCC334728
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521472; cv=none; b=KwTFQxcHEinS+exWeHGaDEuP/7K11/WgU0KmMZN3tzXlXeKA5pdwf+Z4TO6/s4LERVHNyXKQ5n4M3dJ3SsAQu8E9P3+LBuqo1y6J5KJzB6/qEDg1RjsAQpkYwLeTrpbz4DpNa4IMoqdkSrUCCFsTsWIZsNethScCmE+A6HH/oqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521472; c=relaxed/simple;
	bh=XKhu0ButZfP1eFEp10IuKdFzc3bsJodNLb7lW4zaCgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFz+kVLzg6o4AVKviAE8RTqHVZGseIy/osuMm98ta5CY4myuzDtP4y541BStZyjABnPPMbf+0+X5+u9a4AefWjcoMAZ6CtS0OxqNEDr1gz12KG7xdQjyZwe9ZeWGYmRADzmFOvOCR0AUkeCgYQWscvXrRaygr0yk9g9/WakHfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47173749dbso4903565a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521470; x=1758126270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p83w/Q/IRim7hnms2A7dQTsuzOFdw9GVdjRXWe+p5Ww=;
        b=QAnZG1YFEeSO+k0dogXMazUDcu1HAjnsBtipGZxOWuOiwBKBBBpxne/Be2YlNF3IcX
         EqXJzUzpK9/p/m/ppfAfy3FFdT4fMxcDbvK9I8n15SCDzRoxNTMyVZ34QP+LSPDWF1JQ
         LjFt6ltQGBdS4i0WdGxzQYtNcRcx8W5yHNUqed8a3WoLJrUEdWSJJKpFSq+Q3yDhFbZ9
         YOy7S1qEg6DhNHJcYKl4XV5Dze41mUOX70lLFCsgKgF7psjL4xjk8ueJVd9dj3PUpwrT
         nrg34MBYiFNSVPQvXGilo1EvrZyYUiSv4TbBKJ/6fhNciGaC3yQE0YkV5LxhrPqb9pTw
         fAiw==
X-Forwarded-Encrypted: i=1; AJvYcCURROoRKVro0b0FCZQx5RoeSp5503ekLBpdTexqGJ5dL8qHL3rK2Z+Y6gc3zciq1peclTlxOSQiQwSvoxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdVgv3s/je+GIqw4MH582Gp48zSYUBQPOek4SLMmXMoRJLNR/
	Wo4YeZBZSKJoYfZ4bKfr900xxL13qhiQMol42NboWs1fh48q8AcAeGg=
X-Gm-Gg: ASbGncsL7nhK8DGwn+8fZ764Hv5HBffkxegi6z2yp7eHYoInMwlFFUrVPblbUyWrSaH
	EoJwY9fN7p7Rhxn5doMHq29YGMgLdLYXIOoBB0R04rIiucfem0/aTypYiYCQ2j6huNHv29WEKxI
	tnuNUZrX966smj1CoUJCBv//fTsjUvMqjFokmk+AuYGN7HtLa1uPE68ntvTAP4W01B8BGxrlbI2
	lDhYJn5dv5D8Uil80w5fFaCw7Rf1eRamd8xeb56JK6y8UfUlZ2B9bdnV7mmr2aVS7yUDXMOf09b
	HBtCVz4Z73uchEQ44hS0EtJzwpo151oaMaEaLjnn/SOIA5KXBZcs8nrud5aBSgehcH6M7E+0P3F
	mkA7lUIBm9lsJffeNhaPStuB2jeTxtoxz7X+C2EK5KFmxdusW4fwdQkWJHuIpp77/1MFDwlJI8c
	dF8bxigqKaeulRGH+a1e87n0Ay7Cluv5l+jIBZ0Mcp4SZH1RdIUFUr5IIQP1MfcNj79zZ+xvoPX
	I5P2E3pRLsQNBA=
X-Google-Smtp-Source: AGHT+IFiww+cMWoD4/EmybvtoEqMGorFwlUf88+GYf5wrs1Lt1yUTpI2n83Aakd3i8q2nSdM+bs55g==
X-Received: by 2002:a17:902:ef48:b0:259:5284:f87b with SMTP id d9443c01a7336-2595284fe1fmr78470345ad.16.1757521470367;
        Wed, 10 Sep 2025 09:24:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a27425dc1sm31958965ad.20.2025.09.10.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:24:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2] net: devmem: expose tcp_recvmsg_locked errors
Date: Wed, 10 Sep 2025 09:24:29 -0700
Message-ID: <20250910162429.4127997-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_recvmsg_dmabuf can export the following errors:
- EFAULT when linear copy fails
- ETOOSMALL when cmsg put fails
- ENODEV if one of the frags is readable
- ENOMEM on xarray failures

But they are all ignored and replaced by EFAULT in the caller
(tcp_recvmsg_locked). Expose real error to the userspace to
add more transparency on what specifically fails.

In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
copied=-EFAULT` is ok because skb_copy_datagram_msg can return only EFAULT.

Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
v2: s/err <= 0/err < 0/ since we never return 0 (Jakub)
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 588932c3cf1d..9c576dc9a1f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2818,9 +2818,9 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 				err = tcp_recvmsg_dmabuf(sk, skb, offset, msg,
 							 used);
-				if (err <= 0) {
+				if (err < 0) {
 					if (!copied)
-						copied = -EFAULT;
+						copied = err;
 
 					break;
 				}
-- 
2.51.0


