Return-Path: <linux-kernel+bounces-720766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1097AFC02E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B263AC4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2861F0E55;
	Tue,  8 Jul 2025 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kgFVotnK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E841EA7E9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939046; cv=none; b=tS+15BHBeC5yNjegyhbMeip7U9Ty81Q4Pakfj/P5WfDTHeVtTh4H8SWzNQSj6QH55cBUjJPM5DDOsExgwywl4EawFisboaDJTSVcEX1l383ZDgIL+irQ5b5E38K1Oo+1CySxKy/1+waNBEPkvTHoU7lGp72d3JU6sMcTQbp+n74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939046; c=relaxed/simple;
	bh=ITnGl44Ugo75QxOk/V8xMNfq2AqSpn/y/RhZTD6rxqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu1fbgHxs2siQPer7P4/0fxSllaZX2U2BaaK+DXMlC0WwMdUOWXcX5XYnvZ8Uey9dMh2j/JJl2Jvym0rY+/2oIVnPLAglEeUZi+iZbfGR8Wk3JbRnewnt+sQWYJVL0u5Zy7P5pYT+joazTPbxh52dgVNWfuiHh3PbzKRZZ8x5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kgFVotnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KAMZ0011930
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 01:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yl777uk8TYoa7yrfsLRZl56fRfsxTMHbE+ZHD3LEddY=; b=kgFVotnK2ssORDpg
	gLmjlCNYd4OFkuzOzbKRe8qqIBJLkn0j1WXGhNafywS1pWNGb5KE7DBoxfB1wnFW
	qjJByEcVos5+h05YWtLnduwG3JTKiOt6iJd/KYDNiER5Cce2+vgMhbuEFHUAPmYH
	Ix/kilkpPjssem6CaACpmD22o4+1ipsjZe9tjF9m61Ml7cBl2qzNsvYSu99HC6Tv
	eHuQ40rqmsVnD8PlvlvNKircE5KhWBjsJJbgEFJsxzGracJK5JihALuIkN2XTpgm
	69UmRXZceNIpswksCsWYk0veDSaTs8SFlouKfjgcs4yGQqXZTC8Ji1c+2y54G0UM
	HB9MkQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucmt2hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:43:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so6390054a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 18:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751939037; x=1752543837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl777uk8TYoa7yrfsLRZl56fRfsxTMHbE+ZHD3LEddY=;
        b=uHDI9R4oUiWTiNK0YJCrM8mo/Ux6apRx531EYTd9V+uCZgWlQCIbdHxBRP4lhVTF3I
         nGG1/2Su6ZR+ELMm+1KS93XoOmR6z8peg79ZOouZo90dONCHfK/BzcQLkwFIL4g6gdVg
         wBtYSmHEbQB+bL8MbSNDfJMhuQQjHBtilpw3LEZGY/hXy8SIVFQGNT9g9wptlP1R1LqX
         ARAhCfTznOcc/EkbBSZIPR1k4CVGmNIk22hXKNF03q/d0u6iVaNtzisbkbcZJw67ojIf
         06Vcue903RAKKZhgBROtVAWzIfAl/rWCd+hduAS1QiehKrPIssC8CxgW0Plouz7VPr6P
         aioA==
X-Forwarded-Encrypted: i=1; AJvYcCVenYhSR+sy/yNLmJ080Q9Uu53tRC/S8Vh4hjqYiCfIFyRyoS4QicosmwrO9zZBg8oYLnWekm0XEeVg5Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIx6TxGv5YMe0DhQezaisbFBCWadvnXwYw/zF9jTcVgqZ2J50
	uNbif1pcvPQapYnjWi6P1iDsRewVtuR1n72KlAqt3z+rdXD4bJBaTYVCvDXG4ji2BT1JdxSpDtQ
	DHxMfao1o992P6reFK9q1wyzeU0PJDlkOs7eRV53/Y224iSg7S9OFqY5ILQznso6OR8c=
X-Gm-Gg: ASbGnctC2DWnoTyltvxTWx9ROnEc6KYzzy05Sd+ww6Bdk4s0+dYCk0JV3O7Em9HWCLx
	YzpSFVB5kEREeBq98QMxunbWBxLq8NUd+fld5F8GtaBANkk5NqgjWwafeXmdmSaXwgH8P4zO7Cm
	661KbHTdLbV/f1JNOqmzpQWMuzRlANHEIKqSCmo65XfCOf46DZEv1IADMRljXq7FJi0rXkfVc2/
	bMY4OKLj5sT45WLwqGQ3uI11AmcSaK8yuYGmt0wARX/sv7C0MseYyK4pM+6gCBzBc0LqbyJh4pM
	+g8HTBn2/j99RHdSYkImW1pQR9iDvwjNUYWLIeL34EDm4RfzXJ1KwSbhmWiy4eV1MEreUYyj7dI
	53Ln78eedKtXvU3Q=
