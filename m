Return-Path: <linux-kernel+bounces-846686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C0BC8BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969B542233C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFE2DF6FA;
	Thu,  9 Oct 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoSNf3xl"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB12E040E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008711; cv=none; b=fij1Ll4YBUnRDAVUZccI+M7Zh0I8O2m3uN1gRuPyrDEKCt1Y3OIxw7VGg8bLVpD9KQJRnj6k0e+Ar5LOn2mZrrsLtT5dYZnR1Y+jHkDShkiHy6QONPkOXgwISK7ViIWvGp+GYvuZxP2o7fY2Yan718HyA7uRI0icDBtxslliEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008711; c=relaxed/simple;
	bh=KhiBEQ1gBj6N/wX9SxoVMA19u0YnGN1VD1SS7ME84vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXG6aJ9XyYWAIjEjUuoglmKFypFbD7EtfMQIhkdoiiOZSFmeookV5W4uMt80RA9s3sNt1H4Y9ITS8Jif3iMpQdwACdwRDM2/68dkziJpvyJ9zaYr8vTFmPjPS7zM7u8u+suHzJKbgEoo1TWBThUAfh+xXBvS7JVv4AqiFXOwgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoSNf3xl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28e8c5d64d8so7689305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008708; x=1760613508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqfRaZoQUI4dNFSPZo9GyySQC2vIhVGnsV8QxQuw7pA=;
        b=KoSNf3xlHwsIU5mJeeMtTH9JboKnK6HUHzBfNkobUe3mc7l1xBIH9Jtwy2FzEsX1nO
         qEc8xiErlOlepn2KH/f9s5ZDj07EPe99iJO02EgEJkH/L17PPlVWisyKfcf8YkVirI6H
         nRiYamT7UtnlqNqPb3DgyJ/hs+KHqVtiDCQ+TQ7cpM8WaVrbTXcqwCvfSrRXPx0V+E/G
         NBHbUk0Pp/g+HdmeuFt0BvfwggqLI9ZatLuEJjl6b9OB8xIChbhNDLfl8SPTXE4dfhtN
         oJgmwGHh/s+JxCxAPOOBCUERPtBISGEGk24RvR3GEmoayO+y9SewuITwGDcwGbA/2oHe
         YjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008708; x=1760613508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqfRaZoQUI4dNFSPZo9GyySQC2vIhVGnsV8QxQuw7pA=;
        b=i/V0I/h676/4jG7GhC57dDIcOV4FDFqiX0Im8tDmKBKUrlXOtIap7VXP6BDNxUSkqD
         kkJqUTZOydM26EEaLECeRtJJhb+L1orKtCrr2yhUdyzMxasUuWHpZNpEnE5gcc4OuRDc
         cd5hU/jN4VrDHs8dHRA3FRswvulMgl4Y4VLXCN/llIf958jBUmRAgTXrw6bL2V44v4uT
         IFHeedjQEjYXjkRESwNbIAXHGVm18ROLUWrWPmroERceqX5ljysP1tl6ROyPwt6dhepP
         +mkzrp+VXP+zndy4Rzro7PrctQlZcbbVXH2jOChk5kFWyOWeXN/4birxqPsMZ6so1oPp
         SLhg==
X-Forwarded-Encrypted: i=1; AJvYcCV3iGAa2Udit/TI3TCuY7Lw3KyIhRoaMEi7qzbumEpb2qOSVpmDzHav7mpJeZaUKUBkpavsWOIW+TF7OGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCPUo2wdHIA4iE7Su4Rwn5gymrqGG4Cf+S3UacROQSLQUEKgM
	nVSOFDsd9BHc7smqhm45z9EEZJGH+Wk/eAH6Hws+dE8fWhFQtepDL52zHj/t+QAKyLt3hs+k4dL
	JsKd6Mtczb9zcgCLbMiN8w472D7/7PXs=
X-Gm-Gg: ASbGncukJQfqgHHD7KhgmQ7hr8CNEuGJ5VxJrphUgfqnvrLbJ0YlaiIXhNbaew7nLRx
	QNVt0v5kfVltPsG4QnkpTVsfJ0i5zID0Sj6d3NB8J5XNppWLYgx/++ZaKWXvQGTbM6wpriiJWZ4
	DsJBa+VQSTReM2conYgGA/oDoe54DQ9zizoNbSIGqBVgO+ucZm8QxWekxLw3aA4i2SVC36uQtuO
	xJmw0lX+kGiy8PMOKrQcEOsqgi4EQc=
