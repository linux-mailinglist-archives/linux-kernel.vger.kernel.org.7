Return-Path: <linux-kernel+bounces-887703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5604C38E98
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51414F4524
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885E23D7E0;
	Thu,  6 Nov 2025 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3xHM/PZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ix2nG5ZG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA01A9F84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397075; cv=none; b=H08BmSGAyo6vSZq+cwB6DyQK4HC781iVFKADZ9oY9ZwfJMZcnIOe9uGvGUDJOXiIBmWtBjcxEEIPTaFe5uyVdEqr8pYidPIjKK5qitcCJ1qeCj9UFs+oniRKNYD2CggUiRFL9zmqOtsDBukzzge4UIlBgMRUn8ta2UNu65kMGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397075; c=relaxed/simple;
	bh=bVqXl30PeN5EDaQ0ncGTEzN9vQj86nOGA1neWrmFf/4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r0QswFPcnsHlcDhTL5nzkYdYuLlk6etPGkU8kdKQZaIR+fnc1ndFEURNu/VlxLsWqseaTcrIKmhSaWm5hC/SG0dvrqQ5vo0NyB8g5WKkVnfl9puFcj4mXWGgUCyxDYWbXMamId7i2Sntv0g63RCTHjn+GnJZ49z/sSwVdMWpnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3xHM/PZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ix2nG5ZG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KF4L41688911
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 02:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NJZxf2bqv1yZV7BJPTYUbdETwENppVp3Ty/RBoQNVfA=; b=F3xHM/PZ/YTXSqfq
	03FrNyMnt2DQERcgq3ptoghPpQIgps00q+B6g7RaHEfK5ixaijI7A1rF4YHrlsCi
	bi6LuQewB4whwQ6ganw5nP297Q7VU1HHERIU4+kobMgT2KxDuZfKBYwGXE3uP5Z3
	xX4YFQBpaPQ0bwGhdfxPsBK4guaM9OFOeu2SsetypLIMfXCrX3i/wJIxdRNxMJ/6
	O3CJ3IHLZl7GVq2I8h7GmSX5JTIGB1qbp4fOq7h24u18lhme43/z0wkCjwFaDM2v
	4NrerQSd3/TV8cP9eFV0CoLVBGZkYUIHNbEr1rIOoO4LPcFsOclR1x7iNoygtZGW
	ZsVAAQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pj9yyp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:44:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so1347037a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762397072; x=1763001872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJZxf2bqv1yZV7BJPTYUbdETwENppVp3Ty/RBoQNVfA=;
        b=Ix2nG5ZGh6vqbVGj90brRfZhl4WonTEbGe/5Pe0ZfS63I12xIeiVyEbxqS9lrkqyeX
         OUwoeRmCAosmN3IddOlpEvkI5uUe6IKgI2NYL5dy1ZmPydj//7QN03b+HcLbUSz1EaKu
         6fmglxDX8kZkAER5BYESPkuct4x4TkpnVgsUvlKMxqPXO/pn3l2d4VYJnEn28FM2zPMh
         StvW7HxjKpx/ueqUW0Tkc9fBdWoms7hOzCx+6J1vqegQMAUSxuoRjAx/EsyiKXfWFhzi
         LiSxYhwWJD9wTSDs9oUAMrLFtLVtjEa5Qml9/qIZHMWda+UGDb928bjqwmSJo35PPkU6
         SKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397072; x=1763001872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJZxf2bqv1yZV7BJPTYUbdETwENppVp3Ty/RBoQNVfA=;
        b=fXow2pXRXco16Whuu/zPIGEcyH54Ku8kGrdXjt0dPEDj0MVsMb5gn+gKY06prDRrsZ
         U52Q38doG89xXBeUe8/qmj6ZGvIC+sqVZ2s2L3QHcWL4/13LRlpoLg0q7vmfydio2u4a
         52aIFNPdJS4Thwl/dpbmZgt189ryA4mK8vqqXx/Bp8f630t8oINJAEtutU1YtRcZZuKl
         22g7SXBSrXeCwU44e1KcbZAwnO7wlV90g7AFRpWq0QYlASgjOwyoHEpgnvOxyZDBcEZi
         Y0I2JxeRzlEIW6oTcMUh52Gshv4gD75Sie1bowroR9yH6L80mZUl8Vx4sOGGis77WbC/
         RQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXDc68R+g4kiObCpWH5Jp4livpXNOnKUic70AIYIA6/DczdjvHEAUMw8sXDQU070hMIYRTOmXxXu99xArM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IqRz8MhGihnNeKWxRg2NLhB+eik0tMLcvHR0pLnc38GdyTW8
	Y5xX916x2miB97nm+g0T3LhJ0+Q0dOksKUdSNLVhG+sLJcVFMu6bzw3VMtWf7lA+NQ0yYiNKFGL
	avOfMZ1DEHFMa61oBgxjkg6BLOiG9SdjGjTEARebmwd9Ui8fZun3rE+w88/+EBru7PBw=
