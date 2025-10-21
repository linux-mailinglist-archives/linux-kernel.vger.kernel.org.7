Return-Path: <linux-kernel+bounces-862202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3BBF4AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AA3426F15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFD25E44E;
	Tue, 21 Oct 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8b8exvB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948F25BEE1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761026208; cv=none; b=hu+hUn2chRPx+2HVLc8TwO7baVcwBQuqR6miBuzE84NSBivhQVpHQFNx5hiye9Hv+h1E/2JiYOmyvEdtnHNe3oyxKolAZHukkg/TsiFwWIwvuCrwbYhN4vJPNPtfKKpmxT23qtCaE4eQfSzEijCDUCfTuM4LVewcShINYYZ0N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761026208; c=relaxed/simple;
	bh=u8DYHJMSpMrbvdPe/sFzyth3WWxBIK52tEFjXzsKU/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYEBUru9NngvNP5DBRJBYbeGg0wrYk5pyTl1b77VTY5zFdI+zRSdLpv4AV/eRZVEUASCIdGjHP4e3DzJ0LvpQ0mJpp1PV24WYdCMErFNhXDn20r1TlJ0A7uiZ1Z6lJzs1f2lRvtcSo3fcPHVJBSzCSpgRWwiPAUFtMguSgrkx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8b8exvB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0oxB029400
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IrS/pqTBCF+Pif7x1Ny/z7bKzj3uV3/DSsRLVsYq6Nk=; b=M8b8exvBPv93Ir8I
	jJcG61MPsmtyCAgUVxHf1DHrFYGKcugSCH6w4iXMRMBMH1LkBJkuZPq+n5/5Xz4W
	9bzYmSR+P7jqKcNzq3mcsdFg2Cx93yV5q9SRvb4TMM5pxm0NVUFnDmnxdFTwucMA
	JfMihEvj+wlDuSGDg7pi74z9lZyTrjTa7qxX8eSRnuKkFzB31vE8GZwO7Ep/mYjH
	dmgwoC3XeiCwP4NYGoy4HO8VQNBrnc3iCvzzQAY0ubLEMTtewXyzJWO8ZPTxwC28
	S2tcl/ru2UItGO2yinWXFUZyJLCD7WHNqZh+wffwe8Lc3XC4cNDr3d0SvdKOFZ/9
	LPBWzw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wswnsneu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:56:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55443b4110so3789750a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761026205; x=1761631005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrS/pqTBCF+Pif7x1Ny/z7bKzj3uV3/DSsRLVsYq6Nk=;
        b=vpU25S6p9SdxwNmXbrsEHhtLVJbjQI/DsEuJsP/MMMqZCkvYw2UGSnFklFHlkeeA2I
         FocjXhR20c94D2U8jqV0bBAFJh8O0WAIW02A7LJqeeF0Cww6d7bEiN0xFlfqGglnjrZu
         dpuWdRi2OkSwsA/E5W20PqZlEkHxfpvpfSmjN/m/aE68/ktBY20/AkbC9syJXLXXpF6B
         VLysHX+l7MrFSWaASfGT+YDaGcbPQudqthL8tAjn/uzVf90Wga5bbSURyCM3hcRMfOrr
         qJx0uftt8Z3Fp0eydtJrlJ9gPoKYz6bflhVRkya+sg6s3vWVkGkPMuj3hoFSR5e8B3Y2
         /JnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUllB9OPKjj7XoZ5S6eRY4Gc7GAk1aLFUaHmS+oRWF0x8ZZjQJY3o0+sgb/InsrQo5PFR+ykS8WOsjojks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lSGfsphEbTKQ0Dx3SimS1SlnS06+hP9sleT8kZZsXa/axnGi
	PxwssVpNjh4ZhE058GhzqmZyVxlJaEiC+vxBTs9QwMcJX8MzM8xcHRKmSSj0a0yaw7A0vLcUivj
	KcL10eN9so0/RqPXBfaPGSd5EIqb1vTLr7lSLeHP/JJ0D3RIqsKWNXgKa34O5HQzGlA0=
X-Gm-Gg: ASbGncvXWsxUVBDjOI9VcZNriPo45HMC4ZoM4Hzt5TGjCjTMZ/0FiD58A3OKgWeAy26
	fHcFVqH9RoREBquU4IpJ06uDYHoO+GD5dOTlc+zscaO+VQqGYZlRBkHnNdDxW77oJqaV9Xp/flF
	G4TMWAEjov9YdqCR8b+BPNRw9evK6VgNl9dxDYay1Rmz6l6WUeljwFT5zvuNCJvmH0VseG2EKLU
	nDU7yRKlvxftLthdYZJU2rjI9NgaAB0Mh9I7qdzyCzvfMyEPQUYebTU/q7cK6htvtusKqvGPfqL
	T55MWoohAKhBs2FGQK8eWqCO9Xedc35swpqeCIO6Hr0eZv7pRHbaQqZPkptBUvY9XaBujF6jwnj
	G/YnHxBROJXyvnaQaipWkZdWjABtW+V0KK0A=
