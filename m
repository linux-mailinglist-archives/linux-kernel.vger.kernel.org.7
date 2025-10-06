Return-Path: <linux-kernel+bounces-843304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA24BBEDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79D7C34AC06
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2DE248F58;
	Mon,  6 Oct 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGopF/qP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D817DFE7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773641; cv=none; b=OUwp01o6MrrK+0k5vOgZ34D6eX4tNojDyMXrkG8wj7FjjOws+LXIXoDbVzCvcWGmVg4KERhvQWPLJPa4ya787HaNwBNvjIBUev1StMwgGwXrD7GY8gTo8/6XbyVIZr8v7kvqyQ7Y21g1wEidJiMRqUQZ/ZTvdaWyhUYWIvCUqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773641; c=relaxed/simple;
	bh=0GEMNRcZziGzb3s681pgK1hZuY+IKAUR9TQA+X75qiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7yzB8I0BUrA6ia4EdPIRj9r3jIn/rkQK8yGTIUBZ/Y35JoQOK82quIcWGwaQeH+J1JFxbseNVO7ycVbFI4pv7+djyHw+nrLxRPpMbDKmfEBWcIn0Fvi5bQQ/EIIneddREm5PXWzukGmO0FSkhWvic4WLnIfG659fgtgxU6OwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGopF/qP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso10976589a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759773638; x=1760378438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inbCGeX0MlCaOTe4pzWEAkquVwCrsIcfcgv0X9AXOR8=;
        b=XGopF/qPtyupbN0LE08URXj6BA3OCXBI4X3IA99iabFOuSjMJHI/cnVZyuud7W7juJ
         2IVLb3DxuhxwCLM76sHpS8JGl2AgjRh8jhhSJaVyE3OChfepX5Ye/z1eljXWGlsREGYD
         rBdGcsoIEZ15Odw4mwYlo6pmtItN9ZaSfeMJWBwI3qw0cLyCD8lkSPfwZszZx7Tu7/T9
         IYRTsEJFZ2nltYgmyjO7z/5sOYYvuPv3ke+37ylNK/UaNbywR0O2uZy29vaFLSW4Trzx
         uKamB45KFXxym6plXieuIeFNRSHiIATxLWfvQcNcLKGGwbTvSl3bV+sA/J1U0B5IJSBf
         ntfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759773638; x=1760378438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inbCGeX0MlCaOTe4pzWEAkquVwCrsIcfcgv0X9AXOR8=;
        b=pzTYSaC4h61MgaeHr2cS6NjyD9Ol5IkHHp3sYWA9YmsBy/VCqlI5jgSvB1o5k7Ndd6
         vV73Ugi+3V1cf06Xav0IuxbDBhC4zYLwVjsoCqGSUVxV2xUSW+uHUEp3jEkDvTQ4k9R4
         7TkIeRLUtV6nEYrJItdvNmcIPt0mrfs4Zj5EhL01xMtAeNweEPdL8W7MQZqDhKEScUl+
         sl6W/8aYacAlW9ne97+zpcg6QdFb7G4NQPIEXVer7vOoEKN/ch7OJ4hUm2Ma70Mblkes
         5EHF338tRDSrH3jO6xHnR9vbm6bgRYWPCyZ5WjR6/XbAp1iqJMU+T0srdVR2B7i4J+TO
         oeQA==
X-Forwarded-Encrypted: i=1; AJvYcCXqpm05EWDqQJOz93hsrvmhIhueajGdxecwq2jrdjxs5eGrEWIxz2FNRsgb3dI6ZW/e0TZ6nbcqvC5A4Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPElif/Mx2mwypgQSQ/S0VxDAtAic9/OeK9ihUAfhI2y1Dxkp
	y7ZYXckd2aJytJW7CJYqBouHk/KXWF4V4ps8yegzFBLaht1DNRjv547QJmkymUEDXLz4yanVGXb
	70f/+gzldnwwh5f5kzDvA+BwCVAyEw+Q=
X-Gm-Gg: ASbGncsVF3WYWXSznXkJwp0X1thcxMQcEg1/re8cwF6JdEUVWm22mY+/dfEBzB1yNYc
	P2UhXyFsGQ74/8rDWkcMAKp86Z2h1D3rcm2daeMMingMLQ9eIZolQhJoC4FU3UKMCi/l8iJYC4/
	EFdVZMbOZeixzu4GEDXwxat1vXPxHFs0Pgn+LySe4YqaZN3KZnc57yvI9l7F1JD7o71WXSJjYMG
	iiypSInC5ZnGnOFAjDYXio0uGQ7vI/zhwjzHSmIZup1Ef/8AXTK0hwNyw+EHat28As/hU9IRmA=
X-Google-Smtp-Source: AGHT+IHc/KM682jYWj3WvcK4lSK7EMboJJkdUb1lxllQSBBYt5rLkWpEgXxcvdPFJR/OuHQrWNQ0UC2LN9vnzduKPDI=
X-Received: by 2002:a05:6402:354c:b0:633:d0b7:d6c3 with SMTP id
 4fb4d7f45d1cf-639348e53b3mr15040695a12.5.1759773637242; Mon, 06 Oct 2025
 11:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
In-Reply-To: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Mon, 6 Oct 2025 23:30:25 +0530
X-Gm-Features: AS18NWBipFXoldgwotbv0EXeAnZgq5bGgzj04ZlSOSM0MjF-bQqudelsREmIC6Q
Message-ID: <CABPSWR6B0M=nos=wBpjidXMPVYVDKYi0i+-ufuR460_m48vjVw@mail.gmail.com>
Subject: Re: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The
 num variable is set to 0. The variable num gets its value from
 scatter_elem_sz. However the minimum value of scatter_elem_sz is PAGE_SHIFT.
 So setting num to PAGE_SIZE when num < PAGE_SIZE.
To: Kshitij Paranjape <kshitijvparanjape@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org, syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kshitij,

Subject line of your patch should not exceed more than 80 characters
[recommended]
Please check your patch format.

~~vivek

On Mon, Oct 6, 2025 at 11:17=E2=80=AFPM Kshitij Paranjape
<kshitijvparanjape@gmail.com> wrote:
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D270f1c719ee7baab9941
> Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>
> ---
>  drivers/scsi/sg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index effb7e768165..9ae41bb256d7 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1888,6 +1888,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * s=
fp, int buff_size)
>                 if (num < PAGE_SIZE) {
>                         scatter_elem_sz =3D PAGE_SIZE;
>                         scatter_elem_sz_prev =3D PAGE_SIZE;
> +                       num =3D scatter_elem_sz;
>                 } else
>                         scatter_elem_sz_prev =3D num;
>         }
> --
> 2.43.0
>
>

