Return-Path: <linux-kernel+bounces-888039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F369C39A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182DF3B6019
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5C3090FD;
	Thu,  6 Nov 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4jEMhK0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aFiqkJ36"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CC308F35
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419039; cv=none; b=CJUGGznfmLIcgvyQNxUnyAgMIPY0Cocett2d2AQw0GyT2rKWNqEA5fFE7aL+nXYm9QYv5GzwxeNWw1K6MCfpWnzT20unsJ9viHHFpni4dnTQC5wdwKvmHXOi2OYCCpHwoNAGaC+NBk9q9yaKaS5dLop3DmqjyEW5m3u3bGfSsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419039; c=relaxed/simple;
	bh=WVvDeGr64D4pcQGgTdXKzhsbEzPiYrr/sAxjT7B5tN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnwuEBnQhYMc8bUTP9pxsqTDQ400v6BwVtzYlm3Nd5jpYMTAon9RmI7Vx+/P7NO4DCSPOhrSWjG8M/utyILDedP9t8f7nYT1EtjpmNKO6MQQsoymZQoWV7MSTUAVuPEphNlX9+G0QB/EYtksQD/E3Nd3bRkSYuwuW3ZLQ8/srLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4jEMhK0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aFiqkJ36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68c3mu2389043
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 08:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=; b=K4jEMhK0ebWBshQy
	pZBFpZDAIk/RKKd33BpRIi6ZgkStwJMuCJtG7GnCss++wpf/ac6bEIu88OVWZdTI
	3IhgyrjFU288bKdeE7S/wE9FyZR8xAEBGCJ6hdXTsyT0DSxC1XOvQGpjOACAcezs
	+EE0o1jQj8u47jlgPERUqaGnoEn8jCuj27tXytJCg0yWx7oFRE1tBpN+xoK9/S9G
	W5wbtReFqiuaqRjiDQU6Q//Dpu5WvEJih3CGa8FXSB+j83gwTgZ2ed4DRRxccCaS
	ikZjxKM//XV4tNqHpXh9dIGKu5fW38LSydKIOCAwqFZVFlYdaW12S47zd1GKIJFs
	aoBLtA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9us7wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:50:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ba433d88288so595165a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762419035; x=1763023835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=;
        b=aFiqkJ36N+7pY/aLdfLsuZcO942DgAljNMvdt9SawAFinvlSJrY10TV/g1PdMT5Su4
         I8oY0feNEc17H+y90mGlxidWF72jw3ubyrn662FEBiTivtL9xfZcFWue4XGOdmJKlheD
         FGV6UZZM7zdRc2ZvwrrfIUwcu545avAJjgCn/cos5t0dmkdEIS3bi3+cAututWzd83Vl
         D2r27CPjwie8iFaEEhNvYeh2yhU02gd47EpKF/Uoqg6W9HzHRDg9+YHo9awcnoNBAfiF
         a/0keWWdL6ai1UubFJCM90wlUkdahFzMH2xFYZvpF1+i/jKzqtPCnBy9WMWyvsIWyT9C
         wfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419035; x=1763023835;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=;
        b=SlboFRVQooxocfVczAnBK6+c/03yqA/04sMCWsa29z0UK/k5AA7dnX0mfAN2lWJPPN
         nV6SlnKT7Kb82XtpOQnZEOZA6DWBI3Bfx68/tnPqss2HPHpMbOsas+36gy0kn/rh4BQO
         i3B2y9MSCpg1Q7pLnn1SMBB2mPWa/wgm9ttABQasqBt9sciGoTX3ypgmySHtHuNX2c+W
         6zIsVGU4xrFoIsETmChTzjsYkHuu3jG000HtXmr/ZzysgQz1xrg6pbtJT+YoU10aUmko
         5sF8QeTrm+mK+LpyrqSOEzmFg8+7eYKliOHuXWGwRVi6ZDquKKcsHNFeJKOSr2GfNrdR
         i+mA==
X-Gm-Message-State: AOJu0YzkYi1iVy9Da+ComeSq2EaSNMqy1JPAjFzFvJORViAf3vbfC98Q
	GVhdKJIsI19nwbJPknGaYHlquAHaJmj/4dqB8BopD7+QUVwo+OqWIEw0MlnxBFSlZs3SSI2v0Iq
	/VxNhz8iOgDSxwIPw4XNbQgO0+oQhwhzNXAawWqy3DT6jgEC2WMSn4aJTeV3ErlCMeMs=
