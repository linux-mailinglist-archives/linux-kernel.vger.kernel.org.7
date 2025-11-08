Return-Path: <linux-kernel+bounces-891319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AFC426D4
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6121E4E61F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D072D7387;
	Sat,  8 Nov 2025 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0N6dF7v"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE44283FC8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762576142; cv=none; b=UeCMIZr7iSerSBBCP3LLoD+yEh/6O7JKLk659OsNcqJ4Asu7ko6zmpZPoezoIkA5EZM2XwBIQVe+dAvWf4vWPIAAK2v+wQxuYmsVZ2wEYk7yIAQswyjt+yJPbhcj1K1KvA6mK2up9x9D92rp/eiL6K/QCUeFDbA1Hxh6mLreMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762576142; c=relaxed/simple;
	bh=4t66ZklcM0GbPz3oTmZf4siPUHS7sG5MIqEId4RBHqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc6kJOcG4IYyyiH7c/rQIX9Gc3gl+ydFWKKiMmzljIku/u7pCR/WR54J4QcDCmlQae7xtHbKvI9B0OXzuapSgzycHr4N15rTC0zCpCFRQxTqwQg8pWP1ioyN9HxYg6UVRTa/LVNMzZPKrbGw+pABOrzviEwgPyp9MT0cm/f/NFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0N6dF7v; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b728a43e410so309068866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762576137; x=1763180937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO4XlPxpyr6A6CDUplPXQkHQJ9QmhDHMaWGNSWYd/48=;
        b=N0N6dF7vdL++8H3DDfC6CLGQmAxEpUHVqn1aayFfpctZWBAIfmws3akYi/IHdfRwhB
         T5oPSYWSlNCuAM8w0ZJlB5SosRGGSLn/8uMJyA276eaIS7jiHlcuHtHnnM/tFIyAhX8L
         ixZlw5uJlUSng3L2y1UQg4S+4hX5+46UlAMpqNbt12fwe6+Ah2JrstK0sp7H3E23hN/+
         IdLuSBzcjjB8+HZ7psmzohGa8eNOd/wijgSY1gfrBRh4vnjTcRRUC2hgK6uK6luiSm2o
         fLJtGBvQ8CUD8VsInZULj8/UEuUVjQUX+miKQTfkj2Nf9/NOUVnngjvpcLr3wWhqVrvG
         mlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762576137; x=1763180937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KO4XlPxpyr6A6CDUplPXQkHQJ9QmhDHMaWGNSWYd/48=;
        b=SQNdpnYBxrsy2N5XGB39XggQugJUOTVhxRla+iXZAVawoVYNffY3deLKQfmOAGikjw
         ek+T/r8Sk/hjxFRnZDXA2dm+r0YZ3by4ZNA7dsmK91NcH435YQ0SU9oZCapH1YHcea04
         FSRucZuXThg4cRXQNUN5Gy6Quef69IvPMjbOe0M8XZ9O1OZ/vITWW4Kq3hnkGW34FF5G
         zeGfSikVcuxB8Tf1LmC/vBUDJwnj1adgZPgqHU+QI51wOttF50wh0/s+PGTlA6i1ILZ/
         zn65hk4YUHLKt4ljsnMGNgkZas7RP+GCbXFPAiX7NOjezTkO0aXoTFwzkd3LLBS2usVq
         GyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX40bykShcGrIpAbadEOXUlypxPYshYw2Y/93gPc6/mOt2p2blB059Bbx1rPmZF6TimV4FASK6/CzSoaGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytnJD7b5pSpyONsEr4afvMTcJHlg2xnsD/DyPekmPlKrEl5eEM
	syIYxcnl+qSkqgtiJMnxxTk/ho2+Hnh4Rol8Xz3SLA8gIoZHPgs93KnpnpdlQNRLa0HRvipwBKk
	k0d5UG8KSM8PUEYxpVmWsNFk5NfdRkAkd4HMy
