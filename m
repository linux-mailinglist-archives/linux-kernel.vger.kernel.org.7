Return-Path: <linux-kernel+bounces-819728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46818B7D0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99ED327EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C12C3242;
	Tue, 16 Sep 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="BbiXPw6r"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BF2BEC4A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064821; cv=none; b=H+45wUhQ/EgmmC1r1gNCjTbdUHsW51FFXS8xMjhnqODkmvk4XioISiAWQPZFGdd/5wp43Js4awh1nuBhE1m4bM4FRR0nzOr3DvDLm7APOS9kRHUJjft7TTo4yDzy7yDjbfBOgv4Ci+liDtZf/+wRGzB3lVnVhLdUCUKBQO00VII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064821; c=relaxed/simple;
	bh=8TP/U6EO6FSYI+4jmHqjMS4o48NmZbaRlupvr8P30TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUFNtBjTHGqUkebr0RBeBejZr8y2hoL/RpOBT3Lp5P5jdBJr9wfPvW6Y09+fdvzP7d7en2KeS/+s5paZx5y/ylxWYk/fML8RDGph80Gymu9jdo3w9/oiNwDBHSI08nrSgM7SbJbItL/mqReKZ9L6h2Rxcv0QKqbmiaaqajOPZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=BbiXPw6r; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31d6e39817fso8795675fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1758064817; x=1758669617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrEMNHKwYr/02yPBL8fxjj+3KhJzD85mECDAPLYkhT0=;
        b=BbiXPw6ryRgbK8r+S8aIQnqc0ecHa+5aKo42RfYkzBA5VIVYDRYrKbMlWoyfMrygKb
         kKs61+h1thrftfpKvNy84e5SrO4S8W+O1z0sSs18Dxsp69AoFXbYxcBdKEPH15zoyaXC
         R6RaQYAHqlYQAtmYLu8p1CAjwTVVGUmbCzY6usRrQu2tYIyrrpqD/Q16/HEZFBXTN0Jb
         RQd9mVGt1jUQR7uJ61PGzqzNcHvzgH5tNh9kU3kEH+zZkiOs5vf1AOxGsZFg5Zo1YlAD
         vohkBVgFvB8JU0l58FBGupVWw5GqPDbarvq79Pd8EP3BytsVvZ35zIdJuSkn6xyr8n04
         3qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758064817; x=1758669617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrEMNHKwYr/02yPBL8fxjj+3KhJzD85mECDAPLYkhT0=;
        b=oJf+GViKGYSJwetH2nIYjAz5jg22M8AEoaZoutrLc/Df/T4POaTw5vVuU89n6XR9Gn
         34P/e0nclJiNYtzoDE6q1EdQLGg1LfbU1H6NEW1y5NZ/LPVn0zGJi6qNKXpqkYIyJNjM
         OKoViaYVU3UvybOJnkW5uHyHbPf+7EJyKXhX6e9wbOyRmLzDuPLn+lEYSg74EaCNJfZY
         Aoptqwrchig6e16pgtM0jYWs6SPU6vdK/qX05yTVvD+yEENdswuUJ3sHy4anuobpgIZ1
         MGo05yZ9DeAjKqRxvNuHr1XBRNyyc821aSwlf6EjzcDmvcYYcSdzL/kwFrFljd8W4Rw6
         4ReA==
X-Forwarded-Encrypted: i=1; AJvYcCVi8g7TguN+femL/qhq56sgVpgy5xoG2YnlV6PvLVx9EsnaAtBQLHNI6k8mOjZiw6W1HXjktKm56cp1TD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwY95c4OIG6/Zb5v1xyP+TzFPB8RJeRCEMVbG6I0LrdUW5TqKx
	8x58nTEEZyH6tSSqKebUGwcrKM3M1rtqhAdBIiy27IZlnk6vF0dbN/a5jIQib2tzwGNePOMQt34
	REpf4J/DmQg==
X-Gm-Gg: ASbGnctnObLA+JvaRbCNkcYxLLtczob3QA7yzxHScCoTI0cjBFvQ+UuIhVOAr90bMmp
	RmlpJjN6/gsvktzezpUKdHxqil2ApCExK+BEgnpexcsX0HziWrrbxwviqYf/zLGr915ifA3QI4r
	ZYn4FNnEbdD0xBXVb2PMFPSJq0KvsRAAfj+vOu8Oa4zAz7KvfkbHGoUwNHq48Yt3dGK01KnXKrk
	aH67y9D1pyxzG2IikrqFNuiHOevjIssqcnzc/wN8kt4OTm2VklrOUSmXbUcbXRVfMVDiK3Z8Zne
	NQiya0XNzY0a27YTy6fqZHI1q1nNaMhcNU+jyUNvKuS4ZfzW8oYznVWyBwS8KR3qvaH9gVkzyjD
	5PF8Otxraxq4D8r+Ka14m3wBTpQbL8P7M7oM=
