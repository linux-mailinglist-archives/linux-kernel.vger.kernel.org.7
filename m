Return-Path: <linux-kernel+bounces-873234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3AC1376D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F2545057A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAD2D46D9;
	Tue, 28 Oct 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNi/sKMc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D91F4CA9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638762; cv=none; b=g3KpuYtnXBthI09no09bPU1uYv2eALAEUYtjXoLq4AW2pQYWNoZGUCbGuC3Wy6CQHMD34mCHEG2F/Kvyj14vKx4Rf0Ant6vPvJ9NmwfD4vKhzvOf8B1dmS+mQ/Po+pDnuFO4stoyOdZJsCP/dIt5nrMWhyIt+Gde5Vjso2+baOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638762; c=relaxed/simple;
	bh=fIifTYsbWvDsiqNQGKj5ON/It7paC8FULuvuC9z03KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EKdCpzQVSIoi7P8WU3rx0YFA/TvVw4/SeQLe2i0GxTg8FqKyQUovrIegAlYBo84PuPFSCLdk4c9egG2/Noticmsa7YSEqtJ3yuzcOAzJTcVTl7OaplgF4JtncH5XyyKvbDbwRe5+xyevJZdFkV2PVE2mqYYUTCnjkWoWACKWGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNi/sKMc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7Vsw63816379
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0Zcd4XmD56ly1pDfsv+tuvgigmj+KBlI2Du
	kiBWU+eI=; b=CNi/sKMcEJkTHBsoG+Yi8DOo8mhKHIJ9Daba557facX8I4fsp95
	smydFb3SA/nx+drVUwYnJVClsnhJUTgEIASiJ7LSD3JghmrOU0RaWYYv7wSwAYCx
	GulnO/3A5w/jP2K4hCXXiywIHAV0iEnuPdx9YhzwIIfMjpkRyJPiV5rhLrOb4raR
	oJL5d3Zt6itnJnCxWcPHZRGLIjY7htfW2gUhRA2jxrYgz8UtUMOlo95aSaKdVBs4
	yDoZM/PswUcLUp/KTVcTt3gLz56e1K6dVvX8U22vGQYIFMoXad9HMLYGuRAAtGvA
	yzxgDiCS+/4DmO7QNERsmKxeXhCKeL0n85Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2fsjay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:05:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso11808207a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638759; x=1762243559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zcd4XmD56ly1pDfsv+tuvgigmj+KBlI2DukiBWU+eI=;
        b=dKGds3AjP0SBXHQOPzUH5NLtNPAjpUD+w40BKeD7BO61MuUxO/5Rw53hgJQwUy9uuT
         yrh3IZ4TW1oWECrQvqKSu7fHA3HaFKCbhiJkrwAMG3W+ZkiPqIIKlQHHb59RZ0UJjicH
         UUW4qiTVLiQ2QGgf4w4JChEtksSY4nRrt8jx6ZUGYLowxe4hzoXXur8FxVoGlnZGsqLL
         FKlNQ5WuSnNlI2laY9aZYnofESxG8dxYmC09zMvhhMxV3tyltOgogsSs9p6ft/RTLgQE
         ZWci/hqx+RYP6zw8P8shu2W9hTre8dhM2Dusq/VxOInXoTpJo7pbLvX07RvL9ctiJnhv
         r50g==
X-Forwarded-Encrypted: i=1; AJvYcCW3sC4t13AGe91eqQti+wYaRPlhkVZksPFf0m+XDPdn8uhadAXpqS+hroag/I1z0JuJXvCSmGfmHSWQtts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyW9PF4F/nXHzYLwxJvutvv/RoeB+IsVbDRaEkw8xPbi3Sjtij
	ohmrEsOVIT6XfeS4T5ukFXwg/1GO/JhlgZcMypt520jd8mmJy9aExQJBql9STSvSNJTu6a7V5Cs
	+S1wjKRjpJ5Y/7jfzam7Z4lqzpSkpfeBca9EKxrAHCTZnShb9UMuDhsshV+JVmBeQRZ0=
X-Gm-Gg: ASbGncu4XgPB3qsNK6WVsvWaxUWRyH3MlNsXXKYalhW0Hm4hG02JxCjktkitP2rkwWI
	sEXs8V80+TC7iD7Ufxn6Myo8iK1/dZQkU8I/ipYKmqTj65qhqliZwYGoJy3Gc7lgzr3lmRxICj5
	DhNHCsFChQGpn/DWvcx/7mKsxs4of7JxrhdKQI52X67MhiU9MfA7NGUlFjsCT9i8wuz+Q35viDH
	C1uNPjSnsHOUCH2VHiuGvwnD1qNFjWvOKQImhospMVZzibwU4YfjRivgqaGvQe/E4IfvzcbKKyN
	NCnYGx4n+cKURrTBNFIRKw4iUho8du0KQwFHesDPeNctFD34aMjUvN7e3/5VT73RnAfLX3Q8H9/
	mE8YTDHqpRuVBbOw2uKwy8LzwAbVC
X-Received: by 2002:a17:902:fc4b:b0:294:9476:494a with SMTP id d9443c01a7336-294cb691788mr33813005ad.56.1761638758770;
        Tue, 28 Oct 2025 01:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn8amVy2Rs8jr7wffWwUGuAfVwT1CViA13sLhLqmmBpPEoJo3lE8pIsPENsSWakIKWyMn0Mw==
