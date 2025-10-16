Return-Path: <linux-kernel+bounces-856629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECDBE4A47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE2319A4BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D732D7F7;
	Thu, 16 Oct 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn1e3UAc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076EF32BF24
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632889; cv=none; b=We0QTxri+yflCNC/+AtnmXmzF6U4dj5XAoIsdH1VAVHBgiwUGnH3y24JNIFsZiYl06BL5LsA4D7VCVJZz4kjoElCHynNYyJZErLoYFoFuD/SvFL68fw06hTjwCW/kB1XGfeiqsmVMkb8O/PuSdevZrINnytHlwUlOB2xn7K+s88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632889; c=relaxed/simple;
	bh=geONzcfOeXMyRbZUgBQXV9kWfbK6WvS2Ps7xuTXrr8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPYjhJuLSvLjzyWzJ9vgQM7lbPG2tY/4QljrRnEwkx1THIC6GMepkR0VsswfOd/5rjwq7p9fPwb2Xu+LAe7ZPtwyQHYnZ5LLhtGGG4U/Kc9f2hAg0vKSOlnestCJ9vQ+JwmnMCLUwbN+0wWfeJ7/FxOKmLiNHbw/6Hru4OWnOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn1e3UAc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471076f819bso7927915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632884; x=1761237684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WS/pSqoZp2v27HSdB+sPWCVXCPtRW0IR9akwGaRHrc0=;
        b=Rn1e3UAcceqdZLPCj7xirs25SErAhkI0Z3/7QMZ2CzJfuf9oUfthCWaby6nn5YFTRq
         FbO4BU69Meyy6NtzGWmPDOYPzZUI8EWE9gG2coolojtaJ3H9enNR3dSpF+n5ovX2A+Kj
         1UVRg50Qi3FydbLmjK/gl/Tl0hPU/m8PKvpIiuUj22Dwspiks0KdRkQf49DyF5NVd4Hx
         mbFCzJKnuo9okeUwTxBPsYASvSWWvyuyDjcyfqnjOEig9SGm9wmTrYSwZrNR9yxJL9/7
         OkIVRQQdUdWHiJBHBLbJ4XxkbHcoz8OeVPxaUK3Cz3HhxKWrGDye/Y9ZXVs1bNXxv4iH
         GFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632884; x=1761237684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS/pSqoZp2v27HSdB+sPWCVXCPtRW0IR9akwGaRHrc0=;
        b=h2IxzpBsWAGTgqVtL/p7467RxUnaj6hxTW1prvEDhwitIcvqUGw1cwBZ0VnylEtPGj
         odVVE8FB/ihh+41on6EWsO3w3kfCBv84vK3GNJXVQc1HtWGYihNBKyMF9zClPHpNcXC8
         H7XiPshVE2rfqO15PJGkcs3/vv+ZIy+wV/s04TTXymLkch0Y+XsPCkdVORr7CdSW4ATg
         EUgcrswFU9+pHGKfVm2zq6doecnmyttRLIpcV45y2P6ZEDtn6m6fZQBptNIFAaHo3zvy
         hNCM0NkETh/jfzyN3wb/szNEaLX8MVs53/TyRsgbgt2BSReKfy4hhHMP7HePlRviauJG
         /1Kw==
X-Gm-Message-State: AOJu0Yze2wKvTKtGGVE2vZUF+LGSIi4GEK5NoWbJVgI6HHaq32T7Giz2
	FeHwLJsYNDwIVM8FREm32s43xGKDupGqCJPttrVKmbtlacqvcsEkKhFL
X-Gm-Gg: ASbGncvsYuO0OhI/HFdYkwXAb5yoaMKcA5a82AvBBBVTl7Fl7L6poZG0IYjN++bR3Ku
	Pa9KMBUCuPu8LTMpmUZ/btrGEidV9bVrqpoBjkt1SlUcoxkWl9vDcIbZGFa1JevX7f85drI+szu
	SybwTylyT/m9X9f9VyXsRlRAXUPZl0BGxDmWnvEvzoDdlapARa4QYsrzIZZpkl7N+pHx+pR3A12
	Hc6Vw5cbmIRdD/wfIB95RVkpta9P3Mo2K736r4q7DAxeh8uY4v8DIRXnLPheY3TmZYVfslWJBLT
	V4/0tNv1KeTHIaMDo5DcKaIWtT73DdLwwSC4wcZdujXTk3L+FM9uLF/fZc6q9icnLcZ7EVkTPHq
	BwiDvRA88oHB7D0eKmtiqZcLGBRI5l3sRmIASLcCcSsWEK7yVc1+skFTDV45XxGnMMjDPZ1vKif
	v/H4k=
X-Google-Smtp-Source: AGHT+IEDdSyRLOyv2HtT637C+pSe9D5FqI1HRMQ2HeqdN+8/b+MPk1AnRD+MqeeBvqKRbrjLXNPXTw==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr5451505e9.26.1760632883993;
        Thu, 16 Oct 2025 09:41:23 -0700 (PDT)
Received: from gmail.com ([51.154.248.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c34sm40792995e9.10.2025.10.16.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:41:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:41:22 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] ipack: fix ipack.h kernel-doc warnings
Message-ID: <aPEgMkJnnK7SgCMR@gmail.com>
References: <20251016033543.1142049-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016033543.1142049-1-rdunlap@infradead.org>

On Wed, Oct 15, 2025 at 08:35:43PM -0700, Randy Dunlap wrote:
> Fix various kernel-doc warnings in ipack.h:
> 
>  - Remove an empty kernel-doc comment.
>  - Add 2 missing struct short descriptions.
>  - Fix a typo in a description.
>  - Add a missing struct field description.
>  - Add some missing Return descriptions.
>  - Clarify one function short description.
> 
> Warning: ../include/linux/ipack.h:73 Cannot find identifier on line:
>  */
> Warning: ../include/linux/ipack.h:74 Cannot find identifier on line:
> struct ipack_region {
> Warning: ../include/linux/ipack.h:75 Cannot find identifier on line:
>         phys_addr_t start;
> Warning: ../include/linux/ipack.h:76 Cannot find identifier on line:
>         size_t      size;
> Warning: ../include/linux/ipack.h:77 Cannot find identifier on line:
> };
> Warning: ../include/linux/ipack.h:78 Cannot find identifier on line:
> 
> Warning: ../include/linux/ipack.h:79 Cannot find identifier on line:
> /**
> Warning: ipack.h:80 missing initial short description on line:
>  *      struct ipack_device
> Warning: ipack.h:163 missing initial short description on line:
>  *      struct ipack_bus_device
> Warning: ipack.h:130 struct member 'id_table' not described in 'ipack_driver'
> Warning: ipack.h:189 No description found for return value of 'ipack_bus_register'
> Warning: ipack.h:194 No description found for return value of 'ipack_bus_unregister' ***
> Warning: ipack.h:202 No description found for return value of 'ipack_driver_register'
> Warning: ipack.h:221 No description found for return value of 'ipack_device_init'
> Warning: ipack.h:236 No description found for return value of 'ipack_device_add'
> Warning: ipack.h:271 No description found for return value of 'ipack_get_carrier'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: reformat patch description with indents (Vaibhav)
> 
> Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: industrypack-devel@lists.sourceforge.net
> ---
>  include/linux/ipack.h |   23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> --- linux-next-20251013.orig/include/linux/ipack.h
> +++ linux-next-20251013/include/linux/ipack.h
> @@ -70,15 +70,13 @@ enum ipack_space {
>  	IPACK_SPACE_COUNT,
>  };
>  
> -/**
> - */
>  struct ipack_region {
>  	phys_addr_t start;
>  	size_t      size;
>  };
>  
>  /**
> - *	struct ipack_device
> + *	struct ipack_device - subsystem representation of an IPack device
>   *
>   *	@slot: Slot where the device is plugged in the carrier board
>   *	@bus: ipack_bus_device where the device is plugged to.
> @@ -89,7 +87,7 @@ struct ipack_region {
>   *
>   * Warning: Direct access to mapped memory is possible but the endianness
>   * is not the same with PCI carrier or VME carrier. The endianness is managed
> - * by the carrier board throught bus->ops.
> + * by the carrier board through bus->ops.
>   */
>  struct ipack_device {
>  	unsigned int slot;
> @@ -124,6 +122,7 @@ struct ipack_driver_ops {
>   * struct ipack_driver -- Specific data to each ipack device driver
>   *
>   * @driver: Device driver kernel representation
> + * @id_table: Device ID table for this driver
>   * @ops:    Callbacks provided by the IPack device driver
>   */
>  struct ipack_driver {
> @@ -161,7 +160,7 @@ struct ipack_bus_ops {
>  };
>  
>  /**
> - *	struct ipack_bus_device
> + *	struct ipack_bus_device - IPack bus representation
>   *
>   *	@dev: pointer to carrier device
>   *	@slots: number of slots available
> @@ -185,6 +184,8 @@ struct ipack_bus_device {
>   *
>   * The carrier board device should call this function to register itself as
>   * available bus device in ipack.
> + *
> + * Return: %NULL on error or &struct ipack_bus_device on success
>   */
>  struct ipack_bus_device *ipack_bus_register(struct device *parent, int slots,
>  					    const struct ipack_bus_ops *ops,
> @@ -192,6 +193,8 @@ struct ipack_bus_device *ipack_bus_regis
>  
>  /**
>   *	ipack_bus_unregister -- unregister an ipack bus
> + *
> + *	Return: %0
>   */
>  int ipack_bus_unregister(struct ipack_bus_device *bus);
>  
> @@ -200,6 +203,8 @@ int ipack_bus_unregister(struct ipack_bu
>   *
>   * Called by a ipack driver to register itself as a driver
>   * that can manage ipack devices.
> + *
> + * Return: zero on success or error code on failure.
>   */
>  int ipack_driver_register(struct ipack_driver *edrv, struct module *owner,
>  			  const char *name);
> @@ -215,7 +220,7 @@ void ipack_driver_unregister(struct ipac
>   * function.  The rest of the fields will be allocated and populated
>   * during initalization.
>   *
> - * Return zero on success or error code on failure.
> + * Return: zero on success or error code on failure.
>   *
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use ipack_put_device() to give up the
> @@ -230,7 +235,7 @@ int ipack_device_init(struct ipack_devic
>   * Add a new IPack device. The call is done by the carrier driver
>   * after calling ipack_device_init().
>   *
> - * Return zero on success or error code on failure.
> + * Return: zero on success or error code on failure.
>   *
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use ipack_put_device() to give up the
> @@ -266,9 +271,11 @@ void ipack_put_device(struct ipack_devic
>  	 .device = (dev)
>  
>  /**
> - * ipack_get_carrier - it increase the carrier ref. counter of
> + * ipack_get_carrier - try to increase the carrier ref. counter of
>   *                     the carrier module
>   * @dev: mezzanine device which wants to get the carrier
> + *
> + * Return: true on success.
>   */
>  static inline int ipack_get_carrier(struct ipack_device *dev)
>  {

Hello Randy,

Thank you for your changes.

Acknowledged-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Hey Greg, could you please add this patch to your misc tree?

Thanks,
Vaibhav

