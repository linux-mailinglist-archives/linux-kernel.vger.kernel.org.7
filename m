Return-Path: <linux-kernel+bounces-805056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD3B4838E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442DE7A7D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90222236F3;
	Mon,  8 Sep 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LnP8YBIb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC636B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757308344; cv=none; b=r9iRygWLkNTbiToqvQkBx/zmDgGn3fpvAxsBD6DcXGIxO4eDsBtg3KmacFtTOmStGWLHu+fctt17wGNGXhUhmc1FYyQ4HasJYaQCfOEAdthchZYvsgmFApEYx6xNCKU6w6zKnK3238e5FaW3mcLR7nQ9sgrN0YjjMuOIrIjbAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757308344; c=relaxed/simple;
	bh=chHFdSgNZ1Tt/TM7JqxmS49V/jDCc50I9JRShzuwISI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJz8uDTdL9kwuagIG4yiUybz6A0VwcwGzv3F7jCnVFfukUbvD9FJpdsX4ktGbPV8Rq4244YbtKax6/fVFEaLlMxsPpr4oGEOUvCYrdzrl3OPDLc9WHuIQQRlSgu/QnpSX8KXRzm/HsRQ3NSOenQMcVp/0HyYtFIpm8an+eh5BAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LnP8YBIb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880P1uD001510
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5W1iQ3MLJr+HmBQ8m//bgdDxKVBzjD+FmgkBQf6HICg=; b=LnP8YBIbCz210b36
	YKIq5DJH0+aW+aHpYoeEjp5Z1VYQnOpRAUhZvoltWyMzWHTKEYy1NtKbmCYlLH3W
	aXKObbQG/7CMtPU3RDlGFrhG1DHvyIoy1C64oaqoP6/pNbyTxkY/dLY9euaJqCNj
	Tc9RqAT5WS9UdH9bX4bG78MYWZ5G2ZXb28xcAtY9uXVdc0G11CM0JkvkF/mZG/mV
	D3ooxS01W5yRJLLAwnCqDrSH/VVSzgHUfv5PR0OjZhO5wHmG4q+/DHYuCUTsPcti
	Rfxvw3bwxoldR8WTHava47QistU9mpU9UBI/Jry3wDwlFOGtU7kngzKyiYVvE8ck
	9B28bg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8uchy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:12:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7724487d2a8so8179584b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757308336; x=1757913136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5W1iQ3MLJr+HmBQ8m//bgdDxKVBzjD+FmgkBQf6HICg=;
        b=h8QtDyMQvPcKXe+n71OVXjYe6NGCU9BfXrQEAt5udpO/0KHEM54oAcORe1+3a++Ybe
         Nb5pBPjbuLEaui0jBFXHh44iEc4fTY77rATZCSjBCmTDAgnDbJl5cVS5KmiB+m20ajwv
         2aU4Zfg9XUIuvS5eEMxNBTNBEopoKxCsMNhs+YGqa1TihRKa8lFlQ7cGSxE5co42lXNN
         +aKDA2LzpZlrOP3bK9q/Ut2mtc/DLPbbEN2AFXAHfDrCQfJkOK1ik1ue/wR/zjYTqYQ/
         fGvlpWFrudgrnAnqS4NEENtf/28zTnrl2uGsP/zSmE0TOLtnDPO+qfTHXPDr4JRA5J9S
         xa0w==
X-Forwarded-Encrypted: i=1; AJvYcCUGLqHhzD6A+fg94nppa1TcWU6B/I+ao53CwMLxXb31D9hcS0J5Fkge/8og95X2CR2d3tX9/C8jXcwkj94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVCJAkKyEUGLgOCXqWhJ9raq2NR/byeXFIZFGE9R4BBusV5YU
	6GbSmsL/2mjw/gKbKAI9xIpAaLG5XPYmHv8yHFpKHIe5NDAE8m8iqW1HXChbDpue5A40hoOhsO7
	BM8WF5ysleB5nRy9nBpUhuPRvQbjp7QgXd4yzuEH1+h2x1xx0OD/b4EGWsqF/vGJn1qY=
X-Gm-Gg: ASbGncsIRFHsf8F8n/M/APQU8JTprevl1TLm75J50CJBPvKxwGTvIdx/QGhd9N0+GC2
	HTHZPZvhmOQsRFEmQEra5yLGs8u4W8aPgkjLnsyvSmiONJOi/XYG7dXVUjzPgbsFFHXJvVcZBlA
	PemkAGQR6N44nrIN0QcrmwfSMlI7dWJ3+0g9gGiOhMOpmXuEX0D50ZMLp64LoYQmgT0RAdVmo22
	Tj1d8dyzgcDXXP2ZdW5dgFv4S1mSeHgmN2I0OGEOkw+zn8vkDXpzeus5n9UDGRNz2Y4Uob1xsJH
	5xSDC4z3A+HfO5po33ZVsD7Uu52wlzFI26N45xcE7T/EIdM2YTP2j6FRdQ4//gtmk4OEyds=
