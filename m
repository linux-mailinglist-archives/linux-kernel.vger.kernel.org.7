Return-Path: <linux-kernel+bounces-852855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F38BDA1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B6421EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FE2FFDCB;
	Tue, 14 Oct 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OO13by7T"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB62FE04D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452740; cv=none; b=l6+ebHRWjcT5Uw4PDiIKIcAypgsBBAvogaVdg9/Hta0m3xUb094qXjiDjdeyWprfboXmNrhY3ZjAF7egqhvVJ4L4/q45AUargXv72zEHylJwHlYdq4UIqQtlUcx1uAHr4TpFfxfpdfqM8SXrUunO/OTLfuX1Cj5q3QYdBP+xARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452740; c=relaxed/simple;
	bh=+lA8Mt+EHgrMLq/lVHy/EezVen23glNVjt8UVaFDDWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi741XuNtxWPf2j/Iiu5vv3T8AiW5iQN5aFN4jApgUwYZzBgXxjj2vxz4fWDgeLyUule2RaTmfHG2B31/WLp1358KMU3tfAh/jb5LDUtewwkNiHLr+h6pFTcKFdVqq8MH7RfBA6d/0fFuyqw7T2y6EU7iKDM9E1AsclIvm8bKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OO13by7T; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8599c274188so649662585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760452737; x=1761057537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWhjAVgqvULnt1SIAQtWk8QOLU/mrjVdxdoH8SihPeI=;
        b=OO13by7TTbAkOSVZ8o6HD/ZO0Dvd8Bsh05AmZ5kqYBwWOHcfmkcXYJs6ooydm6OWQO
         lCym0MHdKmsx8YCItviUuaaEJtgF/EvskRDEC/3h6lgGMWgYkK6ZahoPyeoSd3JwPaCD
         fZGLtu/bVa5ABbHx0GveeJljpYthqoCrJ+OjGkihnycQqeNotJIhVzIA6WrbasgU03VZ
         1T8ITrRJ22hxq/g/14PrKl+K9WTY1EI28dE+3sUxHUhP6gGp/xV4H99+rio95A2DtOc5
         1TjpiJroRQKKCJTdAMiPHscVDjnU8CwDegE5fAdSkYf1t/pBGv/Cl/SXdSwsjqrGX6AL
         d11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452737; x=1761057537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWhjAVgqvULnt1SIAQtWk8QOLU/mrjVdxdoH8SihPeI=;
        b=ltZP/0pn7N0xFrGe1bLqCnr2wF7NN5RtlGH40d1qxHIxscp9L7tskQRxhw3COA6V3p
         8/DAzvvOW8bFI5OQn4dLu4eokJU6ZntOMvmSbJopScUFHlQt2seplnjHeXhrtHvamdse
         Oh3HYllBql1gKCtGgHQzxV6jkgXrpbDHfRIHsIIsnz/lhLWN5xn2BfJE35PnTdQ1aeF9
         D8WqSZdBgG374pfBrSels8HqEs+l/VF4WvGklexyxGt5ROCwmcGTq2Ifrt58naXTEjX9
         sJEloNIHT8Xr1YCdkD8FqhCp/jOqByP0H5cOYNG6F/X6PIcGs7JmttXpYGRTt9xKLSwe
         T1zA==
X-Forwarded-Encrypted: i=1; AJvYcCXWxjwgQExYRE6sfHqqm5jhZvIrg6qrdC6lD/aVUczNr3RFx8JFL0mXe5fZ5sLUUIhnwfoMZWaUdXgyVgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yKJoGrlkQuT/LWGgRYZOCpca1nQFbc9WCWLAsOTPvfrTVGno
	yTyy/s9MPjdXps2o1e2qbPCPFnz3BNmVyNwEroA5idyr8YTXyp9041jhtXdtZwZE/UOOXrgs2Wa
	hOGU=
X-Gm-Gg: ASbGncsccKG+pxWsZe7KreGTBi5DLEFSdApXH424qTKbCIKH6BZiEFRo4ICj5k/XBkY
	5YlOQGbMy3vHjdzg48tj9QmW5teZfrngM7J+cAH2IMyEzePrfAsDrlUsfZDNy7TB5Ks+HDrnrt3
	EAlrSz3mYjni9Z5wLZFGPxZKHPprsfbBGJcLOEYwiM17KHChnPbSuRED2PRXkhOe6KLIv/tiY5F
	1yp+Xc87yaODzwGna0UWvMwCH3pfyGPfGO9tAw7WZghb30zHDkqsi8SEvt/F8mREiMhyZXHOe1B
	/C8cjNYM4U222cNY+YNIuDnjqo9z5ay7hZhrJOG4CMxiDEDm/OBGd2Uc1D5FElPKbzVQRg1zL3D
	cUxSO9b1S4o1monQr20f45XopEplnpOMCub6ZaHpHVZOA3vEX2NiA9o2lABA=
