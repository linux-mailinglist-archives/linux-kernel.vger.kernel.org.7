Return-Path: <linux-kernel+bounces-755608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5AB1A922
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F006238DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27F21A44C;
	Mon,  4 Aug 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sxb6XvFN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7B4430
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331753; cv=none; b=aW2HQnXgwmoc2C/an1TzwRlA5kiMDiZlm/bMSYaDHuEhVrcAU58cKKT2/kL7EZrGAmcO4Hzku4KWFqu6T4/R4UZkKIL+6Dcph/SYE80pmEtiBYD8USN7C6jDBCYo/cMMGiF+vqdSlWWRHzD6LNuEHtkFC1oMim05wSbXRWDCEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331753; c=relaxed/simple;
	bh=JKj8bw+mKnuVFjEQ11Gaa2fcA7Zn2gHsTNk2HvijlVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjsleY9/APRIYtHBl0LcEQCZFJKAj7LtNSS6Pg21/xRJyz8sHwHj8y0HHZNQKb5biMg7Xbd1LOTsMcBnWSQTvvu+nwm/FjFRwODzN3GxeYk9QKeJSKY7x5rCrCfeKTOeGLuE4xZTHa5dnbW3bmSWIYpxSEWT2qrv5Y4IbCw+k9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sxb6XvFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574H9XbA016348
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 18:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I9FsS+VbJFYkkKuzM+RPQd9H0jMOTQpUPWeQTeryYYo=; b=Sxb6XvFNA+/08g1K
	pA8/1ZpKlwgZzqRYuem/Tx9nK9LnrBMPukx4OUZMhi7RiWmMCcahD56cAkVdQNRe
	FrcN/OBWAACmxKx/RYtzNKaxpOcH+354owz2QytcgJ8HUt4RC9b73hf871s5AwZG
	+4sLYp+h6zdQa2/81ISoNflqURekvSvGcNUsq0byz63vnKl1lquAoGHLeq09zmeZ
	rA2Ck/eEFgJWtvAi+Go6MZU0N6ZxLm/f+ps3xnj0lZihzg5blwmDBNBFYLNLnXz3
	dso0z/wXyCdapE95KXTwiKNkuBZ8w98DzARmDX+nnmT5797fEIcJ0lxDo09WhlGZ
	GpuLCg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjp723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:22:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31eaca81eecso1344228a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331751; x=1754936551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9FsS+VbJFYkkKuzM+RPQd9H0jMOTQpUPWeQTeryYYo=;
        b=T18dr+Jrw3Sfk+zaqL8ioEVl46D1Fl0vFNv9z1Rgqt2tQR8P5S9Nh0u6gVjAtgC4Zx
         JsYOEdQbjO77Y+DUTJzETBm7L1hB8YEAjJalGzO1iNLjBQS4iQU3+9GpY0Y305fM5r1B
         ovLe5wkLd53oyizDJnutAR5NVIjryYpe3cBu3aYtBM4aQu4Z96+SdPOjS9AGNguKoaVN
         WjVVNXDpl7F8MJe/cxIRr93D76yp3cKs8Pfm6EZsN8Ik0+B48z0WtcrTgdSSgKLYN6L+
         GNgoEjBMY8BjnjSpf+aumOb7VT1gj+yYFP3fbbgYDczqst9JOp3VA+9hhjdsc47aJJXW
         Aq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX98oIEZaePKGxqXqthHjxqwCbDx2Hks1c54tOAALq9p5zNkoawKVJnFBqHjJcycTyKWZDKh4c/t7kYXlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBMEc1O8+RTIry0JcWFTTLL6ezXmCh2vg8DtHo5UU8wXQLLld
	nyBtBl9IiVresH6coolcal/+rtYoEDnnM1OqoktxulKCI7PpwDPhrcEe+HCug3utPB08FZ2/xYT
	cGOIArXdXwt8RemqKlyVtQQJNQOvIpMdc3n/0wthsJSbdlKXE5xse+WUbhTgf/yrpA1k=
