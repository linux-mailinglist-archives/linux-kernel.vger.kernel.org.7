Return-Path: <linux-kernel+bounces-872831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC7C12223
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DE7188C166
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064323EA84;
	Tue, 28 Oct 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+tXZmNx"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9633032A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609634; cv=none; b=dyXTyvWscObI7POL9rp3rEbUatd/zC1Wbl+yMcI/ROGi95UXk4B0kgkc44Oce9DmlFk+XDwH/STW2Uzdh+jS0Bfzr78UiPRjJSLSyC7H66NuKjxdzuzsmF4IESKNcIayl0GPd2Bfqy12XXzulpFZo9Vlo2sBQCQRvymsiiNfsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609634; c=relaxed/simple;
	bh=ylW0lW+wuEzlGL+hHENqSKVEnatP0qVhMDiawJdeZVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMK9ozRjWrL6dSkrR/i157HKCKDmLfXFxvLMenAK3tLZMSzfVoijna+3cfQ1RaHa/qo6tUkOY/d62nXDza71FhV4mrYXfMa+J46Y2Np0+3xe8DrH1xB1GAjCgLuUNKFaZPRvDy1+qKCa25hfv7L5WR7imMtm/Nl9pMc6awNUtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+tXZmNx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60157747so51305217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609630; x=1762214430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivCZW/5kdODw7DGks4Fdh9OvB5fw5w/Le7nkqaVGoCM=;
        b=m+tXZmNxaHjvq0hz1YlAtbBwk7OZz1PDJQ4cxdYigF6e0sUTY+h1yfVeqO96GmqZa5
         G6z+80rNQ5VcJAv7/hqTwqiJT6ubGPbmHtQHFKAF7LufuqT6k7+whZAVlAgkd7umIF/p
         bxZyxZI3AloKo9f1lGQnGGze7Ld0qIQXtVUnCVryrFl43p71J+3A3CnJQ/ZIBqVQG2OH
         lAV/3yMNWMl4MD0a0Shot7m1Md8ttA1ig91SFWwGF/CkIkUX83bzkiJccuxaHt0mS88e
         3/Obl3HJlEF9fA4cOFB/URqeVzBD9m+iRqAGZkFLygshpnQ61y2alceFlHwi08kl4LDW
         2k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609630; x=1762214430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivCZW/5kdODw7DGks4Fdh9OvB5fw5w/Le7nkqaVGoCM=;
        b=MwESq83TMnWnaHqHhABT04mRuKwSA9bIvVhL80YoKagLCTJsBXsoFy9SL6WdRo8H8Q
         TzbfpivD9a3o6uz///qE7gnubBciS+K8L0rMWl+0qV2w/qU8sZa+3xucvgecUCgC19/e
         e0mI829wGJc9PlxtiWX/yaiUWvD/B0ZMSBFttsD/dboR0jthJkjA5zFemZZ2DO7eUMvV
         JjLWglQtozlPDUpr1q+vQ09JIvanCXtBwaKxvT2uuBuqsZuhGCJc8JUtuxUab1ynnKLO
         l3Ol3s6lw7eiOSxs9YZ/4u/uJBwdoU0PnMjb0WfzqeyOX3KLzH9XrcElVJbBzU8e+2VV
         y9dw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FoGV6vbfg9EIR1CkNPN8aTyynt/cs7NYYewVzj5v7XoYSN2hyJiP1mkxytfHZC6bVNlK4XGDWxdlbA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9C+EM42FTce3M7eJ819a9X1zJau3CB0Cp7ibsPJReK9NkVky8
	MoVJyVi8Env3CaUEoWNS9d4Vzr+45e0Ov3FswZzrW4cr6HqI7H5Nk9/7
X-Gm-Gg: ASbGncsq00HmEzaH+b+sHPGjVJ7rnGj9Toy4z9K+AMidmHh9wu7lwPg9WGSMS/MoENi
	d+3gP3+gdKZq6/LtINmRSRm7tCTZvO+Qpxy50ZpsHcMsvD+BeqCnu2tD/nsx5Ej7yy+4WiyZUrP
	+pbMLYvWZ0w7rNiwTWd89CMkX50ZvPByveKteAFCG/umbhW2zALJq1DKfvkVfaYJic7bWwK3U8s
	oMyQc9ZPsXNLGF3KI20XB2b238f7Yaq+KwVJdKWCWHujjDZCg05KJ1p0dx+chSMkSSKzwmxDJkr
	QD5FBwpg7TRd8OEIBehCiWxezvMfTuLM6A8VS1qD5xuPFHHU3C8o/+XUE/XzLV3STHnhRpE5hgc
	y0a+XJuY0vsW00b2TnDcY8MVgTr1NoimMtWKYpadwWAodedaN2xZzH/EB9TL92YOhgO+hXZnGW+
	CvhyNQUuVAghPOEQTDIMco
X-Google-Smtp-Source: AGHT+IFIT2ZZKJmfNpqscngAHfVc0scw3rsnRv+/zspdYA9vtzoBsZlLRZhmI0iL+Df05NV6ZwIZFw==
X-Received: by 2002:a05:690e:d8d:b0:5f3:319c:ff0a with SMTP id 956f58d0204a3-63f6b97ec59mr1468225d50.28.1761609630201;
        Mon, 27 Oct 2025 17:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3ccc77sm2718414d50.12.2025.10.27.17.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:27 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 5/5] netdevsim: implement psp device stats
Date: Mon, 27 Oct 2025 17:00:16 -0700
Message-ID: <20251028000018.3869664-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now only tx/rx packets/bytes are reported. This is not compliant
with the PSP Architecture Specification.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  5 +++++
 drivers/net/netdevsim/psp.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 02c1c97b7008..af6fcfcda8ba 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -109,6 +109,11 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 tx_packets;
+		u64 tx_bytes;
+		struct u64_stats_sync syncp;
 		struct psp_dev *dev;
 		u32 spi;
 		u32 assoc_cnt;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 332b5b744f01..3912f2611862 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -70,6 +70,13 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		*psp_ext = skb->extensions;
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
+
+		u64_stats_update_begin(&ns->psp.syncp);
+		ns->psp.tx_packets++;
+		ns->psp.rx_packets++;
+		ns->psp.tx_bytes += skb->len - skb_inner_transport_offset(skb);
+		ns->psp.rx_bytes += skb->len - skb_inner_transport_offset(skb);
+		u64_stats_update_end(&ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;
@@ -164,12 +171,32 @@ static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	ns->psp.assoc_cnt--;
 }
 
+static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	unsigned int start;
+
+	/* WARNING: do *not* blindly zero stats in real drivers!
+	 * All required stats must be reported by the device!
+	 */
+	memset(stats, 0, offsetof(struct psp_dev_stats, required_end));
+
+	do {
+		start = u64_stats_fetch_begin(&ns->psp.syncp);
+		stats->rx_bytes = ns->psp.rx_bytes;
+		stats->rx_packets = ns->psp.rx_packets;
+		stats->tx_bytes = ns->psp.tx_bytes;
+		stats->tx_packets = ns->psp.tx_packets;
+	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
+}
+
 static struct psp_dev_ops nsim_psp_ops = {
 	.set_config	= nsim_psp_set_config,
 	.rx_spi_alloc	= nsim_rx_spi_alloc,
 	.tx_key_add	= nsim_assoc_add,
 	.tx_key_del	= nsim_assoc_del,
 	.key_rotate	= nsim_key_rotate,
+	.get_stats	= nsim_get_stats,
 };
 
 static struct psp_dev_caps nsim_psp_caps = {
-- 
2.47.3


