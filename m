Return-Path: <linux-kernel+bounces-844649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB8BC26B5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A680D3BB8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155112E974A;
	Tue,  7 Oct 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRiiwToP"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2F1E25F9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862481; cv=none; b=IUU6itzHx3i9uqT3qzpVT05bv+MLklXjzjTa3BkIVxzYfYw1aMugGVymqhlNWeoed0A/khIVZvyplb3Oykbwot1Mo1wVJ5IQwgt4qSr28fj73KiszYChq5dziLHGZdPNBoETeaLDwG6qzAHWFf8jJJcoUnokmIbw5yzbB47p0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862481; c=relaxed/simple;
	bh=14usrE9rcmwH9BanS4vF2iQdAhBZbHzF121WciBEXL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1yPMI7aJz6i1YA3ooYXtMr0hVIC4OOFm2Rla2ID76Yy3xECJUZE/sN3OqiM5r4iabw3SwPGHsFjF0TXa8VRWoC8HYPp7DZ0qxLTxmJ13owQBFYm3hDusJR6DytBbedli8zAYFcQAEWbz27oZ6LDj1dvUFcqRBusufHFn1PJL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRiiwToP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78e9f48da30so59500116d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862479; x=1760467279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgixTp66/wF3ZLblegPyEnfFW2saZwup+K1H+9SeEGo=;
        b=BRiiwToPFqpIdT2tutgEU0uZ+uFv+4a2ucVNOOYSkbPmHzo1MtORGFtpi+w55bY8xN
         //7shi1f7fm90ikMuFxVZ3VHCSs7oOSiUlOnQRTEx234CNumUzPPDdKHnoIXU0lfvNIn
         8CthL34yetz5XfjcvN0zuUEYdpryJLXB4lJI0Xgt977QhZ8DoQ7NLoubs+EXlIRz/MQx
         x9WBUFFEs31EmkczI+XTmreqUQDdxPq6W25tIhK2e+k6wjN9ByDNzkZRXUFPaBmQ8fEn
         tvkeV3wP9MAeBQ/VYit7Hjhyt+jMs9JsYR8Rr5ku3MeKh/9MSoYvPvUHvCNkqliWIrzw
         Tsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862479; x=1760467279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgixTp66/wF3ZLblegPyEnfFW2saZwup+K1H+9SeEGo=;
        b=OSdsYcQTD10F34n1JSDbYTrsAuH+g2qkvl0qsXUkL8PzagGmQ2pShbiIN0Eoof/vTQ
         SbdSjgU/hkugEY6nBSgfCyKaJhFF/P44+DlC1fpCGsyoXcc9M/OJ4b3NV7B/X7aR4+Cy
         mwP3AODek52B4Ngj93iJt6tjGImE7NwmK+o3m4uNADzGiiVaU7Tw9gY9EcTEoxprAu8X
         CmVFnscD573vS8nIAfKLkOHnCotHlXmhxGpXhgJf03x1ZE68a6f45/iI5OKlCfQij4n5
         quHpgxkuUVZWQMu7iWs/aNTNZ9e3AfiISupNkgjFTPTbMPjmnndkGz0eJRCcdHZDKDLH
         PIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzopV9mUBMPp99A9AnFz1g9QKB+m67FNTwwOkdftxEeC9ukoZ6CEaq38stdyjZfJnGire0h50yC/JiC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYUvedNJ/d8VgWHpg970+2r2hkf36U46ZaO9FPbZNym5BwM4h
	UcUcQPEba4P7lVZMltmjvQUNi8oOa6gvbuMhc7VFC8T42uYVjT/Ab9Q9PlJehEhOzdkZS6RR1Os
	3+cNGKy10CnnrpzledaGITm6yB6tPdQw=
