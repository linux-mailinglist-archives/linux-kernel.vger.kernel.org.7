Return-Path: <linux-kernel+bounces-858906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040EBBEC347
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FB19A8035
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FB19995E;
	Sat, 18 Oct 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8XmRHQo"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2216D9C2
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749743; cv=none; b=HQyPSiJogwHuOfC7MRsxp0b7whOzGaTLhIVtchMYhv8KuLCmg7f/1nZtfqh7Jz+wAef3j0R9/6w7klobS7ti9pDClFiKGIcC4ua1XTBee2pie/O34gbhnhg0OnwJ4EVsBGp3Aoh9+cFEnkmgfnPdrsUuDRgTcwwn3hCfdYrQe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749743; c=relaxed/simple;
	bh=e3j0tM594BEHtaLmHhl6ldltnFaSOezHubsVppH21NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQlVCVg7PjEjiYO2hdDk3/V9iKdAHWTu2t8tvqzKljERktI8rFK+yyqiIy6mCqY9hCYcx5zELtED02aPPrnnuV3I8sVfCvjSP5gaWeV+d3oVnpwpMmqHuBEI42GtDY0uvHG/D7EztpJz1bGt+7KtLvpia+1KiVvId78i7xSWON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8XmRHQo; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so104866b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760749741; x=1761354541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvZsZ7oS0CM+3Jpc3uOT/QYGpqH5xVAqjmhfBxS7UXc=;
        b=f8XmRHQoialr6hHO75SR9y6KXIDBpZrz5wiTFqXhooWvtNBYO9XDc7YxLHqwGJb8cf
         zEQifro+pgRp1+5J4KRZNL0dFK7Hzvu1JXFL1g8qlP7+2UAnuQwcTXtnimZAXngUJQU3
         NELLzLTgbhxbunMav54TgFuNoVFYKinpQoS8xkw5YKxhT3bJGlR4dY8/AoHpXTD4+CYU
         IXUSEiVJGUO45zP2WmUUTNLE6lKHQgw0mRQYm2GWl26xrH65si3fYJH0vnIPVVitsW1I
         X4RPaKWQpWtrt0BMOiaG7yOG5xFqz1ZilpmclLMhd503Ro34sJv9b9eab/YEOFWA8SXl
         /F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760749741; x=1761354541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvZsZ7oS0CM+3Jpc3uOT/QYGpqH5xVAqjmhfBxS7UXc=;
        b=QP2NRDQ7GvaXYsNBetXEbrXIltMMKIajRQdBnJW62/OQq0noKzp1opzwdy7z7xESqR
         1x2mXk7IUibqfjgwhZ+WQl3/3MNTn6pmZBb79wa+tQu/pFNkfV5MZwAclls7/lIBP2jQ
         D//sgrY8zL+7NfJRdSCFVg/BC8c2THiciLBSwTiN5aqG6jZnfGgG2a52tOwrko6rQDhb
         gP4f0sjisjpetPbG/1keYg81EtKLfvZ7zVmBZMQ32H6mLDF+vW+EGOr/JiC9uWtbnJTI
         S5v8UYWXVi7eKBEUJDTUAul3agsCkSUCbDEM+GLHAjyrncK54bOM0W2IedZgwobMHK2N
         O/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVvPCP7siY48g5x83gS3c/OQZzYgXijhZDU2Pw4AdtRx09eheCVI3EH70Cxd6z51miVYeqxiU6Xgx+TKho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvQkc+fcJjsnqYfwaCVRj4G45Zqkm3WBGPYx//26xdGYKKh/T
	bRz8ydBKNshZjKnDCvBTec6cIzKo5aYDrB+xB+EY4maxgMClEQeoSb7o
X-Gm-Gg: ASbGncseIXosj/Ty5sK4jwMCVyUPVUPsEt5B9hgAqZA1XdpUrbj/XVtbaeQpPjy3N5v
	EFoavoD6RnfuVefvkPpdlZO8JMicsG6u+p/4ngYgAWWHUYbpRkjLG/BSgpq2DsjjHZbDoyCEDEI
	JVd2x6U79efcjjY99dFn3gpXIbzbxD+hkAEUBxhjfTMg0Su5ZY2UxanAoNXBGypAxBwPpnLJrdm
	52TKHa8+ALJKzMM+1GjzXmI6jMUl2nuf5WYMhrx+Z7bvxXgM7YY7Zbf4xFG7LGf+daRVLSEkHpU
	4CBEixOd+6kcAvZ15IB2v7oa2w6bYTQznH9e3dbqmSUWJwOr9fiGCBYFS+18VV/oZHGQDJTJeF4
	IZzhzlo4noeJlDht2Q14aHsqmZMezxPqxqIE96K9yWncmLT2ECAeVwCzD1b4nzndSlmTT/P6wYh
	gNXn/CZSsBb2dBixCjsdY54zyA6WAOjpvqjM6R+5RKQmjkXE+RiO0=
X-Google-Smtp-Source: AGHT+IHiiFYtC9umsD49rAB9MiYKz9Jivl0/Pq/GslEpRRno7xqWZQr46WIide/BgT2Kw79Lw4OfOA==
X-Received: by 2002:a05:6a20:6a1a:b0:334:87c2:445 with SMTP id adf61e73a8af0-334a8610a11mr8025098637.36.1760749741445;
        Fri, 17 Oct 2025 18:09:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de30555sm756087a91.12.2025.10.17.18.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:09:01 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:08:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: pegasus-notetaker - fix out-of-bounds access
 vulnerability in pegasus_parse_packet() function of the pegasus driver
Message-ID: <ekkelgdcm3ovrix3ktmzhlmc2bgchui4g7ogunut5k3dafhwri@y7fyt3uycxgr>
References: <20251007214131.3737115-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007214131.3737115-2-eeodqql09@gmail.com>

Hi,

On Tue, Oct 07, 2025 at 05:41:32PM -0400, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> In the pegasus_notetaker driver, the pegasus_probe() function allocates
> the URB transfer buffer using the wMaxPacketSize value from
> the endpoint descriptor. An attacker can use a malicious USB descriptor
> to force the allocation of a very small buffer.
> 
> Subsequently, if the device sends an interrupt packet with a specific
> pattern (e.g., where the first byte is 0x80 or 0x42),
> the pegasus_parse_packet() function parses the packet without checking
> the allocated buffer size. This leads to an out-of-bounds memory access,
> which could result in a system panic.
> 
> Fixes: 948bf18 ("Input: remove third argument of usb_maxpacket()")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>  drivers/input/tablet/pegasus_notetaker.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 8d6b71d59793..6c4199712a4e 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -311,6 +311,11 @@ static int pegasus_probe(struct usb_interface *intf,
>  	}
>  
>  	pegasus->data_len = usb_maxpacket(dev, pipe);
> +    if (pegasus->data_len < 5) {

The packet size is actually 6 (status + color + 2-byte X coordinate +
2-byte Y coordinate) so there's still off-by-one error.

I fixed it up and applied.

Thanks.

-- 
Dmitry

