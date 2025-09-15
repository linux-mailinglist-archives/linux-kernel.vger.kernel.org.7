Return-Path: <linux-kernel+bounces-816683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8BB57717
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9431A23966
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F7302CC1;
	Mon, 15 Sep 2025 10:47:50 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0530217F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933270; cv=none; b=rZ+4qiEPG88sH2UUqPwUzowRUvWg8xSbn3wwbJJwJ1qRiRY35R8UXy2vAmBdOOe6IJ+EPB3gLb8Uh4cVEjNLy+AdKE3mwXiHHfZFxp9LhQhkBnGV6xwekhsnF9ycP8UYbmAXCLXt2gTVW7Quw5yO0zbCTeTKgjc5IhIM+kg4SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933270; c=relaxed/simple;
	bh=cJNmCEop9g7hasbfK5nHQAjt4RcAnO6s+ONwXp7yYCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUoUqX/dCcB8lVzfcD82+dUcv73dM3OVkkCqVB8t6/fhUIgeK0xeJWdm1Q36g1DiC2Y2z9z8Bo2yIq/Lth1Y0Q0hbrsg5sL77r60otYggU5gKbvwOtCvBZpYSSPNDdfyxYJ3SOWVFTKL2CT4KJJWMjVY17Z+LAXjOSnUeuvDQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so6752036a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933267; x=1758538067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thqZlVu6AwBX6pN9TwBbQDUepDpkuMkaK1MUaqSKnac=;
        b=ffck8h1I/ZlvtClrWcSYZiYS7URfvSrGeiVCDBR/dK53dLbaVEdLYgqxo6zU1fjAvE
         5CllDELVSn0bPgatPZHj5Iz1LU2He+ohi7THzTfJioqJZe6hGugPayhMvawksNAeGtvm
         7bm5rKuTJqhsZYAmXEf6DKuGtSum1NlYU4/XCXNNF9b84QfHnTBs/EaLOv1rL5Qxt1WU
         T0uI/7hnZZezs+WHIZnmS1ry+MfyW5t9zd+3h6iefSXzjn/fm932xIDduUG3F8VJ4Kg9
         jjc6zR/JlZwx/AgiicUIYe3svk0z4zxdOmWOVF/6Pvqos/fwD9YckCsG/vkuE2ycc3W6
         zo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWTHZLFVV50Hcc3Uz+VOf6ex6VqI24Vw6x3TekxmdDPaR/FaOfSGOKP/RINVkdE58Y4pZ0VPgiqA+OrLvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydVjhGBFsG5GLD7gx8L4Bmx/YRYxfeJSoChjM8PC/WaFSa9bh
	pexLimc1+FzsiBuZzozy3Y3SIhZXDYV4Sn/aQUhZSN4NatkouPM5QzDh
X-Gm-Gg: ASbGncva50pPlhuxg6KFLKSWwUVf3zAtdt4gZ2YyEl7HY0aXg9sJYYehlliTskBYkpt
	2sVSnvUXyqWDSbDiPTAxPXwqwQoyWzTxdIXE219SQs9zwblTsf+0FzLxzLlMWV+ND1tpwpJyJB/
	uAl6eyVIAQIQU1MqxzFEmWmeCo3wWUBIJ8MCMhBGlu1dpPiCwm9h6itZUKlHdbHphhr+Sxihc/a
	ltHZISSosvz964ZjkjyW5yvTP1ZS7DKh5NK8nUQBieblRIqb6+rztWDOi3CwOiUudZeFLcLsr/E
	5xRwMMyS7eninnnBlQXlNIFEb3GjRzQUVg4lrNhyHMOO5WXQoguEWiadxSTM6QiiE666qkaiDo5
	XfkRLufHjZ/7a5Zum1KIJJ6A=
X-Google-Smtp-Source: AGHT+IG2lHVG5X9TCybfnRv3fi1JR7IpXWMr4JJq5A/iavS4CtYbQ/LrA4ABQjGkQeP4oF4WcFcoGA==
X-Received: by 2002:a05:6402:1ed6:b0:62f:af:60a0 with SMTP id 4fb4d7f45d1cf-62f00af631dmr8127144a12.28.1757933266562;
        Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f4b8ec394sm852604a12.1.2025.09.15.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:30 -0700
Subject: [PATCH net-next v3 5/8] net: ethtool: update set_rxfh to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-5-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=leitao@debian.org;
 h=from:subject:message-id; bh=cJNmCEop9g7hasbfK5nHQAjt4RcAnO6s+ONwXp7yYCk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HzRQyd97vtKnYcGncnR/KR0p9FyVINGynI
 4V0yrt3f7+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bd+bD/kBGpbWXaTLKX4Up2S4d/W8V7UlXsppBPkr+WPNLXs2W0arKKE30TQyekECZEbWJ3BB30g
 g36/crQFSe6cwz4npE5sTfNNj1+/ObX2DuLe58203DG3B2G+MC7y8zHAFR5mhwWOPN3CYxWn3qP
 HhJVWaCCXSMKpfZYrJr8JiFZUI7SciiuDDxnZUMwmXYVWe3HJpKdMQdpZ8B+ej3hkWHNIFcMRYL
 QYcwWN/gY4kwxHDYAXhynwqHmZzqkPuYAEWJ9O+0Y5Sjdx4cLVV2YHW28xp02clh3NFCs6LWf5A
 6rYaKOy+gw7SzcipOHPTkiXOzc1h478wOs7db7jVwvfbZ15oRjg0y/5wkQYFtApazssDB5rAWji
 twVsmHfbsC8Lm2041NLDVzT9Zg7UuQsmllDarxVsB2HS0zFsU+ms9xc0QCpTTk0LYrirBHOJVhu
 FT6vZ78cthuTBTsaFfcEyarWlBVVDUB8UoawhxF2C5dChildS5gRptFtgMhDSNyGlQvHaMdTQ9n
 1tVr2UmMrg4u7obD4ycOYBI/jQg/+mV8J0bEQDxmbe/7TOjKooHjsHSwv2Qvz8sz5uZS2vDB3HC
 foEQVM+HsRzx06ERfFP9Y0I5NiCrUWu+deZboXIoPTkCUA6FsUe+M2Rechb4JCSRk1LlZrzsXGP
 Zmz9ZeNcZFYq4sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5b17e71cb3032..2fcb11e7505f4 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1555,9 +1555,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
+	int num_rx_rings;
 	u8 *rss_config;
 	int ntf = 0;
 	int ret;
@@ -1618,10 +1618,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1634,7 +1635,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1646,7 +1647,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			rxfh_dev.indir_size = dev_indir_size;
 			indir = rxfh_dev.indir;
 			for (i = 0; i < dev_indir_size; i++)
-				indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+				indir[i] =
+					ethtool_rxfh_indir_default(i, num_rx_rings);
 		} else {
 			rxfh_dev.rss_delete = true;
 		}

-- 
2.47.3


