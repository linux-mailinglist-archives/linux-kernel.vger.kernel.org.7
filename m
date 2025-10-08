Return-Path: <linux-kernel+bounces-845595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386EABC57A8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620213C7E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86A2EC555;
	Wed,  8 Oct 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqCOyJXR"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA162EBBA8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934974; cv=none; b=BneeMll5jXYyimY6AQa03fDfOZfcJBWQEAidS0cL4tucuUfUqg2AxSyPXFl3RDkyLnXnIU0dynDbqXERoVgLm55dtd+hbBCLiyPhXBtTbeALLxuY7CyboPDPLdan8pI596wQBYlV3nU/yj73AeGlpU6DUXCX18Vz2WgpP5P1zkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934974; c=relaxed/simple;
	bh=2oz4055tSs+ZLXmvAtmckJ9z5uGepgRmiB+RNzcDoZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmaIyvM4IVrfcH5CYARN+IjdKrOp4lon5s1soIceWq5e0YYbZTORj/x6NdtKLws9ja1cFXYY5vM0IdLIEylfCx1mUcaAhMLFj9QQgxDe/t+Pf8kY6lsj9eNB8wdehnyAavFgxw4VMCc/UxljPxaYVwJqHoIk8qjzOBy2zIQor3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqCOyJXR; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63bcdf5f241so1520347d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759934972; x=1760539772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcyaXLUPShgmIDCl33cHm/vwKuNgk2xrFWZ6LINoljM=;
        b=fqCOyJXR+xxnYM34HBhJfbxalqBTWYYIDFA+INmQykJpkFZ2+KiTrqJ/37pyAP1FTx
         QlJx8tvA647GFwCJ67FOKkbmfKemsC7wvb6Mmeyc7WAg7lwbLD4APo0QhX+thwdZfO15
         vjpKl+7JkxbvcXHcuKjd3OSbPi2Oexpgf2EyGluNjgcYIe9TF3PbszAWxOUjXjF61PUb
         7YWOA+Dt8NK3nhuUHwe6P5K3tduixazIORhkGl7qptxKpKMxXOxPhY945iLxMuzptFeT
         +d/K6kG8Ejda4+Z1AoA7rJhTpUmbsgbhaHv5ss7JpcVxm4Qc6gyOuVff8xPtMDsKLEn4
         /TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934972; x=1760539772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcyaXLUPShgmIDCl33cHm/vwKuNgk2xrFWZ6LINoljM=;
        b=NBTZBOcOMOXWikxLL2A3mXwPO0HBWN7G9NsT2rp3mVsNr6zQolmf4BIIzIxtWta8Oy
         wLZxpOGxCWoomdz5i74ta8qCEJ5zgQRflDFXhqB48GdOLHdKSEI5NbSeWox5UZiDNrC1
         pqkxj7BBXkXZXxclPRHocyWP8cTkQbTITdcV1eKPAqJ2SdFTaA2C9G95hMh5p9G5ZylO
         fsTQTPf2aW6PS3p1kLXvSosAE+AagrccBQPBHYEx4iGl46k9APtXhxQB30cU67JtJMCq
         WCcw/H6Dw/aVfJLE3RZsaOLDirjq2GFcm5IA5uOVnZKrm8eUSsNQUoiY22D4ItLYK61G
         dR2g==
X-Forwarded-Encrypted: i=1; AJvYcCWtegWGGFjpVgDFyW4gbOguZ59HwoJikQisVBHZBg1CPvIv7nS5CJ8IRqtQ3HRGkd6mv5g/RPg4tXXCw3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQ2w5V9iWcWdp9S+bLjzPshKRDQxxZknCwXFBFSJEOe91vTao
	8SlDmePF6D9hxuGFUDHezmHeFlQ8IIeQ9AA1e9QeGMaUpRlGOL+ohBuDAzbu5+bjUcKGgHeWK7G
	9fS8luwAYRQ99Psc8VY6PuGKy98jGs8w=
X-Gm-Gg: ASbGncvQ79KDCSaRmFPRLcFkyxLLG0sBqNvNrALNNpt5Pi8E+pSrh9kDlR+QmOo4T8c
	/BLM/P7TzhFGiaaU1UyPgwDvxy+sOGHJ2U5Jf6H/qDGkFMXYRlMLSHpj0F1XQMBCkDChiruAT0P
	zfwHSp+ubU10JcpFYz+R24oijJqXUksUMEce6tnnXM0tTfJ5kDjKKyMhyD+uTI33senAUVukXA5
	vXWb3YdUYtgRUhQcPxErrhNrWmEISLsM8MSFJdb1Hd+7w==
