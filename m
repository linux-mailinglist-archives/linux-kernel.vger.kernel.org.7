Return-Path: <linux-kernel+bounces-754440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F789B1944E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC1E3AB78C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630E2BB17;
	Sun,  3 Aug 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0PJKqQH"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAF28EB;
	Sun,  3 Aug 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754234142; cv=none; b=uUng3oxR65PNNVL8noYGAOgWrj+Sge5xlmQjyf6hiIjvbzDNg5pEu7rP6wobX8emi3cNI6qzbnWdYRlw6AhnYmdSf+G9qNAMWgPJjBG24OFsfwE7TJXyvu67RW05sqRCIoVwDzOboH7Ok58hLQOhNI8GmnvPzZ0YH8Wtg2r6+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754234142; c=relaxed/simple;
	bh=wS2ZQ64JMN79CNmjPInj6p4XsgBG9AkgGO1OR+ihdmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjgxoMvpgUDYLcUqfIa3yWvKB2LtyXdoWCd3jM1HoZLU6yN45a2VkQXyZNtwX9NKs8WJP35EKhSEoYawp8ockbehJXShdWhCMT2N1hpLwI++VOUpJLNkVH3ooA4Ec+56w6it/20GWZDSBf2E0rF/ajOfmWmtbP5llBOQ/jgQ1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0PJKqQH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3f2ea2f96fso534341a12.0;
        Sun, 03 Aug 2025 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754234140; x=1754838940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS2ZQ64JMN79CNmjPInj6p4XsgBG9AkgGO1OR+ihdmo=;
        b=C0PJKqQHpa3KUTxPlijhpIKJXJiTCz25ekMVipXC5Mkucogbiz957jiuV/D2X4UX79
         YSMpvkrcqHtKFMj5FSuNubP9UH8dLaXP0RTnazINg4NIOSTlkickE1NGBQmm//jyyvdF
         0BKoONZVcxjiGHN7bSvKrGrwxQntQ3qzdFdo7DabhJ7nI2VzziNxustR2hWjZzntfZ/i
         T4FfzH5dmycPnYL/Q1OGrymk7/YtbYK1fj2/WvSjy8c6y51WBaOs9PeKSub70KLnNz00
         sSsk+Np7frVBnLtfSeUfHM2FxzCY3XhfoJtGt+t7EBCAAoCR6OnO2MBiUK5uRq8DsRDW
         KuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754234140; x=1754838940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS2ZQ64JMN79CNmjPInj6p4XsgBG9AkgGO1OR+ihdmo=;
        b=hwzhCz60h80liIwXOn6/ywI3DYGLZD6rPhY0obdFBAKwdYKmptWp4TrjIIt0tFHU/J
         0StD+gE5D/0S16y0uhTBmKCoegCHE9+Z9gdrxVpx8rDpeuoUPVMgnGFGXmsF0MBUi9bE
         ctLCwqyj2r/gUC+uHrIdxtTNhc+Ue+hMudCGIPzyzOUF32lCEqzkMq397UXPkPFCF+D7
         STC8rR9kRk7XwtSEFzNak+YqiHzZP5WUNioqkJj0qzbQG+fqRPh0eQqUu+0KJ8UQNKCT
         eUuXk91GVzF6EGlzQqsnHSb5FvF5G5LPbVsuBgQjFJmHVDlncOb+PvuR/1YRQT6hhxLB
         DEyg==
X-Forwarded-Encrypted: i=1; AJvYcCV2JxisJ27t57BkONJOxEvpiqvyltAYy4s2Dd6sMVjfH1XMPMsjnX2s9oRB4edhBXfcsd5CxdwykhUwkxskj18=@vger.kernel.org, AJvYcCXQcvefl22ehntE1unJlEkcDMzlso7eQL3AdiYJ6COrBzmMymBgZSxgqcn83rPhB+VGj9JIYwog3rlbTls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyy1hlwvuiDyyXJdxTpcxITpRTxbTotBkkJlvhTIVU2IV8KN2q
	cH2ylVfcCWOR0j9skkydjwtdJyTEDGMHd+ly5fKpeMSP6kImgM08eIVHwBztOgmDAY4eKw1XI2V
	498+sM0EzYiZxQ6SZavKcMIaoTOP7JMc=
X-Gm-Gg: ASbGncvY2XWywstUMQnCLlQ0R2aej5FUd0ci5/zvvD3gdls+GgR71RPYJcrQAUfgnLV
	VuK4pwPQCvwh59rD58muM71euTeliI8DipxOadVGGNsBRPDCYC3afjYMUYqusSlPmbfp2T1Kbst
	t19Eg1qyfN8sIs8zL7yWYmSONT69qZJiXYb0U1XGoLIvCbLnUW/vamzpFw6UpKRlRTo7Mq8sXF9
	lDr/fe83sJd+2B496U=
X-Google-Smtp-Source: AGHT+IHqgBoMTYQAjZYRy/NgnlRibK1XTFSf+41lsaqpZtXit+NR5xBn313BlZqHreigej+f3dIGY4kEoQHDi4FMj4o=
X-Received: by 2002:a05:6a20:9f86:b0:231:242:2596 with SMTP id
 adf61e73a8af0-23df907ad0fmr4579577637.5.1754234140028; Sun, 03 Aug 2025
 08:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-num-v1-0-7ec3d3fb06c9@nvidia.com> <20250620-num-v1-1-7ec3d3fb06c9@nvidia.com>
 <CANiq72=BSnom-nQgzLvv-cqwSknK1uJ=CXGP51r0WRj1Y553Ew@mail.gmail.com>
 <DAREXAUV51B6.7X7TPOJKK249@nvidia.com> <CAH5fLghRJ7QqGKJdUq5Nic542cJsHKX_C+EL+xma_rFJrHd2QQ@mail.gmail.com>
 <DBRZX7EAK13R.LTIJJPA9CCSO@nvidia.com> <CANiq72mjT5jJiRG2J4KAL7pupv5WoCb-T+hXJ=H5NG_4n0HLOQ@mail.gmail.com>
 <DBSTIFXLOTMQ.3TTS2O1PDIR95@nvidia.com>
In-Reply-To: <DBSTIFXLOTMQ.3TTS2O1PDIR95@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 3 Aug 2025 17:15:28 +0200
X-Gm-Features: Ac12FXxirE0lWx5ricQYZYpLZRTFS8QojNMzDEVSWYmJtosPsvKX9UIzXFb0rZY
Message-ID: <CANiq72=AtpG=B+VcyWoX+qL_tk-uUtgiLXYJD0epOfnwYfPD7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add `num` module with `PowerOfTwo` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 3:13=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> We got some interesting feedback on the ACP already. I have been pointed
> to `checked_ilog2` as an equivalent of `last_set_bit`, and it *does*
> indeed work well as a replacement - with the caveat that the name is
> not very natural to me (or anyone familiar with the C interface). Is
> this something we can live with? If we decide to go with the existing
> standard library method, how can we make sure that folks looking for an
> equivalent of `fls` find `checked_ilog2`?

One option is using the `doc(alias =3D ...)` attribute, which makes it
appear in the search in the rendered docs, and would show easily in
greps too.

Another option is simply wrapping it in an `inline(always)`, I guess,
but I think we can just use the upstream ones, unless we want slightly
different semantics.

Cheers,
Miguel