X-Received: by 2002:a05:6a20:939d:b0:327:957:f915 with SMTP id adf61e73a8af0-334a7930a37mr19195452637.24.1761026205595;
        Mon, 20 Oct 2025 22:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1GEYVk9ZmIggP1CN6LfI1euxvj6RfnyqtN4yr3HxRtHXhMW0D2MVeUDQoVSixJwVcAWq+mg==
X-Received: by 2002:a05:6a20:939d:b0:327:957:f915 with SMTP id adf61e73a8af0-334a7930a37mr19195427637.24.1761026205132;
        Mon, 20 Oct 2025 22:56:45 -0700 (PDT)
Received: from [192.168.1.9] ([182.65.65.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf086bsm9865639a91.2.2025.10.20.22.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 22:56:44 -0700 (PDT)
Message-ID: <8eaadd1e-793c-4931-bee9-599fd333ab04@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:26:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: advertise puncturing
 feature support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
 <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <e0ce9b89f0e0a6379070e9e135c53722a2d0a19f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3kL4m4tzMXi_5eKCFIIz5KpKCgCgSnOU
X-Authority-Analysis: v=2.4 cv=Maxhep/f c=1 sm=1 tr=0 ts=68f7209e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=pYoUJYacPP78anNlNKsc4A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CYPn88_h1FTXjLuN7IgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 3kL4m4tzMXi_5eKCFIIz5KpKCgCgSnOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX7mudqGKs3i6w
 WfIfSKizByjIu+d/TynGwyp1OfR0vE0u3lzxrrQlLHK/IzmzSEPZCGrZ6GtlMb47Ovn45BT1yfw
 fjtkWdcyTu05JycNn0bMljYZfhlRUKRL+Yu8I3GBcqZRapvddIiavpbI12de7UU4qjHWKAxPhO/
 9os455NED2BTz+lKcIRYdfH2woFbTR4ZLZ6WZQdKVDQAnjpA1UPxhcEu6s2UgOBKF9CqHjnXahj
 TuszyUAu0IqLluV8yv11kk7Y2mR/FuuqDIq4qxYt/DU+y1dbhT8HyquD4NZuGT8XA1gy0jT9aaE
 SmEGluNgStOhmZMFuJDBSIQ63TO+JyWpXdDYO63Wi4o7DRimVzOTnoiQMeWUhPEDDq7LzjWB6FS
 ze0m0wZ7e0Kl1z6yZWaF+9aoLERjSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On 10/20/2025 7:55 PM, Johannes Berg wrote:
> On Fri, 2025-10-17 at 09:32 +0530, Aditya Kumar Singh wrote:
>> If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_BITMAP
>> attribute, the kernel with mac80211_hwsim driver currently rejects the
>> command with the error: "driver doesn't support puncturing", because the
>> driver does not advertise support for this feature.
>>
>> At present, the following hwsim test cases utilize puncturing, but the
>> bitmap is not sent to the kernel. Instead, the puncturing information is
>> conveyed only through the beacon data:
>>   * eht_5ghz_80mhz_puncturing_override_1
>>   * eht_5ghz_80mhz_puncturing_override_2
>>   * eht_5ghz_80mhz_puncturing_override_3
>>
>> A future change in hostapd will begin configuring the puncturing bitmap
>> explicitly, which will cause these test cases to fail unless the driver
>> advertises support.
>>
>> To address this, update mac80211_hwsim driver to advertise puncturing
>> feature support.
> 
> This might be a good time to introduce better checks vs. what we have
> now in hwsim_chans_compat(), which just uses the control channel rather
> than any actual bandwidth/puncturing/etc.

Comparing those will be equivalent to comparing chandefs instead of 
control channel right? And we already have a helper 
cfg80211_chandef_compatible() to do that. So we just need to pass 
chandefs and call that helper? Or hwsim should be more stricter and just 
use cfg80211_chandef_identical() (this helper is not exported yet!) ?
  >
> It'd also make the tests actually test more. What do you think?

That's true. You want those changes also along with this patch or you'd 
take this one as it is and take those separately?



-- 
Aditya

