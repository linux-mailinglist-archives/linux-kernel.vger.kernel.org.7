Return-Path: <linux-kernel+bounces-892813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57400C45DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00860188F29D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA8305066;
	Mon, 10 Nov 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Bc/nggo4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B512FE57B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769872; cv=none; b=PH3xRPrE/UdHr+A/Ya9rt8zOLsm0LEuWb0CbZ3/IPCbOZqHqHYbC1XSIYvPmyVRja0FAL1zM/bdHeNLnvtWd7Paja/8vLyz8jmNxMoGdgeVeGwCBPo5iXcnfhu+gpQxl/Pun99YeYUqwPhiMjzLAc2suSWUq/VTiBAxWhbqOeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769872; c=relaxed/simple;
	bh=ytVSzmYaDqD0qwMAifjOEvYSRHFoM76EE2Q+SxLmLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBJ8SwHQrOvL/Xd+pL2Va7+A6JeUK1ktONKjr8snhluIzkPCIlZO1fyRo+PJjGLvtO4FAqH2Q+9gOI3yj6vLIfmotq4YnfAB2I+y8oejyVeyNHyc9HmzYfKVMG3nlpIfMMLJ/nr8WIuPpncMO2bx12nkJwpqypCF/CutAtnNBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Bc/nggo4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so230238f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762769866; x=1763374666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cGOOrdlJvwUvrBTIxkNqf0S9KSK2YAvxzQBiD0nhFs=;
        b=Bc/nggo4DD+U+wO0qS71yHjtA7jHJNMLKFlQ4bOmL2fIOp2OT/FsuO1q66wZag0ZlS
         wcGRYBnT0zqQSZfATNyZHGrhXwJ9vHIWfS3tmBd8371aRKOZY5AIqkF2ZeRKCcpeYDTW
         0/L2STKrv2P9/MWfgqIb0Y7qwOO/pTN+17cn4GKmA4BrMh6Xv791vJS1GPyqzEfvuDQD
         8nC/kdZdz4nuA0f4mHmT8cvBjvWg48bb4k/G06dwlRU8in5PqCdwgkl1zp9xQNRLrBoe
         kROW6uuxpjM6Ta/EvddLHx+IRzoiDEs70lx4pWkFIciy5lo1qk0Ahddn4MN6rscJiDe7
         MVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769866; x=1763374666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cGOOrdlJvwUvrBTIxkNqf0S9KSK2YAvxzQBiD0nhFs=;
        b=cjUVoD8Htk1ch115xfcWY16JyrI0uovvajcFNISP/qkrXCXfij/NRThF8pDl2D20/D
         qliEHhBSIotetpCq11EJVRRd/ePHb9MRN3jsuIrQh+cyD4i1bzTE9TAKp4eRUAt4HkLR
         DxiU7GJcYRVFUjmJOuSFXphnyg5h1CQxFME2eDZd4f/HSsymTMM0en1W7+As46SDX7Pb
         +G68vpGtfYl5BZoTBk2OhUUkgIa8ekE2RFI7dJzgVjxjSX+x0m/t8f93EWmirdYiip4O
         jZS89AXwO5JCn97p09PgouKT+momdzdmkHUfw4y/0xMnT4wSoquUROqLai9c+4LgR2Os
         AcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnE+I18JOLWeUST55Us+KvI3HUDbw+NmfclvpnqO2bSn29Gnntdv/6R0lhlpjznMkpDZTFaL27WRnmZhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFd5g5aXP6bDr80FJ1Mod4RU2Rj3y7t9EChKUkCLqD36P9LqQ1
	Z0f+ZSMbgWcyFw826QM0KlpbnOj6hyjWJlyzUvist1/bByS7onCKKAH1yC/6xd69rJI=
X-Gm-Gg: ASbGncsvQw+afNZ0ODPxwsnKzoNScfItsQAjSM7So1/lg87XAmrOC+FY0nU4rhTWq/9
	YJ591coOfilGXhpHIDSDEiRrzGMmoYv0rAkNHeUKCgJXVhecHO18m7dQNACmI4BnXPRfjtTpEye
	/CHjUybwMAPTDnsQUbIWyDI60SfJm93M9sMy+Pg9JuhMm7gi0Z7JiFNLxfAmpjFEW3VXXhT0aaW
	vO+a0W14smDP7cQL6HKMHArJ/1iljBUkZxGL/nYEhA2UQv0PwW9eE5Q5jnrgqrSbxKgRd9L3YWq
	JEh4xzdRWItl1Q2hMYzEASVPBIXErcqRfIPIgi9fM1omfx5VrO7w0Gw1ECp3ov11YhVZaj6B1zo
	2ZiqvleBszP+NIOIAIYvep0J5hOfCTvECfvdZ9wcBRrTyyFG94h2RflmWODjvocFKjtKCWFz3gv
	6Mxpvudye1ugyVI5Y/RbrxWZo2BMPMFIteXBgUpsaUS+aIwUEsKTrgb3YOmAg=
