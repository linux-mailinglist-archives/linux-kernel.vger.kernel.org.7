Return-Path: <linux-kernel+bounces-700244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBAFAE65E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BBF1BC1DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4EB2BEC29;
	Tue, 24 Jun 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbZx1uyl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7B298992
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770510; cv=none; b=u1zFCRx9AMEqvkioymrV2xpIrgoW0O2C46w+zxf1oXV3wXLPMmbYCELRZ9B5c5z4fk0d0JdnrNTywM6QxVEZ3pBRfoiQtAWv3mRbBE22hUbICxcxvGAsfWpadXp/u1uwHhoTwX1T65s/MowQVr93oalTh1Vm1w5G9rploJS6DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770510; c=relaxed/simple;
	bh=OWhxjim2hzRwp44IATiri7aWjY41RYVfuAGrMg9lkKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlBKrTZOS7IyEOOkz234dq2x05ELpCZ3ISDeDXD6uV3VqNHf+6z4asajd0k+BGW7J9DxGKcqAtNaoSvW7HAXh/xd39m1FewsYY4o50VfMntXkOu8cFXxal+sLQrNVd2+0bvNtsOZoyNAo7+fGuij9pirOcpAKIHcLNbl6BYEQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbZx1uyl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O77GQW015721
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GXCLZ7wAY3gbFYvClwpaaAkNVDWwCvFGSPtbvkJl6S4=; b=QbZx1uylK1oDoaHE
	AxheQ3bLH0vLEbfkRRSrZr/l2/yYim17/kmALfwpQKFR+X7ovIUY+p+RU1+vC2X5
	16iDRtyt4ZtNqI5TQ3L9yhwhFrAByVNva9qHM7gfny2S9up19BvOq6IeuWY8wYBR
	LVNGeTg/p3/rL63xnhH4ICX3TOjSiWEiI6v1bOtNBAZQRzGeA9Drh6rO2C3uoPMG
	UX4/IRvcJTzQHoHMWehZfO/2pQ/FhCv0SvK2L5cRcsJWUK5mNfn4ovwOQr+AkjIn
	3nObZbjWy0cXguNZsKogCNwLcEPrDKXEvNE/gosHHSTce7idiG0uCHwontU8EFH2
	c3cdoA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5najf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:08:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c37558eccso342116a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770507; x=1751375307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXCLZ7wAY3gbFYvClwpaaAkNVDWwCvFGSPtbvkJl6S4=;
        b=MNkIUFIIgQ/zPNP92ZEMNnGSuwylsrbMhwaXEl1ibB+8bnqPjHGtOgeNhqvTuMch9h
         FWxiOwyJY8gAg8kzSXZ5FUDQEYXfpbnT2H6L7JaBJG/6WI4JE0GCe+EVY+3g6zWavwdn
         I42LakqwR75Mq6MrZmyC9dqenNw7tWJjki5QtmIjZr0iVpIxyVgiUkoX3fbSsOlxEahI
         vMMoJgwjRpZXYpv8uyy5bwrLwIvp5X+OEficLVHQWXF9PkX3lc62Wu0HGTAtuc5Bx1Ap
         NBEojR0OKYj+zPGdLPtrbEGy2m9i+d+JkwBBWb1qeL7R+g3P8oj4PDU7Re5Za9anGcW5
         wByw==
X-Forwarded-Encrypted: i=1; AJvYcCXNQQtzD1DaIklWBx9G87HJU1lB+kJNedMOjX+Yx59GaNPDSDUeYCJh7ZWGU2qPbSswZ7hQDbV38NIm5Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+dGCCkZdj9BgCEd9xqXgH1cZTzNz6lCXPjj30t+SEFvE4I3c
	/ldCifMZyCPKzNw7mwZOvfnWx4q27G2tAJ6MbLFht3uDrS5TwmqbqkYYjXE/AbyPPMFMcw548LU
	MNcd/J6y//HIJnbISrLfs2vJCnL1j8q9aE6h5SjxeAtLo8e2OOXXHD4RRIdmpcOsPDWA=
