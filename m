Return-Path: <linux-kernel+bounces-883184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A7C2CB13
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF54F98F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056231A561;
	Mon,  3 Nov 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h5XRBiMn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2LUeqO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76D314A78
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182642; cv=none; b=EdjzpwNGEHyTliHDdxBbVLvv/SsqQ3vAXH64PMSJt0ZJfijty9a9d6IN2YyZM8vBOP0rNlb/1WwwtdhqkppsxOkuJUBoG1+rVw9IlvF2GZQDvpKk7A8uJERWlqvFJ16ipfQmM5bW477RTVtP00DBHYaAARFf1Dhi7+vsj9C7AtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182642; c=relaxed/simple;
	bh=TBKnHfAjKl2ppaBTrHo8XUhddBKvleNXHX7YIvz+Vks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AC/wJuBUdzOokVnkQXKwysNnuHcy/M5dU7e7yFmuCIaXaDvx6sGa1mWgdrHBcGqHbk6g5kfvpY1RGb9viefPJq8RTKM+kr6bVxV6ILJnrhnBlzu5k6RGPYRYwW8OX3BktVNLkUn7eNsQHDrDeJF6H3PVALtlbK9uheSqGMFImIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h5XRBiMn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2LUeqO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B7ZSS2984015
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 15:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8A3ArCRCRZvjuVlwNozijUVtgXW3fKedq0/+bH1wVyU=; b=h5XRBiMnTdzCOert
	CSpYbXagMQp95wfOIY7F1YBzJP+zgyNmWp7Z0BUNEtmitaYTamVNTW5wGfUEx3wc
	hUyAd1x7PcKsSf7a3ZoZRLgevUL4/wzCL/9PlxbgqKZzOa2Ksz6b0t9lKGbsP+2c
	gdUkpJkVSRh3vIYqmOcVVYWNBycNuXe3FdQ5Fjd5nrVsEpvLpEDbzn8TsKhrKiYy
	W+fhIACm2OCpJpBcGlrAl8QFSj6qlQ4iMYWHqAphryw8RuOeEsosG3UeaeGK6mPl
	/Cxe4Ykw43NxuG9/BhEtkrA8VHUiw57kKD2PAwNjSVWvUoyet6D3aT78NAzcjHNS
	jEYq/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b0keq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:10:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29554d36a77so27047575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762182639; x=1762787439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8A3ArCRCRZvjuVlwNozijUVtgXW3fKedq0/+bH1wVyU=;
        b=X2LUeqO1+xmIAXfvIXQgrumYMx0wBjMrmGTC8N+JCh2lJV78Vq5/jh19KRmF6YoQcH
         1s+OmUxH4TTq0Z/vYvpPf1aXK1QCgHxkrww/pk8QSrLbx8vjHxbAJ+By/z5w/Pg0FJWj
         nYveVdzsfyuduhP3Re/C0kU5OupXQ5CQet6a/dIrb6Tfh+pvNRJYcHvscdxa1E/jAwdM
         gV6r55/b9MmGl4fChsiA9YnPJRkXIQM8IQie95bSN1Mgch7Mwots5nD5AIypg/jlge+p
         mpHZHD3Ms3ov67sq9wu3xz/rsEIdwaJCLDn3exnqELnw5edtNltbtbj3Zys5UiDKN9DS
         dpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182639; x=1762787439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A3ArCRCRZvjuVlwNozijUVtgXW3fKedq0/+bH1wVyU=;
        b=EIpAKWhpjvSnMcq5du2W+cizzLV3EbuPGUsLxUQK0cKFLz8efa4y+vBE2wU3Y2zb90
         ICVudSrPp/v5N13L85m8Y9EqIdwcmvQAi7XOKS+fUPLSvdUaXNiPq5n2xlLNScAh+TTt
         UeGw0LSSfQaFPT8pFJ5OPE6JTOzIHiMY1ERcE2YKrq4vFVPpVAksj3E3ujpz3ANpK243
         HJOC+cnAlPD0a0AZ1x9CC+eGlxcfyN4i0UWLmPCuVQIGHuVWWf4Y4cqzRgE7t8qVIZSw
         F0QadRfsNU1rJzNs3vySxCxvEPjuXaZYDormMayg5b90LHqnuCm9Vb7KGwAul9GB+Fwr
         cWGA==
X-Forwarded-Encrypted: i=1; AJvYcCVw92/K5jmkf18ebIJpeH1/ZnN9XuJi+iIU2ZMOf125zYYdvd7pTHVHRoRi3XhM8HY4zrfMNe66iZ3OE8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByGegzZciv9Lop8AoFkMkTqIR3n/PC+3Ny3lBN2tWPUKBICS9
	54jJ4xWWIXrg+6IEs8Y8Q7ZvZkAY1f4Bjr1QSscYyQRWxjqr+uEV4dYQPUYO+TLARjFZob7Wwkc
	i3KG5dj/kvFOa+U4A2wjBxUztWZmzGX36PkDAVxnN2bBWd/GU2bzxa6m7o395PEBqGuE=
