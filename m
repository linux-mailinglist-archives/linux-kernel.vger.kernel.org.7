Return-Path: <linux-kernel+bounces-745283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0DB117D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4258703A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF4C1EA7CF;
	Fri, 25 Jul 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRZz3FCl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508029A2;
	Fri, 25 Jul 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420739; cv=none; b=bGncg25INIJ4OUv7tfDZImcdMHzzmUOPQ8RB0OTu38i03oP1aloS4AH41MICGURfvSAqdBQ/V6vg/9EjE4chPvHYdCd5lCrVDegIZO7DoQgeQOnKGTOPs+xs1P1B7LZm2z6pG3+XKN9xigKSM781xdygIRZbRHXF8CqHd9OKYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420739; c=relaxed/simple;
	bh=FuTOrNphQ87GZdTd1ZusU/upsjz8QNLi/l8+5ihUqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaL6BK5sNjqYASJvm1pfBW85qNdZE7QhskSyVgYmi+xnaeSG/c752o3+GToVtbA9xaejyY976yNcaWK178BIo04p6SwF7wvFl2hzajg4cUG7S50NHK4U/10tjv1kdVbQzlpnPKOb75b20GcKGo9aw/WYBAxHcvaMDXERifKn7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRZz3FCl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so1129099b3a.3;
        Thu, 24 Jul 2025 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753420737; x=1754025537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwlCoX9n3S+W1I2p1kc9IDkLp+xJ/GgTuu9b7/n8qiY=;
        b=dRZz3FClb8A57RtmdDx01J17YDbfXgaqnH03KO9Fx9A32Vv47IvMBcdO6c1N4WsgA2
         wNKmQc6Pm+zj50XV6++XAE8atC8EYE/C2zItSeP4v/AJWjGhCkEk7/EYfMqY4shv/z4G
         HoKiMTPxMBj6vWLCYUDrO0IMrlHAFivEG1O5fjyi37y6PMJGOH6ZanoNG+k6hZrEEXDD
         bzlVoTp4vrZjIrogEXkhbno1sDBzKbMC5tAWRDr/FvZxEil05lMfbGeo1iS5PqURyogN
         X7oTUatVThV0IC4VyOzMW+msYWBI+MclGel2BUom/l2N0d+Wg20DFdI5rbz1+5cPGrdr
         EIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420737; x=1754025537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwlCoX9n3S+W1I2p1kc9IDkLp+xJ/GgTuu9b7/n8qiY=;
        b=CRKd5rIrkn6xRiEgBY3i4IYYULuo5oxq1jFxoB4v/iS9XPPBxFS2oLN39CSvuz+VgP
         ET7ZJ+tErfeqsZgSc2gTSLnBB0sqY7FCW9nWmQ+iXNW0XNTaR0ENssc0r2oLyb1wClTR
         +70RN+eO3Z6AQjmciPValEXKujhPAYA9rykTQLDFijEYaJjHExkKXoo0GFPs2WBBgfKZ
         KLncae9WiYX5Gt+Q68s7LYZjci8FehXo+QQsNr3Ce5jym2lP9hO4aTTPhzPILfXAvoDM
         FTa2dtLQBF6zGN8dBDefBqT7VNl6gDat2pYU4OxQ7H3YAdQwHnXWiBUKM8aM06vs6nXr
         B4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7B/Fgp2tQMFOow3F1TVQCX95/aU57UNEiZKuOFUTd1VC9nhu1YqMDrHFafrC98z8cywglJNzMCsas@vger.kernel.org, AJvYcCXmOSEjkgMRRNy6DftKfOzmzI8v8Plps5vuyVRzxV7vxlLPe+Dz/FC8BDV8isfNyMY3vdbE1W1Qae3L3k3u@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2TgBRY/z/z7EWNKg6s1SocD+U7gctUHJgLHepmORYu0+qBu6
	wr8qcqZXp25x32Zd+dDsYPBrReoZzjU5Cgu8MSFIK3sjA4qncWstJlTu
X-Gm-Gg: ASbGncuIdVMZaEWebuadn1Cr3jcr0Ex3eWUQIQyaxl0puGGJ/xk2QQJ7le7MBUyRVvg
	nDHkGggbS3JYcHrwE586YtuVGkuPlgbsexCSWdVSZ1OmzAMLvjkRI68CxVFXtcnvtoxWzgYnfwC
	oS7ITehgmsBNRT3ko2a0AbktmYltadlRBV1diVb2GsrmMa+NnRDJTBK3pwhtgOf9ArB5IgX+wDe
	PnXof7V/AkhGDZCDMW1rHFu1sYzvMGNh+cmZBIKOIHWf3NvQL4fvMq5C+nr26kbG/PgsFL1QnJJ
	VESTVNHfAlzTUwpEIsWEntmw0Hou110Q4T15E68v6Y0vfwy1srFeG2jXuvhVxn7BKsjsYI7Uaqh
	9qv5wYgEYuYPPoJPNhK6reZAhaxLao0O0r+Qr4CxjSs5Uoi2Y++xP4enxYItI05HoTsVcRMQ8T0
	8=
X-Google-Smtp-Source: AGHT+IFPixTsfdXK9p29I79UGfIgXeOO9MD+/pKk+rfiR7TaXdWeo4fQpMcFgUkv1hBHXBF3FZnWGw==
X-Received: by 2002:aa7:88c6:0:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-763382d8395mr881883b3a.15.1753420737003;
        Thu, 24 Jul 2025 22:18:57 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae15838csm2966301b3a.43.2025.07.24.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:18:56 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:18:53 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIMTvUyHGd/ikKY9@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>

On Thu, Jul 24, 2025 at 02:53:39PM +0200, Andrew Lunn wrote:
> On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> > On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > > +&mac3 {
> > > > +	status = "okay";
> > > > +	phy-mode = "rgmii";
> > > 
> > > Does the PCB have extra long clock lines to implement the 2ns delay?
> > > 
> > > 	Andrew
> > 
> > Hi Andrew,
> > 
> > Thank you for catching it. I didn't notice the settings because the file
> > is copied from the exiting fuji.dts with minor changes.
> > 
> > The delay is currently introduced on MAC side (by manually setting SCU
> > registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> > can be handled by the PHY?
> 
> That would be good, if it works. The problem with the current code is
> that those SCU registers are not set as part of the MAC driver, so it
> is hard to know what value they have.
> 
> 	Andrew

Hi Andrew,

I set phy-mode to rgmii-id (letting BCM54616S handle RX/TX delay) and
cleared SCU350 (MAC3/4 RGMII delay) register, but somehow BMC is not
reachable over ethernet.

Let me see if I missed other settings. I will drop the mac entry from v4
if I cannot make it work by next Monday.

Thanks,

Tao

