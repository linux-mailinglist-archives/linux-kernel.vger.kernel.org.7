Return-Path: <linux-kernel+bounces-845530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC888BC5422
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B5E35199C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11602586C5;
	Wed,  8 Oct 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKNGTE95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3E21B9C0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931283; cv=none; b=tGDUjpi5UX5f0kzT4HZM8QElsCFdH2s/PjzFjEFFI5x2itgAMD9Dwc24gkRYvw3UHzfy4U02Vz1bMZ1/VOpU8FUGpd/wqOPLc15U32XG178SVyB4SNAzFicnzi2yWc8SZqZdTMhByvz5ctwWjwuD2/VwgIsh6Un/gXAEePOyddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931283; c=relaxed/simple;
	bh=TArvezDZEQsjMhaHWIisKml+GzJyRldlLSrXhgHIPb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHi7OFViTaOTJVIZAGyQR2A8E7d31SHacxPxB5tEBPjdc7wwPlhFsxUYeAv0GR6oW8UPdEDlurMj3kot+uIArdXCutOGGLU0v+tobzN5jH08motLk6hWwXPOg5IbJbmYGxknZB3iZVgh4w4p+IdCaCFWzhWD5B5lUEw+ihAsz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKNGTE95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B744EC116B1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931282;
	bh=TArvezDZEQsjMhaHWIisKml+GzJyRldlLSrXhgHIPb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kKNGTE95vAq1vaS/BL4oTKjY7jbEX3OEkX/j3GX6GyjVInt6acx2gObwo4cCcpnIF
	 WolI4vA5wQz11Le2ZOOqMEK+hRz0YSoLv1MXmLB48is8C1NGDFqNBxZ5oyJsPR2o4u
	 C0tMc8MMfXjVDaHJLzwf+xhJtTcwnJe8n8RYcsddZz4Six9cTwSb1s9GV+kbcyGyDC
	 iEGQTBxm8YoVRSZoWad05bOEnpqGC1w3mq7yRqdmA9whATdICvCUdj5xDOn2zWbYjn
	 ++CFPA3ur+y9eM8LOeBH2hE+XsoBZWqBbeP54dLveXIyzJwWxArRJLTI9TqJ5IJ+/H
	 k5AoWzLznZ0Rw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6494330b1b9so3215016eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWktNFOk5HLGgN3cSRkW7n0155nEpXYO+RUB+Lv5JavXgytJwRbDRB7GHhTEd+Jl4JtRq/tw0pftJHaRW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZ8WKhNjnXIG7bTPNjthkmmGc3nhopmoURHQPKjUZCQ9udwWk
	dMV8kXEpya5DAKgstDpUM5Xsd70pkAvy0WYHwVbarvHjImDx0KvrWXNzILbrfQ0AaK/gADMqtE/
	wQj85oIL3JkEpYyTDftRDk7axLVr56+w=
X-Google-Smtp-Source: AGHT+IFz5cBg4+T4rL9tuywKBs8c6cm4c/NRWXhnpM1O5tcd8mh0O2hidOMfjxbofOc9Tqa4RWlPyoGWgmjOias/7z0=
X-Received: by 2002:a05:6808:188b:b0:43d:2197:c1e5 with SMTP id
 5614622812f47-4417b1ac054mr1841940b6e.0.1759931282013; Wed, 08 Oct 2025
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911> <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
 <20251008130234.mw6k4k7fupxma2t5@lcpd911> <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
In-Reply-To: <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Oct 2025 15:47:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-f2dzKJZDZ_fxrDL+JYcF3JxjargBVT3RVcXhVVywjw@mail.gmail.com>
X-Gm-Features: AS18NWDzg6y_ln0VOA3LER6CVKTWcaEQ6TVX12yT9jm_4CrN9aS2IFrcY9Saj2Q
Message-ID: <CAJZ5v0g-f2dzKJZDZ_fxrDL+JYcF3JxjargBVT3RVcXhVVywjw@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:10=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/08 18:32), Dhruva Gole wrote:
> > What I meant really was to consider another path instead of a mod param=
,
> > something like a /sys/kernel/
>
> Modules' params are exposed to sysfs and are writeable.

Some of them aren't writable, but this particular one is.

