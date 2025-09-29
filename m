Return-Path: <linux-kernel+bounces-836338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CDEBA9608
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DB31C1BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7693074BB;
	Mon, 29 Sep 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Yfmrrfy2"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DE30748F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153284; cv=none; b=oqUlXFSSp/qNrs6nYZbxYrfYIvW+VzTPfRnkzlqqePzHwyIXvndTh3cLOqL5+yVMiRhzeR8wmOrwymedr+mYgJI0+nGoqmZ6rAkOPUAQMYTVBaH1gZf+8EmhChpJaoF1GS28W7dQbRCG8sR3+fXaEKdOYCvXQIXGc4tYHrctjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153284; c=relaxed/simple;
	bh=5uahX3/t/qKl+AWu2lHhkUSygd0Oeo7v5srfItKOpo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVNV8qKJkN8xfXv/2FjQ9KIj6u9Qpb/TFuYaFdF5iXiqLpXZlhlyV6RhqxKK17cYNfW7+asnkQa3U7+ulNHbm3I5AolLotisjxCte13AehPXd333qWzakaZNNxUtcHIthaBYcpoyxEhT48XuOTKPC+bz9HXGXe9dKTNjFsMUN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Yfmrrfy2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57e03279bfeso6576087e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759153281; x=1759758081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uahX3/t/qKl+AWu2lHhkUSygd0Oeo7v5srfItKOpo0=;
        b=Yfmrrfy2+GMnQBf9zFdyVUDEWWBk7u2IspZC66fvQ78A1OHbwndRgBelIasgsZpbpL
         Myh+TWMFO+toEbK+5IE/UW6n3CRi4rpIoKJho27gz3Yp+1um0S1UYJKGmUzyM3TRVZbX
         a4W+eNLF1Ep145PoknDbfr0oqYv5FrdInBntIkfrZ48eL2YuJnvPi81RCCPrT32tIbtO
         Tj/vuH2BUk8mCzL/Z6O9F8NOCgAq9xsg8knlI0Fea5zcpL9O1J9ZKrRG8CvXjpG62Zyw
         2mDC8jahuA1b67ayY4OTaO82SbTCBPUT4KxWBXuMIpdBMmukJervGKJwOA5gj8OtkR6C
         3GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759153281; x=1759758081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uahX3/t/qKl+AWu2lHhkUSygd0Oeo7v5srfItKOpo0=;
        b=kW4EQ9fkUgLZW7suLMLluPMD9L7DR46BFyGqAlyBmuo3/cUgYKsB5C2RJQOABnjufN
         z3CC8OzyeGwwGbHXUN/0ZyZl//JgJCjUCj2GIVhAqffQJdz52RONeEOBE3rgKrfGbrPf
         jk2uPv5G0ntf7nhtRcTOU9QBgKMgeXZJCAgjU3wM3ai6a9QaIJbhFJuOu7Ulq1QVyF7l
         FC/nw5Rlmbn+inqSlVDhKeEjfBzpAOoeF4RgRO+xd/x8tirzWHENuBcSxf9Naw4ecVJr
         ydXsc5z/c/Ce64GFHjVXX3MA2YCvTvw21JE2+Dj9moc7S6S8GfZ9a1L+mnedvBAG0jhV
         cUWA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2InfmzIDqmWTwG+JYb/cnEirTEDcAItZJxSBOMrmRgLZLxClL0bmfwGO8fdTtRdi8BamizolTT2tekA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMu+bDHI7P4nOS1nHTBLkNbIQZh5bpAnIGCl0iEji4bLIm42P
	tRzaG/PMpBmanQL5Ve1qeSXYiNvnxQMHXeyK5o+ZNvy9rL0p0pDwxgxgNoQv73AXYlU8sLeo2dE
	K6zUScMA1wvNatHixYQf8EQTYLgy0BsbAiycg8l4epA==
X-Gm-Gg: ASbGncu5LGBtUhxuOiMh34D5dNaA1b9LTm/Cy6U07eknad66V9hn0DPkMMDNR1joF7m
	4GnOrYuOlmFrBMBvdh3HGO3gI8nx+GVE1MSzSJn2VqOAdks7S6iOKbEGLqLfpbBrmnO+b7K6I0j
	B9dugRAxVKYN24xrxPF6lEMAbtrsqLxnywqtGuwPLIop5OWQdXPxcTJYaKSt7ovjRieWgHwzJ/H
	i+rpY9NWHnXoHE3DELrEYMfEawAYygOZl/JQb0=
X-Google-Smtp-Source: AGHT+IHVwcUt8n2Dr1HYLUuIj7lg91of8OCj1ZiQGHG98cWyZH+Ddd15Wdp2OohNipHuMRCcT2tzkYcUlRcdG1A1CM8=
X-Received: by 2002:a05:6512:304b:b0:57e:3273:93a7 with SMTP id
 2adb3069b0e04-589842801c8mr179708e87.21.1759153281232; Mon, 29 Sep 2025
 06:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919093627.605059-1-kkartik@nvidia.com> <20250919-undusted-distrust-ff5e2f25cdd5@spud>
 <f6c001af-bfaa-4d1a-8c32-1e2889e78650@nvidia.com>
In-Reply-To: <f6c001af-bfaa-4d1a-8c32-1e2889e78650@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Sep 2025 15:41:08 +0200
X-Gm-Features: AS18NWAjOCk1Qe6m9A7AF8f5gOU-rIzmkU9f6UFIkGdqyVsyB080HPyzY-M8DlA
Message-ID: <CAMRc=Mee9JvcOCAqQxcCMBE7gUQWvZaM=wDAfyKTG5bKyZeHTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: Add Tegra410 support
To: Kartik Rajput <kkartik@nvidia.com>
Cc: Conor Dooley <conor@kernel.org>, linus.walleij@linaro.org, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
	Prathamesh Shete <pshete@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:24=E2=80=AFAM Kartik Rajput <kkartik@nvidia.com> =
wrote:
>
> Hi Conor,
>
> Thanks for reviewing the patch!
>
> On 19/09/25 22:44, Conor Dooley wrote:
> > On Fri, Sep 19, 2025 at 03:06:26PM +0530, Kartik Rajput wrote:
> >> From: Prathamesh Shete <pshete@nvidia.com>
> >>
> >> Add the port definitions for the main GPIO controller found on
> >> Tegra410.
> >>
> >> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> >> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> >> ---
> >
> > Why are you modifying a binding header for devicetree when the driver
> > only appear to grow acpi support?
> >
>
> Although Tegra410 is ACPI-only and does not require a new compatible stri=
ng,
> we chose to add the GPIO port definitions to the DT binding header to sta=
y
> consistent with previous Tegra SoCs.
>
> Thanks,
> Kartik
>

Hi!

The kernel policy is not to add symbols nobody is using. Please drop them.

Bartosz

