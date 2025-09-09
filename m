Return-Path: <linux-kernel+bounces-807876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03AB4AAA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91F51642EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C1E3191CE;
	Tue,  9 Sep 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SukDWI+I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C322877F7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413783; cv=none; b=dVFivHh8eHvpJm/Yf0VGn70moGrOzR7mk2koN37S5p/q3qgcjBbt5ot9pZVLwDKkllWghpqM1mrL7R+LwxkVFj66fQ8rPDF+CtPH/TIiBjJKFSRu51wNr1637RG+J1ij/ZUDYTOHuL3GckVLmMcIIyrE5gVDVFXPY16xh/Htee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413783; c=relaxed/simple;
	bh=usm4FdHvUrxmd9nPz9vE9Y9h2MKo8F0CD0Pm4gdOM3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY2oS9Ku/IUJVieRsen101NRd+jtdJbQC6lzRmVEMjQZQAL2N5AaQRsv2yee9iiDrZHYQf2wNOB7lcrsgfXA9EI6oJt4cFFTdnHAcQFuBCNCuo7L4x53tgU7A5RZ864A0LeR/DZhs00y4xktvOV15WuUvPGqQ/rBGJjVvTTkVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SukDWI+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LT5p003647
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 10:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nBy0MaLLwIMy5hmNCuvVLXpeZyI8/Mf8yaQGjy4D3lc=; b=SukDWI+IENYQRmB+
	xT7tyR+V4I6m4SBnnD/qDnJ/Z620L6GTS4HdZ9XgNEvbyRJiyt8BiWgD9gR40NL0
	wPrTBSLmwtESTV03ElCQuHf7obWaq28R5zgAB4dfl1c6ve3YJ524SrKYvkZvudCW
	F5nDBejDSJDjjosiOjB9+qWxDR/QBFQ9ehpjBOKLYR2ftE0hDFu++JcFUB+uq6do
	zl8krcaI+BKXSMCrjMjbu8a8avZeX69+pVhT01Il5nzkS4vEuO8KajynhzsApbgQ
	6hsY+DJNLsEn5p5etv9zgFI+QXDmvhIGXjGgjTsWg5e7E9O3qqxVxy4G/EbGpeJg
	vpmr4A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapg67p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:29:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b6023952f6so11852721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413780; x=1758018580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBy0MaLLwIMy5hmNCuvVLXpeZyI8/Mf8yaQGjy4D3lc=;
        b=A9cmFCGEV1s7/nPvhK6E5yqHDhRwzQ0bmdmTxUByVdtBz/NZRgEnmoKk7xVTa9dvEV
         uv2SWfsoi55Wooh+M0g8IE0WBVUwhzeX1GyvBirg/6ITkxpbyIsSXYjjEEU87C1W4fuq
         VRCGuddtOcJgDDoKn4wJvGO48moLs33YQNrKlhfWmykGaBzNRZw1xlNxjws0/8FSxlqs
         TTGFRmkIxNDdQsCXfgfVvqaLgdLWi7ZUZYdZV1hiCTwhnXbsWQNW0MNaLy0Re4kh8PnL
         REhw3Tw1Vb51EKMH46/9QpV4cC2BhrdDdS+n9zCNe32LJnYcq5dh0OxO+VjfwPR75veh
         NhHg==
X-Forwarded-Encrypted: i=1; AJvYcCWp4dawWGgW7q2odOp4g9CtubKj0pdi/HHNg9v/YCM+bjHe33bHasCtNEFruqTLhh7l7rWGHijXifOhNMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpINEnUlH9yueE1l6LAMhi+pN1UJmZmGyu3T40WXNke2L42CPB
	l8UdZUdHBNKkId8FPfe6lksjexORyDLq6Q2nzKVj4kLazfbb6UDJ0dsCFtjO/6rmWUTM48p7tx+
	RokgUim5T+M0FWTm5RpA1nW4pt+BsYZgPvu1fUOwJKl2jvbKw8gdgvGBD3saWU0yupWA=
X-Gm-Gg: ASbGncv+mG37Mdpif16VsEP96oA1nAqcz1QzEaSYA7oF2JJCg7c/+uoc90e1/315fFU
	qLmv/g3sAQUnJP7j6m3+5yqwxuVyx08JkR/A3odkmi0jFDboClO+KKyCdAH99RQqNUPiL33Oybq
	D3S136nMYPvN52IhtJF7CNxnC03VpaJi0iMHqR3CeFBFUAUMB437kqCGIZ9xVy9Qmm4CokD3RYn
	357UpQdD5/kb3BIlkEwKqeg2pgXeQFIwEVql9hBzPum3gaAgqDk2vHMDzB0hi0pfWl7HXjdGo9Y
	AI7sB7Bzd7kTcJsSuN9o+IsfL1xHgarZnCMQ6gKSgcj4uKIlNqTxuQCX5z86g527f7fvsEQN8Nz
	WIn3P1xBwgmAZ3DHAHc7V6A==
X-Received: by 2002:a05:622a:199a:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b5f847af12mr82535121cf.6.1757413780362;
        Tue, 09 Sep 2025 03:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnb22PJ9048ALlRoPQ81RK5NwZI6keVm8Xomf4IIFy3Ah/BDXmg4UM7UmfQqnov5lleFpFMQ==
X-Received: by 2002:a05:622a:199a:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b5f847af12mr82534891cf.6.1757413779810;
        Tue, 09 Sep 2025 03:29:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0470f11088sm1406697166b.111.2025.09.09.03.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:29:39 -0700 (PDT)
Message-ID: <df9d2328-8d4e-49f6-a8d8-a3385fd3f017@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 12:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: lemans-evk-camera: Add DT
 overlay
To: Wenmeng Liu <quic_wenmliu@qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, bryan.odonoghue@linaro.org,
        todor.too@gmail.com, vladimir.zapolskiy@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20250909-camss_rb8-v3-0-c7c8df385f9a@oss.qualcomm.com>
 <20250909-camss_rb8-v3-3-c7c8df385f9a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-camss_rb8-v3-3-c7c8df385f9a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c00195 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4WODJ3-QYr2a6mbQJ8wA:9 a=QEXdDO2ut3YA:10 a=1SaFWpeTM14A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Evcrv0_F_2SwyaJR6MP7tlXNWk6Z2lSf
X-Proofpoint-ORIG-GUID: Evcrv0_F_2SwyaJR6MP7tlXNWk6Z2lSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX0FGFiilYMNqQ
 aoUuhkRBLUGAUagPFDvCXr+8M8IYBSIbVI0JCFKn37MjkB6oLyILgWX9kUIU96aF6Czks7LOPaH
 BLgExoAxZPdByZHhmPufH6xrNqiYTsDlfefeyBGwx5Ot4KJyMo8hCqBp91YkEziYmcYPaQe+402
 eOYGg1jf/wbo3Jzm65sQeLPnPUI8g3lzrDjPkLchho1b/lkoYpV0xe05qZKFptJGgFIbT7T3qRz
 qtzlaxt8qVo7/JVwSUhYxHNHzpeUtemYB6ykxLWVKKpu5Z37jxFWuasR2ns8Uoarl7wfyTwcmwG
 p5h0ROklvmhpcZSc70HG23RE8WtTsVLMiDcNxmoU+l1dImnL0BNhF1w6mB0f+wOyAC/z2WhdegQ
 Qcc+LY4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On 9/9/25 12:21 PM, Wenmeng Liu wrote:
> Enable IMX577 via CCI1 on LeMans EVK Core Kit.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Wenmeng Liu <quic_wenmliu@qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

