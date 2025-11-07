Return-Path: <linux-kernel+bounces-891141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1735CC41F02
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 964E64E6FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CB30FC00;
	Fri,  7 Nov 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgA8OJ0q"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AB30EF86
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557754; cv=none; b=tj9Vsnd+ZIAlBWFS1f95ALOAR9D2soCVKSxz3SNuK8uEaO1i6BLV3BckgRDCVGZ6mMgh2ybWMzq35OWSPIrr+M5rtjatna3h6fTLEIr0cq0E1uYNCtWtDU9odnGTcTLbN9vcChDZuVAB1HCnDsUczixeBBg0rOjcxRXUsfQRpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557754; c=relaxed/simple;
	bh=R/2UMPGuDFzkdvrqVcgS/jXdgWO6LAxSQLCkDO2NIDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6B+dPnoemJ3ceLqf73h1l+sPFwR88XEIGy8En+zqIbmqp29G2fwBB9ZR/ZTgkG0thbUIEihuqStgISlrcijUZ7gJD5bEZCAnqZFEoFCNHdA8Y41J1nbnnq3XNVGOvHIcFF13qbKkFFtrgoEbHT1LrZ0IvRcQ6lc9TUreOIt1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgA8OJ0q; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8804f840579so19149966d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762557751; x=1763162551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+AFCmcGkAqt1At2HC2TTbyCq2E8P2gcZqbl9tGD188=;
        b=CgA8OJ0qHb27vmwVH+DWRX/WC9blZqbA1lFGeZqKN5+JapfMps/oCToLiZxZqIMosz
         uq/zuEV9luWf73wDGO2ObooTjixdtBVfkeJq145gruV7kslPtRjM533hVN3jM940B43Q
         sZYR1KgnURo5sZUvD0rKjWLAXt7CaCGtgamvCE6byviMQEYAA5WpvwiDQYqqwt3VJCDy
         eABIddk53GUUgai4J6xqhNBc3vkr+heh8bHlOlTwUNwXIrxBV5xS0uUt6ROcMjZFt3Cn
         zC4Sq1mmnP7zKcWgauHv1PXhLlD0jeDGHqkF8IZfbo48pm1Vmu75dXp4HFx+keaxSRbM
         OdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762557751; x=1763162551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+AFCmcGkAqt1At2HC2TTbyCq2E8P2gcZqbl9tGD188=;
        b=mLsfOMEpvSuva0u6kWikjgNQWbGveLgLz3ZJ6ha/REoE3jKoRswTS34+l0TSrCZibd
         pDdtGgL/PzlmSOjIJ3ZqE5FHepMSeRsPOx6IdiKGGMNdqBESwThAimRvHrc+lUO3IPDF
         jXIcw++Tv/ciqtrjekkQdqOPUC1d1pz/B+St92ph/BmKKoK9Ly9DnT3kE9kBR8XCoS3G
         OCXpgeVUOj7wxXiYTtNAYvOgPAh257W+9eT9fF4C9BpLdy0RwRZt4QQXIXLyqReGupuU
         wNlsz+rfxQrOVJi/kIcaaqOWyD+MXjIkgd1OsZMPJrJMqYYxxE9/8I/2/BEcnIOa2j9w
         +LLw==
X-Forwarded-Encrypted: i=1; AJvYcCUsGcNrKITII9J6jPKsCbi//4Fo45oqCst2TmpHVuGo/nhlL0vjKgQZ114Zn0nSugugO6sGK3xl3+0d/oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydcwl0NYiafTFeQxTytlYDHIzuaTUvtk35HZArBENeOUxEzW+g
	Y/u9kYTqddyUp1YO92tw3EVK0doAw4VXJT63L8cdEvkPUh1nCgyzSFFqDEjTRYLPdQxgkG2xUz0
	Jn5Vhh1MOdeBmfiPWSzzDjkBHzZZew6g=
