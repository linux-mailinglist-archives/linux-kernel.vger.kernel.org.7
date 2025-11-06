Return-Path: <linux-kernel+bounces-888451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A698DC3ADD4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E984E3B25BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C0324B09;
	Thu,  6 Nov 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HamTd/yp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcGDDnWH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F183254A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431296; cv=none; b=I/e1W46TDmzIZC0LGNnvJGerKJTMuf0EtJ82YZfh239fCXPfHcyMvye0AbetP2QYVhXTaoEsmR/9L/9y4Df4sy3q9PAMtjRMl0a6w5WtHuUktNc33YDDwrX/L9gaZ35AyKF8NA0kywYFr0w5aCAGPJ1niSqduuL2BQv2YcqL1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431296; c=relaxed/simple;
	bh=ekKRVsIQk2yTIi2O6W8XgAImjp0Xet2F/XBpm8Quheo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEbv99U2lJdQt0ZQRinRGB2JbuCM4CZEJnLUREXJ2Vt7tG4ICPY0bmFV3AFopLNBDEt0OSvk+g2s652KZf6VCvAE6Y8sLoKXYSq5AS1WWs8/xOiIPhYMPbWXC2d4agJ0eSaIOx3Wtli9HvN7as+UfidpaHb7f8DTeO5fQrbDADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HamTd/yp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcGDDnWH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ASkqj3748580
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 12:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JLXA08kPYaUwpSm1uwFgestSzsTRbCn2xW73c/Hiq4g=; b=HamTd/ypDv1PDxKs
	pTU3tAaf9V1Ft9XKoViWk4FUJ5JCFMbLTXfB0UeUVZT0AbcKDYneC1JNm35wfX40
	1AgbJ9QO3cR3ieqm3NMzddD/eOcfW5UQG4ROgN1CP1YUBoM8VWgAx+LqJ071Zou4
	1BWV45APvi/ciEblgvYuNgapYbrT9KJFj2qlA1yYSEodUFN5Cj2rkD3SyCN1oLgC
	pUnGQqwjLrtR2ZshJOF/eOmSmF1tVrGcvCYj4LYAvRUGqMq9aTWzRS84eymC01BQ
	tulALSEutN2ULunCHNv6PBGYQe84KlvzSsIBy8ingQakUb57Jxt1lHv2G1zcM8XC
	shr5JQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6g8dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:14:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b184fa3ffbso10360685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762431293; x=1763036093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLXA08kPYaUwpSm1uwFgestSzsTRbCn2xW73c/Hiq4g=;
        b=hcGDDnWHmZefrNjC53xCdzaHy97XchqWMc75ggWypX5NQY/JsQT1OMKYoTUj8k1Pw3
         HrvvokPsA6dFmClxhZgTF7utxajfU0sXTj72sQ7Z3cf+nzI2WlT0uT4uXNqrsTwW+gcv
         v9WqkgdcrAwNzJHUsJtv6hiZ5cBHxkScabDCsGjMCCxaMbmRdC/4Ls0i6CVmfgC/xbhy
         HbXigdd2I2PvwkrXBnKmyrfaIb0fMlWvebHDtnl5wLVhoJNEgLhIpxbYO564yyfupXEi
         oR4nTx8gr+Q/t4ndZ9JOFuQTxWNaN0KyIbT2K0e/2XR7yRWvln8orxIR0Vfj+Fhhg9zN
         5TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431293; x=1763036093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLXA08kPYaUwpSm1uwFgestSzsTRbCn2xW73c/Hiq4g=;
        b=H+dmiU1UD1wnBDcOvEiqra8f1XbbbD7Yv1WR6msZrf50X7fYOqCToU6Bg7mZHsnMdU
         7b8troM3LtWJQ7GP8XBY81wv15THZGzK/GsRsGGKwn4P4bKxIc/StrFuKu6YjYVtCL18
         w1i+VK8DciMjAyIs1H34ieHve+gx4voSMTZJjJMcDrYF3s/CWDSqTlnfBtBBWNNRdZFt
         o/HqgqMxE1e/ngc7nAC4SmyRQ7ZgBJ67AuqgTrNDbYz/cTB1Yq/WWnBzOP4Lt0H7k+Ti
         GmSPMl+QqOmjU9xTLuXmMX91+b3CH5f1tNwmUBFKnCVRDWTzza3iB0Nk8KjWSRSr1OkY
         koMA==
