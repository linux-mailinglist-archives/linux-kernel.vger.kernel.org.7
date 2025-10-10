Return-Path: <linux-kernel+bounces-848821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE346BCEA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48DD1A644C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7492147E6;
	Fri, 10 Oct 2025 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3ijQDaD"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B6303C8D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132874; cv=none; b=N7ao0Czu+g7jscArDnhGURvo4t99lwarJi8d7q1TJ1P7Ld/fRUYOdwR9bc7/xueMsVvT+ktbDL2V/KIHg69qAKPmiTuVnewJLjLOKNvd6sFySLBFHCOfXz/KOcbPaUf6n5rdSl7U9t8/l2YLW2IMUOLuxL5V5s8k3pXM6MMgZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132874; c=relaxed/simple;
	bh=mIpoIuiWbWTkQzK3YQSho5nZUTLiqCNHcBr5TymQZzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuxYc8Tb5MKpNya/Mjo1MQUe2CCn+Ysgst9LTjnoxmn/7u5c5DM1slA6EjVd1pG0oTEx+0jTK6yq4LF7lLJAnjrtcnTw4WPrlKXsvXFuuKIwsznsFmOTSD+w+6k05ukk+y/Sw5Lo8M2dpHZUrBQWYBBrEhRIwkkFVwu4+XbKf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3ijQDaD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7f7835f4478so21111116d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760132871; x=1760737671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CR2CWtGpIxQ0lSsR8U+87pwlo1Y1um+ZQFcDhfvovw=;
        b=Q3ijQDaD2AHW/EG7DDiHVpxv+hIqECbLvbhJ0KXspevceWzPdqD1ATxDCYTDUim7Ab
         EGdz743vlKt8lwcrvYb5m+WNnwRxOxmlO0LJLumBaXVqMdHmrk6crAlidfCCZOiUc/BY
         GH2+ehwaSMIvkUUljndO68sF6AERxteYABlX6oBsk/I85s7EmGBcYoTFN7HzY7ARwReq
         vusdQpT56ODQnjNQCDYjuB5BoGDJb5E+MJnrlWgOAN47N6xUm6SbMcICux37lAoUTMwB
         jv1+gx6aqNH3aZ9bNq9ogje5CZpGGJA9jv8mGmaLvnHZn8izkmN7TZRIQxQl6rbkoEVI
         Hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132871; x=1760737671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CR2CWtGpIxQ0lSsR8U+87pwlo1Y1um+ZQFcDhfvovw=;
        b=YU40PykAZruK9y8744FvWoCGZ/HEnT1oX72GkQ/cfRF7/iRIMm2hQbuZ2oUB8C3HTE
         9HyV0zpoAbNpd3N3SxDmUNVa2nMXVncszY5L4it1GcLzjlzrAk/ahTHXQlRPm8yH7p7i
         mbsrBMBxjf6TCGe4ZNiUjiPUNIY2YkEBIr40wVHAUCpAdKALcqwylh0OgG0aaQT60eN7
         KLqDUFbpKfS5lcTE670jzHTbBvdzdUD/tvRnX6ZGOoEezWHCVlFEM2vNeahWQORXvUAB
         IkLz2AcOymjpX3C8mVuNf72ZWd7hV6LTOdIfSundzwv5hc6EmqUcwpJPps4WVDLsosgJ
         OBkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3xtluMFrX6QRFWozDG98+Zs1sB3uOfLpramU+09w/Sy7sNKj2hVo3rF8vbUP3kGs9QCpkVl0o804Xo/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsUJBcE1O8C8Nz/LPyt9ZqjU8sULRbEPixA52bGiWkAqLoCrM
	8SPIV76NFB6pOIzWdU8qg6tjBuoyt4ylqGW5yUDMn4ikWp0RyheKViMir72LrjT0zmR2wlGADXp
	O20Rb0yK1M6XNcEDIQ3sIQKD7IeCzCks=
X-Gm-Gg: ASbGncuGvwITk0dqAQU6qzQYNCJD9GPISg6iWTNUSqJGfNqtt4oATnN3/6CJEBnwpud
	ISv9HzqHia5yKKz87tdCUtMkPJpeSWlaWNft8w6WD+I5NLXn1sHGxOQsVbwwDCyVgEnRAn+sd47
	SuMw8VZK/EkHyed2Un8Qgs4cDZU1IYalmlHfKw2YANS1Ee5adHPhWjaHTiwgYFfXK9UbUHacP8h
	RfMQkIyEjS67+BHdEKWrCGXulrSqO0Cylwkex6xBH9mQceKVlOv9KOrwWJVWr2DJKfIRW9X8H+o
	z4ZBOPZpKiW8eY5QrPKyKtZydhK9QjSDn5LMi+pLJ1/U88huubWHqzrF7HzhWyKAWHNdpgE+VKL
	CPIlfIorg891Om0mRyAruRkcNzTgt8ZRtjuLuGihfj55Dzd/jG3k=
X-Google-Smtp-Source: AGHT+IEKPVwEdU4o07u55ueyk8vUy2UzmXDdxkCxRSLFg22YsdbJNI49WIX6CJNsbf/SmtfBMyBAU8Q57eqBkexOrMk=
X-Received: by 2002:a05:6214:d4e:b0:879:dc43:6334 with SMTP id
 6a1803df08f44-87b2101ea49mr216502996d6.25.1760132870981; Fri, 10 Oct 2025
 14:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8a44f5e-0f29-40ab-a6a3-74802cd970aa@web.de> <8f7ac740-e6a8-4c37-a0aa-e0572c87fe9e@web.de>
In-Reply-To: <8f7ac740-e6a8-4c37-a0aa-e0572c87fe9e@web.de>
From: Steve French <smfrench@gmail.com>
Date: Fri, 10 Oct 2025 16:47:39 -0500
X-Gm-Features: AS18NWDpFATkfplY4kQV4nikbT2tj78bFi9hHJ8bS3alHy0nVzf3BOr0-aoJg40
Message-ID: <CAH2r5msRAejKX=vo7xGxMZDG_s++zZyHTazoFomd6GKOSt1XQA@mail.gmail.com>
Subject: Re: [PATCH 3/3] smb: client: Omit a variable initialisation in smb311_crypto_shash_allocate()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Aurelien Aptel <aaptel@suse.com>, Bharath SM <bharathsm@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Fri, Oct 10, 2025 at 1:52=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 10 Oct 2025 08:05:21 +0200
> Subject: [PATCH 3/3] smb: client: Omit a variable initialisation in smb31=
1_crypto_shash_allocate()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The local variable =E2=80=9Crc=E2=80=9D is immediately reassigned. Thus o=
mit the explicit
> initialisation at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smb2transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index b790f6b970a9..3f8b0509f8c8 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -50,7 +50,7 @@ int
>  smb311_crypto_shash_allocate(struct TCP_Server_Info *server)
>  {
>         struct cifs_secmech *p =3D &server->secmech;
> -       int rc =3D 0;
> +       int rc;
>
>         rc =3D cifs_alloc_hash("hmac(sha256)", &p->hmacsha256);
>         if (rc)
> --
> 2.51.0
>
>
>


--=20
Thanks,

Steve

