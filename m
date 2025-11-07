Return-Path: <linux-kernel+bounces-890348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522FC3FDDF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C94EBABC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B742417F0;
	Fri,  7 Nov 2025 12:15:37 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944E18C31
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517737; cv=none; b=mLZz56M+mY4rKl59qTTxjKhVt0OgSWsa5MCNv8dHbcIEBShvNVyMXuwDXMONy/+ANsVuVar7tWjsz3BjFXJhQ1YKDmiNHisLpsOSqC2dwmrwgV1nyR/EBIgdfd1qVvR8rFbUVQqGtMvcrqGXOngyqFYneiVd57pbPDB3VVt3Dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517737; c=relaxed/simple;
	bh=nJkqvuboRcE/Q+Tc5FS/2w7Fqq08ZLK98rivwvqUbwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lamLg/PybF4v3HrXsTCn9+buAzrl21u29HdWpNm2ls2Yfbr4iAGMH5g0oZaBRdLAegI7ybI2k75it4D+TJ/VHM8TwlURiX9DhNotirkw+UDZeEYCcJssXQqTNhhVhH557hq2PdmRhMEQLr3tYccDMeZlaiamu7oexq0pHVq6pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64034284521so1115557a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762517734; x=1763122534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TZaiKqhNgkqzTPucju46v7m2DA66SO62KdivqxzuRo=;
        b=qEo9veyfsJgSLIB5WH+4k+oX+1BopEdV9L7wHzC9UhDcMo2++h/5ea6I/xep6GHOqn
         YXA7YK+l1Avwv7ltjgQJPR2jQiqNe9ZqqgYmOKalT6V16vwpzsvN7pD+0A8k2AoSpBYG
         XOYyWDYPkLUboIDdAeKiBlI8OIC61O737y4sv6WJ904an4vl1xF4M86o9BMou3sMBBzu
         X71hD2E0mtlboZ03v0j5KKgDtF0+9sSnR0CLzrAYEf2+kAq6NYG0rHjyN0YuFbBd146I
         mJ0rad+2DdfLblX9ZWEs9bHty1AnWlPD+jfB5maqdEyk6EHc/Xbwd8vvKvd3jC/bh1n8
         8KHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzYHNSvxJwLCMQDCJrAPGTktlJrDYxRBG11eEAduybmy/p/V5vo93ChgCL8o6+AQuwU92N9Sfowg8dNd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhzo4oXsjwRQ+Lh3Uwt/sju3bw6hkppXGfHRRol/jyLYRptzDX
	qL2aQR3Ywi5m7Gm9JEMdLUnQyLU0/1X1EhnPNRV/Ywqx8rf1yQApyU6d
X-Gm-Gg: ASbGncstwSP3Ek7v3kJpNLsRc4+2SwrM9gaAJ+8RCgEgqbdFGH5DnswUWhXGvNquFUl
	a1bAPKutYqHQd+RM0BwJzYc10aQHw5opSV5pVKD+bNekvXTWRYKIsdBF6nA5PgndkFji7RE+sMb
	mrzcnUbGggVjZydE4JJUlI7puJZmB3ogOnFNoKg3MVqLE1VC7V2haZMWeipNM70ApDPvG5ClqbO
	mn+tPywa9bWYHB1JfE6q3iqyKiyF9wQz5YnmRSbuhEOmR9CPCPZYkpTe1I+1csIwpMR2//zEHeO
	OAKTWQ8eaHbqRV6jEH3rXXu1cdfMofzX2XXPkXv8r84q/sgp0HahgT8QXXNmcihS/qkjHgRL6xF
	0fL/zZUH94wqFbUOiLn+lv3bPKoc7oGFWM7Wd9PIoDo/ARkB1lA67lGIAMUh1QMbNgQ8L+X1f
X-Google-Smtp-Source: AGHT+IE3/J/dxqkJPk30iDOhIppMHlMoso5VHvUHsgLu5K1wh3uTQSXzctyO2l8Q+jxjQDXMOxbbkA==
X-Received: by 2002:a17:907:9712:b0:b45:b1f2:fac0 with SMTP id a640c23a62f3a-b72c0a38fe0mr256514066b.29.1762517733686;
        Fri, 07 Nov 2025 04:15:33 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm226981766b.41.2025.11.07.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:15:33 -0800 (PST)
Date: Fri, 7 Nov 2025 04:15:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] netconsole: Simplify send_fragmented_body()
Message-ID: <s6zjlx2geyjlfwgp2rvw2qolgu6vnsstv5y2rdihxwkt5i45nb@y6jzzo5pvgge>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
 <20251105-netconsole_dynamic_extradata-v1-1-142890bf4936@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-1-142890bf4936@meta.com>

On Wed, Nov 05, 2025 at 09:06:43AM -0800, Gustavo Luiz Duarte wrote:
> Refactor send_fragmented_body() to use separate offset tracking for
> msgbody, and extradata instead of complex conditional logic.
> The previous implementation used boolean flags and calculated offsets
> which made the code harder to follow.
> 
> The new implementation maintains independent offset counters
> (msgbody_offset, extradata_offset) and processes each section
> sequentially, making the data flow more straightforward and the code
> easier to maintain.
> 
> This is a preparatory refactoring with no functional changes, which will
> allow easily splitting extradata_complete into separate userdata and
> sysdata buffers in the next patch.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 73 ++++++++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 5d8d0214786c..0a8ba7c4bc9d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1553,13 +1553,16 @@ static void send_fragmented_body(struct netconsole_target *nt,
>  				 const char *msgbody, int header_len,
>  				 int msgbody_len, int extradata_len)
>  {
> -	int sent_extradata, preceding_bytes;
>  	const char *extradata = NULL;
>  	int body_len, offset = 0;
> +	int extradata_offset = 0;
> +	int msgbody_offset = 0;
>  
>  #ifdef CONFIG_NETCONSOLE_DYNAMIC
>  	extradata = nt->extradata_complete;
>  #endif


extradata could be NULL at this time if CONFIG_NETCONSOLE_DYNAMIC is
unset. Basically extradata=NULL will not be replaced.

> +	if (WARN_ON_ONCE(!extradata && extradata_len != 0))
> +		return;

And entradata_len = 0 for CONFIG_NETCONSOLE_DYNAMIC disabled.

> +		/* write msgbody first */
> +		this_chunk = min(msgbody_len - msgbody_offset,
> +				 MAX_PRINT_CHUNK - this_header);
> +		memcpy(nt->buf + this_header, msgbody + msgbody_offset,
> +		       this_chunk);
> +		msgbody_offset += this_chunk;
> +		this_offset += this_chunk;
> +
> +		/* after msgbody, append extradata */
> +		this_chunk = min(extradata_len - extradata_offset,
> +				 MAX_PRINT_CHUNK - this_header - this_offset);
> +		memcpy(nt->buf + this_header + this_offset,
> +		       extradata + extradata_offset, this_chunk);

then you are going to memcpy from NULL pointer (`extradata + extradata_offset` == 0).

I got this my vim LSP that printed:

	Null pointer passed as 2nd argument to memory copy function [unix.cstring.NullArg]


