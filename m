Return-Path: <linux-kernel+bounces-723161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE294AFE3D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1101C40CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFE283FF0;
	Wed,  9 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnzsc+UG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667A24291A;
	Wed,  9 Jul 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052611; cv=none; b=DtdVkAoJSenuDFHRX2WRzZBWzTweeJENmpqsMpgI09WyVaEaUSny2rckmlRipg0x9igiZakB2clJ791pXUNPZn5VMwJF4bQT9U81fv2f9RxiNJ7G7PZU7YQBnMnb00nzDuD+sVozRuGanuIUuTwYBqkXRjvYh2f0bAU/4oy1sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052611; c=relaxed/simple;
	bh=tpV7YA9mLr/NTkE5w9xEZCWQh4cVbdwc4D1eG5LV2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlCYIRlbG3jXHrbYSvmezMOxN/D04OgV+vx1AaE4NoFYkTc3pRgPkEatpCw4BkgyDZfik56eEIRbKDboCGUTGd/FyikemQKMqEHacguHxd3LTnTiZAW6aQFMYLxUJwRXCvn1fKWAPSQSzwLAnVgqRe1hqTNZOz7j27V6BQ7PCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnzsc+UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB457C4CEF5;
	Wed,  9 Jul 2025 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052611;
	bh=tpV7YA9mLr/NTkE5w9xEZCWQh4cVbdwc4D1eG5LV2XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gnzsc+UGSLuVdhJDd0Dqrd/QyyDKn/Cyha//l16jZA/FugUCs/qvDEUauXgZf9MLB
	 4ycq8B8oGkEXgsE4EtmLfdp8pOdXhhOtwhthnBs4HDKI4Ku3C5uUuIeLmjSBdlKYhC
	 kWHWzUPOuuV2WSGE0vhM1+4CniiTgF6Lz7bOkeRg33r+xFIccN344HZrrFIDWfvMDE
	 C6QWFp47Sprn2bsZTI2PGlMCmeeZMyCnSSYNxWmr+WLukBmg0/a9ld2rZ1yXCwA37T
	 7ZKfFNL0Oy7xarwSw+F7UiySC+SkUA5Vo4QyYDW6p5Fjd+DkM+kWwU1mty2+oXjgz+
	 6HADPpYsmAlxg==
Date: Wed, 9 Jul 2025 09:16:47 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dawid =?utf-8?Q?Nied=C5=BAwiecki?= <dawidn@google.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Subject: Re: [PATCH] platform/chrome: Add ChromeOS EC USB driver
Message-ID: <aG4zf8rGnmt5xVtG@google.com>
References: <20250624110028.409318-1-dawidn@google.com>
 <aF5N5jrRUlj3SUGS@google.com>
 <CAJ_BA_CppC58kc-Uv49PSmWFcCih-ySuGDuRcO5-AWQQqcqWVQ@mail.gmail.com>
 <aGOiu-sXFj1EUQAB@google.com>
 <CAJ_BA_CZWvC2=i8riNe5LReLKzPXK1vPwymiG2dzLEntda7TRg@mail.gmail.com>
 <aGSuS81Psqm_Ie4N@google.com>
 <CAJ_BA_BQOQe61r9t9rL=UiOqpHwOoTSbQcZNe=CrCcjMha_YQg@mail.gmail.com>
 <aGZrhe8Ku7eEIRqm@google.com>
 <CAJ_BA_AMaz0GWxOHJYws95h3fRdErghqUXPBkhrB1_eYegOJ0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ_BA_AMaz0GWxOHJYws95h3fRdErghqUXPBkhrB1_eYegOJ0A@mail.gmail.com>

On Fri, Jul 04, 2025 at 11:03:01AM +0200, Dawid Niedźwiecki wrote:
> > Given that:
> > - The crash you encountered is a common issue for all cros_ec_X drivers.
> > - I prefer to keep cros_ec_X drivers simple and similar rather than have
> >   something special (e.g. the memorized `struct cros_ec_device` in current
> >   cros_ec_usb) for fixing the crash.
> > Could you give [3] a try to see if it fixes the crash and also call
> > cros_ec_register()/cros_ec_unregister() everytime in the probe/disconnect?
> 
> I agree that the drivers should be simple and similar as much as possible.
> But to be precise, I think, it should behave in a similar way as much
> as possible
> (e.g. reboot EC device doesn't cause re-registering), not be implemented in the
> same way. That's why I believe the current implementation of the drivers follows
> the already present drivers in a better way.

FWIW: It depends on the bus details.  If you find my previous message, SCP
over RPMSG also re-registers everytime after the firmware reboot.

One challenge for current version: it makes the driver more complicated than
others.  E.g. what would be happening if some friend drivers try to access
`ec_dev` while the `cros_ec_usb_probe` is writing to `ec_usb` at a time?
It tries to manage the device's lifecycle one level upper than USB (don't
know what it should call, "session"?).

Another challenge: it doesn't call cros_ec_unregister() in its driver removal
entry.  What would be happening if someone re-inserts the module multiple
times?

