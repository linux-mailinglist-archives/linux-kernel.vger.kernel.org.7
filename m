Return-Path: <linux-kernel+bounces-743417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C069B0FE68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770841C27B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C419004A;
	Thu, 24 Jul 2025 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbGqk9l7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E418786A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321312; cv=none; b=sgLjkL+SlD48wTMA566cNsoxxcbTRI5Dn3rujp7h63vN1BY5H+sM3j3flj1Cp+CUMDtk5cPwgDcImJDJNwvIIKvitFlI4r7GQAIrndZZNy4sC9W0C68UkKR1EZb9WbgT/GAn79RbEm6L37hueYPzQPKgAfcgJ81eeX5SaTD/faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321312; c=relaxed/simple;
	bh=tgMrZhqcs6LlFm9tZEm1ilzQvjFnP85Koztg8DHCrg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZevw7gUR1/zY6VTXb9EDUpxvBbc7/T57mBJkPeu7lI8VwJ2GRLCmfjx/d+FxV4YfoyxdKZgxDuX3dZ4Jz+WXMLvjYEqSn5vtoD5pYDTnUJ+o4Seq+wuSxO7+3OWiOczdDwQPiT8aDlsA55TkJYyFulGkn/EUqiJaHEXc32NBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbGqk9l7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXToe018072
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3l5vVTkH19Z282OOXYT7AVaSkeC2Vgr99aP1Mh72ErA=; b=AbGqk9l7JyqEvtLG
	xPu315+pSjIiJznXNvDVSuZN5drzlf/fsnaMZKwwQcpqSlz/tMOHSd0x1sFIYzOf
	kgkL0bdLc8gR1JYnazgzgNQvlXd0muA72uIvbPBiDJqmt0grTKMCunivB16vpnMb
	soTCx99XCWCotjSpe04Qojqt5pUIX/mlPrkmF7rIJR4ZZUyb0vFJ3K5+7/SZHacR
	Xfk9sT1AQQ5d1WuAu33TSwpaRrznLm3yK1tfkUMmrqoF5UbPwFdaARN4fHrXUPeO
	sgBo8ed6dK7+bpyGj3F1Xu33Ey+Vca5lyzl8Dvfbg+H/F576z7CiiBgsYTme02Aw
	9PGGSQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6s6rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:41:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b34fa832869so1215239a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753321306; x=1753926106;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l5vVTkH19Z282OOXYT7AVaSkeC2Vgr99aP1Mh72ErA=;
        b=spQ7nxmLrZITyBbZ8dAxlFPlHmbUtP3a7I0Z3U5LEvhdG3wVmyA7BBndqNL3jtEd6a
         3jVmoinLtptpt2wLbZcn0q451n+XfWcGOktEUb8kBu2/1OGmJceJhFfXwsb+pSZXztfI
         1D8ope61s6wh8IkSM8wwJwVSdsQ92czDbiYfLrgnbadH0q3Rql2uQTWlL0hRgW8e/Gro
         zTsB/hbGMCLcE6KwopYf9Ok0TsK9ucRJccudqjXZ3CRiKfS4CPou6D/Fl79hA/gmp5m2
         W4pUWxXer6kUmj5bRotD9AqczGuegy/zhg42wj2uNley00UgpOC0aKWvSRrdzYwsfWnc
         Sbbg==
X-Forwarded-Encrypted: i=1; AJvYcCV7m2J4n1yOtnMIHMcIAqco3nXk5e1Kv10+EXFEFSNKLgGgf1sdVjs+TpXNHrrAE/bcEW0D0ti7htOzkbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TgQgUFxs5xVlO73VMTbOMWNFlWXyLsI1mxuml2G40DEB8wXv
	B6zXizLltuqChb/zhXsGurQTUqac0HLrA/wa1lR8qcvckMrq6B+WxnKRXQqn5g/xfIaAJrPLp1w
	FKLErKOT0mVZfKQJivBAhr/uZcJsdE0FowaV2bbkdyeel8sYXo5nQslcD/bz2yOmG73M=
