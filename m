Return-Path: <linux-kernel+bounces-789644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF51B3989B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12141C81F77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EEC2EB840;
	Thu, 28 Aug 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xs4cnsOl"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F7207A09
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374015; cv=none; b=Lw10v6aD7JY/fblSU49nZWEJqquesx/VXN+nCXvnsA0A3DJ7zZ2N6P6j1kByTiUjVPIWoISJ5AfsYcdCBXt7Bq/Na0dT/L6uoI5KK0GENvwUGKhqQo0mnZx6NtkW6ANPn4aR7LlyZDMwc9Np7gQaQrAA4fA62nEJLMLnjZXy0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374015; c=relaxed/simple;
	bh=aDjBedOFhogle5X50+cJzkbYK2Wl5K7pUiyI+O3mWmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6RT0AMZZJ2SAJuTIUqEP5OMwWLtCxmnS61zynJhLoxA6Au2Uu4FKZmwpYy5gVz8i4Lb52r8jgTELWTOyg9jUdp97Xn+Rgr7RssDpP33yUWC1XRvecAlG5KgmtQxPuGDKhdN8cPC4RbbHGQBjZoCsQiNz9gY0OY+RjaqJ2y5nvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xs4cnsOl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so827904f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756374012; x=1756978812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H18ShQScvKRglRK2UXGYScgTs4Q/vE1IKwPk/BKJEEY=;
        b=Xs4cnsOlaFR3B0WFPQ7OFgaK+quJzc4p2ybe1x9kf8uVXcDrfx+LfXIXlpA9rT9kdJ
         S9kbHsIV4MY7JLCW9Ib5IdPh5FNgxbYd/yl6DU8EFOSUc21f54upac1eY0ofqDbVFew0
         5UWLTEsEhWerMDSwYSzDNTlVpZa53bjOjQ4GgyDRnR0kJS5BKKTZ5cq+LsBnSwo82C6l
         TgrgDdjuZMl3JoTw3WOL4gagarflFaOJiwZMbbWkoSjyCbHPNVhLt1/GSOyT8klwr6mH
         K261zT8WfoRVv7uoR6EpYSiYfBabSzCiCvGAUWuMF8LxWowCN0akciQn3Z7M+ZfKFkjK
         HfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374012; x=1756978812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H18ShQScvKRglRK2UXGYScgTs4Q/vE1IKwPk/BKJEEY=;
        b=cYg0OwEze6ygJB/zZ/wTkrHujFkZaFavG+fvxzDVzVuyVAt4N7p9Y1B/AWjbMGHbvd
         aWiNOa2CReLlU0iq5iqZ7na8S0g7y0B2/s9pay2mIUXdwQ5md14XEyc0f0c5exN7J4xN
         XSLnSQE7bODNqeBvZpFGWQPvkXg75wFUvBn/EAMgAmT64XfnOtRpqNhUh9Fqh9yrrxdW
         pfTsGIRqZbLCQqilnCaCJH244CsSNKkzu8WT/xzAJ1V9mRoF3qLHz86pK+Iub4zxhJdJ
         4FO47Re1J9lK7TP0d2PhPHhNJDRee9aVGR3FTSLy9whdzSu2MXqjr/ME+/IioYobq3/C
         HSlw==
X-Forwarded-Encrypted: i=1; AJvYcCWHcAoeeXYjgA/VuLQVi8+h+WOOKHSYFbOYMuqMYG60E6Pws72iFe06FwQUSjaI9GjpPdzrzxgbTpraupo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0aeiA5qW8qdn9Obvj91+8EZB3aPVRKsbIa/N5I/zdHiDtvTP
	nbjuR2h3Q6DckAMhroNfdW06LKnPERtOZDwtYn7WXDDi0OukdTrEHnWwRJoMFI27u5Q=
