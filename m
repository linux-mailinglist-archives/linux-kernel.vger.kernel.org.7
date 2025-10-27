Return-Path: <linux-kernel+bounces-871041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A724DC0C4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCF719A0B25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68B2E7F1E;
	Mon, 27 Oct 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nWLQY8qL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B02E613A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553660; cv=none; b=Cnj6h6KJpWZ26ZyISLA7jngJ9vaU8yECipGqEztWAQ5KQiQCCc+QJSfPllA4p7NlERywe1NIJyvsQRcXgcr6/CIPowWi8gnsZMXaCrG5fJIPFw0ySWikvzpUTGfrPWT/nj3czumR0POCiGQftTl/8D71KbtiTwOAAFARLNMAKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553660; c=relaxed/simple;
	bh=SD7mFn3Azck8G6ddO0hF8piSL6ovIEwmDhL2dXByvlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGa1d44p5XTj4jRgyX/rFQtqdGmBAqLs7LmyjjQ5wd77+YbVvVIufVrBFW+jdhC7zuXPmGo4CwgEuVTePkm0LOuD4E+U4qrTxxEYS4ECgwnoGIEvLF4YxjTi8dcJyujTrHbnHHy2Vu0eTN/Xh+brVZmcJulEX2qQCH0diRiXleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nWLQY8qL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R871a31023953
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fYQEo6dIiW98w97foyLVsGnKPCs4nvCityw2Go+JiO4=; b=nWLQY8qLLmuxGDnr
	JIHJrWvauWSgETYrqhPtZC9vlMFGI6Hj8lrQI/7dtlO60JPNh+ijJsR/e1ulqhiz
	uqOPzMCisa6glDP4LDE6CXa5TJV3S/dDgbbtv9n08XHmMxnCVXtMU8NfGLPHhu+t
	fZwDw3zJwb5rxLIW/RQGGn8m+12C5wIqhdP12V9i1m+hklhlc+FL1bWSZLgl7BxH
	4fcrkhERtG7O0dXUoBZstWZMZCGDNo4OtONZedvYnMLo4SYaq85ZParz+dhTB9zR
	aoOk78+nK/wM0pWBYCYJiru/L6TemfQxBMD0JMmnOiCsqrEZWW2lGLQ0uzMkx0nw
	spg2Gg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6ksm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:27:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87bb67409e1so9699126d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553658; x=1762158458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYQEo6dIiW98w97foyLVsGnKPCs4nvCityw2Go+JiO4=;
        b=NcyUxLDDmr8ico+jM76oR+eqAUnz6TKGjxTdjLUonQ5qBPEkihycXtgV48yCxZHEUW
         ih3TGJyXaSr8OtX8yB4FaGPNBrfGtvkh77+QYt5PtNdbotw1scsw9bV9uQRnnbOnFEw3
         S8MgJ+2YS6vion1OKEd49rb6M24UmR86Jn2kbW8DSl6fI6v0d2xPjzBAqOoxYOMOV0G2
         T0a4CB0AB+ZTSbbzvsReHDWVMcejSjvXBbYpxzJ50QqDjORs8pk7r4VMlJG7i4nqYPwV
         JRvL8mjS20h34uhswK1ijpvEqWEa0FdyIESXr0ds2bWpvyE8wvg6bKJpXkVBgezIkmkf
         fRyg==
X-Forwarded-Encrypted: i=1; AJvYcCWjrI/GOQf99bc7glhF6IaYklyWAbI1/J2qRo7cE8w5/KAeIF/dVW3JjZeWLk8Z1kDyNIQDF5dcmCDv29I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHVnpsD2HF+jg9JLJAISvLCDhatgv9EhKC8gCjVwsVvWITdGZ
	ChTQ4bWB3xwKJw1QBJgWq2Abehkuq0cAQ4UPrDuhlFUqobaeM/H9FrlsChlpt9vAWTH8qbNpgw+
	CQwAaEiJLABLjTYZTTYgWSfolp76nlogKX1f1/ngQk0nFkVAbjlaNHfMtfdUOBhOqljs=
