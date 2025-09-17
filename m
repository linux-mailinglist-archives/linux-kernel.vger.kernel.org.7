Return-Path: <linux-kernel+bounces-820406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D38AEB7D661
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F01A4E11DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C677350825;
	Wed, 17 Sep 2025 09:58:22 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16383451AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103101; cv=none; b=jnKcxOYUbvxXOJR36hD3F9GSuqY/rl7vzQeh/sDgjhPixqmaQhc0D8d1cFj0jSQqhS9iIts/83OggC/iZP9au6I4TNJsdIUNyI02bCgBw+383ZKKiC/nfkyapOtZpgOKXadml71q4l6JAdwDovb8kWJY+Itg1Pv0wuYV+Y0MFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103101; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXmiCcfxcGtdzt6xuJbl55ltJgCC1gjsGdiE1CPQkF8a8QkSfl6zcdXRRWO0bcLxgWThCxtybj0fYQ5s2s347IlneqsblDbvtuNTbrbCA8ONpGnOm0gFSRnHN5GaRm/YCUtCA0qxdKrullW1rhfzuxlmXL33g7ITje00OqzS/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so986164466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103098; x=1758707898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=m/4iQqhNwciIMZMziaqvv0YGm3WTxB4VoYpK4a8HtEac/GRWyttCmN2WRu5BTX3mE6
         m6bYRX9N95g9+txPwywbxRLfl59rfY9i84rsENo2ANDVOzTDGLmyATDIjf1w4UfBivME
         VF3t+huPayN8ZDdYmSe+jKQggYwp+oI+DPEBKLYgMKQW0ed3QZ7JZfFvB2Buem6RrRLN
         TuG/dwL6y5Eb9bRyTH/uAz9rpvnQaHRQaQdvhHh2NMy4UP4en5SNPNODLDkZEAxpfah/
         WKAk8s5HMMSLyXuGuNc7Tyca0yYFMkM6FdoCt21ilJzSIBd/B3m0YSP5bUw5ubSJ+O9M
         wkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8zS/gKTD3RAyaWT00uo5DZtsr9MCS5atdqtfiDoVFQ9mxBfeDiIJCvigPmEkmq2mgtQ0cisFE+UjC3+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QUlcVhnkD394y/m+bUT+P85RqvfiTqNkUJNkbR9pKSrUxDL/
	Hz6mM0MtZYlwbY8Btj6gn1mHapzDLxAvysECi4ysoFUw+MPlt5svDC0x
X-Gm-Gg: ASbGncvFbqEAwabbWrx0+eMijZ4ql29SjeSylldnE54NHk1XmhRNksuETy48QsGNW2Y
	h3rKAPzddooKithM7QFy1HD6uwaRtcCRzxKJMxCObUN7a1K1rTDujdpkiXxmIOP483/ThWUUdFE
	dy6do/LGE8a6viEsmW4U1KB6jOtNUYLM8ourxn5IMIP9UHPetPlVjwHtqvzpcrDjRCO4WpxT4mf
	sMvajrWmnHMRCB6EmleUl7ubj6gJH7d/EWyhk+BAq9tiHBqx6ZjN8XVwE5CaTsYbIvqahaVAsDm
	weOLnOJCidabK3IXvLZUkV40hCp8IWfwWNoptdt7UXuJEHropG5iAi+5G2+27iKJX09hvG2N9o4
	vBF+rCGXHnegk
X-Google-Smtp-Source: AGHT+IF32qzwZCLc4MBxGsmW9WhgDqh4KQLE/xEwqC+/peEotmieMDpT8LsNsX1yfGVQeGzp8aNg9A==
X-Received: by 2002:a17:907:3c90:b0:b0a:333:2f97 with SMTP id a640c23a62f3a-b1bb7f2a341mr188100866b.37.1758103098067;
        Wed, 17 Sep 2025 02:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da388sm1326212966b.22.2025.09.17.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:08 -0700
Subject: [PATCH net-next v4 1/8] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-1-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY27qTLNPpFEVPrZdXSTPTiQ6yrKRmKdqmbf
 QY6yNNOuS+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bQckD/9KObOk9COJoYFWO77hAsuCTU4+zMulh6m6xxBNe2DEIfWbp25ZjPPkQvGdIOLoTpWIk11
 /KP9eABtbMiR7ngAtKDSONV7dzKEF+Zb5ryUkNUuIJ5XB7HC6vUJVOFZo8AfEBNiSl4EaUwAdL/
 04vhfxMoYkR05psE9C2m1NYoVdmYcne9aTD37LlJM0L5X6HafbABgc/q+JfhHnKve/+yYoCKTYk
 B2k+OKQ9iT6QKha9+ecgjxmlCTx6abQeUGOj6PL4xUN5KthgiP1Pcut4XNye3i3SG5qJPlwrgFs
 ugJaubjrPuRQLyAeKsXA9YnDijtLCZtFU3ScMRXVIhCUb/wLpzms4sDAPt0+xrQZB9moFV1BnlX
 hk+y38UhWRYpuRUgQdVw7QGs4t8lmKRCIFY41cRRG2itSE4Fgk+6nLiMEH/BdgWnGka6rUfZ9cg
 gcBS7ecSS2svUmxIzqStNxRRHB+87Qrvh2BI4tspyf8fnBga5TKtu8seg2THJh9oEU1XNgoq8W/
 yhd3NkkZEZ7fioMHrbxPnt8g/MkunSCxGRlcpAW5XZRc+RjPhECxJ5FzEjbXtFAxEvM11k/Aw+7
 97xa7iB0YkNHopjyTuYhiVzXCZvVQjKONrQa4dpzeG2hP+1H6M982JUFkyXJrL/8CD2PbdRthO5
 ouVU5d0dfifzTzQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3


