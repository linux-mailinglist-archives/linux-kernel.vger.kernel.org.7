Return-Path: <linux-kernel+bounces-768316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D545B25FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974C21C27217
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A82F60B1;
	Thu, 14 Aug 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyh4dR6Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F072ECD3A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161589; cv=none; b=nH63wsvLAhP6PWAxrdNr8w4Ez6DZWrhTVPA/2FjSE5RjNt5wxZy5GOEk9nJwhT8q4K57HxX+t+rPRSyntS89/RXT22TbP3M2QxhMdbpMn41pRgG6h3q/lbgwPdwdO0SfH9rjs7xejMBPhbc/cZm3e9VoF+aBJEDdtxQyDA3Vrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161589; c=relaxed/simple;
	bh=2nrV1RGrteIGILA35JGVcooDPCw0i8l4s+Fs181xoas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abXj0Hm8RoLy26xKQVsaQDCxSv05TKwu0PaVZrngYcq8gf70YMP/6WUxg5UWEI0dYhMzNCYBLuILhkl+8Bw7mtpqlp1MJz5aeoq6oniFaWXiEPDparSR40nqUcJUerCghbrHotLWtHnNQAJQqlEExU9Pi4vTPo7br24AmqC60hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jyh4dR6Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8j1DK020580
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=802pdFifR+0
	7OV/Ivdq0qgpF3I8tJB99ZMyu6lvL/YU=; b=jyh4dR6Y5GqRn9yuJLvkmi6qTRV
	W1SlCzCiWosgv77Dv6xxSxN2XXcwLBJccGOtJeFIx6ysXRCPtr7fvDrbaSw83d6Z
	twIYFk7pDFIA91QYFQtLMlNbSoUqh2vNpr3I6bAT+UA33MRhN4zHwOhIn2O0eEaR
	3CjcdJYkjtXoG8Uhl/bl0GFEyyMZKsBTfuAlS14VfX3V1OKshB9LeVhbaQrjfyO3
	u3Vs0EZbcFLnWgf9c3jZseeuy2EgX+9RolWGPOcRsvqNYky+0TzfmXhPmL3nEbfr
	PB7kda6Fx4iP/K0fM56yI+csS6tCxN2hhDm7yNNQ7Z5t++0AEbWP9mPzPyA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmf01y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109be525eso20316101cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161585; x=1755766385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=802pdFifR+07OV/Ivdq0qgpF3I8tJB99ZMyu6lvL/YU=;
        b=g61CYxstVzLg1YSqLcQmv5t/Y4QNcbDV1svyDX7xvo5HWxlbeEMRKxlLcTRT7UJr6I
         D1qdNxs22DMPCFthin1yGDlpX2ebX2r3n2glhlcPRq0m9O17BtueaXYsFhQZ/8gjMaYU
         uuv9Pc9JOhzmxliL1X8RDv5oU3RK+wfm6PLfndgu1fcU8MOYJ96CjbVQjvhDOnGzJYEx
         hwZCqyvz9ylZuPu0npYR9FzBIkBjz/Y3qQapmCkT/K9GjoUdgc+Ueg2t6bTGv693Xajw
         5YiiDdb1z8cxCD1fpkQtcAm4vj2T+buUwCjIiTg6jwuVswU6HYGU1CVwfPi/I9lvB4JF
         snIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXS0kt/z15jRsDKYj4L+S5nBT4Ih3ULmtmbOo0S4iNFZraaRWkh6/pX+5vDPbwOHAL0ymtdT+tHHkL5Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj5ECwtX42vqLQC0VuaNm3uLyNnQuG8TLeOB/9ojjmkNpauc4
	DRFmY3vKw3XuussKr3M/1FnHLKYZBJNInENRX0OO+vaBtcTZ1eEnUBMlhMmi1gTX2z6GkEAFtTT
	r8cwnK/rUW9/zVWPaXxP82ZvmHqoMNFB5Uh50M2mmQoq/jQzbl63otEhlv8RvluMR11k=
X-Gm-Gg: ASbGncsNBs2A3VOjni8hB8h7Q6EVl++sBfxpBBoqI5wSF+rBFXHvpdVpWoBvaUnVyvc
	/c3E0gqrgA4NR+ZETWdgpM0IeP+yvkyXX+rufi15XzsaLqnmKV7uyaxcWPkSt/lRlcz1vCyIqHX
	Q+46wdXur9OECMJMI7IC0AvXuOq7zBmI3jGNRS3moku2ICvQMa2ez9MMtTItINFs3BQO9J0irBE
	j+FLfsEHQq3+Z1RVMeOr5xyj2Yi7MaCt3yCak/ndy8Ex+OijkPd3OeqlmUoXeuSlg8ujyTsHmrM
	354/EqMLM+FHcu3TV0grd9pqPaU2MN9/XLSLiyKTngCBf4Ttxee2oHLe0sATTBcXVwIDuMhcFbu
	qYmZHzkqltIcv
X-Received: by 2002:a05:622a:81c2:b0:4b0:e934:85e5 with SMTP id d75a77b69052e-4b10a958260mr23386691cf.5.1755161585096;
        Thu, 14 Aug 2025 01:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDfgB8pIcLGblDgdcBbn8sEeOUMF0U28QhhTWEOvZWpvnlv7kxX3cNXjAhMSWaa/z5Xj1oDQ==
X-Received: by 2002:a05:622a:81c2:b0:4b0:e934:85e5 with SMTP id d75a77b69052e-4b10a958260mr23386401cf.5.1755161584620;
        Thu, 14 Aug 2025 01:53:04 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm13155895e9.2.2025.08.14.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:53:04 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 8/8] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Thu, 14 Aug 2025 10:52:48 +0200
Message-Id: <20250814085248.2371130-9-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
References: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX+juomU3v39Do
 LDJ712kyCFUkVMEc07XqQqrsxe+8N1+gjVkeC1hMCA4gploUISYp9+qkoQjSx7Av4vkP6ZiN577
 EtqM/jYCy/xg5722qr+ZTqCsNskYr8D6uBAnMl69QQxFOhjhCocI0palQkBa1R+DGRFTgB+aiDS
 DDN6l7Xv2I6CbWE+qTKwKNk7DxLt7rGNvY4TFagkGAwLEzZEP9Y89Cea+LjYnAPO03KPLjOr0P1
 WPaANU+tw+EBgsVmKIv3TgJXSe0SxgMMY0qc1lcKfpQohAKRQy4osfOiHylh/w98Y9ALEIZyVXk
 sDuCikrIPKkIyqF9u59N5peeuen4brpqD9+vCTdYSL7cgLeBbPIkzxWVEMYv5BwG/N13cvI61st
 CGWBw82s
X-Proofpoint-GUID: 8LwNLJZhRB8SvWoP5A6SkMh1RJST7ivP
X-Proofpoint-ORIG-GUID: 8LwNLJZhRB8SvWoP5A6SkMh1RJST7ivP
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689da3f1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=Qms5JgQ9tnEuTiNUcoUA:9 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Enable Venus on the QRB2210 RB1 development board.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..e92d0d6ad1b8 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -698,6 +698,10 @@ &usb_qmpphy_out {
 	remote-endpoint = <&pm4125_ss_in>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wifi {
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
 	vdd-1.8-xo-supply = <&pm4125_l13>;
-- 
2.34.1


