Return-Path: <linux-kernel+bounces-854319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3EBDE18A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79EA835182B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C931A550;
	Wed, 15 Oct 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUNq05bU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70931D726
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525596; cv=none; b=Ts/C1cAdciTvVPMvM0cgDkXUwvFpjruVF68XHnLy0i+9CUBJa1yYWmC244el1ASyaCB5Ikmn8NM9857KgFNRMZ3t6UkjzqO/R104Zb4q2Xb/En5gV/bToX44KlLxYtUlIDOOyMu1N2EJvUQQKTD//iPTDPMZQ6AV0NoDORxiyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525596; c=relaxed/simple;
	bh=MHS8u7sUasvBS9lgafXSXHBip0anTOKGxbuZXAf0odQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaZhwee5gvN+r2sAwN0HdB5JwOKwfrOhIQ65T7HKqdyLuDAIfmt4eyU7B0qoY/Rg+pynjFS8+Hi8QY2ylO7XAHWNVNDzMq6iJrQpDZJnEnhTFEHx5tV2+qOhtA8zBeRf2x3ryY7dFErOW1d0jnWcRNoMyfwH/FalbYHChPJFOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YUNq05bU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAYK3O004155
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fQbIeL1NYHf
	9UHb1CwOW+nqwk/PLKyl/Gj01c0nPyCU=; b=YUNq05bUH1CMKlqX7gkwQBuNdhq
	Nxxa8BG+nD44hi1RSxZYTRrVQ+8EHpsevhRqQiSUgJOrkZ5HUWQe53ufxVo274p/
	PD6rlFaJErzlkyhydK9ozZUiAx9lwtCpTSDVqirQGi/ZQ+MIY2s3GQgB5MzAgQ1g
	7KmQ543NQsTsBM0orQM9zx5/3PhpNKSdagHsENMoj0VsvsPTnlJz1K9YGECxWsxj
	MoHpKOZbgSbJc0JKZacBQRLnhdpe2gZdD7ACtnnZNSl4G/3KGUOC8djyYjLGOgeO
	H7f2Ivo99aG/zNCE1rKUd9noBgMzZojQAiIb7rgzInhT4KxF9YU+zJP7gtw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwpdqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so16792297a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525594; x=1761130394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQbIeL1NYHf9UHb1CwOW+nqwk/PLKyl/Gj01c0nPyCU=;
        b=nAZBwNEeQrvofBfOiAuRANP8LkyHqI+3M3oGlkmXb+bJrM34QgK+KpqC4ekSyfHFLb
         wXQLFpIdi8bSdsgssvzMlmxkRXR/N9lQ58nsSzurX+uvLciloymWDvLwv768UBKJs773
         IMQ3KEUw4JxV9bHP6dHgYjlnra4+V/m9TslWdbQ2tT0+zRhQ5Zu2DRz89yj2OBFfiMoj
         QCE9irmfNTImj25t3TrJsHHjjdLMDePp5B/N1XJP0Hrx/Aup+BCNirdWSoWTy68rLbwx
         wpQ+NkxiWg88TnaT113LVm4Mn+ItquGWogYbx3+bPr8hD9kUR+E2KUNpWPqD/VndpWqq
         V6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6fneszS6xSFP7zM3TwxjTRV2Xkcc2ashTURR7fCwvzNPkZ9eqNvED+mOEdwtWIq/Z83lmlAXJqrNMSlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mIzLAB/T6J0kVB0JiMAtWDIp2Vnbrvx06DVpCFa+kLf0fgi8
	Qs5SMwYcjIs2BeiVAVbv1KlfafDIJblonTd+6+B03pLRJSZgRpoVO3LL8lyi8TpjLy1lbFo9VhS
	LMLa+/EoRGlHr6jpFu8OmvNdcj1gVEYoP8cTGEt0HFDLbYvTvREN1fCc3syj7Hqc53XE=
X-Gm-Gg: ASbGncufsLSQc9By0RKkAaoldzH8IwYTNCqQLfqbN5+KdH7l6wkRrz1BZUVyhKlwu2R
	OyROQfX4/CrM0rWiyC7UqODoYieY9Dq93OOSCwbL30zf3vZfarvyu/UsjNQL17R5VmA95SF8vGB
	EDjyMuOK/TfS0RZxV+59hYIfj7podF2newUKz8IsMLuYW1nTbrbNsCxzaoF8KBfmpuP6BI3A3zF
	oKmk5msYk4a8ltB+9Q6RHC1TdWxXx03IRjJ+F22H3RUpwSj835FsFx57leDqrxXq3t8G4G2Smi4
	Lrh2fJ6iS58Ny8mnBnzO6wbtCIigQieQi0OJFGY+ZkcYxmodg99RLgsouGLyC4hPZeaNSzCgQ7h
	ilA==
X-Received: by 2002:a17:902:c94c:b0:27e:f201:ec94 with SMTP id d9443c01a7336-29027373e8cmr402296925ad.18.1760525593714;
        Wed, 15 Oct 2025 03:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7UhX8xptIfvTz4g9frXK+vdn9Ssva+7MAMiKmWuSPnlkk6SggKkRgGndjbOlqjtzyury1Lg==
X-Received: by 2002:a17:902:c94c:b0:27e:f201:ec94 with SMTP id d9443c01a7336-29027373e8cmr402296575ad.18.1760525593231;
        Wed, 15 Oct 2025 03:53:13 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm193698385ad.49.2025.10.15.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:53:12 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Eric Biggers <ebiggers@kernel.org>, nfraprado@collabora.com,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v7 4/4] arm64: defconfig: Add M31 eUSB2 PHY config
Date: Wed, 15 Oct 2025 16:22:31 +0530
Message-Id: <20251015105231.2819727-5-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
References: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX8AOrzkvpdkh9
 lPemG961jkveEMC3YzMXTIm9T2rrLGI2BjSIBC8X8WdaXc/nXHDjqKxN32iUACxTN7XTFKHjZY8
 Nk6NQgGFe4LfzRcTVONUTxy4RoL6RBhaneuwts9aqqE+7ZwfAUD4/31rbTwYGsX1Xir5mNhMq/m
 91uOdzkyHEujnNv2B5uzGRwJNt5f8+4YDQyDIqiIkDfRasF0ZBF0cWhUhyGg24codmfAgDo+VH0
 /4ihALXUgt8xniPGbw7oB1gPqPeEgh3qDhgGlg5i3HwNqmRRFxaxI/RbPrMfUg7v3CKrevVr3Pp
 jAXJiqgBqv/f78X7QOC85efPQvBY5+w2RpQPasXEKLeHWhr1/o3UQ/v+CD4tNUft2HH+b2Wjg8e
 GGD/3bxo4lqdpp1pOFldCWc0Kyc2Tw==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef7d1a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ZS-ls5sy8mnZQVmeZLoA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: esisraDgphh6sa52mHCnjMlg2YppBPZh
X-Proofpoint-ORIG-GUID: esisraDgphh6sa52mHCnjMlg2YppBPZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

From: Melody Olvera <melody.olvera@oss.qualcomm.com>

The Qualcomm SM8750 SoCs use an eUSB2 PHY driver different from the
already existing M31 USB driver because it requires a connection
to an eUSB2 repeater. Thus, for USB to probe and work properly on
the Qualcomm SM8750 SoCs, enable the additional driver.

Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..24b1c943a7e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1641,6 +1641,7 @@ CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_EUSB2_REPEATER=m
 CONFIG_PHY_QCOM_M31_USB=m
+CONFIG_PHY_QCOM_M31_EUSB=m
 CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
-- 
2.34.1