X-Gm-Gg: ASbGncvJdO8yh4c6CxBcywjU8TpwEk5HZ4xgVU1Ktr57fLESlJpht81mho/p1wjDW3O
	p0YGlS/M+fDNLFd50GOPF/bAbVF37505KmUBjqvfSBK08NwfVpUK4pLVr6tKVJEMQplxftYEK/w
	P5wQNXFX3OaeWpkChy3eFAfY9fxx7j9WpotjZsVlN8KwIFe4lzn5UklIv8ekN6IETrucMAzfRum
	uDreSW4Upbc3Z42/15c8cdiUEwD4ZlxOs2gyLCw6WV2w19loI1g8y6RRHFammxGABo4Gq5rc6QK
	0KtgOR7VD812ekNAFBTylWMKLFFv9dExqJmhWfhRfQmSY4cYrU/p/0ZwDgOyZYSRu8NOmLhzzaC
	dT3uJKCFYaeQCEQtz62sBx9mXZCHyiKKPcn5F02XB98TKJ6b/SNKtTdjbjOCfGOS2gbvsbQ==
X-Received: by 2002:a17:90b:184c:b0:340:bc90:d9ad with SMTP id 98e67ed59e1d1-341a6c5e3eamr6365703a91.10.1762397072310;
        Wed, 05 Nov 2025 18:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVTjm2EheehjKR6voJp/RgJWjUbH/r1DPK/fikAlb/nj6Q+1UxFzp2FFpFLL4XSe68SPy8QA==
X-Received: by 2002:a17:90b:184c:b0:340:bc90:d9ad with SMTP id 98e67ed59e1d1-341a6c5e3eamr6365681a91.10.1762397071710;
        Wed, 05 Nov 2025 18:44:31 -0800 (PST)
Received: from [10.249.17.198] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f661b71sm874030b3a.12.2025.11.05.18.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 18:44:31 -0800 (PST)
Message-ID: <f1456b34-9897-41d9-909c-3fac77e17bc3@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wangao.wang@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
Subject: Re: [PATCH v3 1/5] media: qcom: iris: Improve format alignment for
 encoder
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
 <20251104-iris_encoder_enhancements-v3-1-63b0c431b4d0@oss.qualcomm.com>
 <d21b6376-3b20-4171-9037-a6faf4e438a1@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <d21b6376-3b20-4171-9037-a6faf4e438a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HggPTENYFpOdqSuO2otrkrfk7sKcXvu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyMSBTYWx0ZWRfXwTfdDHkxYshk
 z00gjQ7ZlGcJQ5PnKba9iVpEzZ0MPfeBYS7hFBi0fgBOkSl8lxV2bsoWV8+n/iD68EJvarAevTX
 V4vQIAJxfeIErp06OPPFYgtTJIqFSpmsDAyZTwYU2ldjmyjWH/n53SOr9ugJ+BOF8Z0cAkcNY4A
 Qb7Xf2byL8U1OEg00Iqm1KSaCJo1sNnKVAgUXf2eMIbO/D+heoVAYKd0Wloe9Z3s6zFUWwCWfNv
 lbwzMVixYH5ZxLYhnj2fikGlg1CRqc7wU0Om0SDG3/mQqD5Y6RBLUK4MwqVao1QIHK7bFl1Aoho
 hL0RDkMOU1FTuujT9Y/wM67jmt4Q94Jx5uzMOSlU1CDr+IDimkywk+DNDU9NVtuWewfLoFfjzre
 SGB0ofcn3hjP2QGdYVDbQ7qotl0yxQ==
X-Proofpoint-ORIG-GUID: HggPTENYFpOdqSuO2otrkrfk7sKcXvu1
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690c0b91 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VFZlysSXFxogY-LAaxsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060021

On 2025/11/5 20:29, Vikash Garodia wrote:
>> @@ -231,10 +233,19 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>>   			top_offset = inst->compose.top;
>>   		}
>>   	} else {
>> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
>> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
>> -		left_offset = inst->crop.left;
>> -		top_offset = inst->crop.top;
>> +		if (V4L2_TYPE_IS_OUTPUT(plane)) {
>> +			bottom_offset = (inst->enc_raw_height - inst->crop.height);
>> +			right_offset = (inst->enc_raw_width - inst->crop.width);
>> +			left_offset = inst->crop.left;
>> +			top_offset = inst->crop.top;
>> +		} else {
>> +			bottom_offset = (ALIGN(inst->enc_raw_height, codec_align) -
>> +					inst->enc_raw_height);
>> +			right_offset = (ALIGN(inst->enc_raw_width, codec_align) -
>> +					inst->enc_raw_width);
> 
> For capture plane, offset can be calculated from inst->fmt_dst- 
>  >fmt.pix_mp.width - inst->enc_raw_width.
> 
> This is to ensure that it is consistent with what we do while setting in 
> iris_hfi_gen2_set_bitstream_resolution.
> 

For downscale case, enc_raw_width > fmt_dst->fmt.pix_mp.width, the 
offset becomes negative, so I think it should be kept this way.

-- 
Best Regards,
Wangao


