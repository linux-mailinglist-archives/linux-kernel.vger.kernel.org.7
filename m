Return-Path: <linux-kernel+bounces-827546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C623CB920BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BA7A9416
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC472EACF1;
	Mon, 22 Sep 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFJSYVno"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800424DCEF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556142; cv=none; b=ZOXSeF5aadGNW1JM+CqrP+irYP8jTwKOPuOBMR1AySG9B4pw7dsT64amVPjhAFkZBpJ2NQOetXpL9r424vdi/ay3saH6LHBVFX8CR7BDMihn1pcQd+c6z9WPZ6rZbPNDM2m+ayhxudYQX8uzezwkjGrGiiPnbJriVUMv6Th/964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556142; c=relaxed/simple;
	bh=vNkRmPJx//e+92f7Jn7qqIglcTXlvX95k7Q7RsLP8i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNYW8E7bgMwEWh2oNdokaViupygGN5yZA/byJiY9TyR3tyjLrJsjJd9inh0mVJ+DKzX2dlmtgLYz4QZJb5QvcgKQVQi/X6Oa6nND1S49Bk1dZA9S0TQs8PtabSPdFx9W7AoSRnJ90u/Wg5MeevIUtZsw2YFcuD2PlUyTa2Lfpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFJSYVno; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78e4056623fso42943426d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758556139; x=1759160939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlg2oopvF77trHsNmLt3OpgaKYs1PYeJnpJK0K9pt00=;
        b=JFJSYVnod4L/nso1xEg1Pup3cEnZjd9aA83F83Da43Y+3IjZp7C6AOJykNDNpF368n
         FOUUc7STGxbmGjdLbM756QUAatLO7yf2+hUNWp+ysMtR27cHs4us9QTy+aOKLdpRL9WX
         hZqGYYuEHaTE65WimGq/X5dAMpN2RfH3GwYyiax39Hn4yWDGL1IiWHUdYYltY021NQhg
         ylwMlLGyZFv4PDviGfduzHbxpDrNpYUdkc2VEDp1k94/LQfD6uW6GTyDYtDKujwtxraX
         V//MxqPvCl/1ZHSJkd4lngJAHAqxD2C0T7qFSTetx5NHUBo1xyPYwuX3zBI3K3Fk6A8t
         oyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556139; x=1759160939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlg2oopvF77trHsNmLt3OpgaKYs1PYeJnpJK0K9pt00=;
        b=OGOAnErGwEePEzE+VeuvHlNZ0yrz7zcf3PU8NTecPfVYbNgmc6tdShKYbhU8x4Zup1
         DX9mWVvcib8Qk0S8ygUfc0r5uCDS7xOIgXNFmBSdMbtbkuwkfdjNjGjJA6tlZA+CEmm2
         7H0r0cx+3uNszjmljfOcFoz7DU8eE3d5IS3B4oaXDjCD+GvX5UrsKGD/6HDYZMjPuZIi
         rkJLvKyDRouAmao9abmFV5Gxee2eArbHEYX8xoblGmJ+vuoo+lLbCIZZNetOCcD8uQ4b
         mvx8VnyzHPyheDjNCXkLD64BSLKsF/ebW60D75qsoFpdIX6gWAYmDG2O0gYKuN0lKliJ
         WsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVssac0XnO7ddbSBKmzwBm3cMgnMOBur7HR0OsN8OZrJSlrfhH6wZGSN1+rC67iKha9tLYYp0EC8v8n6Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzul6tfnyKFD5mss6uPUJmsXMtqSwbzuqItH72AMvjmkEegvcAq
	qoUzDQzlibB4/Xn8BBdA+AxIp1hfKyafrOYkRHtn17PHNbAZL+n9bgofI6Fn32eLI/ua/lL/vXF
	fuzhI9eIoam+cL6cWfuR0MHN+Kr5LNvg=
