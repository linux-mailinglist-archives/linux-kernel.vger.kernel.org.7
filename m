Return-Path: <linux-kernel+bounces-806928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6BB49D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786CE1BC4C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021302FAC08;
	Mon,  8 Sep 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQ7/ioF4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C32ECD30
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374625; cv=none; b=NxbN00STsS8MWTVB4zwcFR9S9rrWFIZTlyfylbQpWgkESsQPB/rTc7E3ct4APGwCmCzo0IOC0rSyrUKWsdIRpBtZdurYRFYF6FRpAszpIKEQCUdQjChl0t02D5by0IQFYnXULSxICErh9v7Qg1tDK29bfU6VPxx7NGRK1dZXNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374625; c=relaxed/simple;
	bh=aV6x9i444yKwrh89jsUIy6W2/ZSo2GP1JzPJOvHXhPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gq9Qv4tLalWA4F142vRnmYU/qNAn8cM6k44FQqpIlb6q5Qfy1PzYNdYo4IIi9glBNfXZheLZ3aLkTLylS6pu70s3FUrdLoPTKonz47lhxGfDHs2EMTW6xcFV8tMiT3xsKvwx9xDCXklQqz0WxqM5DguqB8eYEr9nosDPsG7dtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQ7/ioF4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GIkri016206
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 23:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JYDBlg0WkTcfh1+naLAv9d
	eJDd4moNkfZHLu8U7qAJA=; b=VQ7/ioF4wQXXNInep9mjhXOwWScPQfe4Q8Nv7t
	L9LyEV/u9q16UXS1vN/+7iY5GEDXY37lr3a5rAgqh01XN7NFXdu+kVLNtnk7+xM4
	wStVdE71u1Oo5wlfA37B/FhgYd1wSxTSF9ebx2McjpD3UzIi65y6wHeRcgGvZefx
	KDwZ6hD+hdwJz1BDQl05Z1tUFIYKTSHFEn/rJXtHiT63FW4tWg7z3tcGcPPMD3bb
	Faa/hWzWayTV2Ek4irIuhHYkGXkx3ycgon5RSsI3de4yPl06zV2ZXJf49yZdQ/FT
	LuoP8KAKs7p3ssk0NJ5ePuOstXSnQUBpdjD8S8SLnDeOWvOA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfx468-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:37:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de0bdb600so95994376d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757374621; x=1757979421;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYDBlg0WkTcfh1+naLAv9deJDd4moNkfZHLu8U7qAJA=;
        b=qIS6ZaJJpUXmMuQEr4LQ2ioTpqBTV/nSuEYblLoIdlaaoa3MhYz9vLH1RYtISF5kL6
         5x6jYiKMAoh6EMNN3+a336TiYUy9Qk6Q8Mm1jyU5u6vvBse/4Gr61Mbk20YZyPu/AjI9
         El40E9NJLecCzcY4ekMC+yFAXhUmcVz3AhqVAEJwfMDKjABvtWPIkoq6W4vrsfX7znLj
         dwZPHvr1MVXsY0I158AkBajmyLonnZyHaQnkilvRmxYuz/QD+KWNK8dZtjC8KR8O3pUI
         KZ/M1sDn3VTFU9SiYkeze2Q09ePxQXXKeRJbPK+P3ZLf+O19igCemW6zYpMJPSDzge7J
         Czaw==
X-Forwarded-Encrypted: i=1; AJvYcCW20VioUbW33xkCnNJdAFfRVppoI68bOkmMxtzG6D/Gvhlb2Akeg9Zdp7/PyJXycyJdDcuj7oRq7Yfuq9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQw+r0aDSnqxLYJSUpgvHVpeuXQSzws68delcNOCgzzHsZ8Q/j
	1vZxTRjLdeJWmlVxma5b7/xnBk3XVWA5WzUfuPzY2N2Zd54Nf1IiZfTmZK7BK/Q0GWfAa8lT5z8
	Hw31pDIs/tSiuCLeedODF/tfjk8ZgbYg4e3a0vUg/OaSquUYd90dHmV6z66mi6S9yF2AWgkNmE1
	k=
X-Gm-Gg: ASbGncusiTCRTwc6k2Xy7Mvbm5ei3R52jnmwuacgcbTAzmH/8p/yonhfU+qPC1lq98V
	8v4XdiKKa6j63if0yBpeePd9bCAiLG6tEuzHAtIfRV6peXCIGgs2u+Qj9fp17Cf3RiGU1L90FJf
	gdSKzKul7kIX5Of78iDGZTmBZty3TuX1G4SzhMZXZubMKS63y7YbSTCum/bqDGE/Psnv0GR3mWi
	JCkjXnn5tI8Km/WTo2BSi0S0ZGAhc0MzBXNjQF4mgzVwyF60EzkJvG3SPTWYGF4A61vAWvNeYes
	UwAwTqDyxNPhApHWClDer4DOfrtSK5AeDWPRSRUzA9ZfAlCNaktcxMtbrvFzw8Hi9feMLWoOmO9
	k6cIQlfRmr8/HcqaExs6EFeZIfCvjhYfYJpeMj3KO/wZIm3aIGrrh
