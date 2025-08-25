Return-Path: <linux-kernel+bounces-784471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091BB33C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED98B3B6938
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BA2DCF4C;
	Mon, 25 Aug 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgBreqjn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C632DA74A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116783; cv=none; b=mq7zbhlzHfPZPvHlQxVHwdhPlmOzP9MiTZ/yVq7xcFAPPsf54KtOArnTrk992nDmQxBN0dG/RW9mvpBPThP5Vg6bN2NcmIPTTLTNDvMInVRilp6elBaFbOTjVInZQlIU3p6Wo26auapK1J3+zKSYFKOmMr+uUMcpLzAMr4YgInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116783; c=relaxed/simple;
	bh=4jbF4aF8Fyi80mVx2EMaOXjSBRT1sA2h5/KbZLp74h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGmwDd9WK15aPJrE6QEzbP0n0IPUyV/+1qW+kt6KxqJRbwouwS1YY4GZIjeTMWObbyHbZudvB1w2FN5yb2VcUOTrzOISQc3ZemYA3PcqOlT4KslASeuT6e+gv4eLLdQeKqS9xd1FnEm67PAj2JzijkVR0vZYvrf7r1r0LWRLzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgBreqjn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8S6mh027709
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kSGpgoMKAE4
	/OLKOS3q3sOnQ0DxnfDEvngbBHIulXJU=; b=CgBreqjnqvyLnPdjIEgF35V2jTD
	nmTpB8vwPs1vJW16L7LKsp2h7ZFliiESzj/+uPQx3VqH/5w95M1v47ItE8WK619o
	7vJR6p52uIFSKFDL4XiCnr+8U98H06Gr8DeNtyjDclGx1XLkMyts4t9sR8sFoN/t
	jaGaLW3wmjb968IvgvNSJRzVx08havTquhSYg83GWnc0XVkSSup82Kv0u0JYYCpG
	sBhST9hnFiQkFDCFb7EomHzD+2A2FuqaH3rOsK0TmmHXcf/Yg3Z2fU9QQpp0cqy+
	ilcgoDr+qkqUq9Z1NvrItPvdT1jY4w7DgNSd9vwtGQFwxVjRGe/N9XWnf/w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdvmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d9a65c18fso86975086d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116780; x=1756721580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSGpgoMKAE4/OLKOS3q3sOnQ0DxnfDEvngbBHIulXJU=;
        b=MS7wjpEsF7LynlnnrM5flDT1hkBobWH2HNiCom0rXbxPxXny043MZ7JHcGJjuGAmGU
         TWXtAcAp2HpCurx9dTWHGFc9HKpvw0UBT20FxHqTMfrxaWsO2I/ytpP7vO7+iCROKAwc
         kZvVI7tWOINjQ4/NyepWgPJp7mstL9/PAS/mJ4/dw/5Yw1tbbTz4CkCNULfUXFwrQLAO
         OEY4fHYrb3k2Mlc3qLEg4QXWvQnKiSYgeQEeXtYsohn8xiwS/JRXXReiLPDiDnse7N6v
         vbwZiyQg8H6Kq325Vf4fYruEqipgURL2zNntyQf2YcGFFJv5bd9+Qu1T81LrshGJimKd
         0Q0w==
X-Forwarded-Encrypted: i=1; AJvYcCXnOC2O1Vr2ydOh1PZtWTRK91KipkZ5pjlO8vz4JD1Jute6zKBddsYa1SgHxbRe/Yu3C/hrO6nYFnFFcLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFLNzLcpIDQTu/vit6rqd79sf1dtXSGA9iaJWe9NqnXbgQEdC
	y+9UHPwCc0lJHqKLOv8dK0PCDX3zrhbgBT0tBLpTnEAFA9FqD4366KTHr8MQTBnpSjXgPQy2md2
	83QTJ0FiPHyMTUuqcXlJPLVCVqQ/HURx30NNq4By5o5s4uaxe20Yle3hkNr+sHi3Q3tk=
