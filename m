Return-Path: <linux-kernel+bounces-854633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3FBDEEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666023B5918
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDA24E4A1;
	Wed, 15 Oct 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5GY5xju"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB9231A41
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537160; cv=none; b=QMrraCU5NV/H3AV/as4ZdtDDTfICwsED+T+99+Cvh2N2PfE1kJJvAOEs5xTT1TeFK3ULk292z4j0fR8DWLOJP0DDhNTQz9ohFvYzewCpw12LFvPxOVNT6dt9SU8j6sPR49lkAdjd85OWvQCOVlCzk6kH1GixwOumBKlHhO+HpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537160; c=relaxed/simple;
	bh=LyufV/Oxmd5czwod8MbqOItND5kZumwbyc5sLHjKcZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw5qE9gxze5UaDfFl4FysVhfqjDQAmnXWpspvOXGZxT3Dg4n/e3YXDF/dAQw0cDopEV91fmlEOB/5+JzeZwapa3JuWRtlTm/S6K6GpQFlHgm0AA7xzYeJOjfQU6RoWT4drdoIEgSFcEdxLYgIFrrc1ecLOs4hFgrmfPfW5Tk8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5GY5xju; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b60971c17acso5231760a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537157; x=1761141957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Izxb3W52HRiZqSQiVAIiwV9HWtk23rrXM2SEP63D5wg=;
        b=D5GY5xjuHksPKlEQTlL7yVjxeTOeBF6mn4W2mb91s/hPJTZ1Msx6HQirEDtRLAy7M+
         88GU8XaroXIwj0WU0w2IMeeAL9DwI2dxpgsuJKGnD5O91fIERueGFhVgEcdX73bdPDnb
         0ItNV3guRfwdxwuaQIM5FEGzzfT5T4B//KnisWSSInR2EUiTskEmRAT/ki25cInYXHqt
         YvKSpQAIL/kEvsif6x4KFVskB2Qj4a0DOzXAZPRNEAvMv9bAj+KAuAYa1he4SfsjFgZt
         F6HMBlmOgcMyhdpKhAiqrbuhV3t90z6vILbhmWi1beFuDHRBagnT6NetqCl3+PQpHSEY
         wYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537157; x=1761141957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Izxb3W52HRiZqSQiVAIiwV9HWtk23rrXM2SEP63D5wg=;
        b=uUq+hO+q+0vAH4HlqkrbUfrRDc578++6b/1PdmZ2kZb4uPXlPRBah9lDRFriwY0zW8
         mbJNcFwAT9ZG8uNOiWPZTjcYyAgIhYpjJ3RKcIRRH2Jr/p+8FKyNhHwXvlbTXPztKqLb
         a3hlgNvgscF1049zzB8SEPdnFR1KQOyp6SsGatMD5TcW635Y/FKl90INYSJhxzdADXyc
         xeJEOBN19L5F7fR4CD16h05XWAkOSVixFiaBU77hNyD3nEkbb24OJFlAK0tqFWiIgw2j
         Pui8jZ3UsNh7ZUd25JjgtPDaJShp7evtH1ZWXmSPPb3UJZErxhrd1P2jMxemfCIscp3b
         PBQA==
X-Gm-Message-State: AOJu0YzxSAa11U3hpPhpU6wwH8UImp7+wU+IGhmNr30f5weesq8MkiH6
	9lKDh7yrGMxUL1O0QUB1wyaamA5zKLgUklzCAWMPJCjhvnl1HGnEhEwGGbYf5rKQYy5loDUTrX1
	Q6jNEAEFPyMyi9UOMttCdRyGxSjK9gK4=
X-Gm-Gg: ASbGncthSTSsP0+cNbuXYGqYXEbndUSkv4fKNwp8ayL8My8DRLWGlTYTJ439UTTZ8av
	9HsJcL/BbZvPcI+Bq1Op67olXeJ6ItmGX6OL9F23auNZwzGWt8CrKYaAa/JknxFL0vF0G4rI2lm
	EKZEUYWanfujbHortd+1YY8QVaohuspQ6s68MwH2wmtSCVHKSpaM0kCsvHDAxN1GBRcN06jOH6W
	Eft+NJ1PSnFTZuaW44XnIieb0Mg/MD2flaKk+n2WrEEea0/bZ0szn1j
X-Google-Smtp-Source: AGHT+IH80BdRo+6CXpDD4C5IS3FGJwcCjZorcKzoOP4xMkMEbleLUevb8W36dulFWLdsi+QxlI8j9qgAZsAP3mY+ua0=
X-Received: by 2002:a17:903:1b0b:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-290272c1ab0mr388440805ad.35.1760537156603; Wed, 15 Oct 2025
 07:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015015712.3996346-1-rrnewton@gmail.com> <20251015015712.3996346-2-rrnewton@gmail.com>
 <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
In-Reply-To: <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
Reply-To: rrnewton@gmail.com
From: Ryan Newton <rrnewton@gmail.com>
Date: Wed, 15 Oct 2025 10:05:28 -0400
X-Gm-Features: AS18NWDd9xa7otKnSJo4hIQc7ltt0-qgZkcRUOmzit0PnMit8CE93FLvuAfl8oA
Message-ID: <CACYs5Aax6X_8hrYtjC4yAMy5K6e3CwxSjEiW3mK8wfePq3oyBg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org, 
	arighi@nvidia.com, newton@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:46=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
> > +/**
> > + * scx_bpf_dsq_peek - Lockless peek at the first element.
> > + * @dsq_id: DSQ to examine.
> > + *
> > + * Read the first element in the DSQ. This is semantically equivalent =
to using
> > + * the DSQ iterator, but is lockfree.
> > + *
> > + * Returns the pointer, or NULL indicates an empty queue OR internal e=
rror.
> > + */
> > +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> > +{
>
> Obviously there's no guarantee that scx_bpf_dsq_peek() will return the ta=
sk you're gonna
> get when moving a task to another DSQ or a local one. It's pretty obvious=
 from the kernel
> perspective, but I wonder if it's worth documenting here too.

Hello Christian, thanks for looking at the patches.

Absolutely, whenever using a lockless operation you have to watch out
for TOCTOU bugs. In the schedulers we've experimented with, doing a
sweep of peeks just gives you a higher chance of getting what you're
looking for when you subsequently lock the remote DSQ for
popping/stealing a task. I can add a reminder in the comment on the
function.

> > +/*
> > + * v6.19: Introduce lockless peek API for user DSQs.
> > + *
> > + * Preserve the following macro until v6.21.
> > + */
> > +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id=
)
> > +{
> > +     struct task_struct *p =3D NULL;
> > +     struct bpf_iter_scx_dsq it;
> > +
> > +     if (bpf_ksym_exists(scx_bpf_dsq_peek))
> > +             return scx_bpf_dsq_peek(dsq_id);
> > +     if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> > +             p =3D bpf_iter_scx_dsq_next(&it);
> > +     bpf_iter_scx_dsq_destroy(&it);
> > +     return p;
> > +}
> > +
> I think there's an argument to be made for this to just return NULL on
> !bpf_ksym_exists(scx_bpf_dsq_peek), the caller needs to handle that anywa=
y
> and at least it's guaranteed to be lockfree then?
> I don't have a strong leaning either way, probably is fine if documented.

We went back and forth on this patch a lot, and did explore versions
where peek is "best effort" and its semantics allow it to return NULL
for any reason. But that provides much less information to the caller,
because now NULL is supposed to indicate that the queue was empty at a
point in time. For that reason we ended up with this version where
peek provides both positive info (something is/was there) and negative
(nothing is/was there).

Best,
 -Ryan

