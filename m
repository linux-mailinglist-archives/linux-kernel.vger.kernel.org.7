Return-Path: <linux-kernel+bounces-847750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C99BCB91E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F1E4F4512
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231A26B74D;
	Fri, 10 Oct 2025 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="l/cCHbzC";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="y3zuROBF"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D826CE37
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067636; cv=none; b=H3qVMwGPzgLDRzwUXW22YwmBrBE8C6LcHbgvo+uk71tPlObSbGlqA+YbpMHkYbH/9WwBQj8lZHio0e5OirOs5vE4oBTCIdjjCzw7pOp9aFsQLQmrN5wKWlkX9w2I7n2ik0CBK9HRoWF4Mvc/EkfTMTIwI2eI1M/MCQxRX7RZq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067636; c=relaxed/simple;
	bh=EAEy9jXZzMRV5ceE185as2de8jTa17gujyqxp8vu9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNCxUNfejMNRhfYydsaN4rfgK42OZwptpNHLNhIi77NzUqs8IxocDPIvIB7uReBgZNT//3GtVWa42I3hSKqIAmQqfDB8sIHOgDrVOCYXpRCD3Pu1GekMLu2Zs3lC5071ySV6vNr7lj0PHFx3sufV2c0TyNLrlotwsIHYNcZQYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=l/cCHbzC; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=y3zuROBF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=EAEy9jXZzMRV5
	ceE185as2de8jTa17gujyqxp8vu9pk=; h=in-reply-to:references:subject:cc:
	to:from:date; d=hacktheplanet.fi; b=l/cCHbzCSuPCrspwIiOZMiXJfkmya+mQV+
	9Zbxg9t8ZsnqJ+vwIu43GlPZez45/FWY0nES8E3TDOsItJ7mtm8QwVTqDr1ink9stRhsCu
	KGXSX1ckUJQOeuyRFjgxQBzkVC+ebJhcjpPF0fameOK57fgvN1RPITLWz96zWIOdTC+ksE
	cGBHsHSCUdtuqxztJ7MnDjBBSnivmI7gIraBp239aCd/jbwEjDlSK1bY3uESVQqbeQAWfs
	HUHDQ75pHvjH4Za1Yg0DlS+Pm6nkuj4kiDxCZoF+OlckVhYCTPJkMBJMLJtf2Ipsa4bcck
	obZHMYZpu6hjPJVfdx53Do5IZOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1760067629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqTikEuoSgkx6Sgcx3a1z9CiqBLgFrqNn1OJpzaSp8w=;
	b=y3zuROBF4bd4UwMpOYSUOjcOqFloh/mw31x34qCWp0SIzdVYbN3K/ZVPSaY4iD5SHotpbp
	yB1CecTisDTbJsEbGd6s5X5NZ8cUC/KEsw1f2Di9OzoIkAUWHW5RTcVRD67QufPyLDc4+y
	YVyuAVFuLHTDhOASSqDD4mnGELC+S55rYqZ6/PC7cgQngMTRv7HcX8d0BikDQcPnrWMHR9
	o4sl+G1nhWVaQIC+Z2w/8ZfpsYlRSi7E/JbB9V9Y/9TSzLoeKxOUbFAFf7NrSUlsH68t+v
	jCECVN7OtgwQf4/VgJPaofH+alZANirroq/XRaUomAjzrG5TCIulW2oSxcmoHw==
Date: Fri, 10 Oct 2025 12:40:17 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: patch Lenovo Yoga Slim 7x Keyboard rdesc
Message-ID: <aOiAIeVUVQxNrg28@mail.hacktheplanet.fi>
References: <aOdLxAEYQpV2zp77@mail.hacktheplanet.fi>
 <lxtbtu5frygbw7qzfaelc63vgientm7d6oo7dt6jeassl3ttbh@f22h223wehbm>
 <aOdsqHznz1SJdadC@mail.hacktheplanet.fi>
 <56l5tnplzap4mcqcridsavbtvbevhqd235m4m3h4ititj3j5p2@z6oy6wimoodv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56l5tnplzap4mcqcridsavbtvbevhqd235m4m3h4ititj3j5p2@z6oy6wimoodv>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09 2025 10:29:19 +0200, Benjamin Tissoires wrote:
> On Oct 09 2025, Lauri Tirkkonen wrote:
> > This device uses hid-over-i2c, not hid-lenovo; I've got
> > CONFIG_HID_LENOVO=m but the module is not even loaded. I don't see how
> > putting the fixup in a module that does not attach to the device could
> > work. So where should it go?
> 
> Well, the transport layer is i2c-hid, but the logical implementation is
> in hid-generic which leverages the hid core default implementation.
> 
> In your case, you need to tell hid-lenovo to handle the device so we
> stick to nice and tidy approach with each HID driver handling it's own
> business.
> 
> Adding a line like the following will bind the keyboard part of the
> device to hid-lenovo in lenovo_devices[]:
> 	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
> 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_YOGA_SLIM_7X) },

> If you don't use hid-multitouch on the same device you need a
> HID_I2C_DEVICE() macro instead.

Thank you for the explanation; that makes sense.

This machine does have multitouch, but it's in a different product id.

However, it did not work: apparently hid-lenovo can't be loaded on this
machine because it depends on platform_profile, which returns
-EOPNOTSUPP at initialization. This is an arm64 machine with
acpi_disabled. Not sure what to do about that.

-- 
Lauri Tirkkonen | lotheac @ IRCnet

