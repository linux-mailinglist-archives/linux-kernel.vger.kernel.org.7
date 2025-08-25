Return-Path: <linux-kernel+bounces-785574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47373B34DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023EF3B29A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD028C039;
	Mon, 25 Aug 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFj3UJ7P"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0A284686
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156995; cv=none; b=DSgLjGTybLLhDWHhtc/Sq+xW3trBPa30bBjXSIi23l5wg/zWVc0uNBMSCkX8txKmxO/jDgDJUmXR8v4lU+3QHWQWWie1E71kSJvghLUD/1RYOJlvNH/3OFiH4oxwdUW1102JjH4nbADfGAZcpBtn8aEKDCJ07cdurGXdWAEhomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156995; c=relaxed/simple;
	bh=4OXIWFDbmsjTNOVEeTviCFRyDqi87Pwfjs4OZ1zbgRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEG2/4SLXzsm4jUIQNX9bz/7PDA+iVmV2BxXmFg8ypGWffkedPly383R8YZkvpGhBbC4ddU1UN31cDF76IS+48OOWDu95qjs9z7XzRF7nPxr0JRJborC/awx6gj6YtUuFYr1wpHasjGvlOi+gcJ1kNhXQSTfkp3uhummke1EDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QFj3UJ7P; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47052620a6so4235343a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756156993; x=1756761793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dzx0XjY9vsY3WPTYgS3aznsela6F6caCVVOco12uGc=;
        b=QFj3UJ7PC0Sc8a+DidbHYL+u3cimuDCOtTUo2pbM/y/Ty8IwOA7tXWR3FrSj+O0cO0
         GgzNZ/FqhyDNa3o1GzGVPgrdlhSFVLeyhjZ+dyVDkTzlY1C3BWPeQ24R/+uV6B26ZWXQ
         aC1X7Iq5O5+HbUZRnjUDGqEnRTemjeWCMEsj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156993; x=1756761793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dzx0XjY9vsY3WPTYgS3aznsela6F6caCVVOco12uGc=;
        b=nyQWxDoERxgNjZjOB13WICQUOSa246HgDMpA2Gl8O50QRzDLaElgl8iwiiwnvEA9Ki
         OP+701Xb0jyhmBD99gxUCasuXczb/vHB90aNcoaFBFj47x29hsbOm8eGxwvdBv+MciHD
         PE6ThxdAZfbu/Zn8nXxdZBKv59m8nhwlOLT/ylN+lO+Mgt9UJAfIRk6bWl3VoabsdcI8
         n0IUhxAwFn6bz61L+8DcaD/0L67WPSRjenFxX1rB5x5SaWHRe/S/VLGc0ITqwrUCtAYO
         ymuSOi04p6S3c9p0nF1uMfCTnr4/osbVErXb18mIpxQ8qGo0CUbdi7H0NMY8DHDDNoNG
         BSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGg0WgmK7gBid0DeWcbFxODrNOdXU2nYw3VFj5xWA8c5wQWCGLzFb/gNjICXTvDZhehwlElyhjdksfJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhKGCEn5EmIrJbqx2YN8STx8LRcESakDaIZor0n9NCK60c0HB
	J+JzYUQ/FM5+CN22Vhk34heI7ZtlaqfQyzFsd4AkpgU8A00P2WrfZBssf5sYbrdlo6WDzbxsK48
	uGNM=
X-Gm-Gg: ASbGncuirXQ9f6neKyoBfsOlEcc/ZKvtAiuYoCNISo1Ol+y+IpiremgRSYMLbmtjGAd
	WRfch4uDNOb0GzEco5frwkVh7H6vSLm/Wvah05vlkyK1IoAdwESP30trtOnbn8gnqPl5n2KAA9d
	B7/ftLkkVEaXN2SNLnnAdQW+Bwt+joXlxpfSyXduCYXCtFdaKeucZeBnFJIuwO2X0Ek0XBHcHKh
	burDi8mRe33m0f86PEnQ7Ic8dwF06BaD8HeoH2iADMCezMI7EpLFlsVnZcC4gFilhjoMfsgbRqu
	y6ZF9PM+sO36Uv5PBMZPaE8fzdZp5pWpY7vyfpDm1CEkLEAkg6JaZQyx66pZCcPGyA6FZ02169Q
	GR8U2JJ2hxCoFbOa8qgmKuUDvig4gs0lDdmhBaRb4brKfSvjmS8qRYjJmbA==
X-Google-Smtp-Source: AGHT+IGmkgFtAtj/Ymauo+0Tdh1f/Ud/J4FL/QJ2PJ95b+gCl03zI4mZwe6uIUaz5Rl7hLyNDRAOUg==
X-Received: by 2002:a17:90a:e70c:b0:31e:a8c4:c188 with SMTP id 98e67ed59e1d1-3273cc94815mr1011112a91.14.1756156992764;
        Mon, 25 Aug 2025 14:23:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:230e:95:218f:e216])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4c2eb5a0d8sm319239a12.55.2025.08.25.14.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:23:12 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:23:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Gow <davidgow@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
Message-ID: <aKzUP8TczQmuAEXU@google.com>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-5-briannorris@chromium.org>
 <CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com>

On Sat, Aug 23, 2025 at 02:59:26PM +0800, David Gow wrote:
> On Sat, 23 Aug 2025 at 03:01, Brian Norris <briannorris@chromium.org> wrote:
> > Notably, this also excludes ARCH=um from running any of these tests,
> > even though some of them might work.
> 
> I confess to being disappointed that we lose ARCH=um support with this
> -- it's nice to have it run on the "default" configuration -- but the
> correct way of solving this is probably to support SPARSE_IRQ on UML,
> which is probably more work than it's worth.

I made an educated guess on how to support SPARSE_IRQ for ARCH=um, and I
got something working here:

[PATCH] um: Support SPARSE_IRQ
http://lore.kernel.org/all/20250825212031.111027-1-briannorris@chromium.org

Brian

