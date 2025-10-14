Return-Path: <linux-kernel+bounces-853436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF38BDBA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2C9544120
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785662D9797;
	Tue, 14 Oct 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8hr7cor"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573422550CD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481579; cv=none; b=LUKAgNSY5bAJTJpcFbI4pcETjgi+QZlMiAdthCrEodsIjtffPExWWLK94ER988D1vA7Bh2qnSh4VeDNEqOEkw8MV9EjFfP5xCcXYxhU+wM0nSq87i/jGLATSxdGRaum4okj86X5oY8E4bWsXXEqswhGcd+lVyWqFVFTiivHakhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481579; c=relaxed/simple;
	bh=5ODQnisCGFVnzmSQNZxnXZZaqWQoRTY0eyX4Hg+kB6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwvl5Nt/DgEGmxNlhDSdH8Ydr5Nx1f3McoCttdzrEXtjMZIqcRFVL2AROtMH04tYTmEeCTyNepLG6DgXH401+5CzVlMWkhC+r3K7CRAtp8ws2vlAi7GGBXaeBarAietEr5D4IKZVYvRSMusi16GVZ2C+Nyml1k6w7hMxjTWTIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8hr7cor; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af743c232so5389605b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760481578; x=1761086378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZtqCDOZscLqB8RaEJpnchm/C2TI80sLGGpkj07xncY=;
        b=K8hr7corcKAkh3zXm/RvOSSRLZfgs/kDW9x4i+Ifsixi9xuj+BQayTmTsx2ZsYNVnZ
         jGL8IpgZliO+JkWvfCr9SdjfcsHKktfkpRE0Ciil926XcyAJ17MnNbEe2ckweBddcyBL
         7tmNtwpl2zfG3fh2rU14EJfHFmtEuxruZJLmWAOznq1W5ESU6Uq5cDCxvfZuqdBMPQH9
         gussirhA6QXjpnoffbR5bm0t6YN+Nr8z+7yRk1xymTOpP5US2bUEvIePAIBxZDjNgOe7
         Ft+QjJHOzZuHYBpBsxakz+wByiJD6Dt320RK14Duz900xKo4rQ80WqRI9A20dOUnxYye
         mkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760481578; x=1761086378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZtqCDOZscLqB8RaEJpnchm/C2TI80sLGGpkj07xncY=;
        b=YGe3I1R9LsTtV6t2ZOqu6MTDQcTR8rdehY1Cmg7cdJMSV1NccFthV2nd67nDhq8HP8
         m0yLM893yLSWqncO8nSWJN71eFn8tKKtdIulgBBTviOyRHrldsvH7Ywwxz3H17uUGazZ
         iMknhBoWb5qA1PRHlC09t/GHH7PJWsI+Y2D04xi2tWu/t/qWRpxsALbyLY/8jnEklQKy
         aR6O5Flc9Vvd4dF7/rt3arP3SoGUDxHcyloaH4ksscyiAQPaAgPCs3D69neNuC2lrpmj
         HZqJW2aK7ER3VLdi+5cLreIA//Mj0BPyDvT7OT80WAHsKbiBdrOXQhG6hWUrOBRJojQ8
         rIhA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBEJmIM2tYN+LeQuC+4DaXQ2XGsosftOk0IKNQx8e6rfhBwnte4VmPkQY4Gsj2arI9aiNukiergXgY2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6Xg5dcc/KJf+il+QSV+DAK9POnPB3nAsL7TzmCeyb9UbdKuF
	0wb+glnjTraa8bKCFQHeiytR2rADcNsBbHey8dwLa4gao0GRHozjpLR4
X-Gm-Gg: ASbGncuLS/0i8GSXh4PW/IBiLBDEfOViKadmxLXXdyNfqtG9jSebg7O/yrugaGADrME
	+GE60bKb5lG6IC+X0UEmrqicGw49FQyJbqbu4eBhRKPmm2ZCJkZzgfPqH3vUm9ppGruorbUSHA0
	ZXXS6MCs4wKlCSevKeCTnk7RSiTPtxRE11EhaLqULGbdEYWOrXY1NLEfNZwrIqZkas+Ys+/rN6n
	tzjohZFE6blfvT0vziOAkMwAmdqXVPUiuTseCy+YEDj28VVHOJ44CuviBB7wOfJ/VSpKXF+ViQ4
	zfiH17oB2fpxt0esZxiFv09wUARCaMXEzaTgnWeJS884jNBjBjb9fiP2PiOb+4JAd4H0VS1iwAZ
	syO8dC62dbFQD55lRnzVVL51kAyO2RolkVi+lJy+PiQ==
X-Google-Smtp-Source: AGHT+IEi+B24saT9H9rxfelGvAFHN/l9cEixm6BxrzttyGvKpYxkywr6o9MKjbLEkqIAa3+5HpvU8A==
X-Received: by 2002:a05:6a20:3955:b0:2bb:b5b0:b3a with SMTP id adf61e73a8af0-32da7e7bd47mr32647446637.0.1760481577555;
        Tue, 14 Oct 2025 15:39:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:600::1:891f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b59sm16672205b3a.2.2025.10.14.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:39:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:39:34 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <aO7RJs8ceO3mwjn4@localhost.localdomain>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
 <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>

Hi Andrew,

On Tue, Oct 14, 2025 at 09:14:21PM +0200, Andrew Lunn wrote:
> On Tue, Oct 14, 2025 at 09:39:02AM -0700, Guenter Roeck wrote:
> > On 10/14/25 08:11, Andrew Lunn wrote:
> > > > > If it is already in mainline, i don't care too much if it is wrong. We
> > > > > don't want to cause regressions.
> > > > > 
> > > > > I only object when adding new nodes which are wrong. If we keep adding
> > > > > broken nodes, there is no incentive to fix the broken driver to do the
> > > > 
> > > > This wasn't adding an allegedly (sorry, it worked for me) broken node,
> > > > it was removing one that worked for me all along. Obviously I do not know
> > > > if it worked (or if it is even used) on real hardware, but it worked for
> > > > the fuji-bmc qemu emulation.
> > > 
> > > It probably does work on real hardware, because it is one of those
> > > "two wrongs makes a right" cases. So i see this as a regression. The
> > > node should not be removed. It should hopefully get corrected sometime
> > > in the future when somebody actually fixes the aspeed driver, and
> > > fixes both wrongs.
> > 
> > So you are trying to force the issue by disabling the Ethernet interface
> > on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
> > That just seems odd.
> 
> No, i see this as a regression, it probably used to work, so it should
> still work.
> 
> I'm just pushing back on adding new nodes which are broken. If it is a
> new node, it should not cause a regression.
> 
> 	Andrew

The fuji-data64.dts was copied from fuji.dts mainly for larger
persistent data partition (64MB), and the latest fuji.dts includes
fuji-data64.dts (instead of vice versa) because we wish to deprecate
fuji.dts in the long term.

So it is a regression for fuji, but fuji-data64.dts is a new node..

My original plan is to add mac3 back to fuji-data64.dts (which will fix
fuji.dts) when the rgmii fix is ready in aspeed mac driver, but I can
add it back now if we need to fix the fuji regression asap. Please
suggest.

BTW, the current mac3 settings work in real fuji hardware because rgmii
delay is configured in u-boot.


Thanks,

Tao

