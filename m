Return-Path: <linux-kernel+bounces-775683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D171B2C392
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229A3727E92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F630507D;
	Tue, 19 Aug 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UuJvqFvd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E8305078
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606213; cv=none; b=bcsAYE/aRWbu+3mQaLwssnuZx1G7bnO/U/AXjoa2OMxaUWpp1bFvoj3mf9iw4gQvd1eQgymcPnWvi4rMCWlknA+fdtpK87upFUpWhtcmoMwoboei+9QJIVl02B1LG8ISONSDcVZE7AF7TQUcsRcgBDaFDn+nUtVMwDQ9QjcyyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606213; c=relaxed/simple;
	bh=iiQQlEftWDHeZ442gvLmUIzyr80dSO6bfAzIWf9nGzE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaXBflYMh0Qfs0graa2/fpJj4xlCJQt7ttetK642eUhyfMgDD4MXUquQxZFuZvAivDmsIUKRHOBB0ea9GH2ZjCW2z6aaYkJwMxWZK9WbDx5fneK6GTliic/AMtELnioyKd/B5d/exSnayhqoMvzuMF+QrVSomgyke5fgDnnliG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UuJvqFvd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7acfde3so731774966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755606208; x=1756211008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNet/+lY0dGDPv7CdnV+riykcgjZjz2+nmwBWCrU12U=;
        b=UuJvqFvdtrKA5J7rMA8yhI5epgo2CQ+nlqFcYa+vKBguTrNxBxQE06qxbOsz+YWlHf
         QfnEHp8NaGZlSwR+2dLTM8Zke7vSlBaU1kGQ+/TN+FD/duQ/MlH6gPfjmVG77GSHBEcl
         +/P3nSgQ+vj12S5TW61/V7XjrupBrBREPj9SUHw9Z+NbG1FCuignQ/t8QzUwhCH3/Ufk
         FOJkLE8i610/GYfxGcIoQdwYDZODOxzmY7jrALT7FypKungobW1RVgPBA/1mv3BqLrY3
         Tg/BMAakHbaVv/IY3+CHX73pi166CYwdYprKdyxNu6Oty7fY8OhwfaqkHc+iFIL7g8gy
         ADEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606208; x=1756211008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNet/+lY0dGDPv7CdnV+riykcgjZjz2+nmwBWCrU12U=;
        b=rjRzIEB24YGf2TRRkTpDWICxw5zMpk1Q12dJEzzP25QWEll5hfgZ61G0rW+2Au/fzR
         Hwi0rWNfk4/MYzq8Kv1SWJ/5NXzB4UYBJHcgt4aanAjP+riFk+Wj/Pcy9CMGwXkwwzPK
         3OMm4pOfdQzPISKCU3pKgYXISjS+u9N6sqyNSjczfKcJzeE7veRnLbbrJYe6tTJ++LvE
         UIh2cQALOHvAF+daxTMszLXU4xvrcofurcoxVmJns/29iRwZp9Dht8UUqPoCiH5n11j6
         NrttISl06cKDY6NsXFFkrCywkEfotkG5oFpjhdgXynyXPx6MzCtD3CUoBzaW6OMZui5z
         hBSg==
X-Forwarded-Encrypted: i=1; AJvYcCWB8Be5Go7PJp8tt3LifHXMEHiK3c9HWRAyo/z9JmlKNGk5iidN2ukGopBSE74oJ8Jx3NWVeLm0DZbzMpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYSzRErCkYH5NSwEGZNtnDd1TKlSUzqaYAqTAvZqh7K6D9C+F
	afeq9JOxuuUPUVKfF5SSxbd+K50kAVf07+IGXIIsTmbAYgo25MY80nvwFy9lo4CAw98=
X-Gm-Gg: ASbGncvnAbTwipX0Z5tPw6ySVQguPq89lIPJi9VF+EKCVSk6EpCWdHPzT3k6JpNLms+
	Od8VcT7tcc8DWgQ/p+NKHpePpP/b9XLTomEHYtIbMvVNxDnQo0GQxhQ/X/Atb5kLihIkiSldeKR
	MzRyAns7cx+KSwjDwk/838em6uefNBORw+BSP7ZHlV8wULiNr4aHBBoA2nwiWg6+MXhGVLqtuQk
	L1KwvAtuvuzXJnpmNbj2JzQD0IO6VTRhdWeqcadcOAjfzsx6veM44iJKjkDSqROYkj7TkkYEYq7
	mm+58S/YJDPwkRDroz+3lGuXiLEav4hjGe0eZJrtpA4qwKTHJbZlre1Vhj2ztgHb0wpUXqJoXI0
	NwS/6cWg8+o7s90DMCg3P6ngVB4oFYu80rPqoUwUmaUXMNxp5qdSAOa313cu3
X-Google-Smtp-Source: AGHT+IGBR9LjrSdYCCyx4joMeVPXsUe/7J9VYrQBtQLP6UWnN/NWeqjv/7La8X6OrPIYcB35RsOs2w==
X-Received: by 2002:a17:907:948c:b0:afd:d9e3:953f with SMTP id a640c23a62f3a-afddd21ce37mr238165066b.63.1755606208358;
        Tue, 19 Aug 2025 05:23:28 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01ab55sm996821466b.97.2025.08.19.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:23:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 19 Aug 2025 14:25:20 +0200
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 13/21] pinctrl: remove unneeded 'fast_io' parameter in
 regmap_config
Message-ID: <aKRtMIzJPCSNdLlf@apocalypse>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-14-wsa+renesas@sang-engineering.com>
 <CACRpkdZgmW9MXAKbMxQ9dHz8-Oi8pVCPqnV5OE3FbA4KT+0yQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZgmW9MXAKbMxQ9dHz8-Oi8pVCPqnV5OE3FbA4KT+0yQw@mail.gmail.com>

Hi Linus,

On 14:02 Tue 19 Aug     , Linus Walleij wrote:
> On Wed, Aug 13, 2025 at 6:16 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> 
> > When using MMIO with regmap, fast_io is implied. No need to set it
> > again.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Patch applied, rebased on top of Adrea della Porta's changes
> and fixed the two new instances as well.

Many thanks, really appreciated.

Andrea

> 
> Yours,
> Linus Walleij

