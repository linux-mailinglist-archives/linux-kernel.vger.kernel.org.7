Return-Path: <linux-kernel+bounces-851881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B103BD7840
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAEA18A5F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63830B504;
	Tue, 14 Oct 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHQhrPiB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBA30B518
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421883; cv=none; b=uIIaHQUvj2dCZAZRjhbi+I4GxrdOMpe+TIRQEVgImC00LxSg/AvUCGlLmTx/C7o+edvXeFQzoiWNp9vzR6t89FjTdeK66sioqT+ArzvXeyqIcTKj/uojdyAa29gFCQZWVzWTwdRrgbwz0Ec0FZ1ZbGZa0AfvsjR2HOVhfSB7TyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421883; c=relaxed/simple;
	bh=+ic5AihcIegAradhwux+QLsSKjrjS2y32uAShcvRa2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVFhWO5m/5S8Lvt90fa/+PaxZhM9tDMdwnESTOj+Vw87jf1bfenTytvghwu+KAbWk49dico1jPrGNzGUibEkK2MxN9c4TnOyZa/B08AJ6dKuPGd3BgbfR+K9cteRKXWlila0VR5sWbGucIgrLmCvKJ6JZzOdzopd/HysFeq94fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aHQhrPiB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD9t4005642
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tDnjiEFQvmj
	6QEflrGl3a0N01kBNbGPHWb9PIOiOQ2s=; b=aHQhrPiBSlcPJpMDCb4S8oq9H/z
	6vWvsWxknKCM8gFKElfXxKcq/bfHGw59tTu7aIEkwSEogNk5CirdKkLsX5PjFF/8
	HAuKQznIwur65GcbOoTuYIds5EoGvQ1ruinDQcR2RXQXdgJaB1iIWGof1Ucxkcg1
	VpgR2z+XvGKGXxnlfpT4pRCKR9upQA4IFHvcsWL1gLMASm6foLb81i9UHOMjEEs/
	kU1iJauzGDcKnw6BH/v3goWxEje4ZKEFq384jrHXsTBSr54y50G9AoUoozO8oLyN
	MxZnlYScquc67hvDonlkRCGlhj6xfc6x0FFXeDj3TUp+YEBMwS05MjV1tKA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa87bdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62cdd71290so8473278a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421879; x=1761026679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDnjiEFQvmj6QEflrGl3a0N01kBNbGPHWb9PIOiOQ2s=;
        b=BKYRqGefbHlGIj7KdLC161FXvu7IqHi7A9tN3TXHQxWxMDevs2Ez/W6ZX1xtgRZugy
         22a5mvUBJxJFoGkYJ7h/E4wUxoZHAZsH19Il+qjnNmuaAZKoqPgtT3sGWLNXJKgRy9V7
         47IqTopYgGhH5gepFv2YOpcUjHqtvQBzT/8jMbiH1r9u4H8cTftWe6R8/J8R3APSct6W
         cAuT4AIlZvLRpo0Hj8w0Qf6h/WoQU29GTepZ42U0ewZkuZ08Oig2vWiFc/s7ZEGikc5c
         +oEcCfCc4d0tqOZtMkt8Wk+tuJHcMXSo9b4zLZvcxgsRWQA2JQ9qgYhvGcILu9R+/WtW
         +WAg==
X-Forwarded-Encrypted: i=1; AJvYcCVqFDNVbhkhbcbZIC2jyAraUBuhR3px0IxzweWFUVF/GqGiD1mH+zn461dL29rrzVRNtqCo46kUfHUeIJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEaFiCjYO5s/bz/erstE28qrDPgXm022XYjRdDi5rXXcxCos/
	+N8cuTQbl3WmH0xgiNx3LLj/W7Qz1Z7LkwQL4TcC0JTnObPaIiQAl0OG2gb7rptM/YqxTkRekq0
	sRqVcj7c02gHsuib/pe/l2e7JBNS/pG7OlhB+Y+/Vx1z3Gl4RK9H1X3hg3qWmyjO6IzA=
X-Gm-Gg: ASbGncsqlK+IHLqaRNcElVs0wLYxY5swDC2iErTmAZ2HTgYSl28ZLoQ+xT6gKJldCdK
	lZCLJiTeoOSKbnsivRN8VsQlcugEfBK9lT/1XGc7uM5xzh5vsWKiUiuIvSRB+09bJk04fENnllm
	X21IZN+6Mygh4L67eeBqD5KwdBCjm31I91VZG5Hsj0HQVDc7RJmiyOf9AXbg4/veT4Kn48r/Mv4
	szsLVXqIQLe+aQxDadsreaIq3/nkEMBNLsfjk+mmQhExpcXtH4zk5CLfQgqq0ZZZj9DMSNAAKCH
	zXSJdVnLhSdaR48Pi4Jjh17jfDuZrjIykFHcNZ6gY1+0YXLR/4lxHZjltArRG3wnM/Yq4ruN
