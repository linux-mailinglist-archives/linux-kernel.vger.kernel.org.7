Return-Path: <linux-kernel+bounces-816206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE8B570FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE63B8BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6532D373F;
	Mon, 15 Sep 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlWe1GND"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5152D3209
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920441; cv=none; b=NSUGxLD+OsVl731qbFHxttOYHVqcF+mADNhtAE0Dm9Eg8s8ZOlxDGRX3o+qPLHwnzu9nLsENpSA6LsyCyrz+YfJ3zZrSbvEKrgg0FsAj3PkaJZPV+HmzNXob2elAcgvcX1HzJehSsTsYaZG30h4UBc6IA0h0a6fCVClCNz72lYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920441; c=relaxed/simple;
	bh=+qi+uECUZ98pigQwnsb5bPSO1UgdPNw9iBM2lA3ss8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0zWL0IVrvj0bYrSPaI8+RDKRIWpuEClk1xrw/2UTyPd5VZU6OK1TQmyEKU9W7k7hDKxFWpvqYQ8H9nVgaiouldE9efHaDMJ6AIJghuLhT16WM8SAc9DvWcM05b59t2BmY3gZ3i8v6TJ7LrPixW3R6q7aCGMkWH19Z9/6hQ0ms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlWe1GND; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ELjdwm018441
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	emyETxTvEXx2mZ3XPuIpV3lp2jjKDrPuyDEjXKQ/XZc=; b=IlWe1GNDLj9PHlzX
	0NoO/JtNnK4kMpIJb0b53/nibupAAFIrAKaTWRY0L+GuJ1J8oTAlCl5WHG8o8gbJ
	VoDc+jueQd2m542UD5v30+1lPd6oYEncJHffItnpxKxMdZaOwjHhWDPjWT0rBD5F
	7GImqbvQ/Er/cH5rK8cpcFG8vQ9oDW4NwHm+rr7y6biXLFCPT1CRzTRoOJY6/zgR
	5ll/hBZnFfAWaSVYWVQpU1S9YkVULmVbd9pe7BUqK4AnVnOu+mX+bJCRBpD8jws+
	ejotWcadj837X2Y1PiE3DggxSKkChPO2CxYd/LhRE58FIKv9blnz5OZGIKThnbTM
	SzTkBg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma3v5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:13:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b79d4154c9so4913901cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920438; x=1758525238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emyETxTvEXx2mZ3XPuIpV3lp2jjKDrPuyDEjXKQ/XZc=;
        b=rBvgWJBz+0H8DJ2N6HHo/5g9A84Su4ZsIBc8ipz5VfNAzdZY+OkX/VkO+N+93DCjuX
         dkuu92SoVcIWZDXSlJS5Pum0AY9ZeVovounVINX0mLIOS+4hSs++tw7i0ZmwfGb5/1cb
         2T932aIeFG6sx3u77t1OeBNJyC2MVEMNpXXE5sMCgg2ZGB//0g5N2eoVD0qxFZ6HDMaH
         74MEKzGW1YiTF2SQJbWZUumH+e5CfAVNtJtvtb7AOMDBL6m1RfY9YetjLVel3dyCguWO
         Xr2b0WLEfV47NgVJLNohW14uds6qj/uVQHf7gq93Hbh08vxpYAnYgub0/I54QfUpLt/4
         We/A==
X-Forwarded-Encrypted: i=1; AJvYcCWTIVUZtkLylJgjKngcokB2hwqjJBZI1EOO8qY/s91cmLu9SnKqCR28cBHg4KbXa5XYprOqx7AXM1GCiZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv/Va+/MrKy1lE7btA5wjV8onKBDEk+ZwCIJzfv1G+58xfDEt
	AgtbxQNqUKNiYc52lQdvr+kg70W1hI7DuRWueOOZyVLEJDiDqtpFTjv/Spnshhe1GKZRR7ylLbh
	1BKf9ufdZ9lZqHo6LwQK7Y2HXkpTvcVrwvPU+eC7NSWwxmeSLVaY2kxpnFvZeqDOfwX8=
