Return-Path: <linux-kernel+bounces-841232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A33BB6926
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B37E34543E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5E29BDA9;
	Fri,  3 Oct 2025 11:57:24 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8E27A919
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492644; cv=none; b=g7BUo/BhN7O1sxYx7yhJpSgXQYQ5sF/rSt7rNQqLmg9dBsdMHpdpOBw/D1XKBkkftObwfEPlW9i2E18QRlPiYYYwRrw9QIx9Nv7CPY1RmGZvGVBag9FtmTK+ETtcFESdEGspEj4GFPNUy/mgyJ0ph15yQDMjvOIHNAEyPIXWVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492644; c=relaxed/simple;
	bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qpd+uZfFF+gkt1IJupolDK5xBmIl/0mQe7k1AGmyxsCPD2u4Y67LI/UvGmwRcZTwFpQhYC5hiw/mXmODWn9NXyDbgcK3tEgp9loprL0+sutT91qWS1v8ARThmXAyn6ICd6iY89Pg5gsN15t8v8zcMUZtf+F+pf6XVpCFSLVRRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3234316a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492640; x=1760097440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CR8vj1NdfmaZYiunLULz9OPZOynQvbneaWGWn09HLE=;
        b=wnyKnLculZ/3rlZ7WNi7OX+cm7Si9QBwXmjKwiYq8Peeiuy5EqGzkv3MYE3obkNRCu
         DO95SytSBbI1N4x4JdRSWMUS97HSbn9BqSGTEoAW/DexvTWPfoGknikPIEGpGj87SVpL
         LMLL1kg/bXgjVgRitnYztABxOkK/8NJbV5XJ5oTQN444WTgDKJScsX8MLM3p5tBIgVlJ
         GsEbgcWKLHNN09eBjQjXhH+2pJ5NT9tMQp4ZiIFz7ZJowdYdx0oCH4YJqirIVpOToy9Y
         RJ2pOnEyvSOwapM3MKh6aD5oqmd/9cAm5rKiIkfDzJmM7alz9TDw4qnRTIIm7oWg/eD6
         7AkQ==
X-Gm-Message-State: AOJu0YzdcFACVLUjqZtwmJPyb2NCmypRpsdiFHJZ+dYFab7KP7Vos6Sa
	kPuQP/R52GriGHQV5S5JzUgF4twKWI794O17KLtaE45soFLhIflyIiVp
X-Gm-Gg: ASbGncspizlv6coqn2GkjR+DNK0X1PmppjVM8Qy3C2Bew890bM7DG0zPiXd9deCNwYT
	RVXiD28HOkFCPHC17GApBvOtZx8qgC9l+VyOldfJf5XQcwPSpCrwJe1PlKxefZpgm7oVPidY20N
	4XcIri21PUsGlwS0zTzCepm80zBbxO/UrntXmWKwMhbkI9S4qFPUUdagofNXxx57MQeNnWKubSv
	H21aA93vmd1uWXRSEvmIoK9kqLIBnIHX/R9yZDMtcqxPVwKh9t0a7Qu0p0N3zde3FwN8gf8CaD7
	J+Yi/wc+R26bs/tRWiMTXGVGSXpzRuOrYVMU/3JxGYg82dyGu9QSf/x26juOw+OcQiO2YDjamWF
	nQqxF0smKzxA0QIvh+fdmI4lBgANMOFAY4+P73AxpmU2lbUeqrmysJzI6kuo=
X-Google-Smtp-Source: AGHT+IFpV/823baDEnkWXtsZgJSHpqM6pPT3docQw0LYhsvgAr/IMB0l5Cup8boOngZWnvghRP3wEA==
X-Received: by 2002:a05:6402:3585:b0:638:689:dee6 with SMTP id 4fb4d7f45d1cf-639348e6e8amr2796933a12.8.1759492640334;
        Fri, 03 Oct 2025 04:57:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788112bbdsm3866461a12.41.2025.10.03.04.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:57:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Oct 2025 04:57:12 -0700
Subject: [PATCH net v7 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-netconsole_torture-v7-1-aa92fcce62a9@debian.org>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
In-Reply-To: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=leitao@debian.org;
 h=from:subject:message-id; bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo37odYpsGtZhECiITMdqo2bef9kXbNLlvzWt0x
 +wCDxTkUSKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN+6HQAKCRA1o5Of/Hh3
 bdgOD/90PhNiCa0N3WZOW/7jGtNYrv0KINyhkhZpziG0lqMOooyDWLfAnC7GZQ8blbA/k4TVdIw
 RKAScM2pqkO0f48vBRrpkp+9wwxZeoAlMLBJziTp728hFfXmPrYxJpmUT17z/MLg9yxE9YQHr9t
 JG4V3ldShZR2RSZbbhFR9umA5gERU/yyk+1Vtv2F+7kQglhr0F98RiYkEEqGkKDZ/UUTXGEEiE8
 u9nHKMfqCt8AcVHfoqgjI/PCcaBqqGBS1L8mVLXydW7hpEXvLTg9uKkGRcTF/njLEjXnoWYRSRq
 pMIMBVDG6SGMM06viMtX+Dak03BLE+vE04Y7nddcd6YYDDzXnnce14xRq5bXpkV2yDG4MvENurX
 qFubY6S+ChXUtS99c7retQ3oL1OVwAJ9gO73KYKlifFp9DbFBzPJmPGhjXosEzytwnVSkY7ts5/
 en1rQWqRVbBKYExWUqlCVBnJVJgx0tyh1FmlG5usw80CpGiJZZQUFHt0C/OWR7vdVZHL+P0gQ77
 pncLW7GJlQumUBPtundGviRV9ai/ahvsFfxlu0YXu+bSeCE9Y7s1v7pOk4nfMhck6gOWJfrZsbE
 XciLMbijeyAmbMFVQT3f+O/4KVwArgyV0gtO2OeYO/0O5ZV9+qQw0GFjZDKgEnCHdCHG6oZShDa
 0bQ2VxuiYLF6B6A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..f4a0023428265 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -814,6 +814,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -823,8 +827,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