X-Gm-Gg: ASbGncsXt/e+iJlb62pB1ps1hMPCtExMgvwJlZwrZleSjWvt+yMmEfjmVM4jaRglOQ7
	JU1lGWzI1vJwBxWNNL9YUwajDy4ubVhP4WCmNnuzCiKFKVl5CYCQQ6ZCmwKdKUhdOQoV7+uPUUn
	SSwcQvlXhuJoMiinfRpDofWIf342Y5KCRJSYxrQOsfe3vG4hokdw8/ltE2A5/m46uaUExQdHQ7o
	EnqUFCi+8rBvVnA4ybWK7Tljl0Salx/VkXzFFCX0ZkOG/x9ccXxTM0Ck3pqmtALnOV+eS6pg2Hl
	VXCAJG4pM2d0XpdR0LzqfG5mcL6W4/Ot8oHRH4S+D1HApoQSem9ssDpANjAI1YaDOGIKkM327q/
	sex7Lej27m+Fbv4tRzJg8
X-Google-Smtp-Source: AGHT+IHVcugTSFzYYfT7bSVR5B8KfV75JOC+bkghqVVTgya+qCitcTbaRA7yVXfj09A0yT4WrZbJ6OupQWKSKBIcWws=
X-Received: by 2002:a05:6214:268b:b0:77e:8d71:c334 with SMTP id
 6a1803df08f44-7991297fb36mr150947796d6.17.1758556139181; Mon, 22 Sep 2025
 08:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
In-Reply-To: <20250922082417.816331-1-rajasimandalos@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Sep 2025 10:48:47 -0500
X-Gm-Features: AS18NWBZ-tc9h4IfVjj8s-i7hSP4_43DpRVZDBpO1wJ1me1nASDPtaIyja-mdsg
Message-ID: <CAH2r5mtpEc7ePZ58_qdE+9GRPVO3PPYuN44uHuskoQpnssbkdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when max_channels=1
To: rajasimandalos@gmail.com
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-kernel@vger.kernel.org, Rajasi Mandal <rajasimandal@microsoft.com>, 
	samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i just noticed a more serious problem with multichannel/max_channels

When we mount with multichannel (at least to Samba e.g.) with
multichannel disabled on the server it confusingly returns "resource
not available" we should at least log to dmesg something more
meaningful than what we do today:

[ 1195.349188] CIFS: VFS: failed to open extra channel on
iface:10.45.126.66 rc=3D-11
[ 1195.454361] CIFS: successfully opened new channel on
iface:2607:fb90:f2b6:0732:7504:183c:991e:6e53
[ 1195.454599] CIFS: VFS: reconnect tcon failed rc =3D -11
[ 1195.457025] CIFS: VFS: reconnect tcon failed rc =3D -11
[ 1195.457040] CIFS: VFS: cifs_read_super: get root inode failed


Samba behavior is also strange - it advertises multichannel support in
negprot response but doesn't advertise it in session setup flags.

On Mon, Sep 22, 2025 at 3:25=E2=80=AFAM <rajasimandalos@gmail.com> wrote:
>
> From: Rajasi Mandal <rajasimandal@microsoft.com>
>
> Previously, specifying both multichannel and max_channels=3D1 as mount
> options would leave multichannel enabled, even though it is not
> meaningful when only one channel is allowed. This led to confusion and
> inconsistent behavior, as the client would advertise multichannel
> capability but never establish secondary channels.
>
> Fix this by forcing multichannel to false whenever max_channels=3D1,
> ensuring the mount configuration is consistent and matches user intent.
> This prevents the client from advertising or attempting multichannel
> support when it is not possible.
>
> Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
> ---
>  fs/smb/client/fs_context.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> index 072383899e81..43552b44f613 100644
> --- a/fs/smb/client/fs_context.c
> +++ b/fs/smb/client/fs_context.c
> @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct fs_c=
ontext *fc,
>                 goto cifs_parse_mount_err;
>         }
>
> +       /*
> +        * Multichannel is not meaningful if max_channels is 1.
> +        * Force multichannel to false to ensure consistent configuration=
.
> +        */
> +       if (ctx->multichannel && ctx->max_channels =3D=3D 1)
> +               ctx->multichannel =3D false;
> +
>         return 0;
>
>   cifs_parse_mount_err:
> --
> 2.43.0
>
>


--=20
Thanks,

Steve

