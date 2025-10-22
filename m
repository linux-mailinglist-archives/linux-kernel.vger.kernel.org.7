Return-Path: <linux-kernel+bounces-864657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B263BFB45C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D8B4ED5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA72882A1;
	Wed, 22 Oct 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BiwqGmaR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5FF9EC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127240; cv=none; b=Bjz6N5oT1MdY7qKqDZgohxjx0mAwqrBU0poxcllbpZkag7p9Qmv3HZzOuEeZP5/TmTrS8RpgceV0pDpgq1eCgRfiSzhEvfbjxpNJHd7XeiLmSTJ8LIdCgZLLpOXiS0pO5YIz/qB/Lg0Y1cxUSFEoNCiTG5VA8qFiU5J/uoWuEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127240; c=relaxed/simple;
	bh=D/RdzgerUXxdXIxLj3ueFDUpefwcXH+Z33lWnyzuBUU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tIXDlPkFeo0EUQh/DiVx1bmQvt3dsAIhuWMsQlqF+NqOxTjML6AP7RPqB7gNU2k3AM9yFsfuqsxRfc9kIJHmTclZAFG3Er0YG3VN+X/lD7vwTyyXYqQTSuT/8yx04e+pShd9JFPdnDNQzAy4fIeagx7xhYeWNbyDKCtQJAKDHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BiwqGmaR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2RLIL018585
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=djuXN475bvh4
	H2/HkJC0UnX8Fj8yGhy4ORyfJcb7uws=; b=BiwqGmaRgdJksXydFdsWBqdvG3EB
	hCIEKOmFOpVqU9RnvQlhaL3yjBLvd+8HbtxYPwZ0DuPo/uq4kFJ+RVIVhQivhvX3
	a6sVrjsqoRPVjTVdBso857okpC1QFjHTV4bBTbUHwIFZhGhDw1cM8d+JJP2mu7OX
	2stPItmWg7TrtlXzEhLpas0OEK9Wbht/1IG4GUtcP5eRM6AATNQfdHMVSy54ezOD
	0P9HH0f9Q3jv+lQ2SKVbxNXrWpVM91iTM61lFmrAeZk3zp9kTUZkQ1oEQ4lQOTNn
	aqlo5Zn3ZQxjMlesUXo0Aa3aSKAPXujb3RvDGt3pP7TxySAuPjvFFVkAQQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469m59m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:00:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290b13e3ac0so65110245ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127237; x=1761732037;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djuXN475bvh4H2/HkJC0UnX8Fj8yGhy4ORyfJcb7uws=;
        b=WetesYnVhwdgI6ejrXpViLXii7gTRg9Z9vqW7hiJIRhkTsYhJhkS/PbmvceZ+66KjE
         VttbHxLVYM+qbsWq1fDfrkPgBPmdPFVzoE2Bo3GjVH2nLGcKFF41XLjz3TYUkhfM1bOf
         EAEbodPGF/SfFOQD0HQAl4/7QaEuQPEEqT88ihEYGaBn9an2gzBwyPNg7kSrzrpv4DPI
         BeIaWCfSFK1PPELrzE74zkVlWa1vbW7cdJw7lb382mwWQjGOdvDZEOE9bvUc6aPmecrq
         VZ2T7Kbl3fF/jCcgtpbGdMDD79fpbVULjpYWLlQGJMTpNbWe74jLTA8mvHw+CY8Wbu/a
         z8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjw1xNRAHT/eMGQ86QftETKamz8SRUrSAYNdvdLbALxlbhJ7Iq4Vu+KZQrJmVll3sd89Om5zjK6RE2SW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP17/XnmPNvHqXDhPzVGC0r7wp6vGNfjow73wQy1IZIGVagZ3Y
	FlBiMoavZ0t78mQuiXEOl4sP8TN0WTcZX4XLdpxxccZd5J/9bJ7LU5RSGMOebUyqMpXApYWVusw
	naasAgNmKO1HDQrycyBecsa57PBZDtXtnhX/4DOc+6l86A9D+oi4psi5rkL1WrGE/bHA=