X-Google-Smtp-Source: AGHT+IEEvRqkuJ82Z/1uDguuR+kVgtpAwObB6vWeI3q8N/eP1FxDL09AonZPB36dClmDoJcAb7GULptIPduQRTZOjdw=
X-Received: by 2002:a53:b847:0:b0:635:4ecf:f0ce with SMTP id
 956f58d0204a3-63cbe14cc08mr6282876d50.26.1759934971823; Wed, 08 Oct 2025
 07:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121100539.605818-1-jimzhao.ai@gmail.com> <20251007161711.468149-1-JPEWhacker@gmail.com>
 <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
In-Reply-To: <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 8 Oct 2025 08:49:20 -0600
X-Gm-Features: AS18NWCpKHFseMz7HnNNaZWGPOtA5ZcFiGPgcQxn7wnVm-h7S75ViS7O41MSTZM
Message-ID: <CAJdd5GY1mmi83V8DyiUJSZoLRVhUz_hY=qR-SjZ8Ss9bxQ002w@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
To: Jan Kara <jack@suse.cz>
Cc: jimzhao.ai@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 5:14=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 07-10-25 10:17:11, Joshua Watt wrote:
> > From: Joshua Watt <jpewhacker@gmail.com>
> >
> > This patch strangely breaks NFS 4 clients for me. The behavior is that =
a
> > client will start getting an I/O error which in turn is caused by the c=
lient
> > getting a NFS3ERR_BADSESSION when attempting to write data to the serve=
r. I
> > bisected the kernel from the latest master
> > (9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). =
Also,
> > when I revert this commit on master the bug disappears.
> >
> > The server is running kernel 5.4.161, and the client that exhibits the
> > behavior is running in qemux86, and has mounted the server with the opt=
ions
> > rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,sof=
t,proto=3Dtcp,port=3D52049,timeo=3D600,retrans=3D2,sec=3Dnull,clientaddr=3D=
172.16.6.90,local_lock=3Dnone,addr=3D172.16.6.0
> >
> > The program that I wrote to reproduce this is pretty simple; it does a =
file
> > lock over NFS, then writes data to the file once per second. After abou=
t 32
> > seconds, it receives the I/O error, and this reproduced every time. I c=
an
> > provide the sample program if necessary.
>
> This is indeed rather curious.
>
> > I also captured the NFS traffic both in the passing case and the failur=
e case,
> > and can provide them if useful.
> >
> > I did look at the two dumps and I'm not exactly sure what the differenc=
e is,
> > other than with this patch the client tries to write every 30 seconds (=
and
> > fails), where as without it attempts to write back every 5 seconds. I h=
ave no
> > idea why this patch would cause this problem.
>
> So the change in writeback behavior is not surprising. The commit does
> modify the logic computing dirty limits in some corner cases and your
> description matches the fact that previously the computed limits were low=
er
> so we've started writeback after 5s (dirty_writeback_interval) while with
> the patch we didn't cross the threshold and thus started writeback only
> once the dirty data was old enough, which is 30s (dirty_expire_interval).
>
> But that's all, you should be able to observe exactly the same writeback
> behavior if you write less even without this patch. So I suspect that the
> different writeback behavior is just triggering some bug in the NFS (eith=
er
> on the client or the server side). The NFS3ERR_BADSESSION error you're
> getting back sounds like something times out somewhere, falls out of cach=
e
> and reports this error (which doesn't happen if we writeback after 5s
> instead of 30s). NFS guys maybe have better idea what's going on here.
>
> You could possibly workaround this problem (and verify my theory) by tuni=
ng
> /proc/sys/vm/dirty_expire_centisecs to a lower value (say 500). This will
> make inode writeback start earlier and thus should effectively mask the
> problem again.

Changing /proc/sys/vm/dirty_expire_centisecs did indeed prevent the
issue from occurring. As an experiment, I tried to see what the lowest
value I could use that worked, and it was also 500. Even setting it to
600 would cause it to error out eventually. This would indicate to me
a server problem (which is unfortunate because that's much harder for
me to debug), but perhaps the NFS folks could weigh in.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

