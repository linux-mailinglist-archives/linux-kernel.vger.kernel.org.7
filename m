Return-Path: <linux-kernel+bounces-798485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368EB41EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A63B7A46E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADACE2D131D;
	Wed,  3 Sep 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jy5pIQk0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7583283FE7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901797; cv=none; b=XhUpKrCLSuNKZeLEdIBqrOyG6w733GKuH7ypXzn7/z90igora95W2xmTiMzw8irWlQ4zLNGIi/qgrl2PUCE1l1i+DLqvVcnxf4F3jgVg8z/0HLJfMabe4nMng86h9LMiMkP6IAfWSs2A2yWJ1k0WQ6aM9OtcLjHRktU88XFL+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901797; c=relaxed/simple;
	bh=cC0aiuuE0E+2DpdlvkGHD3ARHOLa7nVcin05l3IEh7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twkXGDbnIeU8FkIGz00iw4itmGXdlbSMBElH81THmar+uUrLiRnDwYS0CHqyZAv28lUb6FCV/FuUZWSJr/YoqlaC2JJQDpp3IBR9X5zKiukJsXVqksdHNrrWKqA4fa7pXItIaa8ftUYNn7p7tfOGMAvBGgbdkRVLh8Pv+zalzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jy5pIQk0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEus4004899
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vn4mwhUMj9kw47ypZhCXah1sPzLur+fBXwYhZMjbZk=; b=jy5pIQk0rhPvXaY+
	cCha0zTkTY+5Qr19y0ccl/29FzoPuVV2vfq0FxWpzPg1KNH2fP728pAB5ctzTq02
	Vd2QqOSZw+OyxcGv9oXyvBuqS5jEBMx7mPQFRT6WfgECu2n/Gr/LQ3l2XJCO8APB
	lPxljbQDVVnLf1c/6VBvlZFk9fEdXJ3qGKGsGXvaKSFeMCPgZguN3UDaWih7EdT7
	ndTQqdUgquq43MAd/dErWh4lxVji4a9Xeu6iazj1z/QLEvBJIyeWms1enFwFmjpl
	bUR8jspl2hiz0wxIyLTfnVjgvmcp1ujUpxAQTORNakBhdZHnChVZ+Ey7379aYUXk
	vxKe+w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3nqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:16:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-71ce3c952c1so6617946d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901793; x=1757506593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vn4mwhUMj9kw47ypZhCXah1sPzLur+fBXwYhZMjbZk=;
        b=pRofSCDsFgvdRKp8H00oniCs6YMLSPdve8z8xjsa8CL4Czd+worlWmToQjK1K07CxX
         woQj6Oe5brsf0g+Pla+tgzEwUXRx/yl26A5ktjjoyhON0rAzAILYyLHgC99YfKHHmsqE
         I65z/DwnKQrQNPXY29aCRQ6kpogV8o4bzTs3S+OfUKX8QgX7EnTGB1NWXx9PFqweWX/N
         Wa5MdPTvhePpkvCeYZG2Z+hioGyfYwS1JkMlT/Uo9bKHJBvBMkg+kNH0NlB51dNwtEtO
         n2z6rdD91eXi8+3KYG3diFlRS3Lt8LOzW3rqNsJw9mZ+2GrO8eUP/Vgr62M6xlKTemPI
         kIDg==
X-Gm-Message-State: AOJu0YyxPY7EM8kmjCALHqwlzQ5ZTTk8UnSgOR41cGDKgsZtAtRgrjDv
	Q6tDkmF+5GSTp/GSD6bfpRbwh/EQHI6KVsuM+fESrsBENq7OH5PrFkXYe9zbIIaUqoW4P4t5hZl
	OnUIhcSJFz0IfBk3j6dwMsn4we+yKvYh8RTrQ731isKkVyGEFELbLXp1+SiKkXdhjHl4=
