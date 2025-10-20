Return-Path: <linux-kernel+bounces-860717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA308BF0C47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B19334F2A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8B2FB615;
	Mon, 20 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBeNtnzs"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96792F99BE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958754; cv=none; b=Iyhovrg2hUpXbS/FMrltRr1KEhnjCZfokmGVxopmoPowtG0ik6M7k21QYHnvokt1WZeH8pnhWX1SdpxKRPPkN21XKKAmM3GKxrv6zPdPmd33IM4gFR4ML+fQbEw9KPysBXgg1NUoDPNxiGoVIeVMdLwLlk66J3vATstU1OLmORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958754; c=relaxed/simple;
	bh=n+gvQT6Cp9atDtjg/KyYC4YYp+xamGrTEI0pAHgmHrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc7RpHeTn43X4mz0ttTGcQCt9AtkJSLDvdMUlGRhI7Jz30JSwIa1zuiTHipV49UH7EWzjlsr37N4Aiqrb89tb5QumdKLjedRFiPW1+ad5hN28YQJXWRmC2CAsdmhqIQhAA3IPvjSCasLk94rqeYFs/lw7NvGTO6p0kE+o2btnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBeNtnzs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e542196c7so33741015e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958751; x=1761563551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qwR6qWGPZt8aBWLxI/e6FP+u71DAbbOdbYMkZiZQiI=;
        b=HBeNtnzsbQbmHmaCR/CILC9wT+G6SXaODVblhZpYYVp+se9PjcVS4U4BYftf3RbGo/
         uDJB6PLxQnEZgdTHyErZ9xJmga4xhZPm7qdiR3rUTutnN0cMjmGEI015v6eueBIO3Y6N
         Mnyf25d2CgyFow3hRhLz4Oo3ysq0r0HP9AwHiNnzNrWDUn0792Q7i+0lC7psQ4+RLGwm
         05xpVSOLxhK4Wqdd8hBAL/dUolZeN7lwGo1DIbMazySRu52/NsoWvDQ4FV5alBgbyaed
         FV4xs8pIkzIOTO1H7FwMgsGowLaSVlKlsn0FpeTFaOvY4Yh3DUVqesO1QxejKhLMXzfS
         peDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958751; x=1761563551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qwR6qWGPZt8aBWLxI/e6FP+u71DAbbOdbYMkZiZQiI=;
        b=e0P2SECk5hnbxGVCwjMrmRMomT3E1xw97g1crlmHAISsREQJ4er4a3SvDkDOkbXamI
         IVaC9ncd+Ksiy4fXHJ3BoCLJdAWc/iRocv7P+QgNYWUsXQAYH+mBmWqnz0zlu9+XcN06
         bLN5oEtJNRXeYWm45qAUBP1KNahqVFrOJ6PZvpwzvLBxYgvi46mwsvY216o0RsYQqvGz
         FnCyXOS4LLwqK0w9slfuq22bGfC+D80JOTqMCEkvrf2DTGXXTV25Mo0NKPzpTB4P6Kcv
         l/Q1DNvs52imWtGl/Xr9Whj4LAU9e86NwEVLxQjx2IM68fURHDXqH6mTvDk0ZHtTxrAS
         2Vig==
X-Gm-Message-State: AOJu0YwGtN8Rd4p6sJH5rDpoIHJ9oAxPIrTQo/ZeaONyxSMws7DU+r0G
	QBrk6P+yfsHA90sC6KbrlE4j7UFN8uXCoVuCijQITKtCXbFr1mGRf30Z
X-Gm-Gg: ASbGncuwmUpVALkOMtliKjHp6RIeE0rY8uiC+gkprXpdFwXcHU2SSKCBDTTnW2LPU9G
	wg0Yk6Mf6cyBcam9bl0VFmiXUch2J90i4n690JeFv3XdZHLMBKXoB9T0kUoYPP56ne9ncL+/z7M
	WPzHDnjJcK9bm4uYqm0vsfg2Xc8l2plXHP+8C6u3NetZRoLjf6dJ7JlZs9RPgwZ2bxgGvHGu1NL
	dtESO2aWHSKE7sA0CtZdfxekNiFa8NxNSynsz2Lm87iWl9kSIHwEaOQe05XpQsqOEgJ0eb0+X+9
	A9nHMODa3n2Byu7RvWN06Hhr3SD2XpLkARsfDglM97fyhyP8SlJqMzDVjy3FAcCXx8plIv/NKcx
	eBvYZ4Lz4okQbirvrNzJiuWxTqfPfRigk3O9ylaoB34MWmACGnP+951N4HP1gZXLpoGlRmx/bYG
	o9s/c=
X-Google-Smtp-Source: AGHT+IF/EyA0TIzNac7W/+V2NGoOmFFFbqSmHi7kM1sTW+R8m65rZUTt98m3cX0WAgEihq9NbKzorQ==
X-Received: by 2002:a05:6000:2f83:b0:427:151:3da6 with SMTP id ffacd0b85a97d-42701514163mr10336952f8f.29.1760958751085;
        Mon, 20 Oct 2025 04:12:31 -0700 (PDT)
Received: from gmail.com ([51.154.251.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0ec2sm14645274f8f.3.2025.10.20.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:12:30 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:12:29 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] ipack: fix ipack.h kernel-doc warnings
Message-ID: <aPYZHYx90jqtkYp0@gmail.com>
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

