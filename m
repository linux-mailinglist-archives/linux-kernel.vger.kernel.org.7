Return-Path: <linux-kernel+bounces-820405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD62B7D738
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742F37B18AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0134AAF9;
	Wed, 17 Sep 2025 09:58:20 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA632D5AC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103100; cv=none; b=GAFfcNENxGQ3+10FmUBODPrhmf+g2ghhyry4k2sP+hidBRCH9C/N5Bhyz9m+/T1wRE+CXoF0Rwb8o4qlt83ya+sY6e6HMT0tk2Um6KpYirTUlU24FbBN7Lp53fmY7p4QjhffIjTogmostJwkNUccFvA7NSwF0JXejqx6ce5awYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103100; c=relaxed/simple;
	bh=GFL2k0Aq7ajO2IortbD5EkQeYs+1xr2kSrErJCu6IYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jyQGQUncOjh9D1CD/UVlNuqbPJex5Jx/FlC9bb4VdsbgrzGrcTDd2AFXcG/Ce1Q/NHNqiV9yfGkZv3YZZ6ctViHm/1OR4662UAC4yDMXaomXyNbhpkWZOZuDKlHaOkfU4mRjLKbvjbs+Q/RtWsFo6VaVhpwI1Yq+aSamyqp7kZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44fso5823530a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103097; x=1758707897;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0/8ZVsNDprKIGoj9wUI/3lHS5dn8vmXry8dEtai42g=;
        b=Go9cM+qeIX7pdCzUxb7vkSJZ5/n4DPU+vkMUF3MDXovTJM7pUdbJaT11ta/P8HkeFa
         xdCwjODpwxr/MTMm/7V5QdjH2SCQtqRmJGJ5W7D+whNyHPqLG3OazzR5qbAVSV9udStl
         XCZGVxWFpWEPECbm+G3XRIL6amrqnt9P8Qf6Sv6XmMc3upgxMMaftgCrOqGOGmL7hmhu
         FnK0/t0YRoItqknKSRZP4ecz6MVoA40vpWWfDPIXDr/neSMlqnM0dmN3ziIHqBlHR45H
         gXWHfmjSZcqKgFax+Go7a00GocTjmMdJiYNHjN8dCN3TJ6PNlX4azFLc74Qg9OIwyuoV
         ocSg==
X-Forwarded-Encrypted: i=1; AJvYcCUnbVFYI+CnSraJSQoCZDYWsd4/pohh/Ra7SPInhyvwkBATZVfdis2wZIht6Bl64EmlxdKk+N3G3CZKeb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yype5a9ajwsmlsqZddlgUrBh34cNjqqvbWEK3jcAAVrl5A8+Iem
	XSHy/40I/UvWdBId3RG7G9XuwFWGkyR8LkaSnOOe8zOczTEVq9EywZxUQINE0w==
X-Gm-Gg: ASbGncvMjFE8jzehC9h5YokVXjuvmdhdBLZ8iiKfTBOIe97x136VEKQ5/z2y+VZA5gh
	ywC/uGhoOATQmNnTMA5LscSQJOrSiA2+Pc9SdmRaBl+VTEGuN5dhAoa9hVohJj3Ds9hAA1ZOMjz
	EFkyoQed+/7/xHDk+HT57nJQraeOd/Zup5TOcPmBK35sJm8jL2QMUgH5qDiB1guHm4jWnivzN2C
	A4n4MGX+nVuFg1PaURIv5dZJcgBrv6ZhVeoqwQ/xWtt2BhxIZLS2vkwpRLIjgw8LcYHGO/HbDyr
	Ak6RAQy1vnjcDBeVxcpEfRMJqlK5WHUkhOwf3bF6a3nHX0vheJ2Xs9JeKxvGVQrFE0lzThcan4+
	6gmxDwBO9FPxm
