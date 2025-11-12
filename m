Return-Path: <linux-kernel+bounces-898143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64255C54715
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFAEB34656C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFAA2C2357;
	Wed, 12 Nov 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5AJgxrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8922578D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979150; cv=none; b=ioBAH3fmKO8vtqXUq9kVk+L8gjqV0X+yzGLzSqiR0tBuyQT9wHAgho2wPDfd7IlBDQwXPAsCjJbjWSib0DQuVeYdE25knQkof44S3E91rGQAriFl2PFNH+PbOPu+IGqK/yJrWwRqifdk65Ii3XmGsLET1IlaTgBd68PbgIUL2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979150; c=relaxed/simple;
	bh=cgGge+dwMmPrK+ciZBU6rz22dQLRcQpKCH3b3eB23F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4sBA2cfMoTtj143EyE2kTWxhcjJ8OjjeZNGWjWydFI/JRTszBKcHZtAlsZThLLCAKXK0oJpF7VXCXNWt41MRHexAov7v/GxBD1aWS1sWgaMoy/bj2e9s+kYadGPll8QmPPbsaE6dN2gYhoNapNQGrrRAz3Ny+BL8DeprvpvKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5AJgxrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD66AC16AAE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762979149;
	bh=cgGge+dwMmPrK+ciZBU6rz22dQLRcQpKCH3b3eB23F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5AJgxrZx/YtkUBDacFINXJRH1njgHUa+opNR3y/A+UXBK9i6mryqDR26orNDEuOg
	 bhIgPuTacTbmMhF6Xx8Co4rfCGC7Z4nsR6c32Ma9MyAzwxAx0zuvFikJt7sPkCENil
	 Pehm6XsljO0uQxKU+8zDsuQUMhVVjb0tyP+MHZ4XkPKYgzCqT4NJhwer/lbIw13V0A
	 FvFXTt2V1RaeDOIC+wmbm/wsnoBoWp+q4N1xjv8ClTCy49l+im4NH33QPQS5lWKKI6
	 kl1/SxMIJsLAMUU4EmAIpotzF4WPfGNBHoZCQWA+NC/EhDroCEdq/l4xr7KS3zt390
	 bw3Y7oXqdJcPg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-656c07e3241so59274eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZM1GQseTMtGH/qvawN27sYDXtJnky1XqJdc3jw1kOuWF9jmpn/awT3hPlYYkDYmmnMi/sXX/Wxs2Tfjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhvnpctrS9s8G8wLKajz8E3ZGA4kC+AdwnT2QLbG2L24eWCeu
	p5qukapwEstIOI1cgCbxvtDtmqn4jf5br+qhcjUPF+Q5x55VRxsxKWKX1OpcLwZTg92xBpXBiZH
	GBs0/I2rWJPYhYCvgJ4g4IeIJEJeWmA0=
X-Google-Smtp-Source: AGHT+IEKwzEfElibNCzBiXdHUCqix10pctigzcdu3yw3bAN4/xs6NPsBv5VxA5wX/pqJykBBwUm9XCNPfQC6Jukronc=
X-Received: by 2002:a05:6820:308c:b0:656:9e1c:3a6a with SMTP id
 006d021491bc7-657161afa92mr1698124eaf.2.1762979149224; Wed, 12 Nov 2025
 12:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111075000.1828-1-vulab@iscas.ac.cn> <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>
 <aRSczeIXvymTQN3D@kekkonen.localdomain>
In-Reply-To: <aRSczeIXvymTQN3D@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:25:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtmBGOP2fBPRJr7r38iboHCa9ZyLR_smBmBNzQD2jxnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnA7q5-ZmGsQRkP6w_V7WbKpsTDmpy4nagzAHslZceJDIC7BER6lZexzlI
Message-ID: <CAJZ5v0jtmBGOP2fBPRJr7r38iboHCa9ZyLR_smBmBNzQD2jxnQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:42=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael, Haotian,
>
> On Wed, Nov 12, 2025 at 02:48:30PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 11, 2025 at 8:50=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.c=
n> wrote:
> > >
> > > acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtai=
n the
> > > parent fwnode but returns without calling fwnode_handle_put() on it. =
This
> > > leads to a fwnode refcount leak and prevents the parent node from bei=
ng
> > > released properly.
> > >
> > > Call fwnode_handle_put() on the parent fwnode before returning to
> > > fix the leak.
> > >
> > > Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmw=
are specific locations")
> > > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > > ---
> > >  drivers/acpi/property.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 1b997a5497e7..7f8790e8dc4e 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1714,6 +1714,7 @@ static int acpi_fwnode_graph_parse_endpoint(con=
st struct fwnode_handle *fwnode,
> > >         if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
> > >                 fwnode_property_read_u32(fwnode, "endpoint", &endpoin=
t->id);
> > >
> > > +       fwnode_handle_put(port_fwnode);
>
> I'd add a newline here.
>
> > >         return 0;
> > >  }
> > >
> > > --
> >
> > Andy, Sakari, this looks like a genuine fix to me, any comments?
>
> Thanks for cc'ing me.
>
> On ACPI fwnode_handle_put() is a nop, and presumably a parent of an ACPI
> node is an ACPI node as well. So this doesn't change fwnode refcounting b=
ut
> is nevertheless a good thing to do for API usage correctness.
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

OK, applied as 6.19 material, thanks!

