Return-Path: <linux-kernel+bounces-729340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76FB03531
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB68D1896D60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2B11F4297;
	Mon, 14 Jul 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbj182ml"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115491F099C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467514; cv=none; b=usYqJnC62r+/yZcZAb8UyhqJM7e698/2Vl4I3H5qL/eLe/QJ0PqzFTkO1ChbdWdek6W4txCXl2eUXaZFZYy54B2C1sNf4EbYSgnhasFWEWthrpxl/QVyokb8rzSxS40jMR5/XcdnQ8PKLzz/nOjtHYaKMvM0RKiXobANVOFpGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467514; c=relaxed/simple;
	bh=aQdZvcnOJD9tDUKv6+VfIIAENJ7jzQBXlhfABnT/vog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si9xGh35TPy4dx9+JG88/QQJwg6Ik2tskt9lUD54MPiltAW6r8BM/FTjC0qY3/gwsFoDnHTQtjuPheiOnOjEPf6CmlecnoHTeSJsmoYMfHtZsR2sidqdPWTrUqRQiLbNeCltpTItd5FI82Lit7r96BCkfbaDwL0ZV7Y1v79gxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dbj182ml; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e92cso2429911b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752467512; x=1753072312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvCBTfIWmWtgk9rP9nhlNrNCUoxPn8lBKMavjp2yAb8=;
        b=dbj182mljzoe+XyvAp9fnZoe5uAMOyH8kH72Ef3YB7KLo0hga+5ElJiWeBMITGg/a1
         43hj9l1b7obaboeyzTTtVjhdDtFMd4CIupTqrALBylJCoMpIcNj3JdChnFCt+kzKZuVV
         p9FkQJ3H9bt1t2vS9llnUO+a1rIb9zVEkNjtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752467512; x=1753072312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvCBTfIWmWtgk9rP9nhlNrNCUoxPn8lBKMavjp2yAb8=;
        b=VeDPkG1I6L0dmjkLsCrwlgNTI0QGFCLkH2KnwALxQNUJk0G73+IqXDtck7LOesuNZi
         gRnkth5UKmku5cXwRDXMt4gPTElzniFxxdvlBFg+UnSLJtm8j38grxzGYBCx9o1C3Kel
         3Mkpp4RDnBUUG85GRUmGGMg06GPHHL2LSHNcSZpwKPPldz8Xg0bUCwR/HujAoom7hYCp
         DqF5z12uOm7RaKf3R9FR2fIOk79RU1FP8kM4TvdTwqtdbQ2N6I3uQAdYzVfez8WEcCcn
         c93JXqFK8UMXj1f1qpn73VJ8iJFq8qnWxlTO5zRo17X3tAb/Y6nHG1rf4pioh8a9reks
         A8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeQQ1DMbHU+RWl3H33bqtSspWT3qvuYdEKhVL+l3MiFtxQwgDa703RznP/D7kEhCoSyjWUxWisqVQVF0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rzxhqaariUamSZNQUA5wMlAtbXKO2B+pzw9Q3kXbOFyXmxje
	TCNzzkXiShSKkh4eHllyYZ3ZyUCR4+spbzVyiz0/oJmaNCxDEihHX6osFmFTcM981A==
X-Gm-Gg: ASbGncuO7cgNpJ0JoCMKRAa8QuWnliG77wmhzqORZWR8D8+ANFpcMF1zVFN6d0HZw31
	bU5RZU3ZN0mo7myW4X3ohXKttjQAL8GOVzw9fgFCw7yoUPoe2EYIbEGKPkgnMU5i92RKOtWeAxE
	JgW8W9GwcmIwTp7T8CtzQzXXbcS7gGe6WAOciiqunPAfii6ALYsE0TAgOY5ZyxC+DkAg5gFLCdG
	nzQ5khHd5VBfv23FlqkFeAZ1/171yTXE+FQZ0OW9+NuIlgr3y/GV3Di670G3whk66z0wz7bxOvF
	bKPyMComTmIV42LjY5Swc7UWBwWCSdihtCjY6IkOVr3sOUqgSNQ4KbBB3NrfIjU6Grh+PcbOI9t
	6phGpg+G32jblzIP1oJMaQq+MjA==
X-Google-Smtp-Source: AGHT+IEawOYnl3pwZDteQ7eTr43CIgn4Vq7oK91QQprO4uKRidMBQ0k0pNSfCJmsSZKDPQI5rAbS+g==
X-Received: by 2002:a05:6a00:1304:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-74ee05abc06mr17572958b3a.1.1752467512268;
        Sun, 13 Jul 2025 21:31:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d84e:323a:598d:f849])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f2251bsm9953809b3a.100.2025.07.13.21.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:31:51 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:31:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <nqlxu2zgnf2z3qyncdkhk5juov656fzysgj7jkwvvcrayvsvzz@wuwav7xu3fjl>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
 <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>

On (25/07/14 12:29), Sergey Senozhatsky wrote:
> [..]
> > The device is detached already, I assume there isn't much that
> > cdrom_mrw_exit() can do at that point.
> 
> If I read it correctly

Hmm, I don't think I did.

