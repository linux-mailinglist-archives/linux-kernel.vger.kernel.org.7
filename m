Return-Path: <linux-kernel+bounces-877762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB3C1EF49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6494E53FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB630BB9E;
	Thu, 30 Oct 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPYBX++E"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F318A6DB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812511; cv=none; b=sCxCphtRo8IOebt8/gm9x29qVUJnPxKaejZmo8i/6FVkoVZaiNp/3Crt1tbd/Y+8rf3utrfwoFeGgQTfFT1NRF7f1wbM63quvuX90NVQPluWC9ZwoRWrMuL/Ji0cbn29Tn/zxgyCVHQhunfLDPKyTV+VAohCUjuHAAHjgRdYIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812511; c=relaxed/simple;
	bh=aP9gHKvvsd3H8WS+/h9myuYFkwe72MjPQfocSC/zCe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLM6NvJfzD/azi4qtbzKEZt54ITZgasJfra7va//Mm5TOrKR7HIb7nD3S8w3lKJUIqw0B98a/ILJ9PWR/PkY7zoHA281U/z91/cNUjJz3rA+S+zd6rBsyuEl4R/h4o5IQMbBbwUDtJxXAlZe77gQwJ9/M0J0H3kG8cAmfawfAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPYBX++E; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591c9934e0cso1300632e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761812508; x=1762417308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RRQ3mnvpw4ptRfYD4hKfaf3ngNiZ/ZLRKANhoAh4Ck=;
        b=JPYBX++ECkIxjuSrUWSo58Ov3fPsSVpfQWzxTlw/gIo26r8hMaKM3Gi+coQMGoOnf+
         /IHArEYmiuJK/1hIzUxK1CmcffCEfJcLfy5pq7YcPvTNHd0iwoPC58lxhKpGWMXLdjHN
         x+q9rfEzF6HgaIVxm6qhhB9edQjJfTxGmPYM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812508; x=1762417308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RRQ3mnvpw4ptRfYD4hKfaf3ngNiZ/ZLRKANhoAh4Ck=;
        b=L/LIVopbuw9eweXHh+cKkPSU9TIgTYE4jIfJ8lLmgxxhd3UFFspQPH5guWtShdwWa3
         moNmWJF2xbxjbmMTPZ+1nV5cPXCvuw7iDlFetZStybDLzoietjAKJFN6NnYG7eCTV+q7
         zukU4CYIRQa5AM963197G9f35P9vDjgM1JEpwoOQ2buw7R2qf/QfBxnHHGGsxNxJKWnq
         hbqs/wBabj0gvZIFALgoM4nM+BAAkwL3LvCa9HQghXTGqVVnfin4uFRwrXJxDShXAsVN
         tp3BStj5YpCSa5gEmo3U40cp7AMXf0X5HSV4JVt6JciBzcIg8nao66p1ubEw1nEdqjyi
         MG/g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1jJAdHUD4feF5cioFckk9PAd2s84TSPnzgw65MMVb4xdgP8Xpxvbp/7FsJxqkoBLxRa7kry4Sv6HgYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/uN/S2CLB9+naSDZsAjU/O7J3+nxdhFSFEkr5qQi+JhYw86u
	48NA6ejptYBFD+Q/cfcTnhrpuqTIkKLHqqVHjA1EaR+5nCE0Ves9dfcCaTZIEm5UR38TxcPY2VB
	Zxeo6KpjRizDLRJxKF1LX7zFF6z0ywoqUWfNi19mL
X-Gm-Gg: ASbGncvBlbcPEayKT3PiXlHdSMRqkxs/+cx9LKgEv1rmBMCa19cXqOgGSn8dEEbou2H
	+NoYzYbZbvq+LCFXRI99+q6kLIFqrg7/s8LeIs7yV6b7qgJr8dG9gzPGOqR9EjMKW3ZhH5HPJyj
	GgBzBJzx82B4NqBJEeu1s47hdy1bKtq4U5dRc4/W+dASF831FZIaU7XsAxcmlUQiRvO5fPYOoM+
	dMzgoscvqqqvSGmGKdfFCvYkxVI3JNZa/klDRIOTfgc9cKdfyl8ppMbZVzu/nu/6q08EqRcYRQv
	Oo/Geo/WfBM1VG0=
