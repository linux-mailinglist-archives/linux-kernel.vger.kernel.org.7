Return-Path: <linux-kernel+bounces-786096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD597B354F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C9F3B079A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC727FD74;
	Tue, 26 Aug 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJp1yoeX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75592280A3B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191728; cv=none; b=f/zdFRV9AWho616aHzABsh+jtl/G+ieGBg3wlPAbys+58D9xoBapRKviJp6UNebogilR3BYXqROe96OXVpN3nFAFa/azUiy/P2ABO4P32kGcXkhKEAmvZlrWcEKFfQb+bca6H61HLnCQIkwSM+gcZXplkrGrHn0zTcZUDhpy4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191728; c=relaxed/simple;
	bh=0/5OZHffw4MZuc5X1lI0MOyqXCGdpMXrLJ+db0eHooA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRHXitTQXkxW/iQPsMld72/axJBg7b1o+ogKURy8jWaohiPvM0gC1P8oaEr4014QB5lhiZLeuFmNHyNr6O8MMXw9/IuyU9gjHkazPTo1woq0Qpsf5AU19TFi/ovdDQB8PoJSGrPpUmqk3IgxC9Qtld4ZJv/teVn01EJJf/37O2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJp1yoeX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PKb6Me024698
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vG+JLCn6L4I
	c7MLBU6Y9jQ5LFWamplScsqK99+l+ZYQ=; b=CJp1yoeXIk3Hu7FSl8v7E4T1S3m
	eu+FK5k+wa/7oMn4u1oolfigvAHAeoVivW8wlOtG/HEhJDDWPorfDLZ3iNFmM6tI
	H2p1TZPOkciZiYyWDSXCZ4qrJsj2+CzzgvcBpS1RiPQcfXCjK+nNeFGg/i9ZbvGp
	yvuwpJ0Q9PPidUj+npiH/emQuN1vxp6iQbDOrDFLxpFDQr1DGyOsgxSwCA4Y5/uv
	tyFkQdDghu4dwN2oBGhFaFjHUT7TOrLwZJblOF/2ySGHun1JCSDCpJ2Ltxj3zeVv
	jVJzFTF6IIVOSfk18aadt0s5oFix763RRe/1JSxnrWOkwhCY8uOGofnRG6w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xffr3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4765bf9ed2so4143411a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191724; x=1756796524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG+JLCn6L4Ic7MLBU6Y9jQ5LFWamplScsqK99+l+ZYQ=;
        b=OObUINFZq0f+VjgEBWJTkJH1XsD7nnjM9m0f/jimnhCFwGgb64cuwcwAzD1id0lc15
         QdKF3AqS0AKQmt+oDrCLQbmSrDBdbTbiGmpFrwHzo6ReYp6AIq3iPCM+By+b0gI+m8AL
         H8qKH50MQctclZxa7lzYRHm2saX1u9zn3GiUOo/kSkl9z8T+gQB4/vMJiesHgTuOQP+d
         T1oF/Tpr+1APNKqonVnYQ5eyiHT/WSrTQzeYT1sXtzFUQbgiakbPXmnf4n561Gdxk4sJ
         rTFb1y7Q5gSGhBiKzB1r2hncU6EzwUVmnJ2gd34G0Oat5SWYF+QuTKAKPsEqQ5p6Hk+0
         rM9g==
X-Forwarded-Encrypted: i=1; AJvYcCXNZ8K0oEQZvjKN3xRx0lGzxgZa2vE6rYN41GaSoJX+zFUELKu5NozG3fKALLDUfME/zzzeN79r4AxIb6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbzhQ7EbjiALzn2k8akY5vFe0Q9bcsabhSWB6dUl54wUKtvLb
	228dtk4gNvI39FMEmFnyoudaVmgzh9phSSVSY3YlNzDu+OShfY4Qd6blLKwA8jCFLWPQwve+jzZ
	4/PqYknpTj8+ovUkUhhjEjr4MzWMt626WRCBScWWgqnvjzL1E4+x35vB/FkxHxWVPmOI=