X-Google-Smtp-Source: AGHT+IGcTXsPBhZTmdsjcj1YrtEGdE4o7S5DX96nyjsPy2BgZaV1B0w17FZSDPhHO/AfhGjc60kGCKFbyKvnjNaAjuQ=
X-Received: by 2002:a17:902:e94e:b0:270:4aa8:2dcc with SMTP id
 d9443c01a7336-2902737c5e9mr93104295ad.19.1760008707755; Thu, 09 Oct 2025
 04:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806094855.268799-1-max.kellermann@ionos.com> <20250806094855.268799-4-max.kellermann@ionos.com>
In-Reply-To: <20250806094855.268799-4-max.kellermann@ionos.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 9 Oct 2025 13:18:15 +0200
X-Gm-Features: AS18NWAi8TGwpk5qdmtF-1FkOPvzEwGccMEEtDCCNUrhBLZHkJ86tq0vDug7F0g
Message-ID: <CAOi1vP_m5ovLLxpzyexq0vhVV8JPXAYcbzUqrQmn7jZkdhfmNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] net/ceph/messenger: add empty check to ceph_con_get_out_msg()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:49=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> This moves the list_empty() checks from the two callers (v1 and v2)
> into the base messenger.c library.  Now the v1/v2 specializations do
> not need to know about con->out_queue; that implementation detail is
> now hidden behind the ceph_con_get_out_msg() function.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  net/ceph/messenger.c    |  4 +++-
>  net/ceph/messenger_v1.c | 15 ++++++++++-----
>  net/ceph/messenger_v2.c |  4 ++--
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 424fb2769b71..8886c38a55d2 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2113,7 +2113,9 @@ struct ceph_msg *ceph_con_get_out_msg(struct ceph_c=
onnection *con)
>  {
>         struct ceph_msg *msg;
>
> -       BUG_ON(list_empty(&con->out_queue));
> +       if (list_empty(&con->out_queue))
> +               return NULL;
> +
>         msg =3D list_first_entry(&con->out_queue, struct ceph_msg, list_h=
ead);
>         WARN_ON(msg->con !=3D con);
>
> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
> index 516f2eeb122a..5eb6cfdbc494 100644
> --- a/net/ceph/messenger_v1.c
> +++ b/net/ceph/messenger_v1.c
> @@ -189,12 +189,18 @@ static void prepare_write_message_footer(struct cep=
h_connection *con, struct cep
>
>  /*
>   * Prepare headers for the next outgoing message.
> + *
> + * @return false if there are no outgoing messages
>   */
> -static void prepare_write_message(struct ceph_connection *con)
> +static bool prepare_write_message(struct ceph_connection *con)
>  {
>         struct ceph_msg *m;
>         u32 crc;
>
> +       m =3D ceph_con_get_out_msg(con);
> +       if (m =3D=3D NULL)
> +               return false;
> +
>         con_out_kvec_reset(con);
>         con->v1.out_msg_done =3D false;
>
> @@ -208,8 +214,6 @@ static void prepare_write_message(struct ceph_connect=
ion *con)
>                         &con->v1.out_temp_ack);
>         }
>
> -       m =3D ceph_con_get_out_msg(con);
> -
>         dout("prepare_write_message %p seq %lld type %d len %d+%d+%zd\n",
>              m, con->out_seq, le16_to_cpu(m->hdr.type),
>              le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len=
),
> @@ -256,6 +260,8 @@ static void prepare_write_message(struct ceph_connect=
ion *con)
>         }
>
>         ceph_con_flag_set(con, CEPH_CON_F_WRITE_PENDING);
> +
> +       return true;
>  }
>
>  /*
> @@ -1543,8 +1549,7 @@ int ceph_con_v1_try_write(struct ceph_connection *c=
on)
>                         goto more;
>                 }
>                 /* is anything else pending? */
> -               if (!list_empty(&con->out_queue)) {
> -                       prepare_write_message(con);
> +               if (prepare_write_message(con)) {

Hi Max,

I made a change to net/ceph/messenger_v1.c hunks of this patch to
follow what is done for msgr2 where ceph_con_get_out_msg() is called
outside of the prepare helper and the new message is passed in.
prepare_write_message() doesn't need to return a bool anymore.

Let me know if you see something wrong there:

https://github.com/ceph/ceph-client/commit/6140f1d43ba9425dc55b12bdfd8877b0=
c5118d9a

Thanks,

                Ilya

