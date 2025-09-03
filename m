Return-Path: <linux-kernel+bounces-799040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C6B4262F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0834E7ADB00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D02BE633;
	Wed,  3 Sep 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="paMOUG4f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70642BE630
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915328; cv=none; b=kNZFEDXgkwMZnU68aqzsyYxFqmYCL9HTpDh+oQvdsTg2C2Yqj1uZTmqlIAHkD1GlrBJBnVlzdVYwf5LdNBgOiqd14mZfSVpD1xrQ16YPdtjPerjHOnqMrxSGOjpGl8DIlgptL53eAnoxkZOEBuv6uOdC3jLFzXWmCtW7s7W4Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915328; c=relaxed/simple;
	bh=duCAr7CO/N1Ze4ijxMI+nhb3sedWh7XRQtNULBNw7Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB3Ge0Kru3/jGzdMSnR/BjTn7UErhv2TETuf1Y/cR9qP+onjEq9RqVGN7p+WfyMkmbRCRiqdfcskMhuDTomLYAdwLnYHLgG23c39wmUGSoVM1XsEvNzkdu+NbUdKxUWdhTgGTgQ7y5Y7Ke1G7dxKEDlhBwg3O/S3DYcwpBGen04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=paMOUG4f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxMVS004224
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufkKfMtF2sFaOT1A75ow461HdClQcHWGVHzSfn9/S2w=; b=paMOUG4f4olZvDlC
	gma5g/I5WSNuYq6qS1l+Xt6+llYCURDMNeeKgTlridcomHF2zBXLevGozYUQ6HdP
	8Zyl2KaS1A2nShuiQGZcOjMzi3Y7JEU3y3yjqAvl8vMvAxLxVU25QWGajl2viDag
	nUh+NH31cs1QvoiV0hQAo2DMIp5LcEtZ9OqCSzpLk6kYCfrSd8T5yrPD8oAaMroa
	uf5OTH2qi8QLRjthJJPE7W/XASU8xBxDzAqzWNoo2r5jPxzs0JD+1VNt1tzJJhi2
	VshNLVDDR3CD3+AaHAX96YNNYnpYh2SFdiEyKokd4j2HVom68+vlgNj9L1nYqdrT
	o3cf6A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8v7nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:02:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-52a6b02c954so3015137.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915325; x=1757520125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufkKfMtF2sFaOT1A75ow461HdClQcHWGVHzSfn9/S2w=;
        b=KTzrcExSvV8kNAAP2uuTz/hqOJ6T8zUxIrp9XURAcLZ6zwPkVjOc2K1/fH2XTFjeOZ
         qLgFjZ/y9M5hwgwFxhnrZHxqaeRbTM9ADJnL2y7G3hvFSNb3HeDLT4xFpv/QH00wcnlq
         PIZicLuH48acgw8VvIw7llnkH0GyLK23H+5PZeSrUJfxv7m/Tedvl7BXEzyBe18/qcox
         ZAK6za+SjpRA+g7Wo0xLQ3xPKu1Q8CYLh3brhBXYWwXRUPUZh2Jxe2NCDM0pNo6uV5RC
         tAnlwN3hneUlVWgmXRngi2R8ivw9QiDm3oJL2BRZ/SDGCVEpr6dVLuwUByfPzcOuGPnV
         b3fw==
X-Forwarded-Encrypted: i=1; AJvYcCUohQx+NHYqBoKJ72bqPuqz1+s39imFVhQbqTAVuvhUjEshKyULbJR5zuI7fUBnfOe121GVlCIFdLwIbFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjMzIZdw6qWQPH/EnrxD/eIhZz3VnpTlFI2qduQ81swmDsFFf
	ZOdOzX676+sxyaMNORmkDuWvDktlh6s7et2JzZXM77iLTW/UZWgeQwpoUdzMcsKiYdDQT8Q/GvK
	SIiYFaj+yj7iSuIUFIZWetLBgZwisp4y/bjHW6zQULqkqp/axQdWCPQsYmYbBdq0vb1o=
X-Gm-Gg: ASbGnctXL0xzYDBwgEbbxaPJ/oYrqF4eqm9XV0h4mtMucW3n2IMDom45beGQgsBszy1
	U0Gp1xeoIu/kEgI1SrQ45k3XC2xsHnZkB+y3i9/ZGhgUXnQYyW6+tkp7gQKGk1Ka9VvdVw8GzOJ
	OzRTa8L7SIUqV5vIp6IWYXwNirlOtCmxDXWRYZ2rF+FPLqHa/gg8/Sv7nEZ0WQoH8E69SAsKi00
	qYi1wjWX1bwgYKsPyFjSDffO/ydv7S5JflN8SMPrtSPxv2/bzb1v2Zfho6cChN/VwUeMmuV6i0C
	pqsFxWyIahWvwGJ47P5obJb80BO+ue1hP+EcbjDUodzPpvX//8XFm7imURBdtQNJeGk2MaxOSOz
	1ZALS08MHhnAHqPxfrx/Nmw==
X-Received: by 2002:a05:6122:2015:b0:544:91a8:a8c9 with SMTP id 71dfb90a1353d-5449592885fmr2297766e0c.3.1756915323621;
        Wed, 03 Sep 2025 09:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOwCrprQOUcxuZaV/B20qgOB8K6FfIsDK3UCpWlIJhUbywwkcF3iym3uiTsjk25+FxGpDqA==
X-Received: by 2002:a05:6122:2015:b0:544:91a8:a8c9 with SMTP id 71dfb90a1353d-5449592885fmr2297638e0c.3.1756915322699;
        Wed, 03 Sep 2025 09:02:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7dfesm12285170a12.7.2025.09.03.09.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:02:01 -0700 (PDT)
Message-ID: <ca2b6089-54f8-459e-8cc0-accf802026e2@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 18:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: ipq5424: add i2c nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_msavaliy@quicinc.com,
        quic_vdadhani@quicinc.com, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        kathiravan.thirumoorthy@oss.qualcomm.com
References: <20250903080948.3898671-1-quic_mmanikan@quicinc.com>
 <20250903080948.3898671-3-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903080948.3898671-3-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MWmw26sZGL23wIwqaClJTc3XZr83elDv
X-Proofpoint-GUID: MWmw26sZGL23wIwqaClJTc3XZr83elDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXwQY2RDnUve6c
 o7Oy5w28RXN+CIng9a+SA6mFHUfydGOHJFU1N888Oc25q3XzHn7pah9Z6DUUdMQSvaiYCGCiEXy
 AbdJ3NNag7nWjdPLlCpm+XeSWY+9AvKFWrSvBuu6yMweLfLVEy+ALiJRGWQ2xGNAyI0c5WC5GHX
 yBf5hlMPIaEH14s1QvxZhaJQGdz+yB3aDFOW8ylvEpAgnjYpJvjsF53inXM2OhlqnwCizTmZont
 5oXW4kicR4zhb1cROfdlbr2OTXMOeXyFYWjDK/b5OuBMyuQ+kiMSynbsuK1wdmm7FUPVvnCLtce
 /M/FNhrZSS+kpk84PgS+BOT7cMkFZ3oywA1ws55uf5NdfaG4tjJGvegLRVMq3t0Vl5WZZxjmogZ
 ImuQM7QM
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b8667d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=v5yAd65IgAm86a0TdQQA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/3/25 10:09 AM, Manikanta Mylavarapu wrote:
> Serial engines 2 and 3 on the IPQ5424 support I2C. The I2C instance
> operates on serial engine 2, designated as i2c0, and on serial engine 3,
> designated as i2c1. Add both the i2c0 and i2c1 nodes.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

