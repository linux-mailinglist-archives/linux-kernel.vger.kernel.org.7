Return-Path: <linux-kernel+bounces-832330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C8B9EF67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26741BC5839
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3232FC866;
	Thu, 25 Sep 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVYNYtTB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24A2FBDE0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800579; cv=none; b=PqHADuywRK7nv1JY0SImuyKeTT0/KKc/2mNHTjIUgADxI/D10uXf53zxo2YbcJtX6Ptvr4r2LlWmxlrKojtACWVDI59JpcqXuPMBKCJkuChoNB1omUi/4XTLIK0N8Ouw2bibCcAKHp+wMJkBToMY7CUhhe7Rx48PMvnJEYOiHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800579; c=relaxed/simple;
	bh=VlRsKP0AlZXEr4syIqGk997jZca3LzoEn8FL2OlekIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icNCo6xnotQMevep3dOPw4YX8chgOX42n9lqxGzlIYNi5aEzaMB1An5xaaUJtYttjZ3UWet/RPK8REPtb8uqTiFiNCeB7uR9OOcUC86a60T2kOAywkmNdrziZ1KG7ITklIttduZ47kwD1YutdRfTVeEUpK0LldT4P3lvnSWosa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVYNYtTB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAC9c8017430
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hyoJlzEOQKYfqNHKoaUcAIRDzSzD2tltxogjlfJtGns=; b=aVYNYtTBYXtSmk58
	7CiczI7tYSwmHc0oxDkTipdO7KsqVRp/KCJNqg+kMobplAwxgpQrD+AVtN2hDZPL
	6Z3dWy7TRVwReegLkdjj/IVuRoQpGWafl2NNnBNifJsyG3T2HW3Qcp3It5ICaw93
	HyrZEJ/vmgaFBTklkFKdHtxSJQTpiogzkmtGOm7QlE+OWY7Ih2AcP85nska6ekuF
	zA+m4WnxwcUu21Hj0d3a+o7Irhzj+gMCOX3ecyf+ytac5b3PgMNPvaXJIaPcOcfW
	SGqy8ZORPEGQNq/OsrUzWHEF0pUVmyrSZPm4LY1/+lTbzTa0MzjdB7w0+m3dKich
	E6uzng==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk18xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:42:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3ca5e94d3so1159091cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800576; x=1759405376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyoJlzEOQKYfqNHKoaUcAIRDzSzD2tltxogjlfJtGns=;
        b=mX5z89eP+qkxPeHGncSZp4BFmwbIWa9hnD+zn+6z9qpRjOXABjPozMpm5yfiFSoonG
         N46ktRUHYczVSN8s90W5qwyC44iutvFCn8u28w16wkyhegBmFD2CTevgpLzUpFHkXHEd
         UfAiEvmZcXwpMpIFiSWmu2UpHe3JPGkC9cMFRY7i5kc17VEZmxsyDEbrSjtvhhNlVCaV
         G88d9sqxfpG3cM5mIox4Temqtn+ZrQJbbvHgeZT++Sj4hgX5SPDSW3bnbFDCXTGDSV2G
         CNoRPEYPLrBLAjcsoxHS8wI51TIEUFd6etnDk2Vfm4wMVlAFpTonH2KRgTPiWryqE6wT
         TgOA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZWLrGdDNBL71yXEvI9SCqmtQMipjGPSP9ZqDz7Yh62pZrdw2NhBxIfifUTMAS9/6q/sr5vv+kqOu9Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8fivkArHJ7Z58Jr/VA0RugAuYYxKJe4aRjSULSy4mU8k/+w+
	lSuFncYNfAMSjsx1ndz34yQY9poD4Wd+NtOidce70M/9uNarCQfitCSY1J+7KFr1qS9wTp6QniW
	9GrfKWfLVFGpvaG4DIVNoxmTXopPu/XfWOa/uCaysjAcAD0R+zfgfjp0CdWUVRxYDuzM=
