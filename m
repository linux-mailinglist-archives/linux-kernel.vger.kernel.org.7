Return-Path: <linux-kernel+bounces-816238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17ABB57165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A687F3A721B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38162C0286;
	Mon, 15 Sep 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abT6Khm0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1983EEAB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921201; cv=none; b=tWk3Cmz5M35dgfJdRiaWtjL3pqv0EhhPDoe+a4F0zk6u3AEPO0u+XAIrxa24qrKDK+s+uCcInSNkVb+MJm52mOC0My3Ff604N/KSb6y3PnayDFJGH8EMgEAwkqYQq8XCII87wySe9yvu24SmcFkqeQclN8ctVaWkG3pE9KgyY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921201; c=relaxed/simple;
	bh=TDAloO3oBVpuTTrl3BA4hwC058PmyPWVEAQeMP+IKXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvgztTWkJcGUvYgJvISG0jQ5OnYeG7D4VUe7ezIlNjjNqrQY5Xy0yx/JvRp1eCfx0RgksQBtY1paaZe9c8nlYCUWocEAtmk4tQzXP3exlDQVMh5dN6LGJ+vssI8Cg9MxdGXCL9WQ4R4FuaD5ipQp+57tWERM3hRkm4v5tZhNV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abT6Khm0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I4gO016755
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpCzPmMYzqhbsZujBIxXKmlSp31STMAr8Naqc5Hd5y4=; b=abT6Khm0hwd/Wsx8
	iR6BKmsS+bG5ryjH4UcNJ1Mf5mAsfoc0ne8TSQ9VDQADEaPuMFx2yuEtY4eGDKoS
	6v+ovVOm+mn/aCFfIu7G4PyRquWUHS+RKPaQAtiThOlT7vWxLXc/COXc+rY4eDs5
	u9JWXG00K/YcshfFFc7bEXQ+YMUGTXCbCJZDSO6TmpwAHwBo2YCEm2j3wtasq7N7
	ZicPpm28wVpCb+6Uw4AaNW0kj3GPNAzaf21PLR/SXq461nZN4shvOovkZeKcOVOw
	EAKv4bTCpTvKpbbhk1JLLt/i/bliGiJLR1Kqi57iOiwbEdxPaXijOJv/IWWC7Sob
	vC7lJQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snkq9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:26:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7725a76dcb4so2856156b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921198; x=1758525998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpCzPmMYzqhbsZujBIxXKmlSp31STMAr8Naqc5Hd5y4=;
        b=kf4ZzV9vx9LuLlVaH822VsBL6V8s2Ysy69g8P3TlXxGjJ6tkhUF97dJRitPWEQJnO5
         NFIPSbSow9a1kghAm704/tT6sEOVUy/puJG6LYcXUGR/U9qo5u3vk+H9+fjURiqAvunE
         h22/706F5sQ0WIv1CB/cPbLCACUV9Sa/fsicqt9aqvNyBceicqfbQXYXL+ZU2v3FEpEn
         ghanwL9aCaX7W/sJ7gcInqTKesgN43RUr2bBKwNm89vHIrUmxhvioK+iqTBbpivp/ywe
         4A9TbOBycFTGyZMAxd7E9MTT7hDC7FNjbpTxlPDMTCVw+RFMuF/jTfS4BPEnc0jp0mj+
         Hmuw==
X-Forwarded-Encrypted: i=1; AJvYcCW43mFAnBanlLFvCgIV5778IUfQQrjf8IjDP6hBNMuHgTOq7Jn2+tqfYsg4yiXPOBciEHOgiRwGcYRKVvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC/ABc+u+LciUVCFxhVtMdeqGniT+D/vzZi5fn+rlOFaYHihl
	+cPjktH+7kYIn4FreYsaqW1qzJyJN5XHXWl8AdDPidPj4PDyB4x2QK0bia921WlafOtGWUQSsvr
	35KWLlVEIsleldoo4pPkLiZ/oeEDQ7tUgo3bVnw77CbVXqStk8ocQpoiOH4Mr5MNICVU=
X-Gm-Gg: ASbGnct9B2pVhrI/ILwcCnPdCpfSAKKwiPLLnvT53MKxAMGT8HqmLA2xoYREnWccJKS
	+a7v1kexRk25YO/mtCpHYeUuiTdo87DowsnCqP2yoV/ZmknHNxK7oeUruAKgylNsKCLkfucWb4u
	REA8aXeIg3FNONEysAGhvd5lMgRyPdlYYcDX5vYe01jZh1lA062qNnhSBXC9JcSlQrn0jZZpGDn
	YfnMquFyylEcBJ2ayxnH93LGqizc5kUe6io6ghAW35fTs/3LDGvcqXsUSw/DhH1Aiv/7rLDWrmC
	mbrynSLc7B9F59KZ0bdDfspI23/p7OiO5ggsDB6BDLIerPm+EK8oWqEqEeXt/+kiqSl3Nmt+Dg=
	=
