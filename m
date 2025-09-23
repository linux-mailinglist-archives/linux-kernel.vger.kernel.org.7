Return-Path: <linux-kernel+bounces-829025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F92B96114
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5262E2F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D41A5BA2;
	Tue, 23 Sep 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRg6WQx1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B517A2FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635264; cv=none; b=FP3TMwZx3NAZ99eTv9ct0IHGgH/fNzr3BP51z7iUY3SUdulNEtlQeGEZllORgfP75wqiPhQcJL2vJSEdGX1bGCG0UPsdTZJW2IwtY+MQPqiDHppSXAJtXi5uXnosCCI+SoQmw+eG21q8C7VnyoVOR7pVVqHgMXrX3S54ZxnqZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635264; c=relaxed/simple;
	bh=PN5La3hlg/fG/Y0BOwtDWuC1k9ri0pHOmQFdLr9on8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqIs5ySG7iOKMNCY1RFnEYl0D+S+pA55Ii6ofJ9firpsR8XmqSly5xEahDhK9vAnyM54QM/FQ6w6EeQ8cuY4Tn3tqL9vNerxguHhOWc0FzKcTlQAm96CxlAoIaYn+9qjHvDS03to5a1DELuukp/33PgXQvyO2qUmb31fUc8OWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRg6WQx1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso935067a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635262; x=1759240062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+po0DuJ8bRdPzzhrYcH1IZFck7dYEJX09rufKPUvgM=;
        b=ZRg6WQx15pCYOZjyf2kKZhNeF7/MA9OBKxZkDWPMiVxl/w9fH0DMWu5iY7n3JTjVyj
         ewxx2wvWBDN6MFvYBY2iM/6rMeJa3IBDywxw7LaUijgazx/RXJo4Xb6pbrjV7erpkHND
         RIRnE5cZLkaRqr/ra6+yc3vfPYGoyRBU5W6ESQ0e6CDeKTfzYWzVZF04q2RI6iTRgxP3
         XZdaeB0LMi6KEJh2cTFPs5JUDFO2W1jiP0K0Ae+7PkOpMr++RKK/zh3TFvnQ/f0OYQMX
         iyVc4nkU+pZwkBJvSuR2vITgzltUXb9b+okUOl2qKaveiLGjb0GbJ7oXFPW0qSct+R5V
         FEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635262; x=1759240062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+po0DuJ8bRdPzzhrYcH1IZFck7dYEJX09rufKPUvgM=;
        b=jrf18uL4WCd54VWienN+xiIdIa4xCeXonCg97uE4vxCpA4UdQU/iX1aoI+w6IeFDdA
         7lNJmhnqkKZ6dOV/amBCtjCibZiY9wQrolS7ds3NspjncV+b2jDpo8MpHcJ3A9YK1bKO
         j3GIMRN+0xLIa/JpCCGk8WLw2sED0HBYphP38c76XEMmVeGx2lgpiDFJSgyoEHlterr/
         F4JI8Y4ncwvITXgOQfspR4IsxRDCZWbgV98DTP/AH54aE+JJiuqDBbG9hGbS9v1uW+Dj
         1XJNErFHFDyv3cM/vrgTbo01zAXizWCAQJbI7UoVhkokuN+PvzjM7I+gc9/ZHnNPkuVP
         RcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfG/B+rTmW/ruWaEtMu+6OPt4J3HE4cEurMp2M8s/j5t+QjUU7wPc/GWnjqTrfZ7kLe65jUARf0x4IBL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz125Sc2GbbefjVkyoWmAf/pBJdolHSZ4e6+jKG7n90biehNDvi
	NanvKQt1gjokt2pxJAuboRd3VlNMjLQVQIxgxUmwXxL/MyjCdzFucpsm3QSmgEC0NBQiJkFVT5C
	jo17xABYumCaXaTwGnhRBcASpR49Gkg0=
X-Gm-Gg: ASbGncsVwQnX/sFa6tyjUBfjnW9ypX6xrwVttffU6370u6SUypELJeu97PMljNRAelX
	BwLCG6a5HzsIxlcNl4yzzWcwoQYhI1UtJAFnPt6cLIDHNnd4QCMR2UYgCFhqjloEbWJ6/KNpQUn
	wcKPzzPHuT0rxeRY+I9aaT2GP3ukBDarMY7r4iMm+1XP7W8fP57mjmlcdU6c1rWKtjeGnqwpFAq
	T5SoS4=
X-Google-Smtp-Source: AGHT+IE/H1/LM/bDZyCRJ1SbbgyS89k2lbuqITBp5GxChyBOLUjXoVdvHa8Vm07RnfxnHIveQ+ckEYOUfRTxnACyGUg=
X-Received: by 2002:a17:90a:e707:b0:333:abc4:379a with SMTP id
 98e67ed59e1d1-333abc439ebmr456440a91.4.1758635262421; Tue, 23 Sep 2025
 06:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922185635.50828-1-smokthar925@gmail.com>
In-Reply-To: <20250922185635.50828-1-smokthar925@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 09:47:30 -0400
X-Gm-Features: AS18NWAhbcwLf_A_aG2ayW-fXVW1NiLJzl9s_xqIndnigSUTJI1g12Ie2ZqAKe8
Message-ID: <CADnq5_PnEJYpw2Zu9hPVoKk24YBmZfcSNst=Enqd899eLvpWOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: use kmalloc_array instead of kmalloc
To: Moktar SELLAMI <smokthar925@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, Hawking.Zhang@amd.com, tao.zhou1@amd.com, lijo.lazar@amd.com, 
	ganglxie@amd.com, victor.skvortsov@amd.com, candice.li@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:14=E2=80=AFPM Moktar SELLAMI <smokthar925@gmail.c=
om> wrote:
>
> Replace kmalloc -> kmalloc_array in drm/amd/amdgpu/amdgpu_ras.c .
>
> As per said in the Documentation/process/deprecated.rst, dynamic size
> calculation should not be performed in memory allocator function
> arguments due to the risk of overflow.
>
> Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>

Thanks for the patch.  Some already supplied a similar patch which was appl=
ied.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 540817e296da..8dbb9e349a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2566,7 +2566,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_d=
evice *adev,
>                 goto out;
>         }
>
> -       *bps =3D kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KE=
RNEL);
> +       *bps =3D kmalloc_array(data->count, sizeof(struct ras_badpage), G=
FP_KERNEL);
>         if (!*bps) {
>                 ret =3D -ENOMEM;
>                 goto out;
> --
> 2.34.1
>

