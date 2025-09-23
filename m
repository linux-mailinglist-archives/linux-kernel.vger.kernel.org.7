Return-Path: <linux-kernel+bounces-828782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD30B95708
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A86419C032A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF924311C06;
	Tue, 23 Sep 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8F3tls9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMosvSrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B8145B3F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623488; cv=none; b=gnK2aw6qPEDPbhUgmedvvF1ZqxQk6P8tR5z3LOC+daKUKuTImd23BdxJo5YVCz3yJcXEtUoH9gDT3Ced7RYZRPurnPC91Plr9WL1ODUGxjcpPbW5AVIN69Ntwv489hLtyVc/qG77OiWTCrpH1jzmY3xN6/6MHuNjt6+nCKVHLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623488; c=relaxed/simple;
	bh=9RykSRjNIPj1NJvs2Rad+6KBv1vqbjkVtRCYtSyzNy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaZSY8Oy+lEAAm2y6yYxtNDnO/az3OERorPabHT06suvE/1uDpn2jw72qqvgkmcwE+d/LDe7GO1GsrpwiAHTTNesAiln4eXtLHiOn7aHLtLsI2GQvoFXJRsPgpbPJ/SwOi8BAhDPtisOEv7OyoRlkDm7sruPyjDkViDCOCWL+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8F3tls9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMosvSrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758623485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XK4ggrsm1Y/KLQHwA7VNv6tE3tPrWGSLBy7jITuyRV0=;
	b=H8F3tls9R6Fyb1WTtJEtq/g9vA5eBcsnV2gdBL1yyhGpXX+Z4oIs5EBMi9lSEq6ows8VjE
	J2igXydcFT7KR3TO75SZzGwW09JfNn4eZQDPdJdyqU77TsbdwAUs09V6r3QYFyKHPxOxot
	a1B3VEUL2Uc3zsz4kPgt1vxzW3tH8NWnkVBbVRIqoUe87hQENTIDoUrbDCmQ2mi6rqP3aq
	8BmxeAsU+EM7xLMOh8SHC8barqURn5IFWuJ5nyqsXolDZTfwpO9utTY7D0jJMAisUEsOe7
	3jHbNm60qlQR8AxTOZpB0XRZAny/4O2ZJKBjQ9e9HnFGsnKgUvVg9S7YeGaJIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758623485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XK4ggrsm1Y/KLQHwA7VNv6tE3tPrWGSLBy7jITuyRV0=;
	b=aMosvSrY5KixHWXoKbet8mQnqYfly6B3Pt9Ei2QkgQp7HjYTaciekhXPCQ4r2l2V7S2jRv
	Fjm3jL7/3OJfGLAg==
To: Thorsten Sperber <lists+debian@aero2k.de>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Cc: 1111027@bugs.debian.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
In-Reply-To: <60c824f2-667f-4957-bfe1-145a79e01ac5@aero2k.de>
References: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
 <2pdp3kq4qebdxizprbnaq6omh4dvxdlktokvr37b7nlkf4po3b@fxzmgmi47wxx>
 <60c824f2-667f-4957-bfe1-145a79e01ac5@aero2k.de>
Date: Tue, 23 Sep 2025 12:31:23 +0200
Message-ID: <87bjn14g04.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 22 2025 at 19:33, Thorsten Sperber wrote:
>
> thanks for your help. It's been four days now, I'd say above average
> (last was five days) - and no crash yet. I'm going to wait at least
> until the weekend before naming a winner, but that's already looking
> pretty good.

Thanks for trying.

I suggested to try intel_idle.max_cstate=2 because these unknown NMI
backtraces all originated from a MWAIT(C3).

Can you reboot into the working 6.1.y kernel at some point and check
which idle driver is used there?

    cat /sys/devices/system/cpu/cpuidle/current_driver

and which states are advertised:

    ls /sys/devices/system/cpu/cpu0/cpuidle/state

Thanks,

        tglx

