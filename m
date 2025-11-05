Return-Path: <linux-kernel+bounces-886951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E4C36D04
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 151094FAE90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130A3370F9;
	Wed,  5 Nov 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="We2S4wmO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O01TtpRM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628063385BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361178; cv=none; b=g+UPbjfBgIE+OSBeTxAIkDgYepOSEbKI+qPIk4CUoRroAi9f9blJkMrA/HfCfFl7hkfIkjPT16hwScvjnySus+3JW7ehVbpfWd4eTU0LSebv4wHZ6LSUNt1nM5KH6Ae4AMiePxSiaVOtWBREm9U4QBSyEmNAIY65/pZiCAWCzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361178; c=relaxed/simple;
	bh=CSOgdQpc0lMePHubTaI8zKt7XuYIPcsGjD7SJ+d1YnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuOZzedsAvyQ1omghmxRxAIVtPnjWZAbZPep0VmE10KfVN0TTDlrfJXT54LTmM/BH533YCIEuPTKqxx+/uiMRnh7Z9KAfLc1aHgrJm5kn/hfHql8mCuy8P+D+zE+LG6xFuOPxv3NwylmkwQJ3zZ1wjtz3+djeeuqmVQ/n950VFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=We2S4wmO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O01TtpRM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5B36Nr655158
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0NNfdE3hYTw3zNUDaf9Tkr9rvcnD4dKnWyPzOQRNqA=; b=We2S4wmOLyuO1nHH
	rRTzXzsQ0dFfXANFMEu8iGnKmhNm2oE616DBj3v3aCGlvbiYW9J2KTkWVN8Z2wKM
	ruW7IWzMG4AdH7m3znPgYiDHvwg3/5L3akRs6IJUXJn22vHaFE59yHtS+0DHZVMO
	NugzL9PqaCoXhXizTTGVs5/GJpxwt5KfCUMkqCqcqNIzgax3DbWtc04X+23pIloz
	NnalIx3qCMW26nytLWWck0+rr+N0JycPwuqrqYBgVJMNh6tKo4EC5WphkBlxKDZs
	PtrqDw4kvrkadaw+qnwKayn0ZvJPBEoSCc5F1FtIHEbaNlo0bJM0y2b814WSF78z
	X2L43A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a85c8gxpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-336b646768eso86254a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361174; x=1762965974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0NNfdE3hYTw3zNUDaf9Tkr9rvcnD4dKnWyPzOQRNqA=;
        b=O01TtpRMovFxkGkCstjrnZbKxP1Yjz6cmjho6O9dnMb8YxhQb7lVIzSzDkONN1r200
         rEzf3Lxf0sFLfVIHW3Fjvxah/zEjZouwrrZz2T6oIz5Pwp24rU44Dw2RsPrsCxwAnBj/
         z3rBKx2TC5F2p8NY+os0VnVvNUALAhji7ubNZJUbs991O4RSAO/YnFgTO9JIjCBlIuuy
         ALdOa+GmBkymxSL1Hq6JfJqUxvKJFeglzuMqyYSgRot15W5tcY/oN/ZrrUNZVz24vfdB
         oLPsPILWK3+rzk6HWQObUwUuabIt4GXpNMWs5cqHGrDOJ3NCF3WYoLq3Uga0eb0NVPIA
         qNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361174; x=1762965974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0NNfdE3hYTw3zNUDaf9Tkr9rvcnD4dKnWyPzOQRNqA=;
        b=TIR4toGDIOZaxoq9G6tEA+hmwn1P6JnlWoI91Do5Itb+8gCdGr3KI4842X86H/iBAI
         QNzeicqRNMaoFRrOVxymZ1S1IE4l5VzeYNIe+u7C8QkznXqsZoIw9T6EdpgCRZ3yytKF
         qA1PWX4BZaF3TvOQP52wYJ1bEssj0EIZLyceT5eQtvcpxu82+Cm5iWgMlnvKXRwGH1tk
         SKD+AOk8r0dKi6ErwbdZRPHTmc8GxKqYtKS0GhuGJaOkd5ZoAhRgDuoCHe58uO6CaINQ
         ESLepOIZz4i7hlfjYjbnP4uh7503GzdpQ4fQLrQEHgQ1Yd3eMkFnUNHeUQmxZtiv/thj
         hyow==
