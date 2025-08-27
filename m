Return-Path: <linux-kernel+bounces-788822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5BB38AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23701C221AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E92F1FD8;
	Wed, 27 Aug 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fs4jMqr5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3762EDD62
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325569; cv=none; b=pNQPbgRekWnTUbj/AfPkvGe2FVG1uIVAg7vCIE+tcQzTSLgBg3k6m4/auVovFXw1rF0nIMR2aj0D48rt392NT6zhwYPSiyoZARB4KXZaFPfZS6a1lCalKcy/48FJgACsEhS6YDdHBQK7QRJ+n2tObwcE4QdB2f0YZeYyUJeK7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325569; c=relaxed/simple;
	bh=meLDgphMIzrKjvme/9NyKwkff6sfs1AHm861URMwqb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IytXqrEa7QBVV5EBDbwqfA3l+PSD7qUeel/ycJk1tgHIDP+u4BBLH9aDXuIHWWEWCJBrp0Jl5wED3nPWYDrE/fhdejZVuMJA5ktVvqFh9m7Vm3vvXIdM5SfLpMKTR6RwHY+7lB0xGJD4wthSdsKr8mP/wnlNIUsdDeQ4Ggk/BEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fs4jMqr5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGfnn6022886
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eCTGEcbB5k6
	fBhyVH2N2aNB10W+jMPYCn5g3eW0CwJw=; b=Fs4jMqr5JCTbDd4qFcRfY/09Ofk
	eKJDb797kgpfG9loG4XpEYoqSI6XHNEfxufqT3Bwt0A2dwq1iUYlYIGiRZ7WXhxu
	PUBz0Cl0xkFJDyt6Jthf80vg/OrEgLmXGfohIUzaVyOT74yKtLrhp4BcvZXlKTOM
	vUWi9A/Njoa3QCXK/h61rrOJrTEgif7XFU1vjd3ktTgayO/R2IpfqSItgTlq/8uK
	bJ8mTgMGSvjBdvq21PF+0bT7UEejyb4AzVfFdIOLT7FHZ9pM0qr/KLp9SmsJm4lB
	dNAlV5UUiWkZlg/uMkO+5RRVLFUajDjG1LD26096NxVEAbl1xIevbf+kSIg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5nmha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:12:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7720cb56ee3so394554b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325565; x=1756930365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCTGEcbB5k6fBhyVH2N2aNB10W+jMPYCn5g3eW0CwJw=;
        b=SvFmktBQHvnlrakefDJq6D5c0eJgfPuR36fHTXP8/H154pdfJZzd+5oBuHUw4J2rIk
         lBIsGIKtUH5Qj2HvYtv5wL1/nvJqJpQPx+7J7YzhUmDdyDpkpt5k2L4N8jgx2tAt1tOJ
         v2WpubN6BFIETT1orugL0Ko7pqCoj02VIsOKpSrqeXRXFeE6geIJ0Ofz0bBwA3Eic91e
         fKnivKnXQaM9wG7Z9br8ZGV6KSG5CRtHeQCx+HwBMk/kGM6pKXXworIbiXvnKDpVGGD2
         SAYwsOZeTDNePw7gbcxTqpLRHm+YWDdq44A0edvp25Lm3ag0WIHuPqX4Wp2ypCdb/JnT
         hW5A==
X-Forwarded-Encrypted: i=1; AJvYcCWUMXvcEMaBZyt9NXbX5iI19g4qnVDS/2cB7j8y/OW9hothXQlAMQVVuvAcd4qXJMfQzMgmtLi/pu5VoFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zcSa5XwKRzYcb6SThJQBBEwQkEkoK8EciSM11d1J10Ye5gUW
	hs97syWBfBjNY2w+bWl3/jATtZi/vmm7YmKbN+SB/L13RzLJHAMuq2qcd3i1jpRNzmU8rLilayd
	RA3C06n17ImxOk/++AENg1HKy5+yPv2AAUpZ4iL5W5gCOjEn3PegO6ZChWc0gYOv3HCk=
