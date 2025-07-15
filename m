Return-Path: <linux-kernel+bounces-732572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFDB068DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335ED7A382B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5B2C1592;
	Tue, 15 Jul 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="eGjwOSiJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41927511F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616524; cv=none; b=lf6w83d/6TF4vaM95SPUBgrovzQTk0yH1ziLXTfeOPZQf8nbupRjPF5XvvnmyEQejARTZk42x0RvZRFYcx1fLP2Bm3Zzz+dpSFkbteFaUbzkjMR7/SWZlO6EEdn4u7ILnoI+tuyKqJsKJXxFQXNdeV1kPu3xycDLyOJEZOKK/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616524; c=relaxed/simple;
	bh=uSa2VfNIC2bUvG4Euf/Cfaqx0rIPulEfsctVWLSShMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPhc0/LIuVsYvvN/6NlKlJYKO1qdaUorHX8PUN+lvUpIfb0OQ5tfKozs8O6BXwt4zdN8WIJJ2no5ls+uNZ4jcmbSs3dxRjxxvd29c7xGPyvOJeUEUrcG4vq+ubfAhwEXCZpLi4nt4gKPtla/+AFOHW6+YG3FZvNrPSL+h8fnnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=eGjwOSiJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so43539485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1752616521; x=1753221321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYqbfvHtl3I2Hgu1RhHFaGq587PWx3usXypktcWVEN8=;
        b=eGjwOSiJjTlzmRTNFYM9EIU0SfrbrQF6qcu5eZMrnzy00W2SvLcfZVSoXdbX67rlds
         vbxX2359jePX6DES7qFkXVNJOw1ONCWbJpeZaRUlqeRjE91WkRHGz4BrrAQkDAvvcLIf
         lFrTxnFBfteRTRNQBwhZHFm8VRY3nNWYOC3q4ZKKIszBc8hbPYHRtkHy8aUAl6w414zj
         iOnOS0PzNmQo5y96IdQpJ2ZHhuzIK3B0qEevNhyRkq2wLwgLO3oGW5wq2QkAOL5LIFPm
         Ah9CqAW58As4li/twWuTWp9vF609DLuRvk5uarX02VE5P++ouzapYUJ9y8HJZx5Z6u2z
         thsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616521; x=1753221321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYqbfvHtl3I2Hgu1RhHFaGq587PWx3usXypktcWVEN8=;
        b=gXog6sgbFHZGcLqM8My0DOYzpuVo1r/V5LGSk+LEJF7OMa09S35ZbRFHTiXiRrhhX5
         /l6EbPYrkHBZFZ+LgNIsKl8RrhXD96+lGuvS5GkvX5AGu4BPJ39p+EN/HAIEzoun00fL
         cQu9Uv8KrDwl7K1228ZCLkkf/bCDx10SA/CA4S9YqEWwAm3BAxRSZdMFGk3gIlF+MiHx
         vBQhH62rNeTFmFGV1xMT/HlUtWGcXmWXvkVlkTQmOotsf3wI43Xmos6Ud1CQszTcQaQn
         SywDE4kSqKTfK6LUJn4f3TgSfvz+NjtDcWZxxtGiGZwyi3jO7jokNIHp6frE8SIbjThB
         AA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWR63vsOU7mhBLlwvcKzRdxu2yGfgEbX5DQDhyMyl3qrdI6JU25OTabQz+iVr8hWCwDI2o2acYH9xoNkzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIVv/D/+2RQ/7pN5V2MopUMV6pFnz/GPFNQYHl4URFJMJ7Kxg
	OQDQX1YTsWiZKpTNQsrOgqqCOF3Rkf4ZgRQpEkN3AME0+Az1jwAFQM5bROZi9milnKI=
X-Gm-Gg: ASbGncuUxeOFJzaJKD2dsW/zy0G3hPFuajbOteGHPEPf3o+RCeH1UMur29+8Ci1fevk
	rpJVXX1QsqG5GITlzKKnXeI/4FGFo9IIECbCd9pG85rBXTPF7rKPqZbhted1r6glWpL9uPlgUUM
	eCwWEMzrmdT2X6zOQJzs8WuLhIvnOQBZ2GAyYHYNimsuH8lqI1SILuq4A4+zGx7qbqHe5BxmWos
	CZcgNMcOzxDopk3YGmU3If8QKYVHq58Dwr8rcs6XrBXCQ0BpHBqZtxrz2kUv/A/yTLlRv2y1Wx6
	S28+Wq28reAhuG+DBnYec4+Ds9zTdTfCzaCMm2umqoSoKmMJi0eKUzrHkT5H1XVMvYsp+pGPRjz
	hHCoqcgmY28ocbntXbMi9DKoghW2h2hMhREXeI+NqxJHr0tS5YMC+91xaFqIe93kvSp7izoW9y2
	S3CxYG+PGKP06jJpk=
X-Google-Smtp-Source: AGHT+IFTidfwH97rQ2023GFUBHQgO95HSIPTMN85e2HJPZK6py5Yrf+Wy4WLqy1eMhf9ap/5fowLyg==
X-Received: by 2002:a05:600c:314f:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4562e349e37mr3129455e9.7.1752616521053;
        Tue, 15 Jul 2025 14:55:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1932sm16383685f8f.17.2025.07.15.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:55:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:55:19 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Phillip Potter <phil@philpotter.co.uk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHbOR4IANvJWfG-L@equinox>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
 <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>

On Tue, Jul 15, 2025 at 12:32:22PM +0900, Sergey Senozhatsky wrote:
> On (25/07/14 08:22), Jens Axboe wrote:
> > This just looks totally broken, the cdrom layer trying to issue block
> > layer commands at exit time. Perhaps something like the below (utterly
> > untested) patch would be an improvement. Also gets rid of the silly
> > ->exit() hook which exists just for mrw.
> 
> I don't have a CD/DVD drive to test this, but from what I can tell
> the patch looks good to me.  Thanks for taking a look!

So thus far I've not been able to reproduce this. I've just ordered some
more rewritable discs though, so once they arrive I will produce some
proper sample discs and attempt to get it to crash again.

I will also run Jens's patch too with one of these discs to verify things
continue to work (and indeed that it improves things in the event I can
reproduce, which I'm sure it would).

Regards,
Phil

