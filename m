Return-Path: <linux-kernel+bounces-886257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEDC351A2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9BE4F72FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E630277F;
	Wed,  5 Nov 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prQuvqIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PT38v7l6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921B30149F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338518; cv=none; b=igAa4JFCeIaTpe+56UKuwRKX1Tv1qmq2xHGf/WQHTAMRRN+C1adxzQFOJDNJVYfNN6Mky9rfjcH1NXjcY7XEpQIg/YPa9GGqa5jDeKMbgbCGq8KYufsROwgu/m3+To3qKChjEweszxxNPi8yeqaWXHTV8JDlexjU88sD2vl+gGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338518; c=relaxed/simple;
	bh=bHWQGXUwyp0HSxQyUXCn4pC6y2/RjEnuZm/vTzwzUis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjrFdvjPj6rVFDBce0mUztqANZWPfLZ30PA0lW+oFs39w4V/PjkbsFx3Z35BPORy70RaGcOKxLtqZQLz0nkNuZXXGDC/8zb/+uZ866cTbdjb9M3ELU0y3I83K0vq8JA2aJmGbMyTDubKMH8CmdZ16TtjddYo+CiKOZKJkr0N2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prQuvqIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PT38v7l6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A54Y64d4011438
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 10:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JF+KpggyAZ/ITnvctK4l8SdHIQOwsXYkgFSK64qTgoI=; b=prQuvqIY2Amv7BYe
	cVEn7aZ5txx5vMjo3H/OZ/QYLOQJ2/BvymOuzcAhAesQg0BHcCGsi+dwuKsaQEoQ
	Cw2/QjIyobAfPE1576rdNBI3vH80JpvwLnh/MbqSFlNezHVsM49NhGfxqY0ILA0R
	vq/lGyY5bKiJAhO7d7ZhcXzuePYzfFN6ItFouYOAWskDar0pK7WMSu5CUUrfYTXx
	ouZfweq0n+i0bBRooAwE6KKrakOgnJmryOeMjZhVRLi/d9b3N+ivB72jD3BK3Tjk
	1up7kXC4a9WZK4t10QVgChHcl7jXXLSItX7jY8tgN4ZyVMGKVngGOMrodpi72iNl
	kFK+1w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ynwrwkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:28:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3418ad76063so1702721a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762338515; x=1762943315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JF+KpggyAZ/ITnvctK4l8SdHIQOwsXYkgFSK64qTgoI=;
        b=PT38v7l6KPQDnln6ycL+gvRzsKo5gtbr2ymcN68mFCDKFeHS9Ti21ted3wu1KXYraR
         M9I8eq6vTt5/WiDXmJVYX+WRQcwJT29aQE5XtFBuZMRcjNLJWqUTro/9XykhJH/uiS63
         hbXOT8Zl3ie8Ycin8Hps1vGQ/U80Q6Qt+kfJu4QmFZQHJNFFS+RPxEvLVSLynh9lXnhq
         /BZfXUqjzejT03HRpidi0By7lRxnqGXMQnd0qUKZjEMyakUGcdRq1+u4eGo3Qf/UmXi4
         lP5CKQgFEBjZEIjcF7HuqD8PKn2JB/sXWZ0PJLGKYy8n1xiv+gJfuChjKt0PdLk2gDGu
         0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338515; x=1762943315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF+KpggyAZ/ITnvctK4l8SdHIQOwsXYkgFSK64qTgoI=;
        b=BGa4dooVKU4V0SDqrFnempTCLEaQdLgVQZXJQuNJpOtKT/1baubjnalS2qwSrH/9hu
         ZrUm0Uqpp1NjW4O7ztqgkob43ePcFsZ7aUUnGocT17AmRynjXX3aLbEH3OIufBzr6Kho
         ORSBanLhAFYcd/iNmSSurYOrrgv29Cl+bsdJIMKNETP/XLv2od5Ng3xfJK8WAV1PnL15
         AUwN3jdS6UCupsBbCPxVBn0xsg9LMzSvUlHxQUUuV5mUQIVNC4td5Y7aZMKONyuT1oBO
         Ts0ouXZiUGYYPK51ARBjbSkxV3BB+G2rOM+2LFY7REpsjJwXN5LTDPvunljZ3KcwxD6d
         kBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRNviTIeUHUnNz5O3p9RPwVKXQNsZlGpy13DDWCH9bj6lt/eIawGk0imMQ6tL7QMehqj/tAjulUWcsCCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKb+reEk3bOi4MDEfguoDZ5EX3A7OcF758SWBgZksAYi2ukngw
	D0FLnCUn5T7VqkAC4F3Z30melQgAAkm/GOuhSO1XEkRSgifPpFwvDn7ikFhN6+JiZSIajep01Mc
	Pf7OV5vUbXF19lQhFJfbSDJ2R8bTv99bgxNv28hOIiO3w6bq4po8DgSRiDY0yX6b2mtM=
