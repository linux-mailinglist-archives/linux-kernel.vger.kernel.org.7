Return-Path: <linux-kernel+bounces-891745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EEDC435E7
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D223B3191
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF0271A9A;
	Sat,  8 Nov 2025 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="xfEAr/A/"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C893C133;
	Sat,  8 Nov 2025 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643014; cv=none; b=H9+N6ji58oUmrpmsvXLqWluugJ2mXEX0ovb90ZwMo/5VU2t4pX1HyKTwI+R+BCZxjStDcrvzYyh1qBqyYupAVg+JoL7li2+B7PRRqsvYntjzUukMpRJ6/nG3DWuAllHtk/CVpfoMZQjvRjP5sEROPKvAqwgL7LNXJx+vVXmfrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643014; c=relaxed/simple;
	bh=HOXXcG0DOQ6i8z8mGkV7U3Uqmxb+tl0KJwK2RRX4cTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1DL4Oree24LSetTWydq92tzW3PN51suPJRhU35yNiQyffLzjonKK2bgq+3pTggWk9SfJICtY02BGVCqsapSgf0TGqQ5/VJpVSpYuy48yvMPA3cMj3us6qxqbzrNrhhKRCJgnUQ9PdkI7x427XUPdJtOzSl4ZxL1tCjYSF5K71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=xfEAr/A/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xOxL84IzQAnGWmEzxKZ7s9EYmDqVjiMJ7IRg3IPOgLU=; b=xfEAr/A/9PR4YKQulczA9cyBrA
	UfDyKKuqzcSTdIrbX62mEEpFyqayBgRTF6sehErK1laZZ057RbEPEwEtxXckwn7zcLsQs3szX0K0M
	NPxWmSglFgfV/fB6bO4/m7SWZAE4FASLgAuTlXDNvV0dDHs4ndQ6Ulhrh4S7/QmjQZdyE4E2mQfGf
	yec4Hu1glY2afIPBDL2rJjrZWMEA/NhxEJ5NJjMY/3pcVBjwG6ihwTNMPFd++ixcZq6jKkKGTpxoQ
	jun9YnW/bnerIyiP/1lemG6WU2lUSI6usenp8ZKQGIRSl74mwGtXX/2ZKJCSw3uHjsrscvk3GxQEV
	uA8KhSVQ==;
Date: Sun, 9 Nov 2025 00:03:09 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: Add FP9931/JD9930 driver
Message-ID: <20251109000309.20cb44e8@kemnade.info>
In-Reply-To: <20251108-nebulous-cheetah-of-prowess-964be6@kuoka>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
	<20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>
	<20251108-nebulous-cheetah-of-prowess-964be6@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 13:21:57 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> > +static struct i2c_driver fp9931_i2c_driver = {
> > +	.driver = {
> > +		   .name = "fp9931",
> > +		   .owner = THIS_MODULE,  
> 
> Please do not send us 12 year old code... Drop and runstandard tools
> (smatch, sparse, cocci) at minimum.

Yes, .owner gets handled automatically. And it should be detected by cocci.

To me it sounds like you are saying I would dig out 12 year old code
somewhere and send it totally unmodernized and unchecked. As a
device tree maintainer, you must have seen that I am using the newer unified
device property API and also other newer stuff and e.g. no
pm_runtime_mark_last_busy(). So just to make it clear to other maintainers
what they are dealing with, most of the stuff is new.

Most.. So the only exception might be the i2c_driver struct which was
copied/modified from an out-of-tree jd9930 driver including that strange
night mode. But nothing more, the rest is a rewrite.

Regards,
Andreas

