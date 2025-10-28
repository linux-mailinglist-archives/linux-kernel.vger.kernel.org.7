Return-Path: <linux-kernel+bounces-874256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E478AC15D50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 667F434FAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02F291C19;
	Tue, 28 Oct 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guackWGX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQw53Ua8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2A1862A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669233; cv=none; b=Sctb3P+A5FM0yq0kW1YuGiIKA/wY2UOsmiyhjJo7O9ZVRWeQ4nHP9WjSNXXSoDTkOUEHQViJR0xbLTdPS2e6I7WGRsQlpeO0U6cVewu5gmLQQVgKNXfbv4stej97MgpphGX8zmGS0fsRJY5ZFdTd20KgqVbjRYwsulcbXbfjWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669233; c=relaxed/simple;
	bh=eOTE/km5/N3hc+Vl51e5oupuTDoNIHQBwinbRvEGD50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUiBFLaPlFy0t4oq4H4CQKmGEUM7arvn0MiP/BMPLjfauU5Br0WqUgIDI9y7/89TRN7xjJyt1Xst5CGQmfIwJ9Yp80gZplHkGL8y+wjQzvIXIiulmyNuhAAenesqslE82L/rCN2/vndGztlNTDhYQp3eKHuTa05jkCp77Px12e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guackWGX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VQw53Ua8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEni6m1886395
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUlkwC6XcdB1g2sKWT5DXiAU1YeZiR8gHbTuuonsJ7c=; b=guackWGXGQou21pa
	1jencdN8ab/rjP74joRSmFV1UfzjNV92alviYyIm77aPFlNmdpsbc94FPf094/l3
	EyBk3U1qvXPVrtF3EqEdjGboeeHD0cUtX+Ae7prGHJY89cUZgR+x9nYZCI9/BGst
	oHeOTcKeuNYkO5Hp++qSDoHaBsIJze01FaxNPKTllvNtweyjLwXIgOumLUh8u4Jk
	TK/R00vj58ujV3S2OviWZO61grvLJS86WMGJzrkaL+KsfBEG+SR5bvSpC8G98I+Y
	VzWB8qcvuLYCcw2kti705m1YsphFP2MUwPTjAnkVM1rPizU3eNb8amMFtmEMK+Ma
	1wXc+Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2xxj0jyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:33:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so9891288a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761669230; x=1762274030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUlkwC6XcdB1g2sKWT5DXiAU1YeZiR8gHbTuuonsJ7c=;
        b=VQw53Ua80VJ8dTFWqgBpCNXGDD74O2h4JXGswx5kHNPfRg6QonOGwhkFsNYBL5f4aG
         tkpzEkKJd2/j+Q8NIGAYmEpkCa3KLx+FLD/X2UZ2r2FYK1lD6SfE2NFeq7jy0sobiMZf
         w9DiHS+WAVc9xLtWs0PNYyLUi3M2hmjm8HZ4ggvlbdztVb9tN1E+yptiTuX/mcjbq0tm
         glwzfkuJ+9JxP+ZC1bBKrHUeHP2fYoc8hZeejDqc8TpRgfTD0CXIvP8APcqkg0fvplaX
         mpdctHxPHcYvKb9vNbMzZjVw2kgLBKkHBJu9t8RzV2qH9BYDzfSc2vUBZPaUDhkcIqCv
         alsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669230; x=1762274030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUlkwC6XcdB1g2sKWT5DXiAU1YeZiR8gHbTuuonsJ7c=;
        b=OIKPMccApgcZrrW16OZcU4ZEkbUXc0OpDLpaxqwry63os9j6elECdPMfElk73424Nu
         WQBPiBsEoONTLHbg64OrLxTsfNebF6iNHr/P/acL0FiCIeOHIhOLjyOzte8lcEJmG9yw
         57T3fspPNDD8fiH0ej5cieAumK1xmQsBvL7KizViFctvzzC3Ht4DvVZtynuZ86oJLJAW
         VeB9nTJ6Ekiz+dGV+TEspH1sNo4BDPItFWc67yeV9CExz4/UsZc6H5JZiayOrutggsxn
         hVlV0ZtPC/eoGmCa7O6R8KFiWMevPVDxJXRWc7wlkNIGvv0w3dJwhPuWfEndK+aaD/XZ
         430g==
