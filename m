Return-Path: <linux-kernel+bounces-897471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16184C53122
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 783FC504241
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5C3491FB;
	Wed, 12 Nov 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0syu2N3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXV4oJVG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4F33E36E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958910; cv=none; b=gaTgYd30Eqr1umm1rkJnpkxZkqMr8oAlNON/JJ9lOTTLqKDZi7zWR/Ia49NeXXhnSgkHWQaoQrnj/XqZws6uaC8xPDPdYJ3fsbfx/sUaC4Sk2rqj1hq4vuJ3f2gBtZu+409Nkij0UaFRVXNz8n4Ac00gl1M5ao5sOsYhxTAx0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958910; c=relaxed/simple;
	bh=9PqxUlRpFFCh1taZ3oLNDJ3kN9QV16XGK7ZLTsF67dM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d/IVTlJ0WvfiuwoII3X+YkdH/OBD3QgTyCJBybkonpVoxuKPpi1uumDq5DiVMlnLP0OcOGUa3IX+SLXCQOyCoB6/Do8fARQz5Mv156SSj7ON+jW7HYKU5NPR8nD+7FE+bcjY+pEQscf3Cz5V6OQlwm2KnjGZblYXiV6t/7L0XZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0syu2N3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXV4oJVG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9fSqg721907
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dWbBm32nIsy7hX/7GW0YHW
	3GKPIux+9q5ey0vZSs58M=; b=m0syu2N3+21MEAk3zMyMIdOlStb4W41NfbICR2
	hQ5XnC8i0jAhSL1ZmYjlYBwFy5P1f8I2nTdveYeMz1yglvODUUL7UExJArYHPHZP
	j9WeLkuJXkbnd8jdMHSilabVPN1V+aL3vsSCav/ifN9M3M22VTl0F8hKj6yNXrzq
	2ATc+agj8V0CFc0xjowjstbT8HO7ISArq51Cl2p3vEuOUt/5vmdaK4ZpIQcRjcO5
	ky7yyqLFXvJFwDriMrJN7qaQkme5x+LbIiK7p71Y2z4DGnO+jbKSj0AZZM6di1Rp
	IGFha6rAM5xDPl5VSVRY6tueLPphiH/cw971/3QU3BDsTYwA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1rx9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso977210b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762958908; x=1763563708; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWbBm32nIsy7hX/7GW0YHW3GKPIux+9q5ey0vZSs58M=;
        b=MXV4oJVGC0oE9TXoH2SpivhpUZpz5x5T8Z/jz9tn8o6zXuC2X4yGf3Hzdp4DQj8noG
         m2zNGfNVXxQ8ORWvsKfwqpVUFg05x//do9AVj1JSM4uTa/nva6h8do+J0Rrn0cHKy8Z2
         kKGKioHdoOIEIeEJ0bVM3XORy6UiXAa8YdkLgtPSdB6EYmxx5laFZvZ8ERU0IPRJpZTr
         UsOcz2WM1JfE97JasbOuwJLL6+2h2uWZd00eijF5oiFpRj/WRwDlNXvcEwRU1A25zE9+
         Mr9dZCd5EX418Iu9isHPePeGaKhhFsifX9SAe8phFzon6MIr+9rDVF3lZHyAgAZ0SG63
         h2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958908; x=1763563708;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWbBm32nIsy7hX/7GW0YHW3GKPIux+9q5ey0vZSs58M=;
        b=LG0H8BG/kWKvct/qxWS4Se1F/BcfFWAf8RVdN1C2TCF1pC97axPag4BTmURurIZ+Wq
         XvCYQqIl5Vq7FdupcRqPSRTWvEuRHKrNB6R10uwM2IZMPeP/W1cwcG0kv74g6An8CGq9
         4befO/p/R/NyoS/JCQ8wcxyvI//2mH2HG7g7R6vyYzcBoN1f7j61PQbwt0eOpgeiz5iI
         kUi6Oz9Djt/8a+CyxZpLKfXSifw2MXQQDBuryexcs0JyfwNTM5cF3rv+L77eAeg3pPCp
         tYMvd/VXrvCXK2pp2ImuV2L8cqOWT6hnvIPnlSqogzQMFAJCUCEK17XExKAi1iyBSA0K
         eEGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPkvEXU595OUYL/uKb6NW8IEJWRDzML1y9UaijNM852YpEpcGkUaRaG7XN95WNKJ2S6ezlIKhNNblWicY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUr9V3s6HjZEwffXXtxzQi2zpLuNhz1n+wRBwXnODaPQqF01r
	lFqFZ2g6p1p+93tcaJ3O3JD/sSTxEcJMioUBF/Sq6Q2Bl74lDaf3L2PIIlyb0bVokrwx2iTks7L
	ALAWbWI7GoAsSktJh66itVZzgc4rsOb2BJ1kOEY2wx43KwNpasCR5/E9j7S/3CS/Wkag=
