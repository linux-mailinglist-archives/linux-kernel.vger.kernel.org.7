Return-Path: <linux-kernel+bounces-850551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F9BD3281
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275441886180
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6328C874;
	Mon, 13 Oct 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ddAv/zcx"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62023D7ED
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361395; cv=none; b=Izx4nEDy4Dsb/v2u8wc7XUmReOZIBBnC4uu/jY8pQiNdoSGczJ5WiuCcy2tnqHzP2cWjui4q4cez4P//w0TbLNglFX/10Dvm8QHiIEqOiy867fogiu1hejpNgCvHDrIi2IxuEKj/yZQFxnCOLOCcPbRa3LSMYaCGTOkhutl65Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361395; c=relaxed/simple;
	bh=6LwevomWCksbvPw5zxzgKJ0rn361gs1colI8667FE8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgY2/BBza8tNTZRL/Shuvav0OC1xgzncyI8ZWdK6wx5i83fm+wvcHyM/6spdk8/+WdIgS8EPdi2UbLUNbZXXYFluek9QvLsHXA13wZaJXmNbJnnzjyO5TRXXhx4d50w6yQoT7f0MHCH0RXt4oo/GsFEtxt4CyA/naTyZ6NNv4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ddAv/zcx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7e3148a8928so52252206d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760361392; x=1760966192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bSnM1zzOjn0R4lX0zxJUOJFBs8bOrPyVKb1PDpbaf8=;
        b=ddAv/zcx40upFuZuHn/A0REoNwjI81ga2fVEeU2+Nst5bhX+Vsyym+yL/sMxtATvT+
         GxSQ3xRWHIRlQleXoFJS2LmB89/kgPRRnZ1z45sc9Jii/G3+nqqYS8M9a1B3Nlq0yvW0
         EQ6fMXNf+PqGSUa5r6JcRSjs8eyslLcQU5hwYFOiRoAMHt2s5XXSkeXwGckUFA8LkI0M
         Q7PmlibDHEL5GIG+q8iMmQfxSixyGBjljwyMKBgeRnc2SAQ0mUmQUa2/4VU7omuSTqnl
         uduhZeQcB2VTr2k8+C73tpmVlu1hMxoJU+sSp9jJbA0Yuc0zCQlv198VJV7t3l2RnRTN
         7iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361392; x=1760966192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bSnM1zzOjn0R4lX0zxJUOJFBs8bOrPyVKb1PDpbaf8=;
        b=A1WkfnwSKx25anFp7O0gaTsowhvrCv8dbrk5uBKyr5NufOvQpspMvoKqsYTdzlIGpw
         IHZKDcE7DYCMl78Qfn5VVUiZkgBKkd8rTdwua09pZbYHSSOWSjTx+iZBBfhhtn1uu2Yk
         wpVcZOexf1RwM3IHBDGiVTQcL7utzCmCZNW+907lvhnuEKu7RaSRIq/Donmg7htxoJXT
         kWk5AM2DJDbd7ge/TKT7td0ikEz21GEhwdBTU/vC5NhQwOiv0aZqiKZ/KiPKbMzLywZk
         FDAyyw/AZOOSbnsPsuIo8r9/xgmU8M//n9Rfkx+oajnoTZ4Kg5fyfVMxE98KqHjNKTg3
         ESsw==
X-Forwarded-Encrypted: i=1; AJvYcCUXhszGwuFUdl3ynw0RX+6Cr0lshgqGJN3RbCXqkT+CEY8uCpYMkfOc0pDHrt5lqo/05EFC/cNXAbDw6ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RU/wq3eXIF5Y8ixqoeij14u4P1+C6UtMFYkCDTI28JJR4gY2
	uXRGmzftetZfDBsrZ9a+5z1BmyJQxr0oSgvumHuIRD9VKdgv4ax9jRn+ovtBxI8Ppx0SREwpf3X
	OShk=
X-Gm-Gg: ASbGncvTXqDBaLRj1LyloM3L2lHGuKmFqWrSrg6c2LRlEElKt2NoqTAXdVPBKANKHv6
	BKZQToYvENvOqoo/MPHyw4Ggj7/9BZAPFK0Xts2Xy+mt4eAZvwFK/7x39n7w2QegfjDdiLaOHm0
	2rP1Gx+Ntr0PKX99doCjcd1OUY5dGnyjBL+QKkhZpHsXfEDfEEOppDCGcBzEN6Q4a+O6dHlOZm3
	pT+HFQ+KKxg3jKIFSr8GMCranviUV3TKffQmKXeMlHzwS5KXA5QPi/U87mK5WV8ztocZXBZsIjR
	IM8kRsHYGOAIVcw1XEJ5fXDaBDwcOaahqdPMcFWX25h1Y4nn0L8gtX1nGQr87xjFYc8JNbSPKU4
	UpZfy6NikHC+bdcRcsk2AfqjruGHWYew+pE4LY0whwWMXL6lBlw==
X-Google-Smtp-Source: AGHT+IH8zyaxI27rVjNd4e3LoVIDALG3OGnNtJloQCfAqB0TMxZmw9IeaHLbnZ6+owcuuM+JIhRxtw==
X-Received: by 2002:a05:6214:416:b0:7f1:62a9:ea2f with SMTP id 6a1803df08f44-87b2ef941eemr285584636d6.52.1760361392115;
        Mon, 13 Oct 2025 06:16:32 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::20b3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345b893sm71760936d6.3.2025.10.13.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:16:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:16:28 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: core: Centralize device state update logic
Message-ID: <24db7c90-16d6-4122-8bda-aee2a2c930bf@rowland.harvard.edu>
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
 <20251013-usbcore-tracing-v1-1-b885a3121b09@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-usbcore-tracing-v1-1-b885a3121b09@google.com>

On Mon, Oct 13, 2025 at 10:01:22AM +0800, Kuen-Han Tsai wrote:
> Introduce a new static inline function, update_usb_device_state(), to
> centralize the process of changing a device's state, including the
> management of active_duration during suspend/resume transitions.
> 
> This change prepares for adding tracepoints, allowing tracing logic to
> be added in a single, central location within the new helper function.
> 
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>  drivers/usb/core/hub.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 256fe8c86828d51c33442345acdb7f3fe80a98ce..ce3d94c960470e9be7979b1021551eab5fd03517 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2147,6 +2147,20 @@ static void update_port_device_state(struct usb_device *udev)
>  	}
>  }
>  
> +static inline void update_usb_device_state(struct usb_device *udev,
> +					   enum usb_device_state new_state)
> +{
> +	if (udev->state == USB_STATE_SUSPENDED &&
> +	    new_state != USB_STATE_SUSPENDED)
> +		udev->active_duration -= jiffies;
> +	else if (new_state == USB_STATE_SUSPENDED &&
> +		 udev->state != USB_STATE_SUSPENDED)
> +		udev->active_duration += jiffies;
> +
> +	udev->state = new_state;
> +	update_port_device_state(udev);
> +}

This seems complicated enough to be a standalone function, not inline.

Alan Stern

