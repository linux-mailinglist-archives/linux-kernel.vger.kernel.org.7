Return-Path: <linux-kernel+bounces-817131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C046B57E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463F71611FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A221D3F2;
	Mon, 15 Sep 2025 14:01:30 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF220B800
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944890; cv=none; b=dLAc4P8Rkq3xdtmrv40+QjGZTGf+J8PTL0ChLXLQNKCQxV/iWUfYQ0j0+3dMPX62fD3XsPVY3IZ0s64UgT0qOfTRLGtaKtfveB5q2GcnBYxtZYYRDHaY+1nzAGqN8hEPFFWSuif3AN8tQfpIIxCdHr9TMjkPg1K5pGNC2xbmRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944890; c=relaxed/simple;
	bh=1X0xIQxBX6yOVnBl/NmLb5h/aascqubss1dyNaB4NFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpe1+BhLk9qzo0pc7aLr4mWJH5jKN2GnGLVrjlGRv5YMKP31kmRjZ2tA/1FTP9HT40SUuYoWaErf3lHracttw+LelBEZK/0g7Ovpco3PTpVH/ndczGR9PKZ8lG2FMzOarHIGvKnUELk10GevyQdQLpTDM7TbKfjDIRbdOkhz3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04770a25f2so581856366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944886; x=1758549686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CySEvBWybAaoq23IN9w8eMXO84IhqV9JSNjs9ydP8qI=;
        b=bdlOJjjlIM45eLvSGCGFt/KGYjJ9CJ/QC+4d4LgeOK2UVkIpZMW3loo9WaR9CkzE/h
         5YLR52yAPJ45GPNGDmAp8KAXjV+9RfazRgA2f/d3cVP1U6GvxSrPtLjuPivB/l5mfV8+
         uWwlBePKYUCnc2jfKoQYjwJVLv6yf35SVcEDeBmlzB2xbPRuvGnRIPfBcw3Q7YBv2oBT
         I0woWI3AaN8QvEUdpAxp+cyiC//B31wm4MNRobIofJ0VZb1JP6afCt6sLFJJeHmiT0k6
         6zbkE24qn8Z3CQs52y9m3Q4r4/BkTetbWiafobr8LXNHd8O/eQD21Yo37N3iXi6qFvFV
         +kjw==
X-Forwarded-Encrypted: i=1; AJvYcCWzplSRnmgR5uvCrGVvxgku9ATCyO8Td5MCj3jXMFohKmy4mFlznSI/pSUlMneeO5QIQC4EVsqbUZdmQSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKsppOQTjoWkWOIP1vDy9w+V1fHxB8QAIa6lKOnwkUNZajTL1
	ftt0jndVFVWQaHS7ItxPt4C340JOvvGOifR2m0GaGXCoaU1/1q3RxMOf
X-Gm-Gg: ASbGncthhXlSpy2qhgxHv3pubAqhnCatlRck5kqb6V8bftp9hUNUHeUiVaOt3tz5SFB
	HzyTjvC79q2PFEEXhhdq5cTQacTztJYICKnu7t3pVaOrlPiXbB2EZET+ikjktL/CPs5/TXuAv16
	wiXnlk3nSvaoRVTbMFqI4H6/0bTIkt5gtPk7uuvTUlnZeI8hZAZJr4bIRGNBb4FnTVausA6Si48
	eTTJcyUUE0aUvrCHBS9Ft1hMwmAkoi+xKPXAUlNbflxUslxImmnxq3t5Ma/o0Tv50DScVN9xFeF
	ldEXsfMP04TOCloCQfelSddnk4y/PExdvcC3Xw1RjYP11rzFN2FCPQ0u6c3Oohhi4mPbBvIlaQ4
	sZJGOqBr9CPso
X-Google-Smtp-Source: AGHT+IGJHk97TkO3n1rni6eMyFEqSOB7kk0D7c63q8YCb+UW0rY8Zuk/D87SI6+ftSGqq5ZrrekSyQ==
X-Received: by 2002:a17:907:c09:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b07c384b024mr1274897766b.15.1757944881256;
        Mon, 15 Sep 2025 07:01:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b136ee12326sm90933666b.51.2025.09.15.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:01:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 07:01:17 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912121852.2666874-2-john.ogness@linutronix.de>

Hello John,

First of all, thanks for this patch.

On Fri, Sep 12, 2025 at 02:24:52PM +0206, John Ogness wrote:
> @@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
>  		if (!console_is_usable(con, flags, true))
>  			continue;
>  
> +		/*
> +		 * It is only allowed to use unsafe ->write_atomic() from
> +		 * nbcon_atomic_flush_unsafe().
> +		 */
> +		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
> +			continue;

What will happen with the "message" in this case? is it lost?	

Let me clarify I understand the patch. The .write_atomic callback are
called in two cases:

	1) Inside IRQ/NMI and scheduling context
	2) During panics.

In both cases, they go throught __nbcon_atomic_flush_pending_con(),
right?

Let's say that netconsole implements CON_NBCON_ATOMIC_UNSAFE. What will
happen with printks() inside IRQs (when the system is NOT panicking).
Are they coming through __nbcon_atomic_flush_pending() and will be
skipped?

Also, are these messages even deferred for later flush?

Thanks,
--breno