X-Forwarded-Encrypted: i=1; AJvYcCVr7QhmQ2/a0hBC3uKFAq15ijaubz3tIr+tLpsLwqag21DtweDttmXUMqRjU4Am1YIYO1iH+yo9Cd71vNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxpOAXdi2ab24qy9AHUGs21cFjI5clszNAKdJWIh4ysVmfik6d
	l3yMIxkgtCXDuY/UvdstL4/yTQk98kXp3GIhsLdsLyAFAxpjelZQkeqljTIZs7Dbmugod66kaR3
	P+2jipxoEBNXksWoMFahA/8sndHeMLoZL8z6UgbmtWs239OQ66Ff42pupdTGlk/o8aArqpbDxDN
	zf6g==
X-Gm-Gg: ASbGncst8/0MiMuyvMJZFFw5gBmq+nDut4/7AlJX0NE46BxgjUhff1gkMiwwwlc7pXD
	heOUcax6dXS3j8rnSgyKFNxfZbhdMDw7Vc1C+/LBAs0M5fvxNbZfnblNYw3iwv5yI8IY/rcPhke
	Iih1BOo2/sd5cVjTV9Xl5rKc6g+jRrmAPo2yYpfHaOzqDe046GMsAzUYxJH4UKLf9f6SD0rZC0p
	mgG1e/HMddrKsvXZP8kVUjz/WV43r58llkSfo/q82tbU9rxImJSwAQ20NMa4j4RvU+UvZAw0g+s
	lmS9LyvJmLX/WqiNGQyw+BXjGP7NTvAT4vJZ3PZvQpNbcLvfqOHKA3POWak4niHhVx8C7pCxkNc
	l9yU5zpalgFzhkY8f/QKu+Wqxwc5HM2Oj
X-Received: by 2002:a17:90b:3e85:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-34027a7b894mr5148787a91.24.1761669229954;
        Tue, 28 Oct 2025 09:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBwVsnIJ+qpjTls4rI4uT97ont7N/GI7L+kklzoYSRhy4gq3CY/JaWRK/RGD+wDT4w8EK3Eg==
X-Received: by 2002:a17:90b:3e85:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-34027a7b894mr5148741a91.24.1761669229318;
        Tue, 28 Oct 2025 09:33:49 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71288857c6sm10705179a12.18.2025.10.28.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:33:48 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:03:42 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] watchdog: Add driver for Gunyah Watchdog
Message-ID: <59a00934-cb42-43de-ac5b-a9292b08301d@quicinc.com>
References: <20251028-gunyah_watchdog-v3-1-e6d1ea438b1d@oss.qualcomm.com>
 <25f7ff09-08ea-4969-9184-9fd01b097558@kernel.org>
 <76479593-c47b-41a7-8349-5d7c1403f7c0@oss.qualcomm.com>
 <73955d58-544c-4299-a099-bfd9e5912a40@kernel.org>
 <636a1f99-acd4-4904-8fae-f159646cc1a0@kernel.org>
 <f4d80be9-986f-4d37-9c25-725eff7bb653@quicinc.com>
 <e03373d9-e2dd-48b6-93a6-554fcd623718@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e03373d9-e2dd-48b6-93a6-554fcd623718@kernel.org>
X-Proofpoint-ORIG-GUID: pj5stD1fX1nWmp974ZZduOa4_moxjcq_
X-Proofpoint-GUID: pj5stD1fX1nWmp974ZZduOa4_moxjcq_
X-Authority-Analysis: v=2.4 cv=UInQ3Sfy c=1 sm=1 tr=0 ts=6900f06e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=cz7308oxQqenTtKe3SgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MCBTYWx0ZWRfX8TdUm/HC85+O
 ipuqY2FN3lKT96iuLYuthiMncC/6ILC1wB43Z2rfGzp0+ZHLn9NhHPw2lC+oA5OzvxYE23Z5C0w
 8Uzl8/iX4X9RXAnMOa+UuOtAECAcqWQGpd8/FD0nkDSh0JKMk25Sww4bCaKqnRkHVZ1mrQNfUMv
 Fu+12icvr9V5flZ00CBXdhdTxmRg/+wckan+QtvHATxfhR4eXHDlEhQTEZVei/v+UQ4ulN4BRJ0
 xys0odGWW0EuaYWEk97y9n97QrNDMbZAJwohx1k+1sR3OjifmvOLQre4LxzfHdqs08WcoJ9InZD
 o5Fm35CJUUXBRkiNfNtY6kXyiYWxhDyy9tzZlwA3T2m0AZKF6BgZihKPJkGaDgpQlbuNnLE+Sxx
 irvnwGJtNXClu5OPUp0a+uQOclM2UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280140

