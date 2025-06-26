Return-Path: <linux-kernel+bounces-704952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F435AEA39F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B8A188073F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FE212B31;
	Thu, 26 Jun 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyJeW8fC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D72211A29
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955933; cv=none; b=Aa59t99aaLKIxi7/BxslyDRnx+NI4r0Gt0JveHRkSJ/ghplWuIRJRbdUB/4q26P6nHsz1qMS5ApVIRe8NO5uXVioozmybvjYPY7MiVRJAHPXwHkRL3Jh10VdfldYbafaTajg8584VS9mKsSBIgueKtW+4Jj4sIzQXR4FdJkooGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955933; c=relaxed/simple;
	bh=4tM+osFLm95F10wmg1hWXVqNZ33jb/n9KzTYrLGnO40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFsjC+FzRFkr//4jjcgEN0vH4pRHBS9zZJkXr5c5OL9hWNkMPIOep1sQef1gPhKAJGWaHSafQNVVG1i3CTeS9iaulWXDOhmWFFswWZqpKjizAhm3JohByb1K34dL8G3fU1e6+9uNiTjTsorOFF/Pri3CzyLjfpWUwhobuxXAriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zyJeW8fC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74264d1832eso1730913b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750955931; x=1751560731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvhr4Hd42xq744xGvgbZzLcER/F+YlE4VE7BOc+9sLU=;
        b=zyJeW8fCkW1IexiVQQVsiddOsKr3fmmRlZ/gw+LxuiWqhubFRWmnnC4/wLAQRW1/cA
         GFaPvN+a/us2HCzjJz6aa2fRMJ7WR+cYyRsJfEY2Nf1ATGWA6SKw1InMC1q4u/mgENh9
         sknM/mb8GhpSJ0gQ+67APRkS8z1QinSB0TZemgNicj5ZkWcv8lE7TuBw52rbcjRqwA4d
         d6aTdh9VNjDWewHjV/ILBU3Rs+/sikp0eV7Dz3/7J+zs+PmKlPy+ktukkoN2rtfEngp8
         A/BlBEz+ouOU1SgpD3W5MQP5GGJLKDoamyjtNTShhSBU4Sj/9ephb6tr8x+0z/7SWz3s
         omHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955931; x=1751560731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvhr4Hd42xq744xGvgbZzLcER/F+YlE4VE7BOc+9sLU=;
        b=ECaUdAivtM/9KyVQ+X5Z5feA7gjXg8YPePmDOHG208Lfg06pxNTM7op748GfLy5nyf
         P4mAaaKj33gPIFJgUokUUwv0wFSp1Wb0InGekYPVN8LJ4RC1FfJfxemTbUTcF16At90Q
         z4HOULfn+8nh/pAxpJFy+0JIpkQ+6XgR8cjZ9EnjwZ0ngMsO9vxWzeKXltb8wKoCk12k
         iTNSF0U7rfPOR7FYx2719ihw6FzeKD+35tQgUpUSW2OGj8Nc8UWqNJ81gq8lwzFsLvtY
         Aq66cAc7O1pSuK3+A0z+xwKEKsflGAD+7U18eFZ7WybxJeZTOfPyVDoT7Hju0/i+9z4t
         LEZw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOGo6/Q+9WKTCzGxm07BykfVSHdOm425VXwkmizjVdHOjMaKJDLSkXEgdrJMO+gZICjRQvKRyZFUsghM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXToQuuB2ORjKqC3rntvtYMpiTd0FGBI5LH9QeUvuvUxc09ax
	XjVH/JrYlHzFgvHg9s+kGrrLoS8ES6S07OiZSL3RgGPA5N+uba4xxXLxd8bP+NEEf0Y=
X-Gm-Gg: ASbGncv6uPVJ03XUpOmhTUHfL1NowSREt6TaYDFNuaxVo/7mJre2xVtbwgHwXPLG7wF
	mdQmZFAMx4pQqTt/Ib74XgU92ULURN18/Dx6RYRk9XZqdq+0IWl+jw25glwwapU8tFeDu/RN/5o
	7nGDz9gELgwLgm4maSy5RCIuXraiC6EI1tGH0mPowJc3fKzn7fC3uRp6ibi1N0+QsGbBb9Oz2vW
	3VUTfyT2dBbdxvbftDKiW+ON53uD90eDZ8/FbtKCezLTC0xvOAW8wZ79M5A9UT+n4UOlU3hmWkm
	Di9D8ys9FqgNNWlvo7TyzeuxWQw42SRvJq0EbSDxQEmXsXOghUeJYolLFJpvg2gtJA==
X-Google-Smtp-Source: AGHT+IEjuEd/+4xRMbzboGHemRO7m2WnkSGGA6KZ1DSWu6K0FQ5qJhdZ8YASpAcYjCqHtKB3BtTM2w==
X-Received: by 2002:a05:6a00:1141:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-74ad45b0013mr12097671b3a.20.1750955931088;
        Thu, 26 Jun 2025 09:38:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8327:3d7d:46f2:c531])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c44460c4sm2094220a12.45.2025.06.26.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:38:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:38:48 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: char: Export alias for RPMSG ID rpmsg-raw from
 table
