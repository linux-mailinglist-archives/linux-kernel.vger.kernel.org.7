Return-Path: <linux-kernel+bounces-767166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914AAB25003
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DBE1895087
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20152EAB95;
	Wed, 13 Aug 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a0/2Ibyp"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC362E9EDC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102609; cv=none; b=q+J7azw4g1jO1rQ0SIsfMUi9zskpSe5/8CywY7roM6Ks1yobGG+yZYK4iVnSbMoychNEHBcoyvmXJNhY9cC6UQvuVYJX+xKXEgd7BostQfiBQtISKSK4opzE50GGxkEAUNnhmTqZrEmWh/Vnc/oL6gGevcgcLV8GVDOdRY1bnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102609; c=relaxed/simple;
	bh=XEoca+MduQ9RBom8IQWVcsh2N00Oo9Eex/qKrwPk92Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKSWU5M05Bg5m18byQh5NV8RNplQOey1Avndlm4OlPo7fQlT540b+i0uCgbBuM/3vud3g/5nhnrgaccm/FHbrZncq1vfUF9uR1/Xz/V+/IT3gKR1JQ7qipJmqT+49b0G9Ojk5HS7uk+J4p5r9Lj+1Tz6SqYmRIhv7ujIxlXOQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a0/2Ibyp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2406fe901fcso71941675ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755102606; x=1755707406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7OV+dqQmeCbSCbwtsVnpv+HPm3ZRxf9C7xnRojUFzw=;
        b=a0/2IbypbtNLdM6InYNpiblIDZ6ohW5Ekm6IpTpKUird5UkcN4xLAaOr4hA4bfB7sM
         7nX9Mt800LENEXxy4X10agSKL16BFbJsXsCPlhf4HiQs7JGVHfr5crgDK2ngE3QCmYxc
         cqk/pLfKXdmejL9F5MB521ezVfEQIXApautIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102606; x=1755707406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7OV+dqQmeCbSCbwtsVnpv+HPm3ZRxf9C7xnRojUFzw=;
        b=YIxZrrtNIeeXKWVbRBHBa22aS8RPvSypULiGBD/Fm9iAZzALiLznCNwLgEqxkU86ML
         ASSbRO6sVQkUk43tSyTpLKG30rDb/LM0EosXKhljGk0WmyawePwAO6G2Ya1BQhwGBpyb
         fJxVwXzD5nLdrHaHDLceRNAM3al6o71G3IyYROYV9ueAj3HW/02JoSITzZmKeylY6dmp
         T6oyOp/pPTD2yoMtQGo1v0/dvTyaBbBw/Q2ODE5gcCB45yMW8bglOQacTjDI6MjrX2wO
         3th2utfK4caoZQC+K0NKCC4rqkJz7u4CpZ8SgyTNwQ3w6FdKPaqw2fEX7UP7gcDfCZWu
         WCIA==
X-Forwarded-Encrypted: i=1; AJvYcCVrPy7DiiwUinJrVoixMRhgcyIxU0UOvlDP3akZ+E6zEgp8fZ6DRykk1O1xv+LMwnPNx6NjkpRyybKrxnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTTCage/BCto0uqbxvuD634+9UQI6hOBK3CsDechLDKPKl/3T
	JRDSvYjSy3NefIKLM5aRObHg9RUtFPLon+hGbl3WqdInWz50VW0AsF6oholLK6Mdwg==
X-Gm-Gg: ASbGnctRhwZVh0xZ+ede28wSZAlBwxUQn/eUEKxmnqpoMHk7KMggbjW5/DVXPGi0+Ok
	LgdUH1HCbu5f1267dhoCoCPWofo2rr/TGRklGcG8vb4ZshpUmNWQKywoeqGT6IZgXmjD9Pr9COM
	dFz68i4C3/Let0X+vjjF859LpKHZfo2TmejKf1Uyd6+UFvt00N+CzdCgWEkQ8fvvrTs0pILTAnr
	vBYhr9enz0RqludMN2XklJjraG2LPG4HlUk80wjW/2A89ykQM42tDqvjPrJK3FJaq6xPZY9Qme0
	aOcijyBTw3yRoX6sZimvu9bLX/wEFkSW3fhsAezkNXHK36lohfuMg/RkULmzKznTIbIy046EmEY
	uz2CFuTYlxQaCBt028yQAgPMr53HMV0TKhqHDh8Hu4lFiytk7skX/q9Y8bSAE2f8Z+eVi+ztiMo
	0jfEaQCh6RkcoHWjSMeK6GUBclmQ==