X-Gm-Gg: ASbGnctzzKGO1j6WDZR2wQDB45NaguT2yzvym8+NGkXWceBpu9ZwpICrIJml4VctzB7
	2sGXfF4Lob3w/GTDhyLgfbqHZ1Efa60mpTgeXwdf7solDqsKid1H0WOX8wvQjdHPl0b9K8O58hR
	MFtivk6BHR51TaifMKrOI0bj1YJSzj5DY9LLghcWtesuXUYZNxUiqq4hUdeYRW7x6QNG52lTc7P
	AGZdfr+oOVvGj5CiG6n5nse5R3fzklgEj9x68YUx1czP4LYtZxdKarWFemEMbsE++Nfjqw7mFMk
	NstKpv4Y14kfWSsX1Mn1gVhWH9FYHOkVdDCAqpLyrwRS8+4vCuY7ji9T4gRJlm2bemEFnVIicbl
	flhIioUnuQCC/lldmn1TdGg==
X-Received: by 2002:a17:902:db0d:b0:295:2ebf:a514 with SMTP id d9443c01a7336-2952ebfab79mr133843535ad.56.1762182638338;
        Mon, 03 Nov 2025 07:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmJGKc74YxWJtzu79C/yJHL0moK9Q/+vml8R0VgH1+FevtH2JLVIgQZLv9SJFbT82nEI/2wQ==
X-Received: by 2002:a17:902:db0d:b0:295:2ebf:a514 with SMTP id d9443c01a7336-2952ebfab79mr133843035ad.56.1762182637764;
        Mon, 03 Nov 2025 07:10:37 -0800 (PST)
Received: from [10.206.104.82] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29557bd3679sm90327165ad.87.2025.11.03.07.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:10:37 -0800 (PST)
Message-ID: <fe210f0b-692b-4c45-afc4-fc2bc5e57854@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 20:40:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Bjorn Andersson <andersson@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
 <20251101174437.1267998-2-krishna.kurapati@oss.qualcomm.com>
 <f2724aed-c39c-4793-9522-bae08ea97a05@oss.qualcomm.com>
 <ev5gosxqguzdbufy72gcjmt4m4z6kc67jcaznrhvvjldcps4g5@fntcevrjpqsh>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <ev5gosxqguzdbufy72gcjmt4m4z6kc67jcaznrhvvjldcps4g5@fntcevrjpqsh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEzNiBTYWx0ZWRfX7Dgn1oxuX5Le
 NeuFSooVnLgBsUDqnbdqqDbCd0FvDh8SCnFeCcs3VbVJzJRLIPWvFA3bHo2W/BtEh147AtYFxIY
 UIDWd/CPIZhz7hyJS88iKe9DyUzJHySGaCuHBvxunzYOWv9K7YfamWejbC1XbMWoTxNTfCMuBTL
 YyUne1QCFi6fZ43XneQfA50M6ejnNwxVnzb2JUqbvYZMCbeKdpDh1YQ/v1rV2JvBYWBRVGn8iIl
 mvawIB5PqNvwHeCCd2l+2YrGGT6Xk6Q9K5ZhpqYTKbE/Dqoe18XYzBFjdZxOZFO8GHrDhF/Jbyb
 d0Qy0KmW+oqUKTDbep4pitVk/S+ekl3ejZJet4OlfBVxO0oeNuoMwmRxpi3iV+nxWwZ/Vox5Gxv
 0BYbdMGIXeFt6lx0/Ojvt+Jsp7T2pA==
X-Proofpoint-GUID: cklR9R1BXvzlU35f9PYxrZp5dAAwefRy
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908c5ef cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uOomqL60Iwva-KOcEcAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cklR9R1BXvzlU35f9PYxrZp5dAAwefRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030136

On 11/2/2025 9:23 PM, Bjorn Andersson wrote:
> On Sun, Nov 02, 2025 at 12:43:07AM +0530, Akhil P Oommen wrote:
>> On 11/1/2025 11:14 PM, Krishna Kurapati wrote:
>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> [..]
>>> +			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
>>> +			required-opps = <&rpmhpd_opp_nom>;
>>
>> Probably I am missing something, but which power domain associated to a
>> rail is scaled to NOM corner here?
>>
> 
> That would be the parent of the GCC_USB30_PRIM_GDSC, which should be the
> CX rail. We currently have a NOM requirement here just in case we're
> going to operate a SuperSpeed link, and the driver doesn't scale.
> 

This is a bit concerning. There are other subsystems which share CX
rail, including GPU. So a hw spec violation on USB may impact these
subsystems which would be pretty hard to root cause to USB.

@Krishna, do you plan to fix this with a follow up patch?

> 
> That said, your question is very much valid, because on SM8750 GCC
> doesn't specify CX as a power-domain of &gcc, this vote goes into the
> void.

So the fix is to just add the VDD_CX power domain to the gcc node and a
gcc driver change to enable "use_rpm" flag?

-Akhil

> 
> Regards,
> Bjorn

