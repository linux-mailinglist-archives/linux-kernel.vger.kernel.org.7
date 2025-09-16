Return-Path: <linux-kernel+bounces-819130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC2B59BED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF69B1884667
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31E34321C;
	Tue, 16 Sep 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="bks7/AHy"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28365259C98
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035947; cv=none; b=lpH164dERv9xYa95IyP961/v8Xcjh2SxZSTde3fiX8fLPL8Yj6meftaoTQQGXsYgk+9rPs2ta8hbC4UZ9c0nhXwOBRfzBsqzszMlKkFgRhbwsNxOZoZjPCg6ynvKGaQEyExjbo7Bp/sZMdLJtryRxZW1/DUu0VNGwVoOcimEl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035947; c=relaxed/simple;
	bh=qobymtF6bCxe6oWp1HPqHiNgcrfh79AHQBPc9OQhHec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQHH2pVrK+HUqL6wrhL7hsUvtv1UUDC4lhwx1J/xQZoSl6h6Arp8H6qcY68oWyR8WtovEvtyCw59Wmp8STrNrBk1HgaEKOAFv+vTiv3MSU+YrVTIs/L+HYZhw7Wr3ItBXZpH2bubqgp/7xQbZSDAhLqB6hc8Lev3DdANHEec6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=bks7/AHy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61ff7638f4eso2095910eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1758035945; x=1758640745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+p7h9moPYgINE98uoLpnHKJBq2tK9bPrrVW4csykGcc=;
        b=bks7/AHyJhajpcQFFu+olOR8rQFr9umKMGaBkf+mOdTLBhnUU1NNmagBk3CZGcPFX5
         zYBClCQlcu6GdaYppxVu44Y7MqFW3KeqyCTNWpelmSjG100GpwIMKuZ29tLc1OuspZbR
         GaL/5/DCmBftkbALUNj87mnEfiHxqIs8N6RwsdiMotENVISFLtiJGgbi8YzjlLjvFN3n
         hKmA2dADhMePZQVYNWkcCWqhLdY6OlxWaFlbr8606IXQAHKfdTRTl5GtZ/6mhK02Q2Fm
         ZpVoJwWjHxxuLLlOTEPb0X4RELrMdYAnaQNLJwcbfTQAUVOzSut7PxvaghpZMXtSAHp6
         UcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035945; x=1758640745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+p7h9moPYgINE98uoLpnHKJBq2tK9bPrrVW4csykGcc=;
        b=wlJ3+C2JqowSugFtz42C5paC9vPX29xbzQA/AWJWQCe9B6s/s7RBoiyPk3p4vww6p/
         qe7AbTPVkHkQjOp4wGti7CPUQwY+yXld5SJ3WPeuPBWNKkVSmXwOF4bDPDT9w03sLKMI
         Nx2qgW9BAp0Sim2ca7r0v0g3C3TLCZCS226b9eHH9BOA8SOiIBJA9x+1neQ/XTL7gAfV
         98XR4bnfEXfnZ6kZwpvValrReN8eQjkUq8VQhvphkLI84ekJuXTnrJQKHzGM0liWD6rk
         o5SqJ1wWs7qWuiKg5Nq+Rzo572f7Vk6ytgh0d9zwNrmbOXiZBRewnWcKyn//A7yDjMt/
         WWtg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEMogqAb5QE2NYbUrMcYS4qMsv390m4r8ExuRXhACTBAtLP1p0Ops9G8lE6WFFIdRaK8nsUhggZVPQ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymM6rEYqN/CBMlhZ1BZaM14OxJ4fbLGJAJprO8wFceNj84tSfe
	7kVK0qFeTj9yOk1rUZr48uo767q4C6tS+AF3wtqMUN0WIsv8+9aNezam1V5eElrUucY=
X-Gm-Gg: ASbGncsGDG8XPlhQausJl07Mg1jR4vYTmY19LSQ/in2vnUaN9sloiJxvgRR0D2mluXs
	VkbPOopv+tO7YkBEwCny5G+IBYuAVyeboYuX4HX/KY5OI4PSLKuMBHwSoUEzNuhtyfIkTW4Pk+K
	u+F0dQ0G0/56gkT2rK3CFUfjC9q5Ag+KVW2qiSL8yJ2xHBZSoiQTGeUpwh3EfCqylUtANLJIfIj
	9MYob31Bc328+ZGgRX405gY5d+dDU6xddq7eCHRuYXOY6oVVEeAu588EhFwmQPM78zjGRE04nYL
	usLmOg0EE+ND8cXFt88A9Kh0zuRRgK1v+7V71KeNF6v1Zi4LacNJdvTCP1NfzYLKH1ANCbalhE0
	j9/nGMfD+LmKZOGYwzp8tOX5aDA==