X-Gm-Gg: ASbGncufILenJSzFkmtfPYBR4J3yIHQpXP6F8TOLR/qARrWxXLwCXx9ci8Zc3ex4fmZ
	WhJd+gc73gPWmzrpL06dsNJeevpEDBoBZeKdeTlgZdIZvXivi2m8sH16y263t+vbS9z2l1ZOn4D
	8uyLBhXb/w6Uo0mwx4T9SyGiycn18NJ3pC/RP3DDo+RwpfmRnZ27E8odhlIENGjge+WLpz/ygLs
	0nZ6bOjj4aGyha3Ymx2pU++K8IaEZA8UB8z0nRyt/GfKqJBwq9+dFfMoimaWVY6rwwchgWZ251e
	NP9+c+djRlQz+QeJtNO0xypynYZ4AM3f+Nkyp7JDu2SmcX50xQsSmQ==
X-Received: by 2002:a05:6214:1d28:b0:70d:b2cb:d015 with SMTP id 6a1803df08f44-70db2db15a5mr57117866d6.67.1756116779693;
        Mon, 25 Aug 2025 03:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOnY9gws40NRoxP1ky0M65480RnEkGn7SLBORQFmruM7OnjhFUae7l7V+Z3KiJbquOo1nbOQ==
X-Received: by 2002:a05:6214:1d28:b0:70d:b2cb:d015 with SMTP id 6a1803df08f44-70db2db15a5mr57117556d6.67.1756116779189;
        Mon, 25 Aug 2025 03:12:59 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6359b8d6sm5798645e9.4.2025.08.25.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] ASoC: qcom: topology: convert to cpu endainess type before accessing
Date: Mon, 25 Aug 2025 11:12:46 +0100
Message-ID: <20250825101247.152619-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v5ppjGvTkbwniHXxDQOgH1ekECKhFTcH
X-Proofpoint-ORIG-GUID: v5ppjGvTkbwniHXxDQOgH1ekECKhFTcH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3WmbV+xj0V7r
 wMR6UliecHaOEhnNq/2Fnya++6Z6yEDUbg1TePI8dBGKHUx74eLn9Iyxi+fWKIT03LdXfMU9D+d
 e+B9eGdgvW4O9978YgNnwO1TOhNeETRbKjmOspmQZSmccWrQcbIWSgm5j5axVMHDkH7BpxjXrol
 wyGOGQGISHGy8X4StJ0oJDb6nTgZllhKZXDcXNORgpiCS4zuEyXvWHjHgLxyZ8lct63I5/xk3Pu
 fydH0v/IGVkrSoz3A60MB06SUR5obXrTFh/boF3CenglzKrkNtUgs0eN0AFITe2RdrhgW2y1SIe
 JKkYPz2MJr6TJYcvw8uQ8dSE+AhkRhU137LaIkA/vBXsozRx6UcVpETR8e30zyw23rXHgyD9LN3
 OCfm5aGy
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ac372c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=OR_sDe2PA-1rWwznPDAA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

Looks like some of the members of module config are accessed directly
without converting their endainess to cpu type.

Fix this by using le32_to_cpu() where required.

Fixes: c7ed4c2debfd ("ASoC: qcom: audioreach: add support for static calibration")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508230741.heXmHeDC-lkp@intel.com
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index c2226ed5164f..f61285e7dcf2 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -314,7 +314,7 @@ static struct audioreach_module_priv_data *audioreach_get_module_priv_data(
 		struct snd_soc_tplg_vendor_array *mod_array;
 
 		mod_array = (struct snd_soc_tplg_vendor_array *)((u8 *)private->array + sz);
-		if (mod_array->type == SND_SOC_AR_TPLG_MODULE_CFG_TYPE) {
+		if (le32_to_cpu(mod_array->type) == SND_SOC_AR_TPLG_MODULE_CFG_TYPE) {
 			struct audioreach_module_priv_data *pdata;
 
 			pdata = kzalloc(struct_size(pdata, data, le32_to_cpu(mod_array->size)),
-- 
2.50.0


