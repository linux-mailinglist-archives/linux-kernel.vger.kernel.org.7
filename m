Return-Path: <linux-kernel+bounces-769104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDFB26A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D46FAA2FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED81FDE01;
	Thu, 14 Aug 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPbVbgvx"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544141FDE39
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183044; cv=none; b=BZ04HOkrrKLPd7vASuj0hk2iWDJUyypw1Ku/cJOcyELQkWpxQ6TqgwBBFGWJeJANoEQzcas5WwSxwiHlG4ln1f9R3vdTKY7xbKYB1VBBgzZVQ2rIZJPLY8WdQRN/IlQvSvgl7dNeW8b44VjrVbZAIu6wzUdoesk/IrlB6FSfoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183044; c=relaxed/simple;
	bh=zMKLfvYxyHlXKU2+2xgv7Jd1haLqSPUF1RejGOjP6zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3OZ8jxihZfaY9ElShxoeWwanV/JSBghhJnbvWDxZ3fsRmADUvogZ7o9klmHApilZEkS6NnlS91PApuEPs+YkSnkjm6vEKzFfuU7CuiIrxpa4nCVZ9SwKlysLRa3g/HKibaHGk9X/gzScohQ1aKJyI0pqGFXwCSOmLM94TrWsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPbVbgvx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso554903f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755183041; x=1755787841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=WPbVbgvx1xhELTZHmnwkJCRlOuRV6h8r96yaxiBpdmDM4UZjwVovjsWGEK692DkXsw
         F/xyIs10St9AOB21NhiV9zAupBkslF5htHIpavw3KyDb8JhEp6t7cjORWay4as/1JSAP
         aX9lNLgB7UDK7gWLQgyze2CSpxBZtN/sCIF9zU2cvYFfodqJXiygAX81UfQ/MVuXmsWm
         VBzDHuqejkJOF2shbxXmfV3s8CgBZO3e/LhnQh5sx28Ke/m0cjzMv+m5I/mHUgqx2Tru
         GNveNx2ei1LQfmuBbU/Hpb7wzMMyl8z3c5Nv2B0ByXb+lK11utsBWUFUF41xEF7tX4T1
         Azqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183041; x=1755787841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=YFeIV/nXQx7S3QRKnDGKMcNgYvJ4ICaOCb2Hv72uB4zbjEwNsrU+a7CE0ho/9MywBY
         J5RuHevCw2+AqQ2jiJl5cvr2EyWajWroppM1/gQ9IMzpOhjlYvluz3XjVJrOqhE6A1tm
         0bR5kBNApWg3tDANZ6tr5Pysl2mSLJB6uvw67Md9QUsEsaCeh9H0C8BJ6tjw/AYHvnCr
         9T/rXEyVpS0kf8L2cof6bI0IbSf2C48iIOR8DLfQ3FUyI1HYV57yUtWJWtUaw4aF5tRr
         aXb/Hw9i7Mt3qTB4vIloeBovZEFLnTaD2GGSZH1ziPP5PxHa0FCSUtu3LNscmKneFAQt
         /DhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzw00T7zZL+nsdmbTsWxH7jKZ/XUJigNmXD5R7CBzcUTwk+ze+gkqO9+hd3okEKRL8ZbirC4Xyp1HWnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiLPa7rNY8P0YmJs27QnFsmQoWjAc6VTJEjIYTUbSlWtqbz8d
	5fvTDKUiaGbxAnMytkxdr9a760y2is7ePT+bHO9udOaN+Vmntb6GnTaOBXEOQI2VsJM=
X-Gm-Gg: ASbGncu8sMdCNjVLLZVLlVyV1HEWgAOGNrqdULUIb4N0DRk3B0UULXlZMP43IUGWQAe
	DeaMf9yIcTO5mD3fw0eJA6oOUQ3BI8AHHKpDuo//A322TUmE3yoHLpuu3VUo3muTkf76ZCn45+4
	g9wQxiC1DeznpyAoLHc8VcwawhD+Frh7MxvABSnnOUVlW0U/4fZiTJfnmR0dwawFi67hRep5oNd
	gFHD5P4Qi7bxOeFfD7I4UNHoDtPjS7437CjlI77jgtEQXcxj05EY35bDvT4ZAqpZjlt4HWZQ407
	1VVwnXLggL0KgHurtuct3mlh0x7B1GLJqn1GTzg0+lknAUGKsKha2AJia5bKTZMmX2WVuaxEQ/q
	v1o8LQVY8WdaXg/PyNWv+4pU8auw=
X-Google-Smtp-Source: AGHT+IHh3EzdCyG/NhBNbMq/qJ6rj0vlsxozGvF3nkk+UdR4z/kGz0s6cc9K0QXKutX0yGrJTiEEog==
X-Received: by 2002:a05:6000:230a:b0:3b9:10af:59f2 with SMTP id ffacd0b85a97d-3b9edf34a5bmr2739927f8f.28.1755183040605;
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b9132f00ecsm8850096f8f.24.2025.08.14.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:50:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.con>, Bert Karwatzki <spasswolf@web.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Message-ID: <aJ33vFdOfMRDbpls@stanley.mountain>
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814131536.231945-1-rongqianfeng@vivo.com>

On Thu, Aug 14, 2025 at 09:15:31PM +0800, Qianfeng Rong wrote:
> Use kcalloc to allocate 'adapter->chan_stats' memory (max 900 bytes)
> instead of vmalloc for efficiency and zero-initialize it for security
> per Dan Carpenter's suggestion.
> 

This patch is okay, but lets re-write the commit message:

Subject: wifi: mwifiex: Initialize the chan_stats array to zero

The adapter->chan_stats[] array is initialized in
mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
memory.  The array is filled in mwifiex_update_chan_statistics()
and then the user can query the data in mwifiex_cfg80211_dump_survey().

There are two potential issues here.  What if the user calls
mwifiex_cfg80211_dump_survey() before the data has been filled in.
Also the mwifiex_update_chan_statistics() function doesn't necessarily
initialize the whole array.  Since the array was not initialized at
the start that could result in an information leak.

Also this array is pretty small.  It's a maximum of 900 bytes so it's
more appropriate to use kcalloc() instead vmalloc().

regards,
dan carpenter


