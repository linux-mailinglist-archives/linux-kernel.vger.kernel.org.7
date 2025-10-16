Return-Path: <linux-kernel+bounces-856224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2A7BE3896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A07586131
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CC335BB2;
	Thu, 16 Oct 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULPJIdJG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86533439D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619404; cv=none; b=AUGd4wKik+4dPgVVWlNM+gFVHlwuiOWfJ1lOeQiGYBNCgGVJGrOV0MaYSwNEw+hCnJwFGSgQxB77WcB0z9ItYlIrxQ6OI07rL68NlhI0qymSD8iU7blSry8HTnQfMlSL+FDyqDyA8ivY/UxrvUz9qCXpU67rUPsDPZ5QpaLMElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619404; c=relaxed/simple;
	bh=Jbv8XMDahtn9wKO+PXew2xk51xBX5L1k+/IC6OmuoMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOwdESMpFCRfCeN4RyF5R/iAZXqMvvzo5GwrAmo0G8JSJkVddRrGRWAxpKaXIRLFKBcimLnxnd8eWJ7m+Vpkx5jPVF13Cc75zYfkj5B+jI515y8zTWLtb8uHXp/FPDGZoRyFq4hyEFLQxStuPyzxd2f+pKpCio99QEQIx3GL4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULPJIdJG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G5n3KO003544
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDcnEN/SEPhIGH2w0jNSMNXONDaOo4xYbjpnlUa6mcA=; b=ULPJIdJGV/cxPzlc
	l51ufxG8KK4M7aQnRcsYONSzRn8Rm0RtYmHA0xC+e/wpCgVedccLzd1VdQeepUMH
	EMI9AZ1FwigDOoYrDvma+VzYyYPNG2JtORioMNIfuHyXXI7yuABy9RMGTS2VHdIt
	YlksKS6s2mZyksya0voPQoUk2BR1SWZVoYuDIOlXBZrlBjmFDveXM754MShhhmeS
	HeXDcorOju+BcMjPVXKMKBdcrLnHVaHR5w4gpFeU+OUGetVUEbXKNICSn54Ss7Il
	iP8zKGk7hccs3NNuZnbQwjYgAGTRqkNNlWojQ+01/ch/c5SzQbIROIGNzeTb+9FV
	TlCgTw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8q03c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:56:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88f7eff9d5fso302183485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619401; x=1761224201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDcnEN/SEPhIGH2w0jNSMNXONDaOo4xYbjpnlUa6mcA=;
        b=fAo+GEdsy9VsbYFhQ6PRa5jSr/1ixlvSysBN/R8g3vpoFavt4W23ghnVSjibB4FtTu
         u+cBHrMdruhDY2Mrwd0fXJC0iposa8J33+hIzN/z9/+06Zj6fLg56YjQK6l0nxGzZVGC
         mkhmzVegy+cdTbyEKQhMsFW+UbLdiAtuQcSFr+QiUc9zH8ZkZqRDewl5AfWwsEsReezF
         29fBNNZBOwPUORyHjCOd7jQwBKewYzjHMA8HF0d6uFpiAOpHt6salk4zYg0WhzI98chz
         +XQPGlIWF7K0EopgTaBtANFc9epi7zUEOt616re8njlJmkSNUAZQEeshl8oEDYYqTRlF
         umJg==
X-Gm-Message-State: AOJu0YyUINiJ1CXLwZk7FA9vtMe+sV4DC1cb1531v/xizSECAFDPxUsx
	AgTTmbepjg6gykNG4+oNlhIlgpPR/UPqIOZEUCWshv4Tb4IOozqIGCAgCZfzA0baXVXnBTRvFC/
	iyjE5xFCaeLvFRgCJopg9O+7M28EWP1dZrzNUKIR/4demUU8waTIRdYCC3Ue1qkviTvIOsXJa5s
	mgmQ==
