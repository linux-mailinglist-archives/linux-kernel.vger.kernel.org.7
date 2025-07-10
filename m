Return-Path: <linux-kernel+bounces-725437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB7AFFF20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82124E7790
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602D2D8380;
	Thu, 10 Jul 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DToYf4cP"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BF2D7816;
	Thu, 10 Jul 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143087; cv=none; b=szIFSdUI46Wq1da8TZhhMG3khSkTqb4giEcowSHOZt/Pulk69uL3/h0aufmBNvgvelx7vL8OdXn1JmALGBqkWO/K4vINqfmmUTO/pprMIXz+6kNvd29gfSLH9bO3gAEDyBQ/SPhVi3/05fkJYslhxHNfVy12xE41+gOg6iuhd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143087; c=relaxed/simple;
	bh=8x6wPb57vXYKMuRXH/K9usI50McZs2Lg0t4+z4TuZYU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vs/OpAw3QWXR1jnDMPW25RCx0ox9DkvkR6y/zHJddc2FJHHMTpG5FZFkTlS6lwS1Vl6dXZZJEFFDs2E+2onSt8HAnhhW7r33UstujyWilPdjcaydnk3/u7SLmbpcy5qFRf8+Z+HuRt9GRJ8i/z2HXNl2XLzqzh+ydJb83ZAoOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DToYf4cP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 352972016594; Thu, 10 Jul 2025 03:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 352972016594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752143085;
	bh=p8/epI8kzJFW9D8gYwJ7yEhvDC+8zYBR7PPJ0nr3wa8=;
	h=From:To:Cc:Subject:Date:From;
	b=DToYf4cP/OXwY1UEe9F4Fz5Oaat6+9dvODV9vatkuvRilrsvKXOmVqOjhUrPDybaQ
	 8tnKMDpcq743UGN9KPI4bB7kLTBFx+LW+jHTJQBFeO3ZaHlZuAdrDITJVVNG2bzCTF
	 UvXEHZSM2wpj3KxBhyxQQtR/nRzITxsmnGip+as4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix DSCP value in modify QP
Date: Thu, 10 Jul 2025 03:24:45 -0700
Message-Id: <1752143085-4169-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Convert the traffic_class in GRH to a DSCP value as required by the HW.

Fixes: e095405b45bb ("RDMA/mana_ib: Modify QP state")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index c928af5..456d78c 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -773,7 +773,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		req.ah_attr.dest_port = ROCE_V2_UDP_DPORT;
 		req.ah_attr.src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
 							  ibqp->qp_num, attr->dest_qp_num);
-		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class;
+		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class >> 2;
 		req.ah_attr.hop_limit = attr->ah_attr.grh.hop_limit;
 	}
 
-- 
2.43.0