On Tue, Oct 28, 2025 at 05:17:44PM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2025 13:27, Pavan Kondeti wrote:
> > On Tue, Oct 28, 2025 at 12:07:40PM +0100, Krzysztof Kozlowski wrote:
> >> On 28/10/2025 12:04, Krzysztof Kozlowski wrote:
> >>> On 28/10/2025 11:58, Hrishabh Rajput wrote:
> >>>>
> >>>> On 10/28/2025 3:10 PM, Krzysztof Kozlowski wrote:
> >>>>> On 28/10/2025 10:35, Hrishabh Rajput via B4 Relay wrote:
> >>>>>> +
> >>>>>> +static int __init gunyah_wdt_init(void)
> >>>>>> +{
> >>>>>> +	struct arm_smccc_res res;
> >>>>>> +	struct device_node *np;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	/* Check if we're running on a Qualcomm device */
> >>>>>> +	np = of_find_compatible_node(NULL, NULL, "qcom,smem");
> >>>>> I don't think you implemented my feedback. This again is executed on
> >>>>> every platform, e.g. on Samsung, pointlessly.
> >>>>>
> >>>>> Implement previous feedback.
> >>>>
> >>>> Do you want us to add platform device from another driver which is 
> >>>> probed only on Qualcomm devices (like socinfo from previous discussion) 
> >>>> and get rid of the module init function entirely? As keeping anything in 
> >>>> the module init will get it executed on all platforms.
> >>>
> >>> Instead of asking the same can you read previous discussion? What is
> >>> unclear here:
> >>> https://lore.kernel.org/all/3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org/
> >>> ?
> >>>
> >>>>
> >>>>
> >>>> With this patch version, we have tried to reduce the code execution on 
> >>>> non-Qualcomm devices (also tried the alternative as mentioned in the 
> >>>> cover letter). Adding platform device from another driver as described 
> >>>> above would eliminate it entirely, please let us know if you want us to 
> >>>> do that.
> >>>
> >>> Why do I need to repeat the same as last time?
> >>
> >>
> >> Now I see that you completely ignored previous discussion and sent THE
> >> SAME approach.
> > 
> > Our intention is not to waste reviewers time at all. It is just a
> > misunderstanding on what your comment is about. Let me elaborate further
> > not to defend our approach here but to get a clarity so that we don't
> > end up in the same situation when v4 is posted.
> > 
> > https://lore.kernel.org/all/b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org/ 
> > 
> > You mentioned here
> > 
> > ```
> > To me socinfo feels even better. That way only, really only qcom devices
> > will execute this SMC.
> > ```
> > 
> > We interpreted this comment as `avoid executing this SMC on non qcom
> > devices`. That is exactly what we have done in the current patch. since
> 
> 
> So where did you use socinfo? Point me to the code.
> 

Okay, lets go a bit deep into the socinfo part. we have used
`soc_device_match()` API to detect if the device is qcom (`family =
Snapdragon`). It works. However, when we built both `socinfo` and
`gunyah-wdt` as modules, we do see that `gunyah-wdt` gets probed before
`socinfo` because the driver that registers socinfo as platform device
which is `smem` probe is getting delayed. As you may know `smem` device
gets registered by `OF` core directly before the whole platform devices
are populated. To make sure that any configuration works, we went with
`qcom,smem` based detection. This is mentioned in the cover letter, sure
it is a detail that can easily be lost. Now one might just say go and
fix probe deferral problems. The problem here is that `smem` platform
device creation happens differently to other devices which is leading to
probe deferral. I can enumerate the problem in much detail, if that
interests you.

Please help us understand what is the real concern here? we don't want
to call `of_find_compatible_node()` API on non qcom devices but it is
okay to register drivers. It is still not clear why would non qcom
devices/platform which care about performance load all modules that gets
compiled with ARM64. Needless to say it would load lots of modules and
register many drivers which never gets probed.

We are in this situation because the gunyah overlay does not apply on
upstream device tree [1] , hence we are creating the dynamic platform
device.

We are adding this device to support watchdog (thus collecting ramdumps
and supporting restart) on devices where Gunyah does not support any
other type of watchdog.

[1]
https://lore.kernel.org/all/91002189-9d9e-48a2-8424-c42705fed3f8@quicinc.com/

