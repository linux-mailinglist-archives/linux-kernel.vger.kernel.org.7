Return-Path: <linux-kernel+bounces-735550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CAB090DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0B5A284F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946E2F9491;
	Thu, 17 Jul 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXmbstGw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB782D46AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767175; cv=none; b=RNJH0mImKUY4S/qTe4daGs/XG4tqy9Q/3irj1CPHgIBzIR/WHjMDd8W+pc3yFxqoFWkQF3kxbc4JolRzyfjIR0/MhYiQMNUaBOjjVaChEOfofI9np0tmAu8iEsKgr1OLj3w1LeeQuZLbP+bBFvt0WUl4lcXVK30J966n16Wsoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767175; c=relaxed/simple;
	bh=ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doVxZ3LXP2ajzLqLcLpFzp3hwo5dSWiU7x24i9WyvLBqgnmKZIkNpvwncorrA5k0yW9ARmWlPZ825bMF4oWFUX8uYUzuNb8QUswl9LihK5ByoW5t2jyEpHpNxhy+vweBI8Gf0KfsEeIygWgRTzTAsK/8siW+NyOUO4z7fPEz4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kXmbstGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HD7Hgi022149
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=; b=kXmbstGwL9feq4+i
	Y815sxyr3zgPIC7i+badJKZe3fJ9NVxNgppqa91Bk3QiyKivPw9NOauv7OpJJgYv
	ToTl0BEF50kVy9BQepNVgGtEMsAPMpjH9V1jm1I8kTNUO7DWDVClWo0dVCCwJrA0
	mLUAeSgsiUEqUmsCfTOSMUviM30AIHJhpmbJtlMryKHhDbUXpbQ77a3RG4rXxRnu
	mJ5Duq6BA6kJbnjBgmEmKqhXZQeUgQtFUziSwFESyUH8WffF3jEwCB2g0xT6yFTu
	UkwCWs8KX6j1OEz4ydoDjJSu76Ejwb3p3oMKGuwZlhkAkxLDwXrCZtAW1MJWyNrm
	lXNW6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8g3ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:46:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74b185fba41so1055627b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767172; x=1753371972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=;
        b=m+lt7tZMIfHS6C/uENIm8X9ol1QBcv7vJPFBw2pCadK2KB+lvz0i6aWksGGwb6vjX2
         zZPFxpfAIefRSjBnRY3I0LCgI3GGVdlm+lOEZ4AnxaPZe+3zDwk+//r0zfX2yKt6PXWv
         F4a43vPzUejkjp6RWyaCSBES4t/aiE1a+OkLjsZLN/csJJ2y+90Os006gnHercdq/YZO
         Cck0ptSwSxDb2eAjkVYtM8TZzBJh/jrjTwURTju8HuzrW5M0E22IZCEHrtDXunbfO13+
         E1Cna2EyC/C4rg9CxnmaO8D2OpHhAgK3jQeWWmf9VSbGEI8QtJYSJVzGT80nqbIa/CB2
         BDmA==
X-Forwarded-Encrypted: i=1; AJvYcCX39VN+6xdODNgdp1DaBwwlBndsVocL8KvMK5wg6ApRuDPz/kNBgIoe+whHVSHSoyqVxDTFdVNOVlP7cP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgO3SRos+QPQlXpK9s7FTmni3v5mZH4pWRuV2w9OnjPbk31qI
	B+2kY91oafOoLADwrhRD/kTJ4lLmvCL5ru3ZLUCQ3jdiwnqJsyh/qKsupPMBqiTPFWfUoEvBWH9
	Mh8f2ONew2XLuuAhK1GHTnvbDErdDbtrvcCSAK1QsAMJW65pIOoIRxE64bfLftXCgaQg=
X-Gm-Gg: ASbGncvlreXjCuECkPNTdrc+gKiQileUu+2GMvu4ZsHThueGmQe4/XB3HBLyPjdXUPE
	hKEor5TNnNNJt40nlQWxGXdjSa5R1YJ+w5RzcrgM0bg0JS526+NYW5BSMFM18SniTVPL0ZNmkjH
	D2v2wu6AlX0WHmFmMYmyFDm4U3sUctdrXGblxHmkue4/D7DK9WyaeOSPZgMsock0TpqOOQJQF2x
	iVpY6RizU89d7gcp8Mkt369cTuTPKEwcTD3FoMU8j84WW4oLuXP8tQUxivLkAMMxD+IlGMyr8tR
	J5/d1r4uzyLle/n0i9+FIAYk3TVDJoWQLLAliOmX/HHTzcIXfDkQI7o3U9/RfifI6ORemh+c/TL
	EsjdHNj5QoK0x+jJboSw=
X-Received: by 2002:a05:6a00:1704:b0:748:ef04:99d with SMTP id d2e1a72fcca58-756ea1dd3abmr10368813b3a.14.1752767171500;
        Thu, 17 Jul 2025 08:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuMgT04W8H7FqBViOukrixeUUnPxkr/5CXJJMRmftkb7wIp9ibVR7/CoJg49nYXw6zIDgzbQ==
X-Received: by 2002:a05:6a00:1704:b0:748:ef04:99d with SMTP id d2e1a72fcca58-756ea1dd3abmr10368772b3a.14.1752767170903;
        Thu, 17 Jul 2025 08:46:10 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eba428161sm16444906b3a.42.2025.07.17.08.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:46:10 -0700 (PDT)
Message-ID: <a5e85969-1dc9-4d6b-be2e-ac2338d38d98@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 08:46:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
To: Remi Pommarel <repk@triplefau.lt>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de> <Z_jpq26P99qzPP1c@pilgrim>
 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
 <aHj4zS_3uhDRhzDn@pilgrim>
 <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
 <aHkHOC6DYBXtnE5e@pilgrim>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aHkHOC6DYBXtnE5e@pilgrim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOSBTYWx0ZWRfX6PDP3lcD7dWq
 rLv48ptMR9mKyD+aqOm5/YNUGH1a2+50WzK8uQhaSSj8awNcAWHcpoVLlFh9GthwLbdgrob9Ajh
 ZXuXp+xo95PMrmDU99XgyxyQUePKjiBUcQGalZ93ct8jQjXaRTnfegmxdaOzO49KSP8Lgra8LfC
 +zdWrUQsJZR1Y8rTAkkTXqYoBtQLrUkdlw0n2se0iE+PUa4jON7vgYz9l1VB3+Oi8FIyrBfotMN
 YYVP0r2pr/GPcz8IFukkvsExw88i7QIF0/416QnCKB47OMTEvGPgHGDY8ddzopgBNT+vkXYHJ1D
 KrkmKJoTt58PYy2gMrEOSotl6+HzmpL+RaYdkNYBSEA/8qzaXGQTE/AWjnHvU4JJcJeoV7SWnLq
 c3JQ7yeMix4ZBpjASYG4/SfxdlmiR4TkjLvuaKvx2Y/Dz+grGanAl7dTaf3PV5R78nHCAtdR
X-Proofpoint-ORIG-GUID: QPoV_MZdyZEG0PSEcoIoPh8fJGYIyckW
X-Proofpoint-GUID: QPoV_MZdyZEG0PSEcoIoPh8fJGYIyckW
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68791ac4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MOVf-BS0YNWMpZGKuf0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=952 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170139

On 7/17/2025 7:22 AM, Remi Pommarel wrote:
> For the record, if I am not mistaken, ath12k driver does not seem to
> support 802.11 encaps HW offloading mainline yet, I do seem to have some
> vendor patches to support it though.

Upstreaming this functionality is in the internal pipeline but won't make the
v6.17 merge window.

