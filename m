Return-Path: <linux-kernel+bounces-828036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD3AB93C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EBF2E18D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEC1DE8B5;
	Tue, 23 Sep 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2g7pwnx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BD2AD25
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589440; cv=none; b=SKf99K2518p5TFWWBgb/xyyg2c7Au4TNYS1jeThvvQnxJWqd+vZTIsiPROdfpdpWuJ/HGyHYTGPZUcxEzLDJdKzwutz3bUtZXPqms8EieKpt/xaz1BUhW9ImWxP/vxwwPIKSamxRicUPU7p6ar5Z3mSqJoQ9qQIQK5BkN1fruKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589440; c=relaxed/simple;
	bh=AkmFWqZWKDdWgx+k3IxAC0AsHW+/Je62e22sgXDU+2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAlPiEaZmtohPMgW0t4cmhp3APpgn6uyPxEGZS8azGbnkte8iVx8NMMmN868BuRmMxKBgTRnPh8if69wUZ5u8WvLlZzspWpDMqto6mhCAHuxEW3IbU+z0BZxdh2bqpxlPeSC0HRRkzMGGEe2jr2JaRpksWcEvCsSfDoDmNe2fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2g7pwnx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6EIo028005
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3r2gyH2o9KM3Y4VR/nSiqz6V1kwzJFKLhM9PNywxZ9M=; b=U2g7pwnx7X8Zkxz2
	z+R+FuWVj9i6fTjNhzSitDitg/0dKOsNgygJTVMxGczOSmW4fa/yp1tuZTSf09FV
	geRntp4WiiFIei/DNOpNVcvDXmvNSQSZYkjWFgKioptWGMniAb63x8pXLKrDtVLf
	UPBah2saDNqTLVn6h1RxHyuRa8ePxH6aOkXSpHospDU719xiWAK/mw8jZIafmXmp
	J6gZeOpKqxXfCMGp2l9wZb4Fsl2hl5vOnbU23h/Uzy/9k2Hq8wgvNeL1kpssCtFn
	T29DoN5oVUhwUJRkdd2l/zNMMyWbCDcVWHHNSu7ZUQuxO+14ZYvNKZcOOOYjJMuB
	vAXjrg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajes3p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:03:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77e76a04e42so2919200b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589437; x=1759194237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r2gyH2o9KM3Y4VR/nSiqz6V1kwzJFKLhM9PNywxZ9M=;
        b=eTnKQSqNYkGuTycJKG1hm2ewmlVn+ZMChwCuXvYchbphWwGCW/mB1Ye54f4NgyK6cc
         4gQGa9BT7hXQJZdHoNfKv098vVStjRS0VIe7da1kwhyTgnXGBC8UHO3VuXl65az31nUL
         lfzcaTwSaZrYlAtpecF1QZGDea0Be5G98qQK9QpQaPg6WkKEp1V8KifXgw97WtyMhFv0
         CTxST6ndRUllDfXycQvPvoihGz4fiGOidtCie4tuAVstLul3Rx6qTVeyo2bOyX0JpP+a
         8u5eYSWJVoJR3yw2Qwsjx22Ila3Cg4C1zIzcjuEtNOSYw28sX6Cs1ZrfAYGa0Ds1L8wC
         PQVg==
X-Forwarded-Encrypted: i=1; AJvYcCV4TgR1aPY5PqIE+Fqlg1b6dUZvVKr4EFjapEdp5J6zQjngZYZO11Gk5+k/VolW1NFzUcgEMJq4ns50xE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+FrOSD2L/3mdiRnKEdvco3lSwwZqlT8L7Iic7o2Di76a+G00
	BK75melE4muHh01qi30uCqN0mUx+rr+c4bDQkGBP2+dnYeCU9/eg1yzFBEny0RtqH5CGQYOmuiC
	tUXP2SX+bAzL9WprXjrZOnmsmqEyOElbT8/MuG2D96OXjQgJIFsYatBFqscRGPdlTJOI=
X-Gm-Gg: ASbGncvlbVfj6jcBXRafNaWoxduzbGGKo9WZKrSoe/6BBh71nIh5YC/d9NweEyeaOYA
	qQWPNNMQHFqiY4Turm+yq9bp1EhinmZvQwh/19VO1ZzJX2boZldc6DuRkPHbcf99YZuAt0Xa3Nm
	vgLYkbyHLz8D7Jg13CuVZdLeA2jr6vV2J3Wi7dQplbtAXjQvKOZvIza0JPeCj55/gj4SgN3xFnB
	mHJlIKxs1w4re3KiWs9Wzqm6kEnyUIUR8iXIcqeIiYVMNwNzM2n4gNidu9DwBEfjNuLUmWXrBx5
	w01nNsw11IFST+/faQLjKl6s5ARRpLr4f7zQsvSTk38s2etM2eTP38k9brdoBA32aLeb8PUtPpM
	jAVFNDiLUzTYspaUhGjGsuLBxhGk3Z0k=