X-Gm-Gg: ASbGncswq+dzsypXIuFN2bbxRDn8P4gW+7Rf7/lZjX/SLCRNiousScB5oHaIDvGtBFs
	lXLur8AwS9HmpSbo+MRwJXGlVaMcYAyelkA+xlObVyPQrj9L8I8U36ZUBJEhTAXkkYYvxORDwO1
	CJ2tAZepgthNF4jmIdpEdnbIWnAi9FEu/aeUebv6CmG4XCAsM4w1IHeMMzNJF6xWZViaubMTM5L
	B1RhE2VBkyRSULA1p8r4XVoYIWpg/2kXuy5NbXJnK29SMv/F6iYg+wu7bSDRm82klxcSg==
X-Google-Smtp-Source: AGHT+IGrMxHCCDZvCnZIYxC8OlI5J6aNsXhuWL7dXVFTt9tofuSFasRc4eGE7nHVxUSZrLRJk0lUZkNzkkPL/JdP2IM=
X-Received: by 2002:a17:907:9706:b0:b40:5752:16b7 with SMTP id
 a640c23a62f3a-b72e05e83c3mr158113866b.51.1762576137173; Fri, 07 Nov 2025
 20:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690da014.a70a0220.22f260.0026.GAE@google.com> <tencent_5D8667DBC6ECD2FF464349ADEEFD2EE84C06@qq.com>
 <f25e47415998a9d9360ac87eca7292a2@manguebit.org> <CAH2r5mvRrFmZFtNaQuRFHy2mVM1AG1AnsNwZMOoT=w8LZaLX4Q@mail.gmail.com>
In-Reply-To: <CAH2r5mvRrFmZFtNaQuRFHy2mVM1AG1AnsNwZMOoT=w8LZaLX4Q@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 8 Nov 2025 09:58:46 +0530
X-Gm-Features: AWmQ_blo19sY8oI4byZVSAxpSm_eal3zwPqIUf3DK2UfzTSBtaRF2CJoGUN1P1A
Message-ID: <CANT5p=pC2JShLzXPJG5imWTJBRfXheZeqBhMSpXuOw3rBkRxEw@mail.gmail.com>
Subject: Re: [PATCH] cifs: client: fix memory leak in smb3_fs_context_parse_param
To: Steve French <smfrench@gmail.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com, 
	linux-cifs@vger.kernel.org, sprasad@microsoft.com, 
	syzkaller-bugs@googlegroups.com, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, sfrench@samba.org, bharathsm@microsoft.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:52=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> merged into cifs-2.6.git for-next pending additional testing.
>
> Also added Cc:stable tag
>
> On Fri, Nov 7, 2025 at 8:52=E2=80=AFAM Paulo Alcantara via samba-technica=
l
> <samba-technical@lists.samba.org> wrote:
> >
> > Edward Adam Davis <eadavis@qq.com> writes:
> >
> > > The user calls fsconfig twice, but when the program exits, free() onl=
y
> > > frees ctx->source for the second fsconfig, not the first.
> > > Regarding fc->source, there is no code in the fs context related to i=
ts
> > > memory reclamation.
> > >
> > > To fix this memory leak, release the source memory corresponding to c=
tx
> > > or fc before each parsing.
> > >
> > > syzbot reported:
> > > BUG: memory leak
> > > unreferenced object 0xffff888128afa360 (size 96):
> > >   backtrace (crc 79c9c7ba):
> > >     kstrdup+0x3c/0x80 mm/util.c:84
> > >     smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_contex=
t.c:1444
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff888112c7d900 (size 96):
> > >   backtrace (crc 79c9c7ba):
> > >     smb3_fs_context_fullpath+0x70/0x1b0 fs/smb/client/fs_context.c:62=
9
> > >     smb3_fs_context_parse_param+0x2266/0x36c0 fs/smb/client/fs_contex=
t.c:1438
> > >
> > > Reported-by: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D72afd4c236e6bc3f4ba=
c
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/smb/client/fs_context.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> >
>
>
> --
> Thanks,
>
> Steve
>

Looks good to me.
Steve, this is one of the mount options that is missing in the man page.
Also, I don't understand this option. Why is it needed? Don't we
specify the source in the mount command as devname anyway?

--=20
Regards,
Shyam