X-Received: by 2002:a05:6a20:12c1:b0:243:a190:149c with SMTP id adf61e73a8af0-25340b18f5cmr9589806637.27.1757308335829;
        Sun, 07 Sep 2025 22:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcobsSnfGakO3F8QbsZWMS7rekM1wlZPOOzIc5FjpObcRY7Bs3QOX0DDBjs19qqxadtd2DHw==
X-Received: by 2002:a05:6a20:12c1:b0:243:a190:149c with SMTP id adf61e73a8af0-25340b18f5cmr9589771637.27.1757308335266;
        Sun, 07 Sep 2025 22:12:15 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4ec3a29e16sm21338075a12.24.2025.09.07.22.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 22:12:14 -0700 (PDT)
Message-ID: <7250915d-4611-4f81-a46d-b85e76185aae@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:42:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Update context ID mask for polling
 mode support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
 <20250901053336.3939595-3-ekansh.gupta@oss.qualcomm.com>
 <dqkd4jxzrn4l6notk45udbapcan7icph5lpaoccgenm53kt4me@n7sv2rnf37im>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <dqkd4jxzrn4l6notk45udbapcan7icph5lpaoccgenm53kt4me@n7sv2rnf37im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68be65b1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qNwnL0dspBSjYX0ecmAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: NifHS5qnXi12OTZZktfHj6IdqnYQCMUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX8XK9LAQCXd8N
 TSJVAJv/lYIF2rNf2W2VqlAOkjgAcxIx6G5V5Y/OSRMnWDkR5W14BgvnklufeG7mTcYaGnVqi5V
 NrjZ5d6RhprKM4hiDNV3ZF55txYLlNN8pZ/hC4/73LfrJYQpSK8JtPg+rLaLuQg6Pyd5UcQdHBy
 BM6Q22YcZAyMGwXy+yCnxrUclukDFC1XqjkPFDk01Wm6w48MsBr5gxSf2atgrR/Lxf+TOZ2BE0b
 lL9U7H1bXjXoX2ug/GqzuaiwVyuDUIleUshrlNzophNIe5K1/J4t7xBa1J5zoYqZw1AJamClVUN
 Jq6sEx/F7kd9efmqtUhtm8aAgn+f5PycOguiCdDdee767+IHvV7bym4qzSeyTUYu9S46vhuvqXr
 0h6t8fnT
X-Proofpoint-ORIG-GUID: NifHS5qnXi12OTZZktfHj6IdqnYQCMUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/2/2025 9:42 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 11:03:35AM +0530, Ekansh Gupta wrote:
>> Current fastrpc message context uses a 12-bit mask where the upper
>> 8 bits are context ID from idr_alloc_cyclic and the lower 4 bits
>> represent PD type. This design works for normal fastrpc calls but
> FastRPC (here and in several other places).
Ack.
>
>> doesn't work as expected for polling mode. To enable polling mode
>> support from DSP(DSP writes to poll memory), DSP expects a 16-bit
>> context where the upper 8 bits are context ID, the lower 4 bits are
>> PD type and the 5th bit from the end denotes async mode(not yet
>> upstreamed). If this bit is set, DSP disables polling. With the
>> current design, odd context IDs set this bit, causing DSP to skip
>> poll memory updates.
> This looks like a description of a bugfix. In such a case, move it to
> the start of the series, add necessary tatgs and change commit message
> accordingly.
I'm not sure if it could be called a bug fix as there is no problem with existing mask.
The problem is seen only when polling mode is added.
>
>> Update the context mask to ensure a hole
>> which won't get populated, ensuring polling mode works as expected.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 0991ac487192..57e118de6e4a 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -37,7 +37,7 @@
>>  #define FASTRPC_CTX_MAX (256)
>>  #define FASTRPC_INIT_HANDLE	1
>>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>> -#define FASTRPC_CTXID_MASK (0xFF0)
>> +#define FASTRPC_CTXID_MASK (0xFF00)
>>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>>  #define INIT_FILE_NAMELEN_MAX (128)
>>  #define FASTRPC_DEVICE_NAME	"fastrpc"
>> @@ -487,7 +487,7 @@ static void fastrpc_context_free(struct kref *ref)
>>  		fastrpc_buf_free(ctx->buf);
>>  
>>  	spin_lock_irqsave(&cctx->lock, flags);
>> -	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
>> +	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 8);
> #define magic value
Ack.
>
>>  	spin_unlock_irqrestore(&cctx->lock, flags);
>>  
>>  	kfree(ctx->maps);
>> @@ -623,7 +623,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>>  		spin_unlock_irqrestore(&cctx->lock, flags);
>>  		goto err_idr;
>>  	}
>> -	ctx->ctxid = ret << 4;
>> +	ctx->ctxid = ret << 8;
>>  	spin_unlock_irqrestore(&cctx->lock, flags);
>>  
>>  	kref_init(&ctx->refcount);
>> @@ -2449,7 +2449,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>>  	if (len < sizeof(*rsp))
>>  		return -EINVAL;
>>  
>> -	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
>> +	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 8);
>>  
>>  	spin_lock_irqsave(&cctx->lock, flags);
>>  	ctx = idr_find(&cctx->ctx_idr, ctxid);
>> -- 
>> 2.34.1
>>


