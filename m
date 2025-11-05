Return-Path: <linux-kernel+bounces-887016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F250C3707B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2551A27548
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843633C514;
	Wed,  5 Nov 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pYdEt78l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HO07wXH3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5F33A01E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362729; cv=none; b=elaOG/KpU+tlpseO+RMAwlE/k/mpxMK0rT5Z6X7b4fdsTiS060cGW/sPweY2tCCoIC/UbVvWjQ1z0YRUY+FnbgUGQzFSkF3bwrRCqG85ZwY0MBPXcicVX6nk/Q+cVeijEmYKsGWa32GoUvrnCQ9X2TCC7OQxmHYQ2BWkFelYQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362729; c=relaxed/simple;
	bh=QygCnmXl5Esc5BPNyYe6tgH6/RC9PgKmXDBI3B/5l+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPiOitB99rR2SjlggZwf2zDqZN0mLVhwfwEO2Dv/hr7WV7YtyrbGD+tLKujwBuRtQiAjRq4FgouSWhnN00irvlNgxTslDIxpd/mSPfT64ehs5IhN2h98xBJpriWgHWlGdAVyZQkEykpZqvHGW5qAxVN0YG6ReURltN52Y/uaknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pYdEt78l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HO07wXH3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5EnsLA994607
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=; b=pYdEt78lNbsQqDKA
	st9bvE0zVFewi8LElkEqz6rHQUZ+mzdCdeoNgIXXbm32m8xamBRyZNFGSm1qh5CV
	nkG6nm8KWX8L7wl6Zz03yVNPbVsEgtqthvWBCX0MQ9i9gfQCsvfT5r8fskMBA2x1
	fGPhaAdDRf3yyWl2XetqUQAcuylgNISsmzURV6yvaNCIeedNWQKfAUlCvZH4uBey
	6Fj/yko3Pe6qPmdhItt7qZpH1xn+b3heHEzIl1Mb61ZjIpqjg2nKIOQjQ2QWh+id
	GXTrb8e/7EO53EVUWm7rBC3vQEi29ScfPEOlVi3Mtj5a4z/mD6G+wD8MrkzmVS/w
	BzqdnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pj8fwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:12:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2954d676f9dso735195ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762362726; x=1762967526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=;
        b=HO07wXH3LvGZID+f0zHFScDNclrPPqkE26mSPdm+1Ta3CJlurVao3paB0OmkRuPVIy
         2JrI+kHs7F2NZ3hZHDrZOy0BtyfFYorLwS/dV2Zbi0RTJ72LAAG7ET2ZByXkNIJsK87I
         pF0bTwuClSv12z3tpOPBQAdcSk70o4o1cBY34VC+eLeA9YoCcbfHSx2WjUkfsE+4/s2M
         mFRj+kNC1c4D0OhxUt7+H5E6cZBelcv5NHNHNGZ7+8Eo3pOQIb1r/XjxlTB1PwNLWFbV
         YS+u5yG3TEgfHpkekjCRy3pmv184sv6qEpUbF3MkvbinHabeYW+Ra8+76gWAJxRKVgUR
         /7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362726; x=1762967526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=;
        b=AsMYq660wBAEKw++C9a8RZCD1k0bIS2xaocqTAJyh/Y0Sg/qzamghGbj7l7ZZLzB7E
         6DZIlAvV1diJ6QCG5R3q97I/mq3HNRE/lDLZhPnqZsh+rJ/uoNCgjZcg84KsyrT5+XJq
         XE22ApuD1vkjToT4bsHC0j7/pRYWG2WzB+PEssIv7uSaQisjuDyDGGOGGV4UIg9pt8dW
         nttmOib9f5IsSdLS0rbl8pl0AluzyRE6dd1mXevhBVVdOP4+TFcEKu7RwMQXjNoowIqS
         T8NQLGyl8WgE5BFu4LW22SoTrYLPqdCAT6QQ2yoab6zqbxcTS3nJJxK7EZ0nEb9mkPrk
         m4ig==
