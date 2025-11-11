Return-Path: <linux-kernel+bounces-896164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A2C4FC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC8A3A08A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93628326927;
	Tue, 11 Nov 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hHOAY17H"
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F05368288
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894794; cv=none; b=IxDN33Zdwmr6VtLTFVAIUxvxIyeeerjIyaILwcAaDpW/Yrdlu613+cUVUyr1Q7yd84BcjeTttUg3x6+59PuB5tE6sQmEt2y7SlRY9ZNS+Otnh7oPcsVde7NDsUZVUNxg532YMjTi4+9gCYx8n79Z50P1FYhAWcBjgN/gPBfvihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894794; c=relaxed/simple;
	bh=h0RJyh4XBPTGu3X6i+l4QWakFEPInRUGlYuSCfJaVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo2/HcGmV4OalIolqOjy5XzImdtn6+rkz81//PkN6ewoTB84nLdGXOCpUkhHJsn7bmTUMpriQ/0f7/jpEkAG40DwimI6nb3TmUXHmWlM/JmIOgW+HpBQKa0pNm+AVQHRam//6BkxthusTyAdAdW9WETilK6priQsVDhzszt6nkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hHOAY17H; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-640c857ce02so195819d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894792; x=1763499592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL/D9Hdg9v98Oqy/BeOtMvQ/s/pqgoS0ZcMc7Q8rl7U=;
        b=FPCVxynzlZl5hRcIth9fiR8iIVEgCAbV0rkz2lKjFOHxk3Bj0X2J06ArQrA0C1J5rD
         ef2ursinbQ3x8UDpoGTHweabQ09nid6CIfB3fYjv5Dx8ubPqHqldxQ6TSRQVFza9kMUK
         kodelF2EIjxViDYabr+Twj+iA/IGF61SVMHmAki4zLE50DWOkATMFACtrlURoTmqEbQF
         Ybkc4uaHLDeqjexbjAK30X4paRJuhqAHIikWWRA/uL31Bh6wruvIY4iokee3ZCrhiCCi
         OlSEtEb6b87ulldQFXgHaqN+KqKtCcpcsRU0eluxQDdYnxEkD+vBpMg6UmfujTNpLbN/
         nPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDwUoqIt0xxSn4ADildhOKY96KH1v5dMqoK+xExaq9Ak6Qx+UeH9dYez/49B5IAP2eCq0im9m+Rn1JolI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFdphWfPbeRsNKL4qmbhelDrKsfcJLnznUGBqvMg73vveLe8n
	6K8EwAQ/F71cHHAyBNc1IPnFstkyTtOVDA2qz/dJ56mqVhcHd9e5Zim45iyMs8pqChYHqt2ZY65
	o9a2qH24KyD87HTbXJpzlHyO8TIHdIivWE8wtmD+Gf0SxdnNzO7AzEaSfNHrH5sniZOaMq0li2e
	6jl3l7lPbmo3S6lyiLCGj/6DnzhFpIpxQJ0f9vLo0I4pbB46tR9VmMJE9gYpyh8WdVdRiNaNDiC
	KZ7U0TtWQFF3OtvkhxUeu3DBAQn
X-Gm-Gg: ASbGnctAUq0WPlF3sapeuFdhuu3XUhx1iufhItti0ioBnGSkB+fZQwlWKQS+Wg17Ftx
	SQybm82XLgUOqUDptDHdemDxSSafjuEjEgAIU19wmBOQZyPuo1FCLHy31QkK/VfGkpxO3FPK1zZ
	h0OSoLcyFWJCqhSlTQP/AulEusV0T+J78QfgCfUcfok8hrqDmPK73AU6kNZlXs8q/LgGvLAWe/P
	Tc2CujlZ/8JIJBp7MhDDR8jPvA/FLD6o2WYLhk6+mHJOQf3XV8sSpSYuRFUDo9S9UX2Iso9EUF2
	ZUnZ1EmbV8neLv/Hl8gPC3r6SLsQCJgFUlo1SFbVNzpWpnKJXAxACSORqZmWXXD0lNe8qxXbDpM
	gZxyL9lxQP/V1d8b3ejCSTLz9AsP4ZdofK7fga+8teZE1TzmCcfu7H8QQVFkUyvyJDufoa17spC
	ezjHKFDJE6i+S7UGaOjks8C0XI5WObxmNW5UeAOuiH
