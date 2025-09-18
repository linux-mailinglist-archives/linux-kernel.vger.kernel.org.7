Return-Path: <linux-kernel+bounces-822788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CBB84AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A81B1C0587A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D308304BBD;
	Thu, 18 Sep 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LslaIhHN"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C42F291A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199900; cv=none; b=d18yGLbzmgUk07KMS81T07FyOeoH08GgtEyeJlux3BO9hPpLhuJJEr3njfvhShVRbvu69NYnRNcEicZKCPaTvfcq42keg+dKgOGa4FAx/QnSq77Q8xJKSSXFDdrK0Knu+HC2b4JS96nfpJNLQT7ivqtvNUeZ7H9IpgBka+Mk4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199900; c=relaxed/simple;
	bh=kQvQlJ4Ntkejel7Bjw96+PBXVk0IMsnf/Ap3QHrmNCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvPmNhd8V9zMsW9oj7+P9r1eYQ8mNO1UxY/9N2cDppFqy//Cgiws0y7XoIsywbvVstwwdZL8o9JJxl5o+huFNfCYipZOXVFGet/W4PJMSLGT5x7dCoGaq+2SEhODcNh4djKGWyTy+xkofauUm6yQ+7Dqs8NEa2oOoizFdxPZ3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LslaIhHN; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-31d6e39817fso1552826fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199898; x=1758804698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=kNW+/Dby2wiD1mqgghbgrR1W9F22FVm+0STq/DeHSdsqPTRNkf7UpOFJDBl69i358l
         dObLvSfpu49yWsyPa7xYiwoTd2uxSUzjLoRShqSbW5OP6bnhm8vREnmTgHv2wcH80zJR
         5lg4BZeVV2DvxLWt2zsnK/VJkWBnWdZdk2rxxPoxJf6kWIv/0s6GBB+caZnQioQktpXa
         GJ+f6cihXiMjeMkX64NjioSgt+7DmD81SsTloD8dlW/IL1wp1M4KnL0pWV44GwRy4rXz
         TDfUQkrXvn6lMbPyWHVk/DROzOKifnWU5MAAanHiGow4sBxw8Lnbrl5Vw+8uGSITDyoo
         7sjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYYDAnsGqtf2Wwb06XTajeMQpbDgGeMnmsk9VKDKEBhfhHX8JpnqWcG61eHTHH6/ecoD2mBJKssiqKM5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sz7gREX/1cTBxnAgymCPWGM1xzfLtcVAaxo/JNZeadM0BP2J
	BPRuGVVz23FLADepO5iAHnprouQulOtXvA1kEd4l4NVPjptMf89iU74IkYD2arkBlpk49QMFWur
	EE7kuphHUjT/ZdjVi70Bw5tAywtnid0kqBMt41YZDeyaI36Lq/rLE5zqJnDs7jg2Ly2b3J66FAJ
	ZRPhQmdyTPIEsdFtEPlCDG+IU11SrnyXSxJtzle/948bVO8lWI6YdnsKp4ttdmXswTCxcPuvOhP
	qJeWj1nIJdH4wsq9Fc=
X-Gm-Gg: ASbGncu87GTw+ShQ8qRP539XMCi79zzyZT+XabNe6lzWODbnGzTFOoPHcKd9lazKv6x
	Qw8KzmoQfR/k7LZIM2U8rJvTcNCzBAOoWk5BxTJcgoj47CSFW26LFz3+u99ggbxJqZPhn7ED5BQ
	ORErdqme1NBKmFhObbDtTKzuYhGoOZui+R49Mz9QVZANmb71QJchCkUIN5FjuSYbSbhRTmuQf4v
	Ulf143x9jaQwK6D1oV6FApgVm/DdEXdUqNmBEfgSB++g5nxuyX9uaSQ4/RqNvGz9RMODLwkwn6p
	QCvOEuZz6XSwMxVYOiCbE3Po9nCasJzgrX2/KyEVz+escJ+0paZYAzOF0c3Q/PNVRjUo9j7rVFq
	xeYjoaF0BMq/f7fyGsr13LdldMtjrQAp30sC7LEwoM5Cbkqm0czu/vywx8+K2Aj4K/H5Jy/dOFM
	w=
X-Google-Smtp-Source: AGHT+IESWq4mH4sp8Z+lUNAzgEw3C+ENsgHT+EduH+3vSeFrTTbxC5MvL/TtMW8ZrAi2bKUWsVN2JZT5AgfI
X-Received: by 2002:a05:6870:9108:b0:321:80a7:a1ae with SMTP id 586e51a60fabf-335be1b9af7mr3451091fac.14.1758199898392;
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6487e6asm263842fac.15.2025.09.18.05.51.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-81312a26ea3so198250285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758199897; x=1758804697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=LslaIhHN8O1aqX4njQmgjBJ8PQRnMwz7Ab+NaSVl7RoIgRH7YZj6NVlA156wkUW9eg
         lPMN6c1EhgexICQWPKFLX6OzwdczuMxaN1stubIyEKkAfzOKU+3khSNAQEJ/x8Igl/Vm
         IjrCVCkZ/BElS/wgmkD1MmaqDoeJYtjYVbh6w=
X-Forwarded-Encrypted: i=1; AJvYcCWTCapMQG4kyVhPf5EPeDtEIYEKCjF4Ha6m//+EsWTUE0c/a8MWkICjtAxdmDVIGhEJdR7ZuA+RrDmGf1g=@vger.kernel.org
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617476985a.48.1758199897523;
        Thu, 18 Sep 2025 05:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617472985a.48.1758199896971;
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm159592685a.23.2025.09.18.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pv-drivers@vmware.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.6-v6.12] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 18 Sep 2025 12:37:32 +0000
Message-Id: <20250918123732.502171-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>

[ Upstream commit 0dd765fae295832934bf28e45dd5a355e0891ed4 ]

vmxnet3 does not unregister xdp rxq info in the
vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
is not invoked in this code path. So, we get below message with a
backtrace.

Missing unregister, handled but fix driver
WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
__xdp_rxq_info_reg+0x93/0xf0

This patch fixes the problem by moving the unregister
code of XDP from vmxnet3_rq_destroy() to vmxnet3_rq_cleanup().

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Link: https://patch.msgid.link/20250320045522.57892-1-sankararaman.jayaraman@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v6.6, v6.12]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1a..3df6aabc7e339 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2033,6 +2033,11 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 
 	rq->comp_ring.gen = VMXNET3_INIT_GEN;
 	rq->comp_ring.next2proc = 0;
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
+	page_pool_destroy(rq->page_pool);
+	rq->page_pool = NULL;
 }
 
 
@@ -2073,11 +2078,6 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		}
 	}
 
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
-	rq->page_pool = NULL;
-
 	if (rq->data_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev,
 				  rq->rx_ring[0].size * rq->data_ring.desc_size,
-- 
2.39.5

