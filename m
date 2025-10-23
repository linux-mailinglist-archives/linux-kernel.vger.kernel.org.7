Return-Path: <linux-kernel+bounces-867635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7CC032A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE2342DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB334D4DC;
	Thu, 23 Oct 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gauRYyUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0034D4C2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247372; cv=none; b=rtD/MbYCRi0hPayrJkyUXKwgQdgbNuWtVO9rWfSDVPeZPSUHlK/HGF78O7hkaXluoGF0+DjaH9+jLfoH/sLhhMNF1DxDG6xS4NKL1yBLUOBl4fK9TszTp+yr8b8uoSrgpxqeGbTF9ZJho7WVk4P8AVEiPO5dFvNJo+1d/4qdKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247372; c=relaxed/simple;
	bh=8pmAvMFcgGxycHzVqDJkz5ZectTrMKv7iJ/nlXYuEBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDX+sPLFVtZ+ppwD8p5rJB59kbUjAuR6qJqB2ohbfpr2clyNKZOBgMMLoLu/iOwaiUclVAWw+1YN43DnlaiNNGyf+LwuJU44f9vqSLY5nwyqL/IoBbm8osGRZ4aJ9hzwfcuWVU3hHf1PJCIbmXD4M5whVsZJT+cW64R+SBVRSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gauRYyUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01DAC113D0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761247371;
	bh=8pmAvMFcgGxycHzVqDJkz5ZectTrMKv7iJ/nlXYuEBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gauRYyUVCdJwAxX7BVO4ck4hkX5qlvLWSdY47A+OCvpPFfkj6Rv0/kxxKu7fX7xrg
	 jn8vxzDRTzlVgJuZwZqlHlfQPv7fyOodumtjyfYvweyL6/vmGXpImtCNr38dvCXlhr
	 GTlOg6l3leMMtFoNTD0BEfgLY97wsRGHzubsJZdERRWloMBKKXXVirTwKDEIMXBG7d
	 4+vq9iwygkEFEE4oRJ14EB261wBpcn9BMGf5VQhlMfNcoBfUnjLMNAmuZccsNuZ9yx
	 IC+3fPLS+h9JVetSnN8jNkHEfmMwrW3HDXYIwEtJj7AjJa+arlyin4AGE8rSnmxdWb
	 ncHNIcPRMbWpg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-651c83b6c14so292930eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:22:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpbIICFOucdRSs0i6db6yRLT7+a2V1oeAorAHvO7prTPeW/IvRCFh6lV2eK/37g/2Jcjfqla7sALQMAFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8c3dqGevcb1Eo/BwbwIZqGfobfOnl8+dbB4kQ5OAMnBmK71+
	eDYuedAHdKLqfyt4TfeXk6T6G1UmYWA3gPUYpAQ3Tw1VUWt9R7x7iuRjtOx8/haNfVNYnlQknqu
	Wd4ePygMk0HKHzeckqW/zP7z3M8/w3EE=
X-Google-Smtp-Source: AGHT+IGqs+wyga7dj9Da3tbZpfojrAyct2iyuh4GHuYXjjIoAJ+H85HllrUAP3K5b2wcW/LhQSo81TUyDeO0CP3toNs=
X-Received: by 2002:a05:6808:5091:b0:43f:1e42:9e89 with SMTP id
 5614622812f47-443a30f9571mr13348804b6e.45.1761247370970; Thu, 23 Oct 2025
 12:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007234149.2769-1-W_Armin@gmx.de> <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
 <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 21:22:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idydJCQqnEs38KJT+1TmVJuhLeCFikypDLD1Yd_8zWhg@mail.gmail.com>
X-Gm-Features: AS18NWAbOy9mFyuCtFOF2-oM_q4Tit6y_YbBCimCAlqAP2G-a7giEb0nFT8qYE8
Message-ID: <CAJZ5v0idydJCQqnEs38KJT+1TmVJuhLeCFikypDLD1Yd_8zWhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI fan _DSM support
To: Armin Wolf <w_armin@gmx.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Oct 22, 2025 at 11:41=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
> >
> > Am 08.10.25 um 01:41 schrieb Armin Wolf:
> >
> > > Microsoft has designed a _DSM interface for the ACPI fan device [1]
> > > that allows the OS to set fan speed trip points. The ACPI firmware
> > > will notify the ACPI fan device when said trip points are triggered.
> > >
> > > Unfortunately some device manufacturers (like HP) blindly assume that
> > > the OS will use this _DSM interface and thus only update the fan spee=
d
> > > value returned by the _FST control method when sending a notification
> > > to the ACPI fan device. This results in stale fan speed values being
> > > reported by the ACPI fan driver [2].
> > >
> > > The first patch performs a simple cleanup in order to reduce the usag=
e
> > > of the acpi_device struct. The second patch fixes an issue with some
> > > 64-bit ACPI implementations where an invalid value was reported
> > > instead of the standard ACPI placeholder value (0xFFFFFFFF). The thir=
d
> > > patch fixes an unrelated issue inside the hwmon support code while th=
e
> > > next two patches add support for the ACPI fan notifications as
> > > specified in ACPI 11.2.3. The last patch finally adds support for the
> > > Microsoft _DSM interface.
> > >
> > > All patches where tested with a custom SSDT [3] and the acpi_call [4]
> > > kernel module and appear to work just fine.
> >
> > Any thought on this?
>
> Not yet, but I'm going to get to it today.
>
> > I tested it with a custom SSDT, so i can prove that those patches work.
>
> OK

I've applied two first patches for 6.19 and the third one for 6.18-rc, as a=
 fix.

My understanding is that patches [4-5/6] are preparations for the last
one that needs a pointer to the MSFT documentation it is based on.

