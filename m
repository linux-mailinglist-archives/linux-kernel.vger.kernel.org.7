Return-Path: <linux-kernel+bounces-857781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E93BE7EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F43C1A612B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAE2EB85F;
	Fri, 17 Oct 2025 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lqDzQu+g"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478D2DC76F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695357; cv=none; b=in36453P85niZ4K+4Sbzv1R9kC7O7BJyMneZaSKjwrDphWJih/6nNk1e+wX/0bgockSsyO+qoN22c8J8FnDn3PDYMfbWg2+K+PI7J4hLtyPHkK2Y/EYD2ZQKNE4YRrxbceTjfCxrLHH3oZ8z2XmL47vsORIyYQhMwrIniMHB2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695357; c=relaxed/simple;
	bh=drZrnQKEAi0sMCaCh3X6bSQOyyKvMOxESRxUPZpCKWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APT3s1RWjJcD84drF68C/Vh2+3QMj2131kaCTKpQ9bT4JHFqMrwE5PA8Tn90jtlzFmIP3rxbCWtlyAqz7D26v4Mu4osP9lFqYy/9c4a/Ju3miUd8SzTmbefc3bvyp/3uoClGfBoKz922Crs6tI9xkGgfRPRFOH8Xvi0KIjiyEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lqDzQu+g; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so1682812b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760695354; x=1761300154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7OtZ/yQXFhjzdgsw+HJSVcKTN14IDqdEkJg8GvBN38=;
        b=lqDzQu+gI1tXgG2Z2HtEWr7i3Dwp512iw2ApjgppGcwvvOmvZHjrLsNBqPu8WKddAd
         kFDUIsxKgOTdnNyK7XniFjTbTw3lp3cfdNeGV/m9AswJN2ngGWJdcDYeK+/aMe1lxxRZ
         mo9ISeRAzlkH8y4USd/oDHEBJ/14jo8xZtsqJWa32Q5SyrsVkX5KW67FQqmV4gX5fEth
         VewOMNLITed5xQ20lkxxXCihymPl0wjHT8wWzyJOIjtfG2JM5eg6AQGRXyqJtwlZtdoy
         OgZj4iRFiKYIPv5oYKfsGS7jkUtV2cgroT6Fk2t1eTEvdFu21+lJnjOe1fTroQe4OLWg
         mZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695354; x=1761300154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7OtZ/yQXFhjzdgsw+HJSVcKTN14IDqdEkJg8GvBN38=;
        b=DvDJS41SiuUYP1HQ0sYn8+yE73ptNuVpkihC/s14+5vyC9n90cJRhIVP4+t1ACkSoF
         YVBtk1ZOWoXyqlV04RCooztq8/l+hU5nGLZY1G1TwVyj7r/2ApnQ3i4BfDK1WRvkstGR
         ERGqYKXXsF5UoYJrNTC/8+XgMONVFNLYEskkzGWwXUP4+yYqDsKaUga3hpMRxjvd3eUI
         VVd2n9Ap38J9hGt77hOH5FYsZtTUf/wGsxW9jUz6Kqs1hMaH4fmFLl+y8USGo/yV+a7Y
         AX0YE9iXL9mAK0qYMqr4I7NUrUFWUqnxOAgni2X+7ad91sYXLxS/RKKR6wfejbVKGpgo
         LZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjF5XgjauqBPRFbrHbpQ5SCFzuvyMXQnGzwR05kvmNv1hrPIRjO9pT3UCtsV4XZw5lO/DBmC6oN62/q3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB67MY8BR+ug1zGk4Zx5ZDlDowYSZuiFU355oM0W04+ELrWMVo
	DT3gOcTCam+tIlL0lmnDd8jS2dIMxZuR5ALt/z82OB+YMB9GenuKNZdCU/PlWOINuR4=
X-Gm-Gg: ASbGncvYGZ2/A4xAa/3OiN4c8OLT7J8+xme970/PhklHTUqsH+4pcQo8k9fBheV29vH
	KCUwy04N3hISu3takuDFpikUJbJfGt9afESRjUU77JVpYQMunzsYq53e1evvnjG42FwEzj0Cusy
	57jK9eJjhm0hLZMrXfXC7TFkDfT3Z+p8qe00cLLabjh3P0/QCJktSYV3uReKGXKyl+in8rJdXZr
	Piyh5TMD0yKTndPk9ULGhlXcSob9rb9vtS3YJjVQJqSoIYZaz71t/LTudej6V4ExfHoCUIMGa3l
	T7lamyjlD3G4ZzUhM2RJ2BZwKGWaRc4ei/WHwHx2Cfol5svfblImMv/NHOOMPsWH/eSM4H0PLSh
	cOeOlDO4Mdm3QFMIhbEIjMTrqSZ6AsYRShAsYiW9WQijFrRikVOhgnLGGVTEfESG3K6BpmbvFq1
	3Ix/f20ReIs6LCul6F
X-Google-Smtp-Source: AGHT+IE+kO+0ih3otr2ilVER5YmhgcFdSR2CzWc/DSxY990pGJYLOQdsIKv6VYHabOMyYhFDg7EDug==
X-Received: by 2002:a05:6a21:329f:b0:2ea:12b9:2dfa with SMTP id adf61e73a8af0-334a861fea6mr4543402637.40.1760695353736;
        Fri, 17 Oct 2025 03:02:33 -0700 (PDT)
Received: from sunil-laptop ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3173asm2358675a91.12.2025.10.17.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:02:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:32:26 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: rafael@kernel.org, regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	apatel@ventanamicro.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Daniele Cleri <DanieleCleri@aaeon.eu>
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
Message-ID: <aPIUMoDxW-yl2nPm@sunil-laptop>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
 <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>

On Fri, Oct 17, 2025 at 10:50:05AM +0200, Thomas Richard wrote:
> On 10/17/25 12:22 AM, Sunil V L wrote:
> > On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
> >> Hello,
> >>
> >> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
> >> noticed a regression. The driver does not probe anymore and I get the
> >> following error:
> >>
> >> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
> >> initialize FPGA common GPIOs
> >> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
> >> failed with error -2
> >>
> >> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
> >>
> >> I did a bisect and I found the commit which introduced the regression:
> >> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
> >> to support nargs_prop")
> >>
> > Hi Thomas,
> > 
> > Could you please try with below change and see if it resolves the issue?
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 1b997a5497e7..43d5e457814e 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >                                        size_t num_args,
> >                                        struct fwnode_reference_args *args)
> >  {
> > -       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
> > +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
> >  }
> > 
> 
> Hi Sunil,
> 
> Yes your change fixes the issue !!
> 
Hi Thomas,

Thanks for confirming the fix!

I'll send out the patch shortly and include your Tested-by tag.

Apologies for the earlier issue, and thank you for your help.

Best regards,
Sunil

