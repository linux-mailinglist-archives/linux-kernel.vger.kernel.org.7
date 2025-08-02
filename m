Return-Path: <linux-kernel+bounces-754201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B8B18FAC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6550D17BBDE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432F20CCE5;
	Sat,  2 Aug 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huqXeC5n"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D31C862F;
	Sat,  2 Aug 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160563; cv=none; b=ZSBiEshLpBjrhWx6WCkCzZYYuZnfboVDyzEMqMANHbmVVOMMxrswY828PW6ckNO6HRM+DBH1/vZy4ZmlI76nJAvxXYqgD6FCEc+TPkVIY3tw7kZc3bYqaWNRKtDABEyjuRexSX6nqRx1kbX4Cwt/JjFLGu5HFPnoDQM+PwJEo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160563; c=relaxed/simple;
	bh=s0P5berMYelse87mDB/+lNi/1mHj8tllHqAs82sGYaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9aNnsAuf/k0b0l1w1KI9xKiMtH6OM5ziHrp/8QN+GwAGEvehSs4BIYgrfZNLucIHd9ppaJU62EzQWDYrl9tTNdF0VMThkq/dC00k4pclzgWEklvKXRO3Tmc7WBdFwikH6R3u41maljMh1ZOUvu2WVlbYiIuLNF+1i11mdVDBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huqXeC5n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so2169361a91.1;
        Sat, 02 Aug 2025 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754160561; x=1754765361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V76fjzPkvskv9qgsCSdkH8mO4HTCNhu/mdlmUxAEPMU=;
        b=huqXeC5n82+cmCmKzooX9qnkXwmhMFmIDMlHttglHb7ruRh0c3+NWPGgvWQyxE9ctU
         f/gEAcbqhT2Su7wjpuN/ngnZfopEbATss5FpmMAfH+3A5IuiEG02stYzZGmFu6jCdAA7
         +uk1BHCuyvWxomZ4JYB6/mJRZZp58F9CJgV4lrb77VxLIjYjlbUHuqcWyVUPLjWLz0gR
         99aTpovCxAfPfnFmWvOh/efqAzSKd/kEeJzerryA7iKvHLu0ES0rZHh3H4tmm170AY8s
         WWsM3ALOowRD+JrnQOSx9AWb693p3e5qaEskXNsbfFCaBefGkA7ZDgA4m5NStZiCjSPR
         UWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754160561; x=1754765361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V76fjzPkvskv9qgsCSdkH8mO4HTCNhu/mdlmUxAEPMU=;
        b=AtYUjC0FtekF8BsRRpHYg6dByfTsahUAfYJ7morD2DtzzQLdMHLgdPWvzmPHKshdf9
         vY52sP8495YaEOI+LZCB409S4VsKBqc9qJoVO5X+ARam/BWQP5L4jpQ/Lg0Q0TD9Eo9J
         i3YR5SAZ61ymGE5wTc3BvEKd5YsRmfkIErmXi+QVVmIh9HV0Gq0X02fN7uKN79fC9v/8
         B50iRMwrDqd1juV4MkJQg/1bXdQC0szi3jLZ93xDj+XyGyG70smPIeW7iE8g3baCZ5Q8
         53tUqQoq/DN5PD/huy0PIu0ivCfeklrd9XnoIRhN4q4Jl9uwZMI44YBI+zXgl61GO4ej
         NORQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/1FHnQJxAhbY9Kgq63bEn64tHJodLUj0h3mzGJOxgTAhGCp4dHgm+ZZno9JJLQd3VMSVIRgl9RoHGpEY=@vger.kernel.org, AJvYcCXSKMW09jKJcvuZG9zSV048b6SHjDc9oPyE+9QOM77KSp448VF1eIERl4spfAYtvV/CI5mhB+nqp81VN30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Vg4t59yj9UW4/I0bMS+tm/OVTD9BxCnN2rsdm1zbn7rNig4U
	z+O8k5OXZLYWedzobFM9eQ/k/RNnXmELxlsxgw0O9GKrB7WYPbEpmssyfdfuVQ==
X-Gm-Gg: ASbGncuD1HsqIclT8X8lT1gUtKSfhbWiPwSTqFf1fFm/oAwe8KRSujTT8dLfLY3BAtj
	0Ht0uKvmTEaK2V6Lpepx0gWdIJfyprL8HZe9oSCigKC1GuWLWL+aBmNVjM3ARpwWWYyiFbp1EMw
	+g2gBgKyy1BM0ParclZYretdLiVNmuv4/J0wy9Ix8FDFZYVdSozji/obe4/Xqjp4JgXnjgefeZN
	ML3yd9QoDQO6tOz+Kl/sS7EoaSWvSkiLSWSZ67XtzTwjqRXUDx/MnA//r+9KA6TkjX7bXdemMRR
	ZmQrVICcm0qgsjTjHwQhuT9xWmRdcs+c46nkAA8I9rFSHMqTXVd3ZbN7NGde9ooc1vov/9yH3vm
	JgW+Wunth
X-Google-Smtp-Source: AGHT+IHsNTv41yiCcwCpvkhJkRvK7GeMk+K4cCcYzLiIvzdGKOgIQvT/VlFZ5LRxJncQU7BNzttsgA==
X-Received: by 2002:a17:90b:1b0f:b0:321:2160:bf74 with SMTP id 98e67ed59e1d1-3212160c1e4mr2065372a91.1.1754160561231;
        Sat, 02 Aug 2025 11:49:21 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bd::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3209a84df4csm7690659a91.37.2025.08.02.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 11:49:20 -0700 (PDT)
Date: Sat, 2 Aug 2025 15:49:14 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: serifpersia <ramiserifpersia@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RSC PATCH] ALSA: usb-audio: Add support for TASCAM US-144MKII
Message-ID: <aI5dqrXk5C-JEQ9v@geday>
References: <CAF1NMdC2QouNLdgCFXmFhu5V4UVttGxF9VjL2KkkMeSthC_zJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1NMdC2QouNLdgCFXmFhu5V4UVttGxF9VjL2KkkMeSthC_zJA@mail.gmail.com>

On Sat, Aug 02, 2025 at 02:44:06PM +0200, serifpersia wrote:
> Hi there,
> 
>  This patch adds support for the TASCAM US-144MKII audio interface.
>  It also removes the current US-144MKII support from the us122l driver.
> 
>  I'm looking for feedback on this patch. This new driver supports USB
> 2 mode of operation - functional ALSA compatible interface,
> playback/capture and proprietary MIDI protocol implementation. In
> terms of performance the device does seem to function well enough with
> low latency parameters in JACK and ALSA.
> As for stability the latest version of the driver seems to be stable
> but further testing is needed to check paths of potential failure.

Hi Serif,

The first advice I would give you is fixing your MUA to not convert TABs
to Spaces.

> 
> Any type of feedback is appreciated even if its not merge material I
> would appreciate potential improvements that could be made even as an
> out of tree module.

Please just don't.

Make it out of tree I mean.

Thanks,
Geraldo Nascimento