X-Google-Smtp-Source: AGHT+IGyRnRGY7CqhPe07aorHhTKbaXQ3I6rr5rfYH0fIU68jPx4w1icy/gARd0lt1eXmSiEqArQ7Q==
X-Received: by 2002:a17:903:1b0f:b0:240:7725:18de with SMTP id d9443c01a7336-2430d1d8cd9mr62830295ad.37.1755102605944;
        Wed, 13 Aug 2025 09:30:05 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm329311915ad.41.2025.08.13.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:30:05 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next 9/9] bng_en: Configure default VNIC
Date: Wed, 13 Aug 2025 21:56:03 +0000
Message-ID: <20250813215603.76526-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
References: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to add a filter to the VNIC to configure unicast
addresses. Also, add multicast, broadcast, and promiscuous settings
to the default VNIC.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  71 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   3 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 271 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  40 +++
 4 files changed, 385 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 90a54fcc212..97d6eccea7f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -852,6 +852,77 @@ void bnge_hwrm_update_rss_hash_cfg(struct bnge_net *bn)
 	bnge_hwrm_req_drop(bd, req);
 }
 
+int bnge_hwrm_l2_filter_free(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_free_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_FILTER_FREE);
+	if (rc)
+		return rc;
+
+	req->l2_filter_id = fltr->base.filter_id;
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
+{
+	struct hwrm_cfa_l2_filter_alloc_output *resp;
+	struct hwrm_cfa_l2_filter_alloc_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_FILTER_ALLOC);
+	if (rc)
+		return rc;
+
+	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
+
+	req->flags |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
+	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
+	req->enables =
+		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
+			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_DST_ID |
+			    CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR_MASK);
+	ether_addr_copy(req->l2_addr, fltr->l2_key.dst_mac_addr);
+	eth_broadcast_addr(req->l2_addr_mask);
+
+	if (fltr->l2_key.vlan) {
+		req->enables |=
+			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN |
+				CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_IVLAN_MASK |
+				CFA_L2_FILTER_ALLOC_REQ_ENABLES_NUM_VLANS);
+		req->num_vlans = 1;
+		req->l2_ivlan = cpu_to_le16(fltr->l2_key.vlan);
+		req->l2_ivlan_mask = cpu_to_le16(0xfff);
+	}
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		fltr->base.filter_id = resp->l2_filter_id;
+
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_cfa_l2_set_rx_mask(struct bnge_dev *bd, struct bnge_vnic_info *vnic)
+{
+	struct hwrm_cfa_l2_set_rx_mask_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_L2_SET_RX_MASK);
+	if (rc)
+		return rc;
+
+	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+	if (vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_MCAST) {
+		req->num_mc_entries = cpu_to_le32(vnic->mc_list_count);
+		req->mc_tbl_addr = cpu_to_le64(vnic->mc_list_mapping);
+	}
+	req->mask = cpu_to_le32(vnic->rx_mask);
+	return bnge_hwrm_req_send_silent(bd, req);
+}
+
 int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 			 unsigned int nr_rings)
 {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 79fa58f2e38..d9ab055c5b6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -36,6 +36,9 @@ int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 void bnge_hwrm_vnic_free_one(struct bnge_dev *bd, struct bnge_vnic_info *vnic);
 void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
 				 struct bnge_vnic_info *vnic, u16 ctx_idx);
+int bnge_hwrm_l2_filter_free(struct bnge_dev *bd, struct bnge_l2_filter *fltr);
+int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr);
+int bnge_hwrm_cfa_l2_set_rx_mask(struct bnge_dev *bd, struct bnge_vnic_info *vnic);
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ce7b9e2bc06..1ad3b3afb91 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1486,6 +1486,231 @@ static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	return rc;
 }
 
