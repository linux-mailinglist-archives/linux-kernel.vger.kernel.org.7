Return-Path: <linux-kernel+bounces-860579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61060BF073B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA033A4AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241023507E;
	Mon, 20 Oct 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt+Epdie"
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DC2F6173
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955031; cv=none; b=fk+qdWWdEaHVim0HaxK0fRqFXth/UPR17NiVsBunx9rjPycCcdikQxgJiyTV3rF033fUXJLI18xQlv/4KjtdLH5wNqSamZZTnWQdSGFcelnTKJF+Nqk+MivLG/ZgchzFmhUhBhmtNVYVF5kpd1FuGK6ZsybgwNC625HR0gGEDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955031; c=relaxed/simple;
	bh=+b8WuG/HC3vyA5SwA+soD2Mxxc3drE8Jv/BH+lyAEzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPlPzk+WwMcUZKP/KaWpYD17rUCnDp06CQ1dUo51nmXAsaG8I5SHrob1x5hL0nsgMTV95j/xDVo11rbdw1D4fnnMnog3G+xs3fHhdpjG0QgSmCN+YDZAg6MWPxZr/3bYb6rvM1j43cPEWIqJMPbzJ93cm++whw81PeR2aVE39P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt+Epdie; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7849f67adf7so730537b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760955028; x=1761559828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X5tz6bHazMvHuAjnXT+5fgYz//dOf8mv7OtJycB+c0=;
        b=kt+EpdiebSSB6A4/jAZqkw3+DZWPzKoXbKc4/UOXoUuO8hVSorOXfvQ5AwsnLNUmhJ
         JgOFPh96FwaifkLtuMdCLgoil8Xpj+13Ohp3cEtup9Ndpnd9y2G4uNUR0TcXzifpLkr/
         T3vzLijs/8t4VHVNMicEkBQV3N0MUfZuFdNsWa9SiH026ef4d2wsjBmeyF2qGjx+SWZl
         8OJ0RknoCcc66NmOVliRmVQ//5k0D0WUQ3Lgvbcqn4qZxTP//YtbKiEsXy56xHVK5/Vj
         bM7+KIvPfCOnPDO993IvhPd6a4CcZCHT7phqEnoAkUub5iDIK4xkC0Dnc8VXBG6GVubr
         rnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955028; x=1761559828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X5tz6bHazMvHuAjnXT+5fgYz//dOf8mv7OtJycB+c0=;
        b=cH2CcvlkSCkogHGYwWyz8pWJ5xEEX71jn3/YcN0w6a3hSGVPCipZCZw4rKI8+jDS7y
         jew5LWkfwEAd1pekq61MA/fMROSlJrFW/1GwSain+C+Ua/lFNXnuHuctiJRjoMrNe7M4
         jzS7/Dng3N8hE4NmfI2UvFGZLeufzQ1tP1RgdzvPZvnQrhqC/kfD5UV5aN68Bk5x4sQY
         Qs/wGIb9ZOlHFkb+A2p1SBcHiTt/oWMnTKjqtsCYg/diTHUTuWW8peprZ2ooBdUxg72o
         AxchsIad879z5S9i0QTiFcO3wPXFMRVQfqFmaVC5QvP72iyuXIWeUHT6bBnap+C8nx66
         wQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWvmawLrAY99Mqh/blHP8MNF71xtnMfX/gneAsVwxzr/xymw5adC49oS3Y49KVtPXjwOwvTWXfylQK13UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtuaGqfUlovdWDNOxQ96bHxukzjW9CN24wZ4ve07HYovuIbDJ
	q3okMONFUWnDm9H2ggX0iZIS/a7mde0CIFAYB7Xpk8ujEUyYz2skf08FAdaRlLG2G2BbTEW4oKV
	t5eDntTSpEE7jVGLEhPOoFw28lHW6Ry0=
X-Gm-Gg: ASbGncvepO6/hAlGRa2iTh8PjOpUSi+loukY8kwuJVlTMxki33C5G9FjnijpwNAU9gb
	RmTzg/BVXeOIFlTEWSRoxJwdxApBWDZJ/t2s1HRxTAI9VNeOnEeZZrHFajmbnh5wjNJDSfDoQH9
	lsUZiagg8MPCS3i5IZuWEOFxAqfzlRU7tjxwyej5PPySoNlB2LfFVHC29I1EE4CH14Cj76z8mea
	jFORpm7rHW8+xN5cquJUBjVEgYQF9THZoj+gPJ9y2evinDeGvTFeUMt+8youCZBQts9yvGBfSad
	/Z2qAIlVxHAj4iIm
X-Google-Smtp-Source: AGHT+IHsg5zxzRtvzI5xQzJ13Ye5Pwtxx5IQdlFZPiQMjohCYlmUwIhFbOThhR1qGTxghbUbimtD3GTYPARPrPtXRkc=
X-Received: by 2002:a05:690e:134d:b0:63e:3994:4ae5 with SMTP id
 956f58d0204a3-63e39945602mr1287408d50.4.1760955028249; Mon, 20 Oct 2025
 03:10:28 -0700 (PDT)
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
 <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com>
 <aO_6g9cG1IVvp--D@bfoster> <CAJnrk1Y+rdH11k_n947Z2rofu39=9=C5CRK5USi7Z1CnEG7fcg@mail.gmail.com>
