Return-Path: <linux-kernel+bounces-753308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DAEB1815B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A096283F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A822069E;
	Fri,  1 Aug 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p9IN4Dd3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0E1E5B9A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049387; cv=none; b=BFHd8Z29WWY8ucU3RC9cRSKYNWQJtI+zTqk4o3ScIOp+Wd2My9yHDgWOpESZetGxLK99EdII+zEknM9ZMDRXNqfZXFLRM8r0MpSGjj98GNNCc3gB8J8gtEezwr1vOde3Ilsm6TTcGdF6jWLd8MrzluCRWErJByu1vePfMVPEHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049387; c=relaxed/simple;
	bh=6guj5SGYecgvd+Diof6vhKa1p/zkTKq5X83WawiuHg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIOcKAfhXmum3yy4+zZcwHQs7QObMQCWG73CwvoJiyUL3tjbDV3k/L0o/WFXQ9ce9ruiV0s3MF8u/mSUkRxSzHXNifHujt2cxpyJb7XlBzJ3UH35Vk/ipoIMqeEKN86dmpEhFiMv46SCSXkyOB2ILuf5nTXPjjkvXqyr3f/3Vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p9IN4Dd3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719JSqO002614
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zndqvOkOtBLPZgcibFTCnMvRTtpty67nrf8mHn7tQxk=; b=p9IN4Dd3lbFcTTye
	K+bXpdj2dG96CxiXbECJgun+DGtRDE8rlOyp6Ql1CJxvYR1fbvriulvHrDviZLon
	S3q0IPjExlZdre1IfSHMVcwInjl4mTnfRUJS+Rb1RGKYf7tYaBU/GK94jJWy5DRd
	8EE2uDN4p+bhK7ErBOtFh4UZEb08AH100Gynv5P7iIX5vbblqMFa8RQz8JpYYagD
	hpbgxwLP66N18MFQG2aDS5TcGMWZS5NrZ60UKobFIupPisnWSlY+u5i62k+HPDDO
	rQcE9M7THk+S3BukBuosfQ/0CXy85ViHMY8fgjCdMszRkt0iltJKciXh243RAuOC
	/q0Fag==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbmbhkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:56:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707778f7829so1417916d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754049384; x=1754654184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zndqvOkOtBLPZgcibFTCnMvRTtpty67nrf8mHn7tQxk=;
        b=lUjvGkWwzWfV646b7Q40TmglAtET90w4UzaNMV1fbNYWFJlLCpMGxdAl7d0GTFxVyu
         oAG4LI3kV88xv5GWdEi/F9g9hQj7tW8GOm9N1CdZR/rJ8iWA4DbbaXLF+kor7pW9/wmf
         7HAUUxUD8YhHce6sWyvlgW6zrlsMKJSzON0/LZ7TK/dHnBBt9InMGbs/R+1t9f+QHSUJ
         31WzQWV1vNixrDjfHE/S8PPouWcla6UytKn5OmEyXzAdXlEbZ6m59c5OBJVtOfUZnHDx
         0ZFQ8Ds9R9CjDj/WhlfK0OIjKCs+IpARGQzxxL2VnugcQo234PuRdwTnL2bDbhcuu785
         yg3g==
X-Forwarded-Encrypted: i=1; AJvYcCWVbD5NXhm7m3s/YVQh3uWe9NtyQVtya0JZh7Gj7gqigUtBnto9CZWsVQ6Kc/AJsIbeV+ZpEes6T6DbRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xNAQs9d4b26zT92bn2cuHBCIsl12VCqOvGX7nKNTR+FcJDba
	lv9tUFoLI9GyoNSpiwnNEusqiaD6hnnbwwUORD9yBKd752W/gnctJV89Nz3ErknSCh8thzb2Lqi
	4W/Br7ES86rq2TrsMYWQhDHXqMUfjg3t9/38+uC8bvxV9E1XZ1zRPaCr9t90kYu4phoXU074Rgt
	E=
X-Gm-Gg: ASbGnctcKEB/JypRH5nUq8gQq9WZ6vPKLfTP1Buefe7FbzCtg646sOsL+Sr35nqVscc
	Sx3n4qhzDBs0H0gWjEKgvdXbp878AkOnhQMBC7vfbyTvjH4OQEIqw6I64jcKCnPJC2ZFDc1lpcN
	FtOzkQg6gwsdVCp7FPKtgLWhO7hyTdmSj6HFsOsSHkfWtRNkdZgkw3FxLESx0R90FGG+RyWYFdy
	kx14CSYwYBptEzi03J1K2hKBSZuy6zv1oNXA0SGRKEUtXDmTjXyk1/xlNk6NpYtFKFouN12IJYc
	0gvkkIDOHMgBwMXw9MsFB7PmbyQ0nSVTnlG54wNOp/hVfI2A2NzVjZH8gFz3rjvI7li2bVbtajO
	NUIab0+kCgnucj08L8g==
