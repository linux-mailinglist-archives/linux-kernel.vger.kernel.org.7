Return-Path: <linux-kernel+bounces-764559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17BBB22483
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D101AA624A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340B2EB5D6;
	Tue, 12 Aug 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QM+6lsVW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF32EB5B9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994237; cv=none; b=n9ziGwzALHJX/w/2ifWvKC4iqH6ZnWaDS6n9xCBGKcVhjO9qg9rFFhQrUorgx8RmMD/9/MjQStpzKCq9ek0mW+5V5hkRwO+ieVfxt6pxLNaA3OI3sU0GkDGCd3WfUd0SITVKr7+q0UBkHl1tfarTRU9YY41in/Vg6B/7thgkEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994237; c=relaxed/simple;
	bh=We6XfkAl0+Rk+YFJpAN79Snk06JGvwWviwXHLqMusGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNF47xhzwYZuGuq8m/9Fuz3yQgkJNG1XfBO7CWnXEfay7FFrFJU935MEH/+8omBW5sZbGqCxIs76Cq4KNvuwUo9Pywl1DrUReMIuc5LxPlg/5q6lsGLdqTWO5ogW0dXu3oQ8mnXiOis/wtTaghECBZvzsv1VRWOAJiO9UBULSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QM+6lsVW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4PvbS013093
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uVDsi1mqr9iZ/YWfYut7sj+G181wFB16lCiuqt0bKQs=; b=QM+6lsVWmX9CZDKO
	j85s7DX5IC91rO6zwWkqdM4Ja/9zbdGQ9CpxwQaq1uoeMmvpG15rRN49Y0gcogKh
	QsreN9gT7xipMKajX6TqlA1GVScKVMsNyvR7SKVCofxJM9o/HVlEp/PPJwohMJx9
	UYCr79ToViYoGUT6S7FXKuH0Vj2HRZwiROm5sW6iRi+IDVGM/CBu+32UNAOE4Z5N
	wjxJgyRbq39dWva8Dku/T97nYzWXa6RQZbiNbBMoWJS9CYlqvtv08M4Hzv++Ktcy
	qQgnE+l8KmBCI9aC+MACMLwibERrAYMVFgMAa9hLCGhtjl2PRSC9GpZvpN3TenZM
	wm+rqA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmqw3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:23:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2424aaa9840so58323555ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994233; x=1755599033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVDsi1mqr9iZ/YWfYut7sj+G181wFB16lCiuqt0bKQs=;
        b=ie3w9SY0EjZ510DWWQLqSXZGga0XW9Ubg+hnmL5st4jJXVC+qTf0fu9jZTnDDtepwI
         u/O23w7PT25/ZqsCjkAuz+X+RUOtyfdunilNBm2B0yT5opg4cNSfjMhtnkY4OH3MTaMe
         wprAeCG+NSgepL+vP/N2qP2AhXUTHRasBu8V+j5gFWrcJ52QufkGEoD63JcLsJYAVgew
         qnSb+cuLHajIH+Dxm7pXHzuOLRUWQrozGTeoGv3DwwvAVjvibu36x4xkNeTPxQ6nNqpY
         H8k4rs9FoEAHeaGIL2dvxFkaF2fSQG1I1H/hgamqtgR4P1se0Uv82GF2lmjwjqvyO18h
         qgwA==
X-Forwarded-Encrypted: i=1; AJvYcCVG5kvCxnbFYEzdgnG2h25ndgZ8z55zrteoVrQcmXAc0zNo8JRZf6RNaAthM76PTSiyv/1wxNWTXSY41zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymag+2UIxpKkoEZyMgrRlVNvP2LUtIQ6YrYG4kTZqh4BHCcbnK
	37rrpnkNAjory2CWBadu8ZsIBt/uXEe5P6/a27p1nB4HA6AXdKgPZ1MTbUnX/f7jCZJbcFgg6yC
	wv7AgQyGVhkc4XfS9LEiMoAUf4N5H1UzlfF71QYp/ZZdyGSCbOquyCrEf1/ICPHM8TCs=
