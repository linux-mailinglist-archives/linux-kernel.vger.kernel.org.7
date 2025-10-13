Return-Path: <linux-kernel+bounces-850095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3198BD1D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11404ECB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3E2E9729;
	Mon, 13 Oct 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ljRT3iyT"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5D27BF6C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340946; cv=none; b=FUym4GfsFoDTNCUTOIMoNXYIenAITgFpgWNKIhstJn6FFGbWnFNuS19lyI+xZy/TJMaEcoGYN0lvBu7cJWgdCTzfigq+iTHk4mGNatUs4cZwq5M+o9QkEBEzrCPj1sQaBlYXiCtwotL93CDTPCO1mNNaGJZ0GEWlG0RjAuZMfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340946; c=relaxed/simple;
	bh=ql7ahzRkbyk+z6Q00r6p0cgtcIfdjVFWFWC2Iqq5niE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWZe6dqoPS1/LyAKfcePck72pWNcbzZL21MOWOlFbk3l3lS2fwcEgBomV4JXgcJX2zepu4e7cDyc8ygAU4WmNSk9p955nwYewdQ5tdrHXR5j5nHOke77uel08MWhj2ynlmslGNa7T2Mc7BnU+QypKH8wgQUR5SnBfQTD9K2P6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ljRT3iyT; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 582F13F4E4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:35:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id C6C673F6BD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:35:32 +0300 (EEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C22CA200C4C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:35:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760340932;
	bh=9Hn+Kh+H9BYteHAfZAHvtY3fRWrAQB1UoP7oJwMqcNQ=;
	h=Received:From:Subject:To;
	b=ljRT3iyThnDXSLFSz12uTJbNbbYBwEjClJ0UbBJ7BlTsyDK9Ict/SjN5Aa1EHs2Os
	 EP6Kdb82djXx/TcB/C9U4yLWeeY+nFUwY2v1jHYrE75a2YkS/wdhzm9QOCEtinhVzi
	 PXddPGLUUWhGa8Y510hOCAfA+E/Pn/Iajv2xoJLsFeS73kqXjgmI0CcUJCrvl5qrMV
	 +0iucLiJKVVwYcR/VpPzdyYWE3b7JxyRu4xNuMjK4a8wMNmFnwwRr2iFHoZ+PFSj7W
	 TxtDN9UgLTwZnMMMrCwZNJtS8yC1UdJMvNju9r6rg3aTxnFP/OWLLQ6NRwTkXoh3cR
	 jrWRenYsKsVIg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-367444a3e2aso40903771fa.2
        for <linux-kernel@vger.kernel.org>;
 Mon, 13 Oct 2025 00:35:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YxeibXdCA6Kv7X/K0/1b6tVeOjDYk/ZO0398TzyfIgyAeewg6dh
	EJlq1EFDg4l7YN4YGDAOx04w/HZAHSUxge7IOB9hV/QLLQVr4aSBQ3QXgk1iRM93hzFg49n0RSp
	M91WMCYdS/GLB24rrLy/SJpHqb3H6nTs=
X-Google-Smtp-Source: 
 AGHT+IGhL2/hPSVmQ9/g7fkwl+8HCJEvNwUHqNc+SjupFlRWyGcojcgyopcQdncqUTJ3+gEMsIQUOfnoMI7YIJ6vm1A=
X-Received: by 2002:a05:651c:2126:b0:372:921b:4b7e with SMTP id
 38308e7fff4ca-37609e46310mr51045141fa.27.1760340930853; Mon, 13 Oct 2025
 00:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904175025.3249650-1-lkml@antheas.dev>
In-Reply-To: <20250904175025.3249650-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 13 Oct 2025 09:35:19 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGn3iJLHhSZrokf_V+HELjUSMBnANxcrL3rHi7bjZ57sw@mail.gmail.com>
X-Gm-Features: AS18NWAxC-PYeN9MBQ07gyyTFLN-0TuITGjqsU6t4YtDjnw8Ngcekh9sQdZXDbU
Message-ID: 
 <CAGwozwGn3iJLHhSZrokf_V+HELjUSMBnANxcrL3rHi7bjZ57sw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] drm: panel-orientation-quirks: Add various
 handheld quirks
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
	philm@manjaro.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176034093205.240284.5882039980560948709@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 4 Sept 2025 at 19:50, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Adds a bunch of handheld orientation quirks that collected in the Bazzite
> kernel. I made sure they are alphabetically sorted. In addition, to keep
> the series short, I grouped variants of the same device together.
>
> Antheas Kapenekakis (10):
>   drm: panel-orientation-quirks: Add AOKZOE A1 Pro
>   drm: panel-orientation-quirks: add additional ID for Ayaneo 2021
>   drm: panel-orientation-quirks: Add Ayaneo 3
>   drm: panel-orientation-quirks: Add OneXPlayer X1 variants
>   drm: panel-orientation-quirks: Add OneXPlayer X1 Mini variants
>   drm: panel-orientation-quirks: Add OneXPlayer F1 variants
>   drm: panel-orientation-quirks: Add OneXPlayer G1 variants
>   drm: panel-orientation-quirks: Add GPD Win Max (2021)
>   drm: panel-orientation-quirks: Add GPD Pocket 4
>   drm: panel-orientation-quirks: Add Zeenix Lite and Pro
>
>  .../gpu/drm/drm_panel_orientation_quirks.c    | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)

Can I get a bump on this? New ones just keep coming out we need to
start merging them sometime

Antheas

>
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> --
> 2.51.0
>
>