X-Google-Smtp-Source: AGHT+IGBygP3S/eVZGhq+Z4O52XGF/oROuQabG5HPcatFlI636cBZeCajp072YpuYeGliTe6fMzyOw==
X-Received: by 2002:a05:622a:1208:b0:4e7:2064:bf2b with SMTP id d75a77b69052e-4e72064c0ffmr111676431cf.50.1760452736870;
        Tue, 14 Oct 2025 07:38:56 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::9c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345d4efsm93094746d6.4.2025.10.14.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:38:56 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:38:53 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	badhri@google.com, royluo@google.com, Thinh.Nguyen@synopsys.com,
	balbi@ti.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: udc: fix race condition in usb_del_gadget
Message-ID: <4c8e3538-23f9-4226-a6f6-18c84cc2f30d@rowland.harvard.edu>
References: <20251014085156.2651449-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014085156.2651449-1-hhhuuu@google.com>

On Tue, Oct 14, 2025 at 08:51:56AM +0000, Jimmy Hu wrote:
> A race condition during gadget teardown can lead to a use-after-free
> in usb_gadget_state_work(), as reported by KASAN:
> 
>   BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
>   Workqueue: events usb_gadget_state_work
> 
> The fundamental race occurs because a concurrent event (e.g., an
> interrupt) can call usb_gadget_set_state() and schedule gadget->work
> at any time during the cleanup process in usb_del_gadget().
> 
> Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
> device removal") attempted to fix this by moving flush_work() to after
> device_del(). However, this does not fully solve the race, as a new
> work item can still be scheduled *after* flush_work() completes but
> before the gadget's memory is freed, leading to the same use-after-free.
> 
> This patch fixes the race condition robustly by introducing a 'teardown'
> flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
> set during cleanup in usb_del_gadget() *before* calling flush_work() to
> prevent any new work from being scheduled once cleanup has commenced.
> The scheduling site, usb_gadget_set_state(), now checks this flag under
> the lock before queueing the work, thus safely closing the race window.
> 
> Changes in v2:
>   - Removed redundant inline comments as suggested by Alan Stern.
> 
> Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/udc/core.c | 17 ++++++++++++++++-
>  include/linux/usb/gadget.h    |  5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index d709e24c1fd4..66d2428835da 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1123,8 +1123,13 @@ static void usb_gadget_state_work(struct work_struct *work)
>  void usb_gadget_set_state(struct usb_gadget *gadget,
>  		enum usb_device_state state)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gadget->state_lock, flags);
>  	gadget->state = state;
> -	schedule_work(&gadget->work);
> +	if (!gadget->teardown)
> +		schedule_work(&gadget->work);
> +	spin_unlock_irqrestore(&gadget->state_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>  
> @@ -1357,6 +1362,8 @@ static void usb_udc_nop_release(struct device *dev)
>  void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
>  		void (*release)(struct device *dev))
>  {
> +	spin_lock_init(&gadget->state_lock);
> +	gadget->teardown = false;
>  	INIT_WORK(&gadget->work, usb_gadget_state_work);
>  	gadget->dev.parent = parent;
>  
> @@ -1531,6 +1538,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
>  void usb_del_gadget(struct usb_gadget *gadget)
>  {
>  	struct usb_udc *udc = gadget->udc;
> +	unsigned long flags;
>  
>  	if (!udc)
>  		return;
> @@ -1544,6 +1552,13 @@ void usb_del_gadget(struct usb_gadget *gadget)
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	sysfs_remove_link(&udc->dev.kobj, "gadget");
>  	device_del(&gadget->dev);
> +	/*
> +	 * Set the teardown flag before flushing the work to prevent new work
> +	 * from being scheduled while we are cleaning up.
> +	 */
> +	spin_lock_irqsave(&gadget->state_lock, flags);
> +	gadget->teardown = true;
> +	spin_unlock_irqrestore(&gadget->state_lock, flags);
>  	flush_work(&gadget->work);
>  	ida_free(&gadget_id_numbers, gadget->id_number);
>  	cancel_work_sync(&udc->vbus_work);
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 0f28c5512fcb..8b5e593f7966 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -351,6 +351,9 @@ struct usb_gadget_ops {
>   *	can handle. The UDC must support this and all slower speeds and lower
>   *	number of lanes.
>   * @state: the state we are now (attached, suspended, configured, etc)
> + * @state_lock: Spinlock protecting the `state` and `teardown` members.
> + * @teardown: True if the device is undergoing teardown, used to prevent
> + *	new work from being scheduled during cleanup.
>   * @name: Identifies the controller hardware type.  Used in diagnostics
>   *	and sometimes configuration.
>   * @dev: Driver model state for this abstract device.
> @@ -426,6 +429,8 @@ struct usb_gadget {
>  	enum usb_ssp_rate		max_ssp_rate;
>  
>  	enum usb_device_state		state;
> +	spinlock_t			state_lock;
> +	bool				teardown;
>  	const char			*name;
>  	struct device			dev;
>  	unsigned			isoch_delay;
> -- 
> 2.51.0.760.g7b8bcc2412-goog
> 