X-Received: by 2002:a17:90b:1f83:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-31aac432a89mr19916296a91.4.1751939036600;
        Mon, 07 Jul 2025 18:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhKVpmGrrRXQtES7O9YfBq82/o7OuEhVZMyofryc6rLrPXsT448ckzR8EZfAtTqPI4xY9GZg==
X-Received: by 2002:a17:90b:1f83:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-31aac432a89mr19916248a91.4.1751939036125;
        Mon, 07 Jul 2025 18:43:56 -0700 (PDT)
Received: from [10.133.33.177] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220bc5basm642199a91.42.2025.07.07.18.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 18:43:55 -0700 (PDT)
Message-ID: <fdb9f1e7-bf8f-4018-b0ac-ac8a70d9b8ec@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:43:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
 <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
 <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
 <a92b3d96-0c19-49c2-ad8b-ad31dec973c3@collabora.com>
 <7b8ea9ba-02ef-4676-a4d3-d088920283c3@oss.qualcomm.com>
 <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686c77dd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7V90euPs39zsmW6lzs8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: sTXfPP_jMExOo-fCkpvjvG0S0WexUnQb
X-Proofpoint-ORIG-GUID: sTXfPP_jMExOo-fCkpvjvG0S0WexUnQb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAxMiBTYWx0ZWRfXxGpyENJBhKWl
 lddGBmylT7L6j8AvTEcAh35IxNRk35DrX31NAfrf1F84oklatIm9Saqudatbyb3FYZSq64JFNpR
 0OkNn3G29JtbpSVd67zoXB7qmsGH1Q9ra3iVV6/GggQ7D3P7V3m4TXN7hbe2gB1ma48mRiNiqVk
 0+UXDeSIPBBsfDqeL+toGUHL7JnGP0Y51u2wWP71RdfSLMFMEHsxOgI00QQ3ZvP21Dt35gPR7vk
 2KSnkrbtxOSlyw6U02gg7peCuQpgmXgjWcEyiTp9CkLedsZU6XIHxnFHzkUpkNE2uwUXLO0w34j
 3GD2pNitoyrH43ncbJLE24NXFGx91MOevHqbFsb9N5Orn53F7t5jl9PctsdOuEbCMacMSbtctq6
 xtu6FyOeKjsuOfqapozrxsiqcnUcS9Xq4l/TdNpL3OkL9lbEjp0JdaH7AxVYMuDulBkovvfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080012



On 7/7/2025 9:11 PM, Muhammad Usama Anjum wrote:
>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>>>>  	mutex_unlock(&ab->core_lock);
>>>>>>>  
>>>>>>>  	ath11k_dp_free(ab);
>>>>>>> -	ath11k_hal_srng_deinit(ab);
>>>>>>>  
>>>>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>>>>  
>>>>>>> -	ret = ath11k_hal_srng_init(ab);
>>>>>>> -	if (ret)
>>>>>>> -		return ret;
>>>>>>> -
>>>>>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>>>>>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
>>>>> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
>>>>> in resume handler? So when device wakes up, its state is already correct.
>>>>>
>>>> Hmm... not quite understand your question. Can you elaborate?
>>> I'm trying to understand the possibility of cleanup of hal in suspend handler. For example:
>>> * The driver has been loaded and has been working fine.
>>> * The user called suspend. So all devices would be suspended.
>>> * In suspend handler of the ath11k, we should do the necessary cleanups of the states
>>>   like hal.
>>> * When the device would resume after long time, the hal would have the correct state
>>>   already. So we'll not need to deinit and init again.
>> The hal cleanup is not only needed by suspend/resume, but also a step of reset/recover
>> process. So If we are moving the cleanup to suspend handler, similar stuff needs to be
>> done for reset/recover as well.
> It makes sense.
> 
> So clearing the hal structure completely other than ab->hal.srn_config doesn't seem
> right. I've also tested it and it crashes the whole system.
> 
> On contrary, with only the current patch applied, there is no abnormality.
> 
> num_shadow_reg_configured and avail_blk_resource are non-zero. If I make them 0,
> driver still keeps on working.
> 
> 	ab->hal.num_shadow_reg_configured = 0;
> 	ab->hal.avail_blk_resource = 0;
> 	ab->hal.current_blk_index = 0;
> 
> As you have suggested setting these 3 to zero, is there any other variable in hal
> structure which should be set to zero?

IMO srng_config, rdp, wrp and srng_key may keep unchanged through suspend/reset, all other
fields should be cleared/reinitialized.