X-Gm-Gg: ASbGnctdl2vi4jVG8//svpeSDAF8pxOMUb3McJusdI7SDJ90CEyqqKq0dHY3s6fZnOx
	H/V0sb0RLyrv1tXKraPUXUD3/n7Fmvk2daX+fVcQjBvwsQsDqUWsZ5rTJ2M6YSkO7DjA9bphKWy
	codxgb87RM1Ib6+zoOplC0OycXnTvCUlKvxxxHRse20DgZIMKwyBH9iUUMZ9gN1cOpcnbRZHvPv
	+zcAZkv5sP8QsrI5tiCRLqd2PQ7TAmCerPWmyXxLYzRsGhFnuHFYnlMRN3gWuhkLuC+DBxQp9n7
	T9N5+vc/WEQAFiY+2asQiHn2KvsrmD+9ltoKWJBFS+tCMAqVmolY8URq8EgLD8b036jS7bKjA/R
	TGVrqNu/Zd1TkljxU1XIb3f4MfoNmCzJC
X-Received: by 2002:a17:90b:288e:b0:321:29c4:e7c3 with SMTP id 98e67ed59e1d1-32129c4e9damr3646475a91.3.1754331750826;
        Mon, 04 Aug 2025 11:22:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOU5OWHfOG0dmrlXfJFHVqdV/tQ6gpchrrrTUErDtERSvZxHbDFE9M+eso01gEc1fOlfScHA==
X-Received: by 2002:a17:90b:288e:b0:321:29c4:e7c3 with SMTP id 98e67ed59e1d1-32129c4e9damr3646460a91.3.1754331750334;
        Mon, 04 Aug 2025 11:22:30 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:a9d1:15b3:77df:1800:1497? ([2401:4900:1cb5:a9d1:15b3:77df:1800:1497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da57b4sm15254085a91.5.2025.08.04.11.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:22:30 -0700 (PDT)
Message-ID: <ba553cec-8004-459f-aec7-f9a800342434@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 23:52:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom: Add bindings for Monaco
 EVK
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
 <20250801163607.1464037-2-umang.chheda@oss.qualcomm.com>
 <267b2d6c-468d-4bff-ac06-c6755706a398@kernel.org>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <267b2d6c-468d-4bff-ac06-c6755706a398@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6890fa67 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=JcbvZcPrJRGWfMKQDdsA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: YtPI6cWkpmuVyz73egxF397cxb9j3sIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwNCBTYWx0ZWRfX3jmIdZKI+huZ
 qvU/FpjVY1R89zfSQ70/JLNxf4GSrRwRuCB/74KOuYKJ3bEPe70NtEFP1rJpRa1XaJiUK5ZRRHR
 ENvXRuutEvEdIIWJfSIv6VeJ77D/M2ef9AVFFARD1UAT33rpwvd7Jt49OZcsSfojIjSdCAqBS5O
 BuDuixhZo7dlf5sanozH7Eltii7v8+AocTIiYFySElqhRoQe5pvrixH+xc5CqhPOukt8H/vn5Z2
 XvsMZ5Y0MmG6/IJ5jHrj4wuy1jkxByJrYKaaBZqmxCKRXcoeTZZY8qj50lvVTAxhuiAacewPpFX
 rV7LSeMMVhmf2ScVwKxRG+gUI0y0nbyb+POHX0N1ZvyHygBpXxH18AD74BGWckYHt8hW1yO8UWI
 cwJlqfjCqXjMLw2ROrS035nqU5WhDzERCNQuqLdyh2CAnidXEOrFf10JW0yL0DJOZXTs+z8E
X-Proofpoint-GUID: YtPI6cWkpmuVyz73egxF397cxb9j3sIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040104

Hi Krzysztof,

On 8/2/2025 1:16 PM, Krzysztof Kozlowski wrote:
> On 01/08/2025 18:36, Umang Chheda wrote:
>> From: Umang Chheda <uchheda.chheda@oss.qualcomm.com>
>>
>> Introduce new bindings for the Monaco Evaluation Kit (EVK),
>> an IoT board based on the QCS8300 SoC.
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>  1 file changed, 1 insertion(+)
> 
> This is v2, so where is any changelog?
I have added the changelog in cover letter, But seems I missed
to add it more elaborately and in proper format. Apologize for
the churn will make sure to take care of this in subsequent patches.

> 
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
Ack, will take care of this in subsequent patches.

> Best regards,
> Krzysztof

Thanks,
Umang


