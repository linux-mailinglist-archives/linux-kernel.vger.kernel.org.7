Return-Path: <linux-kernel+bounces-855251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F0BE0A28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECEF64EE17E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AA2FABF2;
	Wed, 15 Oct 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igerKaBd"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9B223DEA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560133; cv=none; b=Uz4TlBKo/RVxBH6jhw6N3/bRcHnbmUM+tlhWhP/JQV/1b4g41+9OAyZd4eFQ/eBMhh/I9srAIpG7kOIDfyne4F5340T9e4YF2DSflig1sqB9Hk8TQqym9EimbBKtBRy+I/ekBoyCl7sSftH1q3dBam87tdk7pAMCwbFCEyJnwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560133; c=relaxed/simple;
	bh=GfW7nLyntXDYIXKIQ+YtakbDrhIW2xPxJZieBsO6EQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRQWfRmm1VcmPbWx/f7WqvfDuMtU6gkRkTRQFGAWgIuI+Q48Ue8uHXFcTRmOLLrlxF6oPeMt8mwlkiEf2xu7R2+dC8FIHKM3mMA34LMWYRuZM8I80EuWowT+GE4Uk6g0wWPRwRK6Vixnai5HaYgCy2bVa6YtmyJEibp8ds7lleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igerKaBd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so412186d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760560131; x=1761164931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCtklihtbOhFVtWrXC87SZH/yrccGP2P2vSXXm4fCXM=;
        b=igerKaBdmzGtmODBpCySu/CGD3dt9wc/VUwWa1RoFFVzQf3bNRXh4jwQ03sNSICFq1
         B6TX/GQdKChZJIEpA2aM7jqE+Xjlx2SU3WDuZZR9HR15QNIPQGygRKsCJ/mi2i/B1x6Z
         npVMA2PyXrCH5B8AJsgICxN5FD+yZqyb0m7Ef7cVP8K75CWn5QnATCJSLUtV4rIvBvEq
         YWrbON0Bfb8U6LDxZhtoJ8DAUP2TnvTHzyV0/00HU9WqFirRJQ6ygyQzs53yWH2teQVD
         Rhmiw1NoGfwF0Bq2q8j64GSZu5XbfXDmEXwpfYlIplZtXgs/hoQTqkfsTHwXJaqJ3yAn
         5L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760560131; x=1761164931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCtklihtbOhFVtWrXC87SZH/yrccGP2P2vSXXm4fCXM=;
        b=pJvAIWSLYOpKe8MhKocC+ObpAlomaRdh+/4UYewLPDiAepa6xeSzTw3iPPNQasi70x
         qa4meokqPV6xmVHqjU+Dxri/B8+6VewpGDIPK8xpowGeM6nU5+kc39ukZ0QXq0LwKF4g
         q9wkCyMOI/9IJ/ZxKYmIo33kd6MpaDsCERIyfmgu2EhGOTvYQGBOEONat4CqI8R7Qjoj
         76OpUlqVilHhKgkIu8XDsvt8bAKal9B2D85IsKEsimd5d9dTLdat5q0OVBx95HNTCG1D
         f0j9hmKZ7bREoUONY3uLutZGOcCVoSJ5awce1noyI7EsTowb48axQFoEvscB4OUkFKGV
         b1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZdVqvZkuaa2TJjXVEHNOWDvwA1cwVdPhn2tna1IYfxMQ9ZDb9QoT5nb2F/vnbXHWjGmAsSeDIQcEFZ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+jD7a0aluJdV7UKeZNpT67AsH0ePvy0clWN2/SM2o8OBP8+c
	nLQe1jYKMWOKqDvr2/FycruTbghRo3AXJFfPPHyGW3+Q3yb3OHC1CoeYAE43CoZud70BpIfSa3l
	Soj7Zp4jzObgNpwJg82R9HY159M0n2XEzFCNv
X-Gm-Gg: ASbGncsSuHHy2DDRbOGiYC0lgW+2hi+m+Oi1KzVPhVjuYRpvAMMg/WEtwxoc1VJgBjh
	Bi9nCxnachCYz9cGMVAYUJTZSIuheglZPEryvxR11HNOi8esk5SSTOjiZCy9TiPMV9wDVoKBbmK
	B6EUzqRT/ivbLD6At0S7+9r9h49XkOSJQST/IL8FnjNyi9vpmczNaCsYLDJpxZ1dn4yEOtP+GYM
	L7An4Qb5rlXT6VBKguu6Ock5kvR2OhzZ7jHCWDWIfgbo7PUg41q8U49pgoArACLkkEXzMBV1tKP
	hSA3Zxx8O6EEh0LA
