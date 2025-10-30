Return-Path: <linux-kernel+bounces-877941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C9C1F659
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FE664E698E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982234D92A;
	Thu, 30 Oct 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gp2ViADf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBgTZ73G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC62C32B992
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818119; cv=none; b=Lz5jIGOogNdg6D/fhrcPH4qM9qF4KB2udydepeHCtP4mudsZiW2ksiZn55qLn3Uek70O0Z/YnEF01urIlLWreu3Ro6l1IWi6W83MphRWno1LH5wL94E1IEmrcatZmVYXf3KIemS0QKCcQQJ9iILPhKgsjxOYGkRuzgv4EyeLfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818119; c=relaxed/simple;
	bh=sn+bKtHsVI42aoD+4isPVZxb22meB/qiiVkfiZk1lOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3/SfHGHhgf4UDS1FxMHEkgt7aYxu+nlzPpbk8iDlZPLxBlt4yO9Qkof3yXy9kgQLh0GQ1CksILqiNwX6RUlAhjyEh5cloo/94AGdrMjK+HMOuZS4lme2CmnIEVyGB1QoB1iVhRNxZ06XQXHCrLbEz/4TjfugvGGklcWA1xoXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gp2ViADf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBgTZ73G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7cg6J1696827
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S2B/u7IAc5KODpSwvJBfygwIgyj16yYs/7b
	v6Cj3hSE=; b=gp2ViADfz0BHMah1LDFQv5ESbJC3KtD1c+Y3fkYDbXs+8BHDdAw
	BntLM8fnYyvHO4mF/aaJYpnJIroC/StNoqZsuFSmbjtS9uUkZyAGNQ22/bDjvQW7
	OGEqqkaOnBy/XHpjomc4SIdXSkvp5AYDwitdX7WUSENnzh+qaoCeBMXZo1ub03P9
	9fowrfLs/Lyn925KiOREAic5RRym9KBFh3TRdq9wVnQaFLu7hcHs8QjrZ9GnDVQX
	awKuIfKrry5DKZNVQXGgDhfyFMxPA5tcNM16FdoHGn6h6s+aXqwIoVCTLlac24a9
	dcONlWKmDMNmMoShfVR63JpydqQNlM2r7uw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv1vjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:55:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810289cd5eso2351239b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761818116; x=1762422916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2B/u7IAc5KODpSwvJBfygwIgyj16yYs/7bv6Cj3hSE=;
        b=LBgTZ73GkSbKQgy4SlQWVMejwYCce1S/3MjUMmS/t/35VZi9vn/jhjKm9z16OJNFQq
         UtAtnptv7AZluk6gC7hui3iM0whhxbsiIsDgBZol1qi6DblASYpN9cxtxFhxYkC2VTdl
         zkNjIcHgmKoipAoJOo01bIORsL+aKzBslIYyMkYya/wgUd0fu9SlPLNjPk/J6etEE60A
         BdmxlUZ/o+tqaB8SfU+JwJncFYYbBKbotse+l71HAVXUuRQKOeIP8cDikBqQaj+o3aXt
         +adypoEb8e6LiFED2ehaOvGJGjxxZsJFsG+3xwoPrYWbdloKe5Te+H9O2MBlGZ2Z0kG1
         Q2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818116; x=1762422916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2B/u7IAc5KODpSwvJBfygwIgyj16yYs/7bv6Cj3hSE=;
        b=D7jtUWn5Eu3z9AG2Oi8Ijids8YOMryLIOrN0NwS42p+sg9kpYUU5JccbE0113AlcR1
         j9uKhIfV2YWj4rEy1k/o/JX4b/Wokg0LRUOrNcdn4eEmwQ9Y3eJJiIYa8A9OzqDSqshO
         DEFRcX7eLaOefDcPTr93Jd8WO9R5RcXm4PLQJnbdCQ2coPJotu9z8SkVgCCob87sMi+c
         Wh9WuOmD1zJJQLdohB3s9vBxesaTmjxd8mZr1sqEvsTt9H3/gWhMUvfcycArp/xH07bO
         sTe6lckQMJZBRMgOaPdlWYuwAOE+GPcfKqWISrL3plM2XCySJr+1S250W+xh3c3OPXqb
         94yg==