+static void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+{
+	if (!atomic_dec_and_test(&fltr->refcnt))
+		return;
+	hlist_del_rcu(&fltr->base.hash);
+	kfree_rcu(fltr, base.rcu);
+}
+
+static int bnge_init_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr,
+			       struct bnge_l2_key *key, u32 idx)
+{
+	struct hlist_head *head;
+
+	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
+	fltr->l2_key.vlan = key->vlan;
+	fltr->base.type = BNGE_FLTR_TYPE_L2;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hash, head);
+	atomic_set(&fltr->refcnt, 1);
+	return 0;
+}
+
+static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
+						      struct bnge_l2_key *key,
+						      u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+	struct hlist_head *head;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_for_each_entry_rcu(fltr, head, base.hash) {
+		struct bnge_l2_key *l2_key = &fltr->l2_key;
+
+		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
+		    l2_key->vlan == key->vlan)
+			return fltr;
+	}
+	return NULL;
+}
+
+static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+						    struct bnge_l2_key *key,
+						    u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+
+	rcu_read_lock();
+	fltr = __bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		atomic_inc(&fltr->refcnt);
+	rcu_read_unlock();
+	return fltr;
+}
+
+static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
+						   struct bnge_l2_key *key,
+						   gfp_t gfp)
+{
+	struct bnge_l2_filter *fltr;
+	u32 idx;
+	int rc;
+
+	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
+	      BNGE_L2_FLTR_HASH_MASK;
+	fltr = bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		return fltr;
+
+	fltr = kzalloc(sizeof(*fltr), gfp);
+	if (!fltr)
+		return ERR_PTR(-ENOMEM);
+	rc = bnge_init_l2_filter(bn, fltr, key, idx);
+	if (rc) {
+		bnge_del_l2_filter(bn, fltr);
+		fltr = ERR_PTR(rc);
+	}
+	return fltr;
+}
+
+static int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
+				     const u8 *mac_addr)
+{
+	struct bnge_l2_filter *fltr;
+	struct bnge_l2_key key;
+	int rc;
+
+	ether_addr_copy(key.dst_mac_addr, mac_addr);
+	key.vlan = 0;
+	fltr = bnge_alloc_l2_filter(bn, &key, GFP_KERNEL);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
+	fltr->base.fw_vnic_id = bn->vnic_info[vnic_id].fw_vnic_id;
+	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
+	if (rc)
+		bnge_del_l2_filter(bn, fltr);
+	else
+		bn->vnic_info[vnic_id].l2_filters[idx] = fltr;
+	return rc;
+}
+
+static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct netdev_hw_addr *ha;
+	int mc_count = 0, off = 0;
+	bool update = false;
+	u8 *haddr;
+
+	netdev_for_each_mc_addr(ha, dev) {
+		if (mc_count >= BNGE_MAX_MC_ADDRS) {
+			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+			vnic->mc_list_count = 0;
+			return false;
+		}
+		haddr = ha->addr;
+		if (!ether_addr_equal(haddr, vnic->mc_list + off)) {
+			memcpy(vnic->mc_list + off, haddr, ETH_ALEN);
+			update = true;
+		}
+		off += ETH_ALEN;
+		mc_count++;
+	}
+	if (mc_count)
+		*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_MCAST;
+
+	if (mc_count != vnic->mc_list_count) {
+		vnic->mc_list_count = mc_count;
+		update = true;
+	}
+	return update;
+}
+
+static bool bnge_uc_list_updated(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct netdev_hw_addr *ha;
+	int off = 0;
+
+	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+		return true;
+
+	netdev_for_each_uc_addr(ha, dev) {
+		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
+			return true;
+
+		off += ETH_ALEN;
+	}
+	return false;
+}
+
+static bool bnge_promisc_ok(struct bnge_net *bn)
+{
+	return true;
+}
+
+static int bnge_cfg_def_vnic(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
+	struct bnge_dev *bd = bn->bd;
+	struct netdev_hw_addr *ha;
+	int i, off = 0, rc;
+	bool uc_update;
+
+	netif_addr_lock_bh(dev);
+	uc_update = bnge_uc_list_updated(bn);
+	netif_addr_unlock_bh(dev);
+
+	if (!uc_update)
+		goto skip_uc;
+
+	for (i = 1; i < vnic->uc_filter_count; i++) {
+		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
+
+		bnge_hwrm_l2_filter_free(bd, fltr);
+		bnge_del_l2_filter(bn, fltr);
+	}
+
+	vnic->uc_filter_count = 1;
+
+	netif_addr_lock_bh(dev);
+	if (netdev_uc_count(dev) > (BNGE_MAX_UC_ADDRS - 1)) {
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+	} else {
+		netdev_for_each_uc_addr(ha, dev) {
+			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
+			off += ETH_ALEN;
+			vnic->uc_filter_count++;
+		}
+	}
+	netif_addr_unlock_bh(dev);
+
+	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
+		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
+		if (rc) {
+			netdev_err(dev, "HWRM vnic filter failure rc: %d\n", rc);
+			vnic->uc_filter_count = i;
+			return rc;
+		}
+	}
+
+skip_uc:
+	if ((vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS) &&
+	    !bnge_promisc_ok(bn))
+		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+	rc = bnge_hwrm_cfa_l2_set_rx_mask(bd, vnic);
+	if (rc && (vnic->rx_mask & CFA_L2_SET_RX_MASK_REQ_MASK_MCAST)) {
+		netdev_info(dev, "Failed setting MC filters rc: %d, turning on ALL_MCAST mode\n",
+			    rc);
+		vnic->rx_mask &= ~CFA_L2_SET_RX_MASK_REQ_MASK_MCAST;
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+		vnic->mc_list_count = 0;
+		rc = bnge_hwrm_cfa_l2_set_rx_mask(bd, vnic);
+	}
+	if (rc)
+		netdev_err(dev, "HWRM cfa l2 rx mask failure rc: %d\n",
+			   rc);
+
+	return rc;
+}
+
 static void bnge_hwrm_vnic_free(struct bnge_net *bn)
 {
 	int i;
@@ -1509,11 +1734,27 @@ static void bnge_hwrm_vnic_ctx_free(struct bnge_net *bn)
 	bn->rsscos_nr_ctxs = 0;
 }
 
