Return-Path: <linux-kernel+bounces-847089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B1BC9D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 200BD4F9A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9521578F;
	Thu,  9 Oct 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5IK4OCP"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79790211A14
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024604; cv=none; b=dnrbubAoMIu61kTQBX/Epr2qufEhtBGIs7LZGXkkjYKBCcyCrzxaeZzBK0y7PHNVxQYajeopH2GQyFO+06iijQE48h50q/dQ0Df6cJ0naNDL4B6DCzq99cFWLn6zHWxhOfZPJopib6MOuUFKvAZYXW/jklKhDU6+5w4B5gksq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024604; c=relaxed/simple;
	bh=te3lK6IWUoqi/wAYbc+4g/fP/ekfKZqS9oWgxvjZ0rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLsttMJmFhi9GMEKwq4OImQunzNdfqNeIoWsO2QwiLuHt6qzyvYLPQ8EQO6Czy7UMkkDZFRJd95rm+14w+SUuMBEgXlx3Sx8S6oTxUql9++gQ6wMv9Zd+aT9b9feYF4xPmpsgInrq0GFyvBHlTMBiwq93GbzBR0bWyQWtph2Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5IK4OCP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-795773ac2a2so9378936d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024601; x=1760629401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNVjPOkZQ4/5TQpLx5EDj6qV7WJ4xTniFhtjleJ40Ko=;
        b=O5IK4OCPguzzR1HnnG11tlVqTHh3OF3Fv/qXLzbXFvE8ceBPYss8GF9Ce9OkRuIvta
         GkJy6qalK/ePV+Uh3tW/YNL/Aej2dNIbnrNMXea0znWeo7oo6JgrDrxRBrXUAhpQKIhT
         RBfHf1emrQzLYpVBwDWw2/hDtcNG4H42zgaMWP17cZejWoFx/qLtfPHYfBjsjdBEnm1B
         nAgDzPMJq0feamsRcZ2R/avlbGjtEgSHAHJO1izz1MydN2OwMQEs9tygudUwb/qjDgsU
         r6wF0KraM9AOfbl/9hytl0xx5wwAv/RlWRSP1ZqeD2Iobn5dRxokou9cIVLxZqKOHL1g
         bMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024601; x=1760629401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNVjPOkZQ4/5TQpLx5EDj6qV7WJ4xTniFhtjleJ40Ko=;
        b=t7+QEA9scQ7hmy+0t0rsY5VoKHo/iJN4qYPFi48wRLXwbyycy7xwxjT6YfjUhnmU8h
         x9cYYc9ugSCLuSFtvEedk4EEiVtVwIlve53CHTMmUebRaxfqtCXpbIiWhxc/Y83kBWNI
         ji1aakXp7HLzdNi8vOBQOj9vFlbKvkpNZaw9DAVQY8vW8k1jUhZwIIbu3Ho8lsFbFQh0
         VVAgOW/Q63lscZfl+dzt3jVuBpARXMNRXkc8iPAaL8Nc/asIedTkbZAueh7At2ZeZCar
         v3Klt6M6vDeF37DvoOytidFIt9G+GOmuqBFw1Ckur9j02HBlZvhaoZ7fGylN0pQj1vfj
         zdxA==
X-Forwarded-Encrypted: i=1; AJvYcCVYuTh7Cc1K3zKzTpfH5l3yp0tNR9EeS+jzKVwbGHxj3T7w75SlNLMD3RULOhsqRJdDJBASJiUJ5XeJf+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0pVDKh2EgKKhlOm2DdtdreQsx//RZU12KubhmVRoB4FqIFj9
	r/+UE71jCrStpXqpP2MqSn2Vnht7WIlyq3+VzDf/rMmvEfvmUuDP+JwUGhkMIf4Ceok6lybTI5C
	jRPMEKKh5wwokUyecmP21Eou3gS3eKII=
X-Gm-Gg: ASbGncubjCgR55xTJZrPGySifR2bnVWcjtAtiSj4cjbGS3BiZuYhQ/vntifjLuAn3RO
	IbK/sccCUTeXafOz/mXa26ITB6le1IIa1lBM2KKHes0vOg0WzWkrETVPriw7+vn6pS3L9VT0J/R
	vx+HVo9ylkdcUs2OIWpt5TDRiJGeTV3RVjZJwlypKGY5lsr9vTwpLQ6hezJxwR9E+riMoa6K7DJ
	lZyHhYwzMC7SBWxUDYLMSEjo8Ery7ZR68Iq9VyrTPShAiCn/LpDVfcv8ksoNu3yxMK970NHsykm
	O/Ly6T3PgDvZMaPqSEZ5Q8+myN/8oZhwjv6Zv00QTK9ytLc0cS5y1d0G4irXy8BA3iNmcw48rUF
	CA/Sm7d/y7gMHOapyJ/IoUapXyEgdfDVW4ERPx/1K9caSZaZMc9vG3wr3
X-Google-Smtp-Source: AGHT+IEYrpzc6SMoRQfsWO3qThn+WGHDuSzBgj5HClu2LTLami2LK2vOG7hA85WdSkdDUqm3JQ980vltGEZBu587cu8=
X-Received: by 2002:ad4:5c83:0:b0:79e:88e2:1e60 with SMTP id
 6a1803df08f44-87b2108abedmr105123276d6.29.1760024601139; Thu, 09 Oct 2025
 08:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a5c4b6d-f15e-4071-8a82-dca6b71b6b4b@web.de>
In-Reply-To: <7a5c4b6d-f15e-4071-8a82-dca6b71b6b4b@web.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Oct 2025 10:43:09 -0500
X-Gm-Features: AS18NWBOW4IMP5XCqIx3vf6oRH0bz8isK0u_b-ctyASqmWxzGVwLMu3pjongCW0
Message-ID: <CAH2r5ms+S+G-wjB1MPTp1G6MyVLf+yzq6r+_Yg9PLb6HmDCtYw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Omit an if branch in smb2_find_smb_tcon()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Bharath SM <bharathsm@microsoft.com>, Enzo Matsumiya <ematsumiya@suse.de>, 
	Paulo Alcantara <pc@manguebit.org>, Pavel Shilovsky <pshilov@microsoft.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Sachin Prabhu <sprabhu@redhat.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Thu, Oct 9, 2025 at 10:12=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 9 Oct 2025 17:00:13 +0200
>
> Statements from an if branch and the end of this function implementation
> were equivalent.
> Thus delete duplicate source code.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smb2transport.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index bc0e92eb2b64..33f33013b392 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -240,11 +240,6 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, _=
_u64 ses_id, __u32  tid)
>                 return NULL;
>         }
>         tcon =3D smb2_find_smb_sess_tcon_unlocked(ses, tid);
> -       if (!tcon) {
> -               spin_unlock(&cifs_tcp_ses_lock);
> -               cifs_put_smb_ses(ses);
> -               return NULL;
> -       }
>         spin_unlock(&cifs_tcp_ses_lock);
>         /* tcon already has a ref to ses, so we don't need ses anymore */
>         cifs_put_smb_ses(ses);
> --
> 2.51.0
>
>


--=20
Thanks,

Steve

