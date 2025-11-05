Return-Path: <linux-kernel+bounces-887390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C303DC381D5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D064C3A8A29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8A29992A;
	Wed,  5 Nov 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+vTp1W4"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39502296BB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379427; cv=none; b=QzKBsFwtyyLTPJKvp/ds9VaGo5gsIDV7ryD3Ox149+70Q7xhUHyFaGWFDgVVlJok+kiMMiCXNAhTdgpnA8GMSGrO7MNj679Fqa5u35hq0SMU02tNCGKl1Tcr4Fc6VS5Ej7Ipz1E7/EBUzlnJJ9MVBMXTDSYmJB2vYnhXUlwuu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379427; c=relaxed/simple;
	bh=gZ380I0iSEejLLF800fnaHD9+ZfISv/wsUJeZNhR7Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkUoosACavXRDteE91wjUmyZ1AvhO11ZXIyGmljDxvnIVDrvneMoSTlD5Xez2qNPvbwGSkNnFGWFy/xQhNUMZofnBZOb+AvvRfEG+5iiwpf+K2pvK/uFJ4L32w+QaY3jN2m8XaFT+ifsSMMqY7AH4QtgqK1WDyGCEmiu1w3Y4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+vTp1W4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983bae80so163621a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762379425; x=1762984225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkJz9g+z54wExynUelx6wglM9y0gBWoZJbd4IPl+Sqg=;
        b=F+vTp1W4SoFJpnBf+kqRgFwXPXlt/dZvyg1FDJwgoyuYnMTbx7s5ueeO2aoOqlfFRc
         D4yX863oBEOeAQWV/VCb/YxxXK6Js1rY6V4Lnjc7wWQwlHIZM50e8pLQj1nTjaSyXUDQ
         cGbBBrRTH2AevK+H4nY7/JX+1WIOT1xJRa7XZE0fQv47I8nM/KkEq4Zn/WGWyPeSBaSl
         tAFMbz0FkDnraREtgzcePy1dQ0/ubTu5nKE3mwQr9JasANzWsUdGlM2o111woPRPzjDu
         8Cyb1b+pkr5OrpRuadkEm5G7RjoujnbPHlGprfiX2dM5/13iMtxqL98RhSPwq8YE3epq
         buEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379425; x=1762984225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkJz9g+z54wExynUelx6wglM9y0gBWoZJbd4IPl+Sqg=;
        b=sVLTJ+dEskTxR3etTNGJNpARXGMfdq2bMdG0cwNCL62dWlA7IDlLsfYLLWujsGd30V
         ddC/f8L18kdF678ULtphz+UB/8kMMAPPeoW7nIpZTt7M/pTsDf5Z7P/g1tjMkveeZz1T
         MOX1XcQikQvgzy1Z0mkWljU4GOYi7NhMw/J82Q+GgNgoXO88Y0utc2znsi1+JMIJlXjr
         aVjDjOYp+dHcBV6gh9mWQGcOCcjBMEq5oJlXAKsQNPc51Tsr3+Vw0CG9XZ/9KHvVcO6L
         uPsBB27yrb5kktCCGkXGqfSi6HjWZt4dOlyoJf0zX6z9c5gPuT0+DlnOfc/OFwo4qjjb
         OVGA==
X-Forwarded-Encrypted: i=1; AJvYcCVN8b5YXv6VkWNvMnz5s404OxhIEhgbBjaK+sSjVVklykKAsfeOqhuJ00tWDFNxgc/Uv3jnEkfGxpZzRTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EZAA2aSDBA0ymiJVnyx7WiVkIEF7ra0zEIrHX/oVFgauy2f+
	8CiZhUbbfRa1zp3cat1W1F3LR/trAJG8gqfA7PWgdh95qWv6/jre2rf0