X-Forwarded-Encrypted: i=1; AJvYcCXdkejWixrChJUt6P/BYVYdt2iMRGnXl+WsZSGWitlwN+J4QfsgHCJpqzCGY57gJJ82CkPd0E3xyHGUob4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGnmSznYEKqKVlF8KEk8dppzhCzhBtwovqBXIcha2laMDlwCG
	PZJ+8LxZwiHJ40KfKRoyvuYZVynQZQtUVLWqYyAdI+XzHELGIFL91YpAsuPGVFNsL99ijBdYMIn
	ctarZOVd8hGBY69Sc4iX4XAtcD9+NMPPY8m6lVkYIn83PhwsGbVuHakseH59khqlF+q0=
X-Gm-Gg: ASbGncvDiqB2fAExsNDMrLAnpf1ZVUHXVmEeq+7Ej1neFr2UAzXZwpe2Sw7QZk4HZ1y
	qqDP2li4ktAw4zK2tG9qxp/6WArtTQmud5BnYl7eHfNKG3RwqFynfEQ6NTEca6xk/mV10C0aOcc
	agVx9QIAwo6vOm87YzbFK0U2z6T7evgRpHxTaW7bmimyPt5cV5jLKaS0GMk3m3mqPtIMoR7kiwr
	HtD0jbH8MwKA+HymHSWDEiZehQ/wtoIKqndW1WKK09pK7VKSZGD3t/f2ecM7V8+TLPhp4UWbVnE
	pLgQuMuFNS8RP0hFCDb/ndqOABUKG3WXlF05pMJe/UER9W2Wf4p3xraUCFzXoaKG4rkqDgaehDX
	MXkTID2VekqcK9zcpPs2afg4=
X-Received: by 2002:a17:903:1ac8:b0:295:7454:34fd with SMTP id d9443c01a7336-2962ae4cc84mr53527155ad.39.1762362725895;
        Wed, 05 Nov 2025 09:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeCFKvc+cu2EJhNOU40JxGO+dLcv4OKAgN90pitr4Vd0dhyF8vMM9GVJDPYkZIN/AZ9xuYcw==
X-Received: by 2002:a17:903:1ac8:b0:295:7454:34fd with SMTP id d9443c01a7336-2962ae4cc84mr53526725ad.39.1762362725371;
        Wed, 05 Nov 2025 09:12:05 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm813955ad.43.2025.11.05.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:12:05 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:41:34 +0530
Subject: [PATCH v8 3/4] arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v8-3-62a7aaa551e3@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762362697; l=804;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=QygCnmXl5Esc5BPNyYe6tgH6/RC9PgKmXDBI3B/5l+4=;
 b=4/hnbaftD85vWOiRvY79AVqajy4IKr/MoIHXNURbn3WJqFZ0h5rcXRY1eU+wws26E3w2sj3Jv
 fn3x+H05GDlBtuMUaJxbVtDl1uWFqTpSagbZRjGwuY+NhsIIxXpYshb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: oRjPgaHnaRQEGZXwdNv_0VxctEX0WOOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX1umKRu7REeNx
 eOtBGWPwuo2RiGPf1N7W6cTFaQfvKrHx3UTM8EbqMJb8N4EU4hNAru32TYqbZ0whmLXrqwr63Us
 bXBiN7IVGaNziOjpOPH1xGx9QGmmvFK1WuXaXFzFk8sz9RrR0ddyosPzWJMAlM2ZCK5ecIWGPvV
 z6dIXAlWovUuNp0WvtZv9o+enWHOeexDrx67x3DK5qQeyjyKVrePoRCnMMcYvZyr6IPF/onLqlG
 eyMHlrVAlAiW5G6MjbkcoPGBeobK1XPLmAHS1SgSSVihi3XMgugmDQdwE7fm08cpASzXlKc5/7A
 hzAlwnyDofJMQu6aF3/7ol7vblEfuoVZuHXhSoOLP/697nDf1noK0vSJha1UG9saQ+SAMJdVote
 J+bvjNREkuTCiMDvK9MFQDLbyPqnxw==
X-Proofpoint-ORIG-GUID: oRjPgaHnaRQEGZXwdNv_0VxctEX0WOOP
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690b8566 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050134

Enable GPU for lemans-evk platform and provide path for zap
shader.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b40fa203e4a2f080f501140fd1c68b72d797fd00..28bf152f5fa8e8d7779904986da1a5c2f06a5909 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -454,6 +454,14 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sa8775p/a663_zap.mbn";
+};
+
 &i2c18 {
 	status = "okay";
 

-- 
2.51.0


