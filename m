Return-Path: <linux-kernel+bounces-762200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F66AB20353
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655487AE5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792232DD5E0;
	Mon, 11 Aug 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvPopkPD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455F2BB1D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904414; cv=none; b=RGsW891yL8uFIqSAgU06Bat4SCd9y0RM9diPXjfHvRM9gP/QkOS0wR4aq/OtRkyh5wOpK7CFsQxjw8joNwnvm70NbOIjmv5JPXn6NS/V5Vgmp5H/rdw+va9or8ZiXzqt5I7vxNWqq1337NbcxR920w5CLWmAXduHrfBSJYrb2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904414; c=relaxed/simple;
	bh=+Jn84KhDH5JdiT/uUB9NAEewloBck7n4PYNux60R0aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKFysAbOOHh4fx/Y1aBknqiJBcd+5t+IuYbz/FzAT6H+ugIIm+tzi9oxqjGpCD5fVf42cgsx+0A6LTBMZmEknqjTcWWbllyGvCfYiWPN5AguYkqNW43oEOq3JVPBQeGudwPWa5navsefEwdZ3swqtMmbX1JBQCibd+HYWLclTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvPopkPD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9LooJ027099
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CQPpOmZCkWntibNDeZA3Oh
	vcnLM7mE0auXLL4JL2KE8=; b=XvPopkPDYFoer9PRjH7nxiyjqJ9uJBqvniz6G3
	rxxZ8tzr7QO3+LKhNVYXuaeTjGPb/ntAnqokDayZfDkj8j3NOtE1gK0Nai498oW9
	pze4+XISscyvhllrvIF6GANVdwzd6HaJyD9/G0Xk+gfwzSg4XGTozPwVjiapv+28
	keq60LNaIinPdW8UmEdYglU5hRl+ybmo+/WQkx6uJZNgvuJT6nFWybO/NXFwSYac
	Xmx38tHyFfhNWMdFOvUFnF8AKRb6gqEa5J+zFZN0m468JhBZGHCpNa/gGslaLy1p
	nWCDTU3rW3MNdiK6eHAT6qQuchzgu05tPBQ6ZtdmLMiAaG5Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbrxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:26:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-242abac2cb4so48739495ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904412; x=1755509212;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQPpOmZCkWntibNDeZA3OhvcnLM7mE0auXLL4JL2KE8=;
        b=catYrT+a0raWt2iIUQ56atMwuSYL/TmOme4kGD7OwZeV5pCieSsX7yDmTOvhQ5Qky6
         sa16AtPFF1FXJdxBL4mWJVl3nC2Ci6pDqtSpDVB9mLqGou/EhdKNL6nnyEpxlxpuVkvQ
         aLcFCUSrSxLstYl3RxjYmwIG3dPgewHHpXPm/Ay7N5NCYMZpWV4kktH5F+LfxbPZ9RGN
         Mj4VG01bEIDJIUnYsEcDuWqf7sKdfm3iFUSNxiidqcAUg614DzR4h6hjfQ1fa7dy2GeQ
         aSrIlue7DAtDDDTG630L4uGjkS6uQ/l2hwnMvZexjYbXX2i9Wdk2dpLXZ5z6KrGtpSWX
         qXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyzbr/srjaf4wOMy7caNNn8soqN+LUzFy7bsWHzvaEWdrxx1SALbKsKQcAOZ6yY+qSk1ENPMreuKKP208=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3tApGtpT47P30Y3HPWladbrHFA+nA48p5j4+Oo972s7QSYv1
	C4lZ/wH1JrcQ2T58Du0nEMBBU22w/hpzUXEQxDjUXFzpDHWjLGVcD27UsSw78UDZ3krlGFKwd5S
	24oxVSsUhxpkc76JEzPGiaBnxVPh30tUkNiF4Mu0eudVMxEWHlqspfx57HqOWcLITV0c=
X-Gm-Gg: ASbGncsobcfmviXYWGC//aqcOddNIRAksX2pBQRw0XCXpXrW8+OEVaTePTNKbj3CPWJ
	no6/r+C/tlpIJ1agvWCzqQXam6hBz8aL/IdFCdDXfw5CldNz+aX1KmU8rwxWv2R5YZRgIFw9dZ/
	tw1DbuPHMrhu99BWavzx06F5yc0a4xfKV4N2IASaRBq1eDoIg3g9s4w3EzxxZL5yjNzFgqFImzi
	N74bPmEK7imyPLaDleip7+7s2uHt6fldhLP9UKICSpAZCy88urb5BvrDAXbSUNkT5bowdjdJZG2
	OZ17jQf78GLU+dNxzR6OtdLMzg4h9qBnZY6VaP9SJM+6zKnP9AZhHqDlP6TrE7SC6S+p113rUYn
	pjKBVem0rZgGAh3EivQ==
