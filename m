Return-Path: <linux-kernel+bounces-753260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F81B180B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81F97A71CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A00239562;
	Fri,  1 Aug 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ly1LOp5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC371FE451
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046534; cv=none; b=l5IqCkUA50btlQspt4PCzgZ0sEN0QnlN1fyhC59jvvzMgq81dHU13QiYLsYq/DbJprzuhQf9iyAUFqVp4lIlCfQW/4jAZxweUH5c5+MZdEKD/qtpFcBLJ+YYtJxo5XESVQdj2RvHqbDZPHXE4OOZBqnWNC20TNsoDUpazHBNvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046534; c=relaxed/simple;
	bh=K9kMdMiREJHRfHZz8ziFGRHoECH2WRdWW+zWvnvv0xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqLeM235qTxc/lOZm4IYyzZmBvvF7GDMhg09L+HV5QyPf9zTiVXwYQJhphQMFUJik07IIqIJRIkV/xI791DnmHipDYdU4Gn5+B8uCi1h2cQOBR51QEbdLgahXmUvaLXtb/qhTWxzFCcy3K8g0hH5OcewK0tf2cvZlT9OV64dPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ly1LOp5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719Anlk001726
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZlE3qV+mNzUFwPUF4H6oGbnl6uDJ+rl7UeaU1GTP5vE=; b=Ly1LOp5tDiRfbOpU
	cptFRkB/Awc/tBPOP9meaq7H9uC7/SpkHjGWCSh8aqD98ZPot7EwSPl9fYNJErtf
	ngYFyYtyV+s0aafgcLHAtKV4/dILGPnlqB+uy8sldLgpqt8GokYEK6bZ+V/YMiqK
	54TzJQJC27QhQedkZA5OVV8MopM05ilCLxCmD53j1/9i1B2vbMkwprVRHHptG8oD
	z+AjiiUWhWGs50TfoMcx3WxKptMQSCtzBV+IlbL3Gx05EdAiSdni5eiaRrBoq293
	h+yozGlgNMFTQozg2TX5dW9yh4kqvDQf5JVjusjtP9OFf73qflAUc3FxaAN7Z2a3
	6rVL+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyuc2ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:08:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab65611676so6037691cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046530; x=1754651330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlE3qV+mNzUFwPUF4H6oGbnl6uDJ+rl7UeaU1GTP5vE=;
        b=Ya6LWiUQH41d7cgAE4O825EyRAt5/5YkAzr9ZI8zrNNKjaJBIr0g/J2RY9UiKHWa9e
         WakxC73RlNkNGBD8WptAvaiBDzw/hc2Z2nVwaU4viHOBa5wANLgcbwLQ2++Nj7+ydEpP
         P8vN+CLtryBnabWx1NHXAG0B3P8rok7akGgkcvfrddPG9r98L05PuPE/FsGdgNOvWdqy
         QoDVNQjbWSX5dMwHWm/e0PJrck9xGCZcYOrOZD+W35BY5UfTHwm/sa/pZ57HyTZBhBHo
         LiJLrxxZ+xjgA6zVN364mjTZyzjjibB3M/kb7kKqKLNeZ96p3Nle05cY3SiS/m81iqrd
         8Syw==
X-Forwarded-Encrypted: i=1; AJvYcCUoGS3eyosGa8uJS7HHb1bFEfvBl6SvWX8v0cA+Kzb7pJ6RWZ1LKZuZh4NsQArsWuA86zTb4meb2/NzNB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2o6F4xqgoqL+KWpF9uWcHZwOJ9tnNBWA8rG9rYEEmPovu26/6
	D8H2xCUfT2V8agL11l2mqt3DXDoneL4vh50P4u03CGUP7DATTPRhIEK2hvjtTtIXUvsbafeBKTI
	l94EAaO6ery5MBRZjlabtVxy5kFDt6n/yHM4Nk58+iWMURd+oEgLGMoX1jzZiaHnKjXk=
X-Gm-Gg: ASbGncs3RDEEzKawrJzqIEnXDp7vF+iBxm13Vn8Z17AxaVWs3ICG4te36QFnkNK/M9d
	xBEC803uPb1GsCC02EKtMdqRKjy8o5of6Bmu0GIMvFNLzFlCtOU9Sx4rWAczqDm/GNaku87Y5ey
	RmRJUQ/GordcnPaTRO2jmd4sW9idsKqHc21J87AMs+shayCzHTiepdXamNrJRbdI8Hds5zaWaJA
	77pNn9GhaBLL4VvJhxgwThNks7jQ/2Dda618eHbkxq2lE3pAYok46nFcE/7NHD1r5qn171oYXVv
	0X4WK+z/1yGgNiZ30qd6OQWieVL1dvEarRfGpkcEY8vwSlLfC6EpWCVKf+050syUsAeKs6XlG79
	fPsTF75Qd03d6YJ/gLA==
