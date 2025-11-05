Return-Path: <linux-kernel+bounces-886420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCFC358AD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A414F4FA120
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1A3081A6;
	Wed,  5 Nov 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndBn0Llf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYmfvH9r"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665330216F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343778; cv=none; b=ApXdEtDfuel1YPFcQgG9l509oW1cnx2VGIEePbF+AyEzS42UoAcFuShfdX61CjPgzJD/jKqdPRmgekltSITa2NIjhSa8xbncYQ2y6gkKnyAp5GhUrDdWHJgQCWU/28Qe4wy/QplNbOtdhelaJp82N+xbOWgmKCb6/qC/Sb1MZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343778; c=relaxed/simple;
	bh=Jh202HqNC+EPrs7/EkTqu9T+iE/XddP+3hQSSI9HUdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDmIc7Y837Z9q8RgsiqzjIgtdfK+oXeoP2iZe70qE3MvluYF47+MGQiaH/4Gh4sX114/BjOLJwo7Ls/AvaCrxRs+5oC5CMPRM81OuM73CfovGLj1fOiyvel0fGuq2dlb08fCPchwmqvs/pgr02jXiGb7hSRsC2T38QUH6XYqiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ndBn0Llf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYmfvH9r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58F4QF3091509
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 11:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jh202HqNC+EPrs7/EkTqu9T+iE/XddP+3hQSSI9HUdk=; b=ndBn0LlfsYBxqEZE
	DFiLvnTnyEwfeQaVtBdoLPk1V3IE7DUzz4ueCnarB2GOxZ/YmMj24SBd2kLPPOZF
	tAgOBF7qFoIwspXb1twWuw4NrnkkPSqMc2Yf5D5YZ6DhN1RkhvASIIN7d0iXmSrG
	7cW2m2p5nRBI2MmsxrDjSkavfH8ia4jxvYGOjhmBrzkUWNnBYbI5aHzkmGk1LgJt
	6GfsBgtQtyMjTt447mhQjolFX+2Mb0mIALJg9sAomTENxT00JlfvA1w1/g+Gvc5w
	RJewWJ7zSrK34EjCmHj1RSvjPLlnv809RGHDY8c4Z95wFQupo/t91HT0KCUdeEU2
	97uv9w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5ea7yb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:56:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso3594214a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762343775; x=1762948575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh202HqNC+EPrs7/EkTqu9T+iE/XddP+3hQSSI9HUdk=;
        b=iYmfvH9rO3HN2/K0hvxZALreD4LuoAxFw6ppzL0zdrextxzTDnezOF/5alhbRaC0y8
         rx+Fse8o4qcIxmehZ4c08LqxhGiw8Xm4SeGMIk240V2h5SPx5p3NoD6Zh+BOsx/xHhN3
         IMzVyo7jxo6GIiyIEYNZUPWLlu6gh86UYQ8W/fPwyu2hhe8d451V4bv13EusvOQoRWX/
         Nq+A5R8H27yEZ48Y0WX5EG25KNRBXSXGc1gg33z+2AvbQ/4y6lzs3VLVzH1WMDVyp6Tr
         Lq891Exy/SxsQOZ7MNmWqZE2+aWbFt2i9T50Uz+b5GQQKE8nNKZOIo5w0TxzLK6Hf2Qc
         dXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343775; x=1762948575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh202HqNC+EPrs7/EkTqu9T+iE/XddP+3hQSSI9HUdk=;
        b=SedUo9PejKjVU1rsaDi3Ra3sCb2cLjEhBrcWAoX9OFe/f0m1XfiLCIUa//M2lz5Egz
         5xt5eL4x8rMNotvC/Q+i8LWr0yeAOWxWGXLIFo+DusUKmhHAGbqTTjMVFffiMA2j2NFh
         Glh0WFkHTpMYmj3de6GRmm6C1xyZmHLaxqJh3deFjibTym6qJNwKBeTkLud4WfgWiegJ
         AAlQA80iOAClHBP3XDfO5aHc3jXiTNoG6TjukD37w2ejCyFlnsx5kjsvAULkQkGXEXoa
         40rImOdUS+954lcU5ZNJiR+X3vY727ARFGNTIH8CAAvi2LufQXZ0gluviRZhVqHyW143
         CC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVUByH37hBQpYysF9J05oN/jg8KA2eglYYvilkT+wmTxACZEbochS6lEsYhRCisZj9vL9RdgFCFiwUaqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH9xu6YirYzjAw3lIboKcRK3SEoOfODi+u1T+sE/YU4LZt4PE
	IWM91Hug0KbJcnNw9S+jK7OiGMY73WKP3Tp42rRDystDklxRf1KDKgTdHsOd6XICu4u4K1ojifg
	IeGuVIGDaOBYE6NXou83PTGkO4Fjc6o/tmq9BOL3nuuCaa8glHbv4vd8yTbii9FFrCGw=
