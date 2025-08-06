Return-Path: <linux-kernel+bounces-757890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1851B1C7F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7197227B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC0225DD0B;
	Wed,  6 Aug 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="g+mLpn+p"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB2944F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491984; cv=none; b=IFdpOz3A8t2Trvkv1mz4dXzwwQvRMqkZINSIjgc5eOcThMuI81rwSOVC1HZbg2DmFupDa1PiqautZp3GwqwynkTyYESwRZeCpOcTMZruiN0HJFcKRDgSpuPErDXqibkk7MytOaELJKYLu6LoFd75rq3c8rdGArOBMxdX2/HxyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491984; c=relaxed/simple;
	bh=FT9NAZayKdDI27pzthIX2Z1Z5soBuTXgGl2ftAlcFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQpVdUHOemBxNB0/I8srNC9+VIqazgPk0Y+iFd7Z3lKsBf1HdluTUs92icHP9W+b4pvBT91PCqkD5hBLokzdaWGGGh+gX2NHTQK+cDARWEgn1VsIUY9yrkZ4CDchbAkHVV5stWveZMf5yDOBGGk2LexRUAUlRIoSbp0ZQe8UGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=g+mLpn+p; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0619a353dso29099321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1754491982; x=1755096782; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y49um8k48nE0B08AM4u/UHZ2Qks552cSP9p7KiLp1/4=;
        b=g+mLpn+pmopqU9D0ATr/URwdJhP0xUo02xFMXkngIxSiXfEtOVKzeVzJcTzHCSeavt
         nqh7wR9dysrYi24Dd+qsBiEQpYOMEzGs4luez6RXa2clRGBrem5I7v9eQ+csS7n5blAY
         JdAex/vaC64D5r0h6lVN7/vQoWIguVVmb1DNolqGWOI/4RCCURO7lm0S0JVb/CFUfyed
         CmkEcx+2czTn55OGpNzeDHydTx01zvWZPdEQyPsBRMPBOpAZgxkKZvUt2fFL+2L5qjzb
         YAC50iPr1sE3sHENphhZlDFuPlpslMOnAZtOYN3W+0qSHXJzhpQXOE4xMi0hj4mcrKJk
         SFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491982; x=1755096782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y49um8k48nE0B08AM4u/UHZ2Qks552cSP9p7KiLp1/4=;
        b=V9xADHDA/4eURRXQnpDeEWt0s6CEU4AsOHwYUK3TZPTkCUAm1jIUMHobsljJEf9ej4
         7rr4YcXIyXOaKi8NxLp+4e+bwscYrOAhnktcC0qrfejhv2XU4mB45Y3Ea3SXIIYifceV
         t8/0xRhExfyRnziI/ruAvpXrAe3MQ3rc8n88S3qhqe9/W9HE+PTAqSsW04Jwo0wcCi9Q
         v2Jtmz/AAqhKJ5CobiQHfRcBvXi9MHGOOUz3rpi+v85kRHWIngbVWFcx0++QKsKN1b0Y
         xUKtmnkUc9QtgSqTd2pW2RnTKdaLp05IN0AEGqbjhQMLZO1FBGl9XFjV29hyRPKLnmEP
         TCyA==
X-Forwarded-Encrypted: i=1; AJvYcCV4MVLkSIPxblm4/wX/USHC83VWh+NL+XP5AcAvPBzIj9Orj+iBsME2JO/Gw+9E/KRWUl2Sp7kwZGjoUqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+x4JCMKAqajLBG3SdzY2G7kOdluhSyyZFVRYoRrAhxhUy4Z41
	P4Kh2GBq6YA86ni/kN4iWla4HN99KbVXDZte+Q9BXEzegYioy4KSFagHNI4zBdAlng==
X-Gm-Gg: ASbGncvLx/xIlOUJu6ld85GampobibbQuQfsebi38Z3mTtZFYwSrnrq+G9o3v58gbJ7
	TSWNdbE+O/dAlBC9vC4KZYIrRB5QnQzITlUovkC+ltKZy3DHKLYk39GEtTgFRNY/SdwKiZY5rmq
	pXG+T/uQtHDM0N3+swwX7OnZJ+fg0t5tJHCnHpdsEjB1rUYz+z/oI3lF8QyWPanjP2NSaJc7Esh
	UsAxzOcKD3e+3lQ6OVVilon5ugM8UNFG7hZNhlRgV2wUj11WUJGYt1NBCqHjZbGGDK+GRSv5VGC
	5xLxG5hhcG+/3pH392AuWDPjKEpv+oxPOYXOyOR//8WevYZtrGSeDfBldoY4m87q45HFtolxPTA
	UHk/biiCPmO/OKzsXGklWCPlqP+qzjNhGUE+/WJlz
X-Google-Smtp-Source: AGHT+IH1wqoI6decNxwgKRqP11WqL9KAB2bDN5/g7e8aK8peDiOJal2c2/0M5WjTN1Upv13s0s9prQ==
X-Received: by 2002:a05:622a:1191:b0:4ab:38c1:f9bd with SMTP id d75a77b69052e-4b0924dd3c2mr42118451cf.12.1754491981724;
        Wed, 06 Aug 2025 07:53:01 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0780a0316sm31471251cf.43.2025.08.06.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:53:00 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:52:58 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mael GUERIN <mael.guerin@murena.io>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] usb-storage: Add unusual-devs entry for Novatek
 NTK96550-based camera
Message-ID: <63e45e57-c3c1-40e3-8ad5-af3834584a60@rowland.harvard.edu>
References: <20250806134722.32140-2-mael.guerin@murena.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806134722.32140-2-mael.guerin@murena.io>

On Wed, Aug 06, 2025 at 03:47:21PM +0200, Mael GUERIN wrote:
> Signed-off-by: Mael GUERIN <mael.guerin@murena.io>
> ---

Patches must have a nonempty description.  You can simply take the text 
of your 0/1 message and put it directly in the 1/1 email as the 
description.  Then there won't be any need for a separate 0/1 message.

>  drivers/usb/storage/unusual_devs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index 54f0b1c83..7bb5a1d75 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -262,6 +262,13 @@ UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_MAX_SECTORS_64 ),
>  
> +/* Added by Maël GUERIN <mael.guerin@murena.io> */
> +UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
> +		"Novatek",
> +		"NTK96550-based camera",
> +		USB_SC_SCSI, USB_PR_BULK, NULL,
> +		US_FL_BULK_IGNORE_TAG ),

See the instructions at the start of this file.  Entries are supposed to 
be sorted by Vendor ID and then Product ID.

Alan Stern

> +
>  #ifdef NO_SDDR09
>  UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
>  		"Microtech",
> -- 
> 2.50.1
> 

