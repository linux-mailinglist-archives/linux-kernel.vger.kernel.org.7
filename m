Return-Path: <linux-kernel+bounces-891318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28145C426CB
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E114E9565
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BC2D8393;
	Sat,  8 Nov 2025 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guTEOfAc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kV5y/qqQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9072D592E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575967; cv=none; b=FU6cjy+nuu4hHebUgO+ZmdFHcvU2hBWFRr//dNkVRHZqSDWsj1V9yGjkCu7HH4VSRHRRLx8AQ6es/3RO/ayXC0guW7KUIsRo6d0+550PWXm+/Wy6WoI7LYIK42h0hOpyTYwd2MXZ5XfN/qcczcFscUmirA0HleuasHWBnbbfF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575967; c=relaxed/simple;
	bh=fBX/EJs5joZGPJFdETzjuI1Y7qiWu9nuWEX9gT1W8A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCcYzJt8yVh+rRYEKYRGWBQYPOBMFafht6+v7Zr+O26Joz8KJfgcUxbhT9e3XEGlpiEg/Rm4tqc9kobWErwmIVZKcAd4cL4YObbNXFmZLoampsP3ps5srLf3Zm0p+o06HZk+nuhfh64oCrRKt2am+fNmk4sMk/1NW6R367D2Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guTEOfAc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kV5y/qqQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A84Q38U989539
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 04:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N4eafeo/cDkStxOwKYqMpoULM2ZZTyXtqjZbO2Myv4U=; b=guTEOfAc+WGT7RKb
	9qsp3dfp9rSCJDAu+CrWx3CLWeUG/Atj+WQzwU+2Wj4mbLbWi4OmUX5NegGgjONt
	bsFGQ9jU+x85FcWdBmdCZwE4VJr9itubCESbWW4o5pxuX3ZSy2nFyjrQPhJ6sTvb
	5Opj1soKnJTsJvl77OGfl/Ei31Syyck9LGFRy6OrZIgZqXwhwa3zUv/Didwss6qB
	YdoIRRmFLTlivSSw3MdX+cJHea9ElN4jpUHUnDo2AJa/QKRw/99EwcW4BdaF/9BP
	aTT06NmtL9mexXRDcrpPaGiq/bQrCp/GQiPo28eGuu9/5mdckbM1hnKOZaWR+0Wj
	p4NCvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu2r009-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 04:26:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269b2d8af0cso4018675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762575962; x=1763180762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4eafeo/cDkStxOwKYqMpoULM2ZZTyXtqjZbO2Myv4U=;
        b=kV5y/qqQhHKdSTSMKPApZp6y6FZO4D226ZxUYqIrem0it99nmT0V0HQKim3dlexRJv
         xI+kiESOt0WJY25jWzDakugQwLEk0esHUf6pE2XvNmPZhO8LDD20IrmeWQrjO4JpEj03
         uefocWn0z07BzxjD/rgqlZeLBJf5/gZM6s/MzTXL3EXa9MoPLpl8KG6Hkd+jnJ88FPFJ
         OwZkfrlqDY3VNq/5a+HtEewVk4rqgp3CH+kHPeFqW9aoJ01aiGh8yI/MCWmJXC8dpw9w
         In9Ne18rF7juywjLSaZdjzSwBEWW0FmKMCHR1n+9iig/7snVN3RE7yXXmOn08A4+mnOb
         quWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762575962; x=1763180762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4eafeo/cDkStxOwKYqMpoULM2ZZTyXtqjZbO2Myv4U=;
        b=BMIaoldoBj7b2bQdIJ1yKFVWNnx0jjE+MMJMh43X5b/yAu+BO8o2EcwA65P1XrXg7t
         7HzsHmNiDR+oxxcqOiKvBTSel0kHEwVWJoorJCewGeuc5Ks5bfe1e5XIfWY50CyXzyWd
         9L1IoRvTqI4n56u3ws0HROyD5cf5HPs1xx08j60FYVgRJEaJ2sjhWCjOaKeUkQ1QZfu1
         BBplCYvXca1Rhf/DexFojcs6zQJeGKvJJn46SgPZAu6P6b3S3Jd4HNv+vca6+gUZp49R
         PlBPXjRPrj6o0FA0m1IJ0ngd9Fb9n2mbornZirC/PGZrEnfUxNmAUQ8g0XAAPcZ462Lt
         auBg==
