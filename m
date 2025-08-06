Return-Path: <linux-kernel+bounces-758162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A92B1CBD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AED6565562
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1829E116;
	Wed,  6 Aug 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="IiZhQVOI"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0729E0F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504343; cv=none; b=DjatzpPDVymkTbYZ9StQ6RHP+AjpuFN+T0CwRTdY5siz/AxjeBKgz8jUnoQp0dqjfuOoCJ/FgoAely90wLhk0owbbpViSUvbGsYBWbZ0EUvY6RoZCHrsB7g4m4qgLgmsqLAv8vGBujLIyB9gYxNahRoH5WhTOzeXx2pD9bjXiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504343; c=relaxed/simple;
	bh=scM60JWooxHIxyZxbf7sRO869NtZo3fJXh2jgi2YgZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiJsfbHCDRy0uXvunZzP77ukVIY3DY+vD3QfEXSJTX6aRhqq7hAPtNqxRpwwWwucHHlkHWe9cAZOh5a019z65qVtl0Iz2nOu0bKr0XMaH83cEIaalmRBT7EH6i2AGLW5M3UJi9abMsRBSUO7DIFmvs0tNB19Mmnqbjji4QmVzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=IiZhQVOI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0a13bb0b7so1101821cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1754504340; x=1755109140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Athr79gwm1aP+FwxIvbTHKxraTrSIJP2WIrwbPHH0Zk=;
        b=IiZhQVOIsntGFaow3+jUtGWx55Pee3DP+CnAEaoX8D+yNagZ755ZCm8FkRchJU7T/l
         zwUK8blCjWnm8RkEODiPFuAjMAh/efveSma1V1pURANW5VYAJJWLly5qQuGHSTvopoCj
         3H+cnYRNAZu/5U8ImwYvJzgdBF/SuQtgVJpyZmzycPOg2+nzTV0eRSRMlB0jy7JVH8BK
         cskcimkm6Wgkzv/S40K1OFTuMemQwD4Lba/L0vCh6/ausyHKxMtZQax22Ew/AdFeTgJs
         ooiqr1qUmc7bmWYvFZwFma6QFSuk9QZ/jTYRZIC8prBrcm16QzY7rBY86Oink36JXuyD
         q+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504340; x=1755109140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Athr79gwm1aP+FwxIvbTHKxraTrSIJP2WIrwbPHH0Zk=;
        b=AnIqbGSUt3XBeQY3Letkhu/ljL9pEjWrlW5DNkHgT77WQEGopBHpzxTxilItHD658E
         FrmT6C73Pz44cldP8sTYKeFUhzk7SbR0zuxkFMfdrF+NeV+w3bz50uoXDSEJYqHV1V3N
         mhVNKPGb/PxUD//HAOFe8kRBN4a4Vl5dFL8lvVUh2R7lRJldILNNBq2R8tOUAjlR6RGK
         821H6BthR688iU0UIsrTGIxguEGaRIrA8xC/FKAP8c9qWXQiCZmZl+UGgmul49NG9U0V
         x1X2gZ6PS6Ecz/J8WEuOIHEwhvRBGjfhGe6xMH3asDfp5FH2Ij6tUipNJXq0AmsdgE98
         DauQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp2yNQmxuW7Vkx/mwSAek8bG5r/+7eVzv5lvC6S4+uwoJOuDY60TlIUlk30/B5l4p+rKRlA5gKSb6rzKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yP3GjbVy7kljW11YE3fDcV4Dd869Lh8J0P9vhKGfj2g3YadL
	mntCg1kOzrdv2Og9CtE0MC4ZW1Uqc1N+qfVxJSgqGwXFzDQTOawhrCx+q3Cjsjgwbw==
X-Gm-Gg: ASbGncv2jSYisjpMlTgM+xq7nbD3elN3fewyannAvSaqtlg1ogvdDeZJ2cAN4RnirbI
	+YgWv2ITPOU8DybOfVeGB+oFl0FY69wiLOOBijkULeKaAlvk3qjNRwu8kTNcrFNzT07GK+fy4fH
	Fg0k8IdJ94ylHGvoQISMRpF7LeDQUcuM2oIjJ66NXTG5ZBG92f68dgOkIb+bW1DV7kX+jm4QsC5
	P76kr9JUhXFCx9qBBgwZOrt4y0kPs5w8dbetgQfaMNznSRPUHvOh/thfNPlycUHdgd6dwg/JNSa
	KkJedevThnL2Pyf1MnRv+e/pjymdobaXMGL2jPDzDf6L0K4hgFsmXP91wjdBAZ1gJJLaRriXEPM
	eLGcYbSKIclHH9ChRy8iWaSaKafmpattk7Qa6JyQl8wbsCoXx+f5EgXS/X5XWqPF2eg==
X-Google-Smtp-Source: AGHT+IEDVGW624rgb330dRrSe4xhRfBT1YoStwCBUlnpqA8nmtR8t/kEuU5e5BddGqZSoOepsdZNoA==
X-Received: by 2002:a05:622a:2b49:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b09145abbdmr57925671cf.26.1754504340318;
        Wed, 06 Aug 2025 11:19:00 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80b2f7a07sm287772785a.6.2025.08.06.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:18:59 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:18:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mael GUERIN <mael.guerin@murena.io>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] usb-storage: Add unusual-devs entry for Novatek
 NTK96550-based camera
Message-ID: <28080ef2-a767-4444-b487-9a12fe0ba41c@rowland.harvard.edu>
References: <20250806134722.32140-2-mael.guerin@murena.io>
 <20250806164406.43450-1-mael.guerin@murena.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806164406.43450-1-mael.guerin@murena.io>

The Subject line really ought to say "USB: storage: Add ..." but that's 
a very minor matter; Greg can adjust it if he wants when the patch is 
applied.

Apart from that...

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

On Wed, Aug 06, 2025 at 06:44:03PM +0200, 'Mael GUERIN' via USB Mass Storage on Linux wrote:
> Add the US_FL_BULK_IGNORE_TAG quirk for Novatek NTK96550-based camera
> to fix USB resets after sending SCSI vendor commands due to CBW and
> CSW tags difference, leading to undesired slowness while communicating
> with the device.
> 
> Please find below the copy of /sys/kernel/debug/usb/devices with my
> device plugged in (listed as TechSys USB mass storage here, the
> underlying chipset being the Novatek NTK96550-based camera):
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=0603 ProdID=8611 Rev= 0.01
> S:  Manufacturer=TechSys
> S:  Product=USB Mass Storage
> S:  SerialNumber=966110000000100
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Mael GUERIN <mael.guerin@murena.io>
> ---
> Thanks for your review and your advice. Here's the updated version of the
> patch with a correct description as well as the unusual_devs.h file sorted
> correctly.
> 
>  drivers/usb/storage/unusual_devs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index 54f0b1c83..bee9f1e80 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_SANE_SENSE ),
>  
> +/* Added by Maël GUERIN <mael.guerin@murena.io> */
> +UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
> +		"Novatek",
> +		"NTK96550-based camera",
> +		USB_SC_SCSI, USB_PR_BULK, NULL,
> +		US_FL_BULK_IGNORE_TAG ),
> +
>  /*
>   * Reported by Hanno Boeck <hanno@gmx.de>
>   * Taken from the Lycoris Kernel
> -- 
> 2.50.1

