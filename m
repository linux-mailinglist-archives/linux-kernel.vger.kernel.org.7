Return-Path: <linux-kernel+bounces-817165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000EB57EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8C21646E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFEE31A578;
	Mon, 15 Sep 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rDOSHwbH"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B530ACF3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946000; cv=none; b=hXRX+4A59QBf809xjrN/45HGhJ3ZweRyjBwclZ6/V3rhVsgE+PqLSeks0s75UDmTc1pYRU0E7f9DGVvzwsEtdhgX3tgOWD+BXFYYugq2L13/SMRX0ct/VLc+KwFGJ7OZp3c3XUbIHql3zlVJC+v0MEWD6+ZbPleiuRZ1LYccSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946000; c=relaxed/simple;
	bh=zQ5QPRiVG3pjuad6CB2bBqliiABHFMuGHTERpYAq8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF3YcecQoYkVRLyD1A5Jw+G2+fvnVT86V2ocGHZtcKH25dkEbrI6j+P9DIc+u4ZGFzDSRkBNQBAjuerkFih5J8oOHHTDqwhCs9JP9T83x+tiNBZg8JEfMN7+X2vPC0Fqz7R/oExLgikrmJMBl20Zt58ABimhyYNF6HYd2xQlELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rDOSHwbH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-778d99112fbso23472286d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757945997; x=1758550797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ltJ3qWgJngyUcXpTPWVqY7F0iklIRp4Gy8Yg/l4qQg=;
        b=rDOSHwbHRD0It61GWPhOenfwvzv/HYS/UtOAUQzCShj4YPOoeWaJqSK74RB+vnrhil
         z28735lVxblFP3z9ppPP2ABidqs11aSN/a7SXybEtjm43kQZ8PgGrwf476Q5kh5zqs0y
         tb8730fOhqF18XPENjN6rjPkUFLsoMr5ZwCBDcz3+wvoDk2Iv4qwO8Difm2PHxfHg8ek
         Y7uVnui3kXtv7sFHLZf34QIGdlYkBQSPn/OwjI6cBJH1c8erjj6KD5mtPG7DPvasTnWO
         X4Ddhn8whIM/Wxg5/gA4xn+O+Od3kZqoL1shX1+jQowFKrz1hCURbBjTMGnxF2QVUjD5
         ndfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945997; x=1758550797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ltJ3qWgJngyUcXpTPWVqY7F0iklIRp4Gy8Yg/l4qQg=;
        b=gTKO5PjVLUr/VB1DQ4oP39FWS7f+0RxzFJurKt3mcBb6fZe482gHemtPEbrQWcEZ58
         CHH9vuSkYyB5IYv5Xxu3XuP85hGahRyhEhWcxRnzOngX+82i1golTkv5f6byOYnaUYqo
         UYdelxey7FKRVwOOOVou8iWxb5p906U57Zs7yJZUiHey9EmqQRblmilq3wleEBYN1B7a
         sAyuUsv92Zg5t0gqk3OX5uS73n3EhYDfNoWGn6aWMBIPgfsxTWG/+2x+2XJMhmtbzS88
         en8F8Z+GPYPbW0yuP1pMTWKZA5TRnbY+F/BdNJ7FxE3gGnOc/ZPr8ETB7uqobeo+WWdF
         NOeg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+j/HjhAeYeHfPgtKIIL7fK9tN7FhIh4vW6QxXpwuNXJyGvUotk5TadZ7O9D0PTaRcJ15qgjXLwnhYis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZq7HSXbSgzc3zYEPJQajrrszZ3SDVQ7DDXOkttDyNn369Wv3
	ljDlFvHVcqbla/XEkeLugdzmRNNTQJ1vMddkBUSxcU3eTpxlEu6qqwSiUm26U6IWcw==
X-Gm-Gg: ASbGnct+QHsltVoISqGrT/DR11bxSLFQUQnK2ntUgaDc7kCwZu2Tz/4eKjoV+T6YXvT
	4GY3+1BjV+cE0QQtzAhSUEOgzFKatIjkm5mZwjRS2lskkV2pjdtU0vQjGTGUdRI7O7PTz7ILp2o
	1SP3rdoyZBqHprouD6pP5BmchdGOou3p5hJq0EDIFQNjRxt0ziaJdCZrsXcjb+VWJNSDCECRpju
	DCjgfuHsyIsxyru5eCitRWpCQy3MtTQlqXwealni0iLcIGSCcjPz3zLYqRBGK0xJsthOCssN8Yj
	r8tmc6AEjYJ4YKbrkzRgJBAODGSdH8lGvDZRdcUykuej9Sldq6FzWGeTvwvzulAgW/cH9/en587
	VacZrEVZ6id1dGf/8fFVj/x1nXAllMvTzki4ZNYgtjkSupJtxwylo
X-Google-Smtp-Source: AGHT+IHNjl6+VXDq55mI2iLpt5yQHDG8LWznTFy16ycII1FKUcMN7wBwyIwufPTVyUH4m6LL8m4d2A==
X-Received: by 2002:a05:6214:2a4f:b0:70d:aefc:359f with SMTP id 6a1803df08f44-767c3771fc7mr157165606d6.48.1757945997437;
        Mon, 15 Sep 2025 07:19:57 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd36cfasm76812886d6.34.2025.09.15.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:19:56 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:19:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: mon: Make mon_bus::lock a raw spinlock
Message-ID: <4f7805f7-805a-4678-8844-c38a97650dda@rowland.harvard.edu>
References: <68c4cfc8.050a0220.2ff435.0369.GAE@google.com>
 <20250915012914.361334-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915012914.361334-1-lizhi.xu@windriver.com>

On Mon, Sep 15, 2025 at 09:29:13AM +0800, Lizhi Xu wrote:
> Interrupts are disabled before entering usb_hcd_giveback_urb().

This needs to be fixed in the usbip driver.  There is no need to change 
usbmon.

> A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
> acquired with disabled interrupts.
> 
> Make mon_bus::lock a raw spinlock so it can be used with interrupts disabled.

See commit 8d63c83d8eb9 ("USB: gadget: dummy-hcd: Fix locking bug in 
RT-enabled kernels") for an example of how to avoid disabling 
interrupts before calling usb_hcd_giveback_urb().

Alan Stern

