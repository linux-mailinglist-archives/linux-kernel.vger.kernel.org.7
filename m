Return-Path: <linux-kernel+bounces-886955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B419C370DB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE10668401
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40F33DED5;
	Wed,  5 Nov 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnQv5Fds";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EC6zxSkS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C7333431
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361198; cv=none; b=K6kL3PM57aXfigi9DCP1VkUWs+tuBj2oNtYrtpMD4n9mzPqv8UBSE4w97/dg9UV3YiGLmtURjC73DgcHtg1S8kdgdknVcX7eexbleTIGq0B/mIZGJFZjwhXrLJkfk3TNtAqlJtqgPTFxbuQG/lnkA86OE1hCoaegxlsAMxhvsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361198; c=relaxed/simple;
	bh=QygCnmXl5Esc5BPNyYe6tgH6/RC9PgKmXDBI3B/5l+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olGfHx9iaZs+W8Zfaqj9Qa60VoypvncbyXqnc70IOHrtW9KbH7g3pSxez0W+q7EcCCGCznxohvKc5zZz8rLyBh7oIqjqYRB7YKdNyrp33LWPBkYJpf0nkMzZrNbIlQ3/2R1E4rLeGKWnMrXKsUJVy9FQpkbOBIqVmlMcmbnK0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jnQv5Fds; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EC6zxSkS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5GWWTO159403
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=; b=jnQv5Fds5DZ66Zry
	IvEzoBTbpAmxm3Blk120fyRbtP0En3+vWCNKbpcPwQX1Fj+O96uxXgs+LB66h4lf
	6yHEDzMzedtzY0DTKt22ScHUDXr45zH6TeU9NxHGwbcPeZSBdw33j/5fz7BxiQwS
	WjfFtovv7k4shYJj2uiTEdpJi3PwLo40h+Npnl+XYeHLDn/+un/Na1CtWAy3+iIr
	OoBuXOQq2zS0fLg8arQlmt+u5NVsP10Tp3T1rVrkTxl4czG1MMnu90djVWXamARR
	//kE+VxVSM3+7n0/wi77orDia9+SYl4nePF4qLcd+QNUhSWEGsH4295dTv7TpT/L
	WMIPJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a82mt1h8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28bd8b3fa67so416565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361196; x=1762965996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=;
        b=EC6zxSkS1Z3LLFdjaZ8MtxhF0KpSKZAnuG7PAdVoG93U8HAeaXUWP01LM78IKCCHhK
         wd3hSI8Jys1fRvPsLkkeD+suW+sDjJBSCbFk10clwaAQ8OFZPGI163CWf72QMctROjYB
         U5tgLphQZwxSYr1aQZ8xvVswPV3Q7ukE7FrETpCe5ns5PmbhXKVBwnFa/ee41tBmWhx3
         xsv2mPShmndXS8dQ/aHe/GGcQhb5HuE9nII6arEyRHkaXWfWH1GPhYXrYaRwNUapc+GK
         0GxWBByYmwffK7iDbYh/47HsTccTt7zMOfZIC6ahuLvqAOkiSvaH5PrJkk57gAZzIDO+
         omnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361196; x=1762965996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJFOrjhFJZHkN7hWb6jUgTkGNx4wTKXUTuj6Z9f24XU=;
        b=vQztmhU0cUTSSVxbeISS0+3gVmJnF7n7HfYmssI283wRyXKOiWsEcg02AYpW7pMQI3
         JOx8L32mVIShbLhF2LCkei/OFI9YaEBtGoJl2r+XvfTkeapEFL+9uyqxEb2YJYz/9R12
         BeZvEYtlQtrLsdLt4wxVC+EoNTtIFAFS9+xM9yoB6ZwG+Tx7+I2Yu+iYiHTrpsIHTb2g
         sUq5L56uNB7za1cy3Z9iQcepTxjPEI1zNmnk7Pu8oxvEksVcIu9EB2yTSDWeKAeL3TD1
         y3mH9SteuuaSXJ+jPp0RgAq5yvN34SAayK1wwoOakJMPfJwalvNUOqsRbb1i6k2dT2CA
         1fpA==