X-Google-Smtp-Source: AGHT+IGUpHSfeagdIBM88vePaTs3yIVY9gCWpK2lN42s3k1Y6AfvZPuuxOVOOc+I4rI5U6e1xXLxSw==
X-Received: by 2002:a05:6000:228a:b0:429:f088:7fb with SMTP id ffacd0b85a97d-42b2c655058mr7359131f8f.7.1762769866339;
        Mon, 10 Nov 2025 02:17:46 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2e96441dsm13918929f8f.23.2025.11.10.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:17:44 -0800 (PST)
Date: Mon, 10 Nov 2025 10:19:56 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlight
Message-ID: <aRG8TMqehv-oR6v1@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
 <aQ4a2SBDldYgQb56@aspen.lan>
 <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>
 <aRG359gIeP48V2ZZ@aspen.lan>
 <59c36699-ee54-467f-9342-6756a0092a98@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c36699-ee54-467f-9342-6756a0092a98@gocontroll.com>

On Mon, Nov 10, 2025 at 11:03:27AM +0100, Maud Spierings wrote:
> On 11/10/25 11:01, Daniel Thompson wrote:
> > On Mon, Nov 10, 2025 at 09:40:07AM +0100, Maud Spierings wrote:
> > > On 11/7/25 17:14, Daniel Thompson wrote:
> > > > On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> > > > > +/*
> > > > > + * 1. disable unused strings
> > > > > + * 2. set dim mode
> > > > > + * 3. set initial brightness
> > > >
> > > > How does this code set the initial brightness? It doens't set the
> > > > MAX25014_TON* registers.
> > >
> > > Yep forgot to remove that, I discovered the backlight core takes care of the
> > > default brightness, so I removed it from here.
> >
> > What do you mean by this? Are you sure you aren't relying on another
> > driver to enable the backlight rather than the backlight core?
>
> Not that I know of, there is the systemd backlight service, but I am pretty
> sure I can see it first turn on, then get switched to the old value by the
> systemd service. Unless the simple-panel driver controls it? The backlight
> is linked to that.

I think you should look at the code. I think it's likely the backlight
is only coming on due to the link to simple-panel.

Normal way to handle that case (if you want to avoid the backlight
turning on "too early") is to set the power mode to BACKLIGHT_POWER_OFF
if (and only off) the backlight is linked to a panel. See
pwm_backlight_initial_power_state() for an example.

If you are relying on "the backlight core [to take] care of the default
brightness" then you have to request it in the driver (by calling
backlight_update_status() after registering the backlight).


> > > > > + * 4. set setting register
> > > > > + * 5. enable the backlight
> > > > > + */
> > > > > +static int max25014_configure(struct max25014 *maxim)
> >
> >
> > > > > +static int max25014_probe(struct i2c_client *cl)
> > > > > <snip>
> > > > > +
> > > > > +	/* Enable can be tied to vin rail wait if either is available */
> > > > > +	if (maxim->enable || maxim->vin) {
> > > > > +		/* Datasheet Electrical Characteristics tSTARTUP 2ms */
> > > > > +		usleep_range(2000, 2500);
> > > > > +	}
> > > >
> > > > If you really want to keep the devm_regulator_get_optional() I guess
> > > > maybe you could persuade me it's need to avoid this sleep... although
> > > > I'd be fairly happy to remove the NULL checks here too!
> > >
> > > Just wait unconditionally?
> >
> > If you think it will be unusual for the driver to be used without enable
> > or regulator then it's ok to wait unconditionally (all examples you
> > have added so far have an enable pin).
>
> I think it may actually be a very common implementation to have the enable
> pin attached to Vin, we don't have it set up that way. But it is displayed
> that way in an example schematic in the datasheet.

Your call.


Daniel.

