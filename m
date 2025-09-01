Return-Path: <linux-kernel+bounces-793979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D79B3DB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0673BE9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8F26E6ED;
	Mon,  1 Sep 2025 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5BHFNO+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BDEEC0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712018; cv=none; b=bIkctJ4CwQo9gNv+WOGNFh3JjguUcEw3KKM875SHXCCuSpAIK4RCDAToFSuCCevj+cmipXMPAFdvVFD2XZ1X+FzuZg7r++TPWXrcczQWByv3vUYlfqh8cejEovGO6uLufAZThjOY6/qPg+1YjeaGoWW4HSGkOWywDS1zOTamJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712018; c=relaxed/simple;
	bh=gVlSE8+FJxabJJF6HJCmkpMqpJLW3soo9nABGLW1Fu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ffGhDOz/ph9Hh+FOs70bIIjH5Voj9j7PC7pfI3BPKniOcuySWM2kf6odoV917BrxpbQhdDKCZmuZM/THuw/j1E2rF4CipX8ZQnMqXyx5mgl+XG09Xz44O8/o9bQJ9y1HkhumAGZvd124m0LTHhzPkulrxtOqxRKcP858v3QOxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5BHFNO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNHrSh007479
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5DJRmLadUWXtXyQvcD/tBF
	b6Uo8uJs+NYbbyFSSUDyQ=; b=h5BHFNO+3cRr6JAK4jf0kQdxlHArxlC9NlJ2Bb
	skIC4wBLiifLwhwKMWGmPeIQt/pKFs/LB7FgmO69JHxrYqS93QhPxyitKK59T0Ow
	+GLpTQluFbEoFpkJL0JztqDqq8rBQMO3fuuxz2l0wcLEKUcvwlBCotQ/kQMQ9gsx
	S34P/4SgNBHyH+UrAY0+iNY8B/8FtFU/bd7Tt2WtW07B9gBNLqYlOLOW5WWc54lo
	q737IrfbQmiuyYXu+pw2BB66HZff7KfpXBtM7wsR8AMPjgeGhl266ZqNwKuMbBI4
	YSZ4kGVwGZy+1UYx8+W1PAt5hZbbNlsgwjOUxf9okwCtaltg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8krva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:33:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2488490fe4eso57266555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712014; x=1757316814;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DJRmLadUWXtXyQvcD/tBFb6Uo8uJs+NYbbyFSSUDyQ=;
        b=rsPkWjvkDeU1RaHge1PZITyS8NE09qEP3NIRvgFrUHxlh6k1DR/161WScKy0DkqWrr
         xtVihRhWgeYh5LAFas6QcmDFP66mSiljVRTJZH/MVMLzobc8yf7T0ajf01y7ZW/4OuB5
         zYPryFOyvrMsrtWzXaPY2FBlnFXfgJ0IpQVop2EkvJIki7qE0jbl1U7F6S9nVfcQbP+R
         yV9gO/FsF4KDV/kqbgha+6SOjviNt2s1mytz0rcKobwiUAv42WCfmO2lmbwNL8+09sOX
         y+LfXX0cmlkRp44Lvkj1beVjqVO9nisuaZwECIVIMUWMbBUFDFGEdNNCq+fb/FZaaF4C
         5cGA==
X-Gm-Message-State: AOJu0Yxa0q4AXk5L35fkcqJ8t09VCNBZKiPuoQsVJbZihKEOlZ+/iUTf
	WkKhKaa3sZm0aDLZJ4PwDIcWPBhgg1JVxsQelPrmAGvkXgPqLg39MYWoLov6shrh0ENhVsmcEcm
	N7mznHbJjrzL/eMUyZ/74yD+i0vA7HqPq+oweSEEFgH4W5rCZR/SkrJUK9txXLe6uTUk=