X-Gm-Gg: ASbGnctl28jfHSa/VqpWa6XqDikeaHWz5/yByffhp/xQ24oZwY4VRBwHZwEbi432oJN
	iO83jcOSFdMU0TCoySBNgl0qITHuTTV+GJLCo96biC7UMQMNj8LrF1QoNhahyGyvxnszZJ0DCZQ
	SWy9utJKF4M8QRAM9NSKV28LJSJyggaG+QCT5Jt20xPJamqg3RjxSy/3JzWeGs5TErowyFdCW9P
	ubss8ejDDJbwrbGWc6iupg4Ws88TvoV6T8yrygquIvQVwaUOBu4tI4NRm4M1xWv5qSTHTjc0Q3/
	q6zl5bmVqqfklyeaApL10BPke1dYETaY8Rg3pWYXF47kb+UzmOOxwwU1CAQRS2AIIHulGalmK45
	QOP+PXW+TwtW7Yb0IGE0T0cSo+jqouP1Ztey0Ebpk4fa5iH3zpa2onxWWNf4ZLidDwxmf3xzs2F
	zl3tHJAmaEGiGynJICMoGlOofelDLbWX1usjNS3X91vw==
X-Google-Smtp-Source: AGHT+IFMkzfsbijd+VCoID/c6AsM0dQ38208M4pgSEwiraeFpdyxx2AcFvyuO/wBvwY6fhwy/w0BQw==
X-Received: by 2002:a17:903:1ce:b0:294:ecba:c7f with SMTP id d9443c01a7336-2962adb9771mr69381825ad.48.1762379425495;
        Wed, 05 Nov 2025 13:50:25 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:35dd:7def:e1d1:adfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651045bf0sm5331095ad.48.2025.11.05.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:50:25 -0800 (PST)
Date: Wed, 5 Nov 2025 13:50:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jonathan Denose <jdenose@google.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: input: expand
 INPUT_PROP_HAPTIC_TOUCHPAD to all pressure pads
Message-ID: <7h77umivuixhxkktdcypzthlrm6xll4524e4dy3cb54iljeox6@guwqyvx2e2pg>
References: <20251030011735.GA969565@quokka>
 <20251031041245.GA1316325@quokka>
 <ueksimssfw7eqxa5mfmxruj2ghtuncznhbgdxvoorjf6jhjfhk@hsuapbn3kie3>
 <20251105060333.GA2615904@quokka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105060333.GA2615904@quokka>

On Wed, Nov 05, 2025 at 04:03:33PM +1000, Peter Hutterer wrote:
> On Tue, Nov 04, 2025 at 09:09:09PM -0800, Dmitry Torokhov wrote:
> > Hi Peter,
> > 
> > On Fri, Oct 31, 2025 at 02:12:45PM +1000, Peter Hutterer wrote:
> > > Definition: "pressure pad" used here as all touchpads that use physical
> > > pressure to convert to click without physical hinges. Also called haptic
> > > touchpads in general parlance, Synaptics calls them ForcePads.
> > > 
> > > Most (all?) pressure pads are currently advertised as
> > > INPUT_PROP_BUTTONPAD. The suggestion to identify them as pressure pads
> > > by defining the resolution on ABS_MT_PRESSURE has been in the docs since
> > > commit 20ccc8dd38a3 ("Documentation: input: define
> > > ABS_PRESSURE/ABS_MT_PRESSURE resolution as grams") but few devices
> > > provide this information.
> > > 
> > > In userspace it's thus impossible to determine whether a device is a
> > > true pressure pad (pressure equals pressure) or a normal clickpad with
> > > (pressure equals finger size).
> > > 
> > > Commit 7075ae4ac9db ("Input: add INPUT_PROP_HAPTIC_TOUCHPAD") introduces
> > > INPUT_PROP_HAPTIC_TOUCHPAD but restricted it to those touchpads that
> > > have support for userspace-controlled effects. Let's expand that
> > > definition to include all haptic touchpads (pressure pads) since those
> > > that do support FF effects can be identified by the presence of the
> > > FF_HAPTIC bit.
> > > 
> > > This means:
> > > - clickpad: INPUT_PROP_BUTTONPAD
> > > - pressurepad: INPUT_PROP_BUTTONPAD + INPUT_PROP_HAPTIC_TOUCHPAD
> > > - pressurepad with haptics:
> > >   INPUT_PROP_BUTTONPAD + INPUT_PROP_HAPTIC_TOUCHPAD + FF_HAPTIC
> > 
> > Should we maybe rename it to INPUT_PROP_PRESSURE_TOUCHPAD? We are within
> > a release of introducing it, so we should be able to rename it without
> > much fallout.
> 
> I'd be happy with a rename too. Want me to send a patch for that or do
> you want to rename it locally during applying?

Please send the updated patch for input.h along with updated
documentation.

Thanks.

-- 
Dmitry

