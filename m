Return-Path: <linux-kernel+bounces-755598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3761B1A8EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975B57A4FAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616B28B4FA;
	Mon,  4 Aug 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhaRGEp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288617BA9;
	Mon,  4 Aug 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330913; cv=none; b=YAlnaVwYG64m9mob2e3zwuh5vv6A+OO4JJweyvQLe8w2SGkF1Hq4fDvdAKh+grfXkJfwI5NczW26ueyAUEX6IPtivQo1e3IN/te+5qXB86uU/w6zgRr2SFUfnSZPXQTJVsAWHlS3mEwjXtxJFBJ35H3qgmg79HGHWTDU8Da9eyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330913; c=relaxed/simple;
	bh=ID+vJhobuuyWhkhRwHBgvOYKsYosMJhwpGMPF6Hc9j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+zAYaUqjH2/qbZFvaZWzYhgyi4zaFjYAnNwR1iwSpUg1h8uI/SPhIYrp+TS57WwlSKZN2QPMwexkY1MmdF50jnszLWccSMBjpMCgCaDcGjoQ/hH6jSi7qfDTx3SgEcDjZDqick3kRF+4OSyn1H7Ya0xnQ0OCqY+EtPLIX21R7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhaRGEp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921FFC4CEE7;
	Mon,  4 Aug 2025 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754330912;
	bh=ID+vJhobuuyWhkhRwHBgvOYKsYosMJhwpGMPF6Hc9j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fhaRGEp4w6Bb2Aaszwjaxilqa+skAMNmEg4Zhr/hBzN10fXiwqU7oxMMXNWTsFJi5
	 L9q+o9GokVd3NKTGfth4S4SiU4CtRgkgLuvpNlOByD9YWqJeFTh3qr24Mfi00g2eCv
	 rbRoGajhNmXim5s5AM90NGajOvA2j8bY+HGCvaDbFJUTftvqNKfUJanjQFSKkYt0O+
	 Mrgq6xwJcFanh3j9qvK4h2c8xJvbK+AuOXL3vzbQtVdbS6wlYtotvtjoBzIolkx+hr
	 ySGzG9L2u2vSJJeOP5XaCNp6RthJC7es0vDDyioU4C+LbgiCWFluMKKPXSfbq4WTto
	 5d9WLNj/bDjCQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so4146494a12.2;
        Mon, 04 Aug 2025 11:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/n44qbLU2oeDZ2t8SLSwI0euXV5gEN68MMC6uzGfJ+PPFJpALWpRCxO77ZCyY1aCCQA66fQ3kwNQIR2/N@vger.kernel.org, AJvYcCWlJXrBK7nsz+HnTzVoS/wiXwHnfZIjkbCE2poIJvZINEiv69kF5kCPMeLAkeW8fxJdWVCtREFCyDw=@vger.kernel.org, AJvYcCXVEspPRcWIb8TNREa80rF8G4sfdHgbZra8pXjW35LqJu2VeSa+xEPvNUeZbbPLLG7mWpfB081ox2qv@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQ7Z9CONqWXxJuMHGQYmnzgH2Fpzpgr37fj01a32vwAgviDtY
	NcCGMom0SV6NV/aV8GQj0yuaH2pv2Vr3yoNIJvXHP3277IApYENEOso+p8N2bUoQ96yQZniwXHc
	rDXG/S0Jk50+y722FOZwk2YMurs71Zg==
X-Google-Smtp-Source: AGHT+IESbkBOk4VXQ+qj0EbwMdurvHOFWsb2fwPx/cQ1mKZvoleIyUh0RxNWpG2D3ckhxwpCiB4GOOqzViLH9sT2XSc=
X-Received: by 2002:a17:907:9707:b0:ae3:ce75:afd8 with SMTP id
 a640c23a62f3a-af94015619dmr1092929866b.30.1754330911099; Mon, 04 Aug 2025
 11:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753806485.git.mchehab+huawei@kernel.org> <b03b95b8d09358e81e4f27942839191f49b0ba80.1753806485.git.mchehab+huawei@kernel.org>
In-Reply-To: <b03b95b8d09358e81e4f27942839191f49b0ba80.1753806485.git.mchehab+huawei@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Aug 2025 13:08:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJV4JgWMn+w7XFX=ixnwWW=_buisp0fF_B-2NmbpmMTqw@mail.gmail.com>
X-Gm-Features: Ac12FXwRQezySL4m4aOOBNpG1DwRIyZxmEgwfM2DYzX-sBu0w218Tt1nn_CVDxU
Message-ID: <CAL_JsqJV4JgWMn+w7XFX=ixnwWW=_buisp0fF_B-2NmbpmMTqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: changes: better document Python needs
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:44=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Python is listed as an optional dependency, but this is not
> true, as:
>
> 1) arm (multi_v7_defconfig and other defconfigs) and arm64 defconfig
>    needs it due to DRM_MSM dependencies;
>
> 2) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;
>
> 3) kernel-doc is called during compilation when some DRM options
>    like CONFIG_DRM_I915_WERROR are enabled;
>
> 4) allyesconfig/allmodconfig will enable CONFIG_* dependencies
>    that needs it;
>
> 5) besides DRM, other subsystems seem to have logic calling *.py
>    scripts.
>
> So, better document that and change the dependency from optional
> to mandatory to reflect the current needs.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/process/changes.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

DT schema checks requires it too.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