In-Reply-To: <CAJnrk1Y+rdH11k_n947Z2rofu39=9=C5CRK5USi7Z1CnEG7fcg@mail.gmail.com>
From: lu gu <giveme.gulu@gmail.com>
Date: Mon, 20 Oct 2025 18:10:16 +0800
X-Gm-Features: AS18NWDlW0DYdp3OTfg9Y2f4VMNvSX7chNPPxPEerbgDkr7mZxeYtiABJdqM0Tc
Message-ID: <CAFS-8+V6j-yunnt5yQSa=+P0mXVSg5jrfsBGWrEAbYGm21y8wg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried to backport the fix  to my 5.15 environment.
After further investigation and comparing the code across kernel
versions, I now believe I understand why the straightforward backport
failed.

My understanding is that in kernel 5.15, FUSE's writeback detection
(e.g., in fuse_wait_on_page_writeback) relies on its own tracking
mechanism=E2=80=94the fi->writepages red-black tree, which is checked via
fuse_find_writeback(). In contrast, the fix in the mainline kernel
appears to rely on the generic VFS/MM mechanism, where
folio_wait_writeback() directly checks the PG_writeback flag on the
folio itself.

By simply backporting the logic that sets the PG_writeback flag
without also adding a corresponding entry to the fi->writepages
red-black tree, I created an inconsistent state: the page was marked
as under writeback, but FUSE's own checking functions were completely
unaware of it. I believe this inconsistency is what caused the
deadlock.

Therefore, a proper fix for 5.15 will require a more sophisticated approach=
.

On Thu, Oct 16, 2025 at 4:28=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Oct 15, 2025 at 12:44=E2=80=AFPM Brian Foster <bfoster@redhat.com=
> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:19:15AM -0700, Joanne Koong wrote:
> > > On Wed, Oct 15, 2025 at 7:09=E2=80=AFAM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> > > >
> > > > On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
> > > > >
> > > > > >  Attaching a test patch, minimally tested.
> > > > > Since I only have a test environment for kernel 5.15, I ported th=
is
> > > > > patch to the FUSE module in 5.15. I ran the previous LTP test cas=
es
> > > > > more than ten times, and the data inconsistency issue did not reo=
ccur.
> > > > > However, a deadlock occur. Below is the specific stack trace.
> > > >
> > > > This is does not reproduce for me on 6.17 even after running the te=
st
> > > > for hours.  Without seeing your backport it is difficult to say
> > > > anything about the reason for the deadlock.
> > > >
> > > > Attaching an updated patch that takes care of i_wb initialization o=
n
> > > > CONFIG_CGROUP_WRITEBACK=3Dy.
> > >
> > > I think now we'll also need to always set
> > > mapping_set_writeback_may_deadlock_on_reclaim(), eg
> > >
> > > @@ -3125,8 +3128,7 @@ void fuse_init_file_inode(struct inode *inode,
> > > unsigned int flags)
> > >
> > >         inode->i_fop =3D &fuse_file_operations;
> > >         inode->i_data.a_ops =3D &fuse_file_aops;
> > > -       if (fc->writeback_cache)
> > > -               mapping_set_writeback_may_deadlock_on_reclaim(&inode-=
>i_data);
> > > +       mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data)=
;
> > >
> > >
> > > Does this completely get rid of the race? There's a fair chance I'm
> > > wrong here but doesn't the race still happen if the read invalidation
> > > happens before the write grabs the folio lock? This is the scenario
> > > I'm thinking of:
> > >
> > > Thread A (read):
> > > read, w/ auto inval and a outdated mtime triggers invalidate_inode_pa=
ges2()
> > > generic_file_read_iter() is called, which calls filemap_read() ->
> > > filemap_get_pages() -> triggers read_folio/readahead
> > > read_folio/readahead fetches data (stale) from the server, unlocks fo=
lios
> > >
> > > Thread B (writethrough write):
> > > fuse_perform_write() -> fuse_fill_write_pages():
> > > grabs the folio lock and copies new write data to page cache, sets
> > > writeback flag and unlocks folio, sends request to server
> > >
> > > Thread A (read):
> > > the read data that was fetched from the server gets copied to the pag=
e
> > > cache in filemap_read()
> > > overwrites the write data in the page cache with the stale data
> > >
> > > Am i misanalyzing something in this sequence?
> > >
> >
> > Maybe I misread the description, but I think folios are locked across
> > read I/O, so I don't follow how we could race with readahead in this
> > way. Hm?
>
> Ah I see where my analysis went wrong - the "copy_folio_to_iter()"
> call in filemap_read() copies the data into the client's user buffer,
> not the data into the page cache. The data gets copied to the page
> cache in the fuse code in fuse_copy_out_args() (through
> fuse_dev_do_write()), which has to be under the folio lock. Yeah
> you're right, there's no race condition here then. Thanks for clearing
> this up.
>
> >
> > Brian
> >
> > > Thanks,
> > > Joanne
> > > >
> > > > Thanks,
> > > > Miklos
> > >
> >