X-Gm-Gg: ASbGncuZvau9EDdkRhvfcTlIDdIapuhzrWPlKG5DKQWmDxWAwJiCvJyFZOTSaVeHfcB
	QJ8RmSkMy+vOLS9neYQ1GFWLxF7bxyqtJ+bzA60C7v+LRyUY46S5GnZjKwxpv2vXDCmQ0R/GY7v
	Grj0HDYqx+z3Gl/3h1qgylJZsJOtE2n/hRFm0bvgqQyWl0CpZhVK0sZ9AfR0Mzm3pMc2U/WvbfX
	8uAL+GIX4xrE5RWdDo31hNApsljcR1bXs+s5W8WxOIozKuXyyhYj4OFG5/9cldVX/ptmU/fYzFO
	tP3v+juI6ew5aVYncB93N+ERv1jl5W3rArh+PR8XwnuY2rLNH02IwRdlfE5SdfHxqddzpp/NFTe
	SczIou9DRY0L8UVd+ZGOpeIaKN6J6mrXYH4V1HFZ/wfUoZg==
X-Google-Smtp-Source: AGHT+IGAMaE//thkRYv+ZrpKF5RBJeySCJyfuh/WlBoUDmdbdLu2J8HHznMto8B8AiACvjHNGwfsCkFdmIperQb8fJ4=
X-Received: by 2002:a05:6214:2aa6:b0:824:30f8:ed70 with SMTP id
 6a1803df08f44-87b2107268fmr6367856d6.9.1759862478535; Tue, 07 Oct 2025
 11:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007082603.16174-1-wangfushuai@baidu.com>
In-Reply-To: <20251007082603.16174-1-wangfushuai@baidu.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 7 Oct 2025 13:41:06 -0500
X-Gm-Features: AS18NWDX3J4Uc_xYcuVgMqAXVA6vY8sa8xSNr6lLcFhs5hl5VboMY8BBFdwzWwM
Message-ID: <CAH2r5mvws19ho44YJDROdNUy3FtWfxyVE8QcbCTbFJ_VWYNQ9Q@mail.gmail.com>
Subject: Re: [PATCH v5] cifs: Fix copy_to_iter return value check
To: Fushuai Wang <wangfushuai@baidu.com>, David Howells <dhowells@redhat.com>
Cc: pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	tom@talpey.com, bharathsm@microsoft.com, Markus.Elfring@web.de, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David suggested fixing this line:

 +                       return -1;

to

 +                       return -EIO;

which makes sense to me since returning -1 could be confusing.

On Tue, Oct 7, 2025 at 3:27=E2=80=AFAM Fushuai Wang <wangfushuai@baidu.com>=
 wrote:
>
> The return value of copy_to_iter() function will never be negative,
> it is the number of bytes copied, or zero if nothing was copied.
> Update the check to treat 0 as an error, and return -1 in that case.
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> v5: no code changes, only improve commit format
> v4: no code changes, only add version description
> v3: use size_t type for (copied) and check for (copied =3D=3D 0) as error=
.
> v2: use (!length) check for error condition.
> v1: use (length <=3D 0) check for error condition.
>
>  fs/smb/client/smb2ops.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 058050f744c0..ac8a5bd6aec4 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -4650,7 +4650,7 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>         unsigned int pad_len;
>         struct cifs_io_subrequest *rdata =3D mid->callback_data;
>         struct smb2_hdr *shdr =3D (struct smb2_hdr *)buf;
> -       int length;
> +       size_t copied;
>         bool use_rdma_mr =3D false;
>
>         if (shdr->Command !=3D SMB2_READ) {
> @@ -4763,10 +4763,10 @@ handle_read_data(struct TCP_Server_Info *server, =
struct mid_q_entry *mid,
>         } else if (buf_len >=3D data_offset + data_len) {
>                 /* read response payload is in buf */
>                 WARN_ONCE(buffer, "read data can be either in buf or in b=
uffer");
> -               length =3D copy_to_iter(buf + data_offset, data_len, &rda=
ta->subreq.io_iter);
> -               if (length < 0)
> -                       return length;
> -               rdata->got_bytes =3D data_len;
> +               copied =3D copy_to_iter(buf + data_offset, data_len, &rda=
ta->subreq.io_iter);
> +               if (copied =3D=3D 0)
> +                       return -1;
> +               rdata->got_bytes =3D copied;
>         } else {
>                 /* read response payload cannot be in both buf and pages =
*/
>                 WARN_ONCE(1, "buf can not contain only a part of read dat=
a");

> --
> 2.36.1
>
>


--
Thanks,

Steve