X-Gm-Gg: ASbGncuGhCrl6RvYsj0D7a+GbiXSyUjUNohiRnd76HKSP7W1azgK3vZzo5Q+Ywho6aJ
	truXv5ZZHaA5KbsKUwzM9YviE/Y+QvnXe5J87agBAxlOPSXP7uSUmuqC0kJ+0U6IZYuujIx1aon
	adVW+G3ox+jS0JQpCK4TCiMM7EGMrMhPH/orj+D0yssiFfBFP5BFvxFFZ4M020UaTNMDUnjq6cl
	eSheUIrataGpu4UnLr6njDviecCa4a0HKvU4QNy/+tbx9cNCmNJFz5gMyLwtSv8KtNI4b+zkDIt
	jB4PCKrTDUr89PIM37bHOnl89ZyD4C80SXb/tis1GRPt0IUEufLtx1zKP+DjJVhxf02IDxi+jp8
	uQzVN+sYeT2NbK0FdcymwwlM5HKV57RPy1jd17H955l626uf5mE60FXvpSwrsKtfhITjvEHZY
X-Received: by 2002:a05:6a20:2589:b0:340:c6cd:545b with SMTP id adf61e73a8af0-34f8601d2dbmr8310898637.44.1762419035256;
        Thu, 06 Nov 2025 00:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9WA8Q9OBOvy+W03mWMWpuJqtsAQ6hbgML/ovXeLVnmjdSHkr68hNbqJUMCMAf7GNeaTowtg==
X-Received: by 2002:a05:6a20:2589:b0:340:c6cd:545b with SMTP id adf61e73a8af0-34f8601d2dbmr8310866637.44.1762419034647;
        Thu, 06 Nov 2025 00:50:34 -0800 (PST)
Received: from [10.133.33.172] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed21desm1841412a12.11.2025.11.06.00.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:50:34 -0800 (PST)
Message-ID: <2cc29c2e-a066-4c49-99dd-872cc2f5f326@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 16:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c615c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=W4cqpq0YkI6qXs7jkP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vQpZndzxaSd7CNpKhVp5DN_8SkWfmcZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3MCBTYWx0ZWRfXy0thPKSbNfzz
 COoHs/i5d/UQdUFe4l6tKFMHuGp8yRnnL17+46y9anF4qK9ZDeyLIV+lxNjCOMJKFaoGkIDqsBN
 C705DB9Y7RGoNfNdYxS1uo0+5dDw6y8Y6LqOkCOIpadeVYWJufy1nf29hFfiqmdMgc11zUJ6ey/
 6bo6hkW7HZnt0DXcyNNw72NH90Rtf7gMRhELjflAWVWwye888yrr0FtN10Z2LGtbLX1gODC0Yq2
 /X101mhQqFTuW6oFhsKPkeAEwS6u7GOCASridksqEM3rCbL83z82/5RN5KZcUGJHXAGmGvYxRJV
 6+gOw46bFZj0mdW7bsJBb852dG6BbetH76sQqKDJdWHM/R2qzOFibOFETS24wHqD8Ue8CkUcw8g
 JzKWm04jhWBTOyboTP2D+0HMjnu+vg==
X-Proofpoint-GUID: vQpZndzxaSd7CNpKhVp5DN_8SkWfmcZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060070



On 11/6/2025 1:22 AM, Yu Zhang(Yuriy) wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>  >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>      1 - start CFR capture
> bw: CFR capture bandwidth
>      0 - 20MHZ
>      1 - 40MHZ
>      2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>      0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo “<mac address> <val> <periodicity>”
>  > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>      1 – stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> 
> ---
> Changes in v3:
>  - Update related comments. 
> Changes in v2:
>  - Update related comments. 
> ---
> 
> Venkateswara Naralasetty (6):
>   wifi: ath11k: Add initialization and deinitialization sequence for CFR
>     module
>   wifi: ath11k: Register debugfs for CFR configuration
>   wifi: ath11k: Add support unassociated client CFR
>   wifi: ath11k: Register relayfs entries for CFR dump
>   wifi: ath11k: Register DBR event handler for CFR data
>   wifi: ath11k: Register handler for CFR capture event
> 
>  drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
>  drivers/net/wireless/ath/ath11k/Makefile      |    1 +
>  drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
>  drivers/net/wireless/ath/ath11k/core.c        |   41 +-
>  drivers/net/wireless/ath/ath11k/core.h        |   19 +-
>  drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
>  drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
>  drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
>  drivers/net/wireless/ath/ath11k/debugfs_sta.c |  143 ++-
>  drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
>  drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
>  drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
>  drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
>  drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
>  15 files changed, 1833 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 
> 
> base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


