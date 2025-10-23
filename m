Return-Path: <linux-kernel+bounces-867070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD1C0184F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FA318932E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA05314A6A;
	Thu, 23 Oct 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="ZlVecIt1"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851743148C7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226792; cv=none; b=Fkn6fyE+9kN2zojkwxvWTlduvSMZprn7UQ+jZhTHJqANs1EiiiMgStmFQnAHLTOn5Wt6nWBn1ECiQ3YCgIaLgEq87IlpQcihqz27sQoVcf6rzyPXH55Nt176mDkO39uLtr+/cK3aQZR2JV4TFrhJB3qt0Z24vEjOjfofal4kOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226792; c=relaxed/simple;
	bh=VlZWQP2vRd5Et2IXN3Y2jcp3joaOd6hd/WT2Ydflim0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdceRJ0y4K/ATnmpOB0Fo0M0M2XjwUXOVIRINtvn0MPKLcnVaJ6uRVFycztDBZbk4B9iEpxFOsKXIi6P9wVe128g8QzkbpmwwYqn34u6VayfnAKq+Gr103yWiHRUXhDTJ6xiKa/HdX1Ew7jCoGLw6k+iXGjE4JFhT6Q7YmoeFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=ZlVecIt1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8923b2d9954so56352485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1761226789; x=1761831589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTdirufWMbJmlgZU7Yrv6nTsTJjgQ9dqEPOTcrYAzcQ=;
        b=ZlVecIt1Va3KLH2xbaLHmrQQIxECKYgoUf2jDlJZxy8YVi3leweiFOghBeFkCoofae
         bH0TOmoqf3fvT0+xJAJarpfPJ57PMPM4Dhe6dofB0JXc7a8OcUG2Un6bsSN+CTEBeXXl
         HqcKF08VnXs2nsdPVxKuJ2j8tRSEpuP3OcsmahZCPPLDJ8JUlIokljyy+kHOI4FpTlzN
         U9BD43Ey5Ntlv5DL3CsV9VuonKNE3hqMnX3vtlKJx6dD2pov1aSvrYCUg3uoEPLo2G77
         +iDf+BkLUbWGWgYPDL9TclwSQLPkuH94dz/J7q51pM2rZWKsSdj2sl0zoXiq+rl1sfAh
         b12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226789; x=1761831589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTdirufWMbJmlgZU7Yrv6nTsTJjgQ9dqEPOTcrYAzcQ=;
        b=sS2sGJ4xMqcbmY7sqGuX8ctJkfkBVOwU2PSd8vUK79GOV1TvRvDL2EbMwAWm0S6p9W
         aR+52OtPGUkBfEZeASulp+Y+eR/44pjgAnooTHASOh5GhG6I1l4QhGKhHu2Ft16BXPK9
         nUxs+ZJVVxx4R6h+glQcvUZjXUBuaeI/UsTOQ53mn9/113/xuMaPiBfN9StyLcv1JvKh
         k2aCqe9KyS7F9dzBTHG38aCNEu3jJwT6zrifSrPuaeVE84t1KW3rFQr+4z6xB+FZAFKb
         V1b6kiRfcSZW9Tg1WDJ1J2LCwZyI6gs6hqc2sUAAyuZirUm4B2+VB2cnP9mPsvIKBpjG
         QYEA==
X-Gm-Message-State: AOJu0YyeLLa6WD1zJzAXcxELcyyPOzKFAyuZ6ThKSoE+L9CGM0GyuK6w
	gWOUwx5932s9jA8Ifp+waWkAUQX89+95s5WLs4bM34daZ6w9QC8kwv4223KiI8FYpKnXV7/OHOi
	ekNk5kN8=
