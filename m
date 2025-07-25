Return-Path: <linux-kernel+bounces-745802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B9B11EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AC189033E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784E2EBDC1;
	Fri, 25 Jul 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqeD5n3b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC22EBDC0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447342; cv=none; b=QNsFRNF0XoADIgtMJFR4jRPfUsZQSz6dOrU4aLgPE2vydiwSa2lgSni1xBjG/ehEwQemH+sORQFuZBzSGF6XzDsXC6P0uFGtXlPhpSH/SOLDo5kr5EV6y555r+ZzGa3q5mg7x4qqnpaHXZZvw+hx1/X5T+NfpI43j5WAknoVKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447342; c=relaxed/simple;
	bh=eF6jcCycbuLtKWGj1n33neuzLN4zW9NG3LxK5UiDPPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6fUjWt6ZzqkCzQZWY9QjmyA5tnPQW7DxQqki0rJb1iL/10CZiW/A+wOiw7uZ3H7ORF/B8GI2Uns+rr36Dq+jkPm2XgMk3B0BgVFFeFHACOSUgwuNbXyxUNws+OF18hQeQT/G1GXu14ltx1JpTbZQ6W6ckH5EflTHj8CRCveSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqeD5n3b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9S0WM000321
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LhQRzHb8yYt93GhMbsQukxzdBNoYn20J1vJtQUloums=; b=eqeD5n3bBxhsghnv
	nnTYw9phj0yplazeT9CwTTzkMky8ECUs7SfWHv4rG8DAUyjeXuNHpHN2H3N1x5Uj
	OgF9VjqO5hkrjHq+797+rNtXe48FK1lsphU6DjqkqK/9IeQ5M182iIbYkrR/8eJj
	I9NYw3taXla14O4qq8yYZAbJMo8Ui5TCaeq5gHDIvKOiocrSFbEw/3ncYaVoippU
	udPzie1Kg+PpnFoBf2HGPaemjvTvS07LiQ7M/hJPk6kiTRvp02hkrduoIbXJNAYQ
	XAxGD5gSezQm1p4H33raazwOqu8+OFV/NE6xHxoNrZ8gEgIRluqKZWPYNdB68IQh
	x6NBvQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xj25k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70717059030so3081426d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447339; x=1754052139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhQRzHb8yYt93GhMbsQukxzdBNoYn20J1vJtQUloums=;
        b=Kd0Gl/i5hfulb+NHXG5uA8pQLsHHqdVMcwu4PcfY+g9vL9ohx1AI5NzVQy4AzA+Jbq
         glIkRL7pAVZG1CU5Kqv/7O/3c66RspzMX6FdxkoIlYWFO6RPttJyk3lOBgbb2I3wRFAW
         5BaZHV1Jgi9CoSsM3WsEGbIAn2aBSLv91Jhahq2cniQffKPRP8T7VTzJOUbIMdjuBIU5
         yibowWL1nA2JTRc74wkOZjHN5Gg2HIDn/bYRniOrqfw4WN+XhM4lxIRJjdna4z+X8Jip
         k8KoGXpBpxAZ/CscGVucBfi2bnGJBYOFcxXlRPeZil1Eklssb8ymgWe7DXiEKGlkHNne
         gBiA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Sa1pN75va+2dLCjWoPi8N2qS6b2levKgW8lQmTmRGpRe8gtcGA+hFT9VBobbMuSeU7SUjg8aRelSndU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSt6MTYi/E5XHcy2BSOwfKBQV80g6Mv4dxrMdK0Kx4JuaLGQM
	mcrT0rKDTjPE5VshBco/mmMJON8trp8LAYmNJD1wsoC731WHYh9JlgguvF5ZP4pr96odFJe70kM
	oVqn9kAIzJEwC0xYI3RB8ToSMwwzElhZRpw0gpn2HBhQv8gmio9ib1uMaLwMMrGOxKco=
X-Gm-Gg: ASbGncuMkYZmjOuNmCRPd6aMJVENHQmz3FLWfGmVwnF0O58BMjQ3p/dfMVmY7Sp5sef
	2H6FAjE9YF7GJ0ytYA1rt4OTwFqY8Rc8g8lDFnfP5MbLCiV3GlFeNw4bCxnr8DKVtSWwwiVYRuB
	z+9wz1flKZQmV6N9YgWF/y1/3wV6WKdsTiNDMvl2RX1GLpzO4Vm8Iz5pF5Brfp/ugskUNnKWqg/
	lPBTVxpC5LHP69AC+/joohedO7FNOCqwmLl8o/phW4R1q9Rh0h2QvyE8d3c6GSwBTAI7u1PTOEg
	AAP3Do9wb2AaaFzpZxmNk4KzmAGA9mSIQZzP+lZ8AMZOT8Vha+m+ZCXd32yPkWVqr8TpyggKGky
	te5/jfhpXLtlBXQOpbg==