X-Gm-Gg: ASbGnct48U9vrpsm4in5VE9gr/OpQqAnyKa/fKPwkdEkiOk2qESh0tENm0zFhUpexUc
	Wc9WRV3AuYR6Dnb8zlRGt7o3FLSNL96ioklQRS7oQdnmWKsqlgPKVZSCCGbbYAaEd+/nrj1Oo+e
	tl0GesIc1BnkGb6bj+KW1x4kA5M8Kc0zkRScsYbATD9Cju5+aq36FUFbaYWPX+8k2g11syO2J/D
	t/YOhPqCEditFn3Y6K0q1YYjMn7eooFG6ByoQv7A4vbAhJTQOq/t6AH7mEWiom1C4Ge5mz7L6F3
	MA/rBT3XEpaXmV5GnC38oq9YP/lxEcoNYaikvU9qA1mRR/xqfOpgnhqBCCyS7qdp5mmp7fykUQ=
	=
X-Received: by 2002:a05:6a00:9a0:b0:749:93d:b098 with SMTP id d2e1a72fcca58-7490db4278fmr17729271b3a.22.1750770507033;
        Tue, 24 Jun 2025 06:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaLKteWP9POVkOhi2cCkGrtK+lX6AAeVvFFXqxc3EwlHw8pY4QVWlpLKOHl1nNiBko7q5DOw==
X-Received: by 2002:a05:6a00:9a0:b0:749:93d:b098 with SMTP id d2e1a72fcca58-7490db4278fmr17729252b3a.22.1750770506624;
        Tue, 24 Jun 2025 06:08:26 -0700 (PDT)
Received: from [192.168.0.126] ([2401:fb00:ffff:fffc:0:1:ac11:493f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88721b9sm1836215b3a.150.2025.06.24.06.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:08:26 -0700 (PDT)
Message-ID: <72f9de63-dc19-4467-b883-8637f95a8e82@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 18:38:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] usb: dwc3: qcom: Facilitate autosuspend during
 host mode
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com>
 <20250610091357.2983085-4-krishna.kurapati@oss.qualcomm.com>
 <20250623235856.b2jwgf5j6yup2sww@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250623235856.b2jwgf5j6yup2sww@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cu1RV7iiOSag6nEW7tjEfxCnAbffy4ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMCBTYWx0ZWRfXyQ7cSIlXI+JA
 aNry3iN33cGqHombUzNsP5AqFsfgOeHWFfRlY5XKdUYkRzJKh3+i+c0+3NskTffi/FyfebWATTQ
 S/ywbcrZ1Dq3Lc7Km8Rt7IyJPV0pnDg7ANklujye6tdjC+EHVn3ue7KV/3GbtZeG/fp+sjYkcib
 asUVNsgUb4xuUirula3v+9hxh54j1V9WT7fDk5rOJX3cAEGMIaXa5CN7VNX1OsWhZJ6F/1oxitw
 OYRyFp4mYbFjc1JxEt8mdtpb8uyoSBfi5z2BdYp/jtDae9jHyyzkMl812nbJme+mU51mUuWZgos
 QwxJlMzkoqNJvARI2mRDrZQYBHCxc4DzPaiQZ4AS8Z4dHozn1AvE5Mv6c42T9zgnXmp4YzAg8cg
 vgC+Y8rBooLA2yrwGqGWSUEZJpuHakUqXn9bAkDVb5G9dIvjzJW/yGI+Jz0/JQAKihfakZXc
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685aa34c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=biFwQZO8mOkSj3tXal0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Cu1RV7iiOSag6nEW7tjEfxCnAbffy4ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240110



On 6/24/2025 5:29 AM, Thinh Nguyen wrote:
> On Tue, Jun 10, 2025, Krishna Kurapati wrote:
>> When in host mode, it is intended that the controller goes to suspend
>> state to save power and wait for interrupts from connected peripheral
>> to wake it up. This is particularly used in cases where a HID or Audio
>> device is connected. In such scenarios, the usb controller can enter
>> auto suspend and resume action after getting interrupts from the
>> connected device.
>>
>> Allow autosuspend for and xhci device and allow userspace to decide
>> whether to enable this functionality.
>>
>> a) Register to usb-core notifications in set_role vendor callback to
>> identify when root hubs are being created. Configure them to
>> use_autosuspend.
>>
>> b) Identify usb core notifications where the HCD is being added and
>> enable autosuspend for that particular xhci device.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>