X-Gm-Gg: ASbGncu0qapLD0JW3boj+0PMCy72l+Nfy9iWCd98BXypAfSH4e32qEKqdn2OvWYGaYl
	LOUwVQkbn69+kfhPaMZRjpuSmKw2VaxBjGpHk7ccEuQFuP3vyy9NHEog616rc4yPCBrrgJbo70J
	echdeUrpMDoJwQaJUXj4HclwUOZl+SvC5/FrU37bVuY7wddwyw0TU5cugbjnOnF3hgty0aDxP7J
	1YvIU2Jfi53161RkUBYbkAa30KYi2zZIE6CjOUt7/jJSIQ81Bzlsd2eKAItWhOp9TH53VFifKCP
	QIBzwggEjAMBjK/VdQICAl11DVvKO2XqOBGoKc/ha4Q9FJhSbLFplIh/qIjvae0UI+r9+h8=
X-Received: by 2002:a17:903:2444:b0:234:9656:7db9 with SMTP id d9443c01a7336-242fc31a4a3mr51288845ad.32.1754994232582;
        Tue, 12 Aug 2025 03:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3nE0xxMXGE/aWuTkvjXgGqjunL9+rYSJeujJY4UxqEAU7X4YcgP2z+joHLGg4G+JZ/pjB4Q==
X-Received: by 2002:a17:903:2444:b0:234:9656:7db9 with SMTP id d9443c01a7336-242fc31a4a3mr51288405ad.32.1754994232082;
        Tue, 12 Aug 2025 03:23:52 -0700 (PDT)
Received: from [10.92.180.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm295123515ad.172.2025.08.12.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:23:51 -0700 (PDT)
Message-ID: <7ab4d0b1-30b8-408f-8dd8-85d9fc255704@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 15:53:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] usb: dwc3: qcom: Implement glue callbacks to
 facilitate runtime suspend
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
 <20250812055542.1588528-3-krishna.kurapati@oss.qualcomm.com>
 <575c80d1-5f68-4863-8ba3-9769a5047b8d@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <575c80d1-5f68-4863-8ba3-9769a5047b8d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689b1639 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=hQXcrAQZFoSSxVINoZkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: xfzWm74ZIFQGBqa0OFC8R1x3owCPMEt2
X-Proofpoint-ORIG-GUID: xfzWm74ZIFQGBqa0OFC8R1x3owCPMEt2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX3kNVHsajZf4T
 a7OCqK+ZdiYq5yj5BPxBBe+dqM0KvQqet1Ejcxk6uUaIum+B7jnJjBYH81lYYU4XBKlCh717VKQ
 khbHB5z5rLCc+e3t9nF84/Rd7tW0+MwfDptsBKTCIyfw7hatd3JqlaDUCzgWhYeH9lWW6MZ7zkY
 VeFfcNeWth5B4gOW1ROKQW+BuLiPJyL48f+rAPg0W2WF5C6aHSCmBSs7HIT7qlJ2FmiBCXrvHui
 zFDNRb9Y3M+Uye+/g0tuwiwnUezEHH7llkRBvjMTvjsgBR5NhWKwiky5Yp4gg+tM6cnc1I1ZKfN
 QEjsFiH6aTAyLl7Az0SNsLFrbj2yKERqPKGjCIxYuhii8FelD62GGgs2qrKDlL4Jc9yYEaNOFmi
 NvckdP9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000



