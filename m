Return-Path: <linux-kernel+bounces-823851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE132B87931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04BD1B23A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733091DDC2C;
	Fri, 19 Sep 2025 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmWAhIhx"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F60273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244352; cv=none; b=U3N5h3K2r4Qo8FEhuXrLx1eFTGSJonvFDaXUmhWJ4SzCUBzC7rZOdC2/nVlVEgaZP4Lz6oyMQx1nfmMNPwtvyStMhNNjqur9ob075bYryCN9wGH1zbDBlRnV5vCcO/Az7Bk51TQaK8SThVGEDn0qj6EACT350eHq++HP9fZVjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244352; c=relaxed/simple;
	bh=NG9G6qkcd55l7sxI5pzc5l+YODe2sfMn5viC5nVCsbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezNVN4kYC6nWhbapySIgt3yDVY77CSvCj8KcsUVC8qCju6W+UiYJ3O17XDv/ZnawcF4kLyXcb8B0rAFbZKKXiieeQ/mlqwJ/p3OjkV2BpKW3cXnymeS4ODHcz3uizfKMHf/12viMvPcXXfLdQx9DSHWVjD1YxPQPziDOwPrgf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmWAhIhx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1120708a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758244351; x=1758849151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A48yMdinMY4TsMoA5WhtjSNisYijRwjFPVTZOj60lQ0=;
        b=WmWAhIhx1udw9SygcsB/pxfIw/Uw1Bv5PgEROxlmI4wIaaOmsQaoyZFx5oKJZbHKd/
         ZLQLcIrGPqM1OWRCN0T7e2cOBiHrzSB3kQa6kITUV4+cxlQkv0tebCVlQO4CcGqzVhcR
         2U5SjB1+ynG9DewR20KhFrn1vrcL2pu9PFZv+Wktz0lWmrRRpgx+9u4aHE+P75FsCZh3
         TyWpSS5qI5pYg2mibIYv6mSmx6uSxKAIrFz0u8+qy+Yqe/iY+FAjtAlYQ9aJxHpsD7Up
         1dMRsZR6xI7oEydr+nZCV1ZJfCy12qOM4BZcili7DJnokWUrzrsp/4TjmjfHrvrHXMVT
         3Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758244351; x=1758849151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A48yMdinMY4TsMoA5WhtjSNisYijRwjFPVTZOj60lQ0=;
        b=uRdwMxfu3gEoFbaKj5Qm9EXUuhrMF1+1X87KnDscZkazwf9+EoSWvkfiuqeRJcJKOm
         NcUztf3npL4H8bADgBWdEBWwU9t8w/i10taXcCB8PLoK7e8Z4obf2SsF1mbo36fKbfO8
         CsFHSoh7Vf0ZyJiDuO/kVynQIp9KNoyfYhozfi+G8jVxTMiUGGxStjOA929pU/Cjki0c
         /xd3YVrkdrkJ3komNsymctUe5l09bTAxHvT8o2pYVEmKqMxOtgLbRBZxNwePk3Sio3WT
         t+MTpDzr/ITLmKxmcE2SejtsRZhflDwq/5X0enkoD1b7lYn0mXOXpXaL5WCzJ9yiH01R
         XWBg==
X-Forwarded-Encrypted: i=1; AJvYcCU24N+XnyEHXg9YewM0wOv97kTA5Z7NxRxx1e0zwlKCcakQk5XrjYDqpCOctOHiFMgxu5RoRJFH+cVNnGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWftunAS2lRzr6C3+agEuPDGbRuJExZeblFgR2ZlG8X/3dgJZ
	gWwHX3xnF8bTSBoBTYCGV6qBABfJhkgSKpNYjdg0D53QmcvGUoddX2gp
X-Gm-Gg: ASbGncsCiT5FZQ6Wj35Hn4ii5O3RaoFWezBg8rdhAg497iHqSJTLX65EGTliVmlpfWY
	p0gKViz/Gpstig7RZ9PYStYW6Hn0rAAz3ugzfwsSfGhjmo9z5PBkUgBRydFunpgh1BLEW0j85km
	44f5D+XWRy7S15SQZwu9Qtwens/JZ+9gkC1TTh/9YdK1PLDxyA8SW+muMoTfUS0WLmFgNo3g9DW
	keAAa2c0TQRwpstfZYGfe8LiygOXx7sgqFCI+9Ndzj5xALIKy9TgP4ZVJYTMGBU0f9+ew4kzVQY
	W1OU7Rvrylr1ILKP4dydzH53AqqWw7TVyIt4jKKK0IbZUxa7q1H7cTVx3UnnW3mqyNnAzaonILX
	xeVBcSKMMr387+e7P+TFLmBs=
