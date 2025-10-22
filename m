Return-Path: <linux-kernel+bounces-865286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C097ABFCB54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F391A00D37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861EF348469;
	Wed, 22 Oct 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEQ3MZ8h"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8512ED161
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144828; cv=none; b=pCCrOI5tKR/z1GT2oQVq87Nh5R1qy/3DYDEOnqaLfksW3zAN1TRkc0F1CztR+zQc2wa6fOs4eh/dbBIrSOa+nb21+jdSEUtxR0FEQ8XOXC2N6gaLxpawnH920UvCtEFTO/oms5jQzOh5U+XF1hA17H1MFymyajyVA84p2A1Wr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144828; c=relaxed/simple;
	bh=XJx0arENnmiKEDehQKHhrpLUYDPZt9CFE2r/LiOpsiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE0neTEsQ0EE8opGr02TZrIfwU1zL0I/i0C4f9GR7+ZkKz/YToFp1TOvL4Ut2XlOd4ls01QuYcJzMU5SGjnRObY+uU+KLfIxz7f1Rt1KsWfhHLj6ZUPngGMb8mjbLjNbhDsfJ0eKpLuKBm44hk1j+CIXtfnqkqrwl+fN375nbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEQ3MZ8h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so39342955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761144825; x=1761749625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDzptmmA/1MAp75cor5JADx19hm032JDHcpSfga7lTw=;
        b=AEQ3MZ8hOURZwOHTcE2N4ydF7Y+mYZUbFGDjqz0njr+lmX5Wrz66763ggcyLvK/1Qw
         Zw71z037Yptu/0+Seq/ozQFG5KEsucgdL+3F6M/rNFd7DOSVb2ypp+gJuv0J9GJu5MPH
         I4rfEqL7VeY2Q8M1F3S4G7t891cqg8RuMH1mHZx6UoN3sy0DZKu/wyAkEnECHaU/FGUu
         vkRrGPV9eQY3rAIeUZXrV/LNl5Q58sLv9moJXLMFkexPouXdJum8rD1W7hdR8+wGnowI
         jwatA8NhXqmgj63++NTvNdkULFKWTqFo2jSD1dcsXYf90J7jE1SMiGrvuWo5CJguMBE+
         Uytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144825; x=1761749625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDzptmmA/1MAp75cor5JADx19hm032JDHcpSfga7lTw=;
        b=LnbUQ7Xa1z5+HIbgjr5d1qZ70i92IfhYq3iBtQeNM7nuFTO8Zc4Iyb8UZQLbmSNsTF
         57crSsCtbLH+0QomWkSKfBD6txvg2DRYxhh4Hjwlg2aV9Q9KUmU6+GSUb9AKt0urr8FT
         FoDhknSYrpcTbHvVrkD5tf7QWCazojLcv1gBLLLHB9uuFjnl1XQ3nw2ONLZ/F3Cq93vA
         7nJjImy1mFjldNIpdH4RWlc+vBlNPowdomLtAs4SnOBzJ2QQ/eMaDhHu44bONwbcn9ud
         5hSzjPaGNq1iWg96D73hYORJ9RAS/FNwxMol+HLewfP84UIJGzMiB2KLMArf5rVTxemL
         AWNw==
X-Forwarded-Encrypted: i=1; AJvYcCWOMc8ErRelx594UAnJdlAgAJQZbs7wVSzGq9YdDOf6S2d24nL1hba5iGUX8FSBIaYF0r+kC3sHEDj3MRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3glMec4nJ0QLNvMX95fW3gsoIE5tMBaFV+Xdgssha4f/lSYlL
	MoWmgMVHZvx1cNKsa4oBYLAVgU+QSMHe4/z8eSGb1cVUikC7OmqQRQK0RWM7IKHr6B4=
X-Gm-Gg: ASbGncsuUFfn3ttQp4N8yBGwdswfhdl4p156/ACHYHdunhPdV1oFf0hWqb5lIsdWSCN
	rEoUTuq2FGAkw/uThvC9jQen7ugvI442d6AFxwjSDUK7TsBYa0hukckW/rPInEb+dAhjjEtuTgs
	Yx0in7m3/+aSIDnQfWCPBxeUX6CJ/WvDSkYWULZBCA/qp/qR3789oIAqmHohWWHRK4ZIz6SqOgT
	HEWgjZZnbRRUKyziRIgqS3st28IFidNsiHjqu2+O2NM6ha6KP7Mzl21KuzFaVt245j6UTym+oB/
	Pq+i9/YHLRJ+Lcxy2iTDpinhhMkH+74nKhfPbhgdEfnAyGb+pzmzafyJ19Lol8AfXNFxhBGX8YZ
	31Npa2mRYsefX3OhmDpQAXWUUBm72ui13MmjI9PP05T2IXdQN/kWJUQKzCUhoiRmkmP+kZYO0++
	hw7mxU7w==