X-Gm-Gg: ASbGncsXc+0b05Uao+BUVtt8dXpQNKSbFqjQwaXOU6lR/I2Ac5hsM94x0Yi//6mnCOI
	vrSkC6d+dRXcOGCb6vv3NnGvjEHgVj636WsssIQj9G5NadM6jZxzWUW1q3ANb+rpxh5V2bl9mnQ
	07LApK4FUUG3av0xHstTG1ItmCyssmxodcU8lsFw2WwzGd3522eEe+Xu/CXsXjx+aqV6AjE6M6H
	CDgmOAm/BscGeHBOk/R4CNP/KbUj1mU+xAuF5uDqx0V54uOFE6O4iDkYt1QdBB4vmDfriKBdxBv
	BBfkpjQCnOUepnoQdLRLEF36piS8zVs9MFYmRhxDrFkNzDK8LgOnx2ml8mnst8LG/H9mZdS0WBH
	Z0EM4s5lYWS62JcCwuRKHcJoqsPxC1D9R
X-Received: by 2002:a17:902:ce90:b0:295:8da6:24b6 with SMTP id d9443c01a7336-2962adb1280mr45846125ad.40.1762343774835;
        Wed, 05 Nov 2025 03:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOBsqvLMifwTLJfIVrISOe7SUcmVBxPtLp04AS/Y3A0SYFQlxN4DHs37cl3B63FjppLnIf9A==
X-Received: by 2002:a17:902:ce90:b0:295:8da6:24b6 with SMTP id d9443c01a7336-2962adb1280mr45845155ad.40.1762343773563;
        Wed, 05 Nov 2025 03:56:13 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f18310easm5428984a12.1.2025.11.05.03.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:56:13 -0800 (PST)
Message-ID: <ca6313d1-b5c8-466d-8ed1-ab9ac6d8a803@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:26:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: remove v4l2_m2m_ioctl_{de,en}coder_cmd API
 usage during STOP handling
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251102-iris-drain-fix-v1-1-7f88d187fb48@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251102-iris-drain-fix-v1-1-7f88d187fb48@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: U00DfwJhB7HKZq2er7K0OuNZ8mFHEk-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA4OSBTYWx0ZWRfX9G4RZu4EXgGT
 vodTIqOIMIUL10w+TZnxoIHEMEihpwcnKclnQAJVmON9Y/Z/quu4MSeQPvzFfBx1S44js3XVdiH
 F9+jzEzi6m5fj/HYxf17Ovq4AjM57AK2SWcGDU68AXkJiVyMlrBKpJYAteo8aPpxinMGutpRWC/
 vP/NTBzSmr2ulCEX9tFuBafMUe8D8nU/g319kEayppngzDQLAJnVdjvYZ0O+ZjZIJPLbxbBRwAL
 O6ZuqYi7TjF8FRbZ2rfGgjQYzv4yLOIUTMm3VN4Tnq9DajqxS7Nx3Pgz219hHCaKLm0O06HBQUg
 IR2sHFLKbUkLJFUHFt6Wna/BZYdOGG+2a+4H2cbEFLvsyxy7D1wjeWZsly8nC1xAU40/dMCYFM5
 HMT60/UYoJqd+p67y9Bhjy6NU/3iqA==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690b3b5f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=AzyGrR4UViKNxLVuAS9Z9g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kD5szkbDwA3gxkcKNYwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: U00DfwJhB7HKZq2er7K0OuNZ8mFHEk-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050089

On 11/2/2025 9:10 AM, Dikshita Agarwal wrote:
> Currently v4l2_m2m_ioctl_{de,enc}coder_cmd is being invoked during STOP
> command handling. However, this is not required as the iris driver has
> its own drain and stop handling mechanism in place.
>
> Using the m2m command API in this context leads to incorrect behavior,
> where the LAST flag is prematurely attached to a capture buffer,
> when there are no buffers in m2m source queue. But, in this scenario
> even though the source buffers are returned to client, hardware might
> still need to process the pending capture buffers.
>
> Attaching LAST flag prematurely can result in the capture buffer being
> removed from the destination queue before the hardware has finished
> processing it, causing issues when the buffer is eventually returned by
> the hardware.
>
> To prevent this, remove the m2m API usage in stop handling.
>
> Fixes: d09100763bed ("media: iris: add support for drain sequence")
> Fixes: 75db90ae067d ("media: iris: Add support for drain sequence in encoder video device")
> Signed-off-by: Dikshita Agarwal<dikshita.agarwal@oss.qualcomm.com>

Reviewed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>



