Return-Path: <linux-kernel+bounces-748826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65620B14666
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E64A1AA1D12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9901216E23;
	Tue, 29 Jul 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT3A3M0t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C214813
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756941; cv=none; b=AD6Z5+h7LlAJ0KtlL/FbL2Fswyt+gGltQI65elCsLijHwq7mJmxtNrt/UilMkg7oJWGeMeNJdFKmcs/g4FLQKh/k/zAfttJY1apWHKScscdH/q1SEgKMGj+0+uDB/9Mjo1Lu42SXgoxGI7n3rfCmHASyW/8ph/TnW1IJRTO2AcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756941; c=relaxed/simple;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmw5AkIzA2CGUfOky0cDlQe/NdL3Cgut7qEC+T3TMTNMS5cEdNztiRbdPwHJFlHxEm9/2xtiKqxg+OE+Pmp5ST/Pvgp4BqX4pQuP2+StDr2bzNqtzzbZIwF2xhpCQh0UXc9VwytcsVhzxPt3A7Ib0+n3kGJ7GDaBLy4VNHi0pVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT3A3M0t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	b=AT3A3M0tNgzOgLC1SIqduDhekisS0X4PeU/9ioY4GxLlPNk5YbrQmv/MHLOXCGD89XtNuA
	2NJb+iGAPvq4euF8OeMKCk6+ErIz0Js0tDZz4g0Mluex1AW9o3ATAJleTSJkfSrEfvPRg7
	xYtNDghBVlR6Jlz6ETJ/XgPWrUwlgA8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-HE4Z4q6lMjiU8O9eIKPNHQ-1; Mon, 28 Jul 2025 22:42:16 -0400
X-MC-Unique: HE4Z4q6lMjiU8O9eIKPNHQ-1
X-Mimecast-MFC-AGG-ID: HE4Z4q6lMjiU8O9eIKPNHQ_1753756935
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso5896806a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756935; x=1754361735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
        b=eps/PkYKemv06FWTgYBMI8d6z82TPTlW+d02jylLcPdcJkMDhHPw3sb1tWnXOZuNEp
         1JZMYenBLg/68dgOt7jDrQ8p9v/xG40vcqJDfxLIQCGboCDOAT4cDTncz2QxJqQr+HH7
         6YhT66wIFHNmtCDpUiDWqZWsWgdXBR6TkKEJe02JdMjvgKVyxgxDegdfiFlSF54nqYj9
         qwUoVdri7BykUo59WJR8cBbWw0bkgQgLPgYB6OEVDBhnPVYrAu2NiKwcMphqaOToN4DR
         jOsxt7SG0bK9mgLgwoAguAE0E3w/PhdZu+jOjfJFyjwRL2ZQpndRiBgRd8f/6lNqXcOR
         AyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWPDuX/2l4mV64X/BkgwS2aGJVYQQTXMdF7LYIimsCJB1RFckG868N8wBiNYtsCjGt+HtLGhL9i5ScIB/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWnBRlpNqHksWrqET6OplJmiSHpi1FJ8etMMLZxD2su2H9H2v
	INzbXFJTqv4Ko/h097dbLbB3qCooB1S4yS9Gleblkso8pqRMSNumGoetY6fKet2TlHN7d2LTOKN
	byzAF0S/8+hiHxaiGnnORrBmktf1WG+zhIeRiNHu17Qn2gCLLuxa41/GcFMiRS3J0rJBfO2sO6z
	49x5iGvcTPGSmD8WBANCsnUEXNKO0+GJqBendOUQOb
X-Gm-Gg: ASbGncuSg30ZIb5SdRKW5vb8QSd1ZGMNfzQX7asOltWzve/I32um+GoYo6k2bqkrwHw
	DAWg/TLBiYOd+rH82O2meW6XKEjl2L4DVc91qQw7EmKNTn8BUAkrS0TgiUHhj1Ud5+53/bt1MZ+
	lWGhOhaaYVWfThfKAgCdg=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e7789934emr19500206a91.15.1753756935530;
        Mon, 28 Jul 2025 19:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTrGIt7eoxqCmwJKJyFiSjpEt/y/C2GLW4uxNz1WclVI1OSQpVtk4/Uh3bkfM8enIwqKkmmo/XskQneWdc8g=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31e7789934emr19500181a91.15.1753756935041; Mon, 28 Jul 2025
 19:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org> <SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
 <20250723151622.0606cc99@kernel.org> <20250727200126.2682aa39@hermes.local> <20250728081907.3de03b67@kernel.org>
In-Reply-To: <20250728081907.3de03b67@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:42:02 +0800
X-Gm-Features: Ac12FXzBxdqLecuJGApu98LjzbNbf9v9AdNqmCM9700YIpdOZpTnf4cOXXGt-No
Message-ID: <CACGkMEvwAqY2dRYLnUnVvprjoH8uoyeHN9CB9=-xRUE80m6JSg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Cindy Lu <lulu@redhat.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> > On Wed, 23 Jul 2025 15:16:22 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > > Actually, we had used the common bonding driver 9 years ago. But it=
's
> > > > replaced by this kernel/netvsc based "transparent" bonding mode. Se=
e
> > > > the patches listed below.
> > > >
> > > > The user mode bonding scripts were unstable, and difficult to deliv=
er
> > > > & update for various distros. So Stephen developed the new "transpa=
rent"
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
>

There's a failover module which is used by virtio-net now. Maybe
that's a good way for netvsc as well?

Thanks