X-Forwarded-Encrypted: i=1; AJvYcCW8RJYntS7KKpAq3I1GuR6T72Tz6Wi3QIdsI6VgDHUmmlgWPG3IPdZzr13Ja/FVzjWe1kc+rZjzupBIRZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwADPMkAAmxz2Yol+65nNvmWIKmLvldnCNKbTEUg2NvY6JqYY
	tQXoKTz8L4X5HDeisf248qLuzePJ4wiQfjgEXR35ECeyYGMQ3gy+gQWD0KwBkzq3ulo5jI27rS7
	iBbbecU4Xs9S6PpqVIadMKL6KseFCCr8QorpOwq6m7g6dAUp94oHN0lgrvB2BVdaAj5c=
X-Gm-Gg: ASbGncsFr265Lx29rMrOhGAnQTgdt6q2fbbACcHVd9xsRS5eVuay3RQgTfLonVjVYMY
	QOfYBKHBAu/ozlnUTdhscT8J8rZJhVqWdrv8rjfe6tHKR7f1XS/CqmMG3xciDMwJrrPqHmrPMnx
	B2kYourz/BDDNYRKaXHj2jZwGFnw6Uhr/hqZoSNyURRY09aYqMuIovJ6eb5Qrm/B0bql+V+/r2m
	LJV5zGVj6iSl2AkRQbbbC1XAxAQ4BVi5E2z56uCfMHzlzlO+3c4PfDVFa0sjoypsOVOISvRd0Bo
	QE9P1T6uGNYmCVwq6kyLpV8yiWpGhTnKh4rrlLm6lEo5nMYlW2qgrYlUQqtH5Gz93FG+MQHtBqO
	sNfHYcMgEb+SQOSZmHQC0e3k=
X-Received: by 2002:a17:90b:274e:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-341a6c2dd89mr5133571a91.11.1762361174259;
        Wed, 05 Nov 2025 08:46:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExDXPdqPDT2NkdJ7fX7iWKr2pf+irb2Zq0hx+Byc3+KFA1DEVgM9hn1fe4HmX+JkqxfTmWJw==
X-Received: by 2002:a17:90b:274e:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-341a6c2dd89mr5133518a91.11.1762361173752;
        Wed, 05 Nov 2025 08:46:13 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:13 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:15:45 +0530
Subject: [PATCH v7 1/5] dt-bindings: nvmem: qfprom: Add sa8775p compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v7-1-1bcf7f151125@oss.qualcomm.com>
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
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=998;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=CSOgdQpc0lMePHubTaI8zKt7XuYIPcsGjD7SJ+d1YnY=;
 b=i1IXdpI+2THuQXFa8wLghoNr7UkEvIZ+HYFBfmuX0sPOdoo24L21KRdyc21kfonQ2ky812AeR
 7Q+ZR+DzxwSADT8vgD11jIiqgJfy4qZSSfcOGwkSN4fE6qUFppbBcpE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: XDY0AdvFEi8tqy0VHqNG1X3oRuTD1tGl
X-Proofpoint-GUID: XDY0AdvFEi8tqy0VHqNG1X3oRuTD1tGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfXyk4gPzvACFe0
 BCPZ78AlP0v2X9d12J63x4Ay1JUN8fI6B1FBK7ZZ8ofHj04qUGVU8ovt2qMO7GlL2CdSJRAm+Io
 y690BzL5mY32WReXw2ZKfnSM5OgpIWc99cZ//VmUhKs3Nhk2lum473OOVWXYLFs387nS7NSpS8M
 aKqt9sw9olNLe+kPdp9/sCWEVGlT/LoDkK4P9IGxuZd02eNZAiUAshNzi4QSKqHoFIUIVdIzvNp
 uFCw72+PqUmEQLsP/4+vZjU4wS9anvt8GwkIwrlA1p52aPhC0A00itrAyLyDkIQzhlKnhTCUVpq
 CWzhSs8tSaz14wr6gmPvUQjiDMoAgZh5CWzhlk3ppDEY6oXt/xewFEaPGj7/jc/yqTMo60rx4DS
 P5JAb5HDfDH/29+ErMFU0PXFJLwI9w==
X-Authority-Analysis: v=2.4 cv=apS/yCZV c=1 sm=1 tr=0 ts=690b7f57 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=TNpnUgr77EDisZP18eEA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050129

Document compatible string for the QFPROM on Lemans platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 3f6dc6a3a9f1adc582a28cf71414b0e9d08629ed..7d1612acca48d24c3b54c4d25fa8a210176d3bb5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,qcs615-qfprom
           - qcom,qcs8300-qfprom
+          - qcom,sa8775p-qfprom
           - qcom,sar2130p-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom

-- 
2.51.0


