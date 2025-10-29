Return-Path: <linux-kernel+bounces-875165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C1C185B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDF91C64658
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971512F5A07;
	Wed, 29 Oct 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoAUlbno";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EYW5lZIc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB0548EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717029; cv=none; b=DcA5wPxMlyy9kmO6jXEoevvo7cgc/0IkL1n5paQiAEAPYbXdXrQ7ZOGPlSlJz7fsZJRzt/CQS8aMb1BmJt3z8l5Qc8q/nlRS4PHf6ra7yS3SX80sdNfNXcykPRCK1B+4ME6O6UsNEvNgPCxYXuIlY4kmqP1Mq8EmcoMNADi+eeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717029; c=relaxed/simple;
	bh=XYZA6dr1okn2VPnrrxRm+D/fdgcyYPasXfIVwZAT9Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1dc/7ls/M52Wfozrzu4ZG43HfXHPDzRkTi7rtXGuRA5FtJCWseLAWeGrOYce2UKS1bZaR8PFMI0KB3GorNP4fl9L9wVVcb0RUPtlHb0LxkV1oUMGUbPVtfMtsddXCIaicFLcw7CziwpkizntBZbH1qF5G4et6lTdu7Ns95aEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoAUlbno; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EYW5lZIc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v0kJ3664600
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=; b=LoAUlbno80vuob69
	4XmkeXz5/TSlanqqv8vvBmc6XesLnrOD2VotMcYOzHhYp5Q2eba3ssaoMZ034cBz
	5vtdZ6mdB2a+9QLuERnqChFlaP+Z8ZjOB4YxJug7yYPPPBl6mXNtiAguzQ1/lC3i
	uk8suQ8tHLMCCJECHt28zYFhWTGYpHHWWBhrcCvpujnQ9q88a6RLzrfLsYxmwlLb
	HSybs3Idlak16TVxaXEMeywc9lT77IKFL9lKnLdDZIB09MR/cD6ZnA+1XN/B45zD
	zfAYCckvMuil/Bjus0ZCAa3FvA+3Tsnd8Zd/zQ1+M8OE8+1NayAOIPaZPjfvBEE7
	TzkvFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3sb4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:50:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-272b7bdf41fso83808555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761717026; x=1762321826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=;
        b=EYW5lZIcY7fu04UGETRJ1NesStWCQLQA+iEPDcDI61SzKz3MJk2hl6x5oS93QjRNpC
         OgMTan0PkDNIHW6I8sIYvgZdKWqLz3Z9nlk7/V17qpjyHsZ7gdggajjb6vFL+ppnMsfR
         o6MVAalXWw05NcfkfREe6Dx9Kkq53JtSlrYsk06jBTuCcqBr9XkSX6QmbkcTku8NyyFz
         8omHbLkUdAh/RbIhhRcdWmMZS9hClEFi09zJKS1YfqHGsECVvpTkLKEmlY0SrnqWkutC
         vjPQmFHiM4sjqxsxbsLZN6BFpyoobpeegTPixUiCbm7fmtsArmk9R/b2s+d7nRJIPZv0
         Bz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761717026; x=1762321826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmAbIa2HLXGYbY6ZAbrAI3G+RXNbdEwalIvBalCKji4=;
        b=o8rVB6YSh4AF7bB1532+V2hKddYJ7+3TPWUG2mYjFJ0QUbysQEVyg15LTiCMkr748L
         +5yjJzSnVI2QUFRJC64MBB8LxeQECeqnEDIW8jOktRL05u8irQZ4/f/NwngZ9QgFSMiH
         9a4JjD6JrmMOOpOSjLfsO5LAPujGU9by+mDYnjTJgmAi0Z8ja945rjZhq9hR75VOBhBP
         QAZxrfAqR39v5RjENRNf4p/niIn/Ty9tXRo7OoFVKIvuPcqqBXDKUU+Rg1WYXsmdheYs
         O8weNkvZyk2SzZigk6uLMLzd6mpNxWUmDEX8HI5i9nhr7iKmPPLL4qgtsZRZhl446GIc
         cdrw==
X-Forwarded-Encrypted: i=1; AJvYcCXuz4rLM+ZJ8bmzEGMB7AC2IkGZd2pIGHl8JIFcMSiMIg+C4JQJKKRdO8moULXnZaUmbnoqSA9IHe9v2ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzIghpfZrhTuRPDiS7kLSgkvACBD860VBgHci1BUgsrKCr+4p
	BcobYbyxBFWHaRl6WmxdUwhsC3quq8qevxp/y4YCpRg41c2+N5u9Z6+mkp+EJNqmH8xbYPLHI2+
	BBEP9WybU+jN0+1pqNVWFGw4s94Vx4G1ADRsZUNCBzaZoRs7TMv/HH63h23Dn4gIb2pM=
