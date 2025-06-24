Return-Path: <linux-kernel+bounces-700235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBF2AE65C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143B43B17DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BD2BE7BE;
	Tue, 24 Jun 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6C4+HLo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C5257435
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770203; cv=none; b=oNnHViT+J16DmcEcfA4yBbHg9rjH5UZqDJcxOVJeOxWYqc8X3iqQddNEnDdmMFxlnE+iyVqYvmTwuTsqSFBUTCWsF4yWdGcID61yC/UcT1HRxSBNjGfdJhOClWh8iLF7tkkf4dwiOL9w6FhnA/0K8vOxNiWoJkT/Ru6NwGSHJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770203; c=relaxed/simple;
	bh=75wsxsNgUyNQLyNdOc9A1QsWJWj6M0Lsclil2BJlKdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NySh9gnm2gSuGzNnQeDDVteaYrWLfR66k2aCd2rP+2ouQGPDfzYVEHgJ8/m3wbQqFgnv7PfXv/JbIwwp4/ubXU6TwzOfbsycroRWapSp1Djwe88M6DUAdifL8Vg2e1cIuqc67hMk2HJIgoAOwBb9sl1a6vuffz1V3dh/QHXxnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6C4+HLo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O6YMrT022517
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+NZqPiRQVJEnBQ7mFloFIHp+/MaZrKBFhk4xTqfODM=; b=E6C4+HLoH+r9i57e
	juXN7kW0j3QayiUIYps7g0PhEgfaO12q5iqKmYQYlv5L78GmZxG9RzARxPCYY1QB
	utmbZL9WtE1tnlT9DFKNcXuuztX/aaAa97xSs+7gQiTm2bphoH+x6SZwiMlLkPlt
	6EMjk6pImSH47uPvKdFsHQr6rD4xqok+e555bUiOoz/rm6vrwFVzZX0QIS7hNtKy
	qAplA+YThw/CxCZfTzxJj+GZIfejKT2aACV0kgXD+z4RYjM2dPCYKn7gXDvUahWQ
	IFQbItGhJIxvhdMQIfgY5jGMrlbl7us7TwKR/fH832hlMKunswNSEfH9RGfVcKUw
	8t8lVA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpvcb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:03:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235dd77d11fso51243285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770199; x=1751374999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+NZqPiRQVJEnBQ7mFloFIHp+/MaZrKBFhk4xTqfODM=;
        b=DZA6nV3g19LEQVcB775v/a85l+QQ4eymIVdYnQTL1aS0RH3HEy4eFueh9YRPOaKCtQ
         6LsFwsUQkswOZTB06rDxzT5smDYJAdQB38NSgjOknEXeoDirQZge24tykvE3rV0UsK+D
         2Q2hwGZ81ejcs1Atwvxiu+LbFrzy2iFPd1o/qMa85cnWC3y77Bzp6d0xFvFqsUb3WprG
         TmnDSAL0ZG6hJGtX9xruW2hlaPLyadpiAPplTZaVkZ+SM9UJWOCPhRCt48RaiFnGlNer
         k5gcC+z4klNC3y0mO3EtQqLUTLUb2SAR6HwR0Qpb3X3Ih8dWyyJEXwu/XGXK8l1105eJ
         1mjg==
X-Forwarded-Encrypted: i=1; AJvYcCVOQCkDxxoR43VF2F7dvyHLXIg2SGc14Nygf293+SBIk1vF2afE318zbD1ghKdxoLuf5EAyk6hRDT38maI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VgpJ/oJ9AWXiWfH9ZzRlgu5TeoMUZPG4EcqG6ROZW2Ddxm+8
	O/3pI/eJRuoRYKLRK59IG+DWxd29+cxXvu7D6WSRhjt+1dF8Q/KY2RXiCMYWzRhBPhYw7HpXQ4D
	Kce1R+t/EzQ819BnYnsu7DnegSRG4d1cWcHlI8gEhajwzkwEsoNYc1O435VQBYmrvJM8=
