Return-Path: <linux-kernel+bounces-878236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F93C2015B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31AD3A46BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9A340280;
	Thu, 30 Oct 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYy0oVJR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6834DB57
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828601; cv=none; b=RlDkf8qbX/I14AodLsHZ2QdSkCMbi2cNyT5eshLS5IfiMXBVwVDgpAPSwU/G9ArfRFHPmizUpsP7vc2c0HMJyVmhskKbQ8dQ2hDH/E9x1n5iFtBt4syGNzEVYS67eNXEPU0FPDB3y+45bvH75HvFWZbyyYzfbPwelObGiLg8Qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828601; c=relaxed/simple;
	bh=dt55WpFBV5UxK0sxkMP8HWK7ldl8BF929rjZNtdvook=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtUcbEdq4i8VHx9lJdcjEcwf14zu7dVajvIf7V/C7UuyrFVErANfHlYVuJWEuE3ER5qMsiQUkionXlgzdOGytws04Dii3x0/cFImhAa0MXpY8rC3nH6eBtmnVez0rJlMSGNL15b0vzpaLXlkYn3olkM0baoLU4iMa2cKQBhM4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYy0oVJR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294cc96d187so12585065ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828599; x=1762433399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS6Cz5sFcZlQoMyfcKzu9jrax3W9xaylmCamMrWFtlM=;
        b=aYy0oVJRC8bgt8V5YhF2s8j11R/nq7wA9cLqoR5HGKio7HZC32xR5fet9uRtKAPmgR
         eumdJ35fXTEmqWbH1atQCmqhKGVsuJBwo6bk4bD6IIcZUcYqoo8bQtGzQbOU77twpsb1
         YF7ycP3te/bKdaRC/2SFWQcwi41FlCt2VpGzqxQVN+K1RD/sRu21h2HuExGu1TvuRmiL
         epZP3Pvb0+es5yd4FKxBZ22/LNwqNGq5PWqPSzP+MmW6MLMobchktPXHwNt1O9RwgMFk
         I1jlggbiITDgIeIlELX/gsJVK2HZiEkd248HbhuFvDyrX24RQbgyFEJs1ByDOTlLguLw
         vcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828599; x=1762433399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS6Cz5sFcZlQoMyfcKzu9jrax3W9xaylmCamMrWFtlM=;
        b=FDcj2OiUzMlWeR1LdkrYrxUM+OeSZG1itPGoRaI1iWqmWrffbcO39nvmu7JLNFBhDn
         KMUhTB8+Y5dPnNK2hDBomEhkn5XCyDEKooSm/VzDdDAbXNYhxCWk3tGwuvO8wmSUjqrB
         pCfjmeD52x91+OHn8rUuBQzGngv8CAZl5or+f1gjplO4Ol8bT0tFEY128g0mtWlQuOiZ
         KMB0q4aCGBjkeVwmHzawB8jh0onb3dCZ9PzWf59zkdD6523ARKOKN23ztPNY6S88OrBu
         uFd4T8dk0ZA0Fr/dPeBY2u0unN/PlEPQbTakS+Vdk1SJpfpfz99TOWAz1tfetO5i3f35
         hoOw==
X-Forwarded-Encrypted: i=1; AJvYcCWep9RUgXUoWDi1vpWYDGNbY1njxeu/DiCa6TJaBc5JfwUbEn0etBRAiLZgWBmPHT/T5k7kHgO4RzYSSy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIwm0kbRMk6In8KNln7hCKk7q49Wohn+SUlWD3ScnTGZn/JDV
	pkOB7w/qMS/l9gCT5LvAokW6oQBKv/5MhJbE7smTzJiyEdtPNSgt7824
X-Gm-Gg: ASbGnct1WBh0SRqvu9rHqXQtTqoahNwMICxUQWDQ2RTWK6oclDrzQkVZl19nw3C8PL2
	MpUmM9I/PLmrDXGTZ86G/4pFBP07U/83EZAaQEA2gKK5MJDp8LSwQ4lgM8+EaOg2osOCTrzfacv
	+/HWyxniPq2fqUcbmfU7AGhTAaRDbfxEoYDlQdm5iv1ycaQR7aEaSoHuWAoxubp/qSeWEpTHlH+
	1Uv5fLimizEEgPyG2AVt2MnpZ0Mgm93S40SEorPpEdbLVKV+HDKmIePNrUmxW9gzXQw5Nd/oIu3
	ixXBMJeWYptRcxzl4tla4Mad0IJZzQXxoA/4FeszXTKPaftJO8Pwmrv7exPTArd92JLNQEL02CH
	QRxERXWYVjNnxMeZe5ezRV+tWuI0xa8UsMfayYgwtXX69QQdniPbTeDr+GxAZffDBIg89rpsIZJ
	fM5BD4KqmZElmu
X-Google-Smtp-Source: AGHT+IG6hTxVI3+DO6LSdzXeMeydwi6lRwoviZ553goUTNLY4A7CJR1y+7vTP/C+iOn69/AQGpV76A==
X-Received: by 2002:a17:902:db09:b0:293:33b:a9b0 with SMTP id d9443c01a7336-294ee41d9a1mr32440235ad.32.1761828598978;
        Thu, 30 Oct 2025 05:49:58 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm16719123a12.10.2025.10.30.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:49:58 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v3 1/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 12:49:47 +0000
Message-Id: <20251030124947.34575-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030124947.34575-1-r772577952@gmail.com>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
 <20251030124947.34575-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_get/set_lower(). If ifr is NULL, return
-EOPNOTSUPP to prevent the call to the legacy IOCTL helper.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..a32e1036f12a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