X-Received: by 2002:a05:622a:a20d:b0:4ab:608f:6d03 with SMTP id d75a77b69052e-4aedb94315fmr68387401cf.1.1754046530018;
        Fri, 01 Aug 2025 04:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHupyCwnbCrxlapDopTrC4Nh8m4/FCiCTtKv/hxGs3Ym6bz49WKmPYNy5lMAm01SKcOzpjC7g==
X-Received: by 2002:a05:622a:a20d:b0:4ab:608f:6d03 with SMTP id d75a77b69052e-4aedb94315fmr68387141cf.1.1754046529583;
        Fri, 01 Aug 2025 04:08:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076aecsm270172066b.9.2025.08.01.04.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:08:49 -0700 (PDT)
Message-ID: <b2e4d6b1-25bc-4b2e-ae54-6588f1573131@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: use correct CW_PER_PAGE value for
 OOB write
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IZMY7t10_QbeW4FwTP3_c4ZwyUBYIM88
X-Proofpoint-ORIG-GUID: IZMY7t10_QbeW4FwTP3_c4ZwyUBYIM88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfX/NFNPQxsg78D
 ZPaxWmAizu72ad2xlnLeLeVaODfPfEhLTWBUxlsAV/nWsFKEcPJioVhvFkD966sB2UbTeZ6uIEk
 tpFsZRMfEN5DRMrU6XCWe5kpAjr6+iFU5Pow6A0MsftlKEdsBN3ORR6zaNQ5mpKLei7eFnvmVYx
 ZVy+pTM1W4/vqfhPFYaPfLw+wqQ4jqObMMGzDbKd2yvH9umdpljb6nxDx3q4h3l+yWiybmX/kRg
 aJFhQLPesnjdKd/0bgjUhrPlUrlqjMes3SEbKSqSzaESSRCdm08iDoGXB1dpEbxigRh9DOlISvT
 IhbkV+6xXFnp/i8m1H5nWQphChcpPOJRu6RrPoN05Un2RrcRKhZP2/mF7Jj9hthvHBqCWadKjQQ
 ryKuNv7BnbiFopb1veP3+M4BUu1a3sIxaPGebISUC2R41HqeaOrQb67AMUqGYEaq3+xYHZE2
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688ca043 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=OccjHAaS2H3VFpHfxMgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010079

On 8/1/25 9:58 AM, Gabor Juhos wrote:
> The qcom_spi_program_oob() function uses only the last codeword to write
> the OOB data into the flash, but it sets the CW_PER_PAGE field in the
> CFG0 register as it would use all codewords.
> 
> It seems that this confuses the hardware somehow, and any access to the
> flash fails with a timeout error after the function is called. The problem
> can be easily reproduced with the following commands:
> 
>     # dd if=/dev/zero bs=2176 count=1 > /tmp/test.bin
>     1+0 records in
>     1+0 records out
>     # flash_erase /dev/mtd4 0 0
>     Erasing 128 Kibyte @ 0 -- 100 % complete
>     # nandwrite -O /dev/mtd4 /tmp/test.bin
>     Writing data to block 0 at offset 0x0
>     # nanddump -o /dev/mtd4 >/dev/null
>     ECC failed: 0
>     ECC corrected: 0
>     Number of bad blocks: 0
>     Number of bbt blocks: 0
>     Block size 131072, page size 2048, OOB size 128
>     Dumping data starting at 0x00000000 and ending at 0x00020000...
>     [   33.197605] qcom_snand 79b0000.spi: failure to read oob
>     libmtd: error!: MEMREADOOB64 ioctl failed for mtd4, offset 0 (eraseblock 0)
>             error 110 (Operation timed out)
>     [   35.277582] qcom_snand 79b0000.spi: failure in submitting cmd descriptor
>     libmtd: error!: cannot read 2048 bytes from mtd4 (eraseblock 0, offset 2048)
>             error 110 (Operation timed out)
>     nanddump: error!: mtd_read
> 
> Change the code to use the correct CW_PER_PAGE value to avoid this.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/spi/spi-qpic-snand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..5216d60e01aab26f927baaea24296571a77527cb 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -1196,7 +1196,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
>  	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>  
>  	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
> -	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
> +	       FIELD_PREP(CW_PER_PAGE_MASK, 0);

FWIW I'm just a fly-by reviewer for this driver, but the docs say:

The value is the number of codewords per page minus one
"NOTE: This field must be cleared for block erase operation"

Konrad

