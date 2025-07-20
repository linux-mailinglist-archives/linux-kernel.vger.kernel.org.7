Return-Path: <linux-kernel+bounces-738196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363CDB0B5A8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C25C17AFBD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACB1F5423;
	Sun, 20 Jul 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="EznbldHq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE192BA36
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753012558; cv=none; b=mBnOZ+0GmTW8GJAkqgoCkbuMoo9cY11OEFne99C4AkNIitKXbZpI9bGlyL0nPPxU3y9x6zgEuQc5oFel3J95xymVhCuzafC3wGWkgJyUdTV0RoI/m1ixRExy+1xAG37tAeQxFqhNQSJWnKoKAhEWeECtsn5boP5wl7Y/Bss7cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753012558; c=relaxed/simple;
	bh=bqtLagOldK/7/rLLesSOOYtHy7Mg9Lw7Y7rhG6Cqw+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyjO2cQaHrG69TWaedxemhWu+7Goptdd5cNI5bGxM+BUmPlpWelRrkskOH6kxJtY/uGhqFV7YgkOeWUH4Vzk0/aFJOS20yD2/Her0ZEPFsb2Gujrrp5FL25vuWQ89dYNNwuKJB7J32RQJb2xrUB9HcXSCwDCSr+i1V3x40MtAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=EznbldHq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so19214635e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753012555; x=1753617355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekTGTFM7E4ZDOmzsJ2i/EMbwRasN0mNK3easuArwKgE=;
        b=EznbldHqYP5HWQbczWTXmBLbLJ61Ug8h1S10Ur+MfEC78ldGlwQCg0yprf7TMox8i7
         IFqqcXSTSpmtL1XX6YSC9HSdYBwMGKqIQ3doNJePVO0uwm+5KTZk/jQLd8Y/7zkUTFSy
         i/E7+5a+ufMd6EQ5c58bVZTg4Mmin9LjZSODz16wlxNs287fkAOoOMpoB/9owl/0mJUa
         PXGKyFHvctyGZ8RwqCRaVadawcVWwbNZ4P1TAmBehaMU5kjZzECDVLVGspAsfVkyQc4c
         mVIjSRPirpd3ruhdOD7zghkWPuS00Lp+EGnI82r9BUtoJeDVStaaAd9KweVadUKo8aOh
         Q/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753012555; x=1753617355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekTGTFM7E4ZDOmzsJ2i/EMbwRasN0mNK3easuArwKgE=;
        b=d40uh1avc9RC3dS1MpP+WSE/PF+EPBa7zaD1WABr4EJupYJl13HQu5QkyVcvY4UlT1
         qOvHmgjVm2duvJ7jsEvOn0xT0LL5D/SE9qECK53SO7Y5Zue6ArkZbIUSvcR2jExF67gX
         FbWnxt6qq1cyW+yDlTmW9fzNkpYRSK5Ip6PrDLQ8n8lqDTcMVHWH5fZXuBcvFidvwh8X
         JB9EcW+LmcEJoU3kNNMyXzi9lL5ji2mO85wVyXJGF/M0qBtBq2U1sl/+CueXrnSu9iG6
         eOQm+E2dGWuMm18GC+pYIOdJdWRd4mAq24qP58MgNfgtua3T6+N8xjyL0Jb0eyrzGIAF
         wGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0dcfn82IFmHKCj/dWXae+GkousrEK9E03lHpdyI80McVy3u9LscPCdfWOniCH8VWuY5kMhqThGJaikXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQC1MCvgCXO2hDF59g2QgkdLSHjE/rPDP2ua6xfXmHKjI/bpvA
	MOceIO2JckyjxMuYC7a6PNGoRRiVXAU1kuHM5+zh5A0TXSpV8EVdk0ByU5OTqevOmxA=
X-Gm-Gg: ASbGncs6A+Yl9rs31MtO75jMALL85jaWZVmzEbS7YIC6PyG4HEy/0bRciIckhd94vu2
	vyucFGHHsQmY+WuHzQqFjNS6dPBe2DeDNHXqAHFO0//I1Rm/y3+KZg9qNpIA2Fl47RI1ynsO9N7
	YY7ug3+eI5rg6OH1I4UyiJ0ZeZiTyg/31q364a2DWhgCnu66rHFzq+TBwK0g0lxZOaI9ZX3zVPW
	mv1JK+NPlyIwui2RvS8cOEgVZ4HbV5GwyNm0q7sdq4XIT7DdzJyBEoOL75PNXQ/rH2YKgDnD1vv
	XoxOi9K3XjnHWj265B3+TwOspYHrVn5qllIMRa1NJ61wDY8MxRzhR+TynTTEoltOL/2uwGBUInk
	s8jyYham9xu5Nuti910g4FE43HJ0wqYZQB0LtzxawecPnBcAu0vvZAVRTq7pbqpBQ00Q7VIN7sL
	DfDCgJ
X-Google-Smtp-Source: AGHT+IGGUFEr+7C/4OxnMXUzeaPEVFQDSDorVA0J5gtJQJrY0CrSSiN5h/kxV+Hu3G8D2M+DmNs7Dg==
X-Received: by 2002:a05:6000:40e1:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3b613e7763cmr10718325f8f.23.1753012555023;
        Sun, 20 Jul 2025 04:55:55 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb96sm7396721f8f.30.2025.07.20.04.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 04:55:54 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:55:52 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHzZSKqAJR9Wk7SX@equinox>
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

Hi Sergey,

Just to say, I haven't forgotten this :-) Have run a few tests with the
patch and so far looks all good. Still been unable to replicate the
specific issue though. Assuming my testing uncovers nothing else, I will
revert to Jens with fully crafted patch submission in next day or two.

Regards,
Phil

