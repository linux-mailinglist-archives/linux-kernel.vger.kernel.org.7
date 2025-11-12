Return-Path: <linux-kernel+bounces-898148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FDC54736
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6931342E41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA532D2498;
	Wed, 12 Nov 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoyeQh6i"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACA2C3774
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979411; cv=none; b=hXoKJbwJpdLvOyvv7qo9T0i/TlammvoU1YBK2XuRp8dv73L6BWc1TUKXjkcUEwl1mIECXAvjneoZ9RN0PWresOBW8pCvj74aIAitkpEZCvx8u4P8FC68dYqCXw+aT4lOkn1cj8KjszHMqOlp3DItmTiwpNZLQ4CPBCazOlPMkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979411; c=relaxed/simple;
	bh=DtbSXMnbv13JS9DE85J2oaC+TTvxz/CxHMp+L2EbBis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJk0ag73tGnDiweGpCzbeD5UHsjr+nz3PInd31vl9SOws4Z8epkua/zs/eCyUHDeecFN+XjKz6nOumQQdqJEidsvbNAZEjlnb0S/lTAl0CT7nRUBFkDBnxCFxzG0puWMOtF3/GCt4Fj1u6R++Bw0kel80pbXW8w3KHozmeKyM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoyeQh6i; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93515cb8c2bso71637241.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979408; x=1763584208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwZOhDKhg6nzefR9evpVQL7Ofqz3agKHaVIZRWUuIFQ=;
        b=KoyeQh6ihvjn6jss34PCiF5FIkixISy03lAn8CJQFDpwsQLRVlX+nr6hSv2xVlS5RF
         4wqcPGHOklSj5D7HQcNCCXIMzTLNA0CUSlW4UT1orLF4gEobpdLFoxNYXiGVbYJAWZgB
         1MtsT5oU+S1Vq565j6GCgkz/Nprf/wNcEr9Bvrv2p3wmVZA82T12R2ZhnBmkpppnszdn
         nwU429VVAyCWmCqqebAE13/APD6gwDucL02qn4YCjXxu+SkvM7gGOUzNqSr8EfnKemqB
         MbPuBcU7AfkV+uxjWGcMB3TsuvCz6pKX7MM7Ghs/n9To7fVxBbfhHJkP0PopxB9wtEV8
         n80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979408; x=1763584208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwZOhDKhg6nzefR9evpVQL7Ofqz3agKHaVIZRWUuIFQ=;
        b=iBifSUWVOuBp2mjsJE5NMoZbfI8ppUyf98QvoPtjg57AeRWYg5fUWXARUV4WkKLgUt
         8VRlDJH1V3w6fN4VLDy3W5RlgwCACsFIZ+I+kBPCgn2izm0GIEzMyLo8V+5fz9JKGvrK
         LJK7yJRBpBSORjqDFCwduWzeQJZ6afJVSEhx6Mg+GhQ0Jc3RXwh20XRMy7Wx+RU+2L5v
         q0RQKIDLE8lzU6uWvUXCsJAfCLkqd7jcQ5MpWetyIxQISMBjEez9nXKxiFNG40jro6ky
         tzI4YSJOEoaDP+Qt/0Gfsq/OPMN9lMEvVshFAxZOY3hLF1u0bIWbP3E4G/NJjpdCz2Ia
         bIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe1JMoLTJvBn2LOj3buD2/X/quGUK9IQ9h97SZEieN7hYDT+FT28gvsMlXPWmBHPGz5BZHuzzZtk+f5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN59h6h5lnVgXosxu8H811ycFU6Py+RNv8v0XHqUATAahbWPNx
	xzBVcQy5VAQHi+13H4Ahj1K88ZmQVKAtQ0nhLdlXpRrW2L6CzWsRckqwvnkJFJHxhP19nAh7arJ
	k4oh2DEFN/7SD8xrvzfa4gNe6z1FnSTc=
X-Gm-Gg: ASbGnctgo2zfbCOvHmg/Go7KJSjhY6m1+EDs4ZEXHwZOm8M/Mif4xpH2jMkA+LqKoIw
	6o6M2Vq1cnlYkPEAibe3dkr7j1XJtwSh42WR3DuIH+Pr2FC/qVUC3p6CxzSMYsjOECjPwkwU12Y
	5EXyCKWzBh9bIEau6J6yaXp8sEzcfFBt8TwpUmnnutmMfoDBsRoNP9NkMFJRHfxhd4Fbc0UFD+B
	++vxQdJtpGi7Fx/kRBn1IXe6ahQ2SHTGCi2HPs9U9zIcnqD/PsOq74gAMyjZpPTPON0KhKoOrVA
	UE7abUDuydT4Eck0z1hzUnNHQmyQlDY/Ga4rnmb/ZmTR2Z0=
