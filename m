Return-Path: <linux-kernel+bounces-885251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B0C32640
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E9E189A687
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6433C532;
	Tue,  4 Nov 2025 17:37:20 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DC337BA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277839; cv=none; b=NqWdhgMuQqwIwUhhfiWntzmEb/e6WMxqdpb7z9u6a2CTaesLpn9OFKr17jwED2+4v1r5XVWYrVulkoaVecHHB+w3ebB9bgIRoZihvo2dFHSiK/qBx8TcODpTujAFnInOsgCZU7vmAmqzSXcazpFR7OtYovOXKCzRXXG5o9qRhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277839; c=relaxed/simple;
	bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0jGoRmFAJlKFLztifl/y+6qhfugRbz7GMfLyALJ9U2K+D6sPeGZU+J0qJmDnABMh6CNAI03w49zZI8qHD7HD7AXKee1MDzKZTCF99qWZE0MEiHsZvldwxPzOacZLme3iTTc/SnYG1HcrPDZFtrixV0069Zu8UeZPqiUClxfIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so862907166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277835; x=1762882635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CR8vj1NdfmaZYiunLULz9OPZOynQvbneaWGWn09HLE=;
        b=H0waxjmaYqoJGL+HiVslUWt9axc7KsJmzaBXdGDfcMO7tk67jyinJjLILT3ceamU7/
         TQ9dwq3YoqRRZQd9vqIF4+PPN8v9DqN/kV5i73l9xvYQXVFK9/u1LcbuqapgFNOvnf1U
         zBPyiFCq2CcrfOgJJiPMXdUewv9/KjtyaeONPvKcBKBOfHaxJEz3/7JBiBkTWITTjscd
         sj/Q5ahanDPTsq1wU/tW1zo68FI3JqtORWL4MvZG9OJHcDftlTMdYcX0ttW/LHNjphCk
         Sf4gs+9nie9KL3txYwJYZ5tdc6FMMkw5Fi75X4HcX9NuUxQcg/W0Z3scR7S58acrNOpx
         F7+A==
X-Gm-Message-State: AOJu0Yw4o9D5QwPAYh+DC8n5R31YGys4BDOeXFw6uY15LHmCXGojWs1A
	IrR170itoXnpUinN0mHWgtKivQYt4JUWs8//mQ2vB/sQZHMtp07TqNsj
X-Gm-Gg: ASbGnctS2rBfKkAKgzMRp/aSXs/eLO8KnZq4JWX4iZBD65bRHoUGkFGtRbAmrCbPApN
	g7CiP7O8HVa/ofDXpWZnliV8bmpj//Tegph+QYuxyEzj+HW4Z3wXAS59YiBaW81004sFm8PnXwJ
	xCJec531KaD5Oh2CavlmivXZ2r3fbhBBLEemXctFqBTCUX+dy03emMHlUkYcMv0K6tWkBrLIuLa
	Uzk6C6Mx8S2nzYOF+W58RnnXiLrI4shQAgriZqugiHpi3Aua49tZgOH6C7awfVYLee8/UN7AQJM
	YsBz9yJVsBgRmodNCe6VNLjf7cHtio7sBAS8N1sqKMvBbdkasMr/ME/tyU7zMVy6PYaHDFZv88a
	aa+WhltHv27DjOXyEfAlYarnvnxaQDQSI3ObCIHRcrkVGtwwWyBQBQbSOLMQBvC/IVxA=
X-Google-Smtp-Source: AGHT+IE+KnBxhwGNobJbXOr3K4zGMGNsa+Cd5ngofjNn+43VHAR/eXIXKEd6sECqqeVT51t6KX+9bA==
X-Received: by 2002:a17:907:98b:b0:b3e:5f40:9894 with SMTP id a640c23a62f3a-b7070874d79mr1554101066b.62.1762277834442;
        Tue, 04 Nov 2025 09:37:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm269697566b.46.2025.11.04.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Nov 2025 09:37:01 -0800
Subject: [PATCH net v8 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-netconsole_torture-v8-1-5288440e2fa0@debian.org>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
In-Reply-To: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHeeVoXRsgwHwQxnRxXWEeemW2sJ4EBYmsX
 y0FXGk6XqaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bW8xD/9odEMuK5OOwO+nH8x80k1edBZ74y34rQI2QWEZU1+pz6t9hqDFimbRJORBD2CJlKH1OIG
 EKtP6o94T8IHeHR4rY//SatjG4tq9Tmq7fj3mVpCei12OAInLJEmQR8YA2DbLKFSwHu9uxIuWK2
 UwWn7FSSH++VREpBmpGTn1JRzBaQLqwDl6Zeu6jw5+6w4M+oLmOVe3XNY8VUP5HBvnUjLn2z50I
 aVK/78Q7c6LFft8MfihDZJ8ZbzSA5FiAea7NnDP99Yc+sSFi6X+vbyIiwC/zNJvm0adr1WeNvFa
 4ky30T9rfX0C8DLUj1usY6Cm1MR62iW+7dxt7eTqZgOVLQdbEFHbXUypOqbvNLp779hIJWPtDsx
 fD6dfWrV76sINNh2F8pSOdCuMEr+pfcaMmnVYTj/JEP6SWUV36U5jd8xSGR8AQbHAzTV7vNj+Gx
 GSluVBNukhZcy2xBibNIHPnEDZKJvu45VrY84GRfez56BnsBYVBX+LPNZspslsHi2z/HZVSfvOz
 /eRWArCW5NTmy+ys7wE/KtuNRhmvmYw1/Wbwm3XHZGPINTr5ca34zYI7BHthLFuF2Ih9XOas7W2
 6+P5v5lBo0s1SSg7ejgni0V9EWE8cGrax6vTZYvVGlh1A4JeqIJYTYlnGDVYFoxz0xt3xw0lOCi
 xrknU0d2fveKVEw==
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


