Return-Path: <linux-kernel+bounces-799535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC4EB42D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1091B2741F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE02D24A4;
	Wed,  3 Sep 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dybKmvnx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA11D88A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941468; cv=none; b=HoRfPcatC+l03IbETJqhJ9QeZv0USofw7NK3F+JF6Equ2k+O8F8ihXIbgegPaJ9R5Qjgrrk28tZq0hmhZ1/GptsjFRd6/RBYwWB2lKrPGnXBHWzreNwcSO5Pnx95pmwjFTDXbI4rI40GSZTxlwK7oz17MBr5cGqJcbIDawoXIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941468; c=relaxed/simple;
	bh=CL0UQKHeFAeKYytwKaMnrKI/oiLvCPtOmNdScKbzt5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3gx3NgmRXFf1kdIJJhh6TB49qPAEejXL7eFJ7QXz2Q3tKIDaBPiZQeI/U0CgwIEMt11E5fBXOxsoKAGtIO+sACKs0KCCRmmO3K/4u9xTcAPWY8MuxqMJmk1l7IA0zzT79g3NCt+ihu0BmRzeyf0Nv3ulxPbG0rlfiHxTSzOpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dybKmvnx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b1622788dso3825915ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941466; x=1757546266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkLytKk0F+mcrLFLoKny4gT/DGyLbmcZKBHsU7/uGGI=;
        b=dybKmvnxdxNBBOyMC6A1Hg928KpZTIE8FS4GjsV5xF4rVob6kdHnyYxIIdfKflaAeZ
         GUhc6ZPbNzr6Bv6FhT2qULIeH3jrUkUdZUTELApN2CXMA1veHyRNuCmPiJhChk6R8xs/
         dikYHtUbIG8EPerpFqqsvmyPj2t4mB2Tvw6qNA9YbRFSXJ3W/xDGiKW6VhEAKuubu/zB
         VJckxONvXU3rdZSGedzCNVw/ZcIH47LSnapPSKRbtS65VAiehKYJ5D1W/BysPdPrTKBZ
         9FBPcu1PAOxUcPODP4J1jSZOhsp+0nFFeN8GiwSDmEJMyA+2hX8s2/Ui/kC1T67C9nR9
         1qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941466; x=1757546266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkLytKk0F+mcrLFLoKny4gT/DGyLbmcZKBHsU7/uGGI=;
        b=UMfoh+i08+Umy0SUH82qggcpsscA1XFJ4Sdq6fUqFIjo84o10cZ22bAf1z//j/JF1R
         KMM/5TMIiHQb01x3OEOx0O7+jJJ+OcxksPd5SFhx4a1a8imO/iVEVy5YhujIfEi7l7SB
         o9/O5t3kqGwNgNiTi23CzRz48t/fHOO4+FWz08MujBgXY4dKGyaNPf+wgDYd627qx3Pr
         +wtoFn8nz1iDzK89EhqPiMy01gvpVh/c7JcgfiWq5LQk6CdE9muRCf4glR2Y55QJqvj7
         pPXMOh55aVGpEC4OGMtBc3/9r70t8r6uKrmmhe7vTuGwakYWlY92K+puwHSeJjZlhjpj
         H9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfw+4rGdVxmCmIJDy6gP/X9E4NMqW9dIsZrmY0POfQo2pCR+XPh0hGciejhefZV+gDJcXLsZPRilgy9pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvP++mcpuIzIjdk1Jqkb5/IWGpRS+hLi9qVEIFawbrQw5KAWc5
	wTEcEBQJog08y3Ev3EFOCYDOHTIt9E4sYjw4KaXFJBTODJx7ziJkN6umMlSUaRXqXaZLyWA8bfH
	46ywzHEXkiGGbX2IEpjUhVY7UVVuhAtsW6qPeWpXZ
X-Gm-Gg: ASbGncs6NPkIkTyBAzhgxr5rsDDtp0aSjqNouCVmre+qEpJeHzI0xMf6Rl8OBuI9+yj
	NTq9/OPFaEaQIDv51eVNCUKSJ8E4uMi/2PXEGN2PR7yW4a2kqmJuHqjNSS2L8X/b6+LVGwJJlWt
	S/dRa/SXLGyyoxTBuWOZvSf8Gok2T7VFRO07cwhqlcn8EUiwyko9cRMAreSIthYOWrb95y43oCp
	+QZReFSbcplVduijij05+1YHroEhqXC9lpSphZWimrnSX1YwAvParg8v4LEBLEL0BQ7whOZl04N
	0iDzh6m2cfOLBAmIe0FMIg==
X-Google-Smtp-Source: AGHT+IFhxtDQVDa6LZXo7J9DiC/8b0oih5DuwHzcLELXLnzuGVPULslhDSQUy7MKs9lywPezWpqkyjhkghnqW1y2cL4=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr209598675ad.50.1756941466531; Wed, 03 Sep 2025
 16:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
 <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
 <20250902160858.0b237301@kernel.org> <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
 <20250903152331.2e31b3cf@kernel.org>
In-Reply-To: <20250903152331.2e31b3cf@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:17:34 +0100
X-Gm-Features: Ac12FXyyy_gj7FyaNK9Ji_76uhk24Wy2vOB8JA_2EMYfRrYXPoL-9MEPDggYIDA
Message-ID: <CAGrbwDTT-T=v672DR4wJU0qw_yO2QCMQ4OyuLjw+6Y=zSu5xfw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Wed, 3 Sep 2025 18:41:39 +0100 Dmitry Safonov wrote:
> > > On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:
> > > > Now that the destruction of info/keys is delayed until the socket
> > > > destructor, it's safe to use kfree() without an RCU callback.
> > > > As either socket was yet in TCP_CLOSE state or the socket refcounte=
r is
> > > > zero and no one can discover it anymore, it's safe to release memor=
y
> > > > straight away.
> > > > Similar thing was possible for twsk already.
> > >
> > > After this patch the rcu members of struct tcp_ao* seem to no longer
> > > be used?
> >
> > Right. I'll remove tcp_ao_info::rcu in v4.
> > For tcp_ao_key it's needed for the regular key rotation, as well as
> > for tcp_md5sig_key.
>
> Hm, maybe I missed something. I did a test allmodconfig build yesterday
> and while the md5sig_key rcu was still needed, removing the ao_key
> didn't cause issues. But it was just a quick test I didn't even config
> kconfig is sane.

Hmm, probably CONFIG_TCP_AO was off?
tcp_ao_delete_key() does call_rcu(&key->rcu, tcp_ao_key_free_rcu).

Looking at the code now, I guess what I could have done even more is
migrating tcp_sock::ao_info (and tcp_timewait_sock::ao_info) from
rcu_*() helpers to acquire/release ones. Somewhat feeling uneasy about
going that far just yet. Should I do it with another cleanup on the
top, what do you think?

Thanks,
           Dmitry

