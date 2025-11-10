Return-Path: <linux-kernel+bounces-893492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E0C47882
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9140B188CC85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3423D7F5;
	Mon, 10 Nov 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZeTq0Xb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17922206B1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788328; cv=none; b=osZuuQNZOrepCdf3p/nbQQ0u3Hom8fcMOksFgLwP9RwuYxI2xP3DtUdOjTyIs3hd4IP8NZGAAQkqspfnybwDj21ggCqw721AZV4+f3XhfIOY3tH0U3hdzv5v0k75prk/hRbAit/P5EUpAzh0uzxFmm0YknKJNnzXtGaiYc+1+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788328; c=relaxed/simple;
	bh=J4zqBGaxHW10geHdnHu2UN1Lym1hfFEVagbnrtVS66s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We9AXYUPZdqnU4wJpWh7x9aWqHqe4lP2RB/o0NRoOGs49oNgjXIKBPzEu9C54THKlk94WAsMAqQj7rYiyyRoqVeh6mEJMO0P+VR7PgidvdFGLKQC4AF0v9JpVX+Y1FHVGo3tS6luaD1Vtaa2LvHxYgekzEiEjWxVw0S4sDKMs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZeTq0Xb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298287a26c3so9229145ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762788326; x=1763393126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfNwtt1P28Ormpd63WpqrWlRVpXKn4HRpQVqf8NamYs=;
        b=BZeTq0Xb52zsjot1NRkTgPRLsZ0lYYR+wRA0WG9uKhUW09YAx2BTl3LNO1dvsnwEWj
         0uMUAFGTJnKmHDrDwCO+ImzpAGpfKf3TYAHl8PlXZv2ybS9LQ1/9i7ps8IgRNivniF0D
         r6lVFLsfYEJ/ZlrvIG24dCHHFr9o6bSLjYMP1MGd5pKp7GX664DV6DjM5CaWw9SzU7Nf
         CYPrE5SytiAigKnjX7DupwoB/dMTvWxbO731ylkl2AKKu/Us3jjJoAR0rNZWxQz0+tiQ
         lNCkhkIbo1ZVj35RhHhaZXzGhaQIWZMB+zen8yGtz0O7wY8pU0kIvkiQIdL/MY7Ot7uo
         NTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788326; x=1763393126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfNwtt1P28Ormpd63WpqrWlRVpXKn4HRpQVqf8NamYs=;
        b=Z7TyAHUqTMRxnTcmQJdXTWRCOyB2VFwz/UL9Rtt2+BR8hLo76nbZ1V1y5BxkTUaoe6
         VepYDqHyHm/VDKXTdoYgzz6LMh4V/Zh5fe4EI+cJGeobAHc4E/rY8H67jr+UfCw/qN/i
         29QZcnP0xDLZLhcDh3yj0UmThUJcqPm5CqoFiAHPxzKXxOwCS/Bty3gCLpzFZJepS2GK
         Jewa+V9vA7Pa0U/0Go9IG77bXIAnbbXFJJ8utw7WY3SMnIQg8p9cTUOQ1XpEfQmJZVVx
         JotSzmDy881i29qzLu964H3Ez+4dfd9uIHmZh6wH+S3lfxjj+ZoJcROpqr56tYKWrJ8k
         Ev8Q==
X-Gm-Message-State: AOJu0Yy96jNi+bdtf1+40pWzLkvf3+zTskKSDEmpw6ilslWc+u+1HZMH
	0gq+fpeSi/SrK2C8ztY9G+Jw4hbg7bUNtxByS9CUaRoGw244LVHCNvfQlm2SJHyo
X-Gm-Gg: ASbGncsJDg5/xVvm2fFd8RwBCtMDbEYAgxgRYgEaNfkM973XWEtmVCCEkerFfy1etU6
	q+T4wKT3iDU5qVFjLTFVj9psagVLFPN8AZzs8NFmbLCYi1HX6DsBsLJ2WMjFiEvJ+WpMARf7oDB
	MsOgTpvCtF5BkZkSFK5PtgrXeJSQOedDfNSGryzOdmfjgeKs8DI4GQAootvS2WhzIaTtgpL2KxV
	Fni4YG3hldwXOASMZP7A818Khxa8XSqgvWkHaCdYVk/zDZMPqUxVEDZLKE+RSehMxEideI3WuEe
	9q1RwV1ItvfjwwtxFlq2xkFfqxEjfE6qb9f2vwOHEXSg0B6HEVkbFJBiMsff8pnsJ+87G14cjRy
	Ry46PUpgXVcLr1leI1tgaEhNgjDM/Qx7QTV6G9acgKgeyyHvy1kGrWolFGhztJKUFvpsx9XGdLu
	bvDOSCIGJV8MzjpVPnCwsXJ//V
X-Google-Smtp-Source: AGHT+IHB1PYa5ZbgRcRUEiecE5RI3qDST01Kg+jblaZ3Qn4npf2GCTSax1pIo/50ah7zJdhFWO/iqQ==
X-Received: by 2002:a17:902:c408:b0:295:4d50:aab6 with SMTP id d9443c01a7336-297e5616224mr108738415ad.18.1762788325882;
        Mon, 10 Nov 2025 07:25:25 -0800 (PST)
Received: from google.com ([2402:7500:499:ceaa:cb8e:dff4:95ab:130d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7445dsm149018625ad.62.2025.11.10.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:25:25 -0800 (PST)
Date: Mon, 10 Nov 2025 23:25:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/1] math.h: Amend kernel-doc and add a note about
 signed type limits
Message-ID: <aRID4efkPf6x6Gqi@google.com>
References: <20251106152051.2361551-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106152051.2361551-1-andriy.shevchenko@linux.intel.com>

On Thu, Nov 06, 2025 at 04:20:51PM +0100, Andy Shevchenko wrote:
> First of all, amend the existing kernel-doc so the description
> of the function is decoupled with the parameter descriptions.
> Second, add a note to explain behaviour for the signed types when
> supplied value is the minimum (e.g., INT_MIN for int type).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/math.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/math.h b/include/linux/math.h
> index 7fcb980677a0..c02cc5b9e6ae 100644
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -180,11 +180,16 @@ __STRUCT_FRACT(u32)
>  
>  /**
>   * abs - return absolute value of an argument
> - * @x: the value.  If it is unsigned type, it is converted to signed type first.
> - *     char is treated as if it was signed (regardless of whether it really is)
> - *     but the macro's return type is preserved as char.
> + * @x: the value.
>   *
> - * Return: an absolute value of x.
> + * If it is unsigned type, @x is converted to signed type first.
> + * char is treated as if it was signed (regardless of whether it really is)
> + * but the macro's return type is preserved as char.
> + *
> + * NOTE, for signed type if @x is the minimum, the returned result is undefined
> + * as there is not enough bits to represent it as a positive number.

Nit: s/is/are

Otherwise, the patch is:
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> + *
> + * Return: an absolute value of @x.
>   */
>  #define abs(x)	__abs_choose_expr(x, long long,				\
>  		__abs_choose_expr(x, long,				\
> -- 
> 2.50.1
> 
> 