+static void bnge_hwrm_clear_vnic_filter(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	int i;
+
+	for (i = 0; i < vnic->uc_filter_count; i++) {
+		struct bnge_l2_filter *fltr = vnic->l2_filters[i];
+
+		bnge_hwrm_l2_filter_free(bn->bd, fltr);
+		bnge_del_l2_filter(bn, fltr);
+	}
+
+	vnic->uc_filter_count = 0;
+}
+
 static void bnge_clear_vnic(struct bnge_net *bn)
 {
 	if (!bn->vnic_info)
 		return;
 
+	bnge_hwrm_clear_vnic_filter(bn);
 	bnge_hwrm_vnic_free(bn);
 	bnge_hwrm_vnic_ctx_free(bn);
 }
@@ -1757,6 +1998,36 @@ static int bnge_init_chip(struct bnge_net *bn)
 	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnge_hwrm_update_rss_hash_cfg(bn);
 
+	/* Filter for default vnic 0 */
+	rc = bnge_hwrm_set_vnic_filter(bn, 0, 0, bn->netdev->dev_addr);
+	if (rc) {
+		netdev_err(bn->netdev, "HWRM vnic filter failure rc: %d\n", rc);
+		goto err_out;
+	}
+	vnic->uc_filter_count = 1;
+
+	vnic->rx_mask = 0;
+
+	if (bn->netdev->flags & IFF_BROADCAST)
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
+
+	if (bn->netdev->flags & IFF_PROMISC)
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+
+	if (bn->netdev->flags & IFF_ALLMULTI) {
+		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+		vnic->mc_list_count = 0;
+	} else if (bn->netdev->flags & IFF_MULTICAST) {
+		u32 mask = 0;
+
+		bnge_mc_list_updated(bn, &mask);
+		vnic->rx_mask |= mask;
+	}
+
+	rc = bnge_cfg_def_vnic(bn);
+	if (rc)
+		goto err_out;
+
 	return 0;
 err_out:
 	bnge_hwrm_resource_free(bn, 0);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d8b73f22856..b27e3807185 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -400,6 +400,10 @@ struct bnge_vnic_info {
 #define BNGE_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
 	u16		mru;
+#define BNGE_MAX_UC_ADDRS	4
+	/* index 0 always dev_addr */
+	struct bnge_l2_filter *l2_filters[BNGE_MAX_UC_ADDRS];
+	u16		uc_filter_count;
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -411,6 +415,7 @@ struct bnge_vnic_info {
 #define BNGE_RSS_TABLE_MAX_TBL		8
 #define BNGE_MAX_RSS_TABLE_SIZE			\
 	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+	u32		rx_mask;
 
 	u8		*mc_list;
 	int		mc_list_size;
@@ -425,6 +430,41 @@ struct bnge_vnic_info {
 	u32		vnic_id;
 };
 
+struct bnge_filter_base {
+	struct hlist_node	hash;
+	struct list_head	list;
+	__le64			filter_id;
+	u8			type;
+#define BNGE_FLTR_TYPE_L2	2
+	u8			flags;
+	u16			rxq;
+	u16			fw_vnic_id;
+	u16			vf_idx;
+	unsigned long		state;
+#define BNGE_FLTR_VALID		0
+#define BNGE_FLTR_FW_DELETED	2
+
+	struct rcu_head         rcu;
+};
+
+struct bnge_l2_key {
+	union {
+		struct {
+			u8	dst_mac_addr[ETH_ALEN];
+			u16	vlan;
+		};
+		u32	filter_key;
+	};
+};
+
+#define BNGE_L2_KEY_SIZE	(sizeof(struct bnge_l2_key) / 4)
+struct bnge_l2_filter {
+	/* base filter must be the first member */
+	struct bnge_filter_base	base;
+	struct bnge_l2_key	l2_key;
+	atomic_t		refcnt;
+};
+
 static inline void bnge_writeq(struct bnge_dev *bd, u64 val,
 			       void __iomem *addr)
 {
-- 
2.47.3


