Return-Path: <linux-kernel+bounces-887541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3DC3879C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEE06348C18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039620E030;
	Thu,  6 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqJ7nCpw"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA11E00B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388778; cv=none; b=bZNNof3aGP4Zza/x/9z2GViEtD1ahbbXo0CHZZs3bnD3xuk1VFnRyJ6sVd970lCH5AEkcMDLKIEW9Tj9fKHgkcgF+6LXlgIuMUUmTAYq0s3o29nCOMcWKAJlKRFVmV/cqvJiR2bq/uQdKfKsyvAooS3eNw+a+XwkRNiddDvuxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388778; c=relaxed/simple;
	bh=wGvVM7e8xZCbRb4uflWfr7nVVAQ6uh8PxX4m7dh8VMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHA+rwpIO+Bu1qAfCdjN0ESil1g5esQv0ljKwEAn2ubjAXAI2xaXAksApYxXlmux1nu6QyfSqLpYD4My/k6JyJ0s/0cFKv2zWflI4X2nwNcsPTojFSXtwTWYaodkLVuH0sXvjSzrIqg/4sc01kwTcahHcwwa3aI06MfyLKlpdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqJ7nCpw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78677ff31c2so3623147b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388775; x=1762993575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGlD8g27EXt4mLiXT/5plrbsHpmSwLaKSFuPthIm2Z8=;
        b=DqJ7nCpwpP6G851RirENXTgAFErtvnG9OOA/hzbsZcCkh4i9khLOqF3IsGnx/c/Ck1
         cqZ2psqTdLw5hma8Vj/Yfg1CDd03qTFxzKhG0FyZYmwVW44TTxHOJhFai7P5YDWgQZ44
         X6Gq9LQd8spsWZUXPMjRdXAv6aI5ZDmcMl7zILarTjb29ZS0/1gJPdPqI71GpC1LZYvv
         TzaJmm/2b4TKQgJsdiqDSCXN8ipBIiSmtgegQaKKVVy7KxHogIR8hIBk0W5b3/GA0GMv
         uIet0WA2EweJuvjZEz/kvr+glBG1adMBV8TwBUui+503LMQNm9BshdHR/+AiI+BMXL0k
         XZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388775; x=1762993575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGlD8g27EXt4mLiXT/5plrbsHpmSwLaKSFuPthIm2Z8=;
        b=gZdAAMgKmG7x3Weirongb+HmnDDP7XIyoRn6RKyjGlodg9F1bBXo1hwj6goykvFjzc
         i5Q/13EqG/xR1ifPIDEJFGNGTgA+KpL7PXJUv6aktOuCwsaASJFyv5L7TJVpxZxKRLqp
         u/ZmuTGib82OX4veBSskG5KJqo3B7i1G/vVCZvy61yehEOFs/jQXZA69/5sUD2Df1nrg
         9dBI1lLgDldX7lfIi1ApBQLyclmnSkcr3UhMQKFXDMZLHg7ASz/442PXTgLXBS2Ms7uc
         LFnnwC8nEB97g1uQym8lFaiN6knRtZpVNdM1WM2uTj7lHK/EDu+jcPf6HzowLinRfcbF
         Yriw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1BTQ/g26spbnlbkrGIAM2ocZ1IhZS23KerxYlkaJam90qtInZTlPW4YnuDzFH6oURcpTuoQC/pZTJHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJNyjnEovqRWj/P5KNgz81VlGL4RnDZI2sPvykAryrnZVrRTG
	bdMDAVfnKp3IeCAHbWfon8KzLrGxF/RYvcYjYelQJ5GyGAAbFKWOPpSe
X-Gm-Gg: ASbGnctfDh+/elgYOfpYnVDMa4/eJb52wH6DJ1TRC4dZSGwR7MkumHTrM8OFrxaoQzo
	X2q59/8qSHjxmyL0qlg4rJm93AX0xpHKGQtt/sU72KaRUcE1TFrZo4y5bKsxZX5jqece3CVBk7y
	BA6m5iQf9EqRid87BDphskbB9dxhjk8NZWP28YS9F64p/bY+k/wJ+quGqZxGRvHtEXiGrpdWoh5
	z4g5B7J2Siylhbt+c54G+DQn+5Pd/0LkbpHEVCWjv4LxHIRP5w0hGHKySjK1j3kF5tjc9Yp/QuW
	pQ1moqwPnk+OmTeCuUklWK7U/ZucYMqUsfqV3VIz2Fw9bAqj7DSsLqZR4XrXY0rlygGZtUSLJFZ
	y8J201rctOvuCGTT+yIj76AsNcGm2/7xMGQDsbmWMeNGXIclWY0+m+f8qnImciZhE5N/WCPi6Vk
	7NRtNmnV1I
X-Google-Smtp-Source: AGHT+IHetxRpnG9cF/Gppc13q63FAvtOFyrYEQ3XG9Moiw5OSk5gaWti/6paiCCz38YCOkTOfMqnKg==
X-Received: by 2002:a05:690c:4a04:b0:787:a126:562e with SMTP id 00721157ae682-787a126679dmr29411267b3.34.1762388774969;
        Wed, 05 Nov 2025 16:26:14 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b159c58dsm3439457b3.38.2025.11.05.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:14 -0800 (PST)
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
Subject: [PATCH net-next v3 5/5] netdevsim: implement psp device stats
Date: Wed,  5 Nov 2025 16:26:06 -0800
Message-ID: <20251106002608.1578518-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
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
index 332b5b744f01..727da06101ca 100644
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
+	memset(stats, 0, sizeof(struct psp_dev_stats));
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