X-Gm-Gg: ASbGncvw+B5ZLyXuo1WRKQg1GZR5wnirX52zq5gEhvo7Kx1sGXj1XjyprJckycN/HXx
	/Hi+aG8EEQyO8CdzIcQgG5gvtUirC3ZxcJW098BLrTgNAqkrh5SvRGP9gbNXv//1//lvqa27Jej
	Y4hOIEpAFR+pP1951pvfdLyaLnjPJjMtCpQh7jkRcMFVEfc0TC140+53mWyLjRkkk9egPQpMjXH
	Mpmt/JHGaGyWDR4F+SjbYos3YX+WhlPhWxXfNJ5rSKuMtixYlUMs3MH1Oo9Z2hOpTumuHqEzFuG
	R44Z2Bgnz0sRRYtbHuaVcMusMwDSEcKyt0JfK9FEM1erHvUMSwMpTm5Mj0ChXyp2u/Mw0JIOGAD
	xyBDNZ/Ie5hokceho7a+gKg==
X-Received: by 2002:a05:622a:1905:b0:4d5:eedd:6893 with SMTP id d75a77b69052e-4da4b806fefmr26721851cf.10.1758800576249;
        Thu, 25 Sep 2025 04:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWGRWLaOiykmDKGvjnmGh5TU7kHhYj22O4CIawL/S0c53YrQcQatBuiNwrwRSEZhIS+hFkJA==
X-Received: by 2002:a05:622a:1905:b0:4d5:eedd:6893 with SMTP id d75a77b69052e-4da4b806fefmr26721661cf.10.1758800575833;
        Thu, 25 Sep 2025 04:42:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629886sm1091846a12.2.2025.09.25.04.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:42:55 -0700 (PDT)
Message-ID: <b7855860-410b-4d32-afd4-84d61cac4a79@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] remoteproc: qcom_q6v5_pas: Add SoCCP node on
 Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-6-611bf7be8329@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-remoteproc-v1-6-611bf7be8329@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ziYu9SeE_8pXHJfQL_-jyyQDQNPi1tNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXyf0it4FShs33
 2c9IT2vAP9j+1LQBZdk5YnS9Z8DyGmRSOYkJL+ovbPB7E2SRtdSErIvhEf4nIxCwdZlM/VLjZIY
 hgyRHusn+yOXTRbpJZ8IA8WQ6+6rbSV2+oDSm4bGzg4/rs1Ww5Svpmaz9eLnFrgaKC/INqT+Rcz
 LucQiy22puXn/pN8mktornvTakw8uLn5QsIni3Q0Gt6SpujKj/zD4zqYyzJ5GOY/Fv2+oWc0Ooy
 zGdQhDLysYdaINCZ/izOHkwxqnR5CiSupxpAlP+qP16pfmNOy5xTgsXciGo+mKTOJGfBubPr2Be
 9CyZBA3poanw0ihCEYLWtoUbbI2q02Sk1pPfJWUl7RdUfttJbVIvURETqj7vDfpd6XvHIxpYqwG
 KJePogXG
X-Proofpoint-GUID: ziYu9SeE_8pXHJfQL_-jyyQDQNPi1tNz
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d52ac1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pQmoqa-UAMS7fspmYOgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On 9/25/25 1:37 AM, Jingyi Wang wrote:
> The SoC Control Processor (SoCCP) is small RISC-V MCU that controls
> USB Type-C, battery charging and various other functions on Qualcomm SoCs.
> It provides a solution for control-plane processing, reducing per-subsystem
> microcontroller reinvention. Add support for SoCCP PAS loader on Kaanapali
> platform.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 99163e48a76a..5007e1706699 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1487,7 +1487,25 @@ static const struct qcom_pas_data sm8750_mpss_resource = {
>  	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
>  };
>  
> +static const struct qcom_pas_data kaanapali_soccp_resource = {
> +	.crash_reason_smem = 656,
> +	.firmware_name = "soccp.mdt",
> +	.dtb_firmware_name = "soccp_dtb.mdt",

.mbn?

Konrad

