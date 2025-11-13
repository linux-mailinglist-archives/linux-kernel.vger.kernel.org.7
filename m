Return-Path: <linux-kernel+bounces-899822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B8C58DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA60B507186
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDB35295C;
	Thu, 13 Nov 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj5+eFPg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8414C5B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051431; cv=none; b=o6tBRPKcp9xu8wFD3qqoB/qKmqIU1CEm8vQCN2PHmj2IVSLimCb9fOQTy18iAt892a/YdfIpE0rlNwL/2XFZnK4MQlGgNg4RddIl0exSe0P6FsA1w3cWrAnhplDBtVPetrG+CXSUB4/2N32+4jj6MPiWo1th6wpjDNpzXM3ci1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051431; c=relaxed/simple;
	bh=3uJv23fu88Wl6Y9vqlscvKEphTQsHPu/VBDgliM5sz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4ocLjCMP4n1wx7a59NJ3wJoq0ChrLUPGf8MMqLZl+VZUuhbwwrJiOUcgnFkZZY1NJX1OWk6Eea1dlQO9+JUennVzxwLdMMK46u35nv9ZAShT8V4s9Nsw7TaXhTwo/Yqk85cPSDIGpY1PobIeYU6ZGrd++FPfmav5pjzSqb/okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj5+eFPg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4777af7c382so493505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051428; x=1763656228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3r73UQNqtdeIQLhnX35BjU0Y880UTPCnGX02EQHqjc=;
        b=Vj5+eFPgJ3qp74Qc1RPvx7c7rSCr1igYktl5S4cj9GL+REI/d7Zz3uUqhK0BwddxFB
         7VSXpd0VSmGGdXQ3eJ5wTNMCV9cbPePTcB0nH+pbT+gtUinCyIjsKtU2JqWN9MpcKVJN
         69nquMKhJ72ZxunCQq4PiWujql1x54oACTIrBWbS87w6n0roOi7+r0CpiqHnIuAjDdzW
         6lpPnSnfJECb16ajDcrqt7wCU72R944tttZCfxtYucUNc5iK0leJuAMM/2C+E1Z13+aG
         Ej6RTqQLZkOGGlPIeQ6/XL17KXntHOshx+Z/YhG1J/xPDgMHp0Ziw1Vnvg/3DZVLwGFH
         qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051428; x=1763656228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3r73UQNqtdeIQLhnX35BjU0Y880UTPCnGX02EQHqjc=;
        b=TJpuAP2xDfnd7mrnemz2BRswkvyK/C/6ooGZrCsgbAUS+uAkjC3UwtwGcG3ue49TpO
         MY5cnhUijoWoMidx0zxNguT33hkUQrT2LZcjiWC1CCmE8oiFlh5/hI2AZvnDJMpBy1Y6
         c9eSbQQCe3knHUSmKffQVhpKMDK9ilZEqEhaV7QYgZzjwM5qiXlJhzcbbwskeDZglp68
         RQ+91ffjqsYxDrAgQoeO0k3s66KO44npyARbNXAFHKeBBMn28Q4Qzebbt/p+3+ivgQxo
         wjDMunSkMg6Dcm+qN0bxkqvbUdwAbBB+mmJ4TAeg4L3HSoGNiwLsBBeeDGi8rsBKB0HK
         qa8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYp0fLSi3tOgdHvR+Es+aeVDTT7YnzZDj8dR5xYJvPSX2LzNnVnSErVyqiNAxKWDxhrf4O2LLkVtKY4N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeWgHJyUGI7eiiAmtYsovPJP4S426W7ujWMIBvaKkVVPWsaVE
	bsOq8G4UKK+i+Lwhr4ISWyeXjkALe+VJX8c7d8rKLH2WJi/ikXG5c9NQ
X-Gm-Gg: ASbGnctgRLoBfV37tpiBx1MmADuPWLSy2utJ1Kd73sdS4b3yopVZ/d017Lyghs2g5Tx
	qkgmUXMHLHf34FYgLSerzLlUFHeMSMWSGFc2B4vOgpU44QLE2UOsHDzkId204RnB7tr6Ad9vnNP
	ph8ayJz5GhQraDxqULSKb06y4wbjas30WHsqFjsHQogtEcNfJauYGdlbl4bTkVgHrMtakGeaCZ3
	WSXBKn6X6WcJ78w9MfUjV2JRHnD2WA1AGIJQwdbt3TkYxyB5NE36wTN0ufw3Q95093fLQeMjOsm
	ZTrenDSOJzgmHLhKzUxQHdeMqTYeY/xXhE4nnQW/ypK7T9ptJ4eZiIpQNT1Z21+1gHiXBtuyxms
	+L25VbJIcOz8HR75vMtIaasnaF9r0PJvHczHwMESRwGTNDLiV1igFSNabldtlF18yE4qdfuuRKU
	FVh8A=
