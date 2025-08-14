Return-Path: <linux-kernel+bounces-768004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99618B25BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086671BC2204
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA440242D6B;
	Thu, 14 Aug 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/M7YKy0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F34242910
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152685; cv=none; b=Vl59K9VucB8IdvG6QTvKEgbKlNp0YAG6G+PXOm1FLzE6i7PpMHzdQG+Tg6/A6SvkwfpfQXkX3PW4sz766gNfXykQoEkn5f+6h4NhDWnTirT1Jj2Ilu+voXiWyI1IQBrJZR7mMU0kuo0dPO+2AXsrVUZmJ/5LDSvFr7WXOdOzFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152685; c=relaxed/simple;
	bh=qZNGyMPtpCLM6EfQifGMbXKiGpwjX+bjskdpMhwc3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2oZufJEzq3VYNNyA47fB9DGyIV7YrFL0GCOyTZvy6i3bupKhyKs3iZKM+BPsUo6FVN0m7u8HVoT2KDuct0h1pQzP4pQtu0F5B1Gfq0L9PCUDZu2kx45eJNXwEQy+s1ZlhmFitp0VtRDDKoElKXFg7zMKsv28bn5MGC4pX9TL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/M7YKy0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so2589225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755152682; x=1755757482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2V662DeXltqYKqnizy5mT9VDX//IKEiaMN/OlCmjlaM=;
        b=U/M7YKy06GluTnYSmp4bQVBh9JZnoQZFwWjG5NmENbweDWRpBbFumTu7kNMJXELm2I
         iatZpZ1Nd5jNiWpt8WS2bOUHyk9WDNj6jlBexvPZnFITDGkZNpLOmsQmeblW46q2xPKl
         XlIUbnXry9D3VK5DFj985JxpXJqXlwP2aMsBoMr1ARRBtRrLTjwSkcoRYhdSnDzTLyMo
         yZd0OQ8lHrqaEc8hWBe/6qK3a2hT+WcpFGAJstENTzAnMexHYyi9JW1eRGW1PCPydA2U
         PL5Z8pGuj8amaJh86kADmh6crujyKAkc8psgl2ubm1uqHRGkfspLGcxXNSeRnMUMWQqN
         EqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152682; x=1755757482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V662DeXltqYKqnizy5mT9VDX//IKEiaMN/OlCmjlaM=;
        b=U3JlL6vH3uUmbiYHONQ5DonAZ+a2wzSuND4d8vb993DUq6VLynzApqQQSLyDneUQhR
         /Q9a++5Up1h+zuzlfSE8NmnnrdpHwQsrCqZgy1l2sV7jrV8/IDb6pBtiSUNFtfF6TEkB
         SYs6K82noocZlEQr3JSicnpkRHGXEyVFbM5Dv1kiUKY53T9sDkkZcg3c7ZF2Lxp1piz3
         zsCXeJ/ENcNURyu4/Gujk7tzXfI3AApyvB/odiqlNpqWX6Qv2gsQxqLO9SsuKPYu5Oc4
         iOg5J5MIETpFL8Xs5TPpoeOyk2mUfTnK7+UwpPJCi6PbOo5tZ/7TUYw5sz3JYP774AN0
         KpbA==
X-Forwarded-Encrypted: i=1; AJvYcCVJDIwNAcl/3hgDJL5GJXY8l02bn/D5dmJ9/AkNROWRhsURRm3lSanlBqyZw5CGuWlWzDH0kHdIHdLGokA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhem0/8xAJIZYn3hM0WSlPsmZ0yquDDqJJPMuK11qfDMLBRN7x
	kdy87KuWAZ1RTPyf05gfDzUfHaF24QM6aJaxaV1QFVGT0HxL5equU8bGPD4ci/Ly9DU=
X-Gm-Gg: ASbGncu++p+zp0Tvrrqt7M7GP5b1fJ4QREkOROwhnUwohm7CZQK+w6HVpPsVzcxIAV4
	yvJ1f1HeW6RCQONpOA/Xmc9e2w36eOXZo1MTYs8uD5mZK37tOZ/0OEUbd8v9+rV5SNbK2gbDJty
	fJ8+5Y5VAPhsIS1GubmsCIcyuTzrQyF4pL1pQ4UJxa9Rs68F7gx5kF48vxD/IvVG/anmjcyNAes
	0Fgf7vu3i5ea7asDQxJ2U/ohPkfpq9vkhrA/uuWMl0ZVivICnO7k2opdK0lmn1lCKfqpT9uCjDQ
	NjT3i4pNGdOSfb4TrQ6Ev1VptqZtAyHWyBi6O0m93W9MM7K/45iILr5be3TOT24EDfhhLf3Ulcz
	TBNp7GCfFIMARO58bKBgLiANZtSFPM/7BmFdR57K1rJffCbn1DSg39g==
X-Google-Smtp-Source: AGHT+IEf+EdlTte75NZBvFy8FZziO62jRtYq3j83EMroZ09yzmhGTqWD2sPpyKuBoUMWeKXskigG5A==
X-Received: by 2002:a05:600c:46cb:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45a1b602f28mr12689675e9.4.1755152681744;
        Wed, 13 Aug 2025 23:24:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6fcd32sm8872795e9.22.2025.08.13.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:24:41 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:24:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Message-ID: <aJ2BJKAnFuJ-xIjs@stanley.mountain>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
 <272c9a0f-1e95-4c7c-9b84-a6b564d9e2bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272c9a0f-1e95-4c7c-9b84-a6b564d9e2bd@oss.qualcomm.com>

On Wed, Aug 13, 2025 at 11:35:45AM -0700, Jeff Johnson wrote:
> On 8/12/2025 6:48 AM, Dan Carpenter wrote:
> > On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
> >> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> >> simplify the code.
> >>
> >> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> >> ---
> >>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> index 3498743d5ec0..fb4183ff02a9 100644
> >> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> >> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
> >>  	 * additional active scan request for hidden SSIDs on passive channels.
> >>  	 */
> >>  	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
> >> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
> >> -						 adapter->num_in_chan_stats));
> >> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
> >> +					    sizeof(*adapter->chan_stats));
> > 
> > n_channels_bg is 14
> > n_channels_a is either 0 or 31 depending on if we're using BAND_A.
> > sizeof(*adapter->chan_stats) is 10.
> > 
> > So we're either allocating 280 or 900 bytes, which is quite small.  We
> > should just use kmalloc_array() instead of vmalloc_array().
> 
> Should transition from v*() to k*() be separate from transition from *malloc()
> to *malloc_array()?

It doesn't make sense to split this up.  The right thing is kcalloc().

regards,
dan carpenter


