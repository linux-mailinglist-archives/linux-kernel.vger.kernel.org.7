Return-Path: <linux-kernel+bounces-799033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF9B42617
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3460D176B71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067EB2989B5;
	Wed,  3 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqYqChm4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563513A258
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915164; cv=none; b=IN1hbLsVdrrqxHMQVlUhAyjc1JUB7LbMDuV6xgDWRwTJcWCG2hQ1xMX1YBzUbeXfN9i+vq4P7h8msRdTG+OgP+fWk/T1iyJnHHKyunGcMtkvH+mrlHPGoPBOxWpZV2a5LsuFwNpUl6kiil5u/cDUfTsNx9mDPOBaAVpq8AB3vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915164; c=relaxed/simple;
	bh=JNMPH5k3WcBdGHvIhwkV+wM3E5WR4tEjM8O7jMB819Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY4n6y9qCXlTPpyq+fafsftVCNDNy1azG5a9wIB5ECvSzNryAXtpx7KzHrtdjz4KfqoW/CD08YwHqprlQeBCiSG8+1vdJcCrxzBlqRuGpvaHaRx+YsDqplbqD7UfnJwPvohUzEsmvdnx8jGpVttWUamgaDjPTIvyOpXp9FbPtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqYqChm4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwxFv007608
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JoondHVb2/f/1ydbXUBDu0DfSCvLLfXEhj4RfdZtE60=; b=EqYqChm4V7FtJ0s2
	dC2mDVa3bh3aETlAwgSrvCJEWP+tYhRPU41BC1mYldl00uP5rOf+SM6imdLX3hO8
	iyaotOG2w1gay7YinUkAHkF5KWdBz6H+5f0lia+pSXibg9mWzmT8vdxl/3ikvOd2
	cmdvk95hb7ZVN28riyyspWzqBBZZGoeisRq6Ih3aTn3eNzUbcHDnb6+yyI46kenF
	nDEOb7lVGLvSOHqODRLf0j6O7aANS/bY3iS1X0O26/6eGctx1KyI7Dt8S4s1WKgJ
	EutSRf6QQMTHQe1meKGGSFiqVevhdMQGZThqwxlwam/ne+ynW9kndmI1uhuYaIBK
	YFAg0Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv4dpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:59:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3387c826eso239811cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915161; x=1757519961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoondHVb2/f/1ydbXUBDu0DfSCvLLfXEhj4RfdZtE60=;
        b=D+HVywzL4guBm3MaJTztOklmXh+HvfEsUQ11DuFUkuzgz6UQf/3PsDCwYHP+xMAT+6
         n7BqbvCmO3UXxOUFEf8iD2eiF8lzwCATLXyOmPDrPLa6tLQ301xh1iyar6HEMsP0SpHw
         BWUEnqzd5lgBdfPsJ8RuM6Tn6KVbwlMjoDAitqdkCuGjIP2ml9fY76TX5nKvflTaYnaz
         C/ElnRHEAWooFqcERMXWSnztPNjYrTA3SkIjdYxAPyR5mXVVb+6oj1n0EAzf8aQG6RAD
         sTRLj5nVebMXzTQKLSnLXdTmMmJvnSOJk4f0R3PmCAIdxypmD1GNE1TGrsO0qmhISPA+
         h0xA==
X-Forwarded-Encrypted: i=1; AJvYcCU/KMWQl9C4sYOCBMLrh7aNOfM0foI1rgapIaVyR5Q0jBuHhPMdsCNbUXeE0Hs6ufYYoPORjpUWDRUJIT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzZ3+Fj8oy1XRsq00YnSs2c4M3S3xpxp1XghW6qnSOarA4hw4
	/86lbXMJPlOO35/MzjbD3HXlcD0nBN5XUJomcvhWbuBPMXuGbqff1wH1R3Ck813sakZtZ9gdFGR
	yGT/HqzGaq2vn/jUaql8Nsych4xzKSdpwc8P7oJPd+L9zT57paEYq1S2oZGz/elSONE0=
X-Gm-Gg: ASbGnctmBvivlpDgpruLJ1rMyL27Yd7TYCzkqkjvHTLY2w352LimBziABg4l9YWCASb
	/GrOR/0gY6TkVC66iKJVxtTAlvrnEreeh37tnDQRxf4aVXZI6KHJ/1wgxiQ4ieXO/GTcSO07amR
	a4LjGsH0g/vqkRS4K6yQi5LCLCD0a9p7gB6OFkp3NVAax1Yl8ODKIIfmQl+YS6HB4QpPmxA0+Tx
	L2w68RhRwpoSN8lzlHN0oJYQl91yYiJ62+jOpjg8Rh7647vbJD1uI78urAUq4Vwn2fiw472Wb3f
	IRNVRepHO9GC6Uy2kzpEBSOpvfO0GXyXoCHrxlr+jjBrL0skzcp5r6xT013NNymV71qs+NN6Dtj
	f7Nz5gKCGJgdjXQEQgnPSDw==
X-Received: by 2002:ac8:7d0c:0:b0:4ab:6b8c:1a41 with SMTP id d75a77b69052e-4b313e8321amr143129781cf.7.1756915161030;
        Wed, 03 Sep 2025 08:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgTsN6zBLbfiQxn8VdgOLVcjIE+dE8RIguKNUapAfNMSnt7dg9W7Uh4W7sqhgWh6QlyYMZw==
X-Received: by 2002:ac8:7d0c:0:b0:4ab:6b8c:1a41 with SMTP id d75a77b69052e-4b313e8321amr143129451cf.7.1756915160366;
        Wed, 03 Sep 2025 08:59:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046c296c90sm180845666b.83.2025.09.03.08.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:59:19 -0700 (PDT)
Message-ID: <a53c6bae-710e-4939-990f-5974346f6c75@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:59:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: lemans: enable static TPDM
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
 <20250822103008.1029-4-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822103008.1029-4-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX5fzViQIarZBO
 H+OR1Aq/oR9Z6Ho9QIgrV7FmKgn9adNSOGuMYahsJFIrZLswEYCCBjUew9cvwON/IB8pSnr5Hft
 29+SNjlzJ/Jetg9re/6EA81Ezmp2xAtrfOfZpR4koQALIeTCmc5rQKjH5E5x+P42XmPYahSjiz0
 XYLhde2LcdClVzfl9sIfEfltd8paltf5VYJUokFo0Tjj948HA2YHdJht5ELKivDMYZjDgL585gU
 Gqru6K6vQPk6CjtpKqXsHfxYSGpyJRG5I7zpuj1gKET+JjUvx8Ie+tQCbqnRGZ+2ZKijJdPppZ7
 eflwZpnq8NL/WLhHb3scPWj+/NRsvISR/Y6dCa+6EWeU557SH5GpcmGELtq8FQigM9d2BJTbfrP
 VBwetnR8
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b865da cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_EvAq3oGWgLp-oLdTm4A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: z-W0rbgC90MIt5m7jVk0ztCwD4l70QxT
X-Proofpoint-GUID: z-W0rbgC90MIt5m7jVk0ztCwD4l70QxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/22/25 12:30 PM, Jie Gan wrote:
> Enable static TPDM device for lemans.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---

perhaps renaming 'turing' to 'cdsp' would make things easier to
comprehend

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

