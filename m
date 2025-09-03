Return-Path: <linux-kernel+bounces-798376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C95B41D16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FDE3BAFAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132C2F9C2A;
	Wed,  3 Sep 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmyr8uJx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF72F9C3F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898976; cv=none; b=NFGSFtVwTeDT6AyqacqfFCFirRxM9LxLlRXZpY1l2U9rHCMWIulztnV3nINuPZRxl9uOs2COzYVlQTLP/RSc8d8905PEB6QuHZlWHZpbi/y659vEhTYk24R8wPyUiwjEiWvnPGhP3xtNoRd1CWeGx6eS7OuitmUl0WvedsiCfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898976; c=relaxed/simple;
	bh=+ii5ePXVtRuyPwTD5x9Lo4Y2oQsXTwdTUVmZ0nXZC5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/H7farCU5Aqo5ihVoTG0kcfX87/kETPa782AlcgoPg5WRwPc7JqOLMuDFGRXQ4+24jGFLTwWB8OcsCLGUEFA1lGMmXUFN5/3l5b4ARZ672M8EmLMHRJEdqFIoQAaKufmaP7AOy/iUrM+MHWTwGw43aEKfPZ2yWQ956wqKJg7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmyr8uJx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEtbn022400
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0DlARa6c+cT5Kx7CXdcj/rxubZTPaG6M02eCca75WUc=; b=nmyr8uJxJ6etqPP0
	b1kmFIR4J1vwBabmRS39wXQngdBbYQL9ssENpoYw71UdRLYJ/tDruDKHMPwKfKwe
	RUbkIBlPRXXcBGAdX6oIkDXLbaCbudFuzHf3EKyFrZ6bvwneOfbWCyRF8iGFbbar
	SVBx/tS9is24GRc2GsDkQyHCJ07evboGykmbwnfaQU8cye3qXatbiGxzXDVORmrw
	78zJTmYocEplG4rMs33Y4WWe6pLl72vGPL7UAggWb/ADOqpnoHTstC303x4HeQhk
	HqU6YrTlmlEe9kJNrQi2cdhPAlOpiam1O9rMgO+/ODHUCpmV0z3HqcI9DWK3ZTHQ
	ckBYVA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fkb7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:29:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3037bd983so34786501cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898973; x=1757503773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DlARa6c+cT5Kx7CXdcj/rxubZTPaG6M02eCca75WUc=;
        b=up0H+GNVFxFawlV/D5ORHIFCoKfF0VxiQMSleTel0kk7Rm88QUkwa1V1+zHxZXxMJZ
         8PbE/+6mtb30ALvs1bxlvYGwjYKggZKLQwj9SZzZgC5ZuVF6rpnWb/4+I4vNQXzo7+FZ
         IdydNZBw/YAPeDyoygCSW28lNvd0QenYeoJ8iH8IV5/zZXnfaz+uZNTvItzKwociFyTk
         OkN2ThQnQVabj7N3fK8hGxuIKUbs6BJcb2rrqg+gSUldv/Z8ngvmvk4E1lUXCg/c6XxS
         NW02nC+np1QeAwW8TazDhqQfUfs1q+lGwp6tmWmylrMTg4UtRZYaDqCoR6P3WXnINA+D
         BPDg==
X-Forwarded-Encrypted: i=1; AJvYcCWBJVJwbVE9O8lIrWFDBMIM7/zTSrZ74PK+6SO9/DreYcirWQxrdmNcnUyPmCxs1/dvgk57uQidCbkH0Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRHS8zUV7x24y3itgyImq05JnUxy0t5ov61RX/dXRnRg3WYCt
	+QdSeFWteQtek2r+yRIJQLOzYwODAXuBqZrDjZb2LCgqSln/t3vcnQawV2naukxJjKYbZXEgYwJ
	TxzfsN/SrLGLIwo+JLPqkXnMa29xztqNuE4IvC6X9Pl5pr7EkPc9hU+TT6KJR+eKqLpU=
X-Gm-Gg: ASbGncs5BVC7GRLKehY9wlDGHSPzk0OseTMMrz2DCrKx6zdymHh4yvLP6FxA0fOVEy8
	R9UvZ9hYMMqFDR1mqfOlqX7WXBb1vNiUAtZZXRGbgxDnU58jwjE3wfTOPvWqUcbQrwQDQX6xffa
	jxOXSEQT9Uoa/CmCQIi78n+Cx0TIOCqiErJga4akzbJ7tdBi+5tcJYOLbSDDgIGiPMATLLWSRwv
	q0wcBx+OHpzcbF6PZXunP66Wpzbk5DPg4DFVINnYII8So9qPLlypu8j8Bzt9L7REymFz2aiE0W8
	Ad6FCaUUAlVni9N2oNu2lKcZHV2ryKYAQ9yvkyPkB3owfjWLXOn5W4snaJWRBLs8IuQGCAzFD6N
	7Korak8WZo1uyEktx4w7D+g==
X-Received: by 2002:a05:622a:3ce:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b49175fe5emr12198241cf.0.1756898972958;
        Wed, 03 Sep 2025 04:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhha7kDI06WR5/PTkK4mODNgVoKoKqWlu2qkXEihO/vwGB+8ZKEGtbIdhREN8PsqTm32pSlA==
X-Received: by 2002:a05:622a:3ce:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b49175fe5emr12197861cf.0.1756898972219;
        Wed, 03 Sep 2025 04:29:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5319afsm11824675a12.48.2025.09.03.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:29:31 -0700 (PDT)
Message-ID: <d74e6c4f-6be5-48bb-bd67-c9b5e42dfbec@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:29:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] arm64: dts: qcom: Add display support for QCS615
To: Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20250903-add-display-support-for-qcs615-platform-v8-0-7971c05d1262@oss.qualcomm.com>
 <20250903-add-display-support-for-qcs615-platform-v8-1-7971c05d1262@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-add-display-support-for-qcs615-platform-v8-1-7971c05d1262@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX4Tt0GwHJB/28
 0eEApT0SQEYTRgmt40Cvg7dmZ05KxGbQ1EmvJgcEWP4buAEZAHbnDYQhwGnMRZ9s0WOcS5Ft0R4
 HmiH+b0JFlaeK3DB+R/yrF3pxxb1L7l19ZAIDFvFnzn3qYSDpnkNh7FnVzQcLV34k/R+/cvX5UV
 SGUPiSbr2k06PTUYo+M3hMxq4RfwrcHWG2T9a8Z/bqIyiDkecG1Ut7W8vWLTau/RjFCvQTvFegq
 dkbrjnLqUWODnJgM6G8o325XnBDQuFACXeYlPxglqUErijM1v/CEx+mfvVQkTek9803nduP3JXD
 VX8a4ZPL8qnS/3JAItXkUjKtbD1NHgi/LQsloYYRLWocUlTNc5bbFdeXD8dfddDaO8D5hRDQ9Pd
 X3kkfpt7
X-Proofpoint-ORIG-GUID: oaYDe9Vp0SkBcYIrB12Pu9Vlg2AMCggt
X-Proofpoint-GUID: oaYDe9Vp0SkBcYIrB12Pu9Vlg2AMCggt
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b8269e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=7cbv3X7aQ-hLW3yDF-EA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/3/25 12:49 PM, Fange Zhang wrote:
> From: Li Liu <li.liu@oss.qualcomm.com>
> 
> Add display MDSS and DSI configuration for QCS615 platform.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

