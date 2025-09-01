Return-Path: <linux-kernel+bounces-794262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02942B3DF26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79EE16DC4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EF30DECC;
	Mon,  1 Sep 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anxy8gHZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B430DD19
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720631; cv=none; b=ZyCWQiW+dUwkkqB/fM3xnfGMUIsBX3tpTVcdi2EZO8PE75AQ3InWumUOdR7bH6ZfpBUfdK64fpNBf8pA2bWxiyhsIDdL9aj6TN2Lw0MulLKwLfrSeAhYvQWeKXPzPvO0B/ZA4SAU7SPdJu7BdJicW7RqCenF48vjMoIY6/35IKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720631; c=relaxed/simple;
	bh=/u0ryJ6xCLlLqWA6VM5G5IQQ2G5Q5uH4siSOeD6tJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onNfP6QmyhwWCQw3OxghOIMPVTWzUTk22YyJ+cHHRDSpgoL6iFqrZJbbzOzHoDWRcnmzzXUQhgOE9xTYDetzxLi6sBwKsZ2nESfqJl1y1CH41hLfXsgQsOS10QFWaCWQkt4EoqlHgRIXEKho+Vh6LlZiCaxSspGl17niDMv/Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anxy8gHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5819eWdb004571
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 09:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00dLSbYm0RAfMXQaim1Wtp3zXWPbxfLKsoiLkamHIiw=; b=anxy8gHZliLYaPA6
	r7OIpwyVVv5bNxCAWPc23TQk4WyIvFFvDenRkBuNrqMljYrnJijGQ7ICM8U0pkkY
	pjqVUC4aB/tF0l/7BrhCHB6BMPKsLKjUznAzGBGPwnSTHF1RWt/jbQ76MkGKVMMP
	EA38f4jHgtjurdV/MjoEiUsBOY7bMFmOsKXfGNGFVR1gR8nGmJYHlKJvTDhtn5mf
	K9J5b8VsVOjKCvOasdY2xIJvDL+xHxKo4f/QQTzISeDCpPk9PNrXvFcZue8WnW9A
	IOpnlNJJ59ix+jEwhUHFWFwKKPWAreAthgMP/CUmp8bhnlhU+xy3i335tEylhwKn
	LQPWFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fc7hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:57:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-327d1fea06eso3279113a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720628; x=1757325428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00dLSbYm0RAfMXQaim1Wtp3zXWPbxfLKsoiLkamHIiw=;
        b=nMlpmojf4JkZGVGLJcbsR4b2XMkAvcYiYTkEIOBBnSeUdpmHQXqwwdPrB3YMOPkvJ4
         fjFY9hPjbEV6iIWl3oyLiJLFtPtR5ZVj91w7JMyus8xQoc0N5KvTNU4TdE7cCQ+FSA0Z
         UAQlHXPAcW7VULwzTSbcDOJIGoZBV717ng3IGxxxZtERtYsYaihqDX9JRh5BIIFI8Dku
         b+YhjSz+Lp3nMbYvYI/hcqx5WM+PvkZNk+KuvZe66Cq4qDdTZroMAevgTIP92UV/P6Zg
         112wZrrWIWXBD0gMOFT4nt3IO2gqJeZ8/JMsZx3cUHhSGNUQXwWHpc+oGBoUVUzCCLXs
         nLaA==
X-Forwarded-Encrypted: i=1; AJvYcCUrfO3qgdKLdISMXqRRWfi94c3FiAuoNfg+TsF4X7vH1viqNGoRJjXCfqTOT1GlJaiWZdOp7JE5I7EE5ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJAGXXdrx/SId0PFMay3HZvSISQM0O/Z3QvhGZhmZH0Twh5pS
	KUThkAwwmvEAe7YBWWlOxW+jgNJ+Tm3PqjwMTPU5g7WwKPwBdhoQ7oDv1HULAwVyMc9f6lbSY5y
	/rAyQkRMmiOmUq8IsH0CeciV/PTWu5ALpu8obPQF3LbjZaco90KISBKfJFLEmBWO7cxNvWgHJl6
	o=
X-Gm-Gg: ASbGncsbQE7JnViRnCLDlhwQVgJg2I78RvnNnuY/sOPRc6QrL1AD2lot5Hn1sq8PXek
	/pWZQBFBlnQysgsrY4ZJhg8QeO4gxrXy1mw41Ny9/Isz2WCDbNqjjmOP4U7GqXwDWP34Ue+Y04I
	FT3EyELTyhUC6vlNNYLr1o9TpWM9goLo4sackF0mDwcG5smPYjHcrzM5bPH+OV4LeUwaJTitPxs
	9chnBRmyyuqNxXSFnqJQgQyArAmsg/thgZZlhH+f4tDw6hIlFFxL8vHq1IuqHDgl+VdGHMlxVzj
	xNGx7mRoV36By/3wG4eQtRVYTYPfpGUA3e2si+fHc6zsx8pOBqWE64tHIQWqImW+luMG
X-Received: by 2002:a17:90b:5205:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-329cb761185mr162194a91.3.1756720628151;
        Mon, 01 Sep 2025 02:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo2XIc0MdwcHVOgcMpSGI5G399DdswL5C9qGONnIa5/Q8lIDtvNeTe9LQtas7uLSamRYS2kA==