X-Gm-Gg: ASbGnctDA8crFNDjTkwNyg/EjCUAju7URhCa8hrV0zoZf97zVSMj/FnLz61NSU5lXJs
	04Gt2OWzOMEt4JPXsgCXGnbNg0nqvZqZZ77FkkDJ3NrzSnWa4FDaVp3YET8tMP8BYTNjhZr/h21
	dGFIIZzMnOq2psi85nQaNGd153Ex75zwRD9omGyslBooClRP9sqU6O/oghpuaa5wddfd5UNG1zS
	fFeykjF0z+BuNiO4VCmaIsmO6rKpO1cCTWhAKwTBqZtZKlmHXcj8PN6X/lZbPAGpGVfphuEDsyd
	n9pDdfgXhRYjVkSlPP4SD0gG6xDfTxWbaSh65JPV26mshpDYStQrOk7dwTgb9UvI5rPg7wxWeyu
	CYmuXkHZaXQbPEubxuv4V2Q==
X-Received: by 2002:a05:622a:1649:b0:4b7:a71f:582e with SMTP id d75a77b69052e-4b7a71f5c59mr16755181cf.9.1757920437786;
        Mon, 15 Sep 2025 00:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXY+2EbGQYmMpg3d61biZVOZwP82Fg9wIo5OW+2n2MKk9HCpqgiBtHZ7vUG59dorC3yHP2LA==
X-Received: by 2002:a05:622a:1649:b0:4b7:a71f:582e with SMTP id d75a77b69052e-4b7a71f5c59mr16754901cf.9.1757920437037;
        Mon, 15 Sep 2025 00:13:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0bf0334ab0sm349700166b.31.2025.09.15.00.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:13:56 -0700 (PDT)
Message-ID: <9557fba3-ad11-49f1-beb3-d23bcb87fa18@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH DNM v2 3/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable all available QUP SEs
To: Krzysztof Kozlowski <krzk@kernel.org>, Xilin Wu <sophon@radxa.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
 <20250914-radxa-dragon-q6a-v2-3-045f7e92b3bb@radxa.com>
 <0a766f8d-657d-42bc-b3b4-33997b919d7f@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0a766f8d-657d-42bc-b3b4-33997b919d7f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX0+P8T2wMPYD2
 KBhs7D42+XTTYaVldM19fuFAMxM3gEU1XtM33bPZpf9fawHZZoFoSfdM5F2fLdwv1YMQM7PQnvQ
 s2vI3f9+8j5Wt6BaKB5ZJ+1Xz+Z/8g8ZZrTleS78PfTc5jXz4Y51cYS4FZGPUG4YMsXGJsDnqvb
 8b3S2JAxgvtpkeSG7WQ5k0ZTTWHYVcPkORxoRKWM/6mOob+guJMVt1ZMXs9m7JbON+8ZBbSw75a
 Y3Lau7twPou3yDfXF1P63M21zDmBmyb/QRe6Ib6UAm1bp7Zn71yKq7tJSacK2GasXy7VfpwgNk4
 gs5TzqL+xa3+zUuC7GjE5uRpXzy69n8cQ0r969uyr3KpLutVlCKE1HEi3rClyNbwyaPqJv/jb+I
 YFksOFNQ
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c7bcb6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ksxQWNrZAAAA:8 a=6z9ov410QEpJGwptJD4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: RjjRTq_hEsYcbPrIcqsa0bFV_EJhhhzJ
X-Proofpoint-GUID: RjjRTq_hEsYcbPrIcqsa0bFV_EJhhhzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On 9/14/25 7:36 PM, Krzysztof Kozlowski wrote:
> On 14/09/2025 17:57, Xilin Wu wrote:
>> Add and enable all available QUP SEs on this board, allowing I2C, SPI and
>> UART functions from the 40-Pin GPIO header to work.
>>
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>>
>> ---
>>
>> This change depends on the following patch series:
>> https://lore.kernel.org/all/20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com/
> 
> 
> No, why? It does not. If your DTS depends on drivers it's a mistake to fix.
> 
> Fix dependency or squash the patches.

That series also includes bindings changes

Konrad

