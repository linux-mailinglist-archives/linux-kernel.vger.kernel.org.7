Return-Path: <linux-kernel+bounces-729357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA3B03560
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30FC189ABFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F11F8BD6;
	Mon, 14 Jul 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljYEd3/z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1C1F4C8E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468804; cv=none; b=US11g+lP+9JR3/2CT/fyIpLKigCB/QyUfkIYUBtVUsVR3zJt2XnGGx/EximjJsYjtHTeSXW2pLvRXf0uoyP0BBxZWZHYM7itLFL4PUs4wFllv3LqXxeh64wosXU+Q7lfpFQkVdwwljacYJ4SoOkAzU1KRP1c4yPEqbzuzxL5AjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468804; c=relaxed/simple;
	bh=QvGVSx6duPfoOXZGVp8TsRxkNssmW3yTVBJ0qkN66wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RkVdZ7NrUGyClZtQj2jE/9YQQWVG+uaX35YUdLRJDxgH4sIJ6UERARHqBerwjiM0qMmw/j99oM5CjOGo8ZBsKgNhEYMvjGaadqjuDWyIXyAfJgynorO0zSHfCEjm35xYzlwFoim9o7JJE/wXVhrRdkrq6vP+RZwWr7rgG2yJ3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljYEd3/z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNphjj004347
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pk7vM8iR7o4BlMbQxsyShMMSXch2AmUcOwz
	7sKF99ag=; b=ljYEd3/zjJL3/NUNuW3K6sV80JhWaCaPDozEeoO/r42DNlPE56t
	ntBm3jAgNbWn1USHeLeoky9ZpAdizO3JnQlaAWdFe5XV85XV8BT0iXNS9sJMcdxv
	mVBEH1H91CPKUDOUS3VUSOYA00ElyMf+3clr9xXwVd/sjtjzYPLBg97ffKWdZfNK
	lla5mvf9XpL7mho14zgPinUOmDSxmn0G8eJDf9sl1tCZQCvDI1dW1ptO/3trClCA
	7/kAccd3BVMVviKMnv8l9f1yRnA+iH8VhXMFfRQAoeV43njckCN03bie8oUPQL+f
	F6B+c4J3+zcVEkADdNDJ2Yojsjg1PpqX8+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxau9c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so3013084a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468800; x=1753073600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk7vM8iR7o4BlMbQxsyShMMSXch2AmUcOwz7sKF99ag=;
        b=mdfBC+rx2p5p7jlgBptAxI0D6UG5mBLRCuQD5xzaYGORyzKF+DKHFdtwYp0xIK3C6z
         /OL8dRNjsqaJxLQ2l3YTABuQeVG9TKmQPoum9Hes5wfssdzTWDwNIcqIN8cgantsFJNx
         dzIIwjiHGPmhy0RSz/y8BEeof60awJlLzZ345WE8BvkGSKtRUzsPnoC7uzuGPrmn4L0e
         UuU30XAALSP+97mJpE4BbTq3y/NqpuEzMFvQqyMkJnfPmRUol4n/jOCoMNxI5ob6pVQf
         s104sHWURgJ57z2m7ub7C/gDPzlHwLzAgTndZY5Dtr6M+AM9k739ZOxOSmljBONQLqdv
         xsUA==
X-Gm-Message-State: AOJu0Yzan4CRuo+17ktcJaeqBMX+rbUzDIsdwKvcxEp4mPMnwBuXBj/k
	qtpDDgRifArT9kh1E4zXRun7ctugGzps47DVDzDFdjV2PxRTt7JzvTlkvF72otvruGtSM1i3lDa
	qcod1dYwh769fF0VO4yki0lWQGNCtwSPXYpd+MYINVDpcvMzEZS6eFdje0V1xWJnbyXI=
