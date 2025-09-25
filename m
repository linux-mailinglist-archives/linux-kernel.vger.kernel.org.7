Return-Path: <linux-kernel+bounces-831821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8ABB9DA08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F431BC3724
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757472EFD93;
	Thu, 25 Sep 2025 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSVoe5gl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B62E8E08
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781794; cv=none; b=SKFQm5EjkcB6rfGwSzohGyfCTJj6h0niDam+YMDOxWZu4Pn1v1jUfX5qwItPpty6jg3VMf0TF+nvpQexSCSCBqJRlc6m1Ho4cQqOlCEloV6t5TOXA8GIIHV6nPm0f1iywYH0P71FOt51p5gYuoVAlfu8g2fngQbOMucgluwFFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781794; c=relaxed/simple;
	bh=E3B3ByaBtuMatGnp2Pcxduj29OzySduOTeUAJyaDEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HV+oSe11LJAbD7Lvg+crDEuvgfsALMjMLECeTIr99koXdHoRn1wgcx68PGru3mu1ke8n5rhcz7IT/c3lOAELF4woworkBydO4NWGYdbKVHtF06XmMv2bpaVnnvU3grRPSd0BcBrrpcP97/hI2K61vdxvI96kq9XXJ6A0AXpQghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSVoe5gl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a9OZ026667
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcCj/e9tgK8s4kiIpVDjeJ1bIplDWEorF8EPo+A1CcA=; b=TSVoe5glvmG9l6JY
	q7VDU3ShWssUSf7/bQUyB4c6WIh5NbOI7gkUT14Wr2QoZiTBcwSlvPTkAZGZuUbU
	jRsZnl9asiLyazehOmNiZqBadgpOa/GT0DddQbOeHkf99HQYPi/ZBJ0xoERJXJOz
	OLKe8QOmLktMQzWeSfoccL0rLIsS/Q0yEVZaD/6DL+9V0oa/Zf/7sraf6FTgsFcc
	JVVjM1CLB5fjIK9tkkzFY7Vb1eZyx4OuIeITTBaLSnBu+nZifbeupq0/kB5cPlL9
	EMaUaBWruq05lWP0juBJlHQXMx5AVU5IGEV5UOXwlASBbFIR6klTV4IJZhKv+WJG
	HxWpPw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f180e8da5so805452b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781791; x=1759386591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcCj/e9tgK8s4kiIpVDjeJ1bIplDWEorF8EPo+A1CcA=;
        b=kt2dkBfqq/Zfczd97VD+w7G5M9SKL9VNdOGWOlPRtDvCLkgjHWDYhLI8ZC72c/05c+
         osWbZtyvOUOjCVaOT7aP/UU6s2I/n21cyXTR7fmnnu5j2864t37s4Qvd+nzo9aw1v7Ee
         AziM9riEDvr+52ssSV4r3mdRBpPzVUq4KQGa8KyE9tAZhzdgK7Qou3+DYDvvaW+uJWfy
         nqzrcwaJ5rtBIrN+IM3YjcCqLqOh3QfvBeO6DrdrhRwXos86D4elpv6WlOp2SgD8SxcL
         /GlTdIWcS9RhtemOz5Opz0vp1blDOomC4FUzRdfR76xZgL2ldRuFq6IZftPcMQNXQE5G
         ixWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS9AJNsrGOTvUvcurdhXt6O+stmA5wwP7S/IGI8IhZzxwqivkULaGy8XTCg1fGv2nsg6tXlFVUSokwDO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3Lqch+sKB4S7SxlcUXHvtokThbatSix4OfQwzJzWDYAvxed2
	an32sJjFaEZxzu8y9XL0PGQn2G3sgsO7plsaTMgooZAacuWkWGTwbsaBb6r5y4UTH3ClvLoOMjQ
	Li16znznx/yoglZpuGeJLAq6tk7MFneRsN98SiCcB1q3v8gkc/5vpSItPiPtk9q8FSKY=