X-Gm-Gg: ASbGncu1gRdqsQ0UZvIGnPDaAvzu1W7dWgZKVIMCaEtgrgWS2eOQwiIPj1ywoD8iQWm
	4MCE+bOc5QvCxWBJISeERfdnXW+XSntIxCDg3E1vCRwMhqppWDTCaZRK40MyJ/mheaQxn8CYQZ9
	n7TTxo8Xn1hmNF9zfw+Hd0Jyo8AatsCxOrSxObSnM4iDIR7bcynO2Ax9L103Hr6qjRxh9piFBXc
	Q6NJNMatRAEdNUn6a4bvYXtbLIr9o5S3NhntF/Wbgp+2zas0BmuyQeYSzLSe0Wksu2Yxm4+SH7n
	rql4hTPvouTXTEqtW5rbtLrgklptzSlFA6xh+uiNmEyssFfiYHBz2ABnO0YnIeANH/c9rFwht9m
	VPw==
X-Received: by 2002:a17:903:32c9:b0:245:fa00:6e25 with SMTP id d9443c01a7336-24944a9bebdmr93754015ad.28.1756712014480;
        Mon, 01 Sep 2025 00:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxr2epv/+TsKlTzR16S3I09bGwKg+e+Algqa7VJCpSEfXE5hgM55vx9JD+xWDXFQQaSMSqA==
X-Received: by 2002:a17:903:32c9:b0:245:fa00:6e25 with SMTP id d9443c01a7336-24944a9bebdmr93753595ad.28.1756712014027;
        Mon, 01 Sep 2025 00:33:34 -0700 (PDT)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5a0bf9sm16095554a91.13.2025.09.01.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:33:33 -0700 (PDT)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Subject: [PATCH 0/2] media: update Dikshita Agarwal's email address
Date: Mon, 01 Sep 2025 13:03:27 +0530
Message-Id: <20250901-update-email-v1-0-8fd49d58c0e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdMtWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwND3dKClMSSVN3U3MTMHN1Uk1TzxMQ0E6M0c0MloJaCotS0zAqwcdG
 xtbUAu6TRsl4AAAA=
X-Change-ID: 20250901-update-email-e4e7aaf42f71
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756712010; l=797;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=gVlSE8+FJxabJJF6HJCmkpMqpJLW3soo9nABGLW1Fu4=;
 b=ze0huHxvBv4Aw8AJgx+M/NXYh7bP5hi5WXOBeVALQ6BIk252y2rWE81ab2qdudDI7UaTB7+yX
 PvkAq/1VGkPAWwfasfhxHDmS9vvSBpl08G6QbWzLc81wN79fIk2OQ0S
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: 8_BCK2OP7iLDUAozYfASSf0OpdocEoek
X-Proofpoint-GUID: 8_BCK2OP7iLDUAozYfASSf0OpdocEoek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX86YiZ7X5Lddx
 XByoqfBhqC2Agp3SqXL2IROaDpOrJks7AeeZe6p1a7WyZl8tlw9LbmBns6pMM+UMmZUXWdHAbf7
 h7FNiMiIwdHNaBcth9Wj9zvM7h9XMRaDg+tlf1pJBnkc4xLFHYfX6OQC+vKAV1a3LkEV6ukvaoH
 ZwdaceFDSkQgQO3zCXLPT9/j3pIGvmD+LuH2qmTKgxkK3iSVUdx5oWCy7HmKXHaij8gvJTpd2AU
 ZJGlzdWFUvXFzvute6st4l/wOPZZXpp+GsjDhw+A4tx5HxM2R8FqYBecsLEo79lWmiO7PA9r2Eu
 jyx16tJPDoOucOIYzCueXXolvRM2qX+Hl5TOuTBkPkz5oCqyb8B0JreN7g05Ls1t4CO+2oPD1P5
 /9Fjwxpd
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b54c4f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=kqLEYqA6lE3EGcPpYoMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

I am switching to dikshita.agarwal@oss.qualcomm.com for my patch
submissions as the quic_dikshita@quicinc.com will go away in some time, 
update all my emails in the code accordingly.

Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Dikshita Agarwal (2):
      MAINTAINERS: update Dikshita Agarwal's email addresses
      Documentation: media: update Dikshita Agarwal's email address

 Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml | 2 +-
 MAINTAINERS                                                   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: dffd279a8aa36479d127766e15fa817830387aba
change-id: 20250901-update-email-e4e7aaf42f71

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