X-Gm-Gg: ASbGncvyBDW++0c9yFKHD0ZYR9QPizJlj7j9WIn9TW5HFSWE2W+x7KXlEZSIO4NKRhs
	sknUQVuV93rIVKPX0yjKdr+myhZtU++sO6wG9TCh9swYa2I+g36xwTCj/CWuf7IKLF70J32cQgn
	31JJG6amT1JWathOGNb5t7gFf6UNs95U1ubYDtwPJpl6iuuikkL5Xsta5nNplx9OvC3+eb6/6q5
	5SeM+Ur+Bgme56EavDbxwZRbdA0YsNcQ15Wb45wzwBaEYSJ4c40Zf2QxEfCknJ16QO4P8KN0KGs
	0arFl/vywVAXooXY8hm4071SBBUEjtmevyQ3uacu7hfgOyH8SnFQUqlOdOF0VsTZJGzwvaohF1S
	UzE0/fBq9MvNTreA1N5HYFVahu+gLZp7PzU7xhOA=
X-Received: by 2002:a05:6a21:498:b0:342:3b8a:f349 with SMTP id adf61e73a8af0-3590c2011a1mr3958622637.52.1762958907548;
        Wed, 12 Nov 2025 06:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgo3wUH9zJxGQBmUR9uRu6r7uP4DumatVM+h0gLk8xcEARsSSFLXdK3iHDwFdRgHy4ZQAWdQ==
X-Received: by 2002:a05:6a21:498:b0:342:3b8a:f349 with SMTP id adf61e73a8af0-3590c2011a1mr3958575637.52.1762958907005;
        Wed, 12 Nov 2025 06:48:27 -0800 (PST)
Received: from hu-botlagun-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm19098234b3a.48.2025.11.12.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:48:26 -0800 (PST)
From: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Subject: [PATCH 0/2] Subject: [PATCH v1 0/2] Add LVDS panel for rb3gen2
 industrial mezzanine
Date: Wed, 12 Nov 2025 20:18:10 +0530
Message-Id: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqeFGkC/22Ny2rDMBBFf8Vo3Ql61bJNKV30L0oWeozSAVtKJ
 DuUhPx7lXrbzcC53DvnzioWwsqm7s4KXqlSTg3ES8f8t00nBAqNmeTyVQghwYYA8zpKITy4QqE
 1Yi5QnDphkkApbHUtZGdY8HaziVIrDFwHz8fIjWTt87lgpJ8/69dx54KXrcnXPWSfeMYUKuQ0d
 W+7m5v/3FcJHBzvRY9SaW78R671cNns7POyHNp5fxqdrQjPhNapU16FQYhBtZkbUY8hKMlNdM5
 51SuhjdYuqsiOj8cv4EhkoSEBAAA=
X-Change-ID: 20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-f804dc09f072
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762958903; l=786;
 i=venkata.botlagunta@oss.qualcomm.com; s=20251110; h=from:subject:message-id;
 bh=9PqxUlRpFFCh1taZ3oLNDJ3kN9QV16XGK7ZLTsF67dM=;
 b=tcxyr70fvu2+gdtFkmciyIbtr0aXiIWPqnSzd9w8ozM6U2bu3v7nR0Jvj4db7s7HMob2g6Gvl
 ffNFHvUwrKUDXM6b+tO32/1NhmTDjjDIPeizXagvWQIuzmN5huFwLPA
X-Developer-Key: i=venkata.botlagunta@oss.qualcomm.com; a=ed25519;
 pk=/SnYBwlkTzDCLnHFgEY0qFwPgKIV+aQWRbc3naiLzrk=
X-Proofpoint-ORIG-GUID: SQv81NqXsr5LBKfTzLtd01-rkBa19DUw
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=69149e3c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=EG195Y-omq6Azxm0EQMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: SQv81NqXsr5LBKfTzLtd01-rkBa19DUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX2nrZha6Lik2P
 yRCydqjDNTw89+WWC0WCP/YBDIOJhvPydaJ1jFoLRhcXjAQ/3iwgIdNLCn7Mf7hcW65Hg7/EQWV
 DvE8SvwlxfoQEqATJm3VSzRnNk6caNTM6Y5gvp8UkSW8WJBVuaxHU2YH0C9IeyCCj/mZ/b0M+Ju
 znTe7rqWGcdFLahfveozfyS4LZuLzW7Mor9eSOSGd2mEaZyB4ge1yuap0r4uJEujontwIY07lX+
 /fuAAAuy3xbGB3DD2tRG7i/2GA/ijQ9AVP3XuJTEK2iWCc8Z8hLwyQv8RCQSI8d8ZQTS528fSI0
 niYm2xsoBPUUvSZ51imEm1xA3d/scgZx/JO4fs+t0ASxqJuKevpMAe48U43gdea2ZZyaSxGEZs0
 RoDoXVzpT2Nl2Q0zY7Ok8DIN5z5/Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120119

Enables LT9211C bridge on rb3gen2 industrial mezzanine for
DSI to LVDS conversion. Add support for LVDS panel DV215FHM-R01.

Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
---
Gopi Botlagunta (2):
      arm64: dts: qcom: Enable lvds panel-DV215FHM-R01 for rb3gen2 industrial mezzanine
      arm64: configs: Update defconfig for DSI-LVDS bridge support

 .../qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso | 106 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 2 files changed, 107 insertions(+)
---
base-commit: 3c3d81183061b9e49dd3207fbbbc36314744bf3f
change-id: 20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-f804dc09f072

Best regards,
-- 
Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>