X-Google-Smtp-Source: AGHT+IGgh7OmYpsm5WrF/6yqCl9whZpB9vMZS5weAAxXcUVQKGVt3MFL8OrudG1F7orP2JILXBJkAA==
X-Received: by 2002:a05:600c:45c4:b0:477:79a0:515 with SMTP id 5b1f17b1804b1-4778fef6feamr205505e9.8.1763051427422;
        Thu, 13 Nov 2025 08:30:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d503:6f00:5125:db14:ba9d:8fdd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm4605741f8f.7.2025.11.13.08.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:30:26 -0800 (PST)
Date: Thu, 13 Nov 2025 18:30:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 0/2] phy: microchip: lan966x: Allow to invert N and P
 signals
Message-ID: <20251113163023.syl6nxq2mqkxpz4z@skbuf>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110114216.r6zdgg4iky7kasut@skbuf>
 <20251111095016.42byrgj33lp4bouo@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111095016.42byrgj33lp4bouo@DEN-DL-M31836.microchip.com>

Hi Horatiu,

On Tue, Nov 11, 2025 at 10:50:16AM +0100, Horatiu Vultur wrote:
> The 11/10/2025 13:42, Vladimir Oltean wrote:
> > 
> > Hi Horatiu,
> 
> Hi Vladimir,
> 
> > 
> > On Mon, Nov 10, 2025 at 12:05:34PM +0100, Horatiu Vultur wrote:
> > > Allow to invert the N and P signals of the Serdes for both RX and TX. This
> > > is used to allow the board designer to trace more easily the signals.
> > >
> > > Horatiu Vultur (2):
> > >   phy: microchip: lan966x: Add support for inverting the rx/tx lanes
> > >   dt-bindings: phy: lan966x: Add optional microchip,sx-tx/rx-inverted
> > >
> > >  .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
> > >  drivers/phy/microchip/lan966x_serdes.c        | 23 ++++++++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >
> > > --
> > > 2.34.1
> > 
> > For context, I am trying to describe the lane polarity property
> > generically, and I've already blocked Daniel Golle's attempt to
> > introduce the similar in intent "maxlinear,rx-inverted" and
> > "maxlinear,tx-inverted".
> > https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/
> > 
> > I am trying to find out all there is to know in order about this
> > feature, and I just noticed your patch, so I have to ask some questions
> > in order to understand, had a generic property existed, whether you
> > would have used it.
> 
> Yes, if there was something generic that would fit, I would like to use it.
> 
> > 
> > So I see that you don't have OF nodes for individual SerDes lanes, so
> > this makes your device tree structure incompatible with simple
> > "tx-polarity"/"rx-polarity" properties. Are those something you're not
> > willing to introduce? 
> 
> Do you propose to change the device tree to describe each SerDes lane
> individualy?
> Apparently in the lan966x_serdes we have also the port muxing which I am
> not sure it should be there as it should be in the switch. I have done
> it this way because I have use the phy-ocelot-serdes.c as an example.
> If I change the device tree to describe each lane, then first I need to
> take the port muxing which is fine for me. But there might be a problem,
> if someone will use a newer kernel with an older device tree, it would
> break the things?
> 
> > What about other stuff that's in
> > Documentation/devicetree/bindings/phy/transmit-amplitude.yaml?
> > You also won't be able to make use of the existing device tree
> > properties if you don't have OF node containers for each lane.
> 
> To be honest, I haven't look at transmit-amplitude.yaml yet.
> 
> -- 
> /Horatiu
> 

ffs :-/

The radioactive piece of #### that is my work inbox moved your reply to
the Junk folder, _even though_ you were already in the list of safe
senders and domains. I just checked this thread to see what was going on
and why you didn't respond...

Yeah, the device tree binding I want to propose is per lane, so there
needs to be an OF node for each lane.

I can't easily parse the lan966x_serdes_muxes[] macros, assuming this is
what you are talking about.

Would it be possible to leave the SerDes muxing alone (with its
#phy-cells = <2>) and just add the lane OF nodes as an extra? You can
add new support for phys = <&phandle_directly_to_lane>, but that
wouldn't remove the existing support.

