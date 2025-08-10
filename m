Return-Path: <linux-kernel+bounces-761379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FDFB1F959
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8953B8014
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB2239E69;
	Sun, 10 Aug 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mta+/e0k"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406214884C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754814534; cv=none; b=Xn5eHKgM3uH9Cst09JfTQrHRqqFIGICv2aR6ejG2HAjfQJmFCT9bb3dPvLad+T+CgBaEkZk6UUJkZtld5Y/2YS1UBh1KmNiKt2BgZrSnFR2pVyfy9Ql/hm/6OG1ubkrGCz5w/09YtQSJ8RF4j/FXCReupKkql/zmfX6Rf6lTLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754814534; c=relaxed/simple;
	bh=IQSwkmeH1UjcasDSqZk70wzCB6MV6DlPS9NdlVUVefg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJP1cfMXIcK8WiTEESFAJJ4ABCaBwfpOjwG/Q4rBqaLYH7w5vrehRFMYyFAKLE5aKi14ltV22hRqFNyzuL8/GuA9SNKqtPyEKhRiqSMUh1BUg7xtr6aTw7xWSEKoYDD7ZSTFtIAeN3MH7eqPMobfAoOtGTqOLuaLGBaTw2nj1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Mta+/e0k; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754814525;
	bh=IQSwkmeH1UjcasDSqZk70wzCB6MV6DlPS9NdlVUVefg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mta+/e0kNt75MPEruWtWpt0AQCwZkPR4jXxlTNY/oBzeZj5+8n5MLuFlvXpyWHBzI
	 ur5BPQjQ+diJ9aosuWZuBVQB3rG6koGBO5CESLL7Mwwi4cnSot5zieC2p8bP2VGgRY
	 ZbyRF3E4OL63tGFbF95V+9aA5HS4ONtO3/ri5WSI=
Date: Sun, 10 Aug 2025 10:28:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Wake Liu <wakel@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
Message-ID: <fbb55063-ab03-40a9-80f4-4315d12239ba@t-8ch.de>
References: <20250805162153.952693-1-wakel@google.com>
 <87ikj0esnv.ffs@tglx>
 <CAOcRiAFzN61FE=By1ANB3aK4PKVTBQAzrCcfoHfHwMX7Qn8wYA@mail.gmail.com>
 <87wm7bbo3c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm7bbo3c.ffs@tglx>

Hi Wake,

On 2025-08-10 10:03:19+0200, Thomas Gleixner wrote:
> On Sat, Aug 09 2025 at 17:49, Wake Liu wrote:
> > long long timespec_sub(struct timespec a, struct timespec b)
> > {
> > long long ret = NSEC_PER_SEC * b.tv_sec + b.tv_nsec;
> >
> > ret -= NSEC_PER_SEC * a.tv_sec + a.tv_nsec;
> > return ret;
> > }

(...)

> And please make that an inline function and put it into a header file in
> the timer selftest directory, and replace _all_ copies of it in the
> various timer tests.

When you create that header file, please add a dedicated definition
of NSEC_PER_SEC to it. The selftests shouldn't be using internal kernel
headers in the first place. Especially not for a single, trivial constant.


Thomas

