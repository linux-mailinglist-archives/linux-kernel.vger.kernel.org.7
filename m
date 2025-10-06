Return-Path: <linux-kernel+bounces-842636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC03BBD366
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23E3834908C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4C256C71;
	Mon,  6 Oct 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nvm0gjB8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8FB189B80
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735768; cv=none; b=r2hgG3dxAQkFa0cmp0duGt4MmSKZMFTH54gMBjdSZAVVzugRrm4t+sy2uQ1Hi5mk4rcU0rgnItNoyBYSelhjkpbcJxWf6tggsvYYLtBpG34YODj9dQL9YEAz7lyvRfLX16MoIoOV+3j0WLkfGBlz1WUGKthGnU1LTx56rAAIcs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735768; c=relaxed/simple;
	bh=pcBAm+wm8c6AgGBg52xkIT6OpiZn0ht/Z5hua5dnd4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/k7MFhRaKdjLMp+kA46CHtcwT600gu6ge8+y1vaN7tFTDc21TleF9+uTmJg20T44h/bILCH3YUahQ8nnPXC7RaCF7p6Nv95DSMFF7Y/o6rWeLeWkLCAOv53OWeDwLcaru9HPBT2PW9qmBmEbCvru1GIPomtkPUGulRa4VPLQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nvm0gjB8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso29110545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759735765; x=1760340565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sghbtbNFIONQugpyNGOw93WuDTAMae0oqKLTraeLW4=;
        b=Nvm0gjB8nd/uEKNdzbd8d/dMWK5g+enjmRmfMj2jMO4ocfdpKsHOdCFvRviIm8FpIy
         x4N+f16xI9LgVRMJRA9OHVm35htmn5qgtyJdZfdL7QL0ImxObNZvck7ppqQ6eDW9s5k2
         ohsm24jCrUGl6QsYIAWo1h9PrOpNROvzqA76XyGrE+rD+7M1P3qqCYVhpWkCl1C2O/Y6
         JVWfvwqlMJz4SfWeDB4vNE8ycPH7HsO8Y65QakD3HuLJF24xAhKj+97wU7oB1nZ21h3x
         s/qvvBSpldzeDIFzZIfwjq0TXH59EQdCFQZ5jJQp9WtWmIh+0d3EbVCz9HZeH6YaCu/H
         ZTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735765; x=1760340565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sghbtbNFIONQugpyNGOw93WuDTAMae0oqKLTraeLW4=;
        b=ammsMjDyalRU2K8MjGDSK4Cl+rtjTV6a/oyTcQXTXa9DABLSCqFQaMoZKyWe97sEOI
         wAkoQh0/IXrbWUqik+e+6/RhsVScCPRnvK21PlzPYyfZ5hi/ZtOosfTrRgNpIx6IQdXI
         y3OKJJEze5+ER9rjBVqW/inUurlUYaHViyWy69TIoiiLqQn9aYewhtgDyRD8we8i8TtP
         tVePjVJ0VmfastKLTNr3gsT4qEYrmNbR/JSlPswgbO6xE6DC37ik70W3LdsBn0nt00Uq
         +/t/FGxWuxBmU10EF0P0HEGMLFY5nQJAIeEtzIclkmtC+xt0s6CB8NPMyDzO0J87qhvV
         D8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJsTz1iUYY7ooKvWYxj4rkGc0B9D9zAiX1mr1h2i3WWV4DQmn//Iit4irRhBraBWEhFS/mgdxnyO4YQiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGBJjSKYBiTzNL/XHPNrzqNSQL8tMBrkO17W0tApuK6Dd9IoI
	juCF9rHEJp7EKtA3Cj4H4vneNxe5T80sIiEra150BG6CzAJmMlc2nyKy/d7BXamfFO4=
X-Gm-Gg: ASbGncvmBHTMSux7fnPShNVZvbxOVIycuHW8ipeZdgBDV9e+5TV2PhsBpWhb3TJy/wa
	hsVBroow+tt/bFIh9loVMtjj8GL3RGeHvhOqIMTnZv01O5oEr32OYjI8Wjcitq6r+szii/AX1lu
	tncuesQqIZx1WKPtj0UjkBGXdEmQFZeKu6lbLMvgsih/QgJzYvLPNrO9FBIoCWea7GqprTeA5zo
	81uWZt1duYxuWS3KJvWvOa25tHf8wWa3SwQNnNRJUS4iSXdfMgKfF0+SzhiTSJyJuB7/YpqUT6Y
	mlC279LRP7+8oRqM97CBcDpEw76Ago9zEMyKEw2mW6bvM2XauDT9jCc9B3xXBKht4iJjGvNCFmx
	SaeBbwO5jPcXo85LAKyzb6e0tzNaa85H80k+qxkh1D6kOlrZFZw9udvpgYicJhJpXcSw=
X-Google-Smtp-Source: AGHT+IGO0iR1Dm38qNqAUxs3JVr09b3dfZJrEsZ7XuRj7eZYj72+1AemzTj/wV9N9lOXV9YTsf+chQ==
X-Received: by 2002:a05:600c:4ec6:b0:46e:1a14:a81b with SMTP id 5b1f17b1804b1-46e7115b667mr79587095e9.36.1759735764818;
        Mon, 06 Oct 2025 00:29:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e723432c9sm144973015e9.1.2025.10.06.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:29:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:29:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rohan Tripathi <trohan2000@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: clean up style in rtw_ap.c
Message-ID: <aONv0JIZNA2GPzKG@stanley.mountain>
References: <20251005155920.381334-1-trohan2000@gmail.com>
 <20251005155920.381334-2-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005155920.381334-2-trohan2000@gmail.com>

On Sun, Oct 05, 2025 at 11:59:17AM -0400, Rohan Tripathi wrote:
> This patch fixes several coding style issues reported by checkpatch.pl
> in rtw_ap.c. Changes include:
> - Removed cases where lines ended with an opening parenthesis
> - Broke long comments exceeding 100 characters
> - Fixed alignment in multi-line function calls
> 
> These are coding style cleanups only. No functional changes.
> 
> Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 270 +++++++++++-------------
>  1 file changed, 123 insertions(+), 147 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 0908f2234f67..9aa225bcf9d6 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>  
> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
> +		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
> +		 * remove it, because it has been set before this.
> +		 */

Just delete dead code.

>  
>  		/* prepare for add_RATid */
>  		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
> @@ -436,7 +438,6 @@ void update_bmc_sta(struct adapter *padapter)
>  		spin_lock_bh(&psta->lock);
>  		psta->state = _FW_LINKED;
>  		spin_unlock_bh(&psta->lock);
> -
>  	}

This is fine, but it's unrelated to the rest of the patch so it needs to
be done as a separate patch.

>  }
>  
> @@ -480,14 +481,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>  		/* check if sta supports rx ampdu */
>  		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
>  
> -		phtpriv_sta->rx_ampdu_min_spacing = (
> -			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
> +		phtpriv_sta->rx_ampdu_min_spacing = (phtpriv_sta->ht_cap.ampdu_params_info &
> +		IEEE80211_HT_CAP_AMPDU_DENSITY
>  		) >> 2;
>  
>  		/*  bwmode */
> -		if ((
> -			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
> -		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
> +		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
> +			cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))

This isn't aligned correctly.  Use a combination of tabs and spaces to
make it exact.

Same for all the rest etc.

regards,
dan carpenter


