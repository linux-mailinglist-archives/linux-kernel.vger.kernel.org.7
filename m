Return-Path: <linux-kernel+bounces-768415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CDB260D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456A87B4CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE322EBBBC;
	Thu, 14 Aug 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpo3dVKO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE52EB5C7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163523; cv=none; b=qV+UcltThH3xs8+nVWW9oxVOP7WUrpG7/im/asz59Vgodt+Xb8ldcNErvoMqSC1jkTpcupCkJF+MEtmP3OSpULG0c4QSFNSnPpGWlP8HQwafrkXMK3vxVHGLwW3ho75Q7z2FQI/A8nIfQxotKSLeVFLLIl6aUHFujjBKx5PJiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163523; c=relaxed/simple;
	bh=BUXFP0U+hivJPwg7gYygk77EM7S6MHzwvVEpmdMZtso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TO8S0YcI8AJBXUC/S666lYC740+AWxkkamtqw11qEuSmjEMmQnvmrTUku26ZvciVmuyfQOZagrO65SYR8DE6xhuQCEztLng931R6HKOXJ/6UFP3n1W6AqGD6D2H6xQmLdKxdUnqRsnr8cZNjdtUIjDSaKhFKppRhAGhXVcr22AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpo3dVKO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNCuBH013690
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQEfbuaLjFND5gvC0GEYzyTZRnvvz4KEBmbZTTE8pJA=; b=Wpo3dVKO5hxQD3NH
	p5ohTSa2i0kyFkjcIaBWIMoeH+ONo4zWYBEUTQT9A/SUkw2SM0zTquwMnExCmCX8
	3m1KbKz3f6P6XVX/q2ffetM9WObeyXBaqezUx4VewqVB6IJ8SF2KDmnrtOrA7XoC
	7BN8adfbFFDpx7Q43hydk9ZHwaD+0sMMU7dFW7tIK4tYEolRZzyqnw68s04Rei2N
	vNvW5JLNu+pLRmQ34GsnWbI7+Xs4zfquZEcrr3c+p8UwtwbKJ5QHxN4xVWrh6ZVb
	Ex3pKKwMjM58ke5/JQv6aMT6pUM5D9qVgutqZM362o0itkZG3YsgWB7V2LNIbp15
	ch9z0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9x6v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:25:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8703155ccso20114785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163519; x=1755768319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQEfbuaLjFND5gvC0GEYzyTZRnvvz4KEBmbZTTE8pJA=;
        b=BB/838dSorR5qkyeNY8Cck01xSvr5HEnfLYJNvB1LeipSTUX8oSFYQfoqjMvWjAl/q
         fhqARId2zEOfOF7xUpa7mDJF+tj9dIGG9bMBmNNQx3FlQ5AEHv9sWhD4YHLpdSOE9Fhu
         7CoKOBVQy4BAZxdxo1NKnXuzKoIwIPyT0iiuUOa34/n/JBoSY0G134LzA8RNMNJL9bXN
         3juMEV9UVohyl5pP5OL+uaRR8WhxSBXvXEELK+hKv2mI63UCMD5irbZHD3ENRP/shBir
         we8XXyFv2yTGpwNkFGBBB/JnpxIsUcZ7D5+KWeMZ/l+ayU5WzCh/E7ROepJVKmWJrDsJ
         Zx5w==
X-Forwarded-Encrypted: i=1; AJvYcCWZmgOcwEfFP2RRmJUVVYx2qVdfqYDNE4X4PmfjzZ+ToYAManc0LVidFHjwhJpurOEugZqP2a18jei18pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBwdWsEFEP7jSDUyXTDj5mh4k+y9scDTWBYgWP9T6wsBC2x7N
	8PwSiNw6nP7ymeXiUFkRWW/zqlj2c7w30+gWwcGjigfrjvgt/78Ugoanywg5U6uUUQZ6rs7KoJH
	hxqxFeGO39gX7136FX+bh6RFRto/XSGnTDDufLEDFb7rvuzCFz2vTJtvpueT+1fIHQTc=
X-Gm-Gg: ASbGncvazadYcLkgCEYUrBhRnIvp8RK1kvUxGSjm457pJjx/GkAoj7RCo9s8ifD7NJv
	CkgLdYmkP02XAPdDpTL6azSqSZtDfs0kMV7i2U6jmzgQZKM97KG4/snvSphcPxd0tZ2O5EWnLWI
	UWid0ODzwspaSi0Q9G8HR1RYTj8xBQudtqqbk+cLanlNeypBm8xSu+xvHO6oVI+b7vw3+6s/Xn6
	5bXCqKAu7DlDSSXGcShtYFt4EbKQFoBukuJQujYCDpn1qP/4pAqTmQ549BN3yTQ4O66T6pAtObz
	iLRtLqaJlWQA8pRr03P2qu1zLdvQfQo2UewAPB8p04RS3MIsNIdYNHkbAoAWcT7wKceNiwUv17P
	H1L2QSxvguNQa/HtPZg==
X-Received: by 2002:a05:6214:e89:b0:709:f328:8f05 with SMTP id 6a1803df08f44-70ae6d09624mr15950296d6.2.1755163519254;
        Thu, 14 Aug 2025 02:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAQIFb6Sq3gKxyxH9UdwqYleE2mbGjbAt6Qiph21glIclnybKJm4av+T+Q9lLlN6r9HeDNIQ==
X-Received: by 2002:a05:6214:e89:b0:709:f328:8f05 with SMTP id 6a1803df08f44-70ae6d09624mr15950176d6.2.1755163518772;
        Thu, 14 Aug 2025 02:25:18 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm23309494a12.52.2025.08.14.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:25:18 -0700 (PDT)
Message-ID: <7813c237-241b-4f09-8948-283def984792@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] soc: qcom: use no-UBWC config for MSM8956/76
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
 <20250814-more-ubwc-v1-4-d520f298220d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-4-d520f298220d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689dab80 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6H9nUlg-slowg9_X3SkA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 6Z2GxrH1zyZHmIwior4yvONHuH7gF3s1
X-Proofpoint-ORIG-GUID: 6Z2GxrH1zyZHmIwior4yvONHuH7gF3s1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX1MTDCqbrk44A
 JNj8C9W3e81F9QlCIFE7ZtG8Z1cbA1pnsWKkV/NWBh6Xpj9R80iucGVfCUkUucr/kqPPM4Ot6ne
 FIV8lIFGbL6dkUke2H52rYDEpXqe9az4OxzkZ/7zkA47JapO/KJD5QrwPCDBFyb8EDXXCvEVR6a
 FuwAOZkehNK3QHiLW1XrrOPqfSwjY0EmH4/vDz5+XJG8bZaSRkLINO4ldouhzqtQuPsfTHYiOdX
 LwNnw4WC0zEqihP2v7m9AaEbN1KVWiO+uDDs6/HYyJvPCwEjmbEP86Td6smdPiS9O7sORYdDW6O
 oRgrhkdZdKTEw8N6AoT/9yl0mN2naN0Y0wej0YmPAPEioXAix1mUinVRMhaEFe91dpMd6xGDVhO
 /6EboVBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

On 8/14/25 9:22 AM, Dmitry Baryshkov wrote:
> Both MSM8956 and MSM8976 have MDSS 1.11 which doesn't support UBWC
> (although they also have Adreno 510, which might support UBWC). Disable
> UBWC support for those platforms.
> 
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