X-Gm-Gg: ASbGncs+b8oI2gjN08Ekc2L7MiTyV2VsZuGClqzFzQoDgMuz3/Gy4OvplaEorwyRUFL
	OuCFSrdTAR/w0eJrqopSohSUjFmcjd7BpOySzyV8r2CQYOpCp7ppB6Hj+Juzaa4RdwokcqGty+h
	qkey3Z+MxlJ1kLFtEVwdgwLermu1qCimUT4S9fwvZYJTLx8/dYmWQZ/9FfeHf97RRULSEFIEpoV
	tr5r5ee46junGHzv8Xzk4NNJwvWRLuab+lHTwekWZxOuQCnXU/W/nclBZz5Hk2Dat6ARdtCRCKa
	BJ2kTYxh1gB8YX8oE5pDBOGmMbpcXFLMQE77bIN8NG0ZWTQ+BFJw6lO3Fw==
X-Received: by 2002:a17:903:4b27:b0:234:d292:be8f with SMTP id d9443c01a7336-237d9779db6mr254755725ad.1.1750770198583;
        Tue, 24 Jun 2025 06:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6fYyc4+LHFjvwoJMDaFlLmDYoZJBOOAxpL9d40WBBKJB6HOruCK5F8CKlq5GaxX3zM+yAA==
X-Received: by 2002:a17:903:4b27:b0:234:d292:be8f with SMTP id d9443c01a7336-237d9779db6mr254755155ad.1.1750770198110;
        Tue, 24 Jun 2025 06:03:18 -0700 (PDT)
