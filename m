Return-Path: <linux-kernel+bounces-754522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB08B1955F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5511890F92
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7861FDA9E;
	Sun,  3 Aug 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbeipkHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321C12BF24;
	Sun,  3 Aug 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754254193; cv=none; b=T1LBRFM94zoLXTMOPU2+lqO4DapJFYjuemTZqoBPnYa117cAUQF4lQKMqC0MmjIN/uohfzZS8vvdCeVcsyADPGejWXXAHyiqII4JhFhEQxA6GHL09Pev2246PeXkqDs/AoQ0EUf9XVQ52y6osX2vXcpyIWs0b92kwhUgv2NVHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754254193; c=relaxed/simple;
	bh=+/0qRS6aQg0KQWft8omUpj97CimdWnULi88QIwZXViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVQXaSwMqKdvF2Onv/8vHcdhHN8xzj62HFgp9KZwUQJtJqYg/QMnZBpjb7UYW5sJY6Ikgbwxef/uOlGZrXyIFM0ezEKz0HAckU5xI6HTOO+XwISD71sZ1F3Kb5aBGVBSMqMoIvjbj9llsHzvSsh/lfKrrDgipgA76AQLJHQo15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbeipkHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6065FC4CEEB;
	Sun,  3 Aug 2025 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754254191;
	bh=+/0qRS6aQg0KQWft8omUpj97CimdWnULi88QIwZXViA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbeipkHs8FzsaH5S735GzA+S78xnf1b+AV2LhK55zxwV2vDtXhJDcWAycKwN9Eo4K
	 bFr9/Fz4FrlC4+zRsXNne4eAG2iVgD9y5K9k7py3eWXii4rEfy51jFL8akfY4nxJjy
	 0BKefzHDZFzrEkyTuCDSuuWhLa6LdBKD4AbAp0Gs=
Date: Sun, 3 Aug 2025 21:49:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?xaBlcmlm?= Rami <ramiserifpersia@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [RFC PATCH v3] ALSA: usb-audio: Add support for TASCAM US-144MKII
Message-ID: <2025080341-usher-tastiness-0507@gregkh>
References: <20250803203409.17005-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250803203409.17005-1-ramiserifpersia@gmail.com>

On Sun, Aug 03, 2025 at 10:34:09PM +0200, Šerif Rami wrote:
> +/**
> + * driver_version_show() - Sysfs attribute to display the driver version.
> + * @dev: Pointer to the device structure.
> + * @attr: Pointer to the device attribute structure.
> + * @buf: Buffer to write the version string into.
> + *
> + * This function is a sysfs callback that provides the current driver version
> + * string to user-space when the 'driver_version' attribute is read.
> + *
> + * Return: The number of bytes written to the buffer.
> + */
> +static ssize_t driver_version_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", DRIVER_VERSION);
> +}
> +static DEVICE_ATTR_RO(driver_version);

The driver version makes no sense when it is in the kernel tree, so this
can be removed.

Also, all sysfs files need to be documented in Documentation/ABI/

thanks,

greg k-h

