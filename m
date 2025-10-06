Return-Path: <linux-kernel+bounces-842634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F7BBD35A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2278F4E5A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C882571CD;
	Mon,  6 Oct 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6h2Ce3Y"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B4231829
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735618; cv=none; b=X/HnC1wzMcxk7OG+EoYuJxMViDsWjjWUiMoBRJqdr6DGkmGjJP4+50VNWwwnIe8Bn7W54O2EauEQgfUpLVIC4HNvlJMpHlkvIPEamNaHXDkLxIZdsY29E4GJ2mR4IhZcMJamvc971O5JdT9OHuK2ce/KL+xRg/Thsefi8gAfoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735618; c=relaxed/simple;
	bh=ZSV4IFjn5S/793vrMHRESbrBLLit6xDjG7yB+mPfIgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuGMUpoxr8OZjWOYkdIP5iLu6/GwlNMyU1Bkfg1PI/7kJZnGYzdp66Xgi+YSc69uRbwwLISUlE3LSjk0G5FuqijUCVoxFPiHJK4X6WrJKg6pW1gr3ROAFzH0Dn0eN+pAUzGswxgUqLZ69QqT5fxoDur1Up1VLn0Ekl+JNeKAV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6h2Ce3Y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3162765f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759735615; x=1760340415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrN7ZozqF/Mn/6ehte6QeL3Mcq45F8goFBLH3ErZr3c=;
        b=L6h2Ce3YzQOk9NgQtoOgWG6xecEqn7Hegdb5iKv4pmUQ1M6fXJM4pVylN6poKH6hf5
         BXcAv4OOJL6I4/jzGpHqZLO6XKVQ5R01FgKINBZwrpFev841t/LAaBSYnzXMVoe62FtA
         pGS+l9o+/1Fmej+6rAWcJ0LPNlyo8hdFCMXp6wzlb3zux0Bs51GIAhA+Rop4clQMjI0B
         ZuOoL6Zc01tRIrjsZUuV93rycq3PAGw2wkhnS5zmxALRBBlTwSTvSaYEP4NLnr//IYXf
         9KwUPaG6O2TBku44Yl4zip61DgotyPu2SrGsIpUupCw4Nuqc6kEX8LdlMqO4YIfKe0BJ
         e7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735615; x=1760340415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrN7ZozqF/Mn/6ehte6QeL3Mcq45F8goFBLH3ErZr3c=;
        b=e3pnXR5ByG36vE6rPfOR4hqbOKWtTmyXR9gqpR6VT2LgmkgJYcDmZgRY/QrpQN+ZoH
         zrOCTbAXeNBSJuPGLueIUxPFFCnWLsTl3qWjXSWmoeJoXlmVaX+qQFQnoZQsU78KdCts
         kXmKsjHHyAPXukNF1HDnLkK9sDRWd1okYlaq22zioVOypNnWuSyq6KL2cFuG9DPWF+Kf
         CCC50AW15PFijW7Rb8oSRHDvB3HcrsSaWpFiJ2knPi12lXvZIXiG/0XLEw52QfyqR2zw
         0aWBwcN6WTqF4ojD9lmnI2yF4wNfG7T5/qNbARTTGQN98WsLKi0tTXvYuSPvOJH85WEL
         KEjw==
X-Forwarded-Encrypted: i=1; AJvYcCUl19ahTk8ogn+ji0upxMDCK6gjc74TDiT2pCJwIx4+kYawmOWMMqmxuWeeEQFa9qYaY6jicb+OEyo6J/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO95yB/OCynuOIx33C+tZHss7c0uIA2DGg1khyE4VNKUdAmz4K
	HZJMuYFYC07e5J+dnVl8Gpzcidh/XCdqClpggXRKMWfag5D8SdadwKRpQaa6Iq+48e1xllvOdF3
	VZGdu
