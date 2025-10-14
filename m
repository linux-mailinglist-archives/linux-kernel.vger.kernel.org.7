Return-Path: <linux-kernel+bounces-851879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C868BD782B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E65D18A5D57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EAF30C608;
	Tue, 14 Oct 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGqf4dUQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56A308F39
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421874; cv=none; b=DHP6cf622Qb0o1wTR0XabDuyOUJtr6oblQQii5ytW/fftE7RwUphft11WKXbr3pZmeX7pwPADQIO9uKvXA0dh7l3yO6qPPJx+aIz1UnTSgNZp/GZD2R/q8iJnoJDMtqfbp4hDEO3ecbPlfpQfiyuC7aj1NzQ/gRkpXJjHtsAFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421874; c=relaxed/simple;
	bh=sG4YcFPqULxpiO6jk4SnmPt855dNmwjEUSYMSQEfyaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqiTg/1YLRzDcTINypnLKJxbMecjLuo6b0nfpZfUFgPlporh0Jd/Kz2jMVfiNZHA1hDN6w67cWEPvlAhnKFKuRjAqXG9nM7L58b9uq28C1ZstTJd9C6LLxegHAXsLWwTsFuwkrxxieO+X7L6Y/o3m/OItecOGpxp0JXEliFOuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGqf4dUQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD8SD011865
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zMPUSJunhaD
	fhK9Gz/rT4F4i0rAWTDEoYWH8yvRVirU=; b=DGqf4dUQUmhLgIf73TcWxNgehnu
	EzpLDyIAM91JEVXOzvE+Ot+D61KUtU7jbuT5tBjYUCNerq2wcIU7xhkdZ7EYCG9+
	5tK/6y4eYHuA9eXWzZ2TfreTsVb5gwxfcNJx1an/PSUqHxfARjGEtZGzxM0YMRYM
	McW7iNw4xjQFZFWGPP/f/vOqo5GKCZ2P6uc1WY2AxdNcumqYrwqjcmRDjAQ7kr1k
	ZkQ78Z7NY2VpokwBK+dNSCFeCinr2ZDKqjAsGbOOrOnMyrJfZ09dTWwsWGXHgyfK
	xiB4voq1+a2szMITkWkw8Kw9580APQevE6c24Kxfwbho7CRDyQhjw06Gstw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5fbx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f9cc532bso7261089b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421869; x=1761026669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMPUSJunhaDfhK9Gz/rT4F4i0rAWTDEoYWH8yvRVirU=;
        b=Y7Au9wMQZwJhoHiP6elxRznyxCBOwUSFHYQtyBmT50Hj1Xk0ldI0sDZZs9aNxH/Zsz
         Hr6zc4DiNknKKhbjQU88rvgKRTeRrybHU6ajkPjBmgtgwIxN2B9dxo1t5iU4wrib+EG3
         6H65gXIf6gtHTfPfA8bsr11Rs3zP9OsZ2zQKywSU7Voa/qYioNhMQ6i0c7fP6fbYRnIO
         lAjnXGx0WVg1dGTl4ZKMX730KfwWadtJ4XYj7UKupdJjr6psbdC/SlIiiHMpZd/ikx0D
         sguXLJL9kurZdUhETzzrv2X0+7PfCyuVjWyfUuJg4fu4FRqzuaOt3ZBbREywncp3PYYG
         BQpw==
X-Forwarded-Encrypted: i=1; AJvYcCXtHUK5Nw3F2O+VvDC40+5E0qD+tzXW8QCHAlA4g7oLB0cjQ/EtxFgULttFyAyc6x0eWTZ8TD8VXM5y3XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCu8FxKvYmU/ZE6En2sBfG5x4dS3F3rATrirGcAN0pp7TzIc7H
	LwRPaIQO+nKBawFWali3RFHOiZDJOTVSnhe+s2cPYe7dU4czOH1XsBO52a9EUCHSWh0AhocK7zS
	qUdZR3a8hMHphF0zXyV8uFXjhw/cd9Nq+NjoOnHROr0ophy5kG9L2ij19sGxQs273jqc=