X-Forwarded-Encrypted: i=1; AJvYcCVAPmTuoMJVPlOEx7IFPYnTXEp2oGO2Wcmcurq+90ZBnAltrHcSYIHj1aNelUVexn3IHJRnvryCVi+yYJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdKsJhBLGmwK7wFNdtbTmuZjWVPFQE1bLFgdjDJquDZCnOsdE
	AAvnmKqpAosn3j55jkJZ22LklDso3/EvbYEZPAKOjrVCHIEbgH/LpqtnKLQ0+9EDoDHrNjH6Lw/
	WpED12dPBS5XDqXAirBX6kE8afk/ev4097GkbU5foPRa7Ux7wx+EAaG53U6b3fVRsCsk=
X-Gm-Gg: ASbGncvYgkzuZJBl2TQmeGplXCm+N/mEPOfKUEHD1D5XZVUA0+Opb5NhTZb0A2l4VuY
	r8Sfjupoy6eZUsHFLAYG4ovl/GZ4V2qL8W+2EAlZgPV1rsvXviqXociC8zJnxwlbuZrkI6Y0wV8
	NGr/51R+wxbDg7ZVT1AxZD07+fLsbt8k8CYraQOMrQ08omZqJ+P3qM6j9OJYmvc0iLByEK04DCC
	lKV8FrygDu572G+c37Qk2euGKHXOA4z9R1mXMklTXmKV4ClvffgywTqwe3tiBVjppdtV0kwTe77
	dmdPcHP5tRaX4V4ddHQ+yVHr8s9EWkdhsGXDg8BQhMsv1+cH3EfgOE6j8jhQ3RhhrDGuq82wrzp
	yCUsrJzaO19fSZFl6w/HMRSE=
X-Received: by 2002:a17:902:c947:b0:295:7b8c:6622 with SMTP id d9443c01a7336-2962ad10486mr59682385ad.11.1762361195363;
        Wed, 05 Nov 2025 08:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYVpEn9p7yDIsAYp1aZP87Bdl/2uK5TgZtdjIwNg03NFpwQ20p/nGpKGX/x/FLTLX8/vHeGw==
X-Received: by 2002:a17:902:c947:b0:295:7b8c:6622 with SMTP id d9443c01a7336-2962ad10486mr59681825ad.11.1762361194676;
        Wed, 05 Nov 2025 08:46:34 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:33 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:15:48 +0530
Subject: [PATCH v7 4/5] arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v7-4-1bcf7f151125@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=804;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=QygCnmXl5Esc5BPNyYe6tgH6/RC9PgKmXDBI3B/5l+4=;
 b=kkr/m55E2zuEnA2RDfM9Hl+ewlE6yBtGv8M1mz14zrUkkvyLGc1oQRrfOQuIGcFm462YtTEbc
 +q/796q/1FHCFP/yO+/k9iCY1uPTdpFDahQ0z7BN/arcIQwhtr7ayCa
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfXwMOg0b3ApTTl
 EbD+o+MZjmtd+Pw99Om7QanHfEA3OAfXMU75giw59y59UFuqfTrxiyK9aljOPfdME2wL6nY9ma8
 HYf3jcDHJSC5kpsoMK0GohOVa3DXQuy4u9xY2ECaVJE8vmniIxe5eaedBYbSNBRJBa0nCcF+xEX
 Rs3vrXTQH/tfLtN97dT2enPClJ3+/MI7iDdwjQKGEhb0yLDPiTS8xRx+8lp3wNyI4Y3PUG1M/Wx
 JELYF4/BNTJQuKMKc3OcdJBlFwaOPesoaAuup8HxxsXXexV3OnqFNNe6uCB5ocF8yE+8TaylHGm
 rQ44ok08V7D6peD/XbvxR6c/C0GV2VyPAi6BvRz7Izr6PsYws115aNH5cqCDP+ulLulppNeQEcS
 9mqeMu6eaZUNIf3XEftRekXR3qzv4Q==
X-Proofpoint-GUID: L3ZTO9qStN-pqb9jRnGn3CGU8dV99K9F
X-Authority-Analysis: v=2.4 cv=LLtrgZW9 c=1 sm=1 tr=0 ts=690b7f6c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: L3ZTO9qStN-pqb9jRnGn3CGU8dV99K9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050130

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


