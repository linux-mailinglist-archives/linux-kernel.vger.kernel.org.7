Return-Path: <linux-kernel+bounces-897315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF464C52914
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1238E1899680
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086652505A5;
	Wed, 12 Nov 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjYVqZg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC12206A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955326; cv=none; b=Z0ye8G4UEoDv+nTEricoljJmvPUsFK8TT7rxr20S390HsExdfudxGrS1nbXyHmV9puUDxxYMTrKwCtsvpRxTwwUqaWTxAgb3gedAn5wgtow5phJKOJyKaMndwzbEQ/gOyTTTAPc32clOyYbaHfVP0VknnsOxVsOcEv+nBs6jWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955326; c=relaxed/simple;
	bh=UupzwuzDQTIlF8ERekcrKAAspPk4rB+oINb3y2XwWBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQzlebs0ZgU+LDW027FiCX8daB6HOTFxOlMtxvrBKcVKDC4L0IFie9RA30RzwuCoVk8YOo4euSxmiYQfZVtz4gOXks1PTn1qkTJrB5LXClqpJVEhKevyeEJlijTq0in6bKlAmR981jmRd90CNNh7UL0F67NiJZvTOYv545ob8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjYVqZg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDBAC4CEF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762955326;
	bh=UupzwuzDQTIlF8ERekcrKAAspPk4rB+oINb3y2XwWBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MjYVqZg+oU2HiX8xyAwdRHs3jbvtWrQjZunGsPBCJBL7Ieia61wj+mhqueCdDfguz
	 9l8/uf7VDdsG9U9NANpZFla+8hpjm7UsPdR/px1Vzoj18yTGHAd4jDqLCGvPf5oLyr
	 s7Vzo6hjHHMHB6nvLMDaRCTmnLYfm0w28i04/uR/GB2yuYFCRPgAMql3z2PibDCgNr
	 t+sX15Kg/4KX3ZKwsuLITKB5ZobEgAhVnEEDsdHHk8Q2leeJB7YHHtSAx9z/0A5eqt
	 NWOSlFxZ73YSObbJ1x7RU1V55Y0xWPWXvG3ZX3CMY8SBcMBFqjXaFHfnPZf0RQMJRn
	 MI675vJI8JD+Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4500a6fb71aso339264b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:48:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhAHJU3ScKHAqZCmhdTCaBfu4a9HvV6at4JlMS52aLCNuCOawaAEFBbBNuuQMYESznaiJJsMxWrptBzno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcmOkJs3AMLdR6kmf9P27mb+PirCjbKU8r2c8YUJ+zLBLNERj
	ll+lYHfqRVUPEPyXJLgHnq+2nK/DFnlKGokmBTmJTFcHN1kG1m3VW3ikc5sd9tmQmloQjebynKB
	ERvIhVyuLjj0xaLGUzbN54ChdJ04M+ss=
X-Google-Smtp-Source: AGHT+IGDqh++5mO4vxpL+UtRKdRygxmRgFVr9oEectFHHfmurMlaujZgebJq0jJqAOEPTsy1WqdIkzN029z17447DbM=
X-Received: by 2002:a05:6808:179e:b0:450:65dc:1fce with SMTP id
 5614622812f47-4507441cc5cmr1376699b6e.3.1762955325415; Wed, 12 Nov 2025
 05:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111075000.1828-1-vulab@iscas.ac.cn>
In-Reply-To: <20251111075000.1828-1-vulab@iscas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 14:48:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>
X-Gm-Features: AWmQ_bk1OtoViJsh_Gz_OIDUPRn5Yz6j6sfg-o4S7l2AUgwAEgtb2oc09fm4-SA
Message-ID: <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
To: Haotian Zhang <vulab@iscas.ac.cn>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 8:50=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:
>
> acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtain th=
e
> parent fwnode but returns without calling fwnode_handle_put() on it. This
> leads to a fwnode refcount leak and prevents the parent node from being
> released properly.
>
> Call fwnode_handle_put() on the parent fwnode before returning to
> fix the leak.
>
> Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmware =
specific locations")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/acpi/property.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 1b997a5497e7..7f8790e8dc4e 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1714,6 +1714,7 @@ static int acpi_fwnode_graph_parse_endpoint(const s=
truct fwnode_handle *fwnode,
>         if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
>                 fwnode_property_read_u32(fwnode, "endpoint", &endpoint->i=
d);
>
> +       fwnode_handle_put(port_fwnode);
>         return 0;
>  }
>
> --

Andy, Sakari, this looks like a genuine fix to me, any comments?

