Return-Path: <linux-kernel+bounces-896933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C121AC51989
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A36664F2FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8082F7AA2;
	Wed, 12 Nov 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6r0iNuN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZUhEo22"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125562FD1D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942184; cv=none; b=LQFAejZtvVqfBln+OddDwBJ3RmFD32aj0pC0/+rNBl+RMSz6MlEnQYAH7/bAPpGuJetNG39ZXVLvExr6B9Pih+vdx+CQUfBWPOdPtThTI6bbhGgWEIZReqdZT8gaffN2YPIISoALUF2SLUR2LyPYZ0dVh9HanNGV62JSLFDr9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942184; c=relaxed/simple;
	bh=olYrXkIqmlydcv65JH0VYt15vLnFtcVP3HgL7kAh2vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRDWSqXv5KR5iWMRz/f9RtQvVuXXx75bjMNrpyd2NVi0acSmBReFuN19RaNrKiOIN0+Kh/jwxnj5HfFRxI2dehr6aH0GgZmQlZ137KNm89VpXFpvpBXpnvEcmNLStvzmW5dNRXGnyfOhlBHdi6yaSK5I1laGK6YHTMwoAjs6ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6r0iNuN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IZUhEo22; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC7IZ2q3502320
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z7+KAp8/WxI0gJBqO/9PgX3s79ROrh9F/K5k8HRSUJM=; b=N6r0iNuNQqVu1TUg
	vnhRFf0gAH9VbEhWaFoddkodhBR2JaXz+vmoQoBeP6Ee2pq/6FcZp8GVkZP74OPz
	S/LKT1kstaSLu/mNrmFYAXCbZhx2ufFLt/D1gjRblZePi2A6SKfx9GMNeq33Zb3k
	vTzeCCfLAjws2hBGqleHa4LJe3oBbiWMORllxcVJO4a0N85SHhxs1DZJSHpMz9ud
	WMW6K/rT3CMXn9y5oBuxZshtAwousRA5mxrcFHbjmG/jcaL2A8KHT+PF5lfHJOeV
	Uf56+2GhNjP7iOGea4cqnZuwrDueiyK3++QaUJMYtsx9tsoX5uw9aA2iu6e8mXKu
	nJQ+NA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acdcc216s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:09:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6855557aso13574191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942181; x=1763546981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7+KAp8/WxI0gJBqO/9PgX3s79ROrh9F/K5k8HRSUJM=;
        b=IZUhEo22w6WfHErDruhmMh74E5XbvT8YM0MbCEKp5EYKpERLGq6ccdnclfsrfHqg8e
         3FQ0M96kGk/2E8NpdKZ7+DMoxA4FvRBb74QDML96svB5u/T2ccm/vvSoMejc4nqpu+QN
         fN2B9gPn2Tl0AjUhvBr1PrXNuo+uvtKp/4w22LabpDHis61FBSTCZg/XlsTeS+HTjq9R
         DcIV7zPneYlFAexvdt8salihhcwrLNPwPVFi+8UrMFqofunT82v/W2ErffPQ2dVBnanc
         97nZ5fClAdIWr5ro/Xkd+M4aj9sW9wR5ZmeFv05KAJbi6Td8I6aTVtk5NcIDS474tQuT
         kJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942181; x=1763546981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7+KAp8/WxI0gJBqO/9PgX3s79ROrh9F/K5k8HRSUJM=;
        b=AA/JfCKXJUcG05b8CKbhpKEnAW4U4oo+zsQB//JbeeuxZCdIRIBpd03TVAOP+h2a0n
         COwKZCP8CGl+t1lfO4xB/U9BRAxiZB5A8M6ZLC8aJWRvyXtHZs8/NgG8v16tliY3JJt+
         mpNTzv97ai1lngJH0utsxBiFjDD8KRJ0EMY74RWEnksegSYtooeSPi2MEHQ+L4cfTYdY
         37eM1th+43dBC6AgecRv1tCOfMPTzfpRls1ZyzA95O90WjWXAYuYaOs2e1kdtNv6jxk+
         IeaKAm4/KuWLVT1mSO8dkftjUJjNo9bvnpgRTQbkdckpfbxyCoal1mrexHgc/85M8Ggk
         YePw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMUbsdoF3KNJcXLtuioeIWPWgIiVXEdnbCgUPFpt9N1HN6t6cq3oEMPzsD6JWRckZbXm++dQH5nOgBIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a6uhFiswPFhXg7MBuRKCQ9unIe4WTze07A06FIGu6K0ZdNrZ
	7FMMEqyzQfooG261XytY+s0Sap4F235FwhjfyX21Qzu/Ks/w9a/NudbKa7opNjegmFrOnSbJRFj
	4qgDeXdxPgePhR6amVnvgvkI92tYeaWtb6CjYAUgvvPqr7W0jJPhNZEiSOTEBXISWDfg=
