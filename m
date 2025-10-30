Return-Path: <linux-kernel+bounces-878080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD7C1FB85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65BFE4E9B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A135580A;
	Thu, 30 Oct 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9Chfr4z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iNE5j/ZW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62840355809
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822590; cv=none; b=hgPsdy2P6tbMlswIN8lgjC9ZSgn5EwRIkjDPleg3491mZK1fp5gqWFtpdbBKbPd/XcpQRme7TpQRu6BYqFo8ClURx0JwlAKZlJCz3Dqes4JAjbXQ+4VBCmOvWc984mWqM4392kFKRr+8Ou2FmzVdHJNEK9cV9cOpVf2/jQWWnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822590; c=relaxed/simple;
	bh=TdTenebo1wf1mMWccGdKC5vf2P8eTxK18YJfYnYRBCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F48BUVbDFzrgrn9z4DEKKS+PvFnLOa2sRqHeCeALSbVT0CQRrNVyr6DWEcF7Bn8iY9BsxcBsfJJzs8gHr2nuoWJ7TlF4uRAHR7wP9SMYEitbXxGzPhgd2AZxyeV15WIx2+NiTX14KNTSCn5XW4hymCJ966T+d3AWALW8g2uDxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y9Chfr4z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iNE5j/ZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7kPAW1697111
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	snUgPgVQWC+EcxSMP4fm0dKm8E4V5U09jedaQkTnmks=; b=Y9Chfr4zN9u5opCW
	OQbMsksnmh+N+z0/5Q4lcuERQRt9EUPXfTmZpoNwlCi+352kqBTsmCLXNpouhosc
	ilyqBrAvqEV5oqRRIKXsa2YLuLyW4Mkn2+3QEpQB47Ezpwr2N6yVVsDo1GHcXzTC
	qIZGKFW7muWl/xt6xVXoDHOS0tUtBcFYfgRWDTIjS2EQN2O+clo4YJgvQeMCsy+7
	rhlvcAJ8e/B34g+HLRpH75FMp/iDZg4/tgA+x9I2GeVxuMyHZuTNII/Qp/Yvv4zH
	p002e+JeH0mpe4ol42OKyPR7LzdLBYj0oFYs3a4BpZAaARAfUFVzFFggbH6huW3O
	ylrNog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv231t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso1610991a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822588; x=1762427388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snUgPgVQWC+EcxSMP4fm0dKm8E4V5U09jedaQkTnmks=;
        b=iNE5j/ZWaj/rp339C3lJICiD9N6+iCQqbIwD6ulgHeV1CYWCvR4polCAFoMh0Q+xcW
         F3oTNvIyaj8aDNRhUr7HsZ6kE4svwO0jgZejurj3nYSeQfI2jUroFBAR0VScgNyLoOEd
         O4Hlnd13RZBOcS8un8eHBrJmfdJu4cyx8S+lT+rUxcFg4deE8tykyPNid4MSMd5A9mLo
         ENyVbGeq9c8vtW2e63V+mBXn8SxbPfAuLvjLM3DStoDwubkyIpuTn9RD77L5QHTbxcZT
         OWwGze6nuIZ/AnsRMP71Texdw8Y9JJH6Pb08oki32THbWRMm0NtX/BfijUyZJr6gUMEn
         pDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822588; x=1762427388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snUgPgVQWC+EcxSMP4fm0dKm8E4V5U09jedaQkTnmks=;
        b=NZk+SJR5uZzF3y+/nRpU3euIR8rUstkmF+YLcaBU7krqU6pG6qoB/H04NShorBEbaG
         OCHt5ZVSsH93SPjSNOlmn9yPrrypVBO5aeUlzpwSXeJQVSKlQ7o4ONiBI6b8s2rkDcC4
         1/J5mGSFdyo0hcCmAtBb4115PQjS7u8He5BYcPjTP7rgDkJom/NK5nyiAQNQ4hx2/T7N
         h+em2iYu7hPEizaF0AOD7L/Cx1r1tfjhTLIH4JWGj4lVmGmkRNOZVp+/USE/MeWsrtns
         mWxdoYl+Y7Ya24Oxllfil4ib3RMwkZUachdDX6U04cgLYoUdq+vpygJedvaZhNtwjkYd
         wdcA==
