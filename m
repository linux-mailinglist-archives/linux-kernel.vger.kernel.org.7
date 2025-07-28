Return-Path: <linux-kernel+bounces-748429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0255BB14128
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A117D0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E93275AF7;
	Mon, 28 Jul 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oFfqiisZ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC1274B49
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723450; cv=none; b=kEcNzZwsqDS5eGfhJcBSbmYAhh3FRkKbvFPCi04oOqC3mwok6VjVUoA1rofveFB3IFr+wFK9IZyt00xNLCDm56W/mZjCrqTS/7l7EU1REOXkS3z/xzYj5QT1ghJJfqADFsp3X6t8QUbNCXZUgxNOJAiA/FCPWKxOYvAT8bxZVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723450; c=relaxed/simple;
	bh=2ZdwF4PQYW8147pzn4fPe5HUYoQfVvkk9RKNY+W2sFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGHafNH82bLD6eeskwjaDqx/seWPctfkwyShfiGwQrlHCQZz2MOwRuWhdNjg15IB39iECxImL+SIq5HKEllbddkGkMd+3RcNIvto3CV5I8NUt0ZWGnGvRXM33Qn0/IZLp1sMb8pzqNuOQpxW8qdo7E/OeZOqDSDXRYOYm18HSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oFfqiisZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70749d4c5b5so8981036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753723448; x=1754328248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XdqDqbJDwpBMe3m0FOfH7VD8pnof2gn6I7X5rLReRs=;
        b=oFfqiisZYO5wCla3SH4BvnBhGCqgeALrVtPIFnG5G5tgZr1Qtj8SKODdsEattfQtIy
         oAS60hUo8gWsAVZffO4SWt0Vr8NPKV5hQg+uGZ3Qfr+6VH2GA1ZkRDHwFfPFNyWOTNCb
         QRBZH8uPb4geRq6lZwY7NjWV62eyojt5amb7KoxqLS2LyMR1kChJNta9lIBPYj37Ku/K
         DNf/u7SlbqYy+Z41nBF32zrOUgtUIuuuOI1guBqApAswaeo/mMZu9Ld5kHY65wtXsfZO
         UgDB+/szoQ387mzVXm9eTBwGZK9wH89SQPGOYcCbdqlIS/hn0mpAm84uq+xJ/HORWMQr
         auGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753723448; x=1754328248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XdqDqbJDwpBMe3m0FOfH7VD8pnof2gn6I7X5rLReRs=;
        b=Nax8c/5l6NnHvilltF1+UQfxvzuVuYXLUrGVOZb5zKBzGbK6oqFfnkd2OiyNDlNjEa
         QUjkkpTcaJ7G0AIT7mbFUZ9MFcNNQZx0WG7Kd0N8gF7smEeQ6A9d+p5iLT9xALuoe4z3
         XeLChScbAo0tz654X+wP2J6vGM2PODVXNiELtLxxio0/sPnT33Ex7sZNT8Hoe+S+xi1t
         Tc+ENzO2jVNV9YTz4OYVUm8XuczgYqxtwXtrdfnyyHt6kSHmu3tTm0l027LwSuFk6C9r
         t6WTkAMA/hKagxuHcIYItUk2T4fXze2m0/PQjkRYWggCxvJN0DeC42XEUl3iwDCIkyLF
         tlsw==
X-Forwarded-Encrypted: i=1; AJvYcCV6gokzadQts2B+F/Ky+rLTVx2TvDtS29WNytzKoaCioEfXHonfDH85XRjnp1lLUkYDhDQuRBp/VjNJgaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4P8PGNYaYk23+i96NCpY/giVyPwph9aR+2gj3BUdMsYnkjGi0
	+hKuZwuSwqXrhKtbdJL+LvqtNt1jyfSyOtfKCsmsFmPC4qw5ZDMzjeXjRIVA4gu86Zc=
X-Gm-Gg: ASbGncseV81yJkwUdOCX6QUehocyznT+eHu6Mc8Q/Q3NrswTBPR7Z3+qeGTYqgmR9E1
	sl16NAZDHhg20EgnVGrwGZZN1UDE5Mv4GSoFknw6Ipiy4C+YDamPEnkzSmQjxDC+E4RIFOBcCZ1
	1uwK+ZTTVQMS1v/EyHwzUbUtO8dhMsHZvJVKXBaX7ftp2z7U8NvZ0Y4EoWAtmruVkCf5PPyb382
	RB4gM0VrURil8pwRPZDXrRKlWlx7i/mNN6sL5HuES/dGZvbmHlSTVrdJ5nGGCUSMnhm2Gv7dvcO
	Y+khy9qskogxb/ERp5cHt5rmnbMLH+WtkAeDkg07Cb2wwfK0PJXquk1raJWlqiGvGb7GiM4SDbU
	qPiH+kqTzyGqsMJ5WtKgRHQ5Kg5anY0ByT5otqr6iUr6i7PeT2J21dkAtOvt/tBNi4cnJfClSYO
	Y=
X-Google-Smtp-Source: AGHT+IHY0LkystMqkqxAK7PK7GfR60GTUEUQKdwp2aWknAFkvv9APqEaMLJSHGrUrYhnngwMHSEy0w==
X-Received: by 2002:ad4:5ccf:0:b0:707:38e8:d10b with SMTP id 6a1803df08f44-70738e8d36amr98246666d6.24.1753723447718;
        Mon, 28 Jul 2025 10:24:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c4db6bsm33605116d6.70.2025.07.28.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:24:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:24:03 -0700
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
Message-ID: <20250728102403.14269ea7@hermes.local>
In-Reply-To: <20250728081907.3de03b67@kernel.org>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
	<20250723080532.53ecc4f1@kernel.org>
	<SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
	<20250723151622.0606cc99@kernel.org>
	<20250727200126.2682aa39@hermes.local>
	<20250728081907.3de03b67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 08:19:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> > On Wed, 23 Jul 2025 15:16:22 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:  
> > >  
> > > > Actually, we had used the common bonding driver 9 years ago. But it's
> > > > replaced by this kernel/netvsc based "transparent" bonding mode. See
> > > > the patches listed below.
> > > > 
> > > > The user mode bonding scripts were unstable, and difficult to deliver
> > > > & update for various distros. So Stephen developed the new "transparent"
> > > > bonding mode, which greatly improves the situation.      
> > > 
> > > I specifically highlighted systemd-networkd as the change in the user
> > > space landscape.    
> > 
> > Haiyang tried valiantly but getting every distro to do the right thing
> > with VF's bonding and hot plug was impossible to support.  
> 
> I understand, but I also don't want it to be an upstream Linux problem.
> 
> Again, no other cloud provider seems to have this issue, AFAIU.

The problem is that other cloud providers don't expose the VF, the hide it in HW firmware.
The userspace world is a mess, with systemd, netplan, cloud init, and the SuSe stuff.
And custom appliances that assume that there is a default eth0 device on boot.
Yes, there were users that expect to see eth0 all the time.