X-Gm-Gg: ASbGncsLaQpRbJUgHBHg9R1878+kXzs2Y+OoNhJikY6z/mxIzEi9VeUnDKkYwygw5zs
	SyDnpq0dUmKko2DuXeXbp0kbodkX7er4HXM1x9ndN8L50aodJFn0LFjZH+hWBoyl7jdC9/CEAmz
	EGV8OOAXQyRL0eS1GHe2/CQLoh+E/srV57GYf9pWGh4MnEQKI7TPMeWymwL9oLGKYWHWoFFI83Q
	MCCF5HtjpRjM1fWgk5i29u4z3X0ac0+0dNxXC1WPgXTTAsHaJF7pWzc3AXBUVYYGp0hkNF747MA
	Z5JScR5pQmuHewa85384rHhjsbSnfhtJcxWnUXW4Hcrs1PBnUeliVIQHmDPOs9Gfk3c1ziz6kEh
	tuA==
X-Received: by 2002:a17:902:f70a:b0:235:f3b0:ae81 with SMTP id d9443c01a7336-23df08e5e30mr184101125ad.27.1752468800124;
        Sun, 13 Jul 2025 21:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlV73S9kgnxtMSDiX6ciJJa0pMHds7dtbdrLub0f7j+fXjTHuuXR8CeV8xnJfnl9GO/5bWOQ==
X-Received: by 2002:a17:902:f70a:b0:235:f3b0:ae81 with SMTP id d9443c01a7336-23df08e5e30mr184100755ad.27.1752468799678;
        Sun, 13 Jul 2025 21:53:19 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864a8sm85664325ad.42.2025.07.13.21.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:53:19 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Flattening USB controller on SM8450
Date: Mon, 14 Jul 2025 10:23:08 +0530
Message-Id: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Mnu-7zRc4TZ2OAwvuFp-GCzSsw44PxA
X-Proofpoint-ORIG-GUID: 2Mnu-7zRc4TZ2OAwvuFp-GCzSsw44PxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNiBTYWx0ZWRfXz51/zrFjxEr2
 6XCRU7u+1XOVUfOMvDiTHRuawCuQSKsJAW9rJBnz7K/U5n4r3ZpHub3xhDDCEWwnwx7SFEplTRf
 0bI5vih63KmucFI5hgGS1mnlZyrEEGuLLLvsU0fCkISTcInZkOINwnPNy2ZKsV4tDW6b9cV+8/u
 OrhaLaMv/L1lj78pWZcrk8U2kf3ZJ3q7o6wWOwkOEkHXUk4viX9YlLnyD75G6DSFjG2W5BGLwLY
 8PZuj+1MHu7iH3Cn8QKS7yPui3xeFmWYJWsYbmhgGM+nbQF3quKoNjwIpfqEWiqf13UAJTCmYj3
 6PRSywyseKQXI3sGjXkdl/JLr4AdMx0/fIbE3IMNZQPhHAYSix4ZA+BF2N1GZCynmyTewcvMT2b
 eV9l+rHO0+DtmvhgFyZ8mBqfW3g/1KkRI39EoCxDHJxZYAaJ4lbmGEAWtrmKgnD7bQnZHX9m
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68748d41 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=UcbzNMOkSj1vwIQaWDsA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=721
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140026

Flatten USB Controller node on SM8450 QRD to move away from legacy USB
Qualcomm glue driver and make use of new one.

Tested the series on top of a QRD. As per Neil's comments, made changes
for HDK as well. Gave a compile test for the sony-xperia-nagara changes.

Changes in v3:
As per comments received:
a) Flattened all platforms.
b) Addressed Dmitry's comments - moving properties from QRD to base DT.

Changes in v2:
Rebase from RFC.

Link to v2:
https://lore.kernel.org/all/20250610091805.2997546-1-krishna.kurapati@oss.qualcomm.com/

Link to RFC:
https://lore.kernel.org/all/20231017131851.8299-5-quic_kriskura@quicinc.com/
https://lore.kernel.org/all/20231017131851.8299-6-quic_kriskura@quicinc.com/


Krishna Kurapati (2):
  arm64: dts: qcom: sm8450-qrd: add pmic glink node
  arm64: dts: qcom: sm8450: Flatten usb controller node

 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  5 --
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts       | 51 ++++++++++++++++-
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  5 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 57 +++++++++----------
 4 files changed, 76 insertions(+), 42 deletions(-)

-- 
2.34.1