X-Gm-Gg: ASbGncv7cFpBvXEPnvwdUlnPXlGhYSe8eqRos3naeZdV1r4QRNN7ZOtKn66eNTSM/gD
	8D74pJyrgD4zEiBlns4czPUM+QQDRQ3CxHZrFkq9ktGDQJ7XBe7dU6xMvMdnLIXqmweSI2BwiXc
	Q3vhl6+XXn/s5mWEBIBH9e111L+vKRW4X4s1UZOelAzGZeuCWG1E+Nco1L3NOPREkM40bAPJU7A
	yS272BvdDLi8xmdup5Iwjk47MyGKHXL2DxNVozw5KwQz4VLTNXXM/gE9fzcuJgqnh34BUJJ3kJX
	oAicl+c2dsUftNX4ep4yv4Prq7R5sFmHINbqusmp4CPBlU+jZbc1m1+saNCvmRyjcpix3hpELNb
	J6KooF00a2SxuPLW2eJyftfsZoYpOO7jDJQG7Hm1j33zLLA==
X-Google-Smtp-Source: AGHT+IFERGYy0Bvc1+pJyr9ZQR1l+DS4FjEWsD509R+lmrVqd/10evLfD/XL9tsL/EgOd/szw8gFNA==
X-Received: by 2002:a5d:64cc:0:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3cbb15ca448mr6762408f8f.15.1756374011627;
        Thu, 28 Aug 2025 02:40:11 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cce1724939sm6098245f8f.26.2025.08.28.02.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:40:11 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:40:10 +0200
From: Michal Hocko <mhocko@suse.com>
To: Weilin Tong <tongweilin@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
	surenb@google.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com
Subject: Re: [PATCH RFC] mm: Use pr_warn_once() for min_free_kbytes warning
Message-ID: <aLAj-itGT9DD3SU3@tiehlicka>
References: <20250828030602.204332-1-tongweilin@linux.alibaba.com>
 <aK_7GKJ4BWjye4tZ@tiehlicka>
 <35e0a580-ae78-4485-b285-7f71f91e046d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e0a580-ae78-4485-b285-7f71f91e046d@linux.alibaba.com>

On Thu 28-08-25 17:23:40, Weilin Tong wrote:
> 在 2025/8/28 14:45, Michal Hocko 写道:
> 
> > On Thu 28-08-25 11:06:02, Weilin Tong wrote:
> > > When min_free_kbytes is user-configured, increasing system memory via memory
> > > hotplug may trigger multiple recalculations of min_free_kbytes. This results
> > > in excessive warning messages flooding the kernel log if several memory blocks
> > > are added in a short period.
> > > 
> > > Sample dmesg output before optimization:
> > > ...
> > > [ 1303.897214] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1303.960498] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1303.970116] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1303.979709] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1303.989254] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1303.999122] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1304.008644] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1304.018537] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1304.028054] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > [ 1304.037615] min_free_kbytes is not updated to 126529 because user defined value 1048576 is preferred
> > > ...
> > > 
> > > Replace pr_warn() with pr_warn_once() to ensure only one warning is printed,
> > > preventing large volumes of repeated log entries and improving log readability.
> > pr_warn_once seems too aggressive as we could miss useful events. On the
> > other hand I agree that repeating the same message for each memory block
> > onlining is not really helpful. Would it make sense to only pr_warn when
> > new_min_free_kbytes differs from the previous one we have warned for?
> Thanks for your feedback!
> 
> The dmesg output above comes from hotplugging a large amount of memory into
> ZONE_MOVABLE, where new_min_free_kbytes does not actually change, resulting
> in repeated warnings with identical messages.

Yes, this is clear from the changelog

> However, if memory is hotplugged into ZONE_NORMAL (such as pmem-type
> memory), new_min_free_kbytes changes on each operation, so we still get a
> large number of warnings—even though the value is different each time.

We can check whether the value has changed considerably.

> If the concern is missing useful warnings, pr_warn_ratelimited() would be an
> acceptable alternative, as it can reduce log spam without completely
> suppressing potentially important messages. However I still think that
> printing the warning once is sufficient to alert the user about the
> overridden configuration, especially since this is not a particularly
> critical warning.

The thing is that kernel log buffer can easily overflow and you can lose
those messages over time, especially for system with a large uptime -
which is far from uncommon.

I am not entirely enthusiastic about rate limiting because that is time
rather than even driven. Anyway, if you can make ratelimiting work for
your usecase, then no objection from me but I would rather make the
reporting more useful than hack around it.

-- 
Michal Hocko
SUSE Labs

