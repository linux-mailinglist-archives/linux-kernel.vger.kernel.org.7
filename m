Return-Path: <linux-kernel+bounces-784034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185D3B335CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F173BC1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE126A1C4;
	Mon, 25 Aug 2025 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmwmgxiw"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031411C8611;
	Mon, 25 Aug 2025 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756099543; cv=none; b=JNtCi0mQBSwiF4Zp2IcZMCXSAOV12cS+HgzypydDMpGt5ezFFDlJYXv1LDx6rQ323QrsSVNwXfwXPTRYgUzl4ZhtIDQCktpTCXYgcI4+DY+ZWBSz3JfeHi+9Zp5WNxRjTgOiZ1biQp08n7yAUCyDkcK7tb/6jl2HRtsFRqftUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756099543; c=relaxed/simple;
	bh=ZAcdbLQ0iyVUzfiAGr03C2vqyVWqD9wx7Xywz+cq5C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EA9/mDR94oPvM7dOge6vwZst2SE8MJtwqHj2Kyi+JMW76p1WAHm/WXVDjzY3BzLZgALZSEx6okUzk0eEPTcIUcO2Jw5CD9xQD62JKpBdd/r057BqMEoPB8ru/arZSFJjO6n9aZbHpzUNtiiLrpc2XlmlCLc5TRP1L4UkvO/wYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmwmgxiw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326793a85so2652441a91.1;
        Sun, 24 Aug 2025 22:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756099541; x=1756704341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suaHsbXLYkVG7j8SRoSurmF0vxyD4d+T76ESWSwaceg=;
        b=dmwmgxiw4OzkrU1IwNxiz9VcSxxfZrMk90pQY8Vuki0qH5qC8m8xbSW0yw4hkqFybf
         DGFREepTxIKr7wvzyi7YtWPy8R5FxFsB9xWD1/ZlMTUsjqSOpAToB6tx3Ter8qWQShZC
         GD4d2W3MJg1+ng2UoDK2fgftM+7rL7zhhEmr5aA0gyIFTIHismKSuxBRuocLBYBgOIio
         RKp8of3TrbtVZGBqHyJ1HuNgPhkqWH0c2OiCogXE6j1lBGMV2aDWyUgcyTcScKfTq016
         F/TzhNjTDxP5Qq2VAs18a6mEbnWJle58zzruBOWUASV/pfiEZ8bqulitbWaUrmmMq7+1
         +FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756099541; x=1756704341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suaHsbXLYkVG7j8SRoSurmF0vxyD4d+T76ESWSwaceg=;
        b=E2ByV3RPV3aAvJwMgkIH5GbQRYmaZad1VTlxfQKM92jDT7wB6I4jnEJ9WuJ3pB5Ls4
         Qm2VGT4pyI3s+d5vUj0+nZlJKICpQ9+XCeLtm14N+BEWUwMIjYZQuPylzAjABoquLtL0
         KxTT7h8NvaGFHE4H4BjBIXW2WAru4HwUfdkBsjmA0RvQHx1/tcwgM0yN5kbPwP3vx0EM
         qoudp0X7oT7nXAo//x9JSspQEgaNF0CTmzc7T82Tkx7gh9hNQUz9jN5kRX/uU2+AyCxi
         YAKgbdgjN7TH0pWwaX7p5EhhAwSQu7eHKTbqelUALrsDFqgUplm6fmAZDPISvIYX6DNJ
         /KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvvGf6KOcjjvHkutqsJldUQqSDAR9Gs8yBUPGGxIJRslf9nLg7qFgoeubQS9ex3jvUJ7pCpkkNomxapJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfbv4kkPi6thuCbGzFmkjNuCMPObm5B69n1PdvwnuZhx9HtY6
	6D8cPnF3s8L7EdQDpJDsAW3t7wev/SWk0xcLQMil0X+1S4WWsFKytsZnKRudtQ==
X-Gm-Gg: ASbGnctnlh8uNMfFPyxKFT1lrqTZngz6dug9VzQW/pXw23MThxxY3EYD1yJ1BMaD8IP
	RQWcn2ffGMkOIcyHuvk4Q+u03PrbLHdZjzY2vdXfGIlihdX1e755X/CgWlK8xKXudi1CZ/nn2BP
	pObN24R51ahpyR+/5HI4D3UHFgFp8lC+I9yIhqEqv1GI8JgiQisVm490gy43VOEE0fjmW44eYLH
	OhV9jA0zF3hekIyIYyluCst9NbSgIqRoUIkbg5xZk819YfiH4SYWt2o7rptQZ5neDOhAWUzqRKa
	mTKdmzw17jBI4+ZjH6ceMru8/QXjghPWgORXdMxWySgOvnyw1ApZuiwka+QbcwxKfusaDUpZs9Q
	KuZFzvgjykFG7/MwJpwVOw+CKSLKLjpfMrkcP5Bw6l2u1Kws=
X-Google-Smtp-Source: AGHT+IGJ4JmALmws5IcfFCk7d2ae3f8ZduUxCQMzg/ds7PfsHARII/oZTShmZ7PGnHFulvVUL/o5qQ==
X-Received: by 2002:a17:90b:2810:b0:325:4c48:af54 with SMTP id 98e67ed59e1d1-3254c48af7fmr8715482a91.11.1756099541085;
        Sun, 24 Aug 2025 22:25:41 -0700 (PDT)
Received: from archlinux (201-13-80-9.dsl.telesp.net.br. [201.13.80.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae9ea3esm5842769a91.13.2025.08.24.22.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 22:25:40 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [PATCH] tools/usb/usbip: fix spelling mistakes in usbipd.c
Date: Mon, 25 Aug 2025 04:17:39 +0000
Message-ID: <20250825041739.8117-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct two occurences of 'seperate' typos on comments in lines 399 and
520.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 tools/usb/usbip/src/usbipd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index 48398a78e88a..3e22b651c754 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -396,7 +396,7 @@ static int listen_all_addrinfo(struct addrinfo *ai_head, int sockfdlist[],
 
 		usbip_net_set_reuseaddr(sock);
 		usbip_net_set_nodelay(sock);
-		/* We use seperate sockets for IPv4 and IPv6
+		/* We use separate sockets for IPv4 and IPv6
 		 * (see do_standalone_mode()) */
 		usbip_net_set_v6only(sock);
 
@@ -517,7 +517,7 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
 
 	/*
 	 * To suppress warnings on systems with bindv6only disabled
-	 * (default), we use seperate sockets for IPv6 and IPv4 and set
+	 * (default), we use separate sockets for IPv6 and IPv4 and set
 	 * IPV6_V6ONLY on the IPv6 sockets.
 	 */
 	if (ipv4 && ipv6)
-- 
2.50.1