X-Google-Smtp-Source: AGHT+IFCn7H/zNcXBxMpbrNmnQeoIxLu56FopThW4xhIHn56Aba+VqVESsjEtwVMcEHmuG8hzRQAx2vIJIxHR6DsZYo=
X-Received: by 2002:a05:622a:995:b0:4b4:9489:8ca9 with SMTP id
 d75a77b69052e-4e6ead5afc4mr367197571cf.54.1760560130795; Wed, 15 Oct 2025
 13:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
 <aO6N-g-y6VbSItzZ@bfoster> <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
 <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
 <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com> <aO_6g9cG1IVvp--D@bfoster>
In-Reply-To: <aO_6g9cG1IVvp--D@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 13:28:39 -0700
X-Gm-Features: AS18NWBUad1fkce9hs92YgRf8HsxWvhoWh_6BAI1le74rtdPJ69SePpQwXy3Svs
Message-ID: <CAJnrk1Y+rdH11k_n947Z2rofu39=9=C5CRK5USi7Z1CnEG7fcg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:44=E2=80=AFPM Brian Foster <bfoster@redhat.com> =
wrote:
>
> On Wed, Oct 15, 2025 at 10:19:15AM -0700, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 7:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
> > > >
> > > > >  Attaching a test patch, minimally tested.
> > > > Since I only have a test environment for kernel 5.15, I ported this
> > > > patch to the FUSE module in 5.15. I ran the previous LTP test cases
> > > > more than ten times, and the data inconsistency issue did not reocc=
ur.
> > > > However, a deadlock occur. Below is the specific stack trace.
> > >
> > > This is does not reproduce for me on 6.17 even after running the test
> > > for hours.  Without seeing your backport it is difficult to say
> > > anything about the reason for the deadlock.
> > >
> > > Attaching an updated patch that takes care of i_wb initialization on
> > > CONFIG_CGROUP_WRITEBACK=3Dy.
> >
> > I think now we'll also need to always set
> > mapping_set_writeback_may_deadlock_on_reclaim(), eg
> >
> > @@ -3125,8 +3128,7 @@ void fuse_init_file_inode(struct inode *inode,
> > unsigned int flags)
> >
> >         inode->i_fop =3D &fuse_file_operations;
> >         inode->i_data.a_ops =3D &fuse_file_aops;
> > -       if (fc->writeback_cache)
> > -               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i=
_data);
> > +       mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> >
> >
> > Does this completely get rid of the race? There's a fair chance I'm
> > wrong here but doesn't the race still happen if the read invalidation
> > happens before the write grabs the folio lock? This is the scenario
> > I'm thinking of:
> >
> > Thread A (read):
> > read, w/ auto inval and a outdated mtime triggers invalidate_inode_page=
s2()
> > generic_file_read_iter() is called, which calls filemap_read() ->
> > filemap_get_pages() -> triggers read_folio/readahead
> > read_folio/readahead fetches data (stale) from the server, unlocks foli=
os
> >
> > Thread B (writethrough write):
> > fuse_perform_write() -> fuse_fill_write_pages():
> > grabs the folio lock and copies new write data to page cache, sets
> > writeback flag and unlocks folio, sends request to server
> >
> > Thread A (read):
> > the read data that was fetched from the server gets copied to the page
> > cache in filemap_read()
> > overwrites the write data in the page cache with the stale data
> >
> > Am i misanalyzing something in this sequence?
> >
>
> Maybe I misread the description, but I think folios are locked across
> read I/O, so I don't follow how we could race with readahead in this
> way. Hm?

Ah I see where my analysis went wrong - the "copy_folio_to_iter()"
call in filemap_read() copies the data into the client's user buffer,
not the data into the page cache. The data gets copied to the page
cache in the fuse code in fuse_copy_out_args() (through
fuse_dev_do_write()), which has to be under the folio lock. Yeah
you're right, there's no race condition here then. Thanks for clearing
this up.

>
> Brian
>
> > Thanks,
> > Joanne
> > >
> > > Thanks,
> > > Miklos
> >
>