X-Google-Smtp-Source: AGHT+IHukfIJqt11Qr9G8lw5Wx2j5qPkL0FBu5yNTX+Je/XHr/6y5XC+n3E6kNJrAdkc8n6REHrCgA==
X-Received: by 2002:a05:6820:1c9a:b0:61e:7bc1:3b with SMTP id 006d021491bc7-621bedb7826mr7978820eaf.5.1758035944996;
        Tue, 16 Sep 2025 08:19:04 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:f61d:e1de:f591:d56f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-62341c04af0sm997167eaf.22.2025.09.16.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:19:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:18:59 -0500
From: Corey Minyard <corey@minyard.net>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Message-ID: <aMl_47OOOotywm0U@mail.minyard.net>
Reply-To: corey@minyard.net
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
 <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
 <20250916084002.GF1637058@google.com>
 <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
 <20250916101438.GA3585920@google.com>
 <CAMpQs4+kj0i1BpJ4Nk+Z=Ov-AMEWcqPmkbruNhD--TmycX4z-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4+kj0i1BpJ4Nk+Z=Ov-AMEWcqPmkbruNhD--TmycX4z-Q@mail.gmail.com>

On Tue, Sep 16, 2025 at 06:51:25PM +0800, Binbin Zhou wrote:
> On Tue, Sep 16, 2025 at 6:14 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 16 Sep 2025, Binbin Zhou wrote:
> >
> > > Hi Lee:
> > >
> > > Thanks for your reply.
> > >
> > > On Tue, Sep 16, 2025 at 4:40 PM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Fri, 12 Sep 2025, Binbin Zhou wrote:
> > > >
> > > > > Hi Lee:
> > > > >
> > > > > On Thu, Sep 11, 2025 at 10:33 PM Lee Jones <lee@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > > > > This patchset introduces the Loongson-2K BMC.
> > > > > > >
> > > > > > > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > > > > > > And it is a multifunctional device (MFD), such as display as a sub-function
> > > > > > > of it.
> > > > > > >
> > > > > > > For IPMI, according to the existing design, we use software simulation to
> > > > > > > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> > > > > > >
> > > > > > > [...]
> > > > > >
> > > > > > Applied, thanks!
> > > > > >
> > > > > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > > > > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > > > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > > > > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> > > > >
> > > > > Thanks for acknowledging my patchset.
> > > > >
> > > > > I can't confirm why you didn't apply the IPMI patch, but this appears
> > > > > to break the patchset's integrity, potentially causing missing Kconfig
> > > > > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
> > > >
> > > > Pretty sure this doesn't break anything.
> > > >
> > > > What build errors do you see as a result?
> > > >
> > > > > Additionally, as Corey previously explained[1], this patch can be
> > > > > applied through your side.
> > > > >
> > > > > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
> > > >
> > > > We only apply cross-subsystem patch-sets to a single tree if there are
> > > > good reasons to do so.  In this instance, I can't see any reason why the
> > > > IPMI driver cannot go in via it's own repo.
> > >
> > > However, there still seems to be a text dependency issue. The IPMI
> > > patch modifies the MAINTAINERS, which depends on the first patch.
> > > If the entire series of patches cannot be merged together, does this
> > > mean the IPMI patch can only be merged after the MFD patch has been
> > > merged into the mainline?
> >
> > No, not at all.  So long as all patches come together during the
> > merge-window, there is no issue.
> 
> OK, I see, thanks.
> 
> Hi Corey:
> 
> What do you think about it?

I thought my ack would be sufficient, but I've pulled this into my tree.
I can't apply the MAINTAINERS portion of this, but that can go in
later; you can send me a patch for that after the next kernel release.

I'll make a note to Linus that this depends on the MFD changes.

-corey

> 
> >
> > --
> > Lee Jones [李琼斯]
> 
> -- 
> Thanks.
> Binbin

