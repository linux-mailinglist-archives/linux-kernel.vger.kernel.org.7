Return-Path: <linux-kernel+bounces-881699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E03C28C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9B4E33D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308A253F11;
	Sun,  2 Nov 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAfF+9CW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qa7tX9HC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C31DDC3F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762075315; cv=none; b=HplPjeoUxe8pcmf2tEmQS+9mNohPXyveokhVnrSj+yFZmnx4Qnj7M1z+Dr4brk48AVaPNYkgwNMSpyMFyZyKtRnTcjPazZ0gQTU6ruwUpazjwt6WI1L5AbP8u3MeKl7nBgOTWZOj6cO8uSNUvxpRGhjfQQmwCC53T0BHlSAPuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762075315; c=relaxed/simple;
	bh=17mp+J9b9ZRdNDDB5GHhXpTZDLvIrOjlqc19XX6LDoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKsBvehu+Jt4UkXvXn8FKFf/x337lIkmlAQikfT5L0sZpj3spUyhtPrnmEpB8yoGDiU3al6xUQHoUx8cxuTOnnRRUYO+3G3IO13PXyjT8+miuyQ0NaKdLPcVwCgDGnuKQj5RK3T9VmQ1e6RspO8DYgi+tS6KjI9QEgSotxZt/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAfF+9CW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qa7tX9HC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A27kTgr3735866
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 09:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=; b=RAfF+9CWZNC17iOv
	nqBHywMnDHORhhei9L/R2XqBT2VUNligWR3myLxbxcOmto/7T7ZMtrtvHllilCDd
	fVOVNNnv0kGpnfgjgB5aQ3xbWhleyrUGUrO39Am+ASuZbnZhfbsAk+oWR+0R1oWP
	ueQLys7RyuNx6pdtLmtaMQhU+K0Pab4lSsheheVZxX6kEAxFPmgVOVQTnUSQGJdQ
	bdQGVNHmkJ28RlC0vN1x+NEu0CCE191Tv30tsj1zOMZ++wFa76sg4zwQJ6D0Wn3K
	avGIJnraARoixUbIfKzAtkseD0CSsHltKotmNDIjAEuYYgVoopLIN79YHinvGDVQ
	21O9Bg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae31w9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:21:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a675fbd6c7so2539018b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762075312; x=1762680112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=;
        b=Qa7tX9HCAOvObkHKBrKINyXTo8HjPGo1CXWM6bMim9jQwVEBkZvjxC69iEqBr5fp/X
         8XbJ0UqUdGZpx2cik5V5lELguirOLCy6sR1hPEbcpuN8MZDZM1BreZbxr7nQ/BchMLQ+
         Xkw8mlX5Q6hgr9p9jskKIF0oGkaz8d0lHaGsjGrTC6gMZGawsqg3208Yb0Y+WwMTmk/Z
         QAEgcYCm3nozjtu82vzBEAX72FA2ji6F60mnz19fy+6xmjdETphPrsxaPTLDfODukOL7
         q5f528Y3Yiad2JPiyl+/jqqheFxMO9Ls2saVOcEtVwmQ3/e8N7VvE/6gewkLF/AM920p
         Tsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762075312; x=1762680112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAk65/6oxj1521SvgSULDG1z7UA2kHEPOczJdwu/uSw=;
        b=AP/xc5Wv3u8TzZ1wON80t81NyFAvgNGRM0rorzBGZ6ZSnXtyhY0apACmwAfgfLEoKo
         rboFkeV+pzOsvxEutMeHnvHjJKIHeRBxvKAfi+6uEJdPrjuThkI6UuyZ2AJLXox/lLIc
         j2Eyvq8dpssJyleccPmzcdZZhiFY2sfzrf0O70qmW4GLqrQb6+rjRu0lKtNVCr38L+W+
         7yztbiBXqMr8SkF8ijIiHoZdi/i9KXZezcZemFdTA0NQ0OuNpDzi99cTe8jvu4PoZs23
         OWbvvl+S0zG5LDZmbgZAKtUyRkLihsNvPKi9fNpnXNQK8+wdrf/0lCSPtSw5Z7ZagjQK
         xGOw==
X-Gm-Message-State: AOJu0Yyy+TaQK2bLz7xcom/vL9SbFfqKOOmrnnA6VGM/51SYxEqG3DIJ
	AFpEFNsj/HFeKBLMrqW1h44Fg2TDZkxdIQ0IBymGg40crHkGlUbBt9GIlRmwTSUQdOqWXsrLw4z
	ygauTH+10i5io3LucudHrBjB0fvCCiiIyfglLhnW0BDoQGlN4otcz3+AKoVtxhmbL9dI=