X-Received: by 2002:a05:6a20:a10f:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-2d10ea02f65mr823595637.12.1758589436708;
        Mon, 22 Sep 2025 18:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZu5szyIQ3+/h2P8RAeWjsUwtJhLpq8SVRmJe1NhdUsMWX4SpcQc49bQMtqaOjrR0EYSzmzw==
X-Received: by 2002:a05:6a20:a10f:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-2d10ea02f65mr823558637.12.1758589436149;
        Mon, 22 Sep 2025 18:03:56 -0700 (PDT)
Received: from [192.168.1.239] (syn-075-080-180-230.res.spectrum.com. [75.80.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2deca77asm5515903b3a.98.2025.09.22.18.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 18:03:55 -0700 (PDT)
Message-ID: <95c59ba6-fd9c-ef59-c5c5-33cb2fb5db8e@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:03:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 9/9] phy: qualcomm: m31-eusb2: Make USB repeater optional
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-10-wesley.cheng@oss.qualcomm.com>
 <umoo45pmamr3qraaiommpqh37tgmqidylmtjh3iamlxs34s7wf@ouug53aqvdfd>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <umoo45pmamr3qraaiommpqh37tgmqidylmtjh3iamlxs34s7wf@ouug53aqvdfd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 07uobzi7_bTytHfiRdTqaMiwSCk-n37e
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1f1fd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=agQD+r7xwyS+FYqxhQjztw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2H1wgwkl3dmy4IbtCtkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX0UzwXxc4ZIYZ
 yOIR3zbpsFMYLZqTeWEc8dNoQVBg3HcdOOa7sOqDEDUcByHgeZWseD6c0W2dk9Tr+cdhO5XorD4
 zcIenMubfkz6VZ5KWDZw87gkdjrWH1y5EoRZxsDI2A+kNhcw0qp676lIsneygah9FBkvQ7Pgwu1
 h/bywP3zqblQ8ZZ85Q/YnZaHcVqj4QqhuBXSBkml1ZXnWUJG4yh5hUOi2vt/261sJy8mg01ZTxL
 RBirXmTTm87tIxfVcX15MKtaQBdCYZK5HSQgx3KlHB2c2jitScRoI0cPPxADLqZpejP8GY5hM/7
 1fiPxLnvGrV1ZAJoipiSieVGferZ8tK3NCnzs1UX8L6Dbn4IBZWpO4hePyiFJIBEbYVd3l76ZAb
 zFanBk4g
X-Proofpoint-ORIG-GUID: 07uobzi7_bTytHfiRdTqaMiwSCk-n37e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168



On 9/20/2025 8:42 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 08:21:08PM -0700, Wesley Cheng wrote:
>> Change the notation of making the USB repeater a required DT parameter.
>> Issues were seen when supporting USB2 across different form
>> factor/platforms, which led to enumeration issues due to improper eUSB2
>> repeater tuning.  By making the repeater optional, for SMB/QC PMIC based
>> repeaters, it can utilize repeater settings done in the bootloader,
>> which cover a wider range of platforms.
> 
> No, please don't depend on the bootloader settings. Instead we need to
> implement proper prgramming / tuning for eUSB2 repeaters
> 

Hi Dmitry,

Will update the next rev with the entries to support the SM2370 repeater.

Thanks
Wesley Cheng

>>
>> For other repeater vendors outside of the SMB/QC PMICs the repeater
>> should be defined and managed within the kernel.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
>> index f4355d38aad9..b8ddadf78c53 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
>> @@ -285,7 +285,7 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
>>   
>>   	phy_set_drvdata(phy->phy, phy);
>>   
>> -	phy->repeater = devm_of_phy_get_by_index(dev, dev->of_node, 0);
>> +	phy->repeater = devm_phy_optional_get(dev, NULL);
>>   	if (IS_ERR(phy->repeater))
>>   		return dev_err_probe(dev, PTR_ERR(phy->repeater),
>>   				     "failed to get repeater\n");
> 