X-Gm-Gg: ASbGnctd1WR0ORvBrSeopNP2TlinTdnapneVcn76TdiumV4QtBchecC+GZ2YsMr5pGX
	/ijfxeSN1xxUNMriTKWRgmTm34Uh+HVih1q4z9ITz44+Vqjq6X2QbgK88BieWLKh4b1yx7uwYaZ
	Hb9FTfJEAyyaVDHm3uUbaaLuElSXXrgrHvIbJy++HupxleDwO3EqstDBmxXNPJLweLwU7wediPx
	rzdnq9fhriOITPIAtE+RXB9iwGwzexGG6SlQvCkDsfF9o4Ap+PyqN35ve1K1A6VnzQyL1KtElQg
	ALoSgduAW/w1KdglHJhy52rj8S6v4MR+jq/AzfbSiDdFpzr5VaeB4R6z5h9YJ15JLq8xBZclR4X
	R6hUj3gSexfUkr6qyNaQx
X-Received: by 2002:a05:6a20:6729:b0:243:757a:8859 with SMTP id adf61e73a8af0-243757a8d66mr6775840637.24.1756191724007;
        Tue, 26 Aug 2025 00:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsB6DgGNhNRZIVnU1LaZzXfbxjCKpRrkugicqU0gWrNG6/1baUumt0mfh3z5afOb2+MFXU6A==
X-Received: by 2002:a05:6a20:6729:b0:243:757a:8859 with SMTP id adf61e73a8af0-243757a8d66mr6775769637.24.1756191723268;
        Tue, 26 Aug 2025 00:02:03 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770b5bed428sm5628582b3a.16.2025.08.26.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:02:02 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 2/3] coresight: tpda: add function to configure TPDA_SYNCR register
Date: Tue, 26 Aug 2025 15:01:49 +0800
Message-Id: <20250826070150.5603-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6U3aEd3Lq0MX
 lTf7u13bx/HrS0g2hc4ijOoWvYUChkSird2Up+Bu+K0RhyyXHykgh7MNngHpyluD993EimykFri
 5bJTpCwZIdLoOYFbUzq7zlKcugamwfn/DH3vq7FszFl6OzJEzgiAEiUBZSwBA7xG9xcH+s+0Mb4
 8MfgfBonDKk2Hjgzr67nFFgJFw41AmTOA8paTgjap9UufIxaVBqTAhuhqVybKzSkl3obqK8ONSp
 2IKoZ0/JDLq7oRXLknMTs03Jo5gfipoPy6oClAiswgOlIEsy+7xt6dIudYcp3/xFxE2mQGAfr+a
 ApDBGcgxEWA9xCUtD6c2yMVlk7VCKHGZbOn2U0h746gK1fGEpEvjSC00SZpjnC6s1i36bs73EL1
 fM3AQPyD
X-Proofpoint-GUID: zp93blGefTjX3fdQHiu8PHjalniUIQA2
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ad5bed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8xtsYS7Ed2DtWhKBhe4A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: zp93blGefTjX3fdQHiu8PHjalniUIQA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

The TPDA_SYNCR register defines the frequency at which TPDA generates
ASYNC packets, enabling userspace tools to accurately parse each valid
packet.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 15 +++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index cc254d53b8ec..9e623732d1e7 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -189,6 +189,18 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
 }
 
+static void tpda_enable_post_port(struct tpda_drvdata *drvdata)
+{
+	uint32_t val;
+
+	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
+	/* Clear the mode */
+	val = val & ~TPDA_MODE_CTRL;
+	/* Program the counter value */
+	val = val | 0xFFF;
+	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
+}
+
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 {
 	u32 val;
@@ -227,6 +239,9 @@ static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
 		tpda_enable_pre_port(drvdata);
 
 	ret = tpda_enable_port(drvdata, port);
+	if (!drvdata->csdev->refcnt)
+		tpda_enable_post_port(drvdata);
+
 	CS_LOCK(drvdata->base);
 
 	return ret;
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index b651372d4c88..00d146960d81 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -9,6 +9,7 @@
 #define TPDA_CR			(0x000)
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
+#define TPDA_SYNCR		(0x08C)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
-- 
2.34.1