X-Gm-Gg: ASbGncuQS3rCrWWEL1OcThEwuXF0zi9eR3XGX4S6WoNotlrCb1UGh2PcS9i7AZHhAoQ
	yvIzyvhlrq9vm8lQETkw/VmOEi0KiBJ9znoi6VhGGaoaY+8XQWyfQnKCvrSVuzgvHrhGLO1gG8x
	hDgFq/oR3mA8QOtbUzFpovfo1OoFh0Mstvn1kfwrL0AkhARkSAtO3yvzvwDmyJFCtoEMhSSAmCb
	cpVm+kK8aBggPq9hM/0Zu00tl4gQ0Gjb7z8f8EtBxGvm5JHj8exVi+XFn9MA/w8wSEdmKEFKeMm
	3Zn00Rt81lsia9ZBacDtwotnTgDmJ/vctaKFapFpom0ON1vVLrG/V+2Xu6C3r6wq+1PP9zrwz0R
	WgTFDhEBoCJNDraZVESn7JT6kUXY=
X-Received: by 2002:a05:6a20:9188:b0:215:d565:3026 with SMTP id adf61e73a8af0-24340b5ada1mr27366899637.20.1756325565212;
        Wed, 27 Aug 2025 13:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIj8L+nwLix1KG/6QnjHpZZhIafsh1DBdgu75+84yKYOIB7X2r8rCg6cN0Ay9YbseD9uexTw==
X-Received: by 2002:a05:6a20:9188:b0:215:d565:3026 with SMTP id adf61e73a8af0-24340b5ada1mr27366868637.20.1756325564771;
        Wed, 27 Aug 2025 13:12:44 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbaffdsm12185234a12.51.2025.08.27.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:12:43 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/2] usb: typec: ucsi_glink: Update request/response buffers to be packed
Date: Wed, 27 Aug 2025 13:12:40 -0700
Message-Id: <20250827201241.3111857-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827201241.3111857-1-anjelique.melendez@oss.qualcomm.com>
References: <20250827201241.3111857-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8mA0opypVy7J
 NMRVCxVV9/e1KyzbOU+rxUWDFD1+PNjHHYBjkzNDGTR6JGoosEaOf+c1kyxBdcemFzx1Ml/3eld
 LNjMTrS9edsQg/V3oG2lE7vyKEljEdrvmaoK/UQnZkVN7jyxmw3tgREu4XEDmQy66/jB88qT4FS
 Fxsqjnu/iRC21CbpDo5gv7b071gfadbwxTLrSNv0hG5S3U0vX+Mcj/rBs+7GvZpSBtIbeU1Xp2q
 MveFL96l7BiDc4o0wY+Nw7U+Y+sSUkbWzZUHN0bFx2sHiqrQ4Ev4lK4dVBII2PKwK6B86TQXKev
 RrazL0OKa3ZVX67hzZFwg3xrprscO1W/cla8Asvizycy6wjmcPhUXU48xitb9MigL2VvyE0vGOe
 Fe8gPT8j
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68af66be cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=OI1EoHIFZYFGuZb9aTAA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Z0rXYvmBfD3W3jaLUCukXQ0494h1Y_0v
X-Proofpoint-ORIG-GUID: Z0rXYvmBfD3W3jaLUCukXQ0494h1Y_0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Update the ucsi request/response buffers to be packed to ensure there
are no "holes" in memory while we read/write these structs.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 8af79101a2fc..1f9f0d942c1a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -30,24 +30,24 @@ struct ucsi_read_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 };
 
-struct ucsi_read_buf_resp_msg {
+struct __packed ucsi_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
 	u8                      buf[UCSI_BUF_SIZE];
 	u32                     ret_code;
 };
 
-struct ucsi_write_buf_req_msg {
+struct __packed ucsi_write_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 	u8                      buf[UCSI_BUF_SIZE];
 	u32                     reserved;
 };
 
-struct ucsi_write_buf_resp_msg {
+struct __packed ucsi_write_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
 	u32                     ret_code;
 };
 
-struct ucsi_notify_ind_msg {
+struct __packed ucsi_notify_ind_msg {
 	struct pmic_glink_hdr   hdr;
 	u32                     notification;
 	u32                     receiver;
-- 
2.34.1