X-Gm-Gg: ASbGncsLK+4ZBb8ui0XdjCmpz0XeZYlB4/hw3//IZc3pHNqLTWH+RS98Xc+QuSANGKS
	shB9u7kQ76V639e0ArtwyU68qFX6NP6abzravCM3DW34kIEKuUktX+D5QoGz0vUe91/xbQBMdgk
	SYV1T/9CuPozg+RKDQPXUM1kKMa/4tJ6PfFvUoTIvYFYiket/O4URPokaBs6NMjoAOAH8/Mvb13
	FqoAKwAZsCk42PMP1yZpIQ1Exdq0GSgVLYVqHatCaKoA6XdovfrAdNcx+BvDDypx63ovce03Gu0
	OszLnbNcbmc7NeJyQU56ssvrNptvRBdo4YsmZhNiLKO7lalz8L6dSvkZ94krc/gXhO+YkUshiR9
	Alhkdcz1eVKMqhr/rRIecs5SNgMkfdnfU/eMy3b69cQ059FoIuB2JKHNe8jd+
X-Received: by 2002:a17:902:e5ce:b0:290:c3ad:8432 with SMTP id d9443c01a7336-294deef9a95mr22435915ad.46.1761717026489;
        Tue, 28 Oct 2025 22:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3oGqY6JtnY6s9TE+mNpoQ7oW8tW3Vrva1KS/4zSSUMofam04Zi+J5i3WgpjvLhwaCJSaxcA==
X-Received: by 2002:a17:902:e5ce:b0:290:c3ad:8432 with SMTP id d9443c01a7336-294deef9a95mr22435595ad.46.1761717026005;
        Tue, 28 Oct 2025 22:50:26 -0700 (PDT)
Received: from [10.133.33.233] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm137576335ad.44.2025.10.28.22.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 22:50:25 -0700 (PDT)
Message-ID: <7d389aa2-5e5d-4b0c-8603-60bbcbce7015@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 13:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station
 power save configuration"
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ross Brown <true.robot.ross@gmail.com>
References: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: b63Xzk0oPbgnIodYJXPfA8bzMSPEdCba
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=6901ab23 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=dJ2fJ0zB95bh057hNQsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0MSBTYWx0ZWRfX4kvY9j3yrrmA
 GxtcbTREWrO572CF1oIHWU16zTzOA8H2g7+93Tj9IebpBcTx8tJ51q7tBIWVr6Wc1DCz4Cbl1We
 WAePfmFe+4ut99hliJsJ0JxC9DZc+ILDALcUQft4cgkzzAHo02bJgcikHZ2rNUJqm6mRFT8W+Sv
 KURwRbGiGVV2dhB/9rmCxTi9mZpebpwavRQ2WywpK7QtoSbRSm66OEOOhkkOF9YlWpLBS5cM8OA
 rh/4aX3Xw6y/b5YjBkDLhcI5+82APfVe9PW3IcyZT8wmforZhG9jySUAJHBjJGPJ2cwlTSfj+Sj
 q03GhYc5erYsaxZIv/BbCy1sdR9iGPJmVysz4gOPMHA0smHpVbCrOPJQF5IaSwNYBbF1VfrzCjE
 RFkLcYV5wOx6gGlttYyyzI4jJrC6kA==
X-Proofpoint-GUID: b63Xzk0oPbgnIodYJXPfA8bzMSPEdCba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290041