X-Gm-Gg: ASbGncsDSBrlI53Zvcf20TW3PUWZ//DPgz83+1NmvCzlQSpVu5l5piCwMNFHgJZkmD7
	e3d7ygFjuDehoP3KdqyytizOcdhxHoCkN86HqqHn89T8/u6SnyWPaRtPPCLxy+hKFG1csfVWTHv
	41z3jW5WjlXZru7DeGH0PEXWea793G435jABAaqEotpYm92xXgTCgajUKvyBjO21WHbDP4H/7il
	UkOiBH5NfnnTHvUPrJasIFmp4IrE8u+8Gcr48UxcHfK1In77ANrfwEL1WyC2yRe01qjaun5dv09
	HgRRLezIrf6oS1XGlisqcvJsbmYgbcJo7y3zD9pgJKAJjjBNB2RWqOKOjQVwR1foFjbumCIB8Dx
	DQTDa2T9OkY/CYYHidkhnRdX0CwC9n/+n7cZpLaU9lBF4uiX8f5CrMT0fhgRTwng=
X-Received: by 2002:a05:620a:1791:b0:88e:6f4:2160 with SMTP id af79cd13be357-88e06f42330mr908702385a.12.1760619400637;
        Thu, 16 Oct 2025 05:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuMl1hYNZddQ/dcADbLf0KGudXkeAs8SKF2Tj8TJbuhBzi9Jt8gOt7GxvWs8IrTaszx1MO7w==
X-Received: by 2002:a05:620a:1791:b0:88e:6f4:2160 with SMTP id af79cd13be357-88e06f42330mr908698085a.12.1760619400063;
        Thu, 16 Oct 2025 05:56:40 -0700 (PDT)
Received: from [10.111.161.126] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f3587272csm192372985a.6.2025.10.16.05.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:56:39 -0700 (PDT)
Message-ID: <400360a0-6580-402a-8b28-54c5212e7390@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 20:56:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: qcom: camss: tpg: Add TPG support for
 SA8775P and QCS8300
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
 <20250925-camss_tpg-v4-3-d2eb099902c8@oss.qualcomm.com>
 <eb90f34c-4b63-4696-abf5-1d412d7bf263@oss.qualcomm.com>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <eb90f34c-4b63-4696-abf5-1d412d7bf263@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0iSb3nTNs3se9iFQOLuc0ZmpWpsO-V5w
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f0eb8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=n-feYObeC9k_B3tjsesA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX9UijtPe+5gna
 qfCqQzhjFaIPxGokdz6L6Aq2x3/Fw1J0VI7ut0r5r6x6IiuEWdjIR3g18qnIpHA1hgdyMIkzn6o
 Ny2khsbEnLLEuk/eYscW4Esm/4Hc5P2Civ2iwsQdg9i7gaIIXniPiyivoIM5Jd/C7BWiKl2MP/q
 r1qiGB2Ksoi6zrejHETymiy6XUrjKCvZ+ewfIdQYdqrrri39Mt30wM6npL9Msbyw4b1tdgtF8wR
 mxhOdnZy3U2xsn2FJYvh2DVLDdCQb4cGHgFLk3JrZ4/5nfHnv4EScRfqc8dzfwQjkkYk5h0bWj3
 NB9RWOrH7I0Cxt3BGPyLawAK5fj9bnJGTExAGPtKGZ7ru2SKfEF8qeZMa4wVyHrBgN8pKggg6Je
 oAgdQYJLlNEXIUc5JEzWcFa8IyIAlA==
X-Proofpoint-ORIG-GUID: 0iSb3nTNs3se9iFQOLuc0ZmpWpsO-V5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134



On 10/8/2025 6:50 PM, Konrad Dybcio wrote:
> On 9/25/25 2:32 AM, Wenmeng Liu wrote:
>> Add support for TPG found on SA8775P and QCS8300.
>>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> @@ -4350,6 +4413,7 @@ static const struct camss_resources msm8916_resources = {
>>   	.ispif_res = &ispif_res_8x16,
>>   	.vfe_res = vfe_res_8x16,
>>   	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
>> +	.tpg_num = 0,
> 
> Uninitialized fields of partially-initialized structs default to zero,
> i.e. drop all lines like this
> 
> Konrad

sure, will update in next version.

Thanks,
Wenmeng

