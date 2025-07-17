Return-Path: <linux-kernel+bounces-735319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD07B08DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C257B857C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AC2D877B;
	Thu, 17 Jul 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHiVSzOa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1342D6606
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757255; cv=none; b=pqkcgvTmcoqfzWM+q3a4qOTcMVhh6fmrYUTN9iRAcMnOpj50VgexOMgOEEEYOPAMibXie/qHwbCtX7xTUF24pEm94+CPqWG2EIbB/FQL2xfnQqkIIDgjgK4bLaptLGFSq01jrfr1gC0bT16FTHb0Iu0u7pu0f13pYy7g2YJmzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757255; c=relaxed/simple;
	bh=XBWj+K2b9C8/2lXZd2Ys5olIeeGxyJQzoy6N7+ggAbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CbCgEKp7lzbT6J6fANFku7K5kPtNR8/q1GZVadJc8XSmZPXrGt5TeGZgsPzPrsVK1i4iqhu1NsKswWK0Phjjb84VeupW5UsrRCQ5hOoLqPBUymRKyzjItVjADJUJQ0CUxAcvy4p8JZE/FMOigbDFgFC6TXkSfSAOB1X3Dfa+ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHiVSzOa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC5lxG020761
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sw6LPLuhEELuBjJMJTabeU8hBl1JfGGZnqYPdlkW7+I=; b=dHiVSzOaPCs2zqZs
	j0DJMIQDmqOAx1UNpYj49VA63b5C9coVlfirV7zVd6bJ0P5LcGqDrgETd07XCnJD
	yCa5zacyWM2AA51iXeZhXDZotgYNwLzEX/D+QKFsacgD3JEO2xmkPquA8N1TrGIQ
	KZdnYP0GqGgQ1ULhGmFU72OwpYJizd6wCi7YJyxPK6BtXidaORlfkd2TfGLANp06
	PcLjgVUtOvKToqX1KA2K/1CzPllDKgoIOMwdmHGK8OH/5OTfo6l/0wKOPrlYs6AE
	T4MVKEBH8x9esyoDuPWuFv2/lgf6p9Y+y0KTU+BrtEwKUFYu8SQoRJFnh9BoFYzU
	yFoHew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjreb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-236725af87fso13677145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757252; x=1753362052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw6LPLuhEELuBjJMJTabeU8hBl1JfGGZnqYPdlkW7+I=;
        b=Tz4LqVLwZtyYfr4ObKbLgnUW4HBXAb5I9ohjLKcxhvX549mwb9mqh305HWLkzMEUFs
         3x4UGcTKhDI7XwN7b4u84CO5zPpHnsFgZ1aFQLbFRpT30sW5HwuN+9aqv8PMm4cbAUgB
         mzKpBLoMcQgaNW5Xmvjik83hzZCryNQ0Rpd9N5B2es5bbbYbhCjZqc4kLdUKyk8gGV57
         Q8d0Bfc+0wC9jbhdhE7LYfV9XVE5mFZeyfpFG0jpiqvuPlmVMi6mCWzcqNtMefGivZ6m
         y855o+ljFh2UUhWWHQY4GBMiYrbBh7QjEb8wyT6UoeO7cdOip6MAltwxyTexJr1IikDT
         M9lw==
X-Forwarded-Encrypted: i=1; AJvYcCWhd64PS5Tn6+EC+9bDrlMWvoklayYtwjwWg+qv93TqoV9P+9qxbs5I1zPDIJnZT6OMtVMd9iTkLIJVJx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXM+DmQonX9vcckVOBN7kxnm7vwdzXx9AGGpNI9dgqPn9MvKlD
	9tPV1YpNU39zXBZR46fQjG062q9YsHJ/D9Y11WmaJ5PwyGo72cBitFO8YnY2KdH1wSi1d3dGT5g
	kSLdtV7IhzARcwtS3kyABv25ZURSopXLN/P5PLCGKqgpNud6PCIlF+B4FIQ8jrqpTmZM=
X-Gm-Gg: ASbGnctN0xOJou2QpYYqWItyzDe2gFUq8F9mm3UIEpUXBO4UJZUbvIKwGYGMknaqtXp
	uHZrR2VyH3eRQku/yYh+cKopbcB+NJu/NeW6TNW1Tv60nf+h0TLp2rYsfly+Es4534fm8r1ehTo
	cwl9bpK0krePlbYBucx2A/o9c5J1UiyeSELW9yXbBVNz02U8TttSAPXVZEz6dKnOCABgKJR3GXV
	NifKQtQx9yYpxBgLT5Y2N9fXU2pOtcv0z25CysQWLmMFp3sl1kvym1Z6j42NcrV+Nj524d98Nnz
	PUXVpJMIkZ0Pkate7k59zuM3s5J/O+ZHfrAZ
X-Received: by 2002:a17:902:f547:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23e30338824mr45454105ad.32.1752757251680;
        Thu, 17 Jul 2025 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPXXNo8cXoPkWxF6QYKGoAcZdb1+peqzLQ5KqZw4p93lkII9cj+MigMVeqxxAlIyqbiB13Xw==
X-Received: by 2002:a17:902:f547:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23e30338824mr45453135ad.32.1752757250981;
        Thu, 17 Jul 2025 06:00:50 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710180741.2970148-1-robh@kernel.org>
References: <20250710180741.2970148-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert axis,artpec6-pcie to DT
 schema
Message-Id: <175275724738.8776.8637174515757948922.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfXyaBQj2eZGXpn
 DNHRVKkATb1j0+RVszUKfixl26a7OH+/GhjruKXjnLMW1ViwJwOzIsVqaYX7ykEQ8hX81A+E+TE
 dqzrnYxmfp3RRZv1MTpIoi9GOeL6awMU/v3zaQkS7qLXrXGLg58tMoAJPlJCNG302fsQTMZlLQX
 YOQGv9I7adxUNhkYmPhshp4JhJiUUkZg6P0ou2UNeEb6IzxJa6//AUV1kJuD602H0nv0h6dmKC1
 1catBKxKOCrvn+CjL1CTtNwXfoTXRRvMTX3nPtQXH2owSo5yrHsnUNAOPWMp3DAFZSNeQsrvFOl
 HFtQ7JcUSjrR8Vp4lhNTPs1mhJLAsvCbITnb4IZpUqNNRbnZZ5uUZ1ui3ANGtLlZbW4bYH4KWn/
 0GzJR6iG/uNVzdWHEndgPf1dVBAdOfscKQ2lwMiTKaQRjF5r19M7qnaywryLOgRDBWE4j8E3
X-Proofpoint-GUID: XbufZe-I0VS840AyPc-1mqq3FLWzIudD
X-Proofpoint-ORIG-GUID: XbufZe-I0VS840AyPc-1mqq3FLWzIudD
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6878f404 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=oZnIUJi4OH_DVw05ZF0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=889 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:40 -0500, Rob Herring (Arm) wrote:
> Convert the Axis ARTPEC-6/7 PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert axis,artpec6-pcie to DT schema
      commit: bfde613ae16ec592e2aa28ad7f7729bc20b9382c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