X-Received: by 2002:a17:90b:5205:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-329cb761185mr162169a91.3.1756720627597;
        Mon, 01 Sep 2025 02:57:07 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ed87sm10763105a91.23.2025.09.01.02.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:57:07 -0700 (PDT)
Message-ID: <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 15:26:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Log dwc3 instance name in traces
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250828224852.ukelgargocektp3z@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX/72EbEPNPcro
 zX1lsIzvdL/PfRT6jbyDetUjUUubgCZpzSh1x2/dyfRaEaqPsCHOaX3LnrPZU2CRSuWS35YbGbi
 AqDlf1bJ5qz83zDmtoS/VRevE32BP92AwUoNrTW1H5+Q0ZZlJi3zRpJlO1aiCs5XwZTCFTDe0q8
 fdkC9FPSOnlnq2HjAgj5jqSN/kt3XtladP6fWyBg/5seoEEwwyy2UFSdM99cdb1BeU56mAUpwXc
 9xOfM3/C4hlSS1vxBYbgsf0S1itUZKFThxuQPhM1HzzwHeORJn44v2gYuYnysPJhXXMp/rFdAOk
 UQPhLIXmgRqd4VuAC9CT+k/gxroGEc03arrk36jXDFE1esBlpSJ90AAEkXfvGOUUkCdr2Z2Mtgr
 7rbS5tkO
X-Proofpoint-ORIG-GUID: yCH7zUhfm9UFvyQTqYgnBJInQKrZrxME
X-Proofpoint-GUID: yCH7zUhfm9UFvyQTqYgnBJInQKrZrxME
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b56df5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tjQcG7l_prDQjLVM-sEA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 8/29/2025 4:18 AM, Thinh Nguyen wrote:
> Hi,
> 
> On Mon, Aug 25, 2025, Prashanth K wrote:
>> When multiple DWC3 controllers are being used, trace events from
>> different instances get mixed up making debugging difficult as
>> there's no way to distinguish which instance generated the trace.
>>
>> Append the device name to trace events to clearly identify the
>> source instance.
> 
> Can we print the base address instead of the device name? This will be
> consistent across different device names, and it will be easier to
> create filter.
> 
Did you mean to print the iomem (base address) directly?
I think using device name is more readable, in most cases device name
would contain the base address also. Let me know if you are pointing to
something else.>>
>> Example trace output,
>> before ->  dwc3_event: event (00000101): Reset [U0]
>> after  ->  dwc3_event: a600000.usb: event (00000101): Reset [U0]
>>
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
>>  drivers/usb/dwc3/ep0.c    |  2 +-
>>  drivers/usb/dwc3/gadget.c |  2 +-
>>  drivers/usb/dwc3/gadget.h |  1 +
>>  drivers/usb/dwc3/io.h     | 12 ++++---
>>  drivers/usb/dwc3/trace.h  | 76 ++++++++++++++++++++++++---------------
>>  5 files changed, 59 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 666ac432f52d..b814bbba18ac 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -830,7 +830,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
>>  	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
>>  		goto out;
>>  
>> -	trace_dwc3_ctrl_req(ctrl);
>> +	trace_dwc3_ctrl_req(dwc, ctrl);
>>  
>>  	len = le16_to_cpu(ctrl->wLength);
>>  	if (!len) {
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 25db36c63951..e3621cc318ea 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -271,7 +271,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
>>  		status = -ETIMEDOUT;
>>  	}
>>  
>> -	trace_dwc3_gadget_generic_cmd(cmd, param, status);
>> +	trace_dwc3_gadget_generic_cmd(dwc, cmd, param, status);
>>  
>>  	return ret;
>>  }
>> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
>> index d73e735e4081..dc9985523ed8 100644
>> --- a/drivers/usb/dwc3/gadget.h
>> +++ b/drivers/usb/dwc3/gadget.h
>> @@ -131,6 +131,7 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
>>  static inline void dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
>>  {
>>  	u32			res_id;
>> +	struct dwc3		*dwc = dep->dwc;
> 
> This looks unused when it's not.
> 
>>  
>>  	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
>>  	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>> index 1e96ea339d48..8e8eb3265676 100644
>> --- a/drivers/usb/dwc3/io.h
>> +++ b/drivers/usb/dwc3/io.h
>> @@ -16,7 +16,11 @@
>>  #include "debug.h"
>>  #include "core.h"
>>  
>> -static inline u32 dwc3_readl(void __iomem *base, u32 offset)
>> +/* Note: Caller must have a reference to dwc3 structure */
>> +#define dwc3_readl(b, o) __dwc3_readl(dwc, b, o)
>> +#define dwc3_writel(b, o, v) __dwc3_writel(dwc, b, o, v)
> 
> Can we not do this. This will be hard to read. If we just print the base
> address, this will be simpler.
> 
> Thanks,
> Thinh
> 

This is just a wrapper macro for readl/writel APIs. I tried using
container_of in dwc3_readl/writel() to get the dwc pointer,
container_of(base, struct dwc3, regs))
but this causes trouble since we use dep->regs in some cases,
thats why i used a wrapper macro instead.

Regards,
Prashanth K