X-Received: by 2002:a05:6a20:a128:b0:32d:95f2:1fe with SMTP id adf61e73a8af0-32da8df32d3mr30176136637.2.1760421878963;
        Mon, 13 Oct 2025 23:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYbnXuM+iOSZX3hz/0dhkllzDFS6YwugLjRnZ5256l5aV2JKlrgvuY1ArMl3v0AvxE39tuXQ==
X-Received: by 2002:a05:6a20:a128:b0:32d:95f2:1fe with SMTP id adf61e73a8af0-32da8df32d3mr30176096637.2.1760421878470;
        Mon, 13 Oct 2025 23:04:38 -0700 (PDT)
Received: from hu-pkambar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm13946024b3a.9.2025.10.13.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:04:38 -0700 (PDT)
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
Subject: [PATCH V1 2/2] ufs: ufs-qcom: Disable AHIT before SQ tail update to prevent race in MCQ mode
Date: Tue, 14 Oct 2025 11:34:06 +0530
Message-Id: <20251014060406.1420475-3-palash.kambar@oss.qualcomm.com>
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
X-Proofpoint-GUID: oJkmI452E_YA3QKDMbq8MFO7XvY1QM8B
X-Proofpoint-ORIG-GUID: oJkmI452E_YA3QKDMbq8MFO7XvY1QM8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX3xZ3n+6dzOZT
 fb9tdjDm746r1x5ZLXvV82ILAmFaA9nCCyqik1Zhp/ztWkVH8efMX7fpfZM7QSjgZ/EaBObBnEk
 syY4EX+zm07+fC4xzetWH6qzEi7UZLYDk0r6TIkI/k7y++Jwm6+xm5XRjE4tGdSdidi+xrcJsrr
 dYp9TYbS8RG1dgavdrB3G9eH/iy7TnBchtCnw+qAXDFx03MKfJAogsds+k69Jcn8T7WelPlW8ea
 sV2WXSSu2gRIA52syeOFj3lV/xbQmNcRwnIIEuT4zkWW2BI8t4KBq6YdyZupdK6ZqZJa+E1yOQ0
 mydrHjZ6rCh+fJB9hmb4oDAse23Jp5gb3xOmMzzFDD0FE7TF29WFE9n3+q3S/ZjWfW3F5PiLROS
 Rwlwo4I3t5QraBuJpv6RpCjIzuP/EQ==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ede7f8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qjqbbBDWswgaW-2ywKgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

From: Can Guo <quic_cang@quicinc.com>

In MCQ mode, a race condition can occur on QCOM UFSHC V6 when the
Auto-Hibernate Idle Timer (AHIT) is close to expiring. If a data
command and a hibernate command are issued simultaneously to the
UniPro layer, the data command may be dropped.

To prevent this, AHIT is disabled by reprogramming it to 0 before
updating the SQ tail pointer. Once there are no active commands in
the UFS host controller, the timer is re-enabled.

This change ensures reliable command delivery in MCQ mode by
avoiding timing conflicts between data and hibernate operations.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
Co-developed-by: Palash Kambar <palash.kambar@oss.qualcomm.com>
Signed-off-by: Palash Kambar <palash.kambar@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 89a3328a7a75..f31239f4fc50 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1286,6 +1286,39 @@ static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
 	return 0;
 }
 
+static void ufs_qcom_send_command(struct ufs_hba *hba,
+				  struct ufshcd_lrb *lrbp)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	unsigned long flags;
+
+	if ((host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+	     host->hw_ver.step == 0) && hba->mcq_enabled) {
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		if ((++host->active_cmds) == 1)
+			/* Stop the auto-hiberate idle timer */
+			ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	}
+}
+
+static void ufs_qcom_compl_command(struct ufs_hba *hba,
+				   struct ufshcd_lrb *lrbp)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	unsigned long flags;
+
+	if ((host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+	     host->hw_ver.step == 0) && hba->mcq_enabled) {
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		if ((--host->active_cmds) == 0)
+			/* Activate the auto-hiberate idle timer */
+			ufshcd_writel(hba, hba->ahit,
+				      REG_AUTO_HIBERNATE_IDLE_TIMER);
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	}
+}
+
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -2194,6 +2227,8 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.get_ufs_hci_version	= ufs_qcom_get_ufs_hci_version,
 	.clk_scale_notify	= ufs_qcom_clk_scale_notify,
 	.setup_clocks           = ufs_qcom_setup_clocks,
+	.setup_xfer_req         = ufs_qcom_send_command,
+	.compl_command          = ufs_qcom_compl_command,
 	.hce_enable_notify      = ufs_qcom_hce_enable_notify,
 	.link_startup_notify    = ufs_qcom_link_startup_notify,
 	.pwr_change_notify	= ufs_qcom_pwr_change_notify,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 380d02333d38..a97da99361a8 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -308,6 +308,7 @@ struct ufs_qcom_host {
 	u32 phy_gear;
 
 	bool esi_enabled;
+	unsigned long active_cmds;
 };
 
 struct ufs_qcom_drvdata {
-- 
2.34.1


