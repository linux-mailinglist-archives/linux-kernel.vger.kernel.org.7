Return-Path: <linux-kernel+bounces-802309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578BB450DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9210AA05857
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83362FDC4F;
	Fri,  5 Sep 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGzL0syZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B38DF71
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059453; cv=none; b=BP03p3477jmC4hDO9oRD5kJlQjRTQbgtXgBDzqQHBzdUm7OXs70AUn/l0/Re9aeqR+qs8aCji+toW0z64hK15DO12OvaMISZyQFZTddQkQ16I5+wvDod68UVrTGRThvi72YHEhbdrW9PZ7QsAXtlh2NtazOANWjrI8nEU7wpATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059453; c=relaxed/simple;
	bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npTJng+uMB0TlBr69f2mR5NWWExlM9xuNOXGng86rFu/9LPNh3r7yj30tmfxtmL88ZD+juSv/GB4/EG/E8NhL/D074vUdtkIedujGvbwT0TfGHgrxppyPs3i0ZSOl8rZhn2084Sh3GtKejcpuNPvT+vZDrZzF2XQfBHX6pnORfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bGzL0syZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-337f6cdaf2cso14391511fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757059449; x=1757664249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
        b=bGzL0syZP9Tuw2/0AtF/bmdxZuSWwd+gXiqLXNd/9xOGMYNV9rMpUzhjtCVFNo2ZY3
         l78vFVU1pG0AWRrg7iWPp+lGTzRO+dzfsweZ5ZBqPaCH8FYiXGO26yAh+lzo2QBqvwa0
         ykCa59A+0TRJc6P+jYJO2uEWqA4ApH+alnp2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059449; x=1757664249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPfnz/o3iNaHytOqe7truOjcGer8WrwACGpoW942gks=;
        b=Ev8kdUzjqozaALidmfBUqOuKQxvpd3CL/41vC+iTdTOh3abf1SvghYi38HS5rNQqES
         4vSuV5dSi0l95g1pBjBR5WXwtz1RvIAEPqYp8hQu3njD+KEZPOAt1WY4JOn7/FJEP3VE
         rGqjDqK/3J9ttW/2EThD26f+SU4D7Mi7Xn3nSh+B7DVP9jEoUQc21rmozo6vqKWPL0iz
         Lq6/N6DMWsEmB+rukYhXgnJuWQMoJI3qRtl1qiShwMzsWvptj4/6eRjzqK7EpDB0jQcR
         eC80hLli7smCv5B3433T8mYyYG90ZjqV+7RPLR8sodwcM5DXuekW31RyrU8DN3O1l06y
         AICg==
X-Forwarded-Encrypted: i=1; AJvYcCVwUq0lcptc9c5XTPvP4+iF5i/FZL+RYOJewWW0pxMbT+Z7XWnlIZOYMzZWySh1BBvLbcZiYiOSPmk6C7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xoDEFpVCK8duCByZx6pEmjHaFUpOUxEisO8vln01nPfZZPBm
	bzIO7eIeP8Zt18c3pSlL9sEgOVqDQn4XsysUdNW/puQ45lrgRzK9KF/yME816T1WqqtzAPYuK/E
	1l/UuAALqS0N9G5ji1Vz8m8lYVQtXbW4oSU0Leu17
X-Gm-Gg: ASbGncvobxTUTFxKD9PeW8lXCz87zElXIdnUYHK6vRQNKgZPWhhDOXbfuT7W0rVxTMX
	c8Mr3oOB8ntqCg9CZ38mBc+q6DAt1eP7GTBw/YLr8ceKg1/s2DPjd49hNfSWqQl+yk7v5KSyeP2
	ZWLoUeey58fRBM4OWXZfhAadMHF3LsC5yiJq64xbL6JQFUebjW2by/xr2fOGQCaZlqSqXYQgeGx
	x/lifPKBg8MnuoVx3fWKvK8DosWa0NC4rifDA==
X-Google-Smtp-Source: AGHT+IHT043Y/TruREpGKZ+/QRl4lPJ5bvgN3xV40J/rToLhwUaxJ8c7vgtH50x+X4YlPrhw0jN/shKQPrGCvcazPsI=
X-Received: by 2002:a05:651c:1a0c:b0:339:1b58:b199 with SMTP id
 38308e7fff4ca-3391b58bbc2mr3260661fa.36.1757059449029; Fri, 05 Sep 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-23-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-23-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 16:03:58 +0800
X-Gm-Features: Ac12FXzqjLPg1snoakkIHpjZL3gjVDvpLkfu1BDJJWXmMZBGn3rIna_U1tSPpG8
Message-ID: <CAGXv+5GreKJSz76EiHYzX-ByfyxuYNYB6OyBJk9ZhsKCapPjRA@mail.gmail.com>
Subject: Re: [PATCH v5 22/27] clk: mediatek: Add MT8196 disp1 clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 disp1 clock controller, which provides clock
> gate control for the display system. It is integrated with the mtk-mmsys
> driver, which registers the disp1 clock driver via
> platform_device_register_data().
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

IMO removing CLK_OPS_PARENT_ENABLE is the right thing to do.

However if the hardware ends up does having a requirement that _some_
clock be enabled before touching the registers, then I think the
MTK clock library needs to be refactored, so that a register access
clock can be tied to the regmap. That might also require some work
on the syscon API.

Whether the hardware needs such a clock or not, we would need some input
from MediaTek. There's nothing in the datasheet on this.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE remo=
val