X-Google-Smtp-Source: AGHT+IEy9aeBUo2n4dYlY/W7J/vEbPfucqkAVCkr+JTDsG/5iKnq4/KG5HqeJZjmqiE9vrFusdq3hQ==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr154106445e9.15.1761144824970;
        Wed, 22 Oct 2025 07:53:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c42b567dsm47385605e9.16.2025.10.22.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:53:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:53:41 +0300
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
Message-ID: <aPjv9Xnm-grVR4rb@stanley.mountain>
References: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
 <aPjIJw3ahPxnDE5Q@stanley.mountain>
 <81d8d424-ad21-490a-b071-e1b3b3564e2c@beagleboard.org>
 <aPjl7G7fmvqtgww1@stanley.mountain>
 <4d87a2ef-4cc1-4774-8716-e4a3f7f346cb@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d87a2ef-4cc1-4774-8716-e4a3f7f346cb@beagleboard.org>

On Wed, Oct 22, 2025 at 07:56:35PM +0530, Ayush Singh wrote:
> On 10/22/25 7:40 PM, Dan Carpenter wrote:
> 
> > On Wed, Oct 22, 2025 at 07:22:49PM +0530, Ayush Singh wrote:
> > > On 10/22/25 5:33 PM, Dan Carpenter wrote:
> > > > On Wed, Oct 22, 2025 at 12:57:57PM +0530, Ayush Singh wrote:
> > > > > diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
> > > > > index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
> > > > > --- a/drivers/staging/greybus/fw-download.c
> > > > > +++ b/drivers/staging/greybus/fw-download.c
> > > > > @@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
> > > > >    /* This returns path of the firmware blob on the disk */
> > > > >    static struct fw_request *find_firmware(struct fw_download *fw_download,
> > > > > -					const char *tag)
> > > > > +					const char *tag, const char *format)
> > > > >    {
> > > > >    	struct gb_interface *intf = fw_download->connection->bundle->intf;
> > > > >    	struct fw_request *fw_req;
> > > > > @@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
> > > > >    	}
> > > > >    	fw_req->firmware_id = ret;
> > > > > -	snprintf(fw_req->name, sizeof(fw_req->name),
> > > > > -		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
> > > > > -		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > > > -		 intf->vendor_id, intf->product_id, tag);
> > > > > +	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
> > > > Change this to:
> > > > 
> > > > 	if (format[0] == '\0') {
> > > > 
> > > > In the caller, the assumption that format is at least
> > > > GB_FIRMWARE_FORMAT_MAX_SIZE makes sense but in this function it
> > > > doesn't make sense.
> > > Ok, will do in the next version.
> > > 
> > > > > +		snprintf(fw_req->name, sizeof(fw_req->name),
> > > > > +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
> > > > > +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > > > +			 intf->vendor_id, intf->product_id, tag);
> > > > > +	} else {
> > > > > +		snprintf(fw_req->name, sizeof(fw_req->name),
> > > > > +			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
> > > > > +			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
> > > > > +			 intf->vendor_id, intf->product_id, tag, format);
> > > > > +	}
> > > > >    	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
> > > > >    		 fw_req->name);
> > > > > @@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
> > > > >    	struct gb_fw_download_find_firmware_request *request;
> > > > >    	struct gb_fw_download_find_firmware_response *response;
> > > > >    	struct fw_request *fw_req;
> > > > > -	const char *tag;
> > > > > +	const char *tag, *format;
> > > > >    	if (op->request->payload_size != sizeof(*request)) {
> > > > >    		dev_err(fw_download->parent,
> > > > We have changed the sizeof(*request) but we haven't changed
> > > > ->payload_size so how can this ever be true?  Did you test this change?
> > > 
> > > The request originates in greybus node. The payload size here is calculate
> > > from the greybus message header. It is not a hard coded value. So as long as
> > > the node sets it correctly, it will work fine.
> > I guess, how was this working for other people then?  It seems like a
> > behavior change.
> 
> 
> Well, it is technically a breaking change, if any device was already using
> fw download protocol. With that said, I have no idea who is using greybus
> right now. And since the changes are in staging drivers, it probably is
> fine.
> 
> I don't really know if the spec came first or linux implementation. But one
> of them is currently incorrect.
> 
> Just to clarify, greybus-for-zephyr is not the original or source of truth
> implementation of greybus. I just found the inconsistency between what the
> spec says, and what Linux kernel implements and thought that spec should
> probably have higher priority.

Ok, this is a question that many people face in one way or another.

Unless you have proof that there are no users, then we have to assume that
there are users.  An example of proof would be, there is a bug which
prevents the module from probing and no one has complained for over a year.
Just because code is in staging doesn't mean there are no users.

Sometimes code is in staging because the user interface is bad, and in
that case we need to update the usespace tools to handle the new interface
as well as the old one and then we can change the kernel.  That's something
we can do for staging code, but we hate to do it and once code leaves
staging then the rules become more strict.

We don't really care about the spec, it's good to support the spec but
what we really support are users.  We can't break the code for existing
users.

So we need to add if statements to support both formats.

	if (op->request->payload_size != sizeof(*request) &&
	    op->request->payload_size != OLD_SIZE) {

etc.

regards,
dan carpenter