X-Google-Smtp-Source: AGHT+IHFZz1ctDlZZkhP4iHGu+C0RukwNgJ0/Rqt2jFZKAtmZEiMKO57mZJI7ViSusQ/kdwk5QrNDA==
X-Received: by 2002:a05:6871:5809:b0:31d:8c1f:410 with SMTP id 586e51a60fabf-335c066873dmr91436fac.48.1758064817432;
        Tue, 16 Sep 2025 16:20:17 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:d2d4:a69:5fcd:4e2d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d35380409sm5268258fac.18.2025.09.16.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:20:16 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:20:11 -0500
From: Corey Minyard <corey@minyard.net>
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Message-ID: <aMnwq3i0qMREnjI7@mail.minyard.net>
Reply-To: corey@minyard.net
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
 <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
 <20250916084002.GF1637058@google.com>
 <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
 <20250916101438.GA3585920@google.com>
 <CAMpQs4+kj0i1BpJ4Nk+Z=Ov-AMEWcqPmkbruNhD--TmycX4z-Q@mail.gmail.com>
 <aMl_47OOOotywm0U@mail.minyard.net>
 <20250916160845.GB3893363@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916160845.GB3893363@google.com>

On Tue, Sep 16, 2025 at 05:08:45PM +0100, Lee Jones wrote:
> On Tue, 16 Sep 2025, Corey Minyard wrote:
> 
> > On Tue, Sep 16, 2025 at 06:51:25PM +0800, Binbin Zhou wrote:
> > > On Tue, Sep 16, 2025 at 6:14 PM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Tue, 16 Sep 2025, Binbin Zhou wrote:
> > > >
> > > > > Hi Lee:
> > > > >
> > > > > Thanks for your reply.
> > > > >
> > > > > On Tue, Sep 16, 2025 at 4:40 PM Lee Jones <lee@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, 12 Sep 2025, Binbin Zhou wrote:
> > > > > >
> > > > > > > Hi Lee:
> > > > > > >
> > > > > > > On Thu, Sep 11, 2025 at 10:33 PM Lee Jones <lee@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > > > > > > This patchset introduces the Loongson-2K BMC.
> > > > > > > > >
> > > > > > > > > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > > > > > > > > And it is a multifunctional device (MFD), such as display as a sub-function
> > > > > > > > > of it.
> > > > > > > > >
> > > > > > > > > For IPMI, according to the existing design, we use software simulation to
> > > > > > > > > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > >
> > > > > > > > Applied, thanks!
> > > > > > > >
> > > > > > > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > > > > > > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > > > > > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > > > > > > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> > > > > > >
> > > > > > > Thanks for acknowledging my patchset.
> > > > > > >
> > > > > > > I can't confirm why you didn't apply the IPMI patch, but this appears
> > > > > > > to break the patchset's integrity, potentially causing missing Kconfig
> > > > > > > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
> > > > > >
> > > > > > Pretty sure this doesn't break anything.
> > > > > >
> > > > > > What build errors do you see as a result?
> > > > > >
> > > > > > > Additionally, as Corey previously explained[1], this patch can be
> > > > > > > applied through your side.
> > > > > > >
> > > > > > > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
> > > > > >
> > > > > > We only apply cross-subsystem patch-sets to a single tree if there are
> > > > > > good reasons to do so.  In this instance, I can't see any reason why the
> > > > > > IPMI driver cannot go in via it's own repo.
> > > > >
> > > > > However, there still seems to be a text dependency issue. The IPMI
> > > > > patch modifies the MAINTAINERS, which depends on the first patch.
> > > > > If the entire series of patches cannot be merged together, does this
> > > > > mean the IPMI patch can only be merged after the MFD patch has been
> > > > > merged into the mainline?
> > > >
> > > > No, not at all.  So long as all patches come together during the
> > > > merge-window, there is no issue.
> > > 
> > > OK, I see, thanks.
> > > 
> > > Hi Corey:
> > > 
> > > What do you think about it?
> > 
> > I thought my ack would be sufficient, but I've pulled this into my tree.
> > I can't apply the MAINTAINERS portion of this, but that can go in
> > later; you can send me a patch for that after the next kernel release.
> > 
> > I'll make a note to Linus that this depends on the MFD changes.
> 
> Feel free to separate that from that patch and I'll happily apply it.

That's great, please do.  It's already separated out, and the rest
is in the next tree.

Thanks,

-corey

> 
> -- 
> Lee Jones [李琼斯]

