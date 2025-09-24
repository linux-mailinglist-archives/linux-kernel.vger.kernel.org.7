Return-Path: <linux-kernel+bounces-829813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DDB97F62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136621AE22B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5631EDA3C;
	Wed, 24 Sep 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyl/oBaL"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1F1F416A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675623; cv=none; b=Nii5+3NHr7fZOmx9AW5WF3QUyqW0m/5iiyb78EVWuYdIwMnyMEUc0Vyv2L+XhunOg5AHP4Hk2tLUuGbWdFcnMvb8fYo780VmgQ3UoO15MeLtJvnQgp9NtKsKi3bL703unWwyORuea2QOAUkS0G00rPaFYWYIlX8nQ70m+yMIVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675623; c=relaxed/simple;
	bh=DXsKgwytsc7GVyepMCnh11OqJnoVKmtE41xnl47jDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy/3Je4DJ48CYTvz0uRGIMynVrvj8kbQUrqE9wLyh8kq9Fy5OhDtj9/dnNS7Jyorasd5+U/r/LYvAERGi4HLc9DOwUvA40egwlsGgawd5OyrbgN1cdfY/hP19PHGDBNmbXX/+ifmfi4erC35Yf4Kvqgq4aVNEG2bG/b6Rx9xbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyl/oBaL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4d00ad6337cso32264671cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758675620; x=1759280420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsVlg5OxPMiXZWZO+qrLbc/alKsBFgcyv9irh3N5VY=;
        b=kyl/oBaL9JbMaYiOWayEFn2zIeFKykcXa1M9YEFGf10HSyvixGtvD/1eGSvA9pE0VV
         epOCnOr3iIyINmKio4BhC0LOe30sYTY9o42P75uYjV1nfQO+xfEtDmElROE9jP2LWIsr
         o1MEfseBoS/6knJRE6cFUyNCGMe3KqCIa0dbAiK/txW3EPcO9xdafDXlo7Jg5In1u2Lm
         q8HWQg8I0SkxX6hH8O7frt/yZ7pMJfpj1tB9YT1UIvwyrxjrNTLnKKJZi0uq/mv0xbBr
         r35SeyIjJFhywsYHk/Tzbl9OeKwvz9isQYxDbi1EecROJ2OoTh1pfxF1Mt2sNfVRyTvj
         tjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675620; x=1759280420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZsVlg5OxPMiXZWZO+qrLbc/alKsBFgcyv9irh3N5VY=;
        b=C58ssjqye2g5Iz/6JHJ779efQwWEXapXZaxU9YA8zAF5eQSoivQ5NyXKTgigdW9fWY
         auIzNKxuPox/uQ2ivf5C7Nze5K0zzYB7qbrXqrheOtOI8pISiMYn3slQreYdoJNbumJT
         i1GG+6ARGjFCuZUU1hpM1paGdciEDPIEmWT8Dae5IwWr6PVuwMqEBSdiOJ8DunFVOI4L
         FcaT2NESduFMKTVlGuHhtTjPGb4obyGo8+1mAGqCHNZumFH4OFRNH1JQbOjGACTdghyM
         HzH9M2WIvZfCNmVVlFF+cT5R/ychbHbK4OMtF5BRoh4bFxtQ2/sHBPjG+brAEQ0E/OWp
         Amuw==
X-Forwarded-Encrypted: i=1; AJvYcCXArOWyJYGcOaeAqPIlYRs3zZnRk2w/b/8vyJFAdFk5CNnMn0sBqs2w5PJI6JEycKDGeuBd5pZj3fCydcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2c2GWH3pIG0T8IKzPFaBvBaIfKZpm39UHo6bQh3ZmrS7X6gl
	t2bh4jJNirWl8Bbe9yU0MWLlfUP/dRIWSdRgiz9JYDaCUHS7WzDQSG5Ure6FsVfc5cRqVbr8TTr
	4V1+2lZBXUX5HN4LX889ZC6EFsMqPESE=
X-Gm-Gg: ASbGnctAEV/2Nsl9+rGl/zGjC1RS9IC0M2SCuCEMMb5zgi2k+IBVPLiXvO7LuQ/4FP9
	w/FjAUQjD4GglE8+Sgyq9N/YLNv7H19XEkOhHrxuNXgjweIG/hc4ZZc9VuEmc115OBY+MdRNHuj
	bW0S3EseLlAg9EG5f0SGJHpBSZtDeq4zRhELqlv0KZVcZtWFANw2jFwI+H+SpKkvvOKkEfre/4f
	Y6UZ8cAq8dVB58Gd9+dSt60+6WDn5tpOO5TFzhxEw==
X-Google-Smtp-Source: AGHT+IFU+HdxW/LEWFydKq5uIjzjnXTJNktogq3srwO5gahMvnvKX0l6y5Tq5+EvCdygt2yb/FL6Q+goFczk6oDSGcI=
X-Received: by 2002:a05:622a:1905:b0:4d8:67fb:4180 with SMTP id
 d75a77b69052e-4d867fb4421mr7701411cf.8.1758675620385; Tue, 23 Sep 2025
 18:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com> <393411916e94245a9f3628c41ebee34c3dd95a98.camel@codeconstruct.com.au>
In-Reply-To: <393411916e94245a9f3628c41ebee34c3dd95a98.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 09:00:08 +0800
X-Gm-Features: AS18NWCngewRu6_z1rC1usvMWn-hg2wKnEFU7JU8elKMaPgAwRFUKF7tF2eGoqo
Message-ID: <CAPSyxFQ1O-trBv9AQAn8nrh47zVAX9GLFovbpcy=_5Va6rDUcg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Revise Meta(Facebook) Harma BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:31=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Peter,
>
> On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> > Summary:
> > Revise linux device tree entry related to Meta(Facebook) Harma
> > specific devices connected to BMC(AST2600) SoC.
> >
> > follow-up:
> > https://lore.kernel.org/all/3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.ca=
mel@codeconstruct.com.au/
> >
> > v1
> >   - Patch 0001 - add new line between the child nodes
> >   - Patch 0002 - use power-monitor instead of power-sensor
> >   - Patch 0003 - dd sq52206 power monitor device
> >   - Patch 0004 - dd retimer sgpio
> >
> > Base: tags/v6.17-rc3-39-g07d9df80082b
>
> Can you please rebase this on the aspeed/arm/dt branch of
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
>
> Patch 2/4 fails to apply.
>
> Cheers,
>
> Andrew

I will fix it in the next version.

