Return-Path: <linux-kernel+bounces-891898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02005C43C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F0B4E2CA1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1852E06D2;
	Sun,  9 Nov 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9yDI2YE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE32DC337
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686385; cv=none; b=kY8lDdRQ33SBvcw1CzKA4j56zB2m19GxA1nXdFLHU4JWcobodDBTdrFNaxwb0sKwY3q+QnJ+kdjTT+mg4Ci4HysB9NfJj60mc1w/pufPwhf5kmfoRg+6wR90aWKAo/MpM1NFEJR5WpdeDRvGFUsl084zvh/9e9S25yNN6/pgySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686385; c=relaxed/simple;
	bh=FIaU/PJYhFPVOHbBtyegMmwlEvrKVznPXH2gtLOtgG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ju9xi20qofDWee0YDjd//Y4Xj8XRrQ7LdjXdzJCtekQous9ANpaF+i4sbAo7TpG4fpSf3Phl6s0Q6zZKE/NiSInoul14pjwqrjpDHncDQAc/u8FnvjNW/R7/5R7grDotaOLXRYfChruwHIcIP4ZQ7NeqQT8Imujy6MZJFsJpPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9yDI2YE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47728f914a4so12320025e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686381; x=1763291181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlM4y0l3wFyRG1MmirgQHO9XDWEVNYNhEnXHnpOtmJ8=;
        b=V9yDI2YElAdYboNrz58iBbVmo+HkAlBMPmr4ZIdodbONCW6/K5YCzXiG/BTwPf6V5u
         lJNdEWTuq+qJStLDuCdKb8C8JHR5wfgWZtojWjPfqx6FnwanUEX3U+s6HnKxu7TVCO0C
         XGyjhUiKrw3OEl+XExNWSpl5HeWwz986iln5uUxkfc93Wby1IqreLLq2i5ii9BQk5GQQ
         RFGfgZTOiONEL8MBNd6xN1gi8an7sSL8Vyrw+kVsW7JnGzUBjLKYV3M9Ex2cVyxNn2BL
         GHMgc4k81Z/wzq6l/IX4tuY8F+FYkMT/nPxN+ZVBUCSAp+g7uD/do/3+b7L4dLSPUCFo
         WnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686381; x=1763291181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FlM4y0l3wFyRG1MmirgQHO9XDWEVNYNhEnXHnpOtmJ8=;
        b=ZF9wnUABxo1KWyE8WLsIpKiAcFmfFUpwiAOjgHBOHgO+u/0BKFR4DjT/yxWkfl/hUF
         eZcDz1wmfjwBUdwfLT64fYxSTrrix4HjtEGEquKiAq8Dz1W131vREFnlrYMeZRts+izh
         dVsXm8h1cKFW1FqkyWJQydfCmzHdhA7vOwm9nI4jbfn0CYO83V+MswYln9/geO8un7Bi
         ZbwMpGYhe/lKc2jhn0F8usTdDLzg3hBkj+zk3fuINxYn+WeZcPPycTT0OzCKcxN4E7CA
         Io3ozB88lrki6F9sCc2JTRypFdVrI+uUhqGl+pf7Dwu4qUQqBh7+SyfdHA9YE3im6Jzg
         Wzaw==
X-Forwarded-Encrypted: i=1; AJvYcCU1NhRgORaoH08bzajLMz/NYOa1rr3Wum1CoJQ02TPo3tnj/RP+LChonGc8r3gyyigDjEnajhm1ZZyIMAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpE3iwl2OmdDoseK8p9OtmA+7+y9Afrgg6fnDOiBvbz0grFor
	IGs8lb6V/VeBwSagOLXpvQVZ1FW4noQjj0ZxZS/cgUeJM0NT0P6lnxFo
X-Gm-Gg: ASbGncuRjP9VtREyoPMlG3v8cHIIqZNJpv3HXQyVhuauIl3AobOYmynysCOH0B1tnKF
	JJC3C0xvBkjp4s/KbpGiFbjq6GKls9khaVqF6ONK2+F+rXGl76e80PziAXdDEtqRTgqUaZaHAQA
	jZnDOVOxZhH0DWD/UgeEI+DDJFzXGJ+4Cu+rDVKP7xVN7CDbg338U2KqZmhgiwCB7rRpw1Hm0Eg
	ymXgTsidMgJdbWJN1Rmh090OBetha8SvoHU8hX3IJZmCwGtJ8/e4+Oe3WsCe4V08PQbN6PYNixP
	46OpOWknV+ml0eQDI+3/wMG3QJDF2jwLI0T1+W8PodZfzv9ziFq+4LaOYZqv3Vpz4lqr40n7NOT
	dGq1qAT3ENgdVIHeE/zjIO6reEcwbv1WxPBI5N/lV3ZUfnYkORaM1Ue4kTBZW10aUkcp8cxSQeP
	ymR3mp67hb+6TRGkg=
X-Google-Smtp-Source: AGHT+IGXNMTWbs/Y2C5fmQZcxJt3PJhVxlTT7teM44/vsz2vWDHEnObq/JmjatlT9IiI9Ya7rMuK8A==
X-Received: by 2002:a05:600c:19d1:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-4777b1661d5mr5895245e9.6.1762686380556;
        Sun, 09 Nov 2025 03:06:20 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:19 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:54 +0000
Subject: [PATCH net-next v3 4/6] netpoll: add wrapper around
 __netpoll_setup with dev reference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-4-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=2197;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=FIaU/PJYhFPVOHbBtyegMmwlEvrKVznPXH2gtLOtgG4=;
 b=jqGwvMXsnTh9gpF8WtcivNejALws/gY5MNBLZJyu5aLSo39/iLcPs/94CM5o+F+o51AXr06CO
 z7GYtxtPn5aC/n5whqJ3xdlIxlszErnaJM35XyWt8rFvodzV+oaW5Fn
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce __netpoll_setup_hold() which wraps __netpoll_setup() and
on success holds a reference to the device. This helper requires caller
to already hold RNTL and should be paired with netpoll_cleanup to ensure
proper handling of the reference.

This helper is going to be used by netconsole to setup netpoll in
response to a NETDEV_UP event. Since netconsole always perform cleanup
using netpoll_cleanup, this will ensure that reference counting is
correct and handled entirely inside netpoll.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec466040..345e74112674 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,7 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c85f740065fc..4d25ba422d81 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -605,6 +605,26 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Wrapper around __netpoll_setup that holds a reference to the device.
+ * The caller must pair this with netpoll_cleanup() to release the reference.
+ */
+int __netpoll_setup_hold(struct netpoll *np, struct net_device *ndev)
+{
+	int err;
+
+	ASSERT_RTNL();
+
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		return err;
+
+	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__netpoll_setup_hold);
+
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf

-- 
2.51.2


