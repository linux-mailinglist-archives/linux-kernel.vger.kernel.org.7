Return-Path: <linux-kernel+bounces-817267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D5B57FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268272A0EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2032A83C;
	Mon, 15 Sep 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERqay218"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6093002A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948753; cv=none; b=m4EeWmqZDO2mc+oKeFS56dIBOjS2QggHiTbz9QESskr2K0Tran4fXXX023qHr7rnC3aLtJPWtjeckXbkA6C7WpAWddmG+yWfBAfrn+eQJFdK6bizKnafTxbkLFikcrJz9zfSh/43AQISiyOHMQyXBfj9gktM6bF7dSac9YV11vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948753; c=relaxed/simple;
	bh=Y+OAfwjN2zLWZP+9G119tAeZdgN0q8dCC78S2c4KhVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEC3phte/+BOiYWC1icvuq2PNyBosi7M+VpgqgTKslFGfbHusHuyIx7aKfN4nqbXHTZ7W17oxzjzSbUYoNb+pXNGMwGINkz2ePx3v+/RIhm2K6u2SwrTHdUGq5YLOBTlgYcEBhXLVXDWe8+9BQXqbX7xH2qJvcxxAIl/d057PSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERqay218; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d601859f5so31072697b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948751; x=1758553551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fZzkxHP1OOwmzsUzfvvWxxzPkZrOBgcHf91zQ9q6bA=;
        b=ERqay2186jk6nozVThEj0Il2gGI/puycsj0fazq+DV+kRFIcf7xB+yQTjY/0bri/9S
         +kcYWEOaOTEiqoi7LNcGhJRAsHeOtBril5k3zNRcLcyZK7wVEykbGr+o10MdAaVpEzrc
         4/n+kq7zXBzhxENQYZzOju9iOwuuijf/dIap3jBBEKDGdwDHFEkJiuaJhrQ0PZdsoHQK
         /mwaVjWErEJCY6/cP9mwWNmxipjRXvKS8+bRoniyxG6NUQ1NOIGKFXSqqfR4kiNFX2l9
         yVSY5lzp+zURLt30HJr7Hyw0sDBqhp2NHvnNQMrg5opDh4yFnejH8ecVe/vteZ3cQ7Pa
         /ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948751; x=1758553551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fZzkxHP1OOwmzsUzfvvWxxzPkZrOBgcHf91zQ9q6bA=;
        b=Q95LITSj5epkXiXror2O/HnOkTsBeTlvlA9ym3dJF2TfhmbY7JTOJpua6sSD3fjNMt
         B+TWRpmVsYulDbC6XaWx5yYuTAqyI4LwA9YXtOPBGw1IR1ijiWviWgugi1lZFQ0Nrz70
         8Xr2Tya80SA1e503yBWq43qWoRXWzw/hbfbjBbVI9mDieSTF4mby8dqAm5SWCwHc2zLZ
         SDvNu74ilVbZqLyAMOZreILjAAdM+UtBMFvAd8eGSGsQ/xeUPvONnbKY8M5POLT/pzEG
         6sJx7gb/2ZApfkHBBf9VwiykBEQ+p8JdryXZl/ZDrQtgcbDbRNGlfpaCEAl5I44YcUn2
         0yWw==
X-Forwarded-Encrypted: i=1; AJvYcCWX8ZY+YRiE1xJkLZ6sl2fSPd0prJc+PPR7JpnxEIBEfqqb3JEdPaM9NYbRgaaFTngUhBd2ofen2XFkqnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HsDe+8gb2Sm604vFBJQpREVj2W7AEJ94dpv2V2eFTkeo/oUf
	IVWJICFSBD8Cf/hSLoYleVfU0IYtym6qRIuq+ogwTkcXOqph7EG0sOAO
X-Gm-Gg: ASbGncvrHnxN1mYw+qxsIdGOZUyUM8cCD8AO0mIb8RzoO8afJZPlBe4JuVr7j5TpLA9
	7eoKHG7O0O6EmHZFVHl4E+9hKpv367eSuCKSCt8tMqeWJAJ9V9qmEeykuWMFGtLKaC5mV9yLfxL
	N7sEoWq4p+jD4K92aeyRmjcmj7Ddrf85/yW04jF81LGdHwFiT3LVjAyk4pWU6TZ0811rNhIsT40
	F/viMSo5swLQxarerDAoF3ko/IZem8d0U224fjYajvVNxPYt73C2rDU/EudQYes3mLB8Wnp/iW4
	HDMYZ7oSVAyhRQwRXZiMa+w22KVabkwy10sgyRafBWM/1AD13jfZF3L7RQk8mNGKnvOgxhv1HTy
	1jTDiuz7GfqonpEruv83CkWfANkTovscZeVaPHhiby9pr/yg8e1zSNdb3BiALbIaw
X-Google-Smtp-Source: AGHT+IFVR4/jZB2COJFPEGxfd0jRNijX9bwoQRclaQiC53MprmBZ+9vZhNJplkD1Ak6GytefEA05oQ==
X-Received: by 2002:a05:690c:4904:b0:733:af83:51b2 with SMTP id 00721157ae682-733af836cf2mr41991207b3.45.1757948750534;
        Mon, 15 Sep 2025 08:05:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238386sm32849077b3.8.2025.09.15.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:05:50 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm/damon/lru_sort: use param_ctx correctly
Date: Mon, 15 Sep 2025 08:05:47 -0700
Message-ID: <20250915150548.1486984-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
> user-specified DAMON parameters on it, and commits to running DAMON
> context at once, using damon_commit_ctx().  The code is, however,
> directly updating the monitoring attributes of the running context. This
> doesn't cause a real user problem but apparently this is an
> unintentional mistake that can cause code review confusions and future
> real problems.  Fix the wrong use of the parameter context.

Hi SJ,

Thank you for the patch! I am a little bit confused by the behavior in
damon_lru_sort_apply_parameters. I was hoping that you could help me understand : -)
In particular, I think that this patch fixes two possible user visible errors.

My understanding is that we want to make changes to the param_ctx first,
validate the changes, and commit these changes to the global ctx struct at the
end. In the middle in the errors, we can abort the operation without committing,
and ctx will remain unchanged.

So to me, it does seem like the current code could lead to some visible effects
from the user's perspective (error-handling case).

Also, I am a bit confused by how the commit is currently called. We have
err = damon_commit_ctx(ctx, param_ctx), where the first argument is the
destination and the second argument is the source. There is a bit of a mismatch
because in the current code we have the following:

+------------------------------------------------+
|              ctx                    param_ctx  |
+------------------------------------------------+
| New &damon_lru_sort_mon_attrs                  |
|                                     New scheme |
| attrs overwritten to NULL	  <--            |
| scheme rewritten to new scheme  <--            |
+------------------------------------------------+

So in particular, the global ctx will never have the correct attrs pre-patch,
since it will always be rewritten by param_ctx, which never had its attrs
initialized.

I hope this makes sense : -) All of this is just to say that this patch does
more than just improve review confusions -- I think there at least two errors
that this fixes for the user. So perhaps a more descriptive commit will be
helpful in the future, since we are also adding a fixes tag?

Thank you again for the patch, SJ! Feel free to add:
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Have a great day!
Joshua

> Fixes: a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/lru_sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 14d31009c09e..ab6173a646bd 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -219,7 +219,7 @@ static int damon_lru_sort_apply_parameters(void)
>  		goto out;
>  	}
>  
> -	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
> +	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
>  	if (err)
>  		goto out;
>  
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)

