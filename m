Return-Path: <linux-kernel+bounces-733471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CBCB07515
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F19506D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8482F50AF;
	Wed, 16 Jul 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGFPT/Gk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964312F5098;
	Wed, 16 Jul 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666817; cv=none; b=reVe7J3YE2H/BBTO6CS6ZjPIe9Kc9uq9lYUwUMK4lGZ9qKAxQ1wojRz5mgS+lo1YvvGnR0t3QuSptIVBzYMT+Lxp4j0txH82w0pIak/eHtaHfqTFdlZkbiwxPrF2J+Vyp6uGfLCLoA55H+oVlaP3Z9dkbMNPJWYmIJwB+NCxZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666817; c=relaxed/simple;
	bh=Z/UmLfAfvDDN2pNeQi4tqkc4cBQJdv0CRL+ljKH1eHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnXJMvY3sLuZ+So52c/GNRt018NnCYfarv1VfNIoV+bZ72uQclV/TRl6Sl5jSXg4WKTgtO8bdauPtZvTSM3+ITV2dN018lKjOwpZ6b5dkb35i2DTxwxMjtryOodNTEO0wFbfK3Ia3SZNvm6BnlQTJa7S7rcjLgyj14K/+wy6G48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGFPT/Gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C9C4CEF6;
	Wed, 16 Jul 2025 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752666817;
	bh=Z/UmLfAfvDDN2pNeQi4tqkc4cBQJdv0CRL+ljKH1eHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGFPT/Gk9K4053/vzVZJiRD+loa8EtbUbNa4vXm0hUMZbTa613cTCmfa0mBUuN4a4
	 wp4GIdslqVaqfzs2thJ5UIuhhRG2D20vrF2+MHtCRmP4ZpEH03O+Y7A2XN2w8pmR82
	 kiPjkWpL2HIuK0aC2YNTlKtP6Bhk5C9RqzpWajGc=
Date: Wed, 16 Jul 2025 13:53:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc: arnd@arndb.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	luoyifan@cmss.chinamobile.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 2/3] eeprom: add driver for ST M24LR series RFID/NFC
 EEPROM chips
Message-ID: <2025071651-pushcart-scapegoat-6155@gregkh>
References: <20250706105311.395162-1-abd.masalkhi@gmail.com>
 <20250706105311.395162-3-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706105311.395162-3-abd.masalkhi@gmail.com>

On Sun, Jul 06, 2025 at 10:53:10AM +0000, Abd-Alrhman Masalkhi wrote:
> +/**
> + * m24lr_parse_le_value - Parse hex string and convert to little-endian binary
> + * @buf:	Input string buffer (hex format)
> + * @reg_size:	Size of the register in bytes (must be 1, 2, 4, or 8)
> + * @output:	Output buffer to store the value in little-endian format
> + *
> + * Converts a hexadecimal string to a numeric value of the given register size
> + * and writes it in little-endian byte order into the provided buffer.
> + *
> + * Return: 0 on success, or negative error code on failure
> + */
> +static __maybe_unused int m24lr_parse_le_value(const char *buf, u32 reg_size,
> +					       u8 *output)

Your __maybe_unused marker here hid the fact that it is NOT used
anywhere in this driver :(

Please remove this function as it's not needed.

thanks,

greg k-h

