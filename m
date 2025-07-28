Return-Path: <linux-kernel+bounces-747394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D640B13348
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44A8175885
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E01F1505;
	Mon, 28 Jul 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="i1TEqPCP"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C602B9A7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671698; cv=none; b=JzMS++K60H6orZrtlzlMQxq/Ea54Jy6xg8qN2sIWtVdT/iLw30+gnBWP7NZjVjst+WalhRcIUi/nTGU6CIWbt2iD47pndX2kDWh8fntM11n+ghxOFqEBQpPdpAC35bVYLtMmXrzFNNhhhsMBnHM23gQugu/gTda07laX00HU4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671698; c=relaxed/simple;
	bh=0vKfwUHfNQR2JxpeH1mjLInwJuziDSzoCPLeGXD166w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STe6gIRVn9y8LYEN1D77Ke1bepM9MYtmHKY4rOsIzxWY74xdCkwzuFgcV9Q1pNFvULmiSYWg4IktroZWtjoe+D9Qv3Rc1bgJ1CDcCIjPefn578av3pYoI3XQemSzH/9Omo0xEvtif4stGkX39Gc84JdYOKU2xYeYufv1CthP7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=i1TEqPCP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d7b50815so25891645e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753671694; x=1754276494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEoci9qMGq3mZsbtJsvexp6JhXmJXNusPRjzxxOh55E=;
        b=i1TEqPCP7dFx6y1M+V4DDDgQIGYukkyZyCUilAIy7nI8XAniubEi918sU3QqNb/X+J
         URwHFw9YKVwbWAeCEoibkfjc1a75NNOn4yiWUfUYhLpoJBMQg6JW28lMCQ0VB99HFJ/O
         LDwjNiK9tuofO4qaCAEuxN/BOWLaEhcUpwcEJrJJ9Uw26C5dkjaN7lCreUcg7aIIsw02
         0v5RjDf7uAUi8MAlv8vLMmxMIMysC8sEMWy1tQwFRL6a6WxLnusauBHumPjsQ4ad95/3
         XmIo/0Ls8nVrt9fh656YX1+ChIxh14fQQn1Ps05X4J7sf/GGyi2zyS4CW5oXQaWcOv9H
         KGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753671694; x=1754276494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEoci9qMGq3mZsbtJsvexp6JhXmJXNusPRjzxxOh55E=;
        b=KfBRy6HlVoilJ9Iib8Vv2dFQ98m+KORMSP7Lm8z63tmAPqc4x+aFCyH/L0Q3l5vbKd
         0PH55+39lABh99Y3VSaveViKMJL9t9FUe4Uw84q8epDqUQDCmdx1W//I9BTyyic8mNoz
         s+wUvgQlswevoZ2+vwXXOx3R9USJSdlr6AoPsAdzqn7OCbnGXI8akSetJcOohsFikYJ5
         Fp7O2EeF9j3AoAxeqRs7Aq5l0ddFSe7GCrsINVszojbUkyBtx76tTL9qtLhm89ipo6B5
         q+B9TosmyvPj8FeySwASSDtUodrOXb0TbXTkw7wjsk/Z9UdsU/RNRNgWEyei3wyql92t
         ek3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbARsFqYUc00eWWM0THRgSIwRBLgWYNZ32m3YdwykhxR4A8l2KcQPIU5ndUEUT89UxdG2cDoYhgEhD2vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mgd1/uw1GBIuGVW/tXEkZvLnOq3Qe3N2zS638glRdrlOloQZ
	tkPyOIwK5YYpE+LwFsApNGmS6Z9cN63RKzEygL8FzhQd/HuS5G+ERNt5M2FEHmf20y4=
X-Gm-Gg: ASbGncs7N1ScKbrqqN9wjvE/fREUcQGKHI12CKAS8wxjpZdVg8bByrqflc+i55q+6JX
	LZoJh2mFe/mX6kWw59Zp9w1ZKCEtfAS3QbQw8Fnhag+rQ55aZIu2OIhfUmLjtHGaXjQzZYSKdNe
	owvcOAXd4OfXr+cTOg1dQnTZ5swlDkd14m/jW8NQLXOMlFcjXxcLAgLP+faJ/Dd2mMfUt4xxxnk
	l25uDGc/9j6VVs5NG61IH+2uFx0WmNDuWiDtAP7nFoZQ/ztq4yUW2etI5Rq8xmzsVOiCM8YHcgp
	U/egGiI7I8EyPXpsfQJ6iy7v6B6Qbtugxg+CgGH0r4nNBSQ2VGnbhFH9h2dY16bw9SEmQfI7gwu
	vGwwo0N9Q5Yc4Uu6CDrgXm5QFUQy5GipLBW0isXu43l/DM4t+/RIP4yivonflY31yAIN75qt8fY
	Y=
X-Google-Smtp-Source: AGHT+IGQxNb0uTRmgaXFIWNAxJsx2ABBH3vJc/u5BlArY34ZoKzsrRmq3jNV4kVoBvHvbjNr05ibwQ==
X-Received: by 2002:a05:600c:6812:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-458762fcfe9mr81396495e9.4.1753671694214;
        Sun, 27 Jul 2025 20:01:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f2e6sm137373995e9.12.2025.07.27.20.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 20:01:33 -0700 (PDT)
Date: Sun, 27 Jul 2025 20:01:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jason Wang
 <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, Joe
 Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Message-ID: <20250727200126.2682aa39@hermes.local>
In-Reply-To: <20250723151622.0606cc99@kernel.org>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
	<20250723151622.0606cc99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 15:16:22 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 23 Jul 2025 20:18:03 +0000 Haiyang Zhang wrote:
> > > > Btw, if I understand this correctly. This is for future development so
> > > > it's not a blocker for this patch?    
> > >
> > > Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> > > being a source of tech debt and bugs. Commit d7501e076d859d is another
> > > recent one off the top of my head. IIUC systemd-networkd is broadly
> > > deployed now. It'd be great if there was some migration plan for moving
> > > this sort of VM auto-bonding to user space (with the use of the common
> > > bonding driver, not each hypervisor rolling its own).    
> > 
> > Actually, we had used the common bonding driver 9 years ago. But it's
> > replaced by this kernel/netvsc based "transparent" bonding mode. See
> > the patches listed below.
> > 
> > The user mode bonding scripts were unstable, and difficult to deliver
> > & update for various distros. So Stephen developed the new "transparent"
> > bonding mode, which greatly improves the situation.  
> 
> I specifically highlighted systemd-networkd as the change in the user
> space landscape.

Haiyang tried valiantly but getting every distro to do the right thing
with VF's bonding and hot plug was impossible to support.