X-Received: by 2002:a05:622a:311:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4aedb9a1268mr83455761cf.2.1754049383851;
        Fri, 01 Aug 2025 04:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJrDwZ4CqsLIhFn16pVJy0wpKGA9BP8YTsdrizbhvNE1Pr9Ax5WAkfuilF6IXeAquepVZw3g==
X-Received: by 2002:a05:622a:311:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4aedb9a1268mr83455581cf.2.1754049383412;
        Fri, 01 Aug 2025 04:56:23 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a313esm277885066b.32.2025.08.01.04.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:56:22 -0700 (PDT)
Message-ID: <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688cab69 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=KpljTfsc1uQhhnHPe74A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NyBTYWx0ZWRfX5alupz+V2jT5
 nlght924tUdbvKjvSMp8aTUhsAqJN4Gmy/jdDnsDEuibmCLEKeRl63NDWJGebCKgN3N0QBeJq7o
 xkrTToVVWMY5Xoga7LTyuZBAVrJIdIgzHs9xhM86jblpZp1m/LG7+/Jxx+uva4xgONeUJ5noUaC
 6m9YetLotI/AmggO9Jh12QXAvws0AR34zp5RoOYcQpQVrU1ldzwV7IRWgiOzGFZc7irU7utwb/A
 Qx4zg3ah67vr2fSJgQaAS0MffrYl0uAE8WrJCacWvXlXFdTIefy6EYo59UEqBRHoEuEZjooQ0Mh
 AaBmuqbqhiX3ajf6Puv5VL6/VPDpOVEI2u0RKPlaCUUZiovplpoM4F9p+4nWI5G2KmKqZ+W8rFb
 kLZZWhr12fTu1WfC0FKsTXNZ3c++jzwBVMFSPxGNM54XsYnXI26XlKi6DnRU0OAZ8D4fLmfN
X-Proofpoint-ORIG-GUID: 91qD66H0iI8kwBG-kxcNDxlpkBhSnqcT
X-Proofpoint-GUID: 91qD66H0iI8kwBG-kxcNDxlpkBhSnqcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010087

On 7/31/25 8:11 PM, Gabor Juhos wrote:
> The OOB layout used by the driver has two distinct regions which contains
> hardware specific ECC data, yet the qcom_spi_ooblayout_ecc() function sets
> the same offset and length values for both regions which is clearly wrong.
> 
> Change the code to calculate the correct values for both regions.
> 
> For reference, the following table shows the computed offset and length
> values for various OOB size/ECC strength configurations:
> 
>                               +-----------------+-----------------+
>                               |before the change| after the change|
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  OOB  |   ECC    | region | region | region | region | region |
>   |  size | strength | index  | offset | length | offset | length |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     8    |    0   |   113  |   15   |    0   |   49   |
>   |       |          |    1   |   113  |   15   |   65   |   63   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |  128  |     4    |    0   |   117  |   11   |    0   |   37   |
>   |       |          |    1   |   117  |   11   |   53   |   75   |
>   +-------+----------+--------+--------+--------+--------+--------+
>   |   64  |     4    |    0   |    53  |   11   |    0   |   37   |
>   |       |          |    1   |    53  |   11   |   53   |   11   |
>   +-------+----------+--------+--------+--------+--------+--------+
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/spi/spi-qpic-snand.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..37ddc48d2c17264499f821d235835c4ff5982873 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>  	if (section > 1)
>  		return -ERANGE;
>  
> -	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
> -	oobregion->offset = mtd->oobsize - oobregion->length;
> +	if (!section) {
> +		oobregion->offset = 0;
> +		oobregion->length = qecc->bytes * (qecc->steps - 1) +
> +				    qecc->bbm_size;
> +	} else {
> +		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
> +				    qecc->bbm_size +
> +				    qecc->steps * 4;
> +		oobregion->length = mtd->oobsize - oobregion->offset;
> +	}

How about

if (section == 0) {
} else if (section == 1) {
} else { return -ERANGE }

?

FWIW the values match qcom_spi_ooblayout_free(), so the commit seems
sane

Konrad

