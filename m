Return-Path: <linux-kernel+bounces-822786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D43B84AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E41C22113
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9A6302CBD;
	Thu, 18 Sep 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K05nXNNE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3629D29C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199807; cv=none; b=dUzZimbciiPsiC1Z5GM3ft1REGI7uL3IpNDxAobjL+575bgJcvNoUxXsVTk2UAEs8eAs59YLklpZpRRquQSZYjBxAG+AmLu6oNwQxngqYoNFKZOUr3Hfj8Fb4hXmL/t33l0lfBD435MAE5whEqLIG1f4G9uF1+ed3LdB2PDoqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199807; c=relaxed/simple;
	bh=8bH3fVLln3J48TzTAJv9MI99+H7ir7k5BxpHk2Gk6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4qmLTfkUubu1dSKPXiCpEYiHc3ur8FrjWQE1aPBkRD+IrrvUG5Ff3XXP/kuQWAgW1mQOUv5KP5nAnsKxU/NkkgQN+nwa4/IJfl7tFHby5pr6bZwWMd1doA4ISOmjuIwkn1nhmwqZuNIjtdbBW+OsP5LT2lpt4RfVfLtXvRvqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K05nXNNE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8B9UL007439
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=; b=K05nXNNETfHhuJ4v
	wa/I0oDvbqWlMeCP+vY5ux7NaDAFMv1k28gJU/CbITklUAda5GryNVJ/DyqYmfZO
	+RSkscaURw1X3k4eeokphNHkITzd++PpJ0f0tTnabq2pkSb+mxoB7sCQ0F/KIJj4
	C6Ib/DviH0RDetuLVkjDgmg4c8BE5AgExO6nO80pw5u3kF4cLm0bJzfP26dAvrES
	QYoW5UKPe9kQGx5JRCAF6MORbaZLvoxu4khstolRwLoHvPxNxyMSMZ/XVRPud2P5
	5UVomkBMlqOOqpAqP7RVSatm+ZrGPKVSc/Oml/b4J/RNjI/908x25prW44nCKC/3
	i+HNEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebervyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b600d0a59bso4541221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199804; x=1758804604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=;
        b=c3DCTB15NoEwAbOI8FEf0XAvzHgUoOL1jHqQaHHBx8kMVJ0sChjKxbNXuu/LknRoPc
         ysTcHeL6ViSQg5Rg+oAWkZmXN17RyAZSDyJIjL0FjJsdbQSlTB9qhbFyDm/87Qgvhqqv
         qe/YpINzFDI7sDQxvcWkAukDGRF9iaJbibZ/EdLFqBxy0DP0JD1YKBiwmgsdCkqQTtQX
         J5eMnYWB6NVCqr0cTYBQJuG5NaMflWtQ6rysZTO8E+PzSPigOHyJUCrqMCMJHeWR2Z8a
         julqwfsK6CJocrsOqOdcpTxvYkJ3jAkT2/w4ehpnCJ5Vkcgj75WbGD7xWcI0E9KuEyw5
         07cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2FUN313sfrgwEr8xnohyPxyyX9sNWiblDfJ83LU7cUCB1iJD7iNH/PgqE+lCWTQyNL12B0n4sWugNlYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpKBbHMHmzfforcrtZTGHemC2nfspnuhj7SLFxiZa3vo+qEZI
	P73AAX1bSCKfJLxmcaMxQtGxFO3TMf7dOB9yTpfKkz4q3+XuLPodE9z97j0Za2V4uoZfN5KVp3P
	2SVI0G2Ch3GHq+TvInF+KTHcA2rc0m7zs9KL9bnrqyNzW3ZNJUSkCjrs6n/mXHlRaqnk=
X-Gm-Gg: ASbGncsKYoTQ4YlM1opWhVt8n0dIMQVZn3qkVY7X2KTp9ehSohug2N4NuLIP3YI79dv
	q3Ww/3de9JdJYdufiLgCHcLJ5DPOpayvbct46IBguDOoXffq6N36rFZRi/Y0YSSAQ7SjTDCGeg4
	gF4nSqhNHsQrwt23bI9ax6Hx1d+40e8SGTfOZ4njRoLt8rXoo+Z8qryYaOSYPUihUBGR6xGEUts
	zfX4sTwFIMT06fjXR+ZXkn4/1Ne5r28j1pwkJVvbkOlMj/VQ1VZp2oJJo9+rjLGQQz0vxhxdGDs
	SMptNOOofm0yOaUQQ8/8WGUjJJP/l+Uye3DYAXqzXGYQBdYxL8t/QhlLerDL
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152811cf.7.1758199804032;
        Thu, 18 Sep 2025 05:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRNHFzJzTMA3xkK272o1+K9461PXaGcz8hNcpg8txtT51Al8DimN2qgY98Hx45Cq2m8Q94tw==
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152451cf.7.1758199803340;
        Thu, 18 Sep 2025 05:50:03 -0700 (PDT)
Received: from [192.168.149.223] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fb5sm189444566b.16.2025.09.18.05.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:50:02 -0700 (PDT)
Message-ID: <824004f9-538e-42e1-b40e-dda22e081c4e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:49:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T010ITbmhMYhgNKbr7fjXHo5wmkVpzEV
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cbfffd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t3lpBGeAFA5ev54tvH4A:9 a=QEXdDO2ut3YA:10 a=VXQMaQTvCj8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: T010ITbmhMYhgNKbr7fjXHo5wmkVpzEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX4cMJaft9R5k2
 D/QfhdIODK85WUMnMKtWrpyE4//Pi6shgkBaOIaOzxqVxs+T01mA4d3U1xNKNEkuKajaIqTLhjq
 VryFDXLX+McQPogofG1tF2HATmr+Pa5vHzW66jazMIwQZs/FMpld8BN8lghKiAqOvY1eDmdkBNH
 H2vCXISo24ppDWxiRBV1O9wwqhUIZsyQJvA7CEcNi83xCYOxb1ZoDBibZzUdf0NsHMLctMlQsiP
 295KudsNKC21HjX2kLTZTWyEousJmEKgL7cv3oqstDcrFUA4DAme3RIpSqacE9Cu2CmPjsXW8+N
 gNZSHX3kezsvbyvMKUni138eFAyrY7zUBy87H4KwIU+/M4rziPOfePBkMEYGJfpQYh7RYbfZ/O8
 8Dp98alk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
> design platform.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