X-Gm-Gg: ASbGnctgs9nMMZczdOOel1/hgd2ff6reXIyzIYbpG82Mil/vjmQBuwuAr5L3Jxkodul
	KA/LHRHPrmTtp3HqIMVl5T5Dlryb3DhBFyLFi5yVo6Bx2cx0iXZAbJf1IYqPEdUbFrzXN3InC1n
	K2T4DVWLYqVatphc//UP3xO28DavA+IDgjwjEXNb7MocQZKYumaDG3Pe8Zq9y8GwmJ3O7VqfLF2
	WRbKkIS3nmqeHoDae+5eSA2wNoDEmvbTdlAfCZnjADDFV8j9Ngt7RoYCu+zAmd6gDhaEaxIX+dn
	7/ShilR8Qt+sMC4XSjK3ENfIN4iL0djGlJvP4m7Wd61ZjLuv18ug/4rb6NIxcX8E5LvW9S3doL3
	i5MeqdJe8XaRUpUEdSJYmi4qhtW/E8Fqkqw==
X-Received: by 2002:a17:90b:2e04:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-341a6bfbc5cmr2752090a91.3.1762338515048;
        Wed, 05 Nov 2025 02:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0nab8d2/HqREAsJ22farB7T8O/NtwdkVq1ttqTloYL9Mn4A21uAb5ZKhKlMroMgSfVGcy9g==
X-Received: by 2002:a17:90b:2e04:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-341a6bfbc5cmr2752065a91.3.1762338514552;
        Wed, 05 Nov 2025 02:28:34 -0800 (PST)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd324680asm5909209b3a.1.2025.11.05.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:28:34 -0800 (PST)
Message-ID: <77031db5-a94e-49c3-b48f-5f7a5569d1a2@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 15:58:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: make sure I2C hub controllers can't use
 SE DMA
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Wolfram Sang <wsa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20251029-topic-sm8x50-geni-i2c-hub-no-dma-v1-1-5e264258a5bd@linaro.org>
 <49f067c0-20d3-4039-95e6-fc19ce48881d@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <49f067c0-20d3-4039-95e6-fc19ce48881d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3NyBTYWx0ZWRfX83POw/ul1ur+
 nfj4y+DhsSP31PMaTtgSqpJUlfAb6a/ZI9XGSEk1Lyg7rQWC9LT6d7iYwgP+gP3KXPF7Rh7eqGf
 p3d9xo0wavPzCheE+S22prDrdVYeWCHsUqsZLcBUq3hLxl+1WoB9eZ6FWleAdcEF2EukXkZvB7p
 Hyjnj6mzFJqW55vHMU4XUZrRIBBD7Qp2roCIrcvnxIQO27wyY2R+wpxEpsUanTToJfpj7xBbiDK
 3Vhb74cxuTlh3Ers/NmJEIps0701YqFD3NOJAfR2SNN4dWcZR04uM7rREjts6P81USIUD/ZH3TF
 5ejMPStDFxuzjwe+hkDLu1QhIZW7GtLhcc0H4BMQoQlVgpCj/99OEQeBNm/8x6C7hE42ExjD3Hr
 Kak3o0l3beRLcp82HfrIYQ0AMpIV3g==
X-Proofpoint-ORIG-GUID: Ap_4WYXS3dXIlW0t25QrmejXRH1-vYFI
X-Proofpoint-GUID: Ap_4WYXS3dXIlW0t25QrmejXRH1-vYFI
X-Authority-Analysis: v=2.4 cv=IpETsb/g c=1 sm=1 tr=0 ts=690b26d4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wCNI2q6YBtXYwDTL9A4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050077



On 10/30/2025 2:56 PM, Konrad Dybcio wrote:
> On 10/29/25 7:07 PM, Neil Armstrong wrote:
>> The I2C Hub controller is a simpler GENI I2C variant that doesn't
>> support DMA at all, add a no_dma flag to make sure it nevers selects
>> the SE DMA mode with mappable 32bytes long transfers.
>>
>> Fixes: cacd9643eca7 ("i2c: qcom-geni: add support for I2C Master Hub variant")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 43fdd89b8beb..bfb352b04902 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -97,6 +97,7 @@ struct geni_i2c_dev {
>>   	dma_addr_t dma_addr;
>>   	struct dma_chan *tx_c;
>>   	struct dma_chan *rx_c;
>> +	bool no_dma;
>>   	bool gpi_mode;
>>   	bool abort_done;
>>   };
>> @@ -425,7 +426,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>>   	size_t len = msg->len;
>>   	struct i2c_msg *cur;
>>   
>> -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
>> +	dma_buf = gi2c->no_dma ? NULL : i2c_get_dma_safe_msg_buf(msg, 32);
> 
> Not a huge fan of putting the ternary operator here, but I don't
> mind that much either
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>>
> Konrad