X-Gm-Gg: ASbGncvKqmN2S3rzY/Uw7JXDmMDjR1XCllUxSXHoalZXX0fHuv036qj7/MmPVi61ZDu
	vuXxxsnA2ffn416PQVQbA1k4NKcqYjyf5pPWYgu0KwmCEmW8WM0MZu/LsKjLo22/vMZpg+eyz+5
	HBQM+NlR73rYCVoJEE3UOpUThVJi5b+j2KdVNRI9MRVBGCUYANwqJrJ/kVjDEKPZtDgGUmKGPaH
	GEKnPTr7CH5VfjDtZQyuwanwlknUWQL0GxAKqcJU294m0mZ1aGfc44h1NWoLO4xnbTwvFhZse/y
	t8R7qhxT3hv4MFDbKUdwHIfv14gvo5AQHYstSWac55BEm4Jy/FdAioxcGeMaXN01IevI4L+s
X-Received: by 2002:a05:6a00:3d51:b0:77f:3826:3472 with SMTP id d2e1a72fcca58-79397924911mr28190327b3a.6.1760421869036;
        Mon, 13 Oct 2025 23:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwMcocoLQ72iCYUYIIvWMNhyDUjxN82rfxBDl9IFZAS/hghDGDfVHM+Dk+s0hTKSUzFfkB2g==
X-Received: by 2002:a05:6a00:3d51:b0:77f:3826:3472 with SMTP id d2e1a72fcca58-79397924911mr28190297b3a.6.1760421868520;
        Mon, 13 Oct 2025 23:04:28 -0700 (PDT)
Received: from hu-pkambar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm13946024b3a.9.2025.10.13.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:04:28 -0700 (PDT)
From: palash.kambar@oss.qualcomm.com
To: mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, peter.griffin@linaro.org, krzk@kernel.org,
        peter.wang@mediatek.com, beanhuo@micron.com, quic_nguyenb@quicinc.com,
        adrian.hunter@intel.com, ebiggers@kernel.org,
        neil.armstrong@linaro.org, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com,
        Palash Kambar <palash.kambar@oss.qualcomm.com>
Subject: [PATCH V1 1/2] ufs: core:Add vendor-specific callbacks and update setup_xfer_req interface
Date: Tue, 14 Oct 2025 11:34:05 +0530
Message-Id: <20251014060406.1420475-2-palash.kambar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014060406.1420475-1-palash.kambar@oss.qualcomm.com>
References: <20251014060406.1420475-1-palash.kambar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aeqqRci3yfwJsbxCZf1vwkBph0FFgbZC
X-Proofpoint-ORIG-GUID: aeqqRci3yfwJsbxCZf1vwkBph0FFgbZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX5vj/88B410U6
 GCom07UrtEoiIKH9BumW3NM78gANyJk6X3ZxX8FFe/9CWqX9aBptQrmEm6rdWg0kkNfRab9ev0o
 BBT7/SAtb9orpxnQ7FW3dn/DkLNXQIqaZZ6zjnDosARmfO4bStQyDIobLKYs3AlM9YoWr+JslPX
 tWeiHI1qvYknPQtfh9TRKZ5uJa4FmlYZtGQUgwc/59Q+LWtM5eFnpD6sk5VH58dRr2MJzuqgyUI
 ur2lIWc/OUgWWUiXiH3TV59zdc/QN3/28CklBXZb/pB4pNNrpSBiBrF8fvq+6rKc+lUrDzFz27F
 vvnrKeZbrPz8ydBHWe2jCaqZ0761ZYl355djHXTp5giKc9C+wK7opdyn2caGyAhQZtYH+m0vtKu
 uChCXTPs2BuYWcYnWs2vnynHD5Hy5Q==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ede7ee cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Nzu2oylm7KG0C_1tlNEA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

