Return-Path: <linux-kernel+bounces-892028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CEC44215
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24243B3099
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29797301006;
	Sun,  9 Nov 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ/fnqaZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E63002D5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704828; cv=none; b=RIybk7QTpPttNPpEVzcMg9gYQNlA4tpbWGIv/uieCChKRPjEjNOaCaDIwEzBBrlcTl+wvk2hVFo2GC9Or9kerwGkjfEf248pWGkyvrlGSh9NZ+/geEMErisWFTwbrzvX7x8KWbE0C4shqRYlNh2XRqmk/6MONYKME10HD8nNmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704828; c=relaxed/simple;
	bh=+4+bYhDhJXiL726cnMpcrCI1T81x+W6JPXOARnAf2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo1c0+MbmcFSRW5HzHV2nrM5SK5/fVluWVwEu+04OPRyx7hHKSsPd3qu/992esgTlsYGFzUx9tYKw8mXkTjD9yCTxD6BuXNNHiPZisxsBB+OH7E7tc4GIE4gGvk2/T1VhEAcnqRhxr9UAslPiK0MwD3YGAVJcCoKrH3iwQdk764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ/fnqaZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so11010585e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704825; x=1763309625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+02kLjHGU/Uou2Bb4YXv+quy1V5TVS2wJ3k/zt0/eGY=;
        b=IQ/fnqaZrXjAgxg8YXo4/2kH5Xx7XSY7gyEQkZu1XJqxSOpQQWtEuKM/dq35NJy/cu
         OHnFTpezgZmMNxxEwhiX7gJ7d9bTvuBKL0C2D3Xbzk7KqFvK22fAX4cAYe0J2pMZ6yzu
         UJcUUYkIsndYFexRX8N3EJJKkggiYZHpwJQgKKr7MyNLz/aDZHCxdFHsdTl0XKbwVygt
         3rua42/Gc9fXu2VHYFaD4puwFttcizDzEVGp2YO+cuDoWBArLXf2UVRBNLmR38Rbni7d
         sZCbAhx7/TG+pLHDtaOkBtd6N6sA1mugz/xTX3HINjMV6jFxRKijDWqW5NSvAYpuQRfv
         +gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704825; x=1763309625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+02kLjHGU/Uou2Bb4YXv+quy1V5TVS2wJ3k/zt0/eGY=;
        b=a62+rP+jjdWqNiVOcgdWWqs7W/67Bger1XbpgkTLRoq4LPbwoRY79Ji7JPVdsRBxzp
         Iv+6Yz82ZGiREb4lJcmy3YWS7fLNLef068i6SKD1la+FRCUVVzCjogpKvgJwTD3Td54e
         nkWwE3hInFzVptBjE0g56Nw3n8azpFIkQhJPlkiR93DS6D6GWyeYVtF42ewSoqxe+8M4
         JSsus6THkXkvA5RXEhaqBPNtPed9m+H1TR4a6HnxFI83eXHvBoLjVoEik4+Se2IU3uyh
         gSPy0D1iA3IAQl/1ihZ43nZuAT+l/5lss7sa5WFM71AmwHM5Nh4ogXef0c4+qQT9us/h
         YTGA==
X-Forwarded-Encrypted: i=1; AJvYcCU1IsREq/KRjoICPkinW2pwPvLINXvgrthbwdOLLTczaMydluv631QU+B5txTVi8muGM/2HTAr3sBCMFls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArNyuI4+pBpeIelH9/qlKMTbUSy7tFSTq+Brp/hvGppneqJCP
	GRGLHwQYSl91VZIRJgSfANIOZfE+4AcA36v1uEKKX7wOn1faBQh6fmzj
X-Gm-Gg: ASbGncs3gvuDiPTKTgwlWPZV4/UNyyEriA0Iuy1RUzaXW8LzJllRuMLcru9NiLz0uWh
	ysxSAgIrRByBjatW8gnTupbA0CvaomVvv1P4HeVBX2uJVc3Qu15Inojaw1fXBkrsXEyNWYN4cbP
	8fCvkwdJ0sEpbH92nEd7uoXjo/dwx4tiktNFta9zg2UzQ6n9qBwM1z8XsxvKAzly5EPDiAOVPyI
	XJgS8mExpomwO04FhewrIzgNQ6P4OK8y6YwvYfSRoHxcq+oJ7IdnLptj1AGzEEFZsDawn1P6xwa
	SagecSWg3FTzhvWv7+5r9KYASshPoGJkmN5F+ExetaIZFWI8YVKJpB8s5a0pMPVMLM+hDMCkANz
	0zjQkIUU7JXdY413gqr/1CYzlLl/Qv49yokpWA/R18VFAJAweNwgbFM5TV4NJWaQMl9iAwO+zF0
	XOFgIEiyILpRSEN0DBGQs+ta20NpPCbxJOLs97p7t0qA==
X-Google-Smtp-Source: AGHT+IHmTHsdU2+Rz4LNGoC3vyXFsyNFTJexIZWocPy0zzCcRp/UzmZAoOUkQHxXn9FhsXI+vpUzwQ==
X-Received: by 2002:a05:600c:4583:b0:477:19b7:d3c0 with SMTP id 5b1f17b1804b1-4777322d955mr43906385e9.2.1762704824735;
        Sun, 09 Nov 2025 08:13:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e73247sm88933425e9.7.2025.11.09.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:13:44 -0800 (PST)
Date: Sun, 9 Nov 2025 16:13:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: jesperjuhl76@gmail.com, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Message-ID: <20251109161342.497e7e7e@pumpkin>
In-Reply-To: <20251109071304.2415982-2-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
	<20251109071304.2415982-1-nogunix@gmail.com>
	<20251109071304.2415982-2-nogunix@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 16:13:03 +0900
Masaharu Noguchi <nogunix@gmail.com> wrote:

> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  include/uapi/linux/fcntl.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 3741ea1b73d8..e3026381fbe7 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -157,9 +157,15 @@
>   */
>  
>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#ifndef AT_RENAME_NOREPLACE
>  #define AT_RENAME_NOREPLACE	0x0001
> +#endif
> +#ifndef AT_RENAME_EXCHANGE
>  #define AT_RENAME_EXCHANGE	0x0002
> +#endif
> +#ifndef AT_RENAME_WHITEOUT
>  #define AT_RENAME_WHITEOUT	0x0004
> +#endif

That looks like the start of an 'accident waiting to happen'.
Either #undef the constants so that code is guaranteed to get the 'uapi' values,
or do explicit checks, eg:

/* stdio.h may have defined AT_RENAME_NOREPLACE */
#if !defined(AT_RENAME_NOREPLACE) || AT_RENAME_NOREPLACE != 0x0001
#define AT_RENAME_NOREPLACE 0x0001
#endif

	David


>  
>  /* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for