X-Gm-Gg: ASbGncsrSSnJRWLXnQdEAKa/KSqCYOgzdTZiNfP8voJMRsy8bmwS+J8ox7Bh2VEx6XT
	17u9I4qDiu6YMLy4F9stzyZF4kLsyoKZEfhUpIMzeIf/IKoT8yJM9G5Axscs4kmpNyYptAOuap8
	IMDPpYXwfOzEVcX8Z0L/A1SJJuqKO0vtIL97LwnUXL++uUlBS2jidHBLQ9UU40/Qy0kSpyGlTaj
	d6N37mzoKdZKYYsXxhQGwoJdecfsbjT1YgGmV69GZlWMFgNIyhFKts1kvHu4cKHvCNrbLm1qrvX
	JcLXGkrQfGRbc4y80nPrd94tnYV+GxJ+oNMXZRderSPENUS1LqT1j0w7z6dRPtXOUufWKfCCVPr
	XEs4Ij35e3TcNtPrDKDlW/KkbNvIFD8U5hsmZECGi8sSNIoYxeYWayoqE
X-Received: by 2002:a05:6214:19c6:b0:87d:f8d3:2456 with SMTP id 6a1803df08f44-87df8d324a4mr156569936d6.2.1761553657640;
        Mon, 27 Oct 2025 01:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw4iXYcaTwz3Rp3bM1QNtADojUTF4L8DQ6lROhsJhLze0SnEaWSmqFqR5f8Qej1VLUJuyOjw==
X-Received: by 2002:a05:6214:19c6:b0:87d:f8d3:2456 with SMTP id 6a1803df08f44-87df8d324a4mr156569726d6.2.1761553657204;
        Mon, 27 Oct 2025 01:27:37 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853fb3bdsm695248266b.52.2025.10.27.01.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:27:36 -0700 (PDT)
Message-ID: <b622f606-e9c7-40b5-b05d-4f011a98faa5@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: qce: Provide dev_err_probe() status on DMA
 failure
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024-qce-dma-err-probe-v1-1-03de2477bb5c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024-qce-dma-err-probe-v1-1-03de2477bb5c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3NyBTYWx0ZWRfX0ikBgF7bQned
 vzC1JWILJV46/jDgfl96V9Y+BAXwn+bKAbvr/t9JsBqe6RzHPnq7f3yea99I2KtN5rxKR6pMb4o
 +y8F+KmJBEOx5e9ba9x0mUq9fRNiF6hm0bl7pWBofmy4kAXAvSPUvZEVzs/GI4CdT5H/Zh7zhSQ
 nM68kPBNOeBcTUgu6gqIgqY8rRjEHtj4++h5nMk8W2XQk6GvM9SvPajsYAmBf9fZTHSBAzYb3k4
 fpN557jBYORDo8d2eUYQv1i5eZk2ANDxbAGO4jog63G4FEiGEIsJ64cD0rv/1dFw8Qz8pOv84Oi
 QwgJsE8DOkf1zr55mhD2NdMqFvskF1b/0e1k/R40Axxd7U9r5v6ugE/KwAMhf1Gqt+wptDNoX6u
 fJPdXTsET9oqlwY3ViAtoP44164HkA==
X-Proofpoint-ORIG-GUID: SvJ5juoQdUGcvnOxpXm2XZ-tQNjpArGR
X-Proofpoint-GUID: SvJ5juoQdUGcvnOxpXm2XZ-tQNjpArGR
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff2cfa cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=25NbGeS3ZlacgUnTFUcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270077

On 10/24/25 11:35 PM, Bjorn Andersson wrote:
> On multiple occasions the qce device have shown up in devices_deferred,
> without the explanation that this came from the failure to acquire the
> DMA channels from the associated BAM.
> 
> Use dev_err_probe() to associate this context with the failure to faster
> pinpoint the culprit when this happens in the future.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

