Return-Path: <linux-kernel+bounces-814451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F420AB55443
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3D15C6DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2C31A544;
	Fri, 12 Sep 2025 15:59:32 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0D3093A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692771; cv=none; b=JUKQNQfdZlszn5m+6ezMRFCype+Mve5X9LkBwKd9dD2j74J0GxC01FyoHqJbJ3AwMhFkJD+HEWv1FuyJaug3wvzy/mMf4ZJjPifKS5bIUz3P54RN6GR8sNSf3zUQ+vHgyaXqBzUSeUqfykPWMF0iuUzcIxrwfxtv58ruhGLJPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692771; c=relaxed/simple;
	bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XgOTaE8ORlsTNlzpMMHIps+mF8zQ6UU+k3sTIruaW/rOpfoBjIRFLrJg78uwcHefTTK8IEvokX5eFQ/sADLgx4pC3/yQfyDdUuH/biavbC1xL8xQxQLoh8LN8iDrVvEkDJx44L3qeBfcaBMm8d26I6yFTzs8k/7i07Ntr4p3HGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04ba58a84fso290388966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692768; x=1758297568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EvLF922o6xh90k0jchOOI1hJMbi5YioNq3mzLJ5T5Y=;
        b=l4CSFSVHm7DG8iM+RcSY95eeZAsCzm1q2d9PhVZTjDid7VyMj4Oce+rhEZFLh5rIjK
         xPOUiIBgQBul5UzWRjw9Zqu1OVEyzlIHxq6ZvIRa9wSsCf/nAFrK/h5vuTYTamq98qgw
         1/GsGEiwU1mY5r+RIUGxXktO1lXxZnhOQo+Nh95ENHPhLe2gVKMzRAxK1d2PJDJaMAwR
         2UwHz6D4FWen21PZfU8xzRsHM39oOZJQyTP4N6sh/vMeNB1dklV7VRFD19A7NaG8oZXI
         NF6HK0M2B3o8Y6gfqvtZ9wQgjDBTJs9Y2ym4vNMz6ZDwEQVCJgzNJVsRBOgA95xlvFf8
         /Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCWZneqVepdOUpjylTw0i/8cBmG8e69E1gEf3X2pJhdSl5FDdXHcSkgR1Qx1mWaZ1Eg/BEJthn6HjFjebfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtkvPpCYZ4zA9+OXiRZcReoD+NOa0lDmQK61dLvsRuS50jiOa
	N5eKeeJTFmBSiwdaZ2LSOjQ82GPhh6bhKXjRdhZu9N4WBBhGxV6mDZfa
X-Gm-Gg: ASbGncvN+KgJQPKSLlekfm2TBEPRalaHdjdWWBTyRj7V/D3CMAn63KbNy/Te/8reUND
	MeSZvJuN2l0NgC6q1187gQDeoRKKithjNHDEp/8s09O56ToE7vKHuljCH3VJk+Tw9VTz4gy7GNQ
	ykfcNPKw3QFa/zS4aCo6fU/4GteTAW1yOFdHUHnZ8jJt2tD1Q8Z/iFBgjQYIhx5UyD9/7jiDaFj
	IjHC5+oK6E4ChfBbBL31Z7Jdc/yierNF3PehrKog681C8/fGGVS7csEFbKpMbUkNNFtIuU3ZbvL
	6GthAEfCD8H1W9/oGxXxTdQGImC6N6z2+0JrA/rPPXoFqpYRDhD5rNzGUvxljHAxsPAfhW/1fr6
	puT5Sa72ZcKQqL/ddVIxVg6E=
X-Google-Smtp-Source: AGHT+IF7nXKfppCZg0T1oDeoByPuGMm7/AxQ/s4l0lUlv1p/sNnpirQWVObNtStv6YhQ7tnpMLjRBA==
X-Received: by 2002:a17:907:6e93:b0:b04:6045:f7ed with SMTP id a640c23a62f3a-b07c353f09cmr340005766b.10.1757692767750;
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da268sm391595466b.10.2025.09.12.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Fri, 12 Sep 2025 08:59:09 -0700
Message-Id: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5DxGgC/42NQQ6CMBAAv9LsmZqyFgRO/sN4qGVb9lJMSxoM4
 e8G4gHjxfNkZhZIFJkSdGKBSJkTjwE6gYUAO5jgSXIPnQBUWKlWVdLPkYNP0iBZRCI0ZKEQ8Iz
 keN5LNwg0yUDzBPdCwMBpGuNrX+Ry5z+1XEol20Y7qy+lw8Zde3qwCacx+q3+EdpvoT5rbNCp2
 lT6KGzXjMfTv+K6rm942q9+EwEAAA==
X-Change-ID: 20250905-gxrings-a2ec22ee2aec
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=leitao@debian.org;
 h=from:subject:message-id; bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdao+OCMI/V6R3A03GZZi2wJ2qZih+VI3HD
 OQAz4Oj/teJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 be4aD/4677eIqWjN+GaivFYOB2waQlJAdd5PtEqvoyZKzCciN2ZLwUv+CL3k+BAHdaTzo9ZMCLT
 VQOiK9vGWvS9zMoS0c+FbVzUle4Cc3QDLo3KnnY4CwTZ1cN3Moo+ZwI1RvXLvFzLPu8P4ROjCG8
 CE/JHoN90fusHc3X6hSHgzA4GyQvSQOGwU7EW6LYbdeKn/kA98CbgXEK0fJZ+jJ0dGJf9bpmO4O
 rS/Ko4VuvV9NqhHSIo2bVLc1c/JmGffxuPnPL3HOLOG8Wf4uu94ORR2l16wZjY0/j3coblw6fqD
 ISCD4jZo1OQcrGxhFCia/5sD5Sx1k/L6OWczduJWiIOMYwz3ttBD/bZKUX5WKod22ML7XBMqRJ9
 F5LSpqLdQ3Uet+TcpM2FycBnx9+0rAducmnxTMygeTdkc5teBTkXAXDH6Z1SL2Kp9Q45wPYaqad
 Vb5pWwznlWWIotZRFnIRtC1i2W+pdASKa3OLHBuT4yjCRggJ+AdSYFtFkwtwFipukrEYpoQeFzg
 xZ+lzTU68F+iGvT1zmq1zlCerOpG5W3JIM6Y7P89z2N8+0xaWVf4mugimFjg7YIghhSwAhNTglE
 rqpue1RtBDxjV6Js1Z84KmjPwafCdWs94F+rd9lNz0s09ZmCGeY9erBMGPOGfR5L3hRi5edoraQ
 nkmjP+G5wvxICMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rx_ring_count, which enables drivers to provide the number of RX
rings directly, improving efficiency and clarity in RX ring queries and
RSS configuration.

Number of drivers implements .get_rxnfc callback just to report the ring
count, so, having a proper callback makes sense and simplify .get_rxnfc
(in some cases remove it completely).

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Lei Yang <leiyang@redhat.com>
---
Changes in v2:
- rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
- initialize struct ethtool_rxnfc() (Jakub)
- Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a54@debian.org
---
Changes v1 from RFC:
- Renaming and changing the return type of .get_rxrings() callback (Jakub)
- Add the docstring format for the new callback (Simon)
- Remove the unecessary WARN_ONCE() (Jakub)
- Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f28f@debian.org

---
Breno Leitao (7):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++-------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/ioctl.c      | 81 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 68 insertions(+), 30 deletions(-)
---
base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