X-Received: by 2002:a05:6214:4005:b0:734:fe8f:27b9 with SMTP id 6a1803df08f44-73922f68800mr104019616d6.13.1757374621169;
        Mon, 08 Sep 2025 16:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaeHoIims3X0e3h2M5HKMNYxOLzNvc34VKws3LcgytKD2PYzVCXkYiTsiD7uMOpOqoAVk0A==
X-Received: by 2002:a05:6214:4005:b0:734:fe8f:27b9 with SMTP id 6a1803df08f44-73922f68800mr104019406d6.13.1757374620733;
        Mon, 08 Sep 2025 16:37:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795eb4asm92926e87.85.2025.09.08.16.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 16:36:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 02:36:51 +0300
Subject: [PATCH] usb: typec: tcpci: report connection status for non-DRP
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tcpci-non-drp-connection-v1-1-e09c7d877d44@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJJov2gC/x3MMQqAMAxA0atIZgO1KKhXEYc2jZolLa2IIN7d4
 viH9x8onIULzM0DmS8pErVG1zZAh9OdUUJtsMYOZjIjnpRIUKNiyAkpqjKdFaF3FCY3BNt7gsp
 T5k3uf72s7/sBP/LfCWoAAAA=
X-Change-ID: 20250908-tcpci-non-drp-connection-bacd9a5d24bc
To: Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=aV6x9i444yKwrh89jsUIy6W2/ZSo2GP1JzPJOvHXhPk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBov2iZq7yOcwNWcciPqD88jCchhhtgzMx2mVaMy
 hT6lZuRLWKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaL9omQAKCRCLPIo+Aiko
 1dYxCACqgXNZg3RY4iVsOC3M5uG93cPZroFWXdl8T2yTOqzz2JlZL1XVV/5sjXiPe7doee009it
 r9sPSiJ35iySr1kEGuOVtj2ewuvuoufzbUfky7lfE58qjg7zxefzC6PuV24c8/DeX9u9sUmkfRW
 6Jx1bLvTUmszWmRQzuppRhJfty/EI1uFU48e0DQpDWA01nrD2IaW+qgvfeGFKy4t/0zklE5KrGj
 piMlcyBwpQqlHcQOeYgIQwVGV4KCpL33sCOLg1Gs6mjSK+FEqKt/dP9mZ4eFOrY2L3Gn+W2E1aU
 LwU1MBoxKGHIEgAj32cSyDxtBS3y/4ebSDByIl8PUGOuEqGO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: hnHyYZJorYPqr8Gnz4wU2t3tT9rN4-Pu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXyISm0HIL6+Uw
 EnPu8lIMVusRIEBueh28VKWHSKegGwfwNEIdU7dFrq/n1vyXY/RpvrqtNAqMWJjUpFcbqn7ggyt
 x3issTJ0rbKykfOZqkCEMAp8MjZsy/WBYepWJ43C4nA+Q5pMZP1Ky0gVhb3lqP7i0pxWyzIKyBK
 4O+EcOPI3NK4fuumbwzuUFF8SnG1rZekEc9Aw0OtDSs4LEG1BDLk1oQjJZL2Uu7UOmRNVhBdncr
 G0zhCOXD21NufMe0GKoRG7f4qeHn9wOuXH9Bll8ifmHvVa/zCs3oSfwNhi2NsEF8K9kSstJqHzK
 g7jtDw4rRDKwOphRKNnpUzjRofEXmrgSIBNFMsUGEaMRk6ScuhzdeC0UmGTwmPwFeFUDNkaE8l8
 tBKIu96E
X-Proofpoint-GUID: hnHyYZJorYPqr8Gnz4wU2t3tT9rN4-Pu
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bf689e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SqqGe75Sp6Rn3n6DgO8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

TCPM core calls start_toggling() unconditionally, but TCPCI simply
returns -EOPNOTSUPP in such a case, ignoring the current 'connected'
status. Make TCPCI driver check CC lines status and report current
connected status.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index a56e31b20c214fc509423d2f8602d3599c1dd2c1..9d57c73b49674858d799790c5c8cb0d929841def 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -178,6 +178,8 @@ static int tcpci_apply_rc(struct tcpc_dev *tcpc, enum typec_cc_status cc,
 				  TCPC_ROLE_CTRL_CC_OPEN);
 }
 
+static int tcpci_get_cc(struct tcpc_dev *tcpc,
+			enum typec_cc_status *cc1, enum typec_cc_status *cc2);
 static int tcpci_start_toggling(struct tcpc_dev *tcpc,
 				enum typec_port_type port_type,
 				enum typec_cc_status cc)
@@ -186,8 +188,17 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	unsigned int reg = TCPC_ROLE_CTRL_DRP;
 
-	if (port_type != TYPEC_PORT_DRP)
+	if (port_type != TYPEC_PORT_DRP) {
+		enum typec_cc_status cc1, cc2;
+
+		ret = tcpci_get_cc(tcpc, &cc1, &cc2);
+		if (ret)
+			return ret;
+
+		tcpm_cc_change(tcpci->port);
+
 		return -EOPNOTSUPP;
+	}
 
 	/* Handle vendor drp toggling */
 	if (tcpci->data->start_drp_toggling) {

---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250908-tcpci-non-drp-connection-bacd9a5d24bc

Best regards,
-- 
With best wishes
Dmitry