X-Received: by 2002:a17:902:ec89:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-242c21dce5emr200859375ad.31.1754904411734;
        Mon, 11 Aug 2025 02:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv4VfSrPpmI4rTjy7szf5KU+m0hImvSmhqNQsa45lSoD5gt6acMlPIQBIsBIaMqJW5fw/yjw==
X-Received: by 2002:a17:902:ec89:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-242c21dce5emr200859025ad.31.1754904411226;
        Mon, 11 Aug 2025 02:26:51 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612864b5sm14277228a91.28.2025.08.11.02.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:26:50 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 17:26:45 +0800
Subject: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for service
 ready message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFS3mWgC/42NQQ6CMBREr0K69pP+UgRceQ/j4gNFGrXVFiqEc
 HcbVi5MdDPJZDLvLcwrp5Vnh2RhTgXttTWx4C5hTU/mokC3sTPBRc6LjAMNPfIrULC6hdEY1Sj
 vyc3wIj0AVa0sMdvLincsMh5OdXra+CcWr2DUNLBzXHrtB+vmTRxw2/90BASEFqOpyASRpKP1P
 n2OdGvs/Z7G2ARBfELxF1REaCMliRqzsi7yL9B1Xd8nji7IMAEAAA==
X-Change-ID: 20250730-ath10k-avoid-unnecessary-wait-a9d48136490f
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/07jY4pkbUAv
 iFx+5ce0j2feNdqXuZTKapYdWps/23jqN4NpTmMBbH/sg0ujhkscuimeiZG4gT0Q2HCwfUseWdz
 ov13n61E2ACfQ5sZH74Sa1hbCmFRmGtQDf2n3oxAZvhBnog8JsGALJ+QitLYJCLXXX3Fv9pYsob
 sRYlcDIV16X6LTMk6MUutOvO3GTLFGgEbPrTVqSlnRBZ2cxhCDlB5Yufuoq0iVfdESZjuJmABa7
 E1YJOAz5FIkU0LpdDong26YmHCSGpA0bcwMD4YyW3BitT8oScjngvvZgazzrr3WerlHkL9NPTX9
 LzgVu8wgu7r2X7k0yu7rsupOWFkXf7QYrEGCZ9PxhI0dCgQI+D+CfE1SlzXLBeXOzzFON+fZZCg
 IjgHTEQw
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899b75c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=h8RaaEB6tyxFYfTmgIUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1i_qB3im06ngn4ISgM5anmluNEYd6t7v
X-Proofpoint-ORIG-GUID: 1i_qB3im06ngn4ISgM5anmluNEYd6t7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
failing") works around the failure in waiting for the service ready
message by active polling. Note the polling is triggered after initial
wait timeout, which means that the wait-till-timeout can not be avoided
even the message is ready.

A possible fix is to do polling once before wait as well, however this
can not handle the race that the message arrives right after polling.
So the solution is to do periodic polling until timeout.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1

Fixes: e57b7d62a1b2 ("wifi: ath10k: poll service ready message before failing")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/all/97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 39 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cb8ae751eb312109f74985580065c3b9d3806d51..e595b0979a56d3110ce0acf534e718a4a1f36a0b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1764,33 +1764,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
+	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
 	unsigned long time_left, i;
 
-	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left) {
-		/* Sometimes the PCI HIF doesn't receive interrupt
-		 * for the service ready message even if the buffer
-		 * was completed. PCIe sniffer shows that it's
-		 * because the corresponding CE ring doesn't fires
-		 * it. Workaround here by polling CE rings once.
-		 */
-		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
-
+	/* Sometimes the PCI HIF doesn't receive interrupt
+	 * for the service ready message even if the buffer
+	 * was completed. PCIe sniffer shows that it's
+	 * because the corresponding CE ring doesn't fires
+	 * it. Workaround here by polling CE rings. Since
+	 * the message could arrive at any time, continue
+	 * polling until timeout.
+	 */
+	do {
 		for (i = 0; i < CE_COUNT; i++)
 			ath10k_hif_send_complete_check(ar, i, 1);
 
+		/* The 100 ms granularity is a tradeoff considering scheduler
+		 * overhead and response latency
+		 */
 		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-							WMI_SERVICE_READY_TIMEOUT_HZ);
-		if (!time_left) {
-			ath10k_warn(ar, "polling timed out\n");
-			return -ETIMEDOUT;
-		}
-
-		ath10k_warn(ar, "service ready completion received, continuing normally\n");
-	}
+							msecs_to_jiffies(100));
+		if (time_left)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-	return 0;
+	ath10k_warn(ar, "failed to receive service ready completion\n");
+	return -ETIMEDOUT;
 }
 
 int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)

---
base-commit: 0f79768f8d665b43b77967d38b5df6ccebe8cb57
change-id: 20250730-ath10k-avoid-unnecessary-wait-a9d48136490f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