X-Google-Smtp-Source: AGHT+IE1MQhGn0ZvaYcWKlwS4An3f4EfbJN+LefzZ1TMah/HpLP8yb52Y/z3Fmuu8390tYfeBvJO8takFnwD
X-Received: by 2002:a05:690e:1596:10b0:63f:b590:2e5 with SMTP id 956f58d0204a3-64101a46d4bmr686256d50.22.1762894792181;
        Tue, 11 Nov 2025 12:59:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-641015acdcfsm49203d50.1.2025.11.11.12.59.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so117858a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894791; x=1763499591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL/D9Hdg9v98Oqy/BeOtMvQ/s/pqgoS0ZcMc7Q8rl7U=;
        b=hHOAY17H9r0tuIWQkuXfcZ94bJ2KYT1ULbc+D8ES01WYL4QlCDtr361m3MZkvjv1x2
         0xeR4f3h6kMXIn8YtPewbVHldZd42o1jmjQgO8zDtEAFoO6Y1AiGxTCLNpR4oAK8678d
         0boXDZGWxpHmLdTcK3HYtbpUEGY3i1Z/9NAYw=
X-Forwarded-Encrypted: i=1; AJvYcCXYV687K46hedTLpt4oJ+X4KK+S3e84vTGCGWDgtNY4rtPG1W9TlByyfIQFTgWyJ4NdtgPzw/OURj0zloo=@vger.kernel.org
X-Received: by 2002:a05:6a20:3d0b:b0:34f:b50e:e2e2 with SMTP id adf61e73a8af0-3590c510498mr634682637.58.1762894790966;
        Tue, 11 Nov 2025 12:59:50 -0800 (PST)
X-Received: by 2002:a05:6a20:3d0b:b0:34f:b50e:e2e2 with SMTP id adf61e73a8af0-3590c510498mr634658637.58.1762894790551;
        Tue, 11 Nov 2025 12:59:50 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:50 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next 12/12] bng_en: Query firmware for statistics and accumulate
Date: Wed, 12 Nov 2025 02:28:02 +0530
Message-ID: <20251111205829.97579-13-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Use the per-PF workqueue and timer infrastructure to asynchronously fetch
statistics from firmware and accumulate them in the PF context. With this
patch, ethtool -S exposes all hardware stats.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 35362ab2aec..8cba4a2f675 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -253,6 +253,17 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+static void __bnge_queue_sp_work(struct bnge_dev *bd)
+{
+	queue_work(bd->bnge_pf_wq, &bd->sp_task);
+}
+
+static void bnge_queue_sp_work(struct bnge_dev *bd, unsigned int event)
+{
+	set_bit(event, &bd->sp_event);
+	__bnge_queue_sp_work(bd);
+}
+
 void bnge_timer(struct timer_list *t)
 {
 	struct bnge_dev *bd = timer_container_of(bd, t, timer);
@@ -265,16 +276,100 @@ void bnge_timer(struct timer_list *t)
 	if (atomic_read(&bn->intr_sem) != 0)
 		goto bnge_restart_timer;
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bd, BNGE_PERIODIC_STATS_SP_EVENT);
+
 bnge_restart_timer:
 	mod_timer(&bd->timer, jiffies + bd->current_interval);
 }
 
+static void bnge_add_one_ctr(u64 hw, u64 *sw, u64 mask)
+{
+	u64 sw_tmp;
+
+	hw &= mask;
+	sw_tmp = (*sw & ~mask) | hw;
+	if (hw < (*sw & mask))
+		sw_tmp += mask + 1;
+	WRITE_ONCE(*sw, sw_tmp);
+}
+
+static void __bnge_accumulate_stats(__le64 *hw_stats, u64 *sw_stats, u64 *masks,
+				    int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			sw_stats[i] = hw;
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+}
+
+static void bnge_accumulate_stats(struct bnge_stats_mem *stats)
+{
+	if (!stats->hw_stats)
+		return;
+
+	__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+				stats->hw_masks, stats->len / 8);
+}
+
+static void bnge_accumulate_all_stats(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct bnge_stats_mem *ring0_stats;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_stats_mem *stats;
+
+		nqr = &bnapi->nq_ring;
+		stats = &nqr->stats;
+		if (!i)
+			ring0_stats = stats;
+		__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+					ring0_stats->hw_masks,
+					ring0_stats->len / 8);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		struct bnge_stats_mem *stats = &bn->port_stats;
+		__le64 *hw_stats = stats->hw_stats;
+		u64 *sw_stats = stats->sw_stats;
+		u64 *masks = stats->hw_masks;
+		int cnt;
+
+		cnt = sizeof(struct rx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+
+		hw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		sw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		masks += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		cnt = sizeof(struct tx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		bnge_accumulate_stats(&bn->rx_port_stats_ext);
+		bnge_accumulate_stats(&bn->tx_port_stats_ext);
+	}
+}
+
 void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_dev *bd = container_of(work, struct bnge_dev, sp_task);
 
 	set_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
 	smp_mb__after_atomic();
+	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bd->sp_event)) {
+		bnge_hwrm_port_qstats(bd, 0);
+		bnge_hwrm_port_qstats_ext(bd, 0);
+		bnge_accumulate_all_stats(bd);
+	}
 
 	smp_mb__before_atomic();
 	clear_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
-- 
2.47.3