X-Gm-Gg: ASbGncujfwkaCvbNwEzM7CT6BEz5gKJ19OM/+2ucFNFPHm/XN5Wx6YmAKHIWvhe6sVR
	kxDZZnYPccjK8arEizl1kF8nfbfMmh9t45GBaojn5//mD6t8Xnpc2PuX1YWUd3mx0wAM26+HM/R
	pBg2Ep96/1f3ufTUb6SdNkb07zR6zIp8IDEqFOyxuKAXCK1jXGTAZMyilQaGTBrZWWukNQjwd0O
	CDQHEfWZUoDNvpwRm7z1WVzFD5RxIH47iNq9BHHzGFIbvVjbNw1dDO2GG6amPPvNTTIHSu9RNSn
	T6fa98Y5jS66GNsaZkD+UFOSMuNEJCxl+EX2KVeCGMmy2guWb3VQswiILNJrApj2N+HZXS6Nlka
	DUjEbEX5vmfRfbNOH5du42x/py3XJUf9q0EfWqQlIx3fmzcPE8mEA8aIHf1MosmMjHb8=
X-Google-Smtp-Source: AGHT+IG2XBqil6G6TC4mt93U+4Uu572R8R0hylqEdTrhXnnJpQZ4j3fC83aTn/veVeHYslgxQyxt+A==
X-Received: by 2002:a05:6000:1847:b0:425:75b7:4b67 with SMTP id ffacd0b85a97d-42575b74b70mr3419997f8f.58.1759735614851;
        Mon, 06 Oct 2025 00:26:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e960asm19393087f8f.37.2025.10.06.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:26:54 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:26:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8723bs: clean up lines ending with '('
 in rtw_ap.c
Message-ID: <aONvOsbVxGYKZnvD@stanley.mountain>
References: <20251005155920.381334-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005155920.381334-1-trohan2000@gmail.com>

On Sun, Oct 05, 2025 at 11:59:16AM -0400, Rohan Tripathi wrote:
> This patch fixes coding style issues where lines ended with an opening
> parenthesis. These expressions were reformatted so that opening
> parentheses remain on the same line as the statement, with proper
> alignment of continued arguments.
> 
> This is a coding style cleanup only. No functional changes.
> 
> Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
> ---

This needs to be marked as a v2:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

>  drivers/staging/rtl8723bs/core/rtw_ap.c | 250 +++++++++++-------------
>  1 file changed, 109 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 0908f2234f67..93ab0015ca89 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -480,14 +480,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  		/* check if sta supports rx ampdu */
>  		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
>  
> -		phtpriv_sta->rx_ampdu_min_spacing = (
> -			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
> -		) >> 2;
> +		phtpriv_sta->rx_ampdu_min_spacing =
> +		(phtpriv_sta->ht_cap.ampdu_params_info &
> +		 IEEE80211_HT_CAP_AMPDU_DENSITY) >> 2;

No, still not nice.  I think I would go over 80 characters.

	phtpriv_sta->rx_ampdu_min_spacing = (phtpriv_sta->ht_cap.ampdu_params_info &
					     IEEE80211_HT_CAP_AMPDU_DENSITY) >> 2;

Another option would be to do:

	phtpriv_sta->rx_ampdu_min_spacing =
			(phtpriv_sta->ht_cap.ampdu_params_info &
			 IEEE80211_HT_CAP_AMPDU_DENSITY) >> 2;

> @@ -498,15 +497,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  		phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
>  
>  		/* check if sta support s Short GI 20M */
> -		if ((
> -			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
> -		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
> +		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
> +		cpu_to_le16(IEEE80211_HT_CAP_SGI_20))

This needs to be done like so:

		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
		    cpu_to_le16(IEEE80211_HT_CAP_SGI_20))

[tab][tab][space][space][space][space]cpu_to_le16(IEEE80211_HT_CAP_SGI_20))

You get the idea.  Same for the rest of the patchset.

regards,
dan carpenter