Received: from [192.168.0.126] ([175.101.107.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f701csm107251445ad.217.2025.06.24.06.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:03:17 -0700 (PDT)
Message-ID: <2c9ce2ed-c21d-496d-9563-237547142a29@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 18:33:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] usb: dwc3: core: Introduce glue callbacks for
 flattened implementations
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com>
 <20250610091357.2983085-2-krishna.kurapati@oss.qualcomm.com>
 <20250623232433.apv23svbaql7ce4u@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250623232433.apv23svbaql7ce4u@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685aa218 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=yWXLeC16oIbqf35128AjHQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=-jcnzw04F3U9awwRRK4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOSBTYWx0ZWRfXx3UX2+rjO0TA
 JUyhYJ2Cby0Uf+SnKF0wF43H91Pz0/tQigjTSLtq6mquysDgRPw7+rpFFyDkVYnvtW+l+sC0/F3
 0jkm3W4pktb9nruixhuixoGukuRZGu4z7pI4FiCMvgCyvgL0DOm+YEHhRZBnMAhbqNyTqWDuhAd
 tZDiivFIYsbOFY3jIPRIZPPzQerOrMc9tJFmLMzYFXGkiVDSpVRf2KlEvMRpM8rFcwg05H7JHkf
 BgvDmRWlLspxigWKwwdlbFWBULz67dgbD1t/58kfsYfkILi2oXUdWh4E2IZtBbdCpzEk/hEE5g2
 H5weqQlIsGcasW8ORHjclWy82D6FS0ocA5ZHu7ILFr2xatyMkZwsI48S9BIVdh62YOtpCfXLEUz
 xiApECDfZeq0qHaDyOD65uYNo1BYWlw/ciNAQJh2lgYBI837GNpgmkyS8scfqAwo939PllAA
X-Proofpoint-ORIG-GUID: E5MIGhXimGiJYQ5v0h0l-RKbrgtV-k4e
X-Proofpoint-GUID: E5MIGhXimGiJYQ5v0h0l-RKbrgtV-k4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240109



On 6/24/2025 4:54 AM, Thinh Nguyen wrote:
> On Tue, Jun 10, 2025, Krishna Kurapati wrote:
>> In certain situations like role switching, the glue layers need to be
>> informed of these events, so that they can take any necessary action.
>> But in non-flattened implementations, the glue drivers have no data on
>> when the core driver probe was successful post invoking of_platform_
>> populate. Now that the core driver supports flattened implementations
>> as well, introduce vendor callbacks that can be passed on from glue to
>> core before invoking dwc3_core_probe.
>>
>> Introduce callbacks to notify glue layer of role_switch and run_stop
>> changes. These can be used by flattened implementation of Qualcomm
>> glue layer to generate connect/disconnect events in controller during
>> cable connect and run stop modifications by udc in device mode.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   drivers/usb/dwc3/core.c   |  1 +
>>   drivers/usb/dwc3/core.h   | 26 ++++++++++++++++++++++++++
>>   drivers/usb/dwc3/drd.c    |  1 +
>>   drivers/usb/dwc3/gadget.c |  1 +
>>   4 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 2bc775a747f2..c01b15e3710f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2351,6 +2351,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	dwc->dev = &pdev->dev;
>> +	dwc->glue_ops = NULL;
>>   
>>   	probe_data.dwc = dwc;
>>   	probe_data.res = res;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index d5b985fa12f4..a803884be4ed 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -992,6 +992,17 @@ struct dwc3_scratchpad_array {
>>   	__le64	dma_adr[DWC3_MAX_HIBER_SCRATCHBUFS];
>>   };
>>   
>> +/*
> 
> Let's keep consistent with the doc style /**
> 

ACK.

>> + * struct dwc3_glue_ops - The ops indicate the notifications that
>> + *				need to be passed on to glue layer
>> + * @notify_set_role: Notify glue of role switch notifications
>> + * @notify_run_stop: Notify run stop enable/disable information to glue
>> + */
>> +struct dwc3_glue_ops {
>> +	void	(*notify_set_role)(struct dwc3 *dwc, enum usb_role role);
>> +	void	(*notify_run_stop)(struct dwc3 *dwc, bool is_on);
> 
> Use pre_ or prep_ prefix instead of notify_ indicating callbacks for
>glue driver to perform updates before set_role or run_stop.

ACK. Will change it accordingly.

> 
>> +};
>> +
>>   /**
>>    * struct dwc3 - representation of our controller
>>    * @drd_work: workqueue used for role swapping
>> @@ -1168,6 +1179,7 @@ struct dwc3_scratchpad_array {
>>    * @wakeup_pending_funcs: Indicates whether any interface has requested for
>>    *			 function wakeup in bitmap format where bit position
>>    *			 represents interface_id.
>> + * @glue_ops: Vendor callbacks for flattened device implementations.
>>    */
>>   struct dwc3 {
>>   	struct work_struct	drd_work;
>> @@ -1400,6 +1412,8 @@ struct dwc3 {
>>   	struct dentry		*debug_root;
>>   	u32			gsbuscfg0_reqinfo;
>>   	u32			wakeup_pending_funcs;
>> +
>> +	struct dwc3_glue_ops	*glue_ops;
> 
> Use const, and move this closer on top. Perhaps below gadget_driver.
> 

ACK.

>>   };
>>   
>>   #define INCRX_BURST_MODE 0
>> @@ -1614,6 +1628,18 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>>   int dwc3_core_soft_reset(struct dwc3 *dwc);
>>   void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
>>   
>> +static inline void dwc3_notify_set_role(struct dwc3 *dwc, enum usb_role role)
>> +{
>> +	if (dwc->glue_ops && dwc->glue_ops->notify_set_role)
>> +		dwc->glue_ops->notify_set_role(dwc, role);
>> +}
>> +
>> +static inline void dwc3_notify_run_stop(struct dwc3 *dwc, bool is_on)
>> +{
>> +	if (dwc->glue_ops && dwc->glue_ops->notify_run_stop)
>> +		dwc->glue_ops->notify_run_stop(dwc, is_on);
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>   int dwc3_host_init(struct dwc3 *dwc);
>>   void dwc3_host_exit(struct dwc3 *dwc);
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index 7977860932b1..408551768a95 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -464,6 +464,7 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
>>   		break;
>>   	}
>>   
>> +	dwc3_notify_set_role(dwc, role);
> 
> This should be done in __dwc3_set_mode(). Perhaps right before setting
> PRTCAPDIR?
> 

Qualcomm glue driver needs ROLE (device /host and none) information. Set 
mode gives device and host mode information. So added set_role callback 
to get cable disconnect information.

>>   	dwc3_set_mode(dwc, mode);
>>   	return 0;
>>   }
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 321361288935..73bed11bccaf 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2641,6 +2641,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
>>   	if (saved_config)
>>   		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>>   
>> +	dwc3_notify_run_stop(dwc, is_on);
> 
> This should be done right before writing to DCTL.run_stop.
> 

ACK.

>>   	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>   	if (is_on) {
>>   		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 187A)) {
>> -- 
>> 2.34.1
>>
> 

Thanks for the review Thinh.

Regards,
Krishna,

