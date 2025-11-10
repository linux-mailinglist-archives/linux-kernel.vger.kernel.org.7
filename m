Return-Path: <linux-kernel+bounces-894301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B8C49B63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A866D4EDE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F634301495;
	Mon, 10 Nov 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBHfNOW/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419525A2CF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816323; cv=none; b=Jse37947tQmFWEgNeKpPTE0nzj7K8Aoi6jR5i2oyyQc2Zy57dyaMHqTo+7qZ5ztW1xNWeO1GlyHYVWPlX97aVUHJDARp+vZ+8uvULhv7VIbRNaFSGon3gP1eHjMaHo/Rsx1YA2gGkf03lEb/PQmQKR87Ztkv0EpZ9Dkol56kOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816323; c=relaxed/simple;
	bh=NCsEEDLAZ7D0HQmvFIC8vI7abvE/3WSqCFBNjRC9Hw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsXlSYUxZyWcsWTx9EMjjNbOFy3bfHOmRLhEqKy03dMR7v04CzteKCPtAxFQglfTB/FHIZe0Q7/y8yg/kKcZyzaTRa69X+ck29wxE7rKYuZ+LtWArlJmTHIejfvQJe7Buq6LFlqO6KVHdR/T7XvODZOKQzulzpoheyrsffBz9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBHfNOW/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16919275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762816320; x=1763421120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ur+jItSBFJa8rWcgkoqU0zfeF/8teVfafx9jMHzM0o=;
        b=XBHfNOW/CWnAIqqFsRJJzORDacsqrC8yieCkACo6mdc1LXCSB0WEc1KhWSmB7mEzat
         QVpGTvB5NQ7n6+5n6rI+tkINqmaM1ftAzCt+r2eeGsm4KweMYDibjIpJgX6pvFXMTUbQ
         LPUGzAoL9jB8sQsNZweqlFOheWP3UjElelK9RiQI/adH4rDSjM3mn0Jp2i7xukq66z7B
         gOTi6nGViJ7cXbKs1vm9QgsFcDg9OMu7wIc+2XNKNaC83oOHcIvG4Zq/yxlbueZ5Tlev
         SsrVXaRAJAVxEfGycUv+LrYrVe21VsLD2ytr+l/hB14YXHtOLnCLb0wK7sVMb6DOufGM
         CEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816320; x=1763421120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ur+jItSBFJa8rWcgkoqU0zfeF/8teVfafx9jMHzM0o=;
        b=qhj118hX2bacq+rmWztFi2Rj9HRSLIPRai1cXYQWHrSLKABTiwCDku30dkzWgVyNTT
         j+u/ePS2i8t+rIZvjmF2wvOehBHSs8iKoOu3kcCjpbpz56qtgoulqZp3vXojU7g1dn0w
         BKAUuWXSzYf2eZgUrk82BtjTYkcJq2zALTgv+J+2UP7IGyCODuaT1e7ClCFXDRaqMt8V
         hl75+WFNs721DCA6VnimQspFQwAroXde7faaVKyOJBxeLdRGXMPbghInp5sl/QXD3QZI
         WGUhMeVUM3bWiJJaiOMHhkcQ+1cZkveTP5B1LjuB7R7D29fXY6vtIXORi7Pq7TGH8Egu
         aHmA==
X-Forwarded-Encrypted: i=1; AJvYcCUgo1Fd6zKzJB9tilEvce5nzWzZTX2Xh/EvTR7BiJ0Ns1cYql+0l54idAEXEAuq5LVW26TtJchX2hwxxAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgs72I7u7kJP4soV+b17Kx4Y0aACveXTIhzeFlEnJ6Oq2cggsP
	pb4gOcCv7EM95F1UBZdry+1CMEGh9EamTDZGPAnvpgxLzsH6689oOQTa
X-Gm-Gg: ASbGncvI2aFKPxju9KPVDItwWg31EoEdFtUV9njPXfA2BmlnERmV9HkzlQVeGD2F6Jy
	ZPnhBZB2+pmPFds4kkQ6QTFHSMnGFjUh+AGi5gN418GpST5GMR1/mn+gq2ToDbr4DL2nHgT7MLE
	AnkOaOJpCFJJNn2yZJr2ogp8ueK1zM4UhaWIdIU7NgpjMx7/OXfHMlYOQjpAehdhJcuqQTxOpFx
	Vr8XyTrVsabS5aTW1B4b8m23fD8VrxUY6/o7wEVoUajPrH4TQrowbWPH2xo9gcTZtkLhVliBstw
	hZVpZ4p02Tk+CqF+MdbDLRW7DoehWvoeaMvVg9ZSsiN5EGbaVLBiGauh/ZkfzY0uwKWAKsiRKnY
	pDJroSYVXI9BrUav8ltmajPF/afKxjW+1VnGC2EBmjuYmoAuDDuHD9q1HdJp9JbJ9bbDHDUXbmz
	h+uJcFZuLb0syPDvsk3Isb++WbXTTtjwZT/8qjeAdXDB0JxUw2vsHRAcnRBZFAMZo=
X-Google-Smtp-Source: AGHT+IFKFQudGUWC8YZ8n+/dp+UJPFiAfw2pO9ZlY7yngKFOQ04Xr0yonHE+avDNO2qvESuJ3bxTEg==
X-Received: by 2002:a05:600c:4448:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-47773290517mr90700755e9.28.1762816319864;
        Mon, 10 Nov 2025 15:11:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47761c2fe2asm285284515e9.5.2025.11.10.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:11:59 -0800 (PST)
Date: Mon, 10 Nov 2025 23:11:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jesper Juhl <jesperjuhl76@gmail.com>, Alexander Aring
 <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Message-ID: <20251110231157.4ab7601b@pumpkin>
In-Reply-To: <20251110144232.3765169-2-nogunix@gmail.com>
References: <20251110144232.3765169-1-nogunix@gmail.com>
	<20251110144232.3765169-2-nogunix@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 23:42:31 +0900
Masaharu Noguchi <nogunix@gmail.com> wrote:

> Including <linux/fcntl.h> after libc headers such as stdio.h may leave
> the renameat2() flag macros defined to libc's values.  That leaks the
> wrong numbers into user space even though the kernel header tries to
> provide its own aliases.
> 
> Check whether AT_RENAME_* is already defined and whether the value
> matches what the uapi header expects.  If not, drop the old definition
> and replace it with the kernel one so the exported flags stay stable
> regardless of include order.
> 
> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  include/uapi/linux/fcntl.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 3741ea1b73d8..8b667550e44a 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -156,10 +156,23 @@
>   * as possible, so we can use them for generic bits in the future if necessary.
>   */
>  
> -/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags).
> + * stdio.h may define these differently, so check explicitly.
> + */
> +#if !defined(AT_RENAME_NOREPLACE) || AT_RENAME_NOREPLACE != 0x0001
> +#undef AT_RENAME_NOREPLACE

I deliberately left out the #undef so you'd get a compile-time error
if the values of the definitions differ.

	David

>  #define AT_RENAME_NOREPLACE	0x0001
> +#endif
> +
> +#if !defined(AT_RENAME_EXCHANGE) || AT_RENAME_EXCHANGE != 0x0002
> +#undef AT_RENAME_EXCHANGE
>  #define AT_RENAME_EXCHANGE	0x0002
> +#endif
> +
> +#if !defined(AT_RENAME_WHITEOUT) || AT_RENAME_WHITEOUT != 0x0004
> +#undef AT_RENAME_WHITEOUT
>  #define AT_RENAME_WHITEOUT	0x0004
> +#endif
>  
>  /* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for