[...]

>> +static int dwc3_xhci_event_notifier(struct notifier_block *nb,
>> +				    unsigned long event, void *ptr)
>> +{
>> +	struct dwc3_qcom  *qcom	= container_of(nb, struct dwc3_qcom, xhci_nb);
>> +	struct dwc3	  *dwc	= &qcom->dwc;
>> +	struct usb_bus	  *ubus	= ptr;
>> +	struct usb_hcd	  *hcd;
>> +
>> +	if (!dwc->xhci)
>> +		goto done;
>> +
>> +	hcd = platform_get_drvdata(dwc->xhci);
>> +	if (!hcd)
>> +		goto done;
>> +
>> +	if (event != USB_BUS_ADD)
>> +		goto done;
>> +
>> +	if (strcmp(dev_name(ubus->sysdev), dev_name(dwc->sysdev)) != 0)
> 
> Can this be false? If possible, I'd like to avoid these pointers and
> strcmp here.
> 

Needed this to identify if the dwc3 pointer corresponds to this glue or 
not. This can be false.

BTW, Dmitry suggested to just do "runtime_use_autosuspend" inside probe 
of xhci-plat.c and remove this logic. Hope that would be fine ?

>> +		goto done;
>> +
>> +	if (event == USB_BUS_ADD) {
> 
> This condition is redundant when you have the check a few lines above.
> 

ACK.

>> +		/*
>> +		 * Identify instant of creation of primary hcd and
>> +		 * mark xhci as autosuspend capable at this point.
>> +		 */
>> +		pm_runtime_use_autosuspend(&dwc->xhci->dev);
>> +	}
>> +
>> +done:
>> +	return NOTIFY_DONE;
>> +}
>> +
>>   static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_role)
>>   {
>>   	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
>> @@ -659,12 +694,22 @@ static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_rol
>>   		return;
>>   	}
>>   
>> -	if (qcom->current_role == USB_ROLE_DEVICE &&
>> -	    next_role != USB_ROLE_DEVICE)
>> +	if (qcom->current_role == USB_ROLE_NONE) {
>> +		if (next_role == USB_ROLE_DEVICE) {
>> +			dwc3_qcom_vbus_override_enable(qcom, true);
>> +		} else if (next_role == USB_ROLE_HOST) {
>> +			qcom->xhci_nb.notifier_call = dwc3_xhci_event_notifier;
>> +			usb_register_notify(&qcom->xhci_nb);
>> +		}
>> +	} else if (qcom->current_role == USB_ROLE_DEVICE &&
>> +		   next_role != USB_ROLE_DEVICE) {
>>   		dwc3_qcom_vbus_override_enable(qcom, false);
>> -	else if ((qcom->current_role != USB_ROLE_DEVICE) &&
>> -		 (next_role == USB_ROLE_DEVICE))
>> -		dwc3_qcom_vbus_override_enable(qcom, true);
>> +	} else if (qcom->current_role == USB_ROLE_HOST) {
>> +		if (next_role == USB_ROLE_NONE)
>> +			usb_unregister_notify(&qcom->xhci_nb);
>> +		else if (next_role == USB_ROLE_DEVICE)
>> +			dwc3_qcom_vbus_override_enable(qcom, true);
> 
> We don't unregister the notifier when switching from host to device?
> 

ACK. My bad, missed it.

Thanks for the review.

Regards,
Krishna,