X-Gm-Gg: ASbGncvVjY/AZ6F0m7H0o+fX5oECjzWI9ARdXYNi48numHwKL8hIAn5dk2mLFKrszj5
	3DYDOUij8IyMJdmcOGiS9pG9rqA5U9UTHPyrD69rl2fS+xerchH0yFYwFRZX4j7huiJGmlMMdc4
	7wIz21NLptVm0TbUJRKKPVw6EpmehcFp9jQfJK3PrzY8ewN1lgvGk3NP8YZkqFPP9pj2rOrBRus
	5uc4dXUHFCjXpFvDgWC3Np0O29wwNktW3blWDII1ZMl8QXNgguiuu5wi+k5b8QYy0lbp4VjraoZ
	+vtNuJjrHXY/F/jEEfv/53VE+bwsnR0Bs8+yMnKxTa5MIW/Y1xOyiZ23b/vZ/B451wVaVJjPDrb
	P5QAaiEn7pg4cg3K5/HXPFqlHwZoAJjbgKjZyLYkzFgHZNaQ1Jf7QK7oLQifq
X-Received: by 2002:aa7:8896:0:b0:77e:ec80:b3e0 with SMTP id d2e1a72fcca58-780fced5bfbmr2922066b3a.25.1758781791348;
        Wed, 24 Sep 2025 23:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8zvFmAMXrlLG0zIap/cG5mPBtSwZ0z6zFscRnmqOoRmAMSRaV6FOZu/Gm2TRFZJOs+sct+g==
X-Received: by 2002:aa7:8896:0:b0:77e:ec80:b3e0 with SMTP id d2e1a72fcca58-780fced5bfbmr2922037b3a.25.1758781790956;
        Wed, 24 Sep 2025 23:29:50 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:50 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:23 +0530
Subject: [PATCH v2 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe
 failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-17-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e160 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zkxicyaTBexjGtpFqaYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX4mmueoiVURj5
 qz4Zg2ClaDcNsBS0ZCUFGCL+2VskE7h+ZJ9Oeo5uCtYbkhyf+aM8wWHk8TnrkKU2I/w8U4OTdwA
 cBdKS9Wc3wI1cccokqMlFOtohJMysM9chV+Jk+08D4dGIRshhaj/2TXSS9a1JmOzfJ1wfQA6epx
 Om2FGTKRHa/p2d1NhdMtgwIegBavgoA0jmcgpcSe8loifZ1gdqz5CLn+XxUIGzTJuhLOtrX1GmP
 iNBWErqtTU7nkHZthNt9Ff5Z0lVGJIyQQPKJvMYo/AwKIhByT/+zFtNAGYJjSU32XysUsOVvtFY
 SLPgH8JGvcbm+T/4rHGS1jjpUwOrEhIcpR5Cd1+E2v/e3gqyGtRZZ2knrz9JPgEqB2lEs4PwcDF
 8dLzi2aK
X-Proofpoint-GUID: Vr388qAn4KRg-DfUJrfU1iTb5wvWfVta
X-Proofpoint-ORIG-GUID: Vr388qAn4KRg-DfUJrfU1iTb5wvWfVta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

On Glymur boards, the RTC alarm interrupts are routed to SOCCP
subsystems and are not available to APPS. This can cause the
RTC probe failure as the RTC IRQ registration will fail in
probe.

Fix this issue by adding `no-alarm` property in the RTC DT
node. This will skip the RTC alarm irq registration and
the RTC probe will return success.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index d6003ae515e37049fdf17d6b604b974dc8e9fbbc..b04c0ed28468620673237fffb4013adacc7ef7ba 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -429,3 +429,7 @@ vreg_l4h_e0_1p2: ldo4 {
 		};
 	};
 };
+
+&pmk8850_rtc {
+	no-alarm;
+};

-- 
2.34.1