X-Gm-Gg: ASbGncskGeoOh1JsYJH1wMsOpaqpCwSlZbFwigph6LWtxcRNVnoWbqjnKHuTmlLH7mf
	ubBhUhar8h5JEf5johBZHBNkTdOYzVe5n2mbHs0IZ4O+42ihTmIy9veVJZW0dfr1xUgozXy5D+g
	e4Zz3xcdwe/WBNelbBN4HeD3NCtHZK0i9ghQbQiLL/5f1SfK5Ga/c9jKQ+g/+91+RumzX2Fs7Lh
	cnqXbOA8W8P8+sVmwcmBg7jV/MJAcNfo9BgSIn0GLoEn7GeLn8YRPV8KlASiqmnrL3FRfVthD7P
	tUqULC6fm1hszqssB730O7Bg10LqW19XhMIUMXj3CvRl7FehVGhmpNkao4T9uHP4ObfdeRRoz5k
	4/2envBDA5/TCFrsvaFA/5o7Ef3oq09W0eaXbQw==
X-Received: by 2002:a17:902:eccb:b0:290:b53b:745b with SMTP id d9443c01a7336-290cb07cfe3mr316250615ad.39.1761127237091;
        Wed, 22 Oct 2025 03:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDROATh3RnjU12HIGSqCJPoOyvjjLYGo0+tf1o+/B9ssy41BPcCGsaC62K96HQ8/uSNiOU/w==
X-Received: by 2002:a17:902:eccb:b0:290:b53b:745b with SMTP id d9443c01a7336-290cb07cfe3mr316250005ad.39.1761127236434;
        Wed, 22 Oct 2025 03:00:36 -0700 (PDT)
Received: from hu-uaggarwa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm134729785ad.18.2025.10.22.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:00:36 -0700 (PDT)
From: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesley.cheng@oss.qualcomm.com,
        Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Subject: [RFC PATCH] usb: host: xhci: Release spinlock before xhci_handshake in command ring abort
Date: Wed, 22 Oct 2025 15:30:29 +0530
Message-Id: <20251022100029.14189-1-uttkarsh.aggarwal@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: O-v13LFtB3VNmvef_gGk7NoSWYsyDqB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX38+RKYD6vd2x
 vSXoCycjrn1F9PWzI/kcZZyvtEKStXsO9G/g42S0YJNgIEuUMFsGb1g21SPtxi2QB7+BdsD/3jh
 9mss/Kl8rCQ5U5E4OWHohU5a/EIUMxuwXYh5eL8IwuVEdz2N6BtQz66OLPBt9WDD9tNRg9ySxDi
 wjKy+W4qCp/kRErD9Cs13bgFe7OGaSZIYkXuDzbwG8IHfbumlqse80KuRPbQVGxZseyO2JIXoaR
 wUp03LQJ2pBNgR0WXSYnk1A9JGqcl814eGJLR1W3tC7s+7HlWjmVXgsnXj1sYKhuAubGteZvpkQ
 Qhb1iuhXn1d+zoecg18GvUXba+KQtWaD10KaU7mLPgr7bdB2AM+Rjaf5NTO3TDTZCr865upTqFy
 9BWzIfZZB3FLxoPC3rsqQ6xPeUL3YA==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f8ab46 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=bdA4XEzNU97oe6VxBpoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: O-v13LFtB3VNmvef_gGk7NoSWYsyDqB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently xhci_handshake is a polling loop that waits for change of state.
If this loop is executed while holding a spinlock with IRQs disabled, it
can block interrupts for up to 5 seconds.

To prevent prolonged IRQ disable durations that may lead to watchdog
timeouts, release the spinlock before invoking xhci_handshake() in
xhci_abort_cmd_ring().

The spinlock is reacquired after the handshake to continue with controller
halt and recovery if needed.

Signed-off-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 8e209aa33ea7..fca4df6a4699 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -518,10 +518,12 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * In the future we should distinguish between -ENODEV and -ETIMEDOUT
 	 * and try to recover a -ETIMEDOUT with a host controller reset.
 	 */
+	spin_unlock_irqrestore(&xhci->lock, flags);
 	ret = xhci_handshake(&xhci->op_regs->cmd_ring,
 			CMD_RING_RUNNING, 0, 5 * 1000 * 1000);
 	if (ret < 0) {
 		xhci_err(xhci, "Abort failed to stop command ring: %d\n", ret);
+		spin_lock_irqsave(&xhci->lock, flags);
 		xhci_halt(xhci);
 		xhci_hc_died(xhci);
 		return ret;
@@ -532,7 +534,6 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * but the completion event in never sent. Wait 2 secs (arbitrary
 	 * number) to handle those cases after negation of CMD_RING_RUNNING.
 	 */
-	spin_unlock_irqrestore(&xhci->lock, flags);
 	ret = wait_for_completion_timeout(&xhci->cmd_ring_stop_completion,
 					  msecs_to_jiffies(2000));
 	spin_lock_irqsave(&xhci->lock, flags);
-- 
2.17.1