On 10/28/2025 2:07 PM, Miaoqing Pan wrote:
> This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.
> 
> In [1], Ross Brown reports poor performance of WCN7850 after enabling
> power save. Temporarily revert the fix; it will be re-enabled once
> the issue is resolved.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: 4b66d18918f8 ("wifi: ath12k: Fix missing station power save configuration")
> Reported-by: Ross Brown <true.robot.ross@gmail.com>
> Closes: https://lore.kernel.org/all/CAMn66qZENLhDOcVJuwUZ3ir89PVtVnQRq9DkV5xjJn1p6BKB9w@mail.gmail.com/ # [1]
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++--------------
>  1 file changed, 55 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index eacab798630a..db351c922018 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4064,68 +4064,12 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
>  	return ret;
>  }
>  
> -static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
> -{
> -	struct ath12k *ar = arvif->ar;
> -	struct ieee80211_vif *vif = arvif->ahvif->vif;
> -	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
> -	enum wmi_sta_powersave_param param;
> -	struct ieee80211_bss_conf *info;
> -	enum wmi_sta_ps_mode psmode;
> -	int ret;
> -	int timeout;
> -	bool enable_ps;
> -
> -	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> -
> -	if (vif->type != NL80211_IFTYPE_STATION)
> -		return;
> -
> -	enable_ps = arvif->ahvif->ps;
> -	if (enable_ps) {
> -		psmode = WMI_STA_PS_MODE_ENABLED;
> -		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
> -
> -		timeout = conf->dynamic_ps_timeout;
> -		if (timeout == 0) {
> -			info = ath12k_mac_get_link_bss_conf(arvif);
> -			if (!info) {
> -				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> -					    vif->addr, arvif->link_id);
> -				return;
> -			}
> -
> -			/* firmware doesn't like 0 */
> -			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
> -		}
> -
> -		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
> -						  timeout);
> -		if (ret) {
> -			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
> -				    arvif->vdev_id, ret);
> -			return;
> -		}
> -	} else {
> -		psmode = WMI_STA_PS_MODE_DISABLED;
> -	}
> -
> -	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> -		   arvif->vdev_id, psmode ? "enable" : "disable");
> -
> -	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> -	if (ret)
> -		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> -			    psmode, arvif->vdev_id, ret);
> -}
> -
>  static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  					  struct ieee80211_vif *vif,
>  					  u64 changed)
>  {
>  	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>  	unsigned long links = ahvif->links_map;
> -	struct ieee80211_vif_cfg *vif_cfg;
>  	struct ieee80211_bss_conf *info;
>  	struct ath12k_link_vif *arvif;
>  	struct ieee80211_sta *sta;
> @@ -4189,24 +4133,61 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
>  			}
>  		}
>  	}
> +}
>  
> -	if (changed & BSS_CHANGED_PS) {
> -		links = ahvif->links_map;
> -		vif_cfg = &vif->cfg;
> +static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	struct ieee80211_vif *vif = arvif->ahvif->vif;
> +	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
> +	enum wmi_sta_powersave_param param;
> +	struct ieee80211_bss_conf *info;
> +	enum wmi_sta_ps_mode psmode;
> +	int ret;
> +	int timeout;
> +	bool enable_ps;
>  
> -		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
> -			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> -			if (!arvif || !arvif->ar)
> -				continue;
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>  
> -			ar = arvif->ar;
> +	if (vif->type != NL80211_IFTYPE_STATION)
> +		return;
> +
> +	enable_ps = arvif->ahvif->ps;
> +	if (enable_ps) {
> +		psmode = WMI_STA_PS_MODE_ENABLED;
> +		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
>  
> -			if (ar->ab->hw_params->supports_sta_ps) {
> -				ahvif->ps = vif_cfg->ps;
> -				ath12k_mac_vif_setup_ps(arvif);
> +		timeout = conf->dynamic_ps_timeout;
> +		if (timeout == 0) {
> +			info = ath12k_mac_get_link_bss_conf(arvif);
> +			if (!info) {
> +				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
> +					    vif->addr, arvif->link_id);
> +				return;
>  			}
> +
> +			/* firmware doesn't like 0 */
> +			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
>  		}
> +
> +		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
> +						  timeout);
> +		if (ret) {
> +			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
> +				    arvif->vdev_id, ret);
> +			return;
> +		}
> +	} else {
> +		psmode = WMI_STA_PS_MODE_DISABLED;
>  	}
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
> +		   arvif->vdev_id, psmode ? "enable" : "disable");
> +
> +	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
> +	if (ret)
> +		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
> +			    psmode, arvif->vdev_id, ret);
>  }
>  
>  static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
> @@ -4228,6 +4209,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  {
>  	struct ath12k_vif *ahvif = arvif->ahvif;
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
> +	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
>  	struct cfg80211_chan_def def;
>  	u32 param_id, param_value;
>  	enum nl80211_band band;
> @@ -4514,6 +4496,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>  	}
>  
>  	ath12k_mac_fils_discovery(arvif, info);
> +
> +	if (changed & BSS_CHANGED_PS &&
> +	    ar->ab->hw_params->supports_sta_ps) {
> +		ahvif->ps = vif_cfg->ps;
> +		ath12k_mac_vif_setup_ps(arvif);
> +	}
>  }
>  
>  static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,
> 
> base-commit: 2469bb6a6af944755a7d7daf66be90f3b8decbf9

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


