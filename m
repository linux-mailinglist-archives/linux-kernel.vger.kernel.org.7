Return-Path: <linux-kernel+bounces-866657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320AC005D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EB864E069F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CD3016FA;
	Thu, 23 Oct 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk+Q/JB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720D2FE06C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213521; cv=none; b=X5uv5l+My8ijSgJi8hQz5iPDYJNuzUGtRAAvZIan6+6pN2Na3gp40YUzmH2JBSpBVAVL57E3741jslzlsddXschxzHyBaqn2Dg6AssE18PIrWUGTVbbFi++pvgINFrnPzpU8iBckm3+McvMrnF3crfherI1HdDEpTvFSxHCJhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213521; c=relaxed/simple;
	bh=pwjiA1Q+1S/FGP4Sxt/IPwPCyI4y5DF05SO7Pb7pvH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6MZIYOmsTd0zzFhMCoWQzCBa0yJk3jyvR528CDchn0lhbbQAisbjxzyaDpJTmKXXn2wG1mPxtbEe9Ye/Z8SzBUZ319qkMsBll1FKAmNX57fRaoWIeVdIyP75BgjfSBKXW5Tpy6q5x/yNm1H4uNhiu4QtATu0EGodOgoNLyQ1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk+Q/JB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F91CC4CEE7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761213520;
	bh=pwjiA1Q+1S/FGP4Sxt/IPwPCyI4y5DF05SO7Pb7pvH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zk+Q/JB0cQwUUluZ6hLANob0vWcgVYF65JEacy8XkrfyTJ5VBDQJJ5pfiUfCzBEqz
	 SeYBHAfc6RY16lTZNhlL6FHOCFeaVTw9pRfn6SZScZ0wq+E9elgVqa1YdP/dCsa4Bt
	 SVTIImma1hmWDiSHTSjJnRDARTsmzH+80eTMRTkB6jmXBEMQgIKN2SVyUcPxxkS3kn
	 MGU2jKyVz1XCk90Lgi0wK0ZzhS5GxNia3Lq1kQ2YOeSH0NtWSBVeAmg+mJgldJJNqK
	 0gL1at3Jgel1VHdbQzXYUJhDatTz/yFVS22hpycJTC8pr0qSMaOJuHXJciHrx498Z+
	 HBlOS7jywaypg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4491510f005so158282b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:58:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFupjtfKoq1MsKn6iymuP8mazA0UGwMcNMFk9lAqVthG1neWiYfq0w2MFarh8W1+91UK5P8A1vMkJHyGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZEIB3xp4b6hKZ0jXA8N5nycC75wZyPoKuOTU1oBBdNGidD5G
	qUGyoe1//fvSr2ETU4V/1n91YbTnkX18fAsvc35s/6Z7Z2kbBbU0mL5qiq+TuNj76eUGPKN9hFu
	RaEVqcX7Elt7CEBYL+e53hQzu4PFW1Fw=
X-Google-Smtp-Source: AGHT+IF6mLk5QxDgJRgmUD2SQ+TwUZbHqxeypTmarAHulyh/ocsnGm49ajtuq2A2H6gvv4MwmBsWK0iQm2vCRyux+WY=
X-Received: by 2002:a05:6808:2f13:b0:43f:5d93:3e3d with SMTP id
 5614622812f47-443a30b194dmr11083560b6e.35.1761213519920; Thu, 23 Oct 2025
 02:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022204523.10752-1-tony.luck@intel.com>
In-Reply-To: <20251022204523.10752-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 11:58:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
X-Gm-Features: AS18NWBLqkSgQM1_EReJZN6QIt7t3F9hVfjKrizmndBRdcttE-en3UVt8DVlzpk
Message-ID: <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: MRRM: Check revision of MRRM table
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:45=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> Before trying to parse the MRRM table, check that the table revision
> is the one that is expected.

OK, so should there be a Fixes: tag?  Or is it just a tidy-up of the code?

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/acpi_mrrm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 47ea3ccc2142..a6dbf623e557 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -63,6 +63,9 @@ static __init int acpi_parse_mrrm(struct acpi_table_hea=
der *table)
>         if (!mrrm)
>                 return -ENODEV;
>
> +       if (mrrm->header.revision !=3D 1)
> +               return -EINVAL;
> +
>         if (mrrm->flags & ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS)
>                 return -EOPNOTSUPP;
>
> --
> 2.51.0
>
>

