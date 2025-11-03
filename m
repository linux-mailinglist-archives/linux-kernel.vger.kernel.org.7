Return-Path: <linux-kernel+bounces-883338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AACC2D1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B79188C783
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E13161A4;
	Mon,  3 Nov 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efrspeYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5827302CB2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187100; cv=none; b=t+K40POjz8HbmnRvyihZbOCFggTs1K/C/wEexaSRwrKQXoqETVY0m7Eim4kKBLIkzkuwrm0V+mRmFkMoCGqyiA1t5fHYiPzsmuEX7bbjU5GJK49Y/b56K5JrypyJ7HLaae8xfuIvxn9lN29rxBe9TBW2nYeh1hQrHAGD5V1zlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187100; c=relaxed/simple;
	bh=AHuFY9xO+A63UmFyS210/4TY04941JIQj5CIWs6/YUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBVUDR0MTx+cgpjcPjZliZv/DxMQiir6AsHJIinUwaOX83ODkKXEy1cRbO/DISJioYap1sy5RUnn0iOY0Ac9NAbYbqP/xpSKDl+Yqi1AfVeUaMp2loukRdBgB7IZqq+NyjF4vKaqR8qV0EEjb83TknNN4+VLQ7VrdEwsxAFRzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efrspeYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88992C4CEFD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187100;
	bh=AHuFY9xO+A63UmFyS210/4TY04941JIQj5CIWs6/YUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=efrspeYYlN91uFxlgNfqcsLywdGs0TPacQA/M8791NnWH3fukwY0rBOeT8+eWTVKg
	 vcvVJsnmrAjXgGTOxVZwfD/nPIdReArj5DU54NLpuTOkDph6G8lF5ms7HET/C0ohIg
	 eGkR8LfSGkxlw6nLgqev8jy0hAt1NJqvkcaQ0QOA01Khv4eckUc315q4RjnA3Z3RxK
	 bTWR60pqdYIg/PTuEFAyX8rpNnPFH3KmEDBhEqGDSraoq6lt+kAS5mGUZOcI6nD5S5
	 66+w+01Yg4ulbM92sZf4jGaBPQ+Xl0L2dfPcU7cq2gNzGdp//k7zhkIPJa2ncqs/Cx
	 grr5xmIJN6/uw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d1cf5c2805so5476077fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:25:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTI2BHqg2h4vds6JRWW9+MF7avdwCDSUJblonAJQ80b2GaJlVi/KuxNsQS2gmEswHNPPn6bIiqEKsiuUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIgI45gr67YuDPJnIoAl+C8yN2edLnQn8Mq5EBe0JpvGtBGo2
	px/RXpGh3C/EaFJJwglcNKxaaVIALKEOWyci6EiqkpDM56yJoe8sFh/Ehu857nD31K5rMap1qzE
	wuEzDMxiifOD3GhjhPOYTYSa1VCPNj9s=
X-Google-Smtp-Source: AGHT+IEf4PcRjvwRSJTmh34zMmlTzmMI8gkWOvhnI9v4RtrHXDFj1hiNW5j3HkHqu2dVd9x9esCxguwYsP5kG9RwS1Y=
X-Received: by 2002:a05:6870:e0d1:b0:3c9:79f5:470e with SMTP id
 586e51a60fabf-3dacdb72630mr6578654fac.34.1762187099896; Mon, 03 Nov 2025
 08:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031055240.2791-1-chuguangqing@inspur.com>
In-Reply-To: <20251031055240.2791-1-chuguangqing@inspur.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:24:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jB4Q=1d6dLLmRrUAYjfT7TcprE0946itrT3gimJEfh+A@mail.gmail.com>
X-Gm-Features: AWmQ_bkLSz07d3TndpqT-Zqb4Lv6xZYP5eBY_GUjapgrNNGkY_nqh5rYNLBHMNg
Message-ID: <CAJZ5v0jB4Q=1d6dLLmRrUAYjfT7TcprE0946itrT3gimJEfh+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix a typo error
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:53=E2=80=AFAM Chu Guangqing <chuguangqing@inspur.=
com> wrote:
>
> The correct term here should be "package"
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ab4651205e8a..6c684e54fe01 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -750,7 +750,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>         }
>
>         /*
> -        * Disregard _CPC if the number of entries in the return pachage =
is not
> +        * Disregard _CPC if the number of entries in the return package =
is not
>          * as expected, but support future revisions being proper superse=
ts of
>          * the v3 and only causing more entries to be returned by _CPC.
>          */
> --

Applied as 6.18-rc material with modified subject and changelog.

Thanks!

