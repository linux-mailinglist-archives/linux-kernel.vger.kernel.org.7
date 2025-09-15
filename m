Return-Path: <linux-kernel+bounces-817891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA5AB5882F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0D21AA7EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7E2D2383;
	Mon, 15 Sep 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AnNF5SZK"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A427A93A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978670; cv=none; b=OhnD3JQr2rn6Ov92JQ8mTwp3lMtNk88GvW6oCrTYY/uADF1EpXKlNqNcLf9F0pd5PRiNEpsfA6FAOlE6FbtTm3kbljUr9FqHNXwGmZBeKgdijXh6toBKfnuMUv7AQsCjgiGLrINEYa9bYx3utVjiuF5BlFScruY7zhQ1X6JkZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978670; c=relaxed/simple;
	bh=GKwwThVWN55ZdhLn8yiXh6K4JxO9Mo/TQgLMtJNViiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgF+Y4eyM6GfUtZkK6+II+KmBBdhS+evs++aHGEG8Jody+Si5qxsF3ca2QJlbm0YuWqs8S5lxkkKJi2C/DULTzlYnTCeW4UevZqA3CmgSw4Qcw+AAi5WyOlsQB1Vh+n3dnidEfe5e7PwkZFIW042+CkuPeeCMcl7h0jp4+jIz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AnNF5SZK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32e372c413aso1353772a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757978668; x=1758583468; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7uiIeEfgdlPYTD6UL4WzVPf/Tll8ADDPeUkNnf2rCA=;
        b=AnNF5SZKv5v17asZT7KXmEVrj+c+cAHFNsqbOyyCckZn84Ou+TpsIyq9M5CNxXk9tp
         wozriOntYhSiUFCQX/n/vTLbuYa1UxAeDgBphC69+e90/WPfG5f9ttB/62oYoZQY8wIQ
         dFXRBNh5B8KDoHLupM0qQAHa1+etF8bgl1mJ2keogyskBZ/n+5OwdiFMhbXGJw/5YVks
         S9lZyMmR5QX176dS50qmD/ygPWC0tVguS33YcC4T1DUjl0lrLk5P8z/H96YhD6PAL8pn
         4FtAA667OE03xWx25OtDuFMjryLGR1dw2RQW1ytemeZGHlyQkpfZWg093TQRbI0MBXIc
         w20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757978668; x=1758583468;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7uiIeEfgdlPYTD6UL4WzVPf/Tll8ADDPeUkNnf2rCA=;
        b=w0B/MAZu5eMCU9V7n3+RnT7rjAsBVb9dlWv1WfIdagDpIhRkm0o2sDHzME9TXfIAlk
         TVFfkCr3ahE8ALRmB3ZyAdhrbBFK4iKoS4llIJR1lxY8Uzr7SEBXv0j1ErkkEzPD/I9J
         ApoWMlUoRBu/ZMdxdcoruWSnW2ji/9WvB55oBIMtVXzcGjEwDbKwpk1c1GGHfu9v1fmx
         U/x8r2Ee6ONxKTsdXl4IO8bUW1zRFUUacbsXAwsNNaGpW2p3LLVUyZdlX5iuD8ApzO6i
         u+4FhiSM+UvGI8nhAocHOhPdUvhABBBj/GdVgIhe0iUd3Jc8mp20khfGcqNIi5y/Bhph
         xe2g==
X-Forwarded-Encrypted: i=1; AJvYcCXxTWN+FS6b15phrVXoqHTvDlIrD/K1cnsO9hHF1/w754i0ggoF7n3yv+SxoW/wO+jNj5Q9bAIBzuvBA/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sxFxRku1yKUrdOrR3Mder8hEVWBlwhCMncGhJiwfSs5mvjms
	3bHuMBIeN97oi+ukb5qtC3N/wKesUjY/Vbzcjb7CBl8ouNkm3xydCRFieVlZfgoXI7E=
X-Gm-Gg: ASbGncvNJTHBPZwnHFwRxVibM+UziQgO+UidSO/Yut/f38bHxJl5ywAVX6OCe/mYKqc
	QXOmf+HtboIOwWK+B0NkZ5a/4LtdtvQHHIYWvf5TEuBdrOJ9B0T+sbiwFA7IazXyDFB1HTxSezo
	l2Q5JO6lxcYIxPOHzq4atKc9p6j2Ya02YQEZo92mLSgGm4k/Eaq2JwSwDFWBZS0ZI6KdYsyU8eV
	0v3HyARuLLKPeKkFrP/14RadnWVVpjHecyKEJD50cEGkP0V3mvTriNRr47e32G3ZopxdNrtqcN+
	N/mcJIMv/dmMaoKVzEz4wJ2xRpG/fCTplhM2p2TIUcPJt1Y69l/EsjsD0R4OiVSfdt/O4WbkP9I
	c68dYwefizkaN19vpPe9PJj98+cisGuM=
X-Google-Smtp-Source: AGHT+IHW+Ei25gxkyciUKrKbP1B/EsmDVjk/MF+hGzmjRjAtg2y1sc/2CYFiYtv3fYigvlxtLkhu6A==
X-Received: by 2002:a17:90b:49:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-32e528c62abmr7999389a91.24.1757978668587;
        Mon, 15 Sep 2025 16:24:28 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32df315f9dfsm11154777a91.21.2025.09.15.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:24:28 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep
 Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] ARM: convert from clk round_rate() to
 determine_rate()
In-Reply-To: <175797847576.2104956.7606973558357095186.b4-ty@baylibre.com>
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
 <175797847576.2104956.7606973558357095186.b4-ty@baylibre.com>
Date: Mon, 15 Sep 2025 16:24:27 -0700
Message-ID: <7hfrcn8fkk.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Hilman <khilman@baylibre.com> writes:

> On Thu, 10 Jul 2025 19:42:15 -0400, Brian Masney wrote:
>> The round_rate() clk ops is deprecated in the clk framework in favor
>> of the determine_rate() clk ops, so let's go ahead and convert the
>> drivers in the arm32 subsystem using the Coccinelle semantic patch
>> posted below. I did a few minor cosmetic cleanups of the code in a
>> few cases.
>> 
>> Coccinelle semantic patch:
>> 
>> [...]
>
> Applied, thanks!
>
> [1/3] ARM: OMAP1: clock: convert from round_rate() to determine_rate()
>       commit: e2c0510935c5485a2dacfd13af3958536b9d138b
> [2/3] ARM: OMAP2+: clock: convert from round_rate() to determine_rate()
>       commit: bb676996ed583464504123721195e98a708fbba9

I only toook the OMAP patches, Linus W. should take the mach-versatile
one as he's the maintainer for that platform.

Kevin