X-Forwarded-Encrypted: i=1; AJvYcCUzZbHjo8AiN9j9SaG401SFues/sNQ1ew19mbpC7gTsCYvUA0KYqfYOUp7l1rEZHcZtN2aWNhYZRKoij9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1v57GmN+niKXFVrjTVzsOyy0GQrlWMDIgnxZbDG73MY/c3Lk
	PIg1+l3ycQL2lza2hBBecrTelQXHoviEvbGYbROt8WerT/Q1feLW7C8m9KN1AxN0lyFWTKjKQPZ
	r7D9rg9xqH05hOKze9fteV/Q42jrfrYPae3/quozsTRexIkVqohVOa2CaIlNdTGwji+0=
X-Gm-Gg: ASbGncvcsMa6nub6XMo/99ZGCd0TZhcgRlxb/ZLtdFwIaAKvpREPWtZ7/32y5bfceSK
	ZMWqNpZrsfjcwX3ZvO/CbLgBxmEsLRLylr8Jur7mWLEpA6Cba/VTxj68SKkDXEx38gD3r9JKYj+
	DI0+lTdgDdW9pASNEw/Fv1A4O8jBxpYj0gHhJ4OGGQh89UraYa53aECsd5VS4UHyhqpriQC9HfA
	/h/cgEdqpj4r7VrUGmxFmAtymBJ0nNmkW2PrCSva/RJ4p6jL7FeJVAFPvdx5ZY/cWsN3fJAbAs+
	sKg02uytvSp11CRLQKZrW5lXRsxM+TP14FqSD99NMz98GXhD22J058XPQBU4j6RBk6NicPbGj2O
	1dntV42PA8W235A/Q3EEpxIKvan5Db8UHT0oKIokE8a/4xzpfj89b4ou7Wj0KBg==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9501665ad.7.1762575962517;
        Fri, 07 Nov 2025 20:26:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZCYViCjmme+RoZrjnoSFrEcEMevTTK+inj7z0qoPap9TRFowi1pucgYzEx3c9t+JNgJBGbw==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9501475ad.7.1762575962004;
        Fri, 07 Nov 2025 20:26:02 -0800 (PST)
Received: from [10.110.21.199] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509683easm75314795ad.15.2025.11.07.20.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 20:26:01 -0800 (PST)
Message-ID: <6b46213f-63a9-4553-b128-e90cc992599a@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 20:25:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
 <20251103-av1d_stateful_v3-v4-2-33cc1eaa83f2@oss.qualcomm.com>
 <43938312-ae0a-4a29-9fab-9cb3920b8335@kernel.org>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <43938312-ae0a-4a29-9fab-9cb3920b8335@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dMWrWeZb c=1 sm=1 tr=0 ts=690ec65b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=SCSBcTUyTCozYamH7nIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: fBvzvCIygP5fS0Epz0ZHNqVW_NkI9hU_
X-Proofpoint-ORIG-GUID: fBvzvCIygP5fS0Epz0ZHNqVW_NkI9hU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAzMyBTYWx0ZWRfX40GrbdaINA9i
 S0EFVWkDyf6+DwcOos4QuUOcnHq80gJgmfNKNQtHSdsyb9uQyM6uOfmevuxdj5gT5Q8WLsEJNlv
 Za/XCfBVLhm4LK6rcmpRzrF/I3avjLvTpfi+3w5SUuTybnm2+sfuPS0bUKV63YbCB6FVPRpUYfk
 Q7m9zp97tXu5OMMX0Tv0OUXoQNBqE/lRUVrP6ibsoCILaLqo6nyMO8Bso1lI1s1pX7wlDo+YSX+
 hJk+kKxC8CAbtcWCiP4r2LTRTMRK0q545+ySDH9PCYMVlD4DN4oR8EcNNctNOg9Ju3AltlRzXBh
 Q44rPEskuCZgoh6rTtzgKGz/4mckGRCbF6o2rk/lmoI4b1+1cbFFHtK80LpZtQCROKP82On9uF+
 QQCy242O3w0T7Oqc0kYJ0qScWXE7HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080033


On 11/7/2025 1:25 AM, Hans Verkuil wrote:
> On 03/11/2025 14:24, Deepa Guthyappa Madivalara wrote:
>> Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
>> enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bdfdf45c5de2f2ce885f219007718a54b5c86251 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>   		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>>   		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
>>   		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
>> +		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU stream"; break;
> stream -> Stream
>
> Regards,
>
> 	Hans
updated in v4
>>   		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
>>   		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
>>   		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
>>