X-Gm-Gg: ASbGnctc9tzVXaXgYT9QU/QDS1Voe1U56EmScDZY5NT8+ZrtK0m0uMTbkNIcvPcGROf
	3H6sUR3vyacS+uM4y0Uhq1RqaIprvmzXoxfRUBdOHkOuTeIOMSKOZzeXAcbEEYqF+UNj54BRh1a
	7Nzq+GF2eiHNbPewDXjp+JNel8BXuDJUB+zNbMEEnaV8GlOg1dILpl0thwkGUA2a2OFuiUNWMpq
	2XS6AkYUOMP2fHjvgy1R1WPVfBPasVy82D0ykSwrVbWPEw16PQjnI6TOajm5OmBg8D+Vz/V6817
	7Fj6tlcbcdj3YAasZSpqmVXyhyVv6g2xfp1nwvJ2KprgvMyeaVbVxS9ZWDpuIcmTYA73qIcW3yJ
	iGES1fu13+8lfrmvJ1vlSJDcvUQ==
X-Received: by 2002:ac8:58d5:0:b0:4ed:ae94:5f5b with SMTP id d75a77b69052e-4edcaaa4f49mr77296561cf.8.1762942181507;
        Wed, 12 Nov 2025 02:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRjcsBdXzo+DsSel+yAaYa6lRVf3CufXhegqSBiMMMAqPt5BSkhfBsKJYMr28ZM1ZOvJKSag==
X-Received: by 2002:ac8:58d5:0:b0:4ed:ae94:5f5b with SMTP id d75a77b69052e-4edcaaa4f49mr77296111cf.8.1762942180799;
        Wed, 12 Nov 2025 02:09:40 -0800 (PST)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6acsm26947215e9.9.2025.11.12.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:09:40 -0800 (PST)
Message-ID: <7eed86f6-97a9-487a-8161-3617597f7391@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:09:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: ngd: Fix reference count leak in
 qcom_slim_ngd_notify_slaves
To: Vinod Koul <vkoul@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
References: <20251027060601.33228-1-linmq006@gmail.com>
 <176292442599.64339.7709313480733902465.b4-ty@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <176292442599.64339.7709313480733902465.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cNmYANlhq-HFO5ICTxkuGsI4cLesAqs5
X-Proofpoint-ORIG-GUID: cNmYANlhq-HFO5ICTxkuGsI4cLesAqs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MSBTYWx0ZWRfX3QS5q0NcZcgd
 hffXFtQXk+g+2VZwKeW1zyd+mDpDuJc9gV4+OxZmxc2rTbVxfmuFywO+dcF+cbNiSzWTPInZA1L
 8zv16Qb+2m2Vz+RMYByjsefbFpwoZiVxdUoD4vQUmkDjOCkUEnGrvSTLMc15EOgYxtBp12Q0HGw
 3GB0/FyVexJbs4VW1IAyx7gzpmgdpocTAUKywcvm73/01xRFIPlGK2uc7h8859+KhypaVOOEX0k
 MnpRYRlnhmAAsEfhnr7dXsLPbrbGuzERZxnGOZQ3iwfKqEgIbdE70H1X/3CmpxpcnyZTEi25ZYi
 geAl36b+ayq1Rn/wh/xNbMY+bMDFgCR/FdHgfEVkx4u5Qfn0x+TomK+tL5NFWZgL3lSbbQA2PlT
 um2ETIcOEpgO8YpRxjLGo+D6BGRtPA==
X-Authority-Analysis: v=2.4 cv=L/0QguT8 c=1 sm=1 tr=0 ts=69145ce6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Yrr5m3MqBTjBsgb0id4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120081



On 11/12/25 5:13 AM, Vinod Koul wrote:
> 
> On Mon, 27 Oct 2025 14:06:01 +0800, Miaoqian Lin wrote:
>> The function qcom_slim_ngd_notify_slaves() calls of_slim_get_device() which
>> internally uses device_find_child() to obtain a device reference.
>> According to the device_find_child() documentation,
>> the caller must drop the reference with put_device() after use.
>>
>> Found via static analysis and this is similar to commit 4e65bda8273c
>> ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
>>
>> [...]
> 
> Applied, thanks!

These are slimbus patches? any reason why they are going via soundwire tree?

--srini>
> [1/1] slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
>       commit: bcd8db9640bcad313f7fbf8433fcb5459cdd760a
> 
> Best regards,


