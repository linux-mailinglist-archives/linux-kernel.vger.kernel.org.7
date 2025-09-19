Return-Path: <linux-kernel+bounces-824279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76F7B888E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787455A1EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CB2D8DC2;
	Fri, 19 Sep 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmdPocJX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020325B2FE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274356; cv=none; b=Lo1lp1I1JHzsugRWtUx7jxpz4Cq4grkTXEG/Bu7rfKWIzGcL5cPdm1eq/lm4TdwVbU6JgHNNPeffMlOY6hbtzkyVq2DgKY5aAXYNhS4hzcG7gDZdptSFyHIBHDjiXwBsG7VZYSnPoARh4Dzv60ItBB5QqcxoffiHAAdp18TfWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274356; c=relaxed/simple;
	bh=PVuuLjxikcu1c+qB2O9qsLWbdD534LCwFYe+PcSify8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCCwJ4rPbeITZuLrGqnOHaLiyxZvuK8x384n/2J1VCJXp43DE1kJ3tfbW4sgMk777YKBpzk6dv4E1s3MpfGzTVrROgcY1t9dXW/fiuxpAfSRON2F8dNre5Nds32HqdoUddClXz+wClmItb6mdNYUKeBZHC4fH9KlJTWH/IHy8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmdPocJX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77256e75eacso1774774b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758274354; x=1758879154; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CV5IehE1Tn53nX+JiK34yeLAu07RSWt3CuophQO1BE=;
        b=jmdPocJXqHH2tQWqUDx3AEW/0qWKK9CKgIfzFatHZFHZwUtBw0qTzJU37UnmoI7/3w
         twL0dEmTJyYiAFCpG37ZMi2o67BdgO4+1Pt9miDUbcwJxJqDMpi4WozvmJysjGcZ+nmP
         anXedMgdRdgscsPy6eiX7zFEB58valSDT/Q2YoXaZi7HpuZ5fRLW35sRPEAWjB9YawbZ
         ObFhLTBRO0+Jtw2TY9vrhQkwGBRMJARvnuRc2hMZixyDlxRhKcrUIw4FtHdgwXXVnhqG
         tKO1UBacOGniXLvGWeVNFvvncg2NsyPFzhRlXcHhm3IV1O0t49j0SDmUbL+eEM7MwvCR
         1UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758274354; x=1758879154;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV5IehE1Tn53nX+JiK34yeLAu07RSWt3CuophQO1BE=;
        b=evpt8sgvdoVr5adfwH3LluzcYOpKW/HVFfWB5LOfNZQJmtV35WG5BGY9hKqpxmPSSR
         pp66IlMqVsutkKjx2gX1mf89mMuQDkRrM78tVyu9COxdvOImRx3Ipw9VeWafPByu0Niy
         bOQ0ooPo7uIxDd1rtsJh+IXsEGsnSVlW8S/wCXKtc0lNhWu1UfbL0tR2u2yuDsxUN2Y3
         y+AECi4eY7lBPgoIIquX9kjnmgQdY7iesCXtTs3fT739SobmdnlC9KOpFzpvQENCD0gC
         9KLmjz8lM1YMtxyB92EYIplsB8fOk0HlOxXTJOhpusBTQEzwfC9iQFchlpp2eNQ+ig1P
         ku5A==
X-Forwarded-Encrypted: i=1; AJvYcCVjXyZIGirUvxymJ8WS7AiGcpVz/G1Omq2uQ0oQip8MVxQ6Py0visrFjy8HM9HsBPkh08DYifeUN1Z/6NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2CsNDqhsBzwCYvB2z+/Z1Qr6xn0hq78mbdLfiuN6zEVUk1js
	BXD4OPb1HvhXWJXH+Br0T5x/7FFg4GzhRdxkeznWK7+J3kZCVfCUjeUYzQuU7Q==
X-Gm-Gg: ASbGncvrLsvTR/ZENsPl8m7zanrovNoLZNLD0d1G7lnLISg4yzsmYhUOPlyIWbrbUXO
	0N5zr3L7HYaThQydJ3+kRFaSeE47h94kouD1dKWxx6K9QYmV0t81YHFku728/0lFZNzpLdeOanB
	EsUyDJ9A/srJzTUxlRz/VbZGqBSjTjOm0R4aqSTx/OLP41lEiSrw8Hjl94ADVi72vjz9Xh5SBYu
	4EWRvHVtfPhBafthBQOmT/TDyuFmn8eogjTra7Pep0/Vu4DoSBY2Y7HDIfHvrE+QrtQH8qyU9O8
	fe2mHfhxs38abvI40vrzgbDjFtV7S5Dc7ITCy6X7V58uFmYQ/e1ivWYu51oPTfq6ZpYHLrrAnba
	b8n7bqdHPUO8E+iL+3EDSrCLX+ZZh9SJ5cSuwUv1H+P7E5VT+ROsuhQBYHPhBjvgkruikwqwdHi
	bdnPYumufd
X-Google-Smtp-Source: AGHT+IGAtV3xKWu/RSfZaRRvZO9qgcxXvW6souPS+g60+Hps7w3owsEq6q+LE1rVNe0azOw7xoT+Vw==
X-Received: by 2002:a05:6a20:7284:b0:248:1d25:28b3 with SMTP id adf61e73a8af0-2925f5746d0mr3945266637.17.1758274354122;
        Fri, 19 Sep 2025 02:32:34 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55268e73f6sm530156a12.21.2025.09.19.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:32:33 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:32:30 +0900
Message-ID: <m27bxu949d.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Fri, 19 Sep 2025 16:24:07 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > > This doesn't make a lot of sense to me. Why would we even want to build
> > > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> > > 
> > > It's not like ARCH=um with PCI and NOMMU has any value even for testing
> > > if such a configuration cannot exist in reality?
> > 
> > totally understand your point.
> > 
> > now I see that we don't have to have this work around by using
> > --kconfig_add option to kunit.py.
> > 
> > # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
> >   --kconfig_add CONFIG_MMU=n).
> 
> That's not what I mean. I think it should be made impossible to build
> the broken code.

okay.
# I think now I lost the point...

currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
so we cannot select it when CONFIG_MMU=n.

but it's different with kunit when using them via kunit.py config,

it first adds

 CONFIG_VIRTIO_UML=y
 CONFIG_UML_PCI_OVER_VIRTIO=y

via tools/testing/kunit/configs/arch_uml.config, and then add

 CONIFG_MMU=n

via --kconfig_add CONFIG_MMU=n.

and then execute make ARCH=um olddefconfig, which in turn enables
CONFIG_UML_PCI_OVER_VIRTIO.

if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
it will overwrite the arch_uml.config.

# I don't know how kunit handles those appended CONFIG entries, though..

my goal is simple; to test !MMU code via kunit.
my original patch or the additional kconfig argument (--kconfig_add)
satisfies this goal.

> The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> various PCI code, but nothing depends on PCI in the first place. Which
> it should, then?

I don't understand the 'nothing depends on PCI...' part.  care to
elaborate ?

thanks,

-- Hajime

