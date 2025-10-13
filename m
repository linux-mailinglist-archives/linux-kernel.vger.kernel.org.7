Return-Path: <linux-kernel+bounces-851306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF84BD6136
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE1C04EC67B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F48302750;
	Mon, 13 Oct 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2zeda8o"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19222D46C6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387236; cv=none; b=PjOL8oPZUxK1jkoSkjZEIQ9797IDN6maYrt67gN/MO5h4R3HLWoFb0H4DZ2JAcb587SMxZV/92UUCpt7ithoGdOxawlGUrYz+dYUx1kIincz8bdu102GtkmsbOUao9dtxem/fEeh1ia5P9wTiK32c28ECEfqoAB/IpzjnCUn2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387236; c=relaxed/simple;
	bh=KU622TuPaRD2MQxn++PZ8PXYKTsWOl/F9uMV6E1/6x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaNyFq74UC60hie/WvxVw30PR+7CBeIhzierI7mqOCNUR3TyurEg2y4KgKK8pw5tEE83tS36TH/DaxVVcvsbTlkiqhOadFIN5gn4AWaMlgiBrnsldSzq1swWWy0hvv9JX2SUrjh0yTH8jfWv2fDaOYUjHwSyUxXtFFD9rhuJFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2zeda8o; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-816ac9f9507so718988485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760387233; x=1760992033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlD9DtXQmkM+JhYn0iDf8SrXaOR+regmjV9sqHbrOfo=;
        b=X2zeda8omZyfo1NgDGWyx1dhJ9fPGnppdYNNQ5QX8B0NkHAxLLvdJaCYa5y0MPdH0r
         F+pT3aRqi5yJUGmWtWnXOIKKh1CFX4pm5foGmT99iFMTR0P/Q7d7aDY0H2saYIQI1gDG
         tpdTMOeMRhZAaycmwtpDA4rEV8XOGZ/qlX9p0kP4s4Cslz4KDS8YpF+kfYrkaw8NnfVa
         TaPZ2pjG5onRfuZNUAXgstBFj0wCljQVlg5p8380F7EkG+IDyHKqwrjnQM1VFCSsFs9c
         6Xhzvi+UcsWqCE7+Z8ygmGTexyZUsIh+fTHLmcCUlpF51mraspZmwYR6G9omz1OPhQaU
         LVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387233; x=1760992033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlD9DtXQmkM+JhYn0iDf8SrXaOR+regmjV9sqHbrOfo=;
        b=K3ygAlMHD1UBuLc7mXa+NZ2JIo3IBeiJAlyyHVoU2vzLjgxRpJSqzPqEY7JjVvU26J
         BnxY7NHuU883/uLMiqXp8eJeQT1+xtanhHNdR7GNC9lp+YB/LNe4CYswxQGecjIrXdWF
         LrqsG4ooNbjVUYK5aseW8TiPSVYIrK4vp66wtw718ij6QWbTPHp/zoBNXa0Y7VKkf0W3
         dkEg8pWP8aAt7WDuA/UnDKkV55ZOEYPDYNdiy3akmBlozjOoczpvObusxRTNLKfzivv0
         VCSay3k23d7G6SzHyG1f9YGA7kf8jSsWqDDXi/aqC8s3ZNyKt+dBFaRN2sbxjwcSJJqa
         zrmg==
X-Forwarded-Encrypted: i=1; AJvYcCUgIg6f9+BEegiC2ak++JFkEWtAUckxM3NulfF6W+B2qHqu3fuWBR5eHra0pEBbVlGU+9/NMPLAhVXjUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNVcDNSnPv/QLBBFToPHT1u3IucyDDbeaa3SjHJNShSWHSVok
	Qy94MY+maOeY0oiguEPNB61VIQlWUfzda7QVjsGqT+XGTwqWBMfqlxFcrbRLTk7EWXcaCNtphIF
	0yM3KGB8Luu+mo2fyqVyW39LNTHIKqTA=
X-Gm-Gg: ASbGncuEn18NhCemrw9Ht6TGYjl5KY3Nx3tadavFZ3byQ1Iju0oq0EPrmf6g8gPwr1b
	Gv79Jloz8Az888s5jKdIaAOlvW39b8XJ6Mgje54SNwyfOazDMhCuTmk11QOdbXG2VJqLYpW8xvj
	KbLPGb7tmqZtaGzX087/nQtjvreaDt6HJOZ/LT7hRvSHXGLzWH6xzZv894i4prn37LWImYWtRO8
	LkZpPtR5qsTKUgZmIeyLxGTmX6IUmfLlHTmeAz5Jon5FV6cGIg73pqlPD+iakNfwZui
X-Google-Smtp-Source: AGHT+IHZNzDVN6agCpPrO/1izdrx2SionIJFnZk7hW0l+PesIrTne546MtffhxsmTfyBcUvnloV59yHjTXtPoQj0VMs=
X-Received: by 2002:a05:622a:996:b0:4e6:ecae:b83f with SMTP id
 d75a77b69052e-4e6ecaec1c4mr333015881cf.39.1760387232594; Mon, 13 Oct 2025
 13:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
In-Reply-To: <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Oct 2025 13:27:01 -0700
X-Gm-Features: AS18NWBpmt7G8mJLvyRGq_BVSs_ov0ThJXHiqkT3BmFkjrMzauVDQCOzZ0CpmUg
Message-ID: <CAJnrk1ZCXcM4iDq5bN6YVK75Q4udJNytVe2OpF3DmZ_FpuR7nA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:16=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 10/13/25 15:39, Miklos Szeredi wrote:
> > On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> >> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
> >> that it hasn't been invalidated.  If old_mtime is invalid or if
> >> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> >> cache is not invalidated.
> >
> > [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> > Link to complete thread:
> > https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.=
com/#r]
> >
> > In summary: auto_inval_data invalidates data cache even if the
> > modification was done in a cache consistent manner (i.e. write
> > through). This is not generally a consistency problem, because the
> > backing file and the cache should be in sync.  The exception is when
> > the writeback to the backing file hasn't yet finished and a getattr()
> > call triggers invalidation (mtime change could be from a previous
> > write), and the not yet written data is invalidated and replaced with
> > stale data.
> >
> > The proposed fix was to exclude concurrent reads and writes to the same=
 region.
> >
> > But the real issue here is that mtime changes triggered by this client
> > should not cause data to be invalidated.  It's not only racy, but it's
> > fundamentally wrong.  Unfortunately this is hard to do this correctly.
> > Best I can come up with is that any request that expects mtime to be
> > modified returns the mtime after the request has completed.
> >
> > This would be much easier to implement in the fuse server: perform the
> > "file changed remotely" check when serving a FUSE_GETATTR request and
> > return a flag indicating whether the data needs to be invalidated or
> > not.
>
> For an intelligent server maybe, but let's say one uses
> <libfuse>/example/passthrough*, in combination with some external writes
> to the underlying file system outside of fuse. How would passthrough*
> know about external changes?
>
> The part I don't understand yet is why invalidate_inode_pages2() causes
> an issue - it has folio_wait_writeback()?
>

This issue is for the writethrough path which doesn't use writeback.

Thanks,
Joanne
>
> Thanks,
> Bernd
>

