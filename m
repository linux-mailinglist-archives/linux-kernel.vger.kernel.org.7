Return-Path: <linux-kernel+bounces-865184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB117BFC678
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FA4E9798
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0134B409;
	Wed, 22 Oct 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4OfaFzj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1621DEFE9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142260; cv=none; b=dgTVJKRkfJKZ/XZc2OQwKb6WCAVdExj9uHdgx7x24nUSJK6yS+9KM4G7Z4g9+6U2nOTWlYHuxc55pCDuwwNWxYLIR7z8mDonW+j6S2YVkOfAvgnD2RJVLiaaK6jfSNI3xfme7WS1ApoT6A8IYeI02Ph2XIT+vcFcxyO+hMNtRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142260; c=relaxed/simple;
	bh=vn67jnrcXDL2Y7Uu/c/3XWuBZ3gr/ImeBq5pl8zrkgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2kVIeVtsWYcOZ5QDj+tn5yPBpwyISAfxmO/0YIQZFLowSTxSmE6m7+l5d7unWQJtsJ6sGYF5LG9WQEa3oTRuufv1WcTVTvQvfynPY/JDEwXJenIzm7SqtFelv44C5fROhcpyaX+1zazhK/PifpTRnd9eW3EY7jwTT2mV8xHDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A4OfaFzj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ece1102998so5667100f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761142257; x=1761747057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkLs9KoLLMdMCW70UI4iz7uHdABAQO8YgtAVQOgKTXk=;
        b=A4OfaFzjyct0tzbfve+hnMnBUU1YjMY2kAB8/AF4eVYGLFkeuWZDqHmLMjVSUs0Ga1
         QkT2Sc6qVhv0vnFe1PsvNAyVt8Z1Ky1/aomCKxzDI66NlpRXm8jiw0RH+VJ8O8dsNXtQ
         uCHCMij2UL/oZ9R1ldzgmzIxwHMPKOlsVHiVGJXqaeeQnFYeCg+tzPcPk4/kaYVBu+YC
         6JevPXKX+2QNob4Ghyt3ABrEh1DEnmkmkNX+fTfF9UD0FBlpea5gEJO0m9m4qRRKLtsS
         WSy92XVJY9TGMLcPed9k0BSUZ4bc3Ep3zpxhfpDrVZWlsz737gdf/lRoRcKFD2iubRDF
         Kjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142257; x=1761747057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkLs9KoLLMdMCW70UI4iz7uHdABAQO8YgtAVQOgKTXk=;
        b=ZsctrAG3xk0gYaWFrqp9VsydbQyVWAQLtNDH7PMGw2tnDNuEHCGgyvZ+OD8aMEw5pO
         7f9jyvDsgVUFjMuTPz8VWgERCOiLwRIzpsJrWyNx0PaSEJ8QfLyDSLcV5R5t8RilJ23z
         spJoaKgqkO9FvaGolcmoJJjZGUktJCaeIs0r0177f8T+L3jHuSx1t+5cEtXoMtNEh3wK
         yW837NWiUjdiqtFw7UVgjLcLD4qegagTLyS9Kz8IgHV4grxUZD/N8jIiiEx/Wl+K/yjp
         Z9UmzrU/VIXWTny+dipXC/ZoSMI6H2nv/e9dKq/C+K8AdU9BtHjCvJvn5JJSJ4KvwOZd
         cr1g==
X-Forwarded-Encrypted: i=1; AJvYcCXqGcsOIDIem3QH9soOU7uxAWWEf4qPGADpxN/kR+5ZnjeA9ulNU9DI4bhMJ4IaX4YK3JkrwWUznh9Hr2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1EJOcCqgYSHRZYikh38B3rC5q2QDb6ZNYAaBfQb/vZnUoWWz
	I7XIsiwuTsOhX51EgM5sbNAQ6HoMPMjPNng4EZQDW5xsxaKSGL1DyOH2yzLUUdO4qnk=
