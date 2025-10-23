Return-Path: <linux-kernel+bounces-867162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F8C01BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95B0E561EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1C32A3F2;
	Thu, 23 Oct 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="TrJAz/pc"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30469328B69
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229158; cv=none; b=B4e4LdcYHNLzZg5sFFTEVPTzikdcpYvbMbN/Yg920BujoRwUWvm2Iq081LwNJYPQC5K2sp7L9yqKUqGB1qhb/DoHfb2neDbrgt6LP0lXQT1pfHJWDoNCoh7/CeDwrmAjo2dZ2+tpZrZ6p7LYc5feAwMDXbh4F0LGXVaEOI7Y5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229158; c=relaxed/simple;
	bh=brWDTQ6YsfkBD8/xaVntOZM/FnJ4PxVuzc4A32wWvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8DgIzW4e1+URXaG9eYWQ1m1377M3EZQzR+e6Axsut9kFV8Bg31Yjm4vnRSsWpgvbLLo9b50JNa3qV70lhft0xTvOvPHlhfwyQTsxfrAWGPpOkYerfZz7cAhKTljznJosvCI8jwx53afl50bD82SreuyvmlGcO7/uU5B61ODYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=TrJAz/pc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33255011eafso972596a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761229155; x=1761833955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYV8/Bdcje4WEw3YeRDD0ZSQ3xsta/5hNTbo6akLa1U=;
        b=TrJAz/pcMKGiSxdVCxSIAkCuJF82Y2jmHNfqVhPvQWNBEz8NtEMdKV3lZnL806HHtx
         jv8w/Uy+MyEVny9quTAwyagRVzeaeIKB/eqNTlyqtZQc5wZaHwkUOmtroDxSj7UX4dA2
         IyxT7CuFw+OIgziWKn9s/oE7xV3ZiYuNum8e4TA7zPZkcKzNVln9E4O8rMj/DOaZNKzj
         itYmPHOWW6ZERqp/cv0Ww6c9deHgzrq0UC2kaYeQa3vM6NGHidxOnaBXLmOfrcOp4oP2
         j4R0yUAUtTzJu0mhN6QZKs/mvz2XlbwajZ7ukwlomUgJRx1fDl1jLYE+SWIxnL4c2A/g
         U1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229155; x=1761833955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYV8/Bdcje4WEw3YeRDD0ZSQ3xsta/5hNTbo6akLa1U=;
        b=LE/8jB1PD1tEvqc9rto3sU/WOw4ogL0OYaEXc9Cj5aKhhAa2mvb6H/0zGhq+9ydAvf
         VPy/AbfaRVlg3ij2j2S4Ew6jnmif2i3dsTkBrjK+72Qnj+DZiiAn2PoPcAicLTeUZwNa
         F+YKKKpRC9AIaIM8dO9iXDxoaQMGa6aFr4rUBwFhwBndaoyPCl6VCf5Gh9GG/p8XgLtS
         54tFV6fcli4cHns/Os/YBw+TuNUm178IcPRp3w9HeoQ5wavkKR6Tq7iXf4webE6PERXb
         vM7JJpbFaTvd6picsgfvBz9hEN33cBfF/f+QAIqs+r7dbAWxg3XfiL/6sti1jn8N2NSV
         ZgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1HY73Fq1Y0uYC/CTOXa6BGfHTP4V0e+1xsNqQSTQ8bvYhq/99Z4RLYGEqJ/EB1ZlartHa6DTk3doFXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUB6OWLjVrhsH21NssipotuiMfmot1xeZhFjeYFaJjV48hQcV
	IcfbQC2rGCKAhzqGcssDVLkRY0trB1GHcKLToekxzwLLIytNoNj5m2x3qbAcVDjSOWU=
X-Gm-Gg: ASbGncuJs1+QIM/nCGwK1E6Rr7BcDRfMOeUDpjFwPSU6IEa1DuQTNjMWcIy657O9w+e
	fMVQ1XgKsnK9DLC4CwIhsQrk+ksjXo+FBJVQd0dAC13n0x8oVU/N40lQIdWyKQFE0lADvMIrDpi
	cdabjeXHn6mJfg2CFa5YREAnT3hAOzB6Qs1rIqIS52EgBg9i/3ZeEMRZveUHbF+GSIuy+kxSRcp
	ZPc+7smADSo+SJhnmWAqBQlNEdOuAyxrbuh+j6i75PXVVmvQVuCT3IPwinpTJK6tfVI+JvOF9sn
	m4QAEN00uNB9RZiZmKsU2d3rxIQBaIaXuoBdX+xt6pPW84XOhXhDAgFdKBKSUMBiJNkXYwqGADM
	6/XRtU3JfPWEIXOwRGu7TmnY+2pBtIToJZ+S9p3SZYhqnQzu58ZUmWol3Pkr7X6YA/kQTtvCHvr
	4HfgQtUproD+wHq1623qDmHA==
X-Google-Smtp-Source: AGHT+IHiyLVprVr7qZwuPFrFBxTVT4NNIp40KFzQ0C6PrK3vi9PGcNX2CKb8dMVSDo7zAaYScwX5uw==
X-Received: by 2002:a17:90b:2604:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-33bcf85fb3cmr26611821a91.3.1761229155463;
        Thu, 23 Oct 2025 07:19:15 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33e224a2640sm5905657a91.16.2025.10.23.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:19:14 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ecree.xilinx@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	habetsm.xilinx@gmail.com,
	alejandro.lucero-palau@amd.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] sfc: fix potential memory leak in efx_mae_process_mport()
Date: Thu, 23 Oct 2025 19:48:42 +0530
Message-ID: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
passed as a argument to efx_mae_process_mport(), but when the error path
in efx_mae_process_mport() gets executed, the memory allocated for desc
gets leaked.

Fix that by freeing the memory allocation before returning error.

Fixes: a6a15aca4207 ("sfc: enumerate mports in ef100")
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v1->v2:
- Added a comment to tell that efx_mae_process_mport takes ownership of
   @desc, as suggested by Edward
- Also added Acked-by tag from Edward

Link to v1 patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20251022163525.86362-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/sfc/mae.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 6fd0c1e9a7d5..7cfd9000f79d 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1090,6 +1090,9 @@ void efx_mae_remove_mport(void *desc, void *arg)
 	kfree(mport);
 }
 
+/*
+ * Takes ownership of @desc, even if it returns an error
+ */
 static int efx_mae_process_mport(struct efx_nic *efx,
 				 struct mae_mport_desc *desc)
 {
@@ -1100,6 +1103,7 @@ static int efx_mae_process_mport(struct efx_nic *efx,
 	if (!IS_ERR_OR_NULL(mport)) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mport with id %u does exist!!!\n", desc->mport_id);
+		kfree(desc);
 		return -EEXIST;
 	}
 
-- 
2.43.0