X-Google-Smtp-Source: AGHT+IElZ2/i6RqS03tpS0EA27+fg9kNKS6fSfi4gvP2vuWek+0vFMBPenYgKlsAPonbd2hhubTx0Q==
X-Received: by 2002:a05:6402:4488:b0:628:6af4:595 with SMTP id 4fb4d7f45d1cf-62f844615ffmr1581732a12.20.1758103096518;
        Wed, 17 Sep 2025 02:58:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f136cead7sm8461746a12.36.2025.09.17.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Wed, 17 Sep 2025 02:58:07 -0700
Message-Id: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCGymgC/2XOywqDMBCF4VcJs3ZKHG/VVd+jdJHLqNnEkkiwi
 O9ekFItXQ/ff2aFyMFxhE6sEDi56CYPnSgzAWZUfmB0FjoBJKmSraxwWILzQ0RFbIiYSbGBTMA
 zcO+WvXQHzzN6XmZ4ZAJGF+cpvPaJlO/3T6391lKOEuuipCv1slZVebOsnfKXKQx7JNEJ5nRAQ
 omFaVQttWbW/R8szvD4PxUoUfe2yRurjVL2B27b9ga/yebcGwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063; i=leitao@debian.org;
 h=from:subject:message-id; bh=GFL2k0Aq7ajO2IortbD5EkQeYs+1xr2kSrErJCu6IYk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2wfQwf3KaeYWACy9Jml/rw2P8JOeMPtbhG
 3ZDwJBM9y2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bdRrEACZX8KCKhgFbfWIy7yfpohCMJ1qPQVdET7m9jgALZPOMT+kD8RoJzt+e8MpFMnPctjH+sT
 +S6lAykehMjHgZrJcS7sTID8C4yyfrtuafk30JXkJCl8kONpmk2gdMzHS98bMy2l5T0Ti6LPi0m
 KxLVgYkFnANf3ndxdaWgIPQmblC861jX/l+WQLiKwj5cX+9FNhXkBdwUAu+g+eIyLOAhkRzly/Z
 mU0o/IXklAmMimUpH6SiLiEUiyOlMYrcTQTHp9TY7RXqQj2LZYlj1155SzbGF05lhySkIcuuUuX
 XYld9bqv+5uUZRRJtCU3cGNEeZIrxKvlPZSMaZkAsF9ezX164nStAwFurqobu6BUUtl2svDBiNa
 EIIZ76SpqJtPaPDcaR/rWCoiY8lT1IcQBBltHfmVC+dkUVfeBgEssGHmLMJmmRUcTAnBwGzf/de
 lVZ/rWd0E46pzBZQ+PJ/d0ujbi3AmFcTv9xmDtcFBu5wT6v9MHUaNvU2dtI/gYBPxXENVkF232v
 9bh24Lm1x6wfeKWoJpCjqtk3wNil5XrYaRfKTqGZIaue3bHQnYseCrPwambXmwrF6hcDV3dZghh
 ilb/kqjUjBAa3dhI5S9myMoHRGCo9hbWoViv9IabaP1kzcbzYvubaHlk9K8rslBOxTu42lcTZMn
 xkkJA/t90pnhnpA==
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
Changes in v4:
- Moved ethtool_get_rx_ring_count() to ethtool/common file (Jakub)
- Keep the check for !ops->get_rxnfc only in ethtool_get_rx_ring_count() (Jakub)
- Link to v3: https://lore.kernel.org/r/20250915-gxrings-v3-0-bfd717dbcaad@debian.org

Changes in v3:
- Make ethtool_get_rx_ring_count() non static and use it in rss_set_prep_indir()
- Check return function of ethtool_get_rx_ring_count() in
  ethtool_get_rx_ring_count() (Jakub)
- Link to v2: https://lore.kernel.org/r/20250912-gxrings-v2-0-3c7a60bbeebf@debian.org

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
Breno Leitao (8):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: ethtool: use the new helper in rss_set_prep_indir()
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 +++--------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/common.c     | 20 ++++++++++++++
 net/ethtool/common.h     |  2 ++
 net/ethtool/ioctl.c      | 69 +++++++++++++++++++++++++++++++++---------------
 net/ethtool/rss.c        | 15 +++++------
 6 files changed, 82 insertions(+), 41 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