X-Received: by 2002:a17:902:fc4b:b0:294:9476:494a with SMTP id d9443c01a7336-294cb691788mr33812645ad.56.1761638758152;
        Tue, 28 Oct 2025 01:05:58 -0700 (PDT)
Received: from hu-mnagar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f3fsm106668195ad.103.2025.10.28.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:05:57 -0700 (PDT)
From: Manish Nagar <manish.nagar@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths
Date: Tue, 28 Oct 2025 13:35:53 +0530
Message-Id: <20251028080553.618304-1-manish.nagar@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA2NyBTYWx0ZWRfX7653XEL6abqY
 DYVwc+yAPJGV/prajBbMDa1XKYPAmQalPuhc5SQXpi0gYKTyMesRe99RnYRTyQ26V/H0/jFyubE
 1pyD0/m6kgFDo+grM6iXAwfk7bpU8XbrvPDy/UhCSXVXeK9n7FzYXyDTESSWOynrJZIZ1No4rG2
 XbZXUrZ/k53EAPBHuC+eG6rXumgk3M+Z+z2feTZbUf9FaB9JuBRsuwAt2ZC/hs194jQIBPbJczy
 luByEqdMUqqLsAkLdlzCZYiTtBKjAYMZHT0+yqEfkMtO1i37oIcwya1ALrOdPeDXgpSPYLDjnB+
 N5EvmewsvqNU2EYq1FW6GAOCnfvuco8+wbsJOajPLp23nch6oPjwZpClBPnX1ElN4D/YEUClZnm
 obVpYBSTUOEVW19gYUTaogCBTUXGtw==
X-Proofpoint-ORIG-GUID: HbciNo5bwQOsgJ-v0SdaHaSfRwLzsDnr
X-Proofpoint-GUID: HbciNo5bwQOsgJ-v0SdaHaSfRwLzsDnr
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=69007967 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ohm9b1kf839YKAti0RMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280067

This patch addresses a race condition caused by unsynchronized
execution of multiple call paths invoking `dwc3_remove_requests()`,
leading to premature freeing of USB requests and subsequent crashes.

Three distinct execution paths interact with `dwc3_remove_requests()`:
Path 1:
Triggered via `dwc3_gadget_reset_interrupt()` during USB reset
handling. The call stack includes:
- `dwc3_ep0_reset_state()`
- `dwc3_ep0_stall_and_restart()`
- `dwc3_ep0_out_start()`
- `dwc3_remove_requests()`
- `dwc3_gadget_del_and_unmap_request()`

Path 2:
Also initiated from `dwc3_gadget_reset_interrupt()`, but through
`dwc3_stop_active_transfers()`. The call stack includes:
- `dwc3_stop_active_transfers()`
- `dwc3_remove_requests()`
- `dwc3_gadget_del_and_unmap_request()`

Path 3:
Occurs independently during `adb root` execution, which triggers
USB function unbind and bind operations. The sequence includes:
- `gserial_disconnect()`
- `usb_ep_disable()`
- `dwc3_gadget_ep_disable()`
- `dwc3_remove_requests()` with `-ESHUTDOWN` status

Path 3 operates asynchronously and lacks synchronization with Paths
1 and 2. When Path 3 completes, it disables endpoints and frees 'out'
requests. If Paths 1 or 2 are still processing these requests,
accessing freed memory leads to a crash due to use-after-free conditions.

To prevent this race condition, `usb_ep_disable()` should be made
synchronous. Specifically:
- Issue an `ENDXFER` command to stop the endpoint.
- Ensure all pending USB requests are returned to the function driver
  via `dwc3_gadget_giveback()` before freeing.

Since `gserial_disconnect` calls `usb_ep_disable()` first, modifying
`ep_disable()` to invoke the `complete()` callback for gser USB
requests ensures safe deallocation.

Additionally, the driver already includes the `dwc->ep0_in_setup`
completion mechanism, which is triggered upon returning to the
SETUP stage. This can be leveraged to coordinate and synchronize
the cleanup process effectively.

Signed-off-by: Manish Nagar <manish.nagar@oss.qualcomm.com>
---
 drivers/usb/dwc3/gadget.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6f18b4840a25..93c20d5edea1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1064,7 +1064,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
-	u32			mask;
+	int			ret;
 
 	trace_dwc3_gadget_ep_disable(dep);
 
@@ -1077,18 +1077,23 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+	/*
+	 * Stop the endpoint by issuing ENDXFER and synchronously complete
+	 * all pending USB requests before returning from ep disable.
+	 */
+	if (dep->flags & DWC3_EP_DELAY_STOP) {
+		spin_unlock(&dwc->lock);
+		reinit_completion(&dwc->ep0_in_setup);
+		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
+						  msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		spin_lock(&dwc->lock);
+		if (ret == 0)
+			dwc3_ep0_reset_state(dwc);
+	}
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	mask = DWC3_EP_TXFIFO_RESIZED | DWC3_EP_RESOURCE_ALLOCATED;
-	/*
-	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
-	 * set.  Do not clear DEP flags, so that the end transfer command will
-	 * be reattempted during the next SETUP stage.
-	 */
-	if (dep->flags & DWC3_EP_DELAY_STOP)
-		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
-	dep->flags &= mask;
+	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
 
 	/* Clear out the ep descriptors for non-ep0 */
 	if (dep->number > 1) {
-- 
2.25.1