X-Gm-Gg: ASbGncv9BwjigHgLothTsc9L3T/eH4iwJsdCEIpoQv36H381HIDKZS0kvMbHPOOKI1h
	KduzPW2cB+DrNjFJMse219+0YrZztDhBHV2SsDOKIyEcxNhlCpvjF14shNiptnrLIDt0+KDoTif
	KLOAxKjWsM7ViZF8ETzz2LRvCLY80LaiiSMNu5se3iwhIJycIkOst8ZSDW8WGl0xJHmRp+q15hS
	GJ75C6kfs0wELTSX2m9BDarAb4xSbCqFEJl3oEe0lZG4L/A+gzuGlGNnLLDay2Wj6aL0OZWF0IM
	EpKzae9Mw8A3PYoLj//0ElycZPD8alXGIffSemwvHKRFP6rMJT5tfSumM2OaRdCB9SD4Jox8WbV
	AHyVqm14TOJongubanQgV2uqxFHzWP9Xp/udCCvUzI29GQlDqUJTXXdnr9TN7z/KeEWwjE1TdIJ
	LWUIRcaw==
X-Google-Smtp-Source: AGHT+IFJ2JgPKhmnyzgneRGCagyAH4hzlYSmYiz/O+vgt1pHhAQ2ZKQ355Y4DvJc4HnzxtJb+9vAUFNwr0i9OGzJEOM=
X-Received: by 2002:ad4:576e:0:b0:880:4614:bb0d with SMTP id
 6a1803df08f44-8823864299cmr11365096d6.27.1762557750876; Fri, 07 Nov 2025
 15:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690da014.a70a0220.22f260.0026.GAE@google.com> <tencent_5D8667DBC6ECD2FF464349ADEEFD2EE84C06@qq.com>
 <f25e47415998a9d9360ac87eca7292a2@manguebit.org>
In-Reply-To: <f25e47415998a9d9360ac87eca7292a2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Fri, 7 Nov 2025 17:22:18 -0600
X-Gm-Features: AWmQ_bkEpYmY2gRj8B26Nn5J__r1j5sVrw-fQtqJ15_06sBhrYAkZmr7jut9NuQ
Message-ID: <CAH2r5mvRrFmZFtNaQuRFHy2mVM1AG1AnsNwZMOoT=w8LZaLX4Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: client: fix memory leak in smb3_fs_context_parse_param
To: Paulo Alcantara <pc@manguebit.org>
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com, 
	linux-cifs@vger.kernel.org, sprasad@microsoft.com, 
	syzkaller-bugs@googlegroups.com, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, sfrench@samba.org, bharathsm@microsoft.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next pending additional testing.

Also added Cc:stable tag

On Fri, Nov 7, 2025 at 8:52=E2=80=AFAM Paulo Alcantara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Edward Adam Davis <eadavis@qq.com> writes:
>
> > The user calls fsconfig twice, but when the program exits, free() only
> > frees ctx->source for the second fsconfig, not the first.
> > Regarding fc->source, there is no code in the fs context related to its
> > memory reclamation.
> >
> > To fix this memory leak, release the source memory corresponding to ctx
> > or fc before each parsing.
> >
> > syzbot reported:
> > BUG: memory leak
> > unreferenced object 0xffff888128afa360 (size 96):
> >   backtrace (crc 79c9c7ba):
> >     kstrdup+0x3c/0x80 mm/util.c:84
> >     smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_context.=
c:1444
> >
> > BUG: memory leak
> > unreferenced object 0xffff888112c7d900 (size 96):
> >   backtrace (crc 79c9c7ba):
> >     smb3_fs_context_fullpath+0x70/0x1b0 fs/smb/client/fs_context.c:629
> >     smb3_fs_context_parse_param+0x2266/0x36c0 fs/smb/client/fs_context.=
c:1438
> >
> > Reported-by: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D72afd4c236e6bc3f4bac
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/smb/client/fs_context.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve

