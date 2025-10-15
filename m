Return-Path: <linux-kernel+bounces-854401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCFBDE486
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7D6A5033B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9231E106;
	Wed, 15 Oct 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfvXEtfq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA933218A0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528139; cv=none; b=W+Ig0++q/vgIPF4X4DMKXnfPCjPqzKQF27PtyacroZiPV893TNxd1+cYfvq33dpU9/eQqAeeBlGakGOc1lMwuU6LTW+hGJfwuIIFXTmLz6h0UOoXmH4BvIlCipZfCqzr9mAwfyIPENYjqj2CSePgIoNWHkuHt1h+9CJiGWOHiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528139; c=relaxed/simple;
	bh=n3pLOKahYjMJJCUclZysCHneDAdftCnzhyeyqUJNPmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caYtPJL9t36ZnHArFYNx3MXU5n2lZQMvGWGfteOZXTunGQYJ1l9pK2t1YHSm8H1GEwpQJR/4I3dl5ECNNl03WMUNeCSAjMu6yHRFANKzkHIRuxnXwbrMBYlLqcb2eh21hf+wTWecKnaV9VnZnKpSSrVGlX3IDhoX/3vGMX5X8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfvXEtfq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so58916005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528135; x=1761132935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4S8dhRZbLBRGvpZL8rkoDs90jKJkdzwGYlmiWO4CnM=;
        b=PfvXEtfqn42okiJnGCMvNcMph9Xb7XvCczZQBWGNVJnkT7vJie3vz+TQcTCY1NUxsj
         Q0OmC/xIXZvhq2ELG8/3u8j9EXscasmhJOLgtqQ7RS/ZRukOP+QI8tm4QGD4ejjRgfm9
         VleoXfqvQLu3/OuXlf/nvxm7BSo8S7v0BcSodcNYPf6OfycK9VE+oSp+UznLZ6q47ROw
         Pr2XuvaYB4NS7eps6nHKYMxyL7/RaMA8uqJ3/orfyZLJIjtUTjwyYBQ2T4SqUrDdv42i
         J9QBsnMJ2bDKdQhpNBctvkIkycKPHhWYYb8g4kSGGNlhzArTO5T68S2yf3wt3C5px8Z1
         amWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528135; x=1761132935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4S8dhRZbLBRGvpZL8rkoDs90jKJkdzwGYlmiWO4CnM=;
        b=kv3A8svA8WC9sHNqQwAORk63zxedT5QrQoLKbDoxZMGGzcR0MNthPVNDuBdwRUBlN8
         NlLtDhYeGuV1IXmE43teNceqI2JMq72FlLMpRvP0+C3OnCoJGL8rVQuS1tjxaojuG7oO
         MdPSax6u1E/NlbmhzNNhfK9Zmw/fZhqbJaMzQKOLxMTgYdpzvulNpAisWfq72a65bQTE
         xdBL7zcYiC+wDO4QobSFRxiIAAR+vwAIMJfhyvkKNHc3Xis326p9dz2tbd2llhcHrcov
         3FKFLje7mC8nC1RB6NKJXNG/rs8CrJjl3mwNXlrvVdJ5PEk3mFZTGkW4g1uKA9brMdmy
         j6ng==
X-Gm-Message-State: AOJu0Yx0DYuBrzDG9bSBv/UFhpcH7v40lvkwFGBcdkLXO2Hanh+mKuoF
	BoHOWPPEIGc/EmRRj+kMIg2PoZCSVKMkkxBghaT3da5fgWFHhh4QX6Jm
X-Gm-Gg: ASbGncvW5JDwIITuEOYpDHYhP3oSO8bN/DfzUliPvL0l/mTTwXeEvRRQuIeqMj4GE0X
	6S+XnOXUoeJPRDgmfjhv7v3JimH/ZBaf5GowXY3A1wYGg1sLz+/sZcNy6gxngIYz4w6ZiNFNDzl
	1jE/un5kLxAKGUQVOxeB3JFwfZ3541/cMrhIfpVYhj+b957gg7n4zRDIwCETqj/5iLW5LaA6z3l
	1PKAA9SpCEhLOgXtmPxmobqxNNlLPlzGMTUBN4aopbUzUIhPQKJq8o8v68NtxOJPoBOgm3eTgPW
	KYcqfy4kb4s9uC3FGYGNiO5I5gdbVci7BGTMvbkOIKXD2HyyyjyGUR526eiiqaC5xDW2jdKlC0b
	ciw/0AIeX4Zil9oNOqJlnf9lpapKyMbukwdBA00Z9Y70=
X-Google-Smtp-Source: AGHT+IGaMN2PF63EoS8Jlv46vcIqoBqeAZ6YEcrN5CzWIHsf6N42NPswIkFUOdS5J95LBB9EvdvXQw==
X-Received: by 2002:a05:600c:529a:b0:46e:4c7c:5140 with SMTP id 5b1f17b1804b1-46fa9af30bfmr198337195e9.18.1760528134973;
        Wed, 15 Oct 2025 04:35:34 -0700 (PDT)
Received: from gmail.com ([51.154.248.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583335sm28246355f8f.18.2025.10.15.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:35:34 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:35:33 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipack: fix ipack.h kernel-doc warnings
Message-ID: <aO-HBfEOnqJJKb3t@gmail.com>
References: <20251014030026.759198-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014030026.759198-1-rdunlap@infradead.org>

On Mon, Oct 13, 2025 at 08:00:26PM -0700, Randy Dunlap wrote:
> Fix various kernel-doc warnings in ipack.h:
> 
> Remove an empty kernel-doc comment.
> Add 2 missing struct short descriptions.
> Fix a typo in a description.
> Add a missing struct field description.
> Add some missing Return descriptions.
> Clarify one function short description.

Hello Randy!

Thank you for your patch. Just a small comment regarding formatting.
The commit message would be more clear and easy to read if the points have
a small indentation and/or bullets. For ex:

"""
Fix various kernel-doc warnings in ipack.h:

 - Remove an empty kernel-doc comment.
 - Add 2 missing struct short descriptions.
 - ....

"""

regards,
Vaibhav

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

