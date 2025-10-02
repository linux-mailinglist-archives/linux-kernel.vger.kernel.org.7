Return-Path: <linux-kernel+bounces-840024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F36BB35BA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702011889597
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED92FDC4E;
	Thu,  2 Oct 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDIQ9QHY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2602FDC2F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395189; cv=none; b=rwfBWcDHWzOQpwrAKsTSEbCPLep3Pni4KVj+ei+ck2iruIvUKUk1airI9xhrXmyd0y/CBMdwcbBW1bYcougKd6LcCVYBSC4UeTlmHWUFH5mAIj6ycEGrMwCADxG9MCg5iNhaQSaLqJwJI4/3XVHzbQMu45/SkYJO45FA9bW6WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395189; c=relaxed/simple;
	bh=yEWKVEONPMuo/1ZLJQobHQKN74Mos671QJLh8xq2IEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rf6jHdwekMs1LSrlqS2eofFJJGLr0/SBwQWwqlXYUb1b61Rq7uWkr26Ah+u/fQ9sQ1nXbA7jmrl3l5bHcpyfeLXEj4SAzCW5iQkl7TNN8R6TWR+ogdyAHBsfsiXvvtu/Z6ZXPoxIez0a/7MGqwSJVzsELzm+K8RpRlRrsFUgxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDIQ9QHY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcAKl023589
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 08:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDVKEu0l6U8/m1DkbF4V1wuFoj1Y7XDb8Q8vVrzOiNI=; b=bDIQ9QHY77iWHYUn
	ROjZnAipZqv2MDIVn4zBi509kJ8ZzZS69omgEOBUolx29qdmLcTIjhYITOojM3jF
	ZpJFC3shbwzeZE3zd42iyk/DAzOA9/9zR2omgdDB4mkVjS2psV9fBEm7eBvCEfNo
	dbVXuHzOcmMs5VwbnfI6Lcj+n+ZasS93MLYvDDcNodCH7zzA81ZVxBEiWdC6bPxY
	uA4AAU3O8YzbJKp7R3lM1jiemXy7xMwwVS/MGItB4OCXYA3C9KBKXHJCU5PUx4pI
	km7hLSxxDDEOVqQXeG1AMGZ9ifvwvNfZG0whT+6zx+7hnlvdgFeMKeOov872Z4xi
	AB64zA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a679bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:53:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d8b8c3591fso21900791cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395184; x=1759999984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDVKEu0l6U8/m1DkbF4V1wuFoj1Y7XDb8Q8vVrzOiNI=;
        b=iU4VbIozxqxrFI/be803fDrfSp28I1ddxwb014MzI1oTsD3oj31/R2Ew06wu4THPyv
         O+yIS8kHbQvJrdE+tEWLfa+PPrAaiTaCjfHDieUDT4krQGAxRFGYi/rdFv/BGBOlQzCj
         +EkuEE0IGYvMWT52aIXF2TgZIVC74uvtnFMdlwf4n8KkPOiF0mA1/IKorxF1JGbe2y69
         SII8d1NemtZ4Cw4k8GOqw8Gu63dH1zvM5Kp6sqt3yWMRcIIHgbrnXXzZcn0NJoVyKE9y
         mWv1ApUQ+lNIfTpKZBK7mcCjMtTq4CwrZWLiRAmy3fYnApb8ulzLR2vcGTWKJe8W4TYL
         IWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo44ZO5oMKq2YT0Eme0sPqxmln1DKHGn4PYuU3NHMs7sPrSWVd0klmGJfzI4WW6cF/WhObTOqSE3xqd3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJkghj1JvUv1nBsCGvewZQLOVdpVabLv4SS4qakklKn4I4Niv
	S6Q/T0d5R4T1jQB0Hf06Ii6EdJJUsCJ+6cIisk4yTrNkL6DcygX2JTW1RkSmurtzdEyYjUFQFhF
	QCb2dUAmU7GJyzjH7itim6RERg/zP2y6CMcTs4Tsh1zOQbQKENg+eAylJAAs1niVYu5YKAhtwuF
	9ZTA==
