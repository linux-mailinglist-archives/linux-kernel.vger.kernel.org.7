Return-Path: <linux-kernel+bounces-769638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C6B27160
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD41CC1619
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A8279DD3;
	Thu, 14 Aug 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M31sWAG7"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA027702D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208921; cv=none; b=jyTWaH5E8tn98kpVqYehWT5F8zSxqFKdnhbySmdb6Akd06mASqR6PMrOuuWPKIVXR+Hj1rbvaEtJF4FQjm/vkTYVkfSUvrf2CeJYIphkiupjX5Qkd4Fy7AE3k+CF9IuLNj1N4Lh+OYDzWgASXGklRIsVl/64r5K3DGHiNslRNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208921; c=relaxed/simple;
	bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBlQMjAewMcE9JlzPmWQxEkpO+4E5amF7lPbHK53rKOVnhONqvfLlhE7WDeM0U0ZKbXjcBLcrfNma0Ag74Rb+WVYKj+irZlddRrASzmHsipuWruTZp+2SPkIPYlKZzDhXBBw9bvFDx+7BBDi3JbE30pBL4VORtzx7MpfKFPmobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M31sWAG7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47175d02dcso1296732a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755208918; x=1755813718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
        b=M31sWAG7mWHhJiDsA0+DndcrTX6zs/MOfjGCRfPh18ZPQk9ObCOyC/MP6gMa/GTaid
         +Lli8PDAI/OZkHTsMiFZ577EB15qcY59ssLHSe2yIeFSdbuMU3RYXfYEa8G545U8tvEp
         uInuuKRiLoZl4I9Ya5mQ4B3cXRBud8Vhc5De9PR0c+e63hV6OlGmxmc4e4R4r+CoTt0O
         gwfozw2fIF+7M6cpts9QTUsBuzBeqqzHVKqKebxdzmxRdY25hwteyRCJ8iXIHcGPw0W4
         TfouhIdm+5LMHXPFoFfXI2VL1jXWgFWmAiHjXXhOjAC+OMzDFb02RADODs5q7/PyJ8Ib
         e74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755208918; x=1755813718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XRnisqu9O3Dx+8tug0BrmRshiqBof51dFIrTfCIjUs=;
        b=e3tmNEzrWkVe+ni4O9PaC8b5f0cEcuEljr3mFx8P8krKdSFEfIuemTE4ZPW7IHLQbZ
         dn2dk276pPo1enfHtwc7U0xQza6baeMjm51sMQZU3Ak3dVMXuuf34UNZupYnTXNVxhHj
         FCIa/j4hmx8Gkclhts/VMMU6DuQXKod05EMGmEL2XMEGr8L2d5Ye75tShTD8GLV9Lnei
         zCH4Ku3RH6ctiEtEsNZqdDc6qbD6SXhJJCmZPCxFH5FMei1HaC0t2wPwyzeCQ5c0cloc
         YnQGsnyUg+SvQt6I014GaNfD7yT+39mjju3KEXloUvKAk6k0vEfrCmR9u5QIoJQung62
         HNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVCTuf2JPNGjtfeBMsjCXfDCy2by4kyWCNKoRsSqAmYnBGuWMzLuXyRIPV9vArbRJXxG2Wo/zcUvgWwTOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WrLDXoTVFcQxh3lb+kCpA5IDq/SikT6VeOP+alAuWoG5zeRS
	UwUDrWBlBgLXxZhuSLm+MbtTwlg0sJSfp40pIiLUnpGwBK+8amTX4vjwgz38XvqmnP8G/CJ8zSU
	6saBPvPuzkr1GGPm1IM5zG+9T4coSPgLwOKXbXM6t
X-Gm-Gg: ASbGncs0ONQpkbh8vI+UjdvhcZyLXGRns/5NxYp+kt7gvA2JZ6rkSSTMTEP3FHy9qYq
	Xpom5k/dNKHc2C2nzgCWL44hAynSvMs50cJnwIviP9hGaQq7Jsf9syjuM+ZxFRTeWiQgtGJXH1I
	C+vB9koaDCcmnZlvFu8UPgw0QFz6ObhHFgqWxaZMuhaqaCoPhGU1vKz+kWiTfQNm21ws6dtbDJ4
	ZnWRm0=
X-Google-Smtp-Source: AGHT+IEDzGUCUbmkKBi2lNmiCJDObwt7jyLc+L7VNoACWG6u+R/JY1FN/9Lybn1yT+eA+zKooGC4MTk6BwBsiV+iI+4=
X-Received: by 2002:a17:90b:57e4:b0:31f:1757:f9f4 with SMTP id
 98e67ed59e1d1-3233d227a0dmr691002a91.24.1755208918463; Thu, 14 Aug 2025
 15:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
 <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com> <DC2BTIG40SRU.16QBMDH0PP01Q@kernel.org>
In-Reply-To: <DC2BTIG40SRU.16QBMDH0PP01Q@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Aug 2025 18:01:46 -0400
X-Gm-Features: Ac12FXype_aLvHDtZZOQRIYNqbuL19JtT5JJvdcu70_SXP98N_IoFGs7sLelUB8
Message-ID: <CAHC9VhQAk4irkap1UUY1dLST3DVAGxMJ8m5VqX6BpkC7rLdhxQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:28=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
> On Thu Aug 14, 2025 at 5:54 PM CEST, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >> On Thu, Aug 14, 2025 at 5:19=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >> >
> >> > I'm happy to take this via the LSM tree, but it would be nice to see=
 a
> >> > Reviewed-by/Acked-by from someone with a better understanding of Rus=
t
> >> > :)
> >>
> >> I think the idea is to take all these through the Rust one with
> >> Acked-bys from the maintainers (or we can skip this one and do it in a
> >> future cycle when the first patches get in).
> >
> > [CC'd the LSM list, as I just realized it wasn't on the original patch
> > posting; in the future please include the LSM list on LSM related Rust
> > patchsets/patches]
>
> I checked and I didn't find a maintainers entry for that this file & the
> LSM list. I'm using scripts/get_maintainer.pl to get the people I send
> patches to and that also checks git commits, so I guess it added you
> through that (which is very good :). So can we add a maintainers entry
> for `rust/kernel/security.rs` so people don't miss this in the future?
> Thanks!

Here ya go ...

https://lore.kernel.org/linux-security-module/20250814215952.238316-2-paul@=
paul-moore.com/

--=20
paul-moore.com