X-Received: by 2002:a05:6214:1bc9:b0:6fd:75e1:16e0 with SMTP id 6a1803df08f44-707204cd90cmr8732036d6.2.1753447339094;
        Fri, 25 Jul 2025 05:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcNKKegjXwc03c2xHl6u8ikHVWlVcUyUE5gVGFjp9xIoK7wro7ZLBbzntdS8cdJqm9bMkAlQ==
X-Received: by 2002:a05:6214:1bc9:b0:6fd:75e1:16e0 with SMTP id 6a1803df08f44-707204cd90cmr8731796d6.2.1753447338519;
        Fri, 25 Jul 2025 05:42:18 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd2fdbb3sm2097125a12.31.2025.07.25.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:42:17 -0700 (PDT)
Message-ID: <12c9b2b0-e084-4518-9f28-735fc80444b2@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 14:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] leds: flash: leds-qcom-flash: add a separate register
 map for PMI8998
To: fenglin.wu@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-fix-torch-clamp-issue-v1-0-4cf3ebaa4c67@oss.qualcomm.com>
 <20250725-fix-torch-clamp-issue-v1-2-4cf3ebaa4c67@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725-fix-torch-clamp-issue-v1-2-4cf3ebaa4c67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FPu1L880nZkCFknnhxw_-KhwRJeVkfsj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwNyBTYWx0ZWRfX/0ka1+BoRPLR
 ZYfiwxQOCtgwXZczH2DzmhJ/tSokBlfXttgDTYabOGAWbT5dfL4kvTGQxENyBqq/KbIIspuFI2l
 RHyc9wsq9xyX9iv/pSna0bepACBk2ve++KTx5iGftBv9npHVH7dTl9EtXZgCoHGuHJapH9RR/RP
 ixk6bBRzr/9S0fyP3Rkf9x8yG6F+AQDmWN43jV8PpMm5jHop+pafzw0xIW4+0tg3+2kkpFKEN+x
 C1tCBTdXm2IXoeHL71LDeHPbMObQRbRw1hSZYYkwG3LoiDBEQewArbLbsyBWJ1JNBMJIkcLoYPN
 7PsaZ4SbWeq+nZnply7Jw7/WmqJ2SuHFK1I2hP27D9sqznv1RAUv7LkIXb1crgT2o7kJD4UWPyg
 E/Is5Q+gunxcJxtlaOv+K8ocVDJ3k9VHGj4Bw8KtgCoksHK39mhT54d19oaIA4xxGnDrXIVj
X-Proofpoint-GUID: FPu1L880nZkCFknnhxw_-KhwRJeVkfsj
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=68837bac cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lzWBnrassQNQYiy42ZQA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=825 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250107

On 7/25/25 12:04 PM, 'Fenglin Wu via B4 Relay' via kernel wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> The 3-channel flash module in PMI8998 has several registers different
> than the others, such as: torch_clamp. Add different register fields
> for it.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> index 9c2e41cfddcf2d50d5a633cb157084371a631d74..2554ef7bcae6bc8f66edbffc7c885a9386b263ad 100644
> --- a/drivers/leds/flash/leds-qcom-flash.c
> +++ b/drivers/leds/flash/leds-qcom-flash.c
> @@ -118,6 +118,22 @@ enum {
>  	REG_MAX_COUNT,
>  };
>  
> +static const struct reg_field mvflash_3ch_pmi8998_regs[REG_MAX_COUNT] = {
> +	REG_FIELD(0x08, 0, 7),			/* status1	*/

bits 0-5

> +	REG_FIELD(0x09, 0, 7),			/* status2	*/
> +	REG_FIELD(0x0a, 0, 7),			/* status3	*/
> +	REG_FIELD_ID(0x40, 0, 7, 3, 1),		/* chan_timer	*/
> +	REG_FIELD_ID(0x43, 0, 6, 3, 1),		/* itarget	*/
> +	REG_FIELD(0x46, 7, 7),			/* module_en	*/
> +	REG_FIELD(0x47, 0, 5),			/* iresolution	*/
> +	REG_FIELD_ID(0x49, 0, 2, 3, 1),		/* chan_strobe	*/
> +	REG_FIELD(0x4c, 0, 2),			/* chan_en	*/
> +	REG_FIELD(0xea, 0, 6),			/* torch_clamp	*/
> +	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
> +	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
> +	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */

Please keep them sorted

Konrad

