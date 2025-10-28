Return-Path: <linux-kernel+bounces-874185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D34C15B41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9FB94EE8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5C342C9D;
	Tue, 28 Oct 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="NC1KV/ga"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983893396EE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667745; cv=none; b=fI8FGCO2ZB4ItOoZCR2/szGwpGI51GAWvW5m0abT9+l4+XNmrROBQUiXYklotVGJEbJwnszdVAl16MHPTq+0d0uGe794NHdYIefKFs/o1Z03rIRg54PVrWWWuH+bri+GgZYIDJlgm/s52cK5Pzg7n9m1behrjrZLhCdmXVn52BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667745; c=relaxed/simple;
	bh=uKru//0VQi4ASSMxc7mTC8Gha4EFBzhbzVqnz9jdgZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np9VDl7HQktqitXmuWh64zTRQYR3o+zBs9WyYOs859msBCzYxNeA/HkJwxKm61PZanmpCJ942EDXU8bUFdIYoX4/Mgx9KnFHmi65ykoVO7KFCBxS0+PYKkam7LDzaT1W2xmyDlSaXnYXM+7RirA/UU3FLE0qzAr5c4TcPYBNbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=NC1KV/ga; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a1603a098eso3724868b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761667742; x=1762272542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW9OsLXnsz6ESKwP6hNF8dP8JhMECKTtQ8QnPSKrIms=;
        b=NC1KV/gao/Qk1W5ZLKJuGPeQXsVRZOo3KkED0xaunQ5jdB6XrbZMOXX8A98M55im4N
         2bdFcM7b9TmIesiuQjOrfPYFq3ungSAA/V/9zuj5nkmwCO34Qc9efvXKk4Kupr/eiKNv
         KEBY39gdgfDgyb1mXY/6wpdCDxgBsMgyzRSEKhY5FiikZOeOZcnlyAGIJ/n+xLKjR4+c
         8woS6LEWZ4y0futUDecu42SiMFY8zLWmUiqyjXBL62BktL+lCnnRX8EtQ4TVHlV/opBj
         9t22flZ7VfUdVHzRGryYRV9smCMrR78twTkEVqOK9cdaqBXu8yRWsXhi5dTmqdSotfhq
         dx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667742; x=1762272542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW9OsLXnsz6ESKwP6hNF8dP8JhMECKTtQ8QnPSKrIms=;
        b=Mt/8xB3WesE1XRPmXcmlE5O9KGcVNREXxfgZODAjEgCHgwrjXC2X6U1WmEWVGBA1P4
         wS1cZGIGuAEhK2fOkp/11vx42UcEzfM4takEfJ/JcZEYp5FTxAiRvOkCqjd2xis+n2Dt
         o2aiIU1Tv4wJ+Bv0+qn+JzM73Ex5AgYbmsMCfp61HISRc1Kls0IkQeFB71YAwvvP1ZNL
         mB7j8yrD92TpTn0KaVePg14+Ku4oaeg0XI0Hy8zubJKpgZnlRBGnJxOZQsSKxhr8oOl0
         2lMs8990VG18HgAU/neQkB5JHhoNNs5XF2g5GuzHTlAgVWiBQJTeCaycmg9KBp3NMFaw
         Ldcw==
X-Forwarded-Encrypted: i=1; AJvYcCUcCo/n13+1PKPpMG5Heqe9CWwC5wi8PEDRpNoxZrYjUiqnSSA51xDOaKJK7SUfFBDAPkTBpH3nP/mF4u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NXsCuIDqvFVq1gTEzrNLMDLAcPeD55bMNOLN4HqHswHEfJj4
	UistUEzi9YmgrXZUXXUSOVGX0pqh734gTcPTCj3iJQWQiprFaa8JfrppdaOiwRwQik4=
X-Gm-Gg: ASbGncvjP6ZGTjlVS8bDb3XTCLFJw1JifGkPfx+QH6xXEZpb5C66ZjxKkdFlVtBPv9O
	Pi7V+pHc24U0ACSZAxgVG5RViBUl+FkXCQ3wSD07RyykRpB1JXe87tk2ySzZ21RD/xL4Bs8tGd5
	m8X9vjPD+tIRbK9HAWcPXjNoG7Z2Cb3TNZU8YBQ+TikGf2c+SePgEOaBwocDuMvzdoYtdzOJkdB
	PvOL01bTpzejugtCVmw8jDwkjiHOKr6kXiXzRlt98j3OmJG4lSCkTmnmYqkgWizxM/HG8f0KWZ9
	hj4zE2fAEVBweGE/XzZq96qoaDWW66krx8HxocoEfpOPbFG/grgxeeyQgMfikzwBSe+IyAWgDl1
	5iTkbNArtHfNHsFs7hbXqH33Wkw7U6dLnv3hdg4feZDEiH9AtESfakNLCULj6rclG+BLftuOFTU
	Ho5v+AmWIWkB7G
X-Google-Smtp-Source: AGHT+IGe3tFN1gphFBUjZXPd9OJZ1HjB7mWf55osHZpxQwESJNdZoVeXL2KpEYWRTA1tLGoUZmVqHw==
X-Received: by 2002:a05:6a00:1caa:b0:7a4:460e:f86a with SMTP id d2e1a72fcca58-7a4460efe29mr2876540b3a.25.1761667741436;
        Tue, 28 Oct 2025 09:09:01 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41402ec82sm12317675b3a.21.2025.10.28.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:09:00 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: kuba@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfp: xsk: fix memory leak in nfp_net_alloc()
Date: Tue, 28 Oct 2025 21:38:41 +0530
Message-ID: <20251028160845.126919-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nfp_net_alloc(), the memory allocated for xsk_pools is not freed in
the subsequent error paths, leading to a memory leak. Fix that by
freeing it in the error path.

Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

v1->v2
- Used dedicated jump labels to free the xsk_pools 
  as suggested by Jakub Kicinski

Link to v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251024152528.275533-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 132626a3f9f7..9ef72f294117 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2557,14 +2557,16 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 	err = nfp_net_tlv_caps_parse(&nn->pdev->dev, nn->dp.ctrl_bar,
 				     &nn->tlv_caps);
 	if (err)
-		goto err_free_nn;
+		goto err_free_xsk_pools;
 
 	err = nfp_ccm_mbox_alloc(nn);
 	if (err)
-		goto err_free_nn;
+		goto err_free_xsk_pools;
 
 	return nn;
 
+err_free_xsk_pools:
+	kfree(nn->dp.xsk_pools);
 err_free_nn:
 	if (nn->dp.netdev)
 		free_netdev(nn->dp.netdev);
-- 
2.43.0