X-Google-Smtp-Source: AGHT+IFU82eFD7KyMUajMtRnh3g0OAFBir+9otZR0HYwHlQYMDmXZxQQJ8cv/9zylVMsVzxv/6PO4ARJDSX3YbcKhTo=
X-Received: by 2002:a05:6512:ad6:b0:592:fe0f:d9e with SMTP id
 2adb3069b0e04-594128655a1mr1896419e87.7.1761812507765; Thu, 30 Oct 2025
 01:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084103.10737-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Gs5_j5L3+HT7K-XYwVG6S8ZGhHZkEcS0HpdkcjRQq2oQ@mail.gmail.com> <9f5a3dc5-d0f8-4172-a4b4-867919612a2d@collabora.com>
In-Reply-To: <9f5a3dc5-d0f8-4172-a4b4-867919612a2d@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 30 Oct 2025 16:21:35 +0800
X-Gm-Features: AWmQ_bmkpHdrIvgnJ7LYrPcYtpiVGscoJE_DrNSX0WTZVJCZr-WNnyLSiVAsWFM
Message-ID: <CAGXv+5Ge-uZHKATOvqQF25DRTcHFJkopUk-JUXDtpEen=BwCiA@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: mtk_scp: Construct FW path if
 firmware-name not present
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org, 
	arnd@arndb.de, andersson@kernel.org, matthias.bgg@gmail.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 7:05=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/10/25 10:14, Chen-Yu Tsai ha scritto:
> > On Wed, Oct 15, 2025 at 4:41=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> After a reply on the mailing lists [1] it emerged that the DT
> >> property "firmware-name" should not be relied on because of
> >> possible issues with firmware versions.
> >> For MediaTek SCP, there has never been any firmware version vs
> >> driver version desync issue but, regardless, the firmwares are
> >> always using the same name and they're always located in a path
> >> with a specific pattern.
> >>
> >> Instead of unconditionally always relying on the firmware-name
> >> devicetree property to get a path to the SCP FW file, drivers
> >> should construct a name based on what firmware it knows and
> >> what hardware it is running on.
> >>
> >> In order to do that, add a `scp_get_default_fw_path()` function
> >> that constructs the path and filename based on two of the infos
> >> that the driver can get:
> >>   1. The compatible string with the highest priority (so, the
> >>      first one at index 0); and
> >>   2. The type of SCP HW - single-core or multi-core.
> >>
> >> This means that the default firmware path is generated as:
> >>   - Single core SCP: mediatek/(soc_model)/scp.img
> >>     for example:     mediatek/mt8183/scp.img;
> >>
> >>   - Multi core SCP:  mediatek/(soc_model)/scp_c(core_number).img
> >>     for example:     mediatek/mt8188/scp_c0.img for Core 0, and
> >>                      mediatek/mt8188/scp_c1.img for Core 1.
> >
> > I know this patch has been applied, but this scheme doesn't actually
> > follow what is already in the linux-firmware repository.
> >
> > For all the supported platforms, the first core, even for multi core SC=
P,
> > already have their firmware uploaded as just "scp.img". Multicore SCP
> > is seen in MT8195 and MT8188.
>
> The only one that is affected is MT8188, which needs a rename or a symlin=
k in
> linux-firmware.
>
> MT8195 is not affected by this change, because the SCP is used as single-=
core,
> hence this code will look for scp.img and not for scp_c0.img.
>
> >
> > I guess I can send a followup patch?
>
> The only followup patch that I deem to be necessary is one adding a symli=
nk
> or renaming for MT8188's SCP and nothing else.

The firmware was uploaded in March of 2025, and is packaged in Debian
Trixie, and was also backported to Bookworm. Either adding a symlink or
renaming it won't trickle down to users for some time. So this seems
like a possible ABI break, where the ABI is the file name.

Or maybe you don't consider it as such because SCP hasn't been enabled
in the kernel in any release yet?

> Please remember that some of those SoCs (including MT8195) allow the SCP =
to be
> configured as *either* single-core *or* dual-core - and usually firmwares=
 for
> single-core configurations are not compatible with dual-core ones, becaus=
e of
> the SRAM carveout/usage.

For MT8188, whether the current blob is dual core compatible needs to be
checked. The blob upstreamed to linux-firmware was built locally by
MediaTek engineers and is not what we ship with ChromeOS devices.


ChenYu

