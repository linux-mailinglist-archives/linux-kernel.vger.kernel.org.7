Return-Path: <linux-kernel+bounces-847065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D51BC9CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636263A1D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301A11E260D;
	Thu,  9 Oct 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7mMO3dD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C91E0DD8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023534; cv=none; b=hQUmdETW9LtfG+K0whIb7Iq1jZKCHoaAObExnaLyHBHKIrFo6Aic1M+nPV9KVr0aV+zaNg6iD1MhkQwwA0oDJE2OyIN3UGaxnI28oKgXGzaDg8wvTBicYatDKy3ox4jelOsjbdIB6DTsMOjCOi7/t3DFbFhwtvOMt+LwQTRHmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023534; c=relaxed/simple;
	bh=/ups0rdcsbhtlWRIsVepwZKH+PzYyefCRWijmztsG38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSzkbBu5CbJnQ/k3cKJ0NuRBeJBusIjzbNlrfB59VFgGxOkF9ZIEd1ubwQW4y5mePxmYK9NJjW34ouGDxusMsfDEFMlC24MwQ4plq2UGzA6hsonPyzRYK1FuAHT5Ci97PVQN4baVeNvek089mO0rchJYWyv/AjBgxJNMCDI16KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7mMO3dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31115C116C6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023534;
	bh=/ups0rdcsbhtlWRIsVepwZKH+PzYyefCRWijmztsG38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i7mMO3dD4j35Ge3GxNo6uQLuK2DZ3HINxs+jtEN1TGybsdza808OOeUCgY08yrXw2
	 VW6iyAbWT5OjTYZ5Iks2S6OStDkve2UCSr2EFsO+OvKnl22+5kNKrWodjdeItWYzTr
	 7qN0wDtL5Te9tob1LD7s0V73vgMq1GyAFJDHC7jWUgUL37JLv/rZii6WeLWj36xF7O
	 vZrOz25DBOpiuvWD/P4chTnEkxVdrH4S7WPvIcDQQBRZKJfeYFniRHsRY8zbmHTxSF
	 gYswlQC9SuCaxL7ENnANCVGw9pbs7KjtpirZT3xX7v3WQojMqb2/A9W1cLn/sNjm8E
	 YfQxYWbAfvabg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74526ca79beso693462a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3Gx9guz8u1A2v6ku4YcWG9J4a4SDqXlaSMnxIZ9gOFe+vG0H6xacdHlqGsYeAaqCV2UhRvAE+HTnKOGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnMDZnK/1RLG/Rfedb0pXU6dT/JUmLoIsC0o11hA+6G+i15Eh
	SFavftamugV9H4cRcAFnLr/T0Zn8LjSDgB8O0PI+NhhON/CjzR650oXqfMyS71pv96SbaSaqu8A
	QZKFcTdoqOp1YDr/UvmyqbojXdb9WzE8=
X-Google-Smtp-Source: AGHT+IGu70IFZQLlAO+3P4ybkBQVr1fPOMs/nnzKxe/rtOBJ7ieNtBACYGLI1c7T/YNJWaLDapxP8Kyk8iZDzISReqM=
X-Received: by 2002:a05:6808:e88:b0:43f:b7f8:e216 with SMTP id
 5614622812f47-4417b2d1e98mr3887324b6e.4.1760023533432; Thu, 09 Oct 2025
 08:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009135646.8899-1-bigalex934@gmail.com>
In-Reply-To: <20251009135646.8899-1-bigalex934@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 9 Oct 2025 17:25:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itqy9dXoS4ubq3MPdM2zCBQKah3R5B2SGiJE6auTugBw@mail.gmail.com>
X-Gm-Features: AS18NWBnRSV55ReCkktNys3L2MAhOlsiQ_YiADq19oGN-jfD9E83LCPjtwGrdHg
Message-ID: <CAJZ5v0itqy9dXoS4ubq3MPdM2zCBQKah3R5B2SGiJE6auTugBw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add absent field_obj null check
To: Alexey Simakov <bigalex934@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:57=E2=80=AFPM Alexey Simakov <bigalex934@gmail.com=
> wrote:
>
> The acpi_ev_address_space_dispatch function is designed
> in such way that assignning field_obj to NULL is valid case.
>
> Cover the missed execution path with this check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special contex=
t data")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

ACPICA changes need to be submitted to the upstream ACPICA project on
GitHub as pull requests (PRs).

Once a given PR has been merged upstream, a corresponding Linux patch
can be sent (with a Link: tag pointing to the original upstream ACPICA
commit), but it is not necessary to do so because released upstream
ACPICA material is automatically included into the ACPICA code in
Linux.

> ---
>  drivers/acpi/acpica/evregion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregio=
n.c
> index fa3475da7ea9..fa01bcd3840d 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -163,7 +163,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_obj=
ect *region_obj,
>                         return_ACPI_STATUS(AE_NOT_EXIST);
>                 }
>
> -               if (region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_PLA=
TFORM_COMM) {
> +               if (field_obj && region_obj->region.space_id =3D=3D ACPI_=
ADR_SPACE_PLATFORM_COMM) {
>                         struct acpi_pcc_info *ctx =3D
>                             handler_desc->address_space.context;
>
> --
> 2.34.1
>
> Just FYI, this patch was already merged to github ACPICA repository.
> Commit hash with correspond changes at ACPICA repository: f421dd9dd897dfd=
1e0c015afa90cd0de2464e23c

