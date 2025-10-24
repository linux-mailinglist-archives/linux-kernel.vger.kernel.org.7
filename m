Return-Path: <linux-kernel+bounces-869397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F14C07C82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBC13B5DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115F34A768;
	Fri, 24 Oct 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b="Vso706Kq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C1F5827
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331118; cv=none; b=Bu2b7WhHz7CyuqdG+ErffsjMLTP2T+wh4NQTQkgRoMRMqqFIk7BkTh59MAlLgd9jB7sgMz3yFcNSLNP70m2CcStqXe9HovGk+ZMZwl3xWBIj3r0IHZmpEKVfbiU5eW2GlTwYbpOy4Kqe6qdxuXyRjSo1+bKL9vvyFBJkGgwblPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331118; c=relaxed/simple;
	bh=NAESK4xE0AJwpsdA0hU7GaP9dMmNYf6jUNchmY2TKzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udwPO/+D0sAql+sBDdZlycdxyHsp+LwTyWj+rYK0dtcZ5FzoxRhGv0+K1drnOlMt1V0SbTOtshHIdnooe+0Pc+b9cvEB+capPZS7nYDb6VsfQLDAyGXd03n84xXfGbF4sZ/KlgCJsa1qV8L7vtUsiCtmerqzKRzFuYlazUZYujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com; spf=none smtp.mailfrom=darkrefraction.com; dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b=Vso706Kq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=darkrefraction.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso3883667a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkrefraction-com.20230601.gappssmtp.com; s=20230601; t=1761331115; x=1761935915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SehxGFf5RI+QNApRbl8Q/HaZF1Kv4u2TFfr5KHjmZY8=;
        b=Vso706KqsDJuI9SSopq0i2wiPbTgH6z5a5Xz+LfC41Ht8MS68k03QUoMjr6pghS/MF
         yVCOXJIAgP9qNaLHn2IHgtRjRY0CYW8fzbmYQY6WP59nesjj2j4E8vylbNJwXvb+ndvp
         MUwPMhh+Mhj+VNrgowoK5qiHsOAfIXLU6E0ivOdYbl9THxz1nSIpKCqR6cmiQ47RjDXI
         a/fpO1R9Id+jW2mGMxiXfZ6SAQXNhGW/WW1j+37iv+xajT3rpSHArAVTtx9CDTR6ZWUO
         VhjbB5jXxxKVnen9SspnAzrqOKz1qk0EzUfPTVqjKbHHYzOHTyzVJu1gf9EWDSwK5t5n
         ibpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331115; x=1761935915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SehxGFf5RI+QNApRbl8Q/HaZF1Kv4u2TFfr5KHjmZY8=;
        b=cZGtYNcIdHhMzLrZ8N7+3+IijaAV73uJEByLAi0pTSn5SS5Eh+fTRrWbwzKXnhapSt
         c4vmoPmUR9UPuKw32HJ3kdujkUiu9/jFDj0eyNWygL+ACrr64aDjeWMXYN9jfcTqRaP5
         qJD0vDf9fKGa3ytRsum0saQ82JWedAlgAfFpBUxwClfX17ZauRQEqi/VYx6bm4ZxYQCs
         7k05c5u0e7XBPxesisLgLK2A7MZTpPz3+/cHgL/v4A3ghmsuck4HNJWK51wPRIDhgNTs
         IzRNeGHAtYfsQ5VlcxwIZixhugVaJ4wk5mOlxvzI0+BKAsyRSZOhitApwCzw2Pz34Dmk
         SnLg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Au39CDyjtJMfG0YfCatnawRJd5zuGFZW42JwznnOZvrGFPpFuh7aCwk6U6rUVRZGjkmrIv+SHPGuaxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+D+EXlSOsbyJwXkoApE6X2rCIOgPLbSpuxZg6pV5vhevUn4S
	i/A9g9PJAlR8I6pkvKMR3gleoX0OEkDFCaVBGJd/l2O7/J04vd5q5Kl3+x19WgZB0w6OioweiST
	Sy2bZGHhujKKZ/POc2/HqaphxcMDtKSthTUv+0x+tXg==
X-Gm-Gg: ASbGncs3SplQiTCddRCcuny87X55PjXkDilzxCegSV+srTulg9B9VuLhH1hAf1csG2c
	L6+QZ710bngFtmWEFukOT0yEYo81FgBzxFuCoUR21HuYBp1NkVjNsT5pP8G6DXGm4NXGTBZ1yze
	8EJyFAP78Np3kK0aXPUQVMk6uz0zHu4Mjzqk5vvr0i2ERpcgtzvJSOa7oDl4Za2IXJnl/3jIJJv
	8UV+IHyyNdXkK7VYXxsw3v0iYElPHQ/0FZLoAPzq9FpBXt4Vr3Cbjbz/+pI
X-Google-Smtp-Source: AGHT+IE1vxC1Uwjj8R8CM1AWbxojRAD3IvgvngS7zRhcGLQcsfz5Kuv+JEHnlpy2xp8g/pOMb9xkDE45L8O5xqHHD+I=
X-Received: by 2002:a05:6402:3586:b0:63b:d7f0:d93a with SMTP id
 4fb4d7f45d1cf-63c1f6364c8mr27858987a12.3.1761331114665; Fri, 24 Oct 2025
 11:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
 <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com> <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
 <904ba70f-b1bf-4745-8e92-d27a6c903673@kernel.org> <CAPv6GL2DQ_wY=r4eV_V=nBGaj20HtYzRfJg==rQJtuO8Fo+HAg@mail.gmail.com>
 <CAA+WOBvfStqh+HTXYrrD_=YUXPYNaKLgHPLQ9g07gfQmAXKAWA@mail.gmail.com> <6bfd10e6752cd682e396fe14a367885a26346568.camel@redhat.com>
In-Reply-To: <6bfd10e6752cd682e396fe14a367885a26346568.camel@redhat.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Fri, 24 Oct 2025 14:38:08 -0400
X-Gm-Features: AS18NWAt5obvzBW50pR65D8rfSGongK4bck5mMwpTRAiNvffKJwTezyBXT3yoSA
Message-ID: <CAAgWFh3rMwAwcaSCYsyaM0Q+yT5pf=teLQsAUJYyUbVHRQYjBQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Lyude Paul <lyude@redhat.com>
Cc: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, Mary Guillemard <mary@mary.zone>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:52=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
> One other change we should consider making though: can we make page_shift=
 32
> bit? A page shift of 32 would give us 2GB pages and I think that sounds w=
ay
> larger then anything we'd expect to encounter. Plus, we could just warn i=
f we
> get a page shift larger then 32 bit and fail the ioctl. 64bit % 32bit sho=
uld
> be faster and at least alleviate some of the overhead from the math here.

If the 64-bit modulo is a big concern, then this could also be
re-written to use bit arithmetic like this:

static bool
op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_shi=
ft)
{
        u64 non_page_bits =3D (1ULL << page_shift) - 1;

        return op->va.addr & non_page_bits =3D=3D 0 &&
               op->va.range & non_page_bits =3D=3D 0 &&
               op->gem.offset & non_page_bits =3D=3D 0;
}

