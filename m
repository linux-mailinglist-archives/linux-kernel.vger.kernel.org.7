Return-Path: <linux-kernel+bounces-820727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A08B7EBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514D1525020
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471236C065;
	Wed, 17 Sep 2025 12:52:20 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFD32898A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113539; cv=none; b=CUOWDjLqMENTY6JFZdEmbQwjRkGfVBv8oRW1GI0zlKuwqgzuc+BFatgI8zNuN1p1vi7+0w//QQvxncLyiA6u0tnbH81yJlQqjuTkRpveiCY7YZoeyOKYUVo/jThYKZIFNDa8tHLEy8HVuAngs1W7kxNW64+Eg6NPRmWOXXXuiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113539; c=relaxed/simple;
	bh=0qblMs7pvAvukMaqH1XZzSc/HsAgRmJmnlAnkCtcl+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQwj0HGoKXlnIbgN8iJ3jBDQw+vo60G4+hIp2Zpa+d2iIKz/HyZ4RZYFhSYvVfVYyRPiUXjRIgGfDy/11EUid2tp5lx3WF1RZ0pPXlqAz7GoR+HgUB2J9jIKA6R0VLnm63RqDJ4Fc6UZ7EKfBmoYawFu4Jp4QFOvEtAz/bTmPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f1987d4b2so7984685a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113535; x=1758718335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cRw8y8aLRwmgMXJrfhUT0H+SQQUEvdJ4IqhIR3aLXE=;
        b=uXueQ8KQd6pmMRNKDrH1WYGpwKFoBqWRPS4sLEKgzg17KGJmFIkVQnfcj5ghbjXR8t
         n33Yb1XOimWR9ao/+HBNXHfONN0Q8dXN44yZDKXnWfxuJfktzpyySO9LZ6jw8CR0JbVA
         3O2q51X3Fz7VUkKv1M86Zo1rrGqw3Rg7N1/008vFwMQrqIiBrqE2aBhU3mUNgYCRP9XH
         5UB27aWU+Y0w50ydN+kuxc54JDm0dL3F8AYw9/B8pclBVokKdJ2xHBZH9MR98qVuAOKW
         SGysDfVPWhtD4p4xg1ztrqk4eJTpkqFs3w2BwiLkGUCiN+PH1hQgP3uh6QPDy0ASnQ4U
         LldA==
X-Gm-Message-State: AOJu0YxbL54XiDaeMf/BbjzBZy112eAma8iQHicfMZjpK+2mgVil2aQJ
	MCxSOgPEawdvj00hTghf4Qty8lp50s+hJxgUubGEPuPx+y8U9F0eLO2y
X-Gm-Gg: ASbGncu/xKsh7SkbpZzZEo9fvT5wjvOX3sI9qrFcnSwV5lr6wr89KmzMYM8uuCMAoaY
	35aB9kiWtb8SZY3tNnD61R7c0Vqm6uxdvhbfyZmZzKTGYi7NATX+ReWeIwWt6t1X9dadARBu5ae
	8BTVuHQzSvg7asBbTCQRvKmp7Ow+5614vzsXlzUilZdL7VoCPpkUo4avWQNsUKm74nOMtvHKy22
	wzWa64ykjInY4pQwWyDMKwEIWwRw3hAUk48KRV0E4iS63oFSUySoKrFawMNJYLbAUCA0LDYh2so
	2ErEl8gQZRx53fQ5MkcMqlysAHUhUT3iBM9iCqHiVl9W1PNOGwFrdmMEVoYqxv/6VC9NcnDu+Hb
	WkiwgIwhvXHjB4w==
X-Google-Smtp-Source: AGHT+IGcKNDtBC4IjzRF3C/1A9WDY4PVAXhCw25GqLowT2AP0xhnCrLG2vPouzAemnf5ULAz3hkDMA==
X-Received: by 2002:a17:907:9444:b0:afe:b311:a274 with SMTP id a640c23a62f3a-b1bc106eff5mr256536266b.46.1758113534737;
        Wed, 17 Sep 2025 05:52:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1c11d45587sm114087366b.12.2025.09.17.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 05:51:42 -0700
Subject: [PATCH net v4 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-netconsole_torture-v4-1-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
In-Reply-To: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
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
 h=from:subject:message-id; bh=0qblMs7pvAvukMaqH1XZzSc/HsAgRmJmnlAnkCtcl+M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77ikqYfP1RsaQ1IywqQvoCiFOi9x4LHFf3b
 bZdGzWOyqiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bSuvEACZOgjHa9YCJXRrUCYSe7rbbAYJhxe8eWRbe/mAXDcoBW+xpoh1HUdkdE1BAw7KwCch3f7
 Cvf/tCZ1PG9v+NXgAL8A1R9jwarbT2vNayZo3f9ynePau6EOLiptAvpyqr/RoNvmoF7GvF4ELz9
 wLx8oNvpTzgSNv6K2o3SEGxewOQweLFfIo+9BOHlJvlXvtm6J4f0MaMcgHiGz77YxM3BYKfNlIj
 8RY0q/NZCmalRYOMAvonH0AJkLXJvwGKVEH/k1rgFTK7PEE9ayZV4sfcjBE74CUOAjQWam4FFIg
 2mDTwda3SsxX6zzrNx5FPuQmMYhFCWDHqPwTm8dqatgr3VYnOCOrNRHmICT+S6g7W2CSOdveycJ
 ttTlVgfnzb5nskzsZCipFeIx3K133loOfy2StaLgIcGcx6XM4vE4vH43DF1Wj+uzzJiLm/E3wzp
 sMjRFKKqgwBxYZizTWVnwRWcax3N7iMHLyA4e7wkwX68w8EEnqzUKpBdVNcFYaALDTo4eR1LvDj
 klGCoybhLWEBaAlEwohhAInLBwj/lJeg7lln5Y3DkWaU8z8DPCBcvc0i3y18oSW4L/rii7zaa+b
 Nhd262M16Gx8Xt1rG4YQB0qi3HzB0GrqDifWCYwgFIaSYRaXi8ilp1/xfkZmrx9IvLnSojLcDbU
 2eehCEHIH6FtR0g==
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
index 5f65b62346d4e..19676cd379640 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -815,6 +815,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -824,8 +828,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


