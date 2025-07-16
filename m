Return-Path: <linux-kernel+bounces-733603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B071FB076D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244281AA27FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A10145348;
	Wed, 16 Jul 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wGtIGk6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470F1A727D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672228; cv=none; b=U/bNulMPzQH0ttOyGlA50bCpfmNrCoBlM6CJui1WgTzpAXIlRhoSrgUu6yZ+6fDSbS+nYGarivmWbjiGMTn1YvMXg4zvEKBPqf8AweYr6ge3XW4Qfyzwurt58t9VNmnSNiCEfjbcgS8u1HwVs3/I3otjCb60n9xi4gGP36BxllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672228; c=relaxed/simple;
	bh=y4uHY0nhoT4ms+izjjab0IZOtoJ6ED45m1o373tDFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD3uzLb9XpwrRSWz4jL6P74sQUZqNVfmcxeEOxwo5Uo5IP/TV7n3W9wDc6l73Wq6o4aR1c+kLrU7BkntGUNJUANK2FcDqzmssehLC8ElUGXOZ3uV2DW5eXtFI/9B+HKS4Pb1qRxtnW+RWm9Orf60rGMj4RMJZ6bf6izAv8pGw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wGtIGk6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDFFC4CEF4;
	Wed, 16 Jul 2025 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752672227;
	bh=y4uHY0nhoT4ms+izjjab0IZOtoJ6ED45m1o373tDFXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wGtIGk6n/XemCQ1odlP0xrP/8LByNUk5rA8auewYaSdebDKyvN0Sn0Y3aRR5OAr1E
	 c1n2E8xGA7sV3sx3GzRqoOcCxSnkMtMlWI6JXF6xjD0HGKnH+/51ItO58ZYRu1yQ/Z
	 PQFYNmNiAtyGSfcvdOJORjmKQf0XjpNwWY6PmwFg=
Date: Wed, 16 Jul 2025 15:23:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-devel@silabs.com, Alex Elder <elder@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [RFC 6/6] greybus: add class driver for Silabs Bluetooth
Message-ID: <2025071617-plant-daytime-582a@gregkh>
References: <20250705004036.3828-1-damien.riegel@silabs.com>
 <20250705004036.3828-7-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705004036.3828-7-damien.riegel@silabs.com>

On Fri, Jul 04, 2025 at 08:40:36PM -0400, Damien Riégel wrote:
> +#include <linux/greybus.h>
> +#include <linux/skbuff.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#define GREYBUS_VENDOR_SILABS	0xBEEF
> +#define GREYBUS_PRODUCT_EFX	0xCAFE

Nice vendor ids :)

We really should make a file for all of the current ones, to keep track
of them.  At the least, the vendor ids should be made unique.

Overall this looks very good, a clean and small driver.  Would you have
other ones for this type of transport layer?

thanks,

greg k-h