X-Gm-Gg: ASbGncs2/Yhs0iPzZ0jbhUVVxEoCt+j9RKskTC8ZRKEtVKBcq4Dex+JSoFsBwWQ32qa
	mIEu4Qoh7DwfsAT+xsnC0iiohR33DxqKtwM4QUSIGlWysRFUF+8qZ3RFKmE4CnpSwWdTSYtKOz8
	mQ0MpGbqrnBXtYZHz8K7mWEgZioXb3TkWsbL/TIdBH1W0ciF79UJYEW2qR2kmAUnu+g4yD47ZSa
	m7cv18LZHq/58ERrPgTQ+AqY+Plq2ehCzYgaUyXiV6SPkK/B+xzSn2GuBWXHaWP0RzbyfNmnevL
	mywxLUYYryHIoVzNQw1BIDCqXvsRFNxkUalB5DzBI8g63YJJX8nZUc8oFgWAFdBXROnDeq7dxd2
	JBrgdM5cIMbXv8gGuFPJmJw==
X-Received: by 2002:a05:6214:509c:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-70fa1dada4emr132004946d6.3.1756901793452;
        Wed, 03 Sep 2025 05:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsHxz+3HO2KA7aO0WYCcwzAJIdCm+RcRd6sRVZbTR8qPcb7vM9trhlNh+9aPhNhIf6qPjJxQ==
X-Received: by 2002:a05:6214:509c:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-70fa1dada4emr132004686d6.3.1756901792919;
        Wed, 03 Sep 2025 05:16:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7ed1sm12115926a12.1.2025.09.03.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:16:32 -0700 (PDT)
Message-ID: <d40c5ab2-2195-462f-9fd4-8c519a43f032@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] media: qcom: camss: tpg: Add TPG support for
 SA8775P and QCS8300
To: Wenmeng Liu <quic_wenmliu@quicinc.com>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250822-camss_tpg-v3-0-c7833a5f10d0@quicinc.com>
 <20250822-camss_tpg-v3-3-c7833a5f10d0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250822-camss_tpg-v3-3-c7833a5f10d0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX0NJNUogIatKN
 jjjN+bZWZF6t4GSGdulh8I6Q7jpNKaLpnONmOPTUJOL9iDIT8DdukK3eXkTXLy8tpL0FFbbset5
 N9Um4T2pSIhSRRiKTkI1gYHmlngPhVwYLZw9c/QVl2WDo3QKaHUFDf0LnQf+0mmgAN6Po0tOx3y
 Nt6eaXAnMWyFNuQd0BYOQqvCYVdTVIoYwh4Y4VDfo+YxW8ncj51HhyAzfJDBIxqLGg3dqaAHONf
 z+zJi/PDE3gF7sYtzKh5dy/jMa+gR7dJ62Q/Tn8A2YD2QrYybFjQkscevkXOankjLCw+WApdZ/P
 /+Fs0JeVE+GaCHtIjLzd3QCSHimiYaRSwkgI/6pNF1QTWuMWIG19Qpd/WS8bqm9hLW5D++3e1HT
 EuWyfmVT
X-Proofpoint-GUID: -VhJd6C_hszRuBDUavlmtxJb8pjliymX
X-Proofpoint-ORIG-GUID: -VhJd6C_hszRuBDUavlmtxJb8pjliymX
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b831a2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=McB9vphyiCVPsmp0I2cA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/22/25 2:09 PM, Wenmeng Liu wrote:
> Add support for TPG found on SA8775P and QCS8300.
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---

[...]

> +#define TPG_HW_VERSION		0x0
> +#define		HW_VERSION_STEPPING		0
> +#define		HW_VERSION_REVISION		16
> +#define		HW_VERSION_GENERATION		28

Please use GENMASK for defining bitfields, avoid tabs (just a space
is fine, perhaps add one in front of #define to denote bitfields) and
use FIELD_PREP/FIELD_GET accessors

Konrad

