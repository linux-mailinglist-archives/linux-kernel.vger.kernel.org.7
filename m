Return-Path: <linux-kernel+bounces-775939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0CB2C69B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B76F3ADD23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB4215F7D;
	Tue, 19 Aug 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="twNnSjrf"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E602EB850
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612425; cv=none; b=l40fPQt6B0daQuDLfksAItmLPJIGBhn/D/YcBw2mE4c+lUElX7xmEo+f8AtRZvSK8RSQos8mnfk1nqW0GeHLNDunvj9zc2pJK6ewkNsGVvh2tJwecbZFo7qJ5cRsyfabM8YULhonWv9PvmKnzlRfFM45wE2pDov7epn2moRe0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612425; c=relaxed/simple;
	bh=RBc+Mfrd5JZ5Shxaf+WcXhRVeM6ZXhVokwNykvbyHqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmA0RS0oR2V6qGU/0bBOhE467uqtk3fWCoZmVuG+XlEDVxUNxLPpzR5oj9HtGo3sIsr9k0WQxKFJKhL+LI6GuqNo2NqbAZa7grR4vfTYluR8ZAuy4Q8WMTUief2+LgRc3rEbhUvm2LshGT3jVst/a9Dt30R386J+GMkfXWpnlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=twNnSjrf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755612421;
	bh=RBc+Mfrd5JZ5Shxaf+WcXhRVeM6ZXhVokwNykvbyHqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twNnSjrfWq17jU6NnXmyUMffT6kGI2LHzFUy+Au1sVsd2GaS0Qi1WcXk/2dW548Oc
	 Onhq0TRPVrJnTaeVALtneZZZAI4T+5g9qBV+N7NYm1xY+pGs8d5yGss1AbZlRDiYWC
	 jS3xXVLtogW1/YcE7WB27b5sO7CRJ52gi1vosgHc=
Date: Tue, 19 Aug 2025 16:07:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] sysfs: attribute_group: enable const variants of
 is_visible()
Message-ID: <faf11932-3a09-4c26-b83e-fbe7bd5838f2@t-8ch.de>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-4-0d973ff46afc@weissschuh.net>
 <2025081957-promotion-shrivel-32cc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025081957-promotion-shrivel-32cc@gregkh>

On 2025-08-19 13:28:40+0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 11, 2025 at 11:14:30AM +0200, Thomas Weißschuh wrote:
> > When constifying instances of struct attribute, for consistency the
> > corresponding .is_visible() callback should be adapted, too.
> > Introduce a temporary transition mechanism until all callbacks are
> > converted.
> 
> I count about 600+ users of is_visible() now, how is that going to be
> converted?  It feels like a lot of churn/work, what's the plan here?

The idea was to convert one driver at a time to the const variants.
Adapting is_visible(), read(), write() and the group structs
together. And then submit these batched per subsystem.
It's not a purely mechanical change as the users may modify their
attributes.

It will be a lot of churn. is_visible() is not even the big one.

> These changes seem a lot more intrusive than the bin_attr ones :(

Indeed :-/


Thomas