X-Gm-Gg: ASbGnctFcXl2Mz+/ucPrJOpyYn+OLfQAcEfXEfKuchZYA0xTMz55rueaaXROpBjidEh
	axc4FyPz5dlMm38LK4c2Ev5JSYuvpuW62NQZqYDMulgKagIUDuL51Q5JDFQzvEoP8VP8dU7GCK6
	S5lYhr62X0ClgvsZSwfFYkiO1oel73jN0nNF1IPRc6vesSaRAiwPN76eUVfu5HFa7BrO+nV2QAd
	Ni9wNi9LNY8jYoNUqOq6X9lZvjXkwwoMGayyPnCDP8CoHiW7BIB15rQ6EdN1qr2Hhf73dTgb9Mp
	nftWyz7/KYsfs3yOOsLCExQeVMeyTnVugWmFW7GVWVPMsk3hpY9Z3Gki340GVyDC+XhSMGN0CbZ
	danco7yUvDj47iPJpxuVZMRXLmhGSddnZfpizwfm0/8AOuvpQOlwWfI8gJ1EtXv/DwCnfzSmMDl
	iP4XOytIK51anV7cu+jgM5U5pjyks=
X-Google-Smtp-Source: AGHT+IE6akp/2Dc2iEjje5ectRAOzvnt5Fnjh0DmNxZXmwTBAAK6Oke63zjnbBgDMPvQctvH8W4krg==
X-Received: by 2002:a5d:5849:0:b0:426:eef2:fa86 with SMTP id ffacd0b85a97d-42704d83873mr14817512f8f.11.1761142256609;
        Wed, 22 Oct 2025 07:10:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3c65sm25232989f8f.15.2025.10.22.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:10:56 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:10:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Dhruva Gole <d-gole@ti.com>, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fw-download: Fix find firmware req
Message-ID: <aPjl7G7fmvqtgww1@stanley.mountain>
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
 <aPjIJw3ahPxnDE5Q@stanley.mountain>
 <81d8d424-ad21-490a-b071-e1b3b3564e2c@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d8d424-ad21-490a-b071-e1b3b3564e2c@beagleboard.org>

On Wed, Oct 22, 2025 at 07:22:49PM +0530, Ayush Singh wrote:
> 
> On 10/22/25 5:33 PM, Dan Carpenter wrote:
> > On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
> > > diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> > > index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
> > > --- a/drivers/staging/greybus/fw-download.c
> > > +++ b/drivers/staging/greybus/fw-download.c
> > > @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
> > >   /* This returns path of the firmware blob on the disk */
> > >   static struct fw_request *find_firmware(struct fw_download *fw_download,
> > > -					const char *tag)
> > > +					const char *tag, const char *format)
> > >   {
> > >   	struct gb_interface *intf = fw_download->connection->bundle->intf;
> > >   	struct fw_request *fw_req;
> > > @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
> > >   	}
> > >   	fw_req->firmware_id = ret;
> > > -	snprintf(fw_req->name, sizeof(fw_req->name),
> > > -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
> > > -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > -		 intf->vendor_id, intf->product_id, tag);
> > > +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
> > Change this to:
> > 
> > 	if (format[0] == '\0') {
> > 
> > In the caller, the assumption that format is at least
> > GB_FIRMWARE_FORMAT_MAX_SIZE makes sense but in this function it
> > doesn't make sense.
> 
> Ok, will do in the next version.
> 
> > > +		snprintf(fw_req->name, sizeof(fw_req->name),
> > > +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
> > > +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > +			 intf->vendor_id, intf->product_id, tag);
> > > +	} else {
> > > +		snprintf(fw_req->name, sizeof(fw_req->name),
> > > +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
> > > +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > +			 intf->vendor_id, intf->product_id, tag, format);
> > > +	}
> > >   	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
> > >   		 fw_req->name);
> > > @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
> > >   	struct gb_fw_download_find_firmware_request *request;
> > >   	struct gb_fw_download_find_firmware_response *response;
> > >   	struct fw_request *fw_req;
> > > -	const char *tag;
> > > +	const char *tag, *format;
> > >   	if (op->request->payload_size != sizeof(*request)) {
> > >   		dev_err(fw_download->parent,
> > We have changed the sizeof(*request) but we haven't changed
> > ->payload_size so how can this ever be true?  Did you test this change?
> 
> 
> The request originates in greybus node. The payload size here is calculate
> from the greybus message header. It is not a hard coded value. So as long as
> the node sets it correctly, it will work fine.

I guess, how was this working for other people then?  It seems like a
behavior change.

regards,
dan carpenter