X-Gm-Gg: ASbGnctd/65X56u4tSy3FoKT1KPxch1OaRsaTmgSXAvz8lUQIDaS1uNFj+G6036scsk
	f2zWNhmbY9VBdzY07GSIVkbTS8vfvC9zuevVWo+Nm7h9bZnFWoSwYhT5AuoEFnTAKnXGSyI7G9b
	DU2ZsxHUShBQCwnqfLVN/XggwRk1vhY5c1JEPogpe3PoZX/VWtYIGovy/p+2JyXhDugg0Lm7uK9
	yu9ey37hSXx1C+iB78DVf6PA3UAC0tqWDNczh9UGA7wHBqnPq0vCKBiN6je2uvmg72gQ6Z39UiG
	VHUPw9EQSDgybDBgJOu3GrqrwwMvx/VqDGmHrgQCkS/1j29LM/YQefjiMMsaGF2I9QDVpdfyC5v
	4/prGtnt/JHsD835BHQeOaAegO48ahMJEoUGRpLprLdaQK/NBhMtD3nshFV5+K8jn
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr13299237b3a.32.1762075312398;
        Sun, 02 Nov 2025 01:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcmjVi+40dr9p6o/3hoFcMaPlDSC/vKfYhfoR5jnlpypTGY/GIWuBn/J1+Vo8ouKI8w+WRrw==
X-Received: by 2002:a05:6a00:4b4c:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a779eefde4mr13299221b3a.32.1762075311827;
        Sun, 02 Nov 2025 01:21:51 -0800 (PST)
Received: from [10.133.33.28] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e862sm7580857b3a.8.2025.11.02.01.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 01:21:51 -0800 (PST)
Message-ID: <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
Date: Sun, 2 Nov 2025 17:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
In-Reply-To: <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nEZrO3qCHrHdxnqDxZNsoISJnaxrkxX6
X-Proofpoint-GUID: nEZrO3qCHrHdxnqDxZNsoISJnaxrkxX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDA4NiBTYWx0ZWRfX8oruHdloC5H5
 ANEtUfYyEovVaSYadkLjMQ+mY9CFWzvsqTaANMM26Lfv4ZIgsKnRQ1z6Z3X4Qpohlk3dxd0BQQj
 dXegD2ZNmX/xGCeafR+OVWIyBlJg3wBYPbmvjk/96vKOQTXlmieZSSxe8V/aVBSkb4vrLr1hZ07
 8Vn+aYWG0CD8YpZOTp0EYpkWHMP6630629XMpsIyyhnkC88HiH1BD11Zj2UPa5ljd6sMYyvJCsX
 VD/yjon1UHbnCYWtRNP5BrW3S8edtvK2joeDJFPs7RbhnK0Ka4DfcCH+zYA0UWp7ek509ZV37zc
 yJ4oe5/3BE4eZFPlf8rKnxg6Rcf8ljb0aFTW8IFQcXTnZMvw0wqlR8Xt6FVe1/uJIzoG/Co/2lu
 tuOLFVP7Qv1iqH25D1zK/1hqF3f+CA==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=690722b1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RlJQG4Jwgf-QiIBLNHQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020086



On 10/31/2025 10:43 AM, Baochen Qiang wrote:
> 
> 
> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
> 
>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>   			ar = ab->pdevs[i].ar;
>>   			cfr = &ar->cfr;
>>   
>> +			ath11k_cfr_debug_unregister(ar);
>>   			ath11k_cfr_ring_free(ar);
>>   
>>   			spin_lock_bh(&cfr->lut_lock);
>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>   		}
>>   
>>   		cfr->lut_num = num_lut_entries;
>> +
>> +		ath11k_cfr_debug_register(ar);
>>   	}
>>   
>>   	return 0;
> 
> miss _debug_unregister() in the error handling?
> 
> 
The documention for debugfs_create_file() tells us:
  * NOTE: it's expected that most callers should _ignore_ the errors 
returned
  * by this function. Other debugfs functions handle the fact that the 
"dentry"
  * passed to them could be an error and they don't crash in that case.
  * Drivers should generally work fine even if debugfs fails to init anyway.

So IMO any failure to create the file should be ignored.