Message-ID: <aF13mM9PSvTnKQ1k@p14s>
References: <20250619205722.133827-1-afd@ti.com>
 <aFwgQJ8B7EcjM1q7@p14s>
 <a6d77856-cf9a-48f4-a66c-d124752b5f64@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d77856-cf9a-48f4-a66c-d124752b5f64@ti.com>

On Wed, Jun 25, 2025 at 12:12:03PM -0500, Andrew Davis wrote:
> On 6/25/25 11:13 AM, Mathieu Poirier wrote:
> > Good day,
> > 
> > On Thu, Jun 19, 2025 at 03:57:22PM -0500, Andrew Davis wrote:
> > > Module aliases are used by userspace to identify the correct module to
> > > load for a detected hardware. The currently supported RPMSG device IDs for
> > > this module include "rpmsg-raw", but the module alias is "rpmsg_chrdev".
> > > 
> > > Use the helper macro MODULE_DEVICE_TABLE(rpmsg) to export the correct
> > > supported IDs. And while here, to keep backwards compatibility we also add
> > > the other ID "rpmsg_chrdev" so that it is also still exported as an alias.
> > > 
> > > This has the side benefit of adding support for some legacy firmware
> > > which still uses the original "rpmsg_chrdev" ID. This was the ID used for
> > > this driver before it was upstreamed (as reflected by the module alias).
> > 
> > I was surprised to receive this patch - my question from almost a year back is
> > still pending.
> > 
> 
> I answered[0] your question and never received any follow up questions so I had
> assumed the answer was satisfactory.
>

Ah!  I never saw your reply, apologies for that.
 
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > Acked-by: Hari Nagalla <hnagalla@ti.com>
> > > Tested-by: Hari Nagalla <hnagalla@ti.com>
> > > ---
> > > 
> > > Changes for v2:
> > >   - Rebased on v6.16-rc1
> > >   - Added Acked/Tested-by
> > > 
> > > [v1] https://www.spinics.net/lists/linux-remoteproc/msg18959.html
> > > 
> > >   drivers/rpmsg/rpmsg_char.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > > index eec7642d26863..96fcdd2d7093c 100644
> > > --- a/drivers/rpmsg/rpmsg_char.c
> > > +++ b/drivers/rpmsg/rpmsg_char.c
> > > @@ -522,8 +522,10 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> > >   static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
> > >   	{ .name	= "rpmsg-raw" },
> > > +	{ .name	= "rpmsg_chrdev" },
> > >   	{ },
> > >   };
> > > +MODULE_DEVICE_TABLE(rpmsg, rpmsg_chrdev_id_table);
> > 
> > ... and I still don't understand why this patch is needed.  What is broken that
> > this patch fixes?
> > 
> 
> Today when this driver is built as a module it does not automatically load
> when a matching firmware is started. You can see examples of documentation
> working around this by manually loading it[1] and even applications
> attempting the same in code[2]. This should not be needed. Here is why
> this happens and how this patch fixes it:
> 
> A given firmware that makes use of this driver will have one of two
> RPMSG device IDs: "rpmsg-raw" or "rpmsg_chrdev". Let's look at each in
> turn:
> 
> If the ID is "rpmsg_chrdev" then this driver module will be loaded into
> the kernel (that is what the MODULE_ALIAS line below did). But it will
> not cause the driver module to probe, as probe is triggered by a match
> in the above rpmsg_device_id table.
> 
> If the ID is "rpmsg-raw" then this driver module will probe with the
> firmware, but only if this driver module was already loaded into the
> kernel, or was built-in to the kernel.
> 
> By adding "rpmsg_chrdev" to the table we make this driver probe for
> firmware with that ID. And by adding MODULE_DEVICE_TABLE we make both
> IDs trigger the module to be loaded if it has not been already.
> 
> This patch makes it so both IDs do both needed actions. Where before
> each ID would only do one action, but not the other.

The part I was missing is the call to add_uevent_var() that uses @rpdev->id.name
in rpmsg_uevent() - with that in mind it makes sense.  I have applied your
patch.

Thanks,
Mathieu

> 
> Andrew
> 
> [0] https://www.spinics.net/lists/linux-remoteproc/msg19814.html
> [1] https://github.com/OpenAMP/openamp-system-reference/blob/main/examples/linux/rpmsg-mat-mul/README.md?plain=1#L42
> [2] https://github.com/Xilinx/meta-openamp/blob/master/recipes-openamp/rpmsg-examples/rpmsg-mat-mul/mat_mul_demo.c#L306
> 
> > Thanks,
> > Mathieu
> > 
> > >   static struct rpmsg_driver rpmsg_chrdev_driver = {
> > >   	.probe = rpmsg_chrdev_probe,
> > > @@ -565,6 +567,5 @@ static void rpmsg_chrdev_exit(void)
> > >   }
> > >   module_exit(rpmsg_chrdev_exit);
> > > -MODULE_ALIAS("rpmsg:rpmsg_chrdev");
> > >   MODULE_DESCRIPTION("RPMSG device interface");
> > >   MODULE_LICENSE("GPL v2");
> > > -- 
> > > 2.39.2
> > > 

