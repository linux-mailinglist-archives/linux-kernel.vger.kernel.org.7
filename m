Return-Path: <linux-kernel+bounces-885022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516DC31B49
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B499234A1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E71331A6C;
	Tue,  4 Nov 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C43sraVb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D125228D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268470; cv=none; b=HZpU4cq/KlgsaHWcq4+sLzC06eUlAa3Ziywz6wLA4lWObjvu0txpIWJWz+vziOENuoC+tsmNNCZLAPf+5XeTobwlvHaso0W4LxlKtsruaX6okTrgjdSMUvnLNoUHipG4shvR6A5BYQBwCPp7u58m9WFdPLB1UMP1bfTfJeD0weI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268470; c=relaxed/simple;
	bh=vZN2WJV0Mbm+dI4WIamqbhYw44ZHR//AxmMEtsXLh/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RASKVVcBlKwD4HOTpo4/BhylGsIbVQ4fsEkl+5J9eKxHBJg84dXQj+DjtAYaXDoBAE9xV0iL+EcfVgZzndj/RPmF3R4mbO8UgKQFrVxz8XjEU7fZjcX97U9kknmj/MBSeAC1TaxAPDzsz2ckV6tjHe9QZ9yT0hxMmGv1qPp6p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C43sraVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043B6C2BC86
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268470;
	bh=vZN2WJV0Mbm+dI4WIamqbhYw44ZHR//AxmMEtsXLh/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C43sraVbyDY3fjAnCgJUnJETUt66qVBXFdY0MzpfrY5dfY8w9WVdSDgg8x/cZs3Bv
	 NyCslddAm2+K0IfhTH57IHos1xtNyVNTHlduHj0mgV1xC4QaW/5rk5s/xOJsyK4SVT
	 O2xLCR6E2uGR8ElLB3kEC9EvV8JYgRJvzXno4KlRSE1u0q5oZDjHbBVV5/rQ9N3slS
	 c5ZdrnWeBr7eztBsJEF54eR7dKY9eAJ4drm1bl4pUS/tsNACKSmDJcKiYS6qWY8Hk1
	 O70iYT2i3Fuvg/gY478DmxY/6kvwaqNQkBsMNkfLB4CH+5Gjb0Wta7gBZ+w0y8kkFD
	 Plfu3AdaOZBww==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656b1f906f8so392475eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:01:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw1hll9V+0+jituyr5HzVbJrpKy0OZZRCykiyWnF/QU9zimTnD/VJ90bkqrY/pzfXa55rJXnuu/wkUYtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1opaAejqZu2m/wA7yfkWF1F62FjaDeSiUbwKR/sqnDtjKhM7
	wqdZFFi22FRFf/L96gpOg757ixKy2CJhv8LcpRTarHgPFzJSYntgTvcljVvc429xAksTu1Hop8t
	aPoVSK/HtPcFuQnljCqMe4BY9JNDQbMQ=
X-Google-Smtp-Source: AGHT+IG0H7lfrUrQtg/Rfq3YQ7x41bofCSJboSYU30bARQKyyk/7O7Q9eQ8j8vwMbjqTwVyluCxazQdyRIxtR1npygI=
X-Received: by 2002:a05:6870:478f:b0:3e0:ffcb:2f84 with SMTP id
 586e51a60fabf-3e0ffcb3186mr519281fac.28.1762268469241; Tue, 04 Nov 2025
 07:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-2-lihuisong@huawei.com> <CAJZ5v0j5_+gOuuW8PdyzjOJ+Q__k9PrpM3X6=Q0d50u+d8SPpg@mail.gmail.com>
 <53a38563-1151-4e2d-8932-b5242c68bf62@huawei.com>
In-Reply-To: <53a38563-1151-4e2d-8932-b5242c68bf62@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 16:00:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htRKzEhe3yWC52tnJnDBwH3U=ndWX+6ZjguhstuHcWhg@mail.gmail.com>
X-Gm-Features: AWmQ_blVYHl7QWqOCW5A8V0yb9eY0-9-gXECIQYhcjkv7_d4dXYKeX_wZCMx7-M
Message-ID: <CAJZ5v0htRKzEhe3yWC52tnJnDBwH3U=ndWX+6ZjguhstuHcWhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ACPI: processor: idle: Mark the state as invalid
 if its entry method is illegal
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:30=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/11/4 1:49, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com=
> wrote:
> >> According to ACPI spec, entry method in LPI sub-package must be buffer
> >> or integer. And the entry method is very key in cpuidle. So mark the s=
tate
> >> as invalid.
> >>
> >> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power=
 Idle(LPI) states")
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index 341825e8ac63..9f1040eac051 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -956,6 +956,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle=
 handle,
> >>                          lpi_state->entry_method =3D ACPI_CSTATE_INTEG=
ER;
> >>                          lpi_state->address =3D obj->integer.value;
> >>                  } else {
> >> +                       pr_debug("Entry method of state-%d is illegal,=
 disable it.\n",
> >> +                                state_idx);
> >> +                       lpi_state->flags =3D 0;
> > Why does lpi_state->flags need to be cleared, isn't it 0 already?
> Good point.
> Do we need to add debug log?

Well, is it helpful?