X-Gm-Gg: ASbGncvrfwUiYuth8RCeMHu2QSM2rhzEdsgallU0D8axhJGgdCd3eCOiobBpRG2NJE3
	gMXgIG8x9D83KZnIeIJFFkwybf9/eWUZ3bgd/AMWBfsvNqlcUuAzQ7idHIlVasSVrDq1x8VMsHm
	D/mCkDPS4gejf2IbhFz4PqEK0Xm5iLo+grFX3LFA5lPYh3mZv42QopfgOukiiPoYEl2ulaiRISg
	CWiYehzwGtPziGHsaRVu4LzDH0/9WbJHXc0Ahc4JW7ufhzvdOLRf6bRLsNuwjNul9kKyTI9a7sm
	cMoKyFuKBPsKRELBa6625UOXElDmkWS8Y2SLnhKaxMQKnzxNs2Ngjop3T/rnDbeWjiJbbHEYxXg
	v5uY3lL4M8iZWlLcn8AxKGlwQPjYImjsSgxc15cvw9XTbmHCHKmW2mc4N2g==
X-Received: by 2002:a05:622a:4d0e:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e4192f7886mr86280801cf.0.1759395184140;
        Thu, 02 Oct 2025 01:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzoeXCsCYajxT61dCdKaUdyvl96BO5g78vsxvJhmN//YTWTsStifnvfSF0Kf3B7QHZtn7D9Q==
X-Received: by 2002:a05:622a:4d0e:b0:4cb:102c:56b2 with SMTP id d75a77b69052e-4e4192f7886mr86280511cf.0.1759395183470;
        Thu, 02 Oct 2025 01:53:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 11:53:00 +0300
Subject: [PATCH 1/2] interconnect: qcom: msm8996: add missing link to
 SLAVE_USB_HS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yEWKVEONPMuo/1ZLJQobHQKN74Mos671QJLh8xq2IEI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1s5EDM9dHkNBqE1ej+iY8LhlPeUyUebTYbE
 +8rfOXz9FiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1VbaB/9I8MxIptyQz+jehF3TFFzZP1BOna+zENlbWyss4aU13MaIdAtq6etDhYdtsSHMQyDvMhe
 4iS84XB3WDiDXwHACSYW4P6DS05vNv9ovjCk4SAQXclLGZztZtQo+Fn8vxe9uO51ajsCRfwgpER
 SEhIYuUpuYqjFk7ksnlKJ95jhAKYppDUkqnyxgO5v3AqlE14z4pLw1zsZP1ChUmRpkU1Dcc8qRV
 DXbrrYAir2Fx8sqQc42uBLbd0WHmZmgKDg7PBYhoCBMDICxKnF5MLhumqdzIhl0ZeHevh8mnze+
 v4lozF7Avfx1pwtupEfhRaHlPOfhrHRafSUau64XAo6RgmQN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68de3d72 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=PsYRQ7GA2nqPEF2217oA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: W1e_r2X8Sl5vnv54HZ2ReG2o30-Me1OK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX5A6inkFueZhU
 z/Vwd6vmimWqJOwm3/MtAs6uPmmA5hd2+P7l3I4wrHtQYTGLCE8GrrFsYON4LfJ0yIPsWUpKx74
 Oc6wB1/4l8b1PAZH4B+iiYS6tE3pzfZOJijpSKq74uWCXl/u6l3p+dMfikVfekMHRrKP3T/3qOU
 J1C3BYbU2VfPMVt39AFwZ4hpKGh7RqDjfo+WLdMjzwaF4bIkyt9bM4rdH3loPdueiJknrnC4G8v
 LBv/cDFqxzpfLNVAmYUYSNRB1QE1Ja6ZUjOGwLBaPZ0hqBZ0g6O4f0lClfw/VvrT0Xc/8u2hKvF
 JGpi0M8Ty8/LUFZ1T+WxxqC0g2l/8vG5R7Kx/x07sx+Oo3QsKRjAbQdLwn2bQdQTSyOl1Tk4TgI
 vWZgltwHBBEUXykaOPAOMiTTY8rQbg==
X-Proofpoint-ORIG-GUID: W1e_r2X8Sl5vnv54HZ2ReG2o30-Me1OK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

From the initial submission the interconnect driver missed the link from
SNOC_PNOC to the USB 2 configuration space. Add missing link in order to
let the platform configure and utilize this path.

Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index b73566c9b21f9dd275878419e030ab07163ef8dd..84cfafb22aa17dba0d5fc4074613546c3dd95625 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -552,6 +552,7 @@ static struct qcom_icc_node mas_venus_vmem = {
 static const u16 mas_snoc_pnoc_links[] = {
 	MSM8996_SLAVE_BLSP_1,
 	MSM8996_SLAVE_BLSP_2,
+	MSM8996_SLAVE_USB_HS,
 	MSM8996_SLAVE_SDCC_1,
 	MSM8996_SLAVE_SDCC_2,
 	MSM8996_SLAVE_SDCC_4,

-- 
2.47.3