X-Google-Smtp-Source: AGHT+IFHYQYlB5H/vZO6pAE59Ra+lPGYc/9oEwXWmHHStsX1pd0NaLKAa+GMJ2VwQwjA/HrEVrmE3Ft6/3DaLcbhLUU=
X-Received: by 2002:a05:6102:441f:b0:5db:ee3e:860e with SMTP id
 ada2fe7eead31-5de07ceedcemr1597457137.1.1762979408635; Wed, 12 Nov 2025
 12:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028145534.95457-1-kubik.bartlomiej@gmail.com>
In-Reply-To: <20251028145534.95457-1-kubik.bartlomiej@gmail.com>
From: =?UTF-8?Q?Bart=C5=82omiej_Kubik?= <kubik.bartlomiej@gmail.com>
Date: Wed, 12 Nov 2025 21:29:56 +0100
X-Gm-Features: AWmQ_bnLwOfcWQPWIKmUoND1n7tdM12UUbgDYcwxauU_Xcm3P8dYRzc2Y6PS87Y
Message-ID: <CAPqLRf2vo6pVbF6C4LtReBwH1VaMQzEGGyd2NuFxbLMZykqM1g@mail.gmail.com>
Subject: Re: [PATCH RFT v2] driver/scsi/mpi3mr: Fix build warning for mpi3mr_start_watchdog
To: sathya.prakash@broadcom.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, sreekanth.reddy@broadcom.com
Cc: martin.petersen@oracle.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, skhan@linuxfoundation.org, khalid@kernel.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 at 15:55, Bartlomiej Kubik
<kubik.bartlomiej@gmail.com> wrote:
>
> GCC warning:
> drivers/scsi/mpi3mr/mpi3mr_fw.c:2872:60: warning: =E2=80=98%s=E2=80=99 di=
rective
> output may be truncated writing up to 63 bytes into a region of size
> 41 [-Wformat-truncation=3D]
>
> Change MPI3MR_WATCHDOG_NAME_LENGTH define to properly clarify
> the required buffer size.
>
> The mrioc->watchdog_work_q_name buffer in
> the mpi3mr_start_watchdog() function no longer requires adding mrioc->id,
> since mrioc->name already includes it.
>
> mrioc->name is built using:
> sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id)
>
> Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> ---
>
> I do not have the hardware to full tests it.
> Tests only built kernel without warning and run kernel.
>
> Changelog:
> Changes since v1:
> - Add define MPI3MR_WATCHDOG_NAME_LENGTH (MPI3MR_NAME_LENGTH + 15)
> - Change watchdog_work_q_name buffer from size 50 to MPI3MR_WATCHDOG_NAME=
_LENGTH
>
> Link to v1
> https://lore.kernel.org/all/20251002063038.552399-1-kubik.bartlomiej@gmai=
l.com/
>
>  drivers/scsi/mpi3mr/mpi3mr.h    | 3 ++-
>  drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 +--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
> index 6742684e2990..be15d5ec8b58 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr.h
> +++ b/drivers/scsi/mpi3mr/mpi3mr.h
> @@ -66,6 +66,7 @@ extern atomic64_t event_counter;
>
>  #define MPI3MR_NAME_LENGTH     64
>  #define IOCNAME                        "%s: "
> +#define MPI3MR_WATCHDOG_NAME_LENGTH (sizeof("watchdog_") + MPI3MR_NAME_L=
ENGTH + 1)
>
>  #define MPI3MR_DEFAULT_MAX_IO_SIZE     (1 * 1024 * 1024)
>
> @@ -1265,7 +1266,7 @@ struct mpi3mr_ioc {
>         spinlock_t fwevt_lock;
>         struct list_head fwevt_list;
>
> -       char watchdog_work_q_name[50];
> +       char watchdog_work_q_name[MPI3MR_WATCHDOG_NAME_LENGTH];
>         struct workqueue_struct *watchdog_work_q;
>         struct delayed_work watchdog_work;
>         spinlock_t watchdog_lock;
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr=
_fw.c
> index 8fe6e0bf342e..18b176e358c5 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> @@ -2879,8 +2879,7 @@ void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc=
)
>
>         INIT_DELAYED_WORK(&mrioc->watchdog_work, mpi3mr_watchdog_work);
>         snprintf(mrioc->watchdog_work_q_name,
> -           sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->=
name,
> -           mrioc->id);
> +           sizeof(mrioc->watchdog_work_q_name), "watchdog_%s", mrioc->na=
me);
>         mrioc->watchdog_work_q =3D alloc_ordered_workqueue(
>                 "%s", WQ_MEM_RECLAIM, mrioc->watchdog_work_q_name);
>         if (!mrioc->watchdog_work_q) {
> --
> 2.39.5
>

Hi,

I submitted this patch about two weeks ago but haven't received any
feedback yet.
I wanted to check if there are any concerns with the patch or if any
changes are needed.

Please let me know if you need any additional information.

Best regards
Bart=C5=82omiej Kubik