X-Forwarded-Encrypted: i=1; AJvYcCWcHSlAb4ahmbe64LyVvxWr/nVZ+ONdQpxBJMPU8wuxbxJX0G14fbmrct6HVu5TeMYgxGPJp9ITv+UD+xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05kmVMFl/KfkYxVHQt9HivMo6azOuyeWncDGf5EJMe2tlmZ/d
	QE7+t9kYZvEHaB9XyVveTcDtQLZQdxXI424DwFvleD1DXOBQyteWZOvzpjDrri6kRd4tPNE99EJ
	OCxpQeQ4wBStg8FrL/WL6cz73uZ8DM8z+LDjuHQ5i1VqJvQLeTfhd08NyXZONCW5HnmI=
X-Gm-Gg: ASbGncvl72Nv+0DbAIu2kWqkoGcs4Zn80XDe2QMqwQNbPKkpuABIBBgWDdN4voA91iN
	NhvistGr5XeNYKpfjSRdGrZgcISdSGf2EFjGSH+LrC9LjC/itR9jSXRBmEXaci1KaIPZkF3VC4f
	RcBTKX4IQYBwUXds+378RGKsHHPDRBVEMOwQFxr+9nJHrvwEzI5DKmhX8gsMUyPZ+5XZ4c3sa+8
	5xSeJiv87qCPpEb0pYZEGkpvzmMl6qbCabAK6DwUluuksf7UiCVOHPmDICLm7n0cqDt3/y3X/FU
	RG+ElmkhyiWk22ZD/iXGr5LTcPAymKgkntBkxfGvNuyEPLPVgItOoqZgSSRYJkzUx6qIyz+povO
	yxTYpFnzD8pkLuT4fNJTU/gNGn0qIHxSTwYQKzS0GRM9t484qG4Q+mc3J
X-Received: by 2002:a05:622a:1190:b0:4e8:9bf5:5ecd with SMTP id d75a77b69052e-4ed7212ab6bmr51316541cf.1.1762431292983;
        Thu, 06 Nov 2025 04:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbHbT2S5J7YWDZlDRXl3mXy5NvTvkRuByNb/uQnt5fhSTJ+xry+0wZ84KARasofcaWgtF/dA==
X-Received: by 2002:a05:622a:1190:b0:4e8:9bf5:5ecd with SMTP id d75a77b69052e-4ed7212ab6bmr51316331cf.1.1762431292468;
        Thu, 06 Nov 2025 04:14:52 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c7e39sm202861366b.72.2025.11.06.04.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:14:51 -0800 (PST)
Message-ID: <ed1e6e3f-946b-481b-a183-c39771686c10@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 13:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Treat PHY as optional for the new
 binding
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
 <20251106-pci-binding-v2-2-bebe9345fc4b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106-pci-binding-v2-2-bebe9345fc4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690c913d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kYxvmccDk0iZALW1rmwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5NiBTYWx0ZWRfXymDtG7cOKneF
 OLGIy5BpUI/tFIV+rrVAj6Kcp+gZPYEcFOE38+DfYeE317FvS+BUtPK9JCbyDJcZ0DuU0VaR8lg
 w0fRgARwSz+vItGQRqE/YDlHG+KIPOhy8uqxVqPK6nQZe5jN3r3LFppNWkvAesovl9Yz3CGHX/j
 OwPcEtejOHAe+r6IgLAGDt4MZ/e7KhJGuHxA9PaIxAyKzQ8KnnuC+IVVkN4nYNP3F81BjWoSVHG
 6M4+xP/Vhbktd5aufBWjy8O+/f2cj9Z5RPBiwdwcS146fNFgBqI/u1stZ1fwOU1BpwxXbbozcIs
 oOpc2FvdpytCU1wd4GO43uJcllhu6cGqraCHhfukaTec3ncuBxCT3Y8c/mADq61gSVGztQmjSvS
 GQTrN64+6uvYG66s1Ij39n6sEYpipQ==
X-Proofpoint-ORIG-GUID: HhVyDGr7Zc6Uus37V-62kGWIWervRTNd
X-Proofpoint-GUID: HhVyDGr7Zc6Uus37V-62kGWIWervRTNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060096

On 11/6/25 12:27 PM, Manivannan Sadhasivam wrote:
> Some platforms like the old ARM32 IPQ/APQ platforms do not supply the
> 'phys' property in devicetree. Hence, treat the PHY as optional in
> qcom_pcie_parse_port(), so that they can work with the new binding model
> of specifying PERST# in Root Port node.
> 
> Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Hm, I suppose they must rely on the PHY being pre-programmed then

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

