Return-Path: <linux-kernel+bounces-850811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22BFBD3DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EFE18A194E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1C30FF30;
	Mon, 13 Oct 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc9l9MkZ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70330F923
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367218; cv=none; b=KgC7IXLB8SV0RnkmmCIk0UaN1miAtr5E80bYIVKDNmqMl6EFqips2Cklpd31zTkfMRcXQI7QNbfN59hhOq8UjW+BqEkvb/oyERQBTnsbzNy9v5xqAx+YHuhn7BG4ivqxWs6eA3PsP88Z14PmXgWqUKtsQt0YT0/G9dZYqF8h+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367218; c=relaxed/simple;
	bh=PbuNSYS4ZvphCG8IIqw5e2RtAOtPsOlFF3aKC+mIwRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILUasU+dtxjF7jnNV1PNc7Qwh848xnj0p7iA304yOz2uKENfP4tdpr8h7OtGEAv7J5YJdZzBH9cDi8owHXg+57pgz9uv8gpgYoyntsjS7Fvqx1GT4/FAxq0wF3FIQLK1pMCm3tsmehCKDv/zSxPSvDFflfg3FtsuTQd4106fv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc9l9MkZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2328753f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367214; x=1760972014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=Sc9l9MkZ3jsGmKuzKFJ+WZzEdPxLvhnRI8KiyXKOgbVGZwAcnRqNP2Ec0LNq1zZ7md
         Mgq4VfOY21/tdd8fUZAVvlBcnBPIvU/xKZUYZw+ZPbW3jqi0ybSXxiN+ADp6xSnfF0c8
         aJnV60/1bMla5WqYSH4g+oYgHEAmF0gsmgDAAfe1RLWuoaUpKKPAQ5I5cdOiUCwWuK9J
         /sEwPMpYtXR5vCLJYbNm1CJS1DaJGx8PL8Apt906L1RQYAMoXgFTCXplecSj7VXQf7fF
         5J2uOwtwVSGXxOVIYxD+8NSZxxxZ80vhkwxl2ojns6ifMWP5ALcdJlIftTQJE/D3aG58
         7pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367214; x=1760972014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=k868Fucacj/za17otwkgXEbHoul4c14q8oVzBbZXnJQ1sVbCCCutitVDXj5O1MGQDo
         ChUjBMbYOnYc8BoQjGN1jnLefp0pI8HqGCheGNWx39wZXrQXFE48X/XGTUhDHJybDIEH
         N7g3Pg62KYMhwMFy7uRKLXmw4XNNUIYpzjPRT/pIfRFVv0achGoX4DD0KdK+TXfrZBwB
         ZlFe60VINeuN5YzAHFZjt2EnmPlJ7odIh7Vi980Vek8I6xuSV8h1Ers95RFQtwTMYoxJ
         x4gxEyJV01+Nz/s4RyrfhrcIrRSQLR6oi9tuxEdRPDpHtcbM1/4VvZk+xbHY5FwG869D
         5s7w==
X-Forwarded-Encrypted: i=1; AJvYcCUP5MPXxm4ss/YoDdZv40sZMAu1pqSbEHc0i3dOZwqjL2y6C321MOBECthdO7Jas2NdUhNf8qUnwMCNK2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENxqPsjwr1NqM2LP61I2cBoNv0NZPagLRUGvSyGX2avyANEPG
	m+8q6GJBa8UyuyW4bZOJN3eqTHy/GZHC+vHvs9/PFqxANoAzgqutQM0r
X-Gm-Gg: ASbGncuI+0UbjH0UqueRlpfcaGRd2gPNNef66Ap3BCjKkEWA11Lt4ulWZ4QUHLWv9BQ
	TXFSpGBoQHirZbB4f4vAYaEguGuafqBRbrudkJs81Yn9g4BZJq8Yau/Ms3TkiSR+D+nlxV73WHp
	nvZSdS9m6W9gGH6KShYsGJJdBzAHLHnpNrWHKJzHss3YjJpzQCU1qBzaqb1BHz2Z4HU9W325txM
	0QSofw01anG9rEHZTRrB2oKLJ7ZjyTCMfJ6dM/kFnAkUf55rzKowokm948sdpUaSEkSfwkcYxnR
	IAD8fGRLNvTI2wtQjMJ6v73JO5s/3SFg+9o9J1/807kY5rIvxm1MC+F3wGPjqscvhk3V/1E1hKY
	4hGe9wfdzYu6+NiH6223Ln8Ta1IvvKT3FeJk=
X-Google-Smtp-Source: AGHT+IHmUh7f1JWY1Bn/xnAz1OdnLNh1wSTUkKJWaDX80Ssi4DYZzLpugyxu+bw4gsN3KGpLNos3vw==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6709517f8f.63.1760367214055;
        Mon, 13 Oct 2025 07:53:34 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 07/24] net: add rx_buf_len to netdev config
Date: Mon, 13 Oct 2025 15:54:09 +0100
Message-ID: <bd750653950673fb2a4bc1fe496ddb24cca87619.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add rx_buf_len to configuration maintained by the core.
Use "three-state" semantics where 0 means "driver default".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 4 ++++
 net/ethtool/common.c        | 1 +
 net/ethtool/rings.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 9d5dde36c2e5..31559f2711de 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -25,6 +25,10 @@ struct netdev_config {
 	 * If "unset" driver is free to decide, and may change its choice
 	 * as other parameters change.
 	 */
+	/** @rx_buf_len: Size of buffers on the Rx ring
+	 *		 (ETHTOOL_A_RINGS_RX_BUF_LEN).
+	 */
+	u32	rx_buf_len;
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index eeb257d9ab48..2f05359d9782 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -909,6 +909,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->rx_buf_len = dev->cfg->rx_buf_len;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 628546a1827b..6a74e7e4064e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -41,6 +41,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.rx_buf_len = dev->cfg->rx_buf_len;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
@@ -302,6 +303,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->rx_buf_len = kernel_ringparam.rx_buf_len;
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
-- 
2.49.0


