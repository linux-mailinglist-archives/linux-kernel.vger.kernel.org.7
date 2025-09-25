Return-Path: <linux-kernel+bounces-831773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77FB9D8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5F44A7FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16C2E8E0C;
	Thu, 25 Sep 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqkzfmjy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F32E8B71
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780727; cv=none; b=SIhpWOS7LhgQnt/NkzhdGPuVLb/0YQwxTmLpA7wFWlRP5Cchg+XktmDI02bcWJe51TVq0YpFUimqlt1iS+TFKMmxpW4cU6vuVsQfBRghNjhttyOeIT3TFzrF23rRUmiGie5va2EzGBT1lSSK9ouuYNxUDr/AVoWelJcGHDlgYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780727; c=relaxed/simple;
	bh=uSFb8MHXwLqA9OKwUwZ9qPfEDx9KKhVW9XfP9kuC53s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCx0OTS+N2wrSL64Bykzu4cx2JZfqzQFf5jLnCHEcvr8EfDO7Boo1mBckTXZix436gdR+tkgToK/FKcE5IsZlgtJo7zvUq0RTET3UqXFIMl0dIMKdgsZkMwIoukWcR7gFuVLBiQ42WXxXwXq1fcVJb3nKXYQ3jY6CHOrB/rhEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqkzfmjy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e1e318f58so4780505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758780722; x=1759385522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEYWGfF11/g3FTMFlorTwEZrbGBIs3tO9z9pPNiHJAo=;
        b=qqkzfmjyigSpLUoNqAMuAQPl/zPXizRaJfpLiXhw2cfQSwVL8u7D95BnPvpPfPoA04
         c7DPuIq+tHha0AqLofEqBwuLohznbyQTmFnioXKf18DW04Tma9rsEaqu67ZxtHuW1YTh
         SEK+jdgVOgwOdcUUudwlrEk0K6tqdtiSgdFO3IR8N+KoEe/C8V9Nque9V3Jv/Xb3yNeB
         Gro94cqz5bWoY5+kR2qM1bVW6F41cM5/NlgqWbNlrN4E0uQ9Hy4BWBktjrMiCXWr82iB
         iIg3aGdJ586DTiy+EhmAXH+NVFYsSsAhMFOZPsE1NTTdlMOOZvEVlsgRFd82pyXpAxlP
         qQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780722; x=1759385522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEYWGfF11/g3FTMFlorTwEZrbGBIs3tO9z9pPNiHJAo=;
        b=Qng9kYUynL21GpyVqRJvHUfHEeV8vBFAet0lBd0EvC1eeAwVMn+MQxIv1gNxE501m5
         Ve2leffeNga1SXTs+lZPPPGTz7QgkCvK3sfQsrBLgue56VvxCr0JUuVXmFv9zq930Rub
         mk4lzIjeMvXVLFzWM9OiKsXXJVXpBegVg7tkcXQYs0sdaAQ4BkdrWzXoE/rFRR420v5t
         g0GWgA6E/MbPapd3ixbn9fo0kwfA1zbJJvwmEcvSud2SmXqFc6JkAjDl76wu3mYPWgPu
         qU/8m3uYEYsb0AVzEBR60kPAZ03SIHu4U6SpKyUPcXVypjK0OacZKMNEWw4gjKq18kmo
         +67Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYLX2qvYkWl0qjYSpzF4cUtSymYGlUeGMXww67eAHfW0LUN66gm7iWMZo3R00T/KhZraYdoz5xpjpO97k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcTfT6MBuCFQmXGb8TIph18auk5DJLE6KnuRN6M6B5jX6z1y9
	llig+WufdP4e1PShgUYrOipN55gKcC8ZwCPEsPMdEytJrCbsyJcWpCz35JbG9Tn39a8=
X-Gm-Gg: ASbGncu4IbkDmYz5ffCZ8uQk9xP2Enq8dMJAuvzYpaBP7h3Ioywcd9HR6FRgEVTeOj3
	3D5iKvZWEe9Dur9Xggm+CNCIxDBoYGBDrmbeH4U2Z92DZHAL/ipXwXRSQjdCbzC/74rkBskJekl
	NU2AYGAWOs0Bb0Iov3W8tVqaOT6iuBMCbfOjY1EyMcmA5iNzKUBg+SQRZ77+5m3y2LfIMW4Ksbk
	HHykESjhbJDLxG7nnbnr0ipqmMevskiLLx7OJnEJyiVWo1Nx+UzFc1YgoCuzt/AUl5yBQgqiGp3
	gtiphVBjjq4uQZlQxusrJMZzNhrV5w19wP/kL9Mx7669LpF6bq4nvIGtvO4EarMwiCllJu4ZE8M
	dgEAIQ5BFspfty8GE0Rxa/llcXAc=
X-Google-Smtp-Source: AGHT+IFRkpqclsNYUNbGMkAuZhXHS3Qv2yCkSEuPjzYXQeiL3SAyG+ATQky02YBh1lI/bsu4q3uPPA==
X-Received: by 2002:a05:6000:2381:b0:3e5:47a9:1c7a with SMTP id ffacd0b85a97d-40e4a52475bmr1878562f8f.62.1758780722328;
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc5602f15sm1453105f8f.39.2025.09.24.23.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:11:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2] 6pack: drop redundant locking and refcounting
Message-ID: <aNTdLU7amoq0bCnS@stanley.mountain>
References: <20250925051059.26876-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925051059.26876-1-dqfext@gmail.com>

On Thu, Sep 25, 2025 at 01:10:59PM +0800, Qingfang Deng wrote:
> The TTY layer already serializes line discipline operations with
> tty->ldisc_sem, so the extra disc_data_lock and refcnt in 6pack
> are unnecessary.
> 
> Removing them simplifies the code and also resolves a lockdep warning
> reported by syzbot. The warning did not indicate a real deadlock, since
> the write-side lock was only taken in process context with hardirqs
> disabled.
> 
> Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c858b0.050a0220.3c6139.0d1c.GAE@google.com/
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2: add Closes tag
>  - https://lore.kernel.org/netdev/20250923060706.10232-1-dqfext@gmail.com/
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