X-Gm-Message-State: AOJu0Yz47D+HRa28Orulwupe6HQW6Vtsk+mFKlk7U0bWVD3Y0TGeeheH
	4/OVDIIxkxsJz5d2y/TUSKC/ZgEvLG/p80qHKyYXo96L0IY7bsNM95Z1EpWCPooARtATshn/4FV
	L8n/NVifDM/81crHYrys1JmOUqAhAR30nLnGC3jjW8HZQmRnhbC29kQLashA7Zz02kL4=
X-Gm-Gg: ASbGncs88/zIiEl+x4EXBEQLC8XytGTXXS+pQOmTbXi9dK48DNvcwtQqtj+siiep5DU
	wox0Fp7RgANXh7R39BtkhVSNTIe9OzZ7FAesfZfXGWCXCDNqZiF8kYs0ViknqNR/bThuq4+QcpK
	I8D+mrH7MzdvMgBUGqZNx5OAw0ns7R5kWeKtd1iMFlZ1eAG7PITfYSm83RELQnmNjMD9lj996f1
	vdsyTRSe/5HfJmxmYzOS+Q5ct3uhwbmsHkvoNLE0QlPvG3DtYabv2fcVihWzF4OTBKdFYdErbMW
	hTi/f0TmskKpzJ4+FMfZD7hk6Jg9eg2Pt93Bbx94+jt6mqYpqFWCA1k54yoOvFNESaspaJhFHRZ
	U45j5X4qRdMspcaBKE8gjPg==
X-Received: by 2002:a05:6a00:ad3:b0:781:d98e:ebda with SMTP id d2e1a72fcca58-7a4e55f0e5emr7526622b3a.30.1761818116189;
        Thu, 30 Oct 2025 02:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYE7KRGEkSNV/szJQtJrW6GJ04ajU8Iw5/rPjZPSBhZJYdiAQpQvQzRWBTfSYUwtEKM5px4Q==
X-Received: by 2002:a05:6a00:ad3:b0:781:d98e:ebda with SMTP id d2e1a72fcca58-7a4e55f0e5emr7526586b3a.30.1761818115675;
        Thu, 30 Oct 2025 02:55:15 -0700 (PDT)
Received: from work.. ([2409:40f4:310e:1f51:38c1:6dec:226b:be0a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414035ecesm18239258b3a.27.2025.10.30.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:55:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bjorn.andersson@oss.qualcomm.com, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [RESEND PATCH] arm64: defconfig: Enable SCSI UFS Crypto and Block Inline encryption drivers
Date: Thu, 30 Oct 2025 15:25:09 +0530
Message-ID: <20251030095509.5877-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P35Mio--_vZdGt5mOgkDmN0lKKP5Pefy
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69033604 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=rO3wVDe-YCVyVCuK1RsA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: P35Mio--_vZdGt5mOgkDmN0lKKP5Pefy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4MCBTYWx0ZWRfX6VqRVuY9EKuz
 0/9njZFxM+XWsd0Cix9EFZafxBLnjdDRR16KmTfhx6NhioWnrUJ0m9/Jg/ydh0/0uu4BHgtPiBn
 Fmwq6q5hvlFFsI83RnYI2fVDqbaexBK0YHC251X8CgEML1uX3tSJ7UeK1oOEbgCbpkJtvaJGy40
 lV/lTEJlEuANakgUBDV3FVEXG7veGpe16Zh9lmmrh4oU5wSMXo2Zt+FFh/o4Y+eCiobcCohk/Y+
 hnNzRFXOSnYur9LNyIE+ZKDiApHsKfUHc0/6iS34puJ5ZkPU34KvSZDvoIo+f9TlsFjfglO4aUP
 wqA15Ap2nND4JS9Z4+EzP6mu3ycuM9sy3q/5+/TRJo42rRnYCt4IdWT20m9IIh3RNAWlEkbkGTk
 CuEaxvWbgadFSDzKXtSgeNKeaoKvVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300080

These drivers will allow using the crypto functionalities of the UFS
device, like Inline Crypto Encryption. Both of these drivers are of type
'bool', so they cannot be built as modules.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---

Compile tested only

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..9f89b3ce1262 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1230,6 +1230,8 @@ CONFIG_SCSI_UFS_RENESAS=m
 CONFIG_SCSI_UFS_TI_J721E=m
 CONFIG_SCSI_UFS_EXYNOS=y
 CONFIG_SCSI_UFS_ROCKCHIP=y
+CONFIG_BLK_INLINE_ENCRYPTION=y
+CONFIG_SCSI_UFS_CRYPTO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_MULTICOLOR=m
-- 
2.48.1