X-Gm-Gg: ASbGncvSSjs/asKmCJZn9tygbKiBdbfx4JoFwtfWtv1uOgK/IzGkjn9uM9rX8HcL00R
	n9ngf9UCNbkCMqhxzuzGwM0Rdgq8AsmVXh5YXc6R0K8SxPi6ngddWegzZlJmz6KLztww/mp2itI
	mLLeNfTwlbCsycxhLQLzKPYtpR4PSPOaq8+l6SgCLhpBNaBOdPqxZ3TF7BTQxjOIPjCuuocy49W
	X/XQ46Te8NfrpYAyBvfkUgR6AL2yJvl+MYLBKfON0hu078R0pVRpQMvFo44Yl/SNRYcGYTrMy7j
	HePfZJXkdy1/YEDdAn46ajsNYVt+5fogjocUFuWdt/6tvBrry4PgRAtpOS+G4tdjLP8VSeBtIkU
	2W8S7Hervd89g/7/vtr9ZMMgE92szSs/itFGLg8FJT52OeaOfWknuWo6H33phNbk//Hn4x3xRj3
	XbOAT9/r3og6u/jFknkN9FQHvBeIDDkg==
X-Google-Smtp-Source: AGHT+IHv+2FoyHtgNqF1DBafNAWsqVheVNr/d4qFGe2fvEd3Bm7iU47UHmaCg3qy/u+cwC/1tQZFTA==
X-Received: by 2002:a05:620a:2a0b:b0:892:dff8:2961 with SMTP id af79cd13be357-892dff8325amr2309221685a.50.1761226789166;
        Thu, 23 Oct 2025 06:39:49 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-89c0e97efa6sm160831585a.24.2025.10.23.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:39:48 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:39:47 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org, stable@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <ni6gdeax2itvzagwbqkw6oj5xsbx6vqsidop6cbj2oqneovjib@mrwzqakbla35>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>

On Thu, Oct 23, 2025 at 07:21:21AM +0000, Esben Haabendal wrote:
> On Thursday, 23 October 2025 at 06:45, Nick Bowler <nbowler@draconx.ca> wrote:
> 
> > After a stable kernel update, the hwclock command seems no longer
> > functional on my SPARC system with an ST M48T59Y-70PC1 RTC:
> > 
> > # hwclock
> > [...long delay...]
> 
> I assume this is 10 seconds long.

Yeah, about that.

> > hwclock: select() to /dev/rtc0 to wait for clock tick timed out
> 
> And this is 100% reproducible, or does it sometimes work and sometimes fail?

It fails every time.

> Are you using the util-linux hwclock command? Which version?

hwclock from util-linux 2.40.2

> Do you have CONFIG_RTC_INTF_DEV_UIE_EMUL enabled?

No, this option is not enabled.

> Can you run `hwclock --verbose`, both with and without the reverted commit,
> and send the output from that?

6.18-rc2 (broken):

  # hwclock --verbose
  hwclock from util-linux 2.40.2
  System Time: 1761226454.799573
  Trying to open: /dev/rtc0
  Using the rtc interface to the clock.
  Last drift adjustment done at 1657523820 seconds after 1969
  Last calibration done at 1657523820 seconds after 1969
  Hardware clock is on UTC time
  Assuming hardware clock is kept in UTC time.
  Waiting for clock tick...
  hwclock: select() to /dev/rtc0 to wait for clock tick timed out
  ...synchronization failed

6.18-rc2 w/ revert (working):

  # hwclock --verbose
  hwclock from util-linux 2.40.2
  System Time: 1761226685.238753
  Trying to open: /dev/rtc0
  Using the rtc interface to the clock.
  Last drift adjustment done at 1657523820 seconds after 1969
  Last calibration done at 1657523820 seconds after 1969
  Hardware clock is on UTC time
  Assuming hardware clock is kept in UTC time.
  Waiting for clock tick...
  ioctl(3, RTC_UIE_ON, 0): Input/output error
  Waiting in loop for time from /dev/rtc0 to change
  ...got clock tick
  Time read from Hardware Clock: 2025/10/23 13:38:06
  Hw clock time : 2025/10/23 13:38:06 = 1761226686 seconds since 1969
  Time since last adjustment is 103702866 seconds
  Calculated Hardware Clock drift is 0.000000 seconds
  2025-10-23 09:38:05.239100-04:00

Thanks,
  Nick