X-Forwarded-Encrypted: i=1; AJvYcCW46mbxRzRX6a4IHsvMUCVt283bu2GAfQ6A+mtB9mkIwONptCtshNC5nImGFgncdRipD7pUMJjT7sbRmhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOA9SH66Brab/V9rVvYJoUoekol8EurK78V/2OhPmrNkvMv+N
	0GSU0Izt/Asf3QMqmlf0E7P7zzSnL8Z2+JyCNb9YngFCdTwqMpbvGRFpJybwARN0MoJKbYBrlAK
	rpPmhkbQBU/Ja7359nJR/T5g+sMMttdrjWd82tqKACLsHN2DsAHAB8otRrub2uqpRxzU=
X-Gm-Gg: ASbGncsmFZjzJy0ji0aEX//UmONnPEvjxx8r99cQ0xZHdsOCXh4UMVF4HrmeEj7EIiF
	gyepAl+fglvgT5aAhjkkmGBWnlE3JrlhncFKfKBKyWgj9IKPFOPJpoQO/l1d/PxhPAHUQQxW2w2
	86T65FSF62yK2uRusvpAEMKIUJvqnusbQYKJ91KQ50d13PPefVMK7bSpggf/nFmMhGbEkvG0yeN
	gh9Yn+S86PmAeQUjDoF/2ZEZukHE6b1zF8Tl9mO+Az8CNvmq9c3ZUXnO9l+LxiDMKm2N682Ur7M
	cN0PuQwzuxBnWi0nmRL/nfWvpAWSFWSggebnXrJ9lgkvlsnG+aHSaTouW7B560epvc60NtC3ISF
	/023YJ9GVXpJpccqP6Vc/1AY=
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3403a28efb0mr7578853a91.27.1761822587839;
        Thu, 30 Oct 2025 04:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh7+ANE+Hi9qtGtlIMkfwoy1OotAoprCXBNtn0GZ8LJhXpLEzUjuS1rFg5Wm0R5B48lMsOsA==
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3403a28efb0mr7578782a91.27.1761822587245;
        Thu, 30 Oct 2025 04:09:47 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509727fesm2262839a91.4.2025.10.30.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:09:46 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 16:39:05 +0530
Subject: [PATCH v2 2/6] dt-bindings: clock: qcom: Document the Kaanapali
 TCSR Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-gcc_kaanapali-v2-v2-2-a774a587af6f@oss.qualcomm.com>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com
Cc: aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: op0CUvLhjKG_a5z-XudsuTrKOtv_y24z
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=6903477c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=3hKmvjqeoD1fMx2jVRsA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: op0CUvLhjKG_a5z-XudsuTrKOtv_y24z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX82hBjtdgVyQx
 GJTG0bQ5CzNuLnxGCXyXXINPEKKNd6jTMGxIUatKTGojKICBps1lJCJDMvd4AQPQPmNIkyJrE4Y
 hiA7RE30Lo1c6IQBvVO9+na2PVeNLqng0S8nIrbtlArbT8USGBUNg/wojxHMFjjHHl0VCAfWNCN
 uZUGRkoY9pzz+e/58oZ8IDIKp9cww3fZamYId+AO4AC6GSJOrj6Wi2IW0lehzLsB37JNONS1zDm
 MIxUAvkdtba1vGyK1Ru4Im8hvOzuPSymSRRYim18kqnM4YiGzgqIRtGX6hXMiCgSycLLX1z18ac
 yQHdJ4YsvrWxtOxmNh4CWGgHTN+J8BuXPnfe+djnvUfIsLTCs1hUnzePtQzJz86DlImryWrx1q5
 Prfyjy902wgyYTrIQcv9xeIr14FkVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090

Add bindings documentation for TCSR Clock Controller for Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 2c992b3437f29b38d9c73e3c600f2c55e0b8ae98..784fef8306812c482f863c45b322a69b88c5800c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -25,6 +25,7 @@ properties:
     items:
       - enum:
           - qcom,glymur-tcsr
+          - qcom,kaanapali-tcsr
           - qcom,milos-tcsr
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr

-- 
2.34.1