From: Palash Kambar <palash.kambar@oss.qualcomm.com>

On QCOM UFSHC V6 in MCQ mode, a race condition exists where simultaneous
data and hibernate commands can cause data commands to be dropped when
the Auto-Hibernate Idle Timer (AHIT) is near expiration.

To mitigate this, AHIT is disabled before updating the SQ tail pointer,
and re-enabled only when no active commands remain. This prevents
conflicting command sequences from reaching the UniPro layer during
critical timing windows.

To support this:
- Introduce a new vendor operation `compl_command` to allow vendors to
  handle command completion in a customized manner.
- Update the argument list for the existing `setup_xfer_req` vendor
  operation to align with the updated UFS core interface.
- Modify the Exynos-specific `setup_xfer_req` implementation to match
  the new interface and support the AHIT handling logic.

Signed-off-by: Palash Kambar <palash.kambar@oss.qualcomm.com>
---
 drivers/ufs/core/ufshcd.c     | 6 ++++--
 drivers/ufs/host/ufs-exynos.c | 6 +++++-
 include/ufs/ufshcd.h          | 5 +++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 568a449e7331..fd771d6c315e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2383,11 +2383,11 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 		memcpy(dest, src, utrd_size);
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
+		hba->vops->setup_xfer_req(hba, lrbp);
 	} else {
 		spin_lock_irqsave(&hba->outstanding_lock, flags);
 		if (hba->vops && hba->vops->setup_xfer_req)
-			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
-						  !!lrbp->cmd);
+			hba->vops->setup_xfer_req(hba, lrbp);
 		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
 		ufshcd_writel(hba, 1 << lrbp->task_tag,
 			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
@@ -5637,6 +5637,7 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 	}
 	cmd = lrbp->cmd;
 	if (cmd) {
+		hba->vops->compl_command(hba, lrbp);
 		if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
 			ufshcd_update_monitor(hba, lrbp);
 		ufshcd_add_command_trace(hba, task_tag, UFS_CMD_COMP);
@@ -5645,6 +5646,7 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 		/* Do not touch lrbp after scsi done */
 		scsi_done(cmd);
 	} else {
+		hba->vops->compl_command(hba, lrbp);
 		if (cqe) {
 			ocs = le32_to_cpu(cqe->status) & MASK_OCS;
 			lrbp->utr_descriptor_ptr->header.ocs = ocs;
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 70d195179eba..d87276f45e01 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -910,11 +910,15 @@ static int exynos_ufs_post_pwr_mode(struct ufs_hba *hba,
 }
 
 static void exynos_ufs_specify_nexus_t_xfer_req(struct ufs_hba *hba,
-						int tag, bool is_scsi_cmd)
+						struct ufshcd_lrb *lrbp)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 	u32 type;
+	int tag;
+	bool is_scsi_cmd;
 
+	tag = lrbp->task_tag;
+	is_scsi_cmd = !!lrbp->cmd;
 	type =  hci_readl(ufs, HCI_UTRL_NEXUS_TYPE);
 
 	if (is_scsi_cmd)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ea0021f067c9..845f0df34281 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -356,8 +356,9 @@ struct ufs_hba_variant_ops {
 			enum ufs_notify_change_status status,
 			const struct ufs_pa_layer_attr *desired_pwr_mode,
 			struct ufs_pa_layer_attr *final_params);
-	void	(*setup_xfer_req)(struct ufs_hba *hba, int tag,
-				  bool is_scsi_cmd);
+	void	(*setup_xfer_req)(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
+	void	(*compl_command)(struct ufs_hba *hba,
+				 struct ufshcd_lrb *lrbp);
 	void	(*setup_task_mgmt)(struct ufs_hba *, int, u8);
 	void    (*hibern8_notify)(struct ufs_hba *, enum uic_cmd_dme,
 					enum ufs_notify_change_status);
-- 
2.34.1


