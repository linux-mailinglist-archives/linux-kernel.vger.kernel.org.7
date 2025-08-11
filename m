Return-Path: <linux-kernel+bounces-762517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1696B207E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D06B2A3E81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4792D3746;
	Mon, 11 Aug 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBJYPqC3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A62D3725
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911667; cv=none; b=djAlHpUWyWrbDmplLekJrVsZu5k69rfiHxc7SHlasMYsKWKWlcDdDpI0c+g5pOHOBt2EeRoODP1dsb6uJJNHsBpwJfdvu4z7oVy3QY/e+MYVzv0WweuKyeQ7L8wGiTdxw6DpO0+yrgQT2dNQDJDcxyHwVNNIUggMzpckNb1tdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911667; c=relaxed/simple;
	bh=U+J+XLR+6ekPSZrj8pxsuPqEj3REqQNGk7AxDkssPmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN0yMLUGNcoIQ/NhKZ3aLr8hOVzixAyIApzQHxUMxzWCV/bT0xizpWp8YxW4eZcUYskBmTHf7ODmYrvJ9W0DHVk2Aq9X1x1QcoJw97dEzfGzC3U5zxjNDTbcHioPTzIjTnJV41AWrU/hPOyeAFNjvgwVl/kp1QhqgAbkQGCLU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBJYPqC3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9vJ007563
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5fyLS4N2oFmF2UHiHGCjHJxCE38PIq/B8p4f+c32zQI=; b=WBJYPqC37sqXjgTJ
	zJ2c/zO11jThleKKz5jYA4agRwC/ZU0Tgghvp7SHMuvN7Efc7lulsqxe3VtarRrJ
	PjBdm3FfZ60ydGoEs647Qa/pFM76G8mebyFEvZYOfOijWb1JrUfQGqPiHw8KjenH
	/cARw3yK+w5B6PGtHf0d+7RRh0KWLqJl1eMRZvO3p+on49umkL3jPlZLbfVk56UA
	JmCzkTWcS0BiM2LgpWxDXBRzie1j2ulGdqXb3sEp6/leZNX6+ZnZ0XN3ojFCLTMk
	kqJDrcl/XNQPL4HBL+yz6mZJDLilsixIQdbmK1RITcUWlKBRcJpVo+unXVUMyMs+
	JtBFVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fmct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0938f0dabso11615991cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911663; x=1755516463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fyLS4N2oFmF2UHiHGCjHJxCE38PIq/B8p4f+c32zQI=;
        b=lsYwCIX87E8yO4ILrhMJOe67/6BJu6c61aNC7DH50KUUiBTswtN/l2YCv6b2fgtIgo
         VuIamx6zycNW6ZM8psE3AnZK4NsXtC6zUXc0xsjOhQHNbKT4DtCSd1h3tgi1cDuzZ5YG
         GLEF6wqXPEgAAP6TgyLk1T29xrab9qgRf1QUkCz/FoB8kM/it8q3g/50X1HSo7lMgcPX
         njuILceggugm+uKmQ2hYvyFtRy5aXQt9QLOfUIivWNvqwpKKi1iU+eSwF+FiPXcDtF/a
         H80CpITFrPpXBRUgildl4Hwhd5HHWdz+R2jpggvxDhsVTRJoGg2p7dgkfDkE4O1a6fWU
         H5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUCmeao06afIKL0Ymomo1sJljpWk53iCtBW+hNlRZp66O8pfO77E+5rhUfz5q2kY+czklZ5hHH8mkoEmGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47arAoRiuR81LlhtOtxTB1Gr9Tccz/SrCu6ln/YcKmFF8dqTb
	HUy6MgoJ9i7v5We4eC5TwZrn7S23CKyL/tLW9Xnc5t8B0OB8cEPyAC8GgU63lRC8tigQ/803lla
	TVWZkgZQx5AK4ipI32MNeu4F8k7n2f8TCnnlGQKmAfTwqLn6gvXTdFaC48P4NIB3qe5M=
X-Gm-Gg: ASbGncvPZTg65Jxx7s35SPMzutwkV9aX42/+XYLNoLpnDxHJR77QKo36d4lB06QL4Mc
	PfUgL2NEiPrDYBfZ/i8QVK6sTWCOgrR4bqQipOrmsjSLBKdgwctMWa5VBlx0W9QjBQZlLMHUysE
	ypcj4RlUQ1v3a0NrwbuZ/T27LIeWDOZ8vDj+mtXfyT7clyhjjK8o8Er5CpBYy5VoU1UEVWuboXw
	C2WyCFLbqEUTQAo2Z8xW3qudH1oiBoze65cRb/2Z2fg3QpTe6qViMSoOxnNSG1/KFxf94Fuo74x
	g4nbNx8HsIpf0AdkQS7dx7BqNLIyrpCHd7VbN8sxs4zAd4kuftmwUS9QctDqXBvcD4NkwF/JVSZ
	4hjT79ovx8r3K9vw3ZA==
X-Received: by 2002:a05:622a:44e:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b0c18ff1b3mr53726811cf.2.1754911663308;
        Mon, 11 Aug 2025 04:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJgFSDOS5fEjCuyG5NolkHlckR1ubFRcXPAOC/JGl654XR7C52OV8G/dlGBHR8wLM6zvgBnw==
X-Received: by 2002:a05:622a:44e:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b0c18ff1b3mr53726531cf.2.1754911662717;
        Mon, 11 Aug 2025 04:27:42 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af93d62bc97sm1729893366b.80.2025.08.11.04.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:27:42 -0700 (PDT)
Message-ID: <bc5c66f5-2f75-4371-bfc0-452d69bc16e9@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sdm632-fairphone-fp3: Enable CCI
 and add EEPROM
To: Luca Weiss <luca@lucaweiss.eu>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-msm8953-cci-v1-0-e83f104cabfc@lucaweiss.eu>
 <20250810-msm8953-cci-v1-7-e83f104cabfc@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-msm8953-cci-v1-7-e83f104cabfc@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hvWTlKjKSKD5xQL5D_82CUWetNEZpoJV
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899d3b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8
 a=RAyH1-HTb1k6rVK9-NMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=y4cfut4LVr_MrANMpYTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX23F4rLOVnTAd
 wzzwHm6/IoF0qddmXnPEVdcM1H+dFbp5daez9fv4HdS6NEVLImwNzYk7DUtscj1nDfXRIBntILC
 1+PzhMHqlHniTRKKweE40RRwYfDcEf5AHiDHM7I2OrR6UXz89BYzLq1onjLKiGvEe8irtEkRFV9
 rmuoxzbM0xau/dFYJUlhYF0Isu2sJeYA8RgNqRE/hlwrLTR83SFiX1JptkpBohigkGsp/zZR/l4
 ogF16JC/sSiAzuPpnja3hEtXqBNkzJvuy15drsiG6OIEETLo+q5nM49mJqO4mg7wDRy/lQS2VGl
 xSuPcRMR00B6UYjEBj+z5q52L5Bd2teDKpn5l58+EufzjfedZqPzuh77/mEu+jXqm0FTjooZfaD
 Ggrd/Z2Y
X-Proofpoint-ORIG-GUID: hvWTlKjKSKD5xQL5D_82CUWetNEZpoJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On 8/10/25 5:37 PM, Luca Weiss wrote:
> Enable the CCI where the camera modules are connected to, and add a node
> for the EEPROM found next to the IMX363 rear camera.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

