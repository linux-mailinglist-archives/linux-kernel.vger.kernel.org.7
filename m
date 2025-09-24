Return-Path: <linux-kernel+bounces-830606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56817B9A1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CDB188942E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A446200BBC;
	Wed, 24 Sep 2025 13:47:02 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370FCA6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721622; cv=none; b=EvmJ7TznSNDGIaGXb0x9RfzYXK44JBRQobcytmvl1j4SBK1W9RRb1CbrS+9giRrHrklvBiHWLzBmRmclZo9VXOZd+niFUtHsGWgqE7h7CFB6wC42urF3rAqD6+h3rVUjYZD3TOrg0KPwVR/0QwshrSd5dXVsft0Ew/LsXpt4JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721622; c=relaxed/simple;
	bh=4ufVBo91j6b7vQS8nx77668ZnFWJ1UYtSUBtzw1k6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snuctM7Nuck47NImpWNKr3jdMSLaWEVftwiJo+ylpUezqNtMAV5gzlyikqF9V+XT0jrH2QV0KV72PRauGggi06Ht+4cYlnH5dVn36a2tF2sUNnGNKerKMFxuErhCVEDsj91Huq8HOk3YTIyAMwqmTuDcAEpqasadjtzejyZ3C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5997f407c85so1561620137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721619; x=1759326419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLzLZ4lMMfD6hJdHfjXaI/aoGDFxs0QS4To1e7V5pJk=;
        b=iS5M4Vo1ZJf9/P00WIAbxll7g+gxC1k1mueST+qtLauZJ/D01JPxz2G6+P251w4pMh
         vjuQX+6Xo6wmLNBWOBG9PBlUacYCpyl1CsxYiDcppmbBU/w+vtAsYzAQU8MMFXCjmdgv
         uFLqyMhq2k0HSfZ/RoftLBY1E85KhCzUI4vZ50b6qreEgUNoYQKf6O6VDf6Pc74XV22M
         sctAx9hzj/qtn5wTpXWnyK/ffMJZ/BmizESiTGHMpNvRAHqfKaUCox3MeXBuRmym9M2z
         0Tio7utKO46R6dPIqoDSx8VvwDzbUi80R04IwOH7Fm3IPnOj0fqYBSlmNpL2iDsv32qY
         hE8w==
X-Forwarded-Encrypted: i=1; AJvYcCWau/GjxMtrHWsAMXDyQstveKWG5OwIBv5glxPcGQ/2yzEHv7xFhyQTyl33YO8mA7PO3wrC2f8xMAKMgos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zcnzRd16/6hZkPDaatNDhKuue86RQi20Ibamkl7UrwajddGd
	RmVcwoNGsu+6CLmYn22AVxRzNY3zoG15neW2Ro/waUWaGexy4Z6tZoI2YKSuUF1X
X-Gm-Gg: ASbGncufddVlRR3UrLWvGi2BumEJROw89BwsSHPvjumsWPIAEPW1NIE/WtalIbvrHlK
	S91rdWH4JoBDIxkdpJubktEJJ6gvOrK7L+KXeyAq2jQe6BvLGS1F7oSBto47gWwi8qF/3iNrgCx
	fv2WQDg/wu8uf924ksmnUfb1NDagXxknN97yD22yvYTElzfiqNnBQx5dkgNkrnPjU9YWs+jeEh7
	euTeTD2/Dz0oZWsr6rvMXoM57QhViND513LgpnBCRpBsXfKTk4VuZM/2II5lD/FJWK06IjXGHAM
	Mn2orcOkIO3IgjMDpQe+A17qym3dklsoiIuxPkO/FX649ejNnGmqpQZAhoTu4XdMUsIx+OT5+QH
	GzRv6cu2Cbenxnm16t7A/GbVXvMheyCsdb7r7jiUxbgufyHB4phQwzRSWF1dYoF7d
X-Google-Smtp-Source: AGHT+IHaqIu8kK6IHEGNV3MFlb6gER5FiXsZgcijQfRCg3q65Yd0Ev2icVFhtLJe0D/tA8ePkLniKQ==
X-Received: by 2002:a05:6102:914:b0:51b:fe23:f4c with SMTP id ada2fe7eead31-5a5787ac8c1mr2246583137.22.1758721617750;
        Wed, 24 Sep 2025 06:46:57 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-592500edcd3sm3605042137.15.2025.09.24.06.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:46:57 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so1827705e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFY70bi3crFgtUUnFCkD2eyXEMcKjRIYsTwKbrHaUFz1UJAP5GBk25q1cPVVZu62DkIsdh5Sp7WSZBI7A=@vger.kernel.org
X-Received: by 2002:a05:6122:3d04:b0:544:75d1:15ba with SMTP id
 71dfb90a1353d-54bcae9778amr1949729e0c.8.1758721616800; Wed, 24 Sep 2025
 06:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910142657.1148696-1-niklas.soderlund+renesas@ragnatech.se>
 <20250910142657.1148696-3-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdVKZn-YfBxvwA1wgjksvzZK=NPzaoTCPRur_Z=AneLA6w@mail.gmail.com>
 <8672a8c1-26b2-4b65-a30e-a4c3e0f1f32e@linaro.org> <20250924093132.GA1062104@ragnatech.se>
 <69f09f55-fd2f-47a9-887a-e9c2cf7c21df@linaro.org>
In-Reply-To: <69f09f55-fd2f-47a9-887a-e9c2cf7c21df@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 15:46:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWt07VP=i_5S2bm6yaRwOovzc4hgZzYaYvpqj4nronxgA@mail.gmail.com>
X-Gm-Features: AS18NWDVph8AWywi1xllkD9wmtBCKD3KT56Evui3Cxt4BbhVbP3DxFNagKkV9X0
Message-ID: <CAMuHMdWt07VP=i_5S2bm6yaRwOovzc4hgZzYaYvpqj4nronxgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/sh_cmt: Do not power down
 channels used for events
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 24 Sept 2025 at 15:43, Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
> On 24/09/2025 11:31, Niklas S=C3=B6derlund wrote:
> > If it's not too late I think we should drop it. The issue this work
> > tries to solve is a lockdep blurb which highlights a design issue in th=
e
> > driver. But the driver have function properly in the past. So I think
> > it's better I work on solving the blurb without any regressions.
>
> Ok, dropping 2/2 but keeping 1/2 is fine, right ?

1/2 is a refactoring without any functional impact.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

