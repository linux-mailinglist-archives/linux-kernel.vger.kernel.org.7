Return-Path: <linux-kernel+bounces-776814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF71B2D1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5EC52474B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488127C154;
	Wed, 20 Aug 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJYs5NyH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAA27B35D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655491; cv=none; b=rAjG7ci4/f9oQ76JEZjFtM/nmtABlzT09nTF2outWa1H/b8bhNjWrMK5eREXHw3KQ5WPlzSL3O9DdXATxjTDEnxAzhZmJ4vX/r9c12wx0q6B3ZSF+GAsV6hB/zWbGlf2JvRLyF/srJZEDyZu4LcIb9LiKvL3neHdt9/jz+V0Gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655491; c=relaxed/simple;
	bh=zEpVahfh535VfqbCsd1GZhquq+XM/4DWjCgCN7dt7yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB0A/ETyG8YQIq7I/qll8BNEIruRpY5wNeXVTuod53Y8X6BDfnUqD4Vdl5EtG9yOarivQUgQNLV1FQj4icB6q2JB157Ld0P4Brck0qBbyqm/HA8OLGBY5Q6xJjMdqeMVib3Tt6TpvoXIGTq0qKggVtaRCXyCNlFaHk17/c0TVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dJYs5NyH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso6338324a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755655489; x=1756260289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVU8t8SEuGg2Ydf4TYKXUzr0Gv6gJe9s60zdvfLEhYg=;
        b=dJYs5NyHxS03Ygxh0L2H2MNFT896tcRDXIrQT/8C1+FcaYLVKrz419/IilI7Oah9uQ
         k2wCRNmUObuDEt5MZT6PlN1Df3BskVzgeYV7JSifK3H0SfHIQU8Ap3hYVkIYcXmjmjLy
         MHmXRIpwp1MNJi43Ard5hwZrW+09nJb9ZyQHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755655489; x=1756260289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVU8t8SEuGg2Ydf4TYKXUzr0Gv6gJe9s60zdvfLEhYg=;
        b=o+eOjPaPShRHBr1G//rOoXiQU7go5SXZA7Ku9+Q0TpKwpvzLDqfHnCpeXJIDc5tshH
         OfVzJG177n4ljedPHh9k3+bHMtYPhMpWW8WiOrehe1M878Sy9wX/2H1cfAG24dRhiwBV
         XUl+pZYqIugUZHd8wx+g4TrWcUrhO0m7qW6TtNsMbSkc221ieWhXoDmB+uX7ShMABlA6
         ppwpnVtqbzFmQISMjcFCft9v6d1ZOn6Lyvpm+M28BfSqC8hN5O1PftfU4pm1MTjd+WHI
         8g1NJI5ApVY03SH1oydofGVkvaetEWFsqaRjbrt/3LGeas0km5TiZZbMTUXY/o8HLCsX
         AWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlYvSZIts9i73DwmeUX/hRSngQOTsRfZuynO9eZ5FeqzNBSvy0g+rCXhq0Yk7HKayf18uhpywpvw4T1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRNpU5bR3SsGa1WkHwBzaUx4/FEK/rqUlo2YvLHaFUOF8jG3g
	NcbF1HT+fRhaT6rWrrvheVH4QndZNYj9Uj+U3gJsPME1dwHg+sJz+96xxPgJeLa3pQ==
X-Gm-Gg: ASbGncsubACo31FtueZlDMhrRa1Q2GRW6l40OCHY8+O3wTRoR33mpffPlu1aOWkHOJ+
	vE2Ui1qwXz++Z4rFolJdEALXA2uYM5Ss5IpPBouI0Yki4wnM2jz9kUX6yL6ivMOZ65K4aMFYbaH
	fO2LkpS1Q3ths1At3856nS9HiohB29c9VntgU3ofmCCmbEqGtdriatWKNT7E9dvx/Ima/UkwpkK
	sYrAQgi6jNqE4S9+Am7uJ3I154hXXUWip84jUnRMx5fQwvgjNNgXhphRGTnbLUi/ppMOrmRK3/j
	gJeJzoWgbuozAtAsrQG1uvIq7aP2R2bBnzA7sdPkz8zX5JDCBOIYQ0tcM/zkW5RCG9NY2t6H6GC
	aww6R355cIv4HL9CRYFy35SkNSA==
X-Google-Smtp-Source: AGHT+IHxv8AzQbZlnNl7yEBNhn//58P8cBNzw6MHuveKMqkiuqUA2DnZVcHCsQ6yHpB+x73iCeJGzA==
X-Received: by 2002:a17:90b:3945:b0:321:81a7:775 with SMTP id 98e67ed59e1d1-324e142a186mr1457487a91.25.1755655489508;
        Tue, 19 Aug 2025 19:04:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3ff5:e488:6024:dadb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324d335c4f1sm1601815a91.11.2025.08.19.19.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 19:04:48 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:04:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
Message-ID: <afspavnfnnhyttvxmcgdl76jwpawqp7v7g7dd5bnjfc3vv3hg7@g3zey3r3zqc4>
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
 <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>

On (25/08/19 21:35), Rafael J. Wysocki wrote:
> On Thu, Jul 31, 2025 at 5:01 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Add dpm_all_cpu_backtrace module parameter which controls
> > all CPU backtrace dump before DPM panics the system.
> 
> This is exclusively about the DPM watchdog, so the module parameter
> name should reflect that.

I thought dpm in dpm_all_cpu_backtrace explains that.  Should
I rename it so something like dpm_watchdog_all_cpu_backtrace?
Any better suggestions?

> Also, it is not quite clear which module this is going to belong to,
> so a comment with this information would be helpful.

Ack, I'll add MODULE_PARM_DESC().