X-Gm-Gg: ASbGnctXg+SYyE66yBRKnUcViEdPDGI2R9OzPizuFjMmm87+LRoHlimBr5ge1d79IRx
	RPomjy8zTnRYY43wFoMlOiy3Di9x5hp1Dc7pIwzm/9gsJjfqh1mZabSda+8lMoBjt2ADoHiAQQp
	0HU/D9xm8Q0KoHLVldxbuQWGbExZ2SNP0JCKCj+hJtJOyrjzuI+8ZQGUohqKrM/lmAL/Fom8KcY
	SHiGaxQ0p5qR8MuCSqm6yn3Mo7McnnXNRkZ3i0xqmMvTZO+BFMz/HNMUK/aUqQ2UDGV2ZmAs6Js
	iPnFGh93IPzfUjPfeHAkXgjHXVNlGfPogODa61aIByE71t+/LishHmy/yRVDBFkaI6offwnIGEg
	CS0eOT4QezUq2oAIQswa37VV4XUBQMrTJ
X-Received: by 2002:a05:6a21:7182:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-23d5b6d0d5bmr271125637.21.1753321306547;
        Wed, 23 Jul 2025 18:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfD+HGAkMnjB5I3dCEWR4gDruV20/UEZdN21kQ2WAho8Z9MdvKFzZRB08ebGbrhWrhU3FYaQ==
X-Received: by 2002:a05:6a21:7182:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-23d5b6d0d5bmr271093637.21.1753321306071;
        Wed, 23 Jul 2025 18:41:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761d52fe8cbsm189010b3a.111.2025.07.23.18.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 18:41:45 -0700 (PDT)
Message-ID: <1d5f27a4-5407-4cf2-bd52-1ee75a4050ef@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 18:41:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] wifi: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20250723201741.2908456-1-helgaas@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250723201741.2908456-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68818f5b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1XWaLZrsAAAA:8 a=NRXtL9kN6jlbBn24eUgA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: g1YHug1TMoYfj6NhChz-cLgqdQroy4uw
X-Proofpoint-GUID: g1YHug1TMoYfj6NhChz-cLgqdQroy4uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAwOCBTYWx0ZWRfXyjFCZyCRpbKG
 A+iZgDHcpXwFb+sK9ArmoH60T2CGXQKLfsbBLt03wkEE9CiTcEGmJy1XWhkWIXMB0VjVPxLm1qc
 +RXS7uoJJFM/yH1KGJq+9aF3tebv0lmRfuzwYxsA6pHd84j5DA7jbgUS8VgxIXTaiZ9fMMOKUD1
 rfAguDvhSKi3DXbpEu4hYUMjzizr7gBcQgWU64v2cRUL0Prvt2u+AAUkJPzRGN6PK0by1skhF3E
 9HW5kwd0uvT13j42oD4DZMbNz93EdLSvHu6q7Vk7Py98jrvJhfEZFackCJZY/cV2R7g0MMKa53D
 QYMXcND1c4r2glgfINgIrt/pkcUZVEeyAmM01hEFi/kJcHYrQQzBvZwTFoJ457iOCWM8ci2gVwI
 p2VdOlzoAkpj1cg1yMjXESNlGh8nJJF/52x46H0aG2t5pZnHZ4PAkfVX3wi7tx5cfVdad8wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240008

On 7/23/2025 1:17 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments and error messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/wireless/ath/ath10k/hw.h          |  8 +++----
>  drivers/net/wireless/ath/ath5k/reg.h          |  2 +-
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  6 ++---
>  .../broadcom/brcm80211/brcmfmac/common.c      |  4 ++--
>  .../broadcom/brcm80211/brcmfmac/common.h      |  4 ++--
>  .../broadcom/brcm80211/brcmfmac/core.h        |  2 +-
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  4 ++--
>  .../net/wireless/intel/iwlegacy/commands.h    |  2 +-
>  .../intel/iwlwifi/fw/api/time-event.h         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  4 ++--
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 ++---
>  drivers/net/wireless/intersil/p54/p54spi.c    |  4 ++--
>  drivers/net/wireless/marvell/libertas/cfg.c   |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  4 ++--
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
>  .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  4 ++--
>  .../net/wireless/ralink/rt2x00/rt2x00queue.c  |  2 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8192se/rf.c   |  2 +-
>  .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 22 +++++++++----------
>  drivers/net/wireless/ti/wl1251/reg.h          |  6 ++---
>  drivers/net/wireless/ti/wl12xx/reg.h          |  6 ++---
>  drivers/net/wireless/zydas/zd1211rw/zd_usb.c  |  2 +-
>  25 files changed, 55 insertions(+), 55 deletions(-)

At a minimum it seems that this should go through wireless-next instead of
net-next.

Even better would be to split out the patches that have dedicated subordinate
maintainer trees (such as ath.git for the ath5k and ath10k changes) unless
Johannes wants to take this entire set.

/jeff

