Return-Path: <linux-kernel+bounces-784160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31AB3376C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A41483BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91B288C9D;
	Mon, 25 Aug 2025 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BfF2ZCNl"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571882BDC10
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105368; cv=none; b=fmP0nOcy+A83TCFrNW2DUb0XMLr9ce6M5TsS0Ghyqacbz8BIQJNC3FF52R+eMhwitaOvt1RpBZvEzqxTOSelMNPuyS/aFnfTeLnjsdRRCAr1lfRj6GEhCfV73UBzFwZrdvCZOWhnaSZefM5aYyUpC8Tc4QwcJXZWuBZ3rWwGo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105368; c=relaxed/simple;
	bh=Ww1l4kU6XoG6+pq0FKhmMqbZI3C0dck0vI2yup0Q6Ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xzug9e6ISk4n5uCjnodFj2xNx0cvHuqQDwh6BNpNmGJNzepNHla1JgPWExsa0+L4CsmlxImvlbe9ZclGACpncbX0nT5vT8kYMXFhFXhV7Jo+LeHrEfFcfDFJkJdNH5hSgPQpeo+NQuVdrnwaUncgcnHCJGal/ZZDmWEq3ojul2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BfF2ZCNl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <88fec8864f2544df67113bf7282a1b2965a1eabd.camel@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1756105357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww1l4kU6XoG6+pq0FKhmMqbZI3C0dck0vI2yup0Q6Ys=;
	b=BfF2ZCNlgiauBfEnpXCc3Mvuj0qOEvCEDy8EsJMvt6fCQMDuHPqMlB6uXl7vyLOC0IVykR
	vpBECokdqz0xm8dkS8r44Uq/24bw2dOqVAXLJvuYxAccZ+RDV8vVX12McBFOqotntKft+J
	xMyVG3JyVUQxpkjLiYfZ3mLa8yLdH4u7BcF8rxj+XZq1HuxKN44YRDXHMaWdT6qS56XNPj
	MJyhUlyAa2djoTKSfgrsbPhA+ZTYWzjJXjMscFOoMfO2alOJ24qjs3Ljls/uJJwaukE5Xb
	ZYj/HsTb9KlAQilavvZmdK3MLXbNAWlhXjYxGFUg8JnTusfXMvHFasjk7C8ynw==
Subject: Re: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a
 granularity of 100
From: Philip Mueller <philm@manjaro.org>
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alex
 Deucher	 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Rodrigo
 Siqueira	 <siqueira@igalia.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>, Lang Yu
 <lang.yu@amd.com>
Date: Mon, 25 Aug 2025 09:02:34 +0200
In-Reply-To: <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
References: <20250824085351.454619-1-lkml@antheas.dev>
	 <20250824085351.454619-2-lkml@antheas.dev>
	 <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On Sun, 2025-08-24 at 21:33 +0200, Antheas Kapenekakis wrote:
> Well Phil managed to fall into the value 332800, which has a 0 minor
> bit. Unfortunate. In hindsight, every 256 hundreds there would be a
> zero anyway.
>=20
> Before I made this patch I made a partial refactor of panel-quirks
> where a quirk like this could go to. But I would really prefer not to
> do quirks. Ill send that too.
>=20
> Antheas

I was already looking into that OLED issue for several weeks. Changing
granularity might hid the root cause and you might hit the issue less
frequently.

Currently checking [1] which changes the first byte to 3 since when
DP_SOURCE_BACKLIGHT_LEVEL is written to with
the first byte being 0x00 and sometimes 0x01, the panel forcibly
turns off until the device sleeps again.

In the end the panel vendor has to fix it in firmware. If not a quirk
might be better specific for each panel vendor.

I'm still not sure if that refactoring is needed, or a separate quirk
function is more logical to be accepted upstream.

[1]
https://lore.kernel.org/lkml/20250824200202.1744335-5-lkml@antheas.dev/T/#u

