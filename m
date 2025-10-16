Return-Path: <linux-kernel+bounces-856470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EDBE43E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F237506838
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743A34AAF5;
	Thu, 16 Oct 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5InIkx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E927E066
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628629; cv=none; b=bqcp3t4pB6YG89qxlpubfqKwpFFHO9qnkBxPhDR+jdfu1Uz5f1Lu1cBXK+9oq4AKBShSjIWg0ShnqE5CzHedtIGCydq4nmhsW2137fRt2dC0Yxlvzxu4W6hNM3N0uljm+wi8/Kb/EFPTM340UvY0otpKMUr8DebJhzfbmhX1TMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628629; c=relaxed/simple;
	bh=JR0IPU7PxFXpfgWYzXY12lPBiLM1O9zhJ5yP9OtWp3U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+PuUnKbbjsWT5Wesh56RWDsauKfkSQQByjcRB50EeH5x9CTYsIPC+CFzj0gkaEPTdgp1Kfw+P5efTLIwHvGDHN50PRfFlYl8qIDv4m2eT7+oOHppwqT1+Cdn4gmzw+TeCyGun8QUBQsxCz9pvihU7i/PN7cnCewMNGfLngUn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo5InIkx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso8189425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628626; x=1761233426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ietOkeWTDnClykDeSgCRmDi1+eHw6qsXZBfGYbeOrE8=;
        b=Lo5InIkx0iWn8NLs4ifoap7z/6chVScpDsrnX8aTw7wZRA6q0rKmnYaxqCDSX/FGeP
         BHPevq0P2K1FfFaodTdfgGbEWlNNP+bP3oioNY4frzUk9mtqGtXdtu+cJZQba/CfmoaK
         4zP0in8F9eUqeCHS4P15r3gFuxbc9pReIWaYGNg9kAQxD7FArQFrF/DlXTXH3TJFxkAc
         27TCuzpUqldZkWZXdwT0zwxRGJp8a05d2YK2qydYrB+pr3xCuRlGC4ESz8PgNdgANEdt
         WdLihxXtPdQAIDabPMV6jQAOHnBuVVq6BFuc/VJp6gr1uxFwkg3rG2JW7MUQtgcg4WpN
         TJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628626; x=1761233426;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ietOkeWTDnClykDeSgCRmDi1+eHw6qsXZBfGYbeOrE8=;
        b=CJ3igcTNcQnE1XCIn/gVYz2eUvvaFUSUufoX3gB1SgAuIeQW+YdFPrrqOis4wipnZ9
         L/721b/aKCsxeXiXoFzmynwBbj+aY6h+T8EDCsfwOJFq8s32U269tB9Y0B+KXYi7KCz1
         WIUn6iI3bopHjNQ2wZRF/mzcqVag2Dtku6JuIsDhysg5QLF9UmLjEKxhKr1ao7Pdnn6I
         htt1cMPnYjwtNuzwudzq/YYYNrpa8K1uucs2tLUPqGhF7rS3ZBQC7+VJPeReUMA/oVnt
         HxHnGnae3EHR4d2PRLP68qhBTo7n8v8BFW4OGrzg2rfiLPNjuZTLOvhrY422UyhGmwlN
         wgyw==
X-Forwarded-Encrypted: i=1; AJvYcCXO5PqYtlisJWOpIH7slo1BMjVkbXv6fjuB3x72JYKEaqBX0s6RONEKSyYl149rkTJCp+vGZsLGI9EMoi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+5aTcg0z7K3KLN9UMusSqEdofz9BTksYW0Uh/lQkRJH5teV7
	fVZ7xDoPmmSmElWVCdVh3UP+7vITi3dlnHBka4ol+yB9GXSY4t37h/K+
X-Gm-Gg: ASbGncuHMmW1zbV3jfuz1nY7jTY/ZRI0iJS0pNH0TYa4Itd3kkhUfLfRi0lVE1Dqh2C
	Up/DU4wN+c/58agOjtyHYImC1JdajV1nie0EUSlIFNAaG0cNK7ulpk2h3QL/gIFGFliuJ6RzCDk
	+vnxHjxGUhY3uyA4ZrWB5ibVJAUje1TXUu33kFipXqQrqSP4vfPb0eIuYyhYQUfR72UZCOEkMnc
	kIJljb3y2r4hfw/BDQa5Ja8EN0IqTjIQOag0gfMqIGw6bukLmk8XMmU1LkO/Oqzqr7syPmWBwxS
	5NrRQHJDMF0+kCOR+AMrHPH2FWfGKJPkNrKVqwivoi96uXhRlA+kOmpB+j5Uw1o7slJ1tPtw6hI
	dB7ZfXro2KOhgckSdVc75gMVrQvpeJutH0Z1kuXfSMLZ+Md9Pz+0hcO463Q6sPjxYZ4lWwzJaSG
	YhyQdRRLnJZahsKEX2v0gNkShbcJJ1DnjyXmg5qZ1eTA==
X-Google-Smtp-Source: AGHT+IE83L633qvtvU9yjysbdYdlIQn21EV/wagnBNKOZgnU2CqBGKS2iMtK+HobtWHJlzyFyVaiQQ==
X-Received: by 2002:a05:600c:45c9:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47117913764mr3709145e9.31.1760628626015;
        Thu, 16 Oct 2025 08:30:26 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82b8sm31899495e9.15.2025.10.16.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:30:25 -0700 (PDT)
Message-ID: <68f10f91.050a0220.3778ad.a4b3@mx.google.com>
X-Google-Original-Message-ID: <aPEPj0R2k64GH7kW@Ansuel-XPS.>
Date: Thu, 16 Oct 2025 17:30:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [net-next PATCH] net: phy: as21xxx: fill in inband caps and
 better handle inband
References: <20251016152013.4004-1-ansuelsmth@gmail.com>
 <aPEOBRytURg6vKqN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEOBRytURg6vKqN@shell.armlinux.org.uk>

On Thu, Oct 16, 2025 at 04:23:49PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 16, 2025 at 05:20:07PM +0200, Christian Marangi wrote:
> > +static int as21xxx_config_inband(struct phy_device *phydev,
> > +				 unsigned int modes)
> > +{
> > +	if (modes == LINK_INBAND_ENABLE)
> > +		return aeon_dpc_ra_enable(phydev);
> 
> So what happens when phylink requests inband to be disabled?
> 
> I really don't like implementations that enable something but then
> provide no way to disable it.
>

On firmware load it's disabled by default. Can phylink ask to disable
inband at runtime?

I will try to check if there is a way to disable it.

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