X-Received: by 2002:a05:6a21:6d98:b0:246:458:8544 with SMTP id adf61e73a8af0-25cf5d082a1mr21923016637.3.1757921197816;
        Mon, 15 Sep 2025 00:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEewNIc9ydvy5wy5hm5/P36oyXjxjPVG/IVE9AHKYUMCIiJRex0UM13Pf4atLtTuSYn+Tvr8g==
X-Received: by 2002:a05:6a21:6d98:b0:246:458:8544 with SMTP id adf61e73a8af0-25cf5d082a1mr21922952637.3.1757921197292;
        Mon, 15 Sep 2025 00:26:37 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b5568a82sm7028051a12.34.2025.09.15.00.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:26:36 -0700 (PDT)
Message-ID: <6510264c-d91a-45f3-b484-18d334c515e8@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 12:56:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: host: Update session id for each suspend and
 resume
To: Slark Xiao <slark_xiao@163.com>, mani@kernel.org
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250912100827.294443-1-slark_xiao@163.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250912100827.294443-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c7bfae cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Byx-y9mGAAAA:8 a=QnQY4Z2GrxFU2i-fODsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: -Yc8Ecbb__9okc_EkFW-hsjWmPiCRATX
X-Proofpoint-GUID: -Yc8Ecbb__9okc_EkFW-hsjWmPiCRATX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX+HHs4tqbZfCz
 sQoDY58VziUZU7c13Gcy3W4dripE+IzZ6W4fIFtpdBr1vn9JBJrCuASXE1Fq3PrluwV2IdishbG
 LFiqRxAiTLzGtthseMPbq+DWmGrO0caGUWr16ypM3l3sUEU9EmuEqdz9KKVXyUeaMUYGBJkWlWO
 cXqIYZ/5b0avHHD/7NuDS0UlhfzESWvHNcj/C0+9wXYJMWBqkKEB8CSlb2YEQzrhfyWWpum2pgf
 3WnOaVXTR8hGsLBtxDanlEoRyEb3+nq4FtuderC4jU+MHuXVwuSGTLKy/kCnmnTd7W9u3nqUAkM
 jr9YMyETjix0bdeqmz/pcXnvyOftLoYNpxP4VeZtIMPH4wLjXQYSTvfu4/3Q664SK4C2yKkKIbc
 874rhTOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040



On 9/12/2025 3:38 PM, Slark Xiao wrote:
> On Qualcomm module side, there is a UART print as below:
> session id: 0x355fe689 state:2
> session id: 0x1f478e42 state:5
> The session id reads from register BHI_IMGTXDB(0x218), and the
> state indicates the D3 or D0 state.
> 
> In Windows side, MHI driver would update this session id for each
> suspend/resume progress. We benefit from this mechanism since it
> could help sync each suspend and resume progress between host and
> device, especially for some suspend issue which needs to take
> hundreds or thousands cycle. We can easy to figure out which
> suspend cycle get a problem and what's happened at that time for
> both host and device because they have same id.
> 
> But in Linux side, this session id value would always be 0x0.
> So we add it for potential debug usage.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>   drivers/bus/mhi/host/pm.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 33d92bf2fc3e..a6573f687363 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -864,6 +864,13 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	enum mhi_pm_state new_state;
>   	int ret;
> +	void __iomem *base = mhi_cntrl->bhi;
> +	u32 session_id;
> +
> +	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> +	dev_dbg(dev, "Starting enter suspend, session id: 0x%x\n",
> +		session_id);
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
I agree this will help in debugging, but unless it is documented
in the MHI spec we can't have this. Since in future if there is
some other purpose for this register we end up facing issues.

if it already part of spec point it in the commit text.

- Krishna Chaitanya.
>   
>   	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
>   		return -EINVAL;
> @@ -952,6 +959,14 @@ static int __mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force)
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	enum mhi_pm_state cur_state;
>   	int ret;
> +	void __iomem *base = mhi_cntrl->bhi;
> +	u32 session_id;
> +
> +	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> +	dev_dbg(dev, "Starting enter resume, session id: 0x%x\n",
> +		session_id);
> +
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
>   
>   	dev_dbg(dev, "Entered with PM state: %s, MHI state: %s\n",
>   		to_mhi_pm_state_str(mhi_cntrl->pm_state),

