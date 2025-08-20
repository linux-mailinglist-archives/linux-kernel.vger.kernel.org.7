Return-Path: <linux-kernel+bounces-778533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469AB2E702
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFF9A26610
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BFC2D6E53;
	Wed, 20 Aug 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbnHXcLt"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2811E1E19
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723107; cv=none; b=aS3qzZcTXUjBXjsWNIDk0KVJJ5fJP0RUBzWlKVOrRTBc+Hl0Q6HSJ+dlPz8vPMFw15jymkAJognaodSIkaIkaMNYzTXz21/wZ6Mo6YjFc+8K+FDPMWEYIF+2neuiUs6eaN+jVqWIunnXaj/+EPfq7ov/gRLoi/ZIo6MtASF9Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723107; c=relaxed/simple;
	bh=4Me4vXB6ODQcABCgWDh4HsPJQbjccLI/Pb+fgV8C0mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLzIaDb7cm1g0qQrx3HrDMORsLBJAAho678OxZJN+NreOs/irEoMgpneLt2uFWGXoyYz2Jvw7qP0yuRI2tW7qNKO2CoT52Vn+sd9ulFlMnXky5r7uXfMcZPpWPacw4ikMh33DDM3uB1hjqkUN4LArFk1WIqDoj3v74k42Cxy1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbnHXcLt; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b17552198so122841e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755723105; x=1756327905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHKTS5mcdAuJ/6so1Fu8wdD7ErgBomd6S6kgDOCUXZU=;
        b=DbnHXcLtN6GDsWB/mdLpf3DnLrSfDzNaD5zFsYrdRJ+ITVbeP8RUBsyosznM2FdoNp
         yJ8xHkPzlb6f5qMF3TZy22gZSqCZZHZ64V1+qDQJozkqtWlfww9nIejuo6YxKd9vntU6
         I4TNGAoOTG0mOVXkMOy+ifxe0SqdOMv2mKEZ39YyD0WXyNhaESnzRaM3x4YTFqw7bCeQ
         kjGU215ShHofDx++MTo0YYBQixXans1Bqr1zYd5bKB3A43jrbYuHobPhQ1YHWMBda4V+
         35EX5leB17OhozBRBlYtgq1mg6NIxZbq3W6MVR3wgP7ED/zyDzWC4sUpmVZJ79i0aRQp
         /Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723105; x=1756327905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHKTS5mcdAuJ/6so1Fu8wdD7ErgBomd6S6kgDOCUXZU=;
        b=vEvegKO+s5vz9r6AwxH17IA7mfceNZWmRwREAkO0tuN4m56vQL4FfLbxVDnaOg5cVp
         cQvstRAuNws/eMfVZFR2W4Olj6puDiimkJ3hqakCp+PT6ktctTYXtUAvp+2ggF6SQZKQ
         NLf6jMhJnOrEmHXZcJpK7BpksQneFUB8T3oIn52RfvERFnNdg2X8+RKIjO4DSXMT+7vN
         Rd24KBbMj0xi0GIHQgYhC+GWGp9cIH1P/lxxG/3sJINNgIlFueqYwGqnclY5Rg4uMtYq
         SodxgxYJb/Z870k24SjHI0AEMAb44/75nORy5ykJ49HTB/pGzNh2AlXx4BBHMsXr5yTu
         wq5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7LdJ7ARAMOGjjQtePIkbRyrhSsbmcYyxhTPb8r+BLzz1IxCirWONJHe9aMfg94Ab/uvLX9HgUwtXypo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzosvzjo/DXmS7gqvsa3CwYG9odrpd5Y/UzHLJMxPMq6L9IkeYE
	9N5r4pz9nXwqVwsCPzs5PbV+XtnGFW/IcF/TCrgPHhaJFm0QAxg+C09H/JAtzTt8s6+R/HREnSz
	LZwaPv2rde190SwK2/DwkrujhjSAiYmiOL5kO59gq
X-Gm-Gg: ASbGncuD2Krac4WPFATOFKgzaO4v3+YNKggEOFP8aB+1s7dqy4em/Q7b4QBlA1J6xsX
	fd8fLRT1kG3pGQKEaWpu3rAHM3qjPk52Jfj6BJLPcPw5lcoHFLwz7qDo799R878h5FhGcigDHFs
	4A7O1SUEPffpQ/UtqN1/xiD9fGUkBF1pibcHXQewCVQeYceavCsG0oyP5+Ritx5/anesx4YQyjc
	hrOSSSKCXhb7qIJVMDWoNAL3ovJ39sPzV0BWLD1krPgKoa6zuPhXg==
X-Google-Smtp-Source: AGHT+IHRt+LiqU1bNcACp//Ntxm7XH/cxrv2iwBUVZFZyViML7tnEwhsGDdj5amh54hAAvisyGyWPi6lYlAI10NScTE=
X-Received: by 2002:a05:6122:508:b0:535:e789:6ccc with SMTP id
 71dfb90a1353d-53c6d48927dmr1310532e0c.3.1755723104602; Wed, 20 Aug 2025
 13:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820192805.565568-1-robh@kernel.org>
In-Reply-To: <20250820192805.565568-1-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 20 Aug 2025 13:51:07 -0700
X-Gm-Features: Ac12FXyG4JVALbMlbPqBRPkY6bhe0gsfl2f_OZ4G16pEP24JNqN5iaa6770dUhI
Message-ID: <CAGETcx_DqgEt0e8ZGikTyLWS+2vaTfz=m3BnZJROgGNcp6CwWA@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: Add missing IORESOURCE_MEM flag on resources
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Daniel Baluta <daniel.baluta@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 12:29=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
> Commit f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse
> "memory-region"') failed to set IORESOURCE_MEM flag on the resources.
> The result is functions such as devm_ioremap_resource_wc() will fail.
> Add the missing flag.
>
> Fixes: f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse "memory-re=
gion"')
> Reported-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reported-by: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  drivers/of/of_reserved_mem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..d3b7c4ae429c 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -771,6 +771,7 @@ int of_reserved_mem_region_to_resource(const struct d=
evice_node *np,
>                 return -EINVAL;
>
>         resource_set_range(res, rmem->base, rmem->size);
> +       res->flags =3D IORESOURCE_MEM;
>         res->name =3D rmem->name;
>         return 0;
>  }
> --
> 2.50.1
>