X-Google-Smtp-Source: AGHT+IGjYX11oCrTtfxdx4vWRKTaE6PAVgpbO6Y8EQGn0PtwNPXtesJFTQwPRO+jaBSBsmPP7H+GGQ==
X-Received: by 2002:a17:903:944:b0:24c:b39f:baaa with SMTP id d9443c01a7336-269ba579989mr18144535ad.49.1758244350465;
        Thu, 18 Sep 2025 18:12:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8e3e:e1c9:1151:50c3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55199e08f1sm402995a12.24.2025.09.18.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 18:12:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:12:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Vishnu Sankar <vishnuocv@gmail.com>, hmh@hmh.eng.br, 
	ilpo.jarvinen@linux.intel.com, derekjohn.clark@gmail.com, mpearson-lenovo@squebb.ca, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Subject: Re: [PATCH v3 1/3] input: mouse: trackpoint: Add doubletap
 enable/disable support
Message-ID: <fgizjuhcnl6rfawrqnabkhijf5uzbczen6k5zp6z44hycjqylx@6qzi54baxivx>
References: <20250901135308.52340-1-vishnuocv@gmail.com>
 <CABxCQKtEcFozTtuV3sutU3OyobTbpA82Uy=MyU0FQePPT7S2Wg@mail.gmail.com>
 <6e834cb7-565b-4a4b-bf90-4765f5fc9cc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e834cb7-565b-4a4b-bf90-4765f5fc9cc9@kernel.org>

On Thu, Sep 18, 2025 at 09:31:47AM +0200, Hans de Goede wrote:
> Hi Vishnu,
> 
> On 18-Sep-25 4:37 AM, Vishnu Sankar wrote:
> > Hello all,
> > 
> > Do we have any questions or concerns?
> > Thanks in advance!
> > 
> > On Mon, Sep 1, 2025 at 10:53 PM Vishnu Sankar <vishnuocv@gmail.com> wrote:
> >>
> >> Add support for enabling and disabling doubletap on TrackPoint devices
> >> that support this functionality. The feature is detected using firmware
> >> ID and exposed via sysfs as `doubletap_enabled`.
> 
> Hmm, you seem to be using a firmware ID prefix match, combined with
> a deny list of some firmware IDs with that prefix which do not support
> this. How do we know this deny list is complete?
> 
> Also as Dmitry says you really should use the is_visible() callback
> to not show the attribute at all on unsupported systems.
> 
> >> The feature is only available on newer ThinkPads (2023 and later).The driver
> >> exposes this capability via a new sysfs attribute:
> >> "/sys/bus/serio/devices/seriox/doubletap_enabled".
> >>
> >> The attribute is only created if the device is detected to be capable of
> >> doubletap via firmware and variant ID checks. This functionality will be
> >> used by platform drivers such as thinkpad_acpi to expose and control doubletap
> >> via user interfaces.
> 
> Hmm, you refer to thinkpad_acpi as a possible consumer of this
> functionality. But you only add a sysfs interface.
> 
> thinkpad_acpi will need some in kernel interface to use this.
> 
> Which brings me to my main question: thinkpad_acpi is the driver
> receiving the doubletap events since these are send out-of-bound
> and not through the ps/2 trackpoint protocol.
> 
> thinkpad_acpi already has the capability to filter out these doubletap
> events and report nothing. Why is it necessary / better to disable
> the doubletap at the trackpoint fw-level, rather then just filtering
> it at the thinkpad_acpi level ?
> 
> I don't really see a big advantage in filtering these events at
> the fw-level rather then in the kernel and we already have the
> in kernel filtering.

That is an excellent observation, thank you Hans. The frequency of these
events should be extremely low, so cost of simply ignoring events should
be miniscule...

Thanks.

-- 
Dmitry