On 8/12/2025 2:39 PM, Konrad Dybcio wrote:
> On 8/12/25 7:55 AM, Krishna Kurapati wrote:
>> On Qualcomm DWC3 dual-role controllers, the conndone/disconnect events in
>> device mode are generated by controller when software writes to QSCRATCH
>> registers in Qualcomm Glue layer rather than the vbus line being routed to
>> dwc3 core IP for it to recognize and generate these events.
>>
>> UTMI_OTG_VBUS_VALID  bit of QSCRATCH_HS_PHY_CTRL register needs to be set
>> to generate a connection done event and to be cleared for the controller to
>> generate a disconnect event during cable removal. When the disconnect is
>> not generated upon cable removal, the "connected" flag of dwc3 is left
>> marked as "true" and it blocks suspend routines and for that to happen upon
>> cable removal, the cable disconnect notification coming in via set_role
>> call need to be provided to the Qualcomm glue layer as well.
>>
>> Currently, the way DWC3 core and Qualcomm legacy glue driver are designed,
>> there is no mechanism through which the DWC3 core can notify the Qualcomm
>> glue layer of any role changes which it receives via role switch. To
>> register these glue callbacks at probe time, for enabling core to notify
>> glue layer, the legacy Qualcomm driver has no way to find out when the
>> child driver probe was successful since it does not check for the same
>> during of_platform_populate.
> 
> [...]
> 
>> +	if (qcom->current_role == USB_ROLE_DEVICE)
> 
> I think it makes more sense to check for next_role here (we know
> it'll be the opposite of current_role, but this is confusing to read)
> 
>> +		dwc3_qcom_vbus_override_enable(qcom, false);
>> +	else if (qcom->current_role != USB_ROLE_DEVICE)
>> +		dwc3_qcom_vbus_override_enable(qcom, true);
> 
> I think the formerly proposed inline comparison grew on me..
> or at least drop the 'else' condition, '==' only goes two ways
> 

ACK.

>> +
>> +	pm_runtime_mark_last_busy(qcom->dev);
>> +	pm_runtime_put_sync(qcom->dev);
>> +
>> +	/*
>> +	 * Current role changes via usb_role_switch_set_role callback protected
>> +	 * internally by mutex lock.
>> +	 */
>> +	qcom->current_role = next_role;
>> +}
>> +
>> +static void dwc3_qcom_run_stop_notifier(struct dwc3 *dwc, bool is_on)
>> +{
>> +	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
>> +
>> +	/*
>> +	 * When autosuspend is enabled and controller goes to suspend
>> +	 * after removing UDC from userspace, the next UDC write needs
>> +	 * setting of QSCRATCH VBUS_VALID to "1" to generate a connect
>> +	 * done event.
>> +	 */
>> +	if (!is_on)
>> +		return;
>> +
>> +	dwc3_qcom_vbus_override_enable(qcom, true);
>> +	pm_runtime_mark_last_busy(qcom->dev);
>> +}
>> +
>> +struct dwc3_glue_ops dwc3_qcom_glue_ops = {
>> +	.pre_set_role	= dwc3_qcom_set_role_notifier,
>> +	.pre_run_stop	= dwc3_qcom_run_stop_notifier,
>> +};
>> +
>>   static int dwc3_qcom_probe(struct platform_device *pdev)
>>   {
>>   	struct dwc3_probe_data	probe_data = {};
>> @@ -636,6 +683,23 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	if (ignore_pipe_clk)
>>   		dwc3_qcom_select_utmi_clk(qcom);
>>   
>> +	qcom->mode = usb_get_dr_mode(dev);
>> +
>> +	if (qcom->mode == USB_DR_MODE_HOST) {
>> +		qcom->current_role = USB_ROLE_HOST;
> 
> Should we explicitly clear the VBUS override in this and the last branch?
> 

Not necessary. Even if its kept set (somehow carried on from 
bootloader), its still a NOP if dr mode is host or default mode is host.

Regards,
Krishna,

> Konrad
> 
>> +	} else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
>> +		qcom->current_role = USB_ROLE_DEVICE;
>> +		dwc3_qcom_vbus_override_enable(qcom, true);
>> +	} else {
>> +		if ((device_property_read_bool(dev, "usb-role-switch")) &&
>> +		    (usb_get_role_switch_default_mode(dev) == USB_DR_MODE_HOST))
>> +			qcom->current_role = USB_ROLE_HOST;
>> +		else
>> +			qcom->current_role = USB_ROLE_DEVICE;
>> +	}
>> +
>> +	qcom->dwc.glue_ops = &dwc3_qcom_glue_ops;
>> +
>>   	qcom->dwc.dev = dev;
>>   	probe_data.dwc = &qcom->dwc;
>>   	probe_data.res = &res;
>> @@ -650,12 +714,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto remove_core;
>>   
>> -	qcom->mode = usb_get_dr_mode(dev);
>> -
>> -	/* enable vbus override for device mode */
>> -	if (qcom->mode != USB_DR_MODE_HOST)
>> -		dwc3_qcom_vbus_override_enable(qcom, true);
>> -
>>   	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
>>   	device_init_wakeup(&pdev->dev, wakeup_source);
>>   

