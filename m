Return-Path: <linux-kernel+bounces-650925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E28AB97D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB833BE6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3322D9FF;
	Fri, 16 May 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VY6vauHw"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231C282E1
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384655; cv=none; b=W4/vlh7jjv1vNdIt++nU2X60O3aQ9B50PwqOIpq2eaAjvB/JaCX6JtlV7194FIH2WExl/MMx3n+LzlyLnuGwbng8Vp1YQXjS/J/PMJdL9FyoZ1VEBx+ne/JITVDVZNTqSpg9rn/5K1wTzyzPAH2yB+fXR1GdMimCTBDX270tRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384655; c=relaxed/simple;
	bh=fi7qBQVzRR/BDXaQCkUxtll5IWUl9/nKV++lPsLDtZQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=a9K4427of+2JJGi8d+2coli4r5DywO/dcRrgjJiQOhq7DJ0PSOLd9jPX5faCXNee9S8ywtiHYpfGxkUM5A0plTdmZvkboDKMMzMo7BEmTFbmXqraAIYMYX3TUm7TGeZkvuK2v5iUZZTFubP//qWNTbxqXAh5x6SR6f8J/a51GhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VY6vauHw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250516083724epoutp0172ecd7822acefab5da2412f9b686f0a5~-9ROaW2h63199431994epoutp01z
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 08:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250516083724epoutp0172ecd7822acefab5da2412f9b686f0a5~-9ROaW2h63199431994epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747384645;
	bh=4Zhu/vBMgvVq9L8aEv9dFQUEhIuLX61Uo6B2T4FP0rQ=;
	h=From:To:Subject:Date:References:From;
	b=VY6vauHwa5U9PyfKXdlk9vquDD00fnqFsuIhWrnH7SMEbZ2W2CJSuV0RqUODVSPXj
	 fDNgzVFiRpP1ubiUkfB1iYDIW4BaIqFegfHtjUxTgM90lIjcS0l0oAgfCoMx2cz8/j
	 fN7Sugzi7y8vZ1rBkE8NceAVOKnoEn7EMXO3ZD4E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250516083724epcas5p4e69fbb3781dec4dabd3d5811f4184ca7~-9RNveLRe2035120351epcas5p4J;
	Fri, 16 May 2025 08:37:24 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZzL6r1h0Vz6B9mB; Fri, 16 May
	2025 08:37:24 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250516083723epcas5p216a21ffb81631d35f0a12f7a583ea248~-9RNeGMEZ1166711667epcas5p2C;
	Fri, 16 May 2025 08:37:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250516083723epsmtrp1dfd1976faf326d98147978e81e3b387b~-9RNdRYxX1472814728epsmtrp1K;
	Fri, 16 May 2025 08:37:23 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-d5-6826f9430553
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.4E.07818.349F6286; Fri, 16 May 2025 17:37:23 +0900 (KST)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250516083723epsmtip12f72bf26ad708cadebac3e7b790a3275~-9RMrqrIA1581115811epsmtip11;
	Fri, 16 May 2025 08:37:23 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	peter.wang@mediatek.com, minwoo.im@samsung.com,
	manivannan.sadhasivam@linaro.org, chenyuan0y@gmail.com,
	ping.gao@samsung.com, cw9316.lee@samsung.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: mcq: delete ufshcd_release_scsi_cmd in
 ufshcd_mcq_abort
Date: Fri, 16 May 2025 16:38:12 +0800
Message-Id: <20250516083812.3894396-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnK7zT7UMgz3fTCwezNvGZvHy51U2
	i2kffjJbvJyxlNlixqk2VouN/RwWl3fNYbPovr6DzeJuSyerxfLj/5gsnp0+wGyx9dNvVovP
	TxcwOfB6XL7i7bFz1l12j2mTTrF53Lm2h82j5eR+Fo+PT2+xePRtWcXo8XmTnEf7gW6mAM4o
	LpuU1JzMstQifbsErozGpVvZCtZyVbQ27mFuYDzI0cXIySEhYCLx4dIP1i5GLg4hgd2MEjs7
	lzJDJCQkPnf+YYWwhSVW/nvODlH0lFFi1vn57CAJNgF1iT/X74J1iwi8Z5I4eq+VBSQhLBAs
	sefREbAiFgFVidNr7oNN5RWwlri68DQbxFR5if0Hz0LFBSVOznwC1ssMFG/eOpt5AiPvLCSp
	WUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBAe8lsYOxnffmvQPMTJxMB5i
	lOBgVhLhvZ6lnCHEm5JYWZValB9fVJqTWnyIUZqDRUmcd6VhRLqQQHpiSWp2ampBahFMlomD
	U6qBKae/IO0il9XujNpTdz66L1WK8pJn26n/L7iPsZ9josiRBbYHexLZjQQV8m96SK4JnuFz
	WeSTlFvxagZvXePwhxumhHpd7TMRYLQIkI/ovy1oyO+v+5cvOu+XxuwFLs+O/vyzIu7l3UUS
	qY/fzdBU/1/yWd5B1C7huXXb8sgd7wvy6/r2clmXzPO9c1ff5eyZ9/w8JX8NOT5nv2NOKtp7
	iondcqmRjeEE777/tf1Jq5fk7jfJaY1lOs0T8WblL0GRzSk7ol7uOmf5/0vV1R2ZKxsf8Py6
	/OlixboZnm33vQ8uV4g45PrvImvCljsRzZGKL8wKOn5nXlNeeLL2yLpihsoNlo4PAxbK3b5o
	rxylxFKckWioxVxUnAgA5yrrAOcCAAA=
X-CMS-MailID: 20250516083723epcas5p216a21ffb81631d35f0a12f7a583ea248
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20250516083723epcas5p216a21ffb81631d35f0a12f7a583ea248
References: <CGME20250516083723epcas5p216a21ffb81631d35f0a12f7a583ea248@epcas5p2.samsung.com>

after ufs UFS_ABORT_TASK process successfully , host will generate
mcq irq for abort tag with response OCS_ABORTED
ufshcd_compl_one_cqe ->
    ufshcd_release_scsi_cmd

But in ufshcd_mcq_abort already do ufshcd_release_scsi_cmd, this means
 __ufshcd_release will be done twice.

This means hba->clk_gating.active_reqs also will be decrease twice, it
will be negtive, so delete ufshcd_release_scsi_cmd in ufshcd_mcq_abort
function.

static void __ufshcd_release(struct ufs_hba *hba)
{
    if (!ufshcd_is_clkgating_allowed(hba))
        return;

    hba->clk_gating.active_reqs--;

    if (hba->clk_gating.active_reqs < 0) {
        panic("ufs abnormal active_reqs!!!!!!");
    }

    ...
}
Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index f1294c29f484..2106c63db5ca 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -713,10 +713,5 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 		return FAILED;
 	}
 
-	spin_lock_irqsave(&hwq->cq_lock, flags);
-	if (ufshcd_cmd_inflight(lrbp->cmd))
-		ufshcd_release_scsi_cmd(hba, lrbp);
-	spin_unlock_irqrestore(&hwq->cq_lock, flags);
-
 	return SUCCESS;
 }
-- 
2.25.1


