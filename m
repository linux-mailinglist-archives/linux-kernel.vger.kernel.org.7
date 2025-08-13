Return-Path: <linux-kernel+bounces-767255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0512B251DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA127BDFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FA1F5413;
	Wed, 13 Aug 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hRsC4Ts2"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36715303C89;
	Wed, 13 Aug 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105400; cv=pass; b=boWJ6g2IiGZqerBS90+hEmy8hz5DTgGeD9BE/2NelzPI9v7tL6yf1xeIwlOTYVwW6exe5Oxd9aU3eCAKkjPniwz++xBwYVRF6o86u5rtVfnVZRj8EgMWi1cn/UH+dCqH1W7s0+7K9Y8+qfWIjIOBIwHZq4uKOWVTXyfhsG00suI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105400; c=relaxed/simple;
	bh=/vzN8wPcA9iD7oRNZZjvZq9B0/vfABdMxfyd+edq4jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DE8Mz3/kkeQRcZ+deFRj1C2zfBlt1NuPt4R0ex4uHOhqvRH73biF04kFNzfLN4MOwYPHnxwS5oLcgly/rBoc9dBGvxxI5yBWvUsoDMMqYwz0EBYgK6Nyq2BADV9/tXpaebaUOwUixKfIhmrz05BoywZJXp5Th3QGQhaaV1g2hnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=hRsC4Ts2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755105383; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jCQPNJr6Utb/IlNo0c8yh/wBg6V3a4jV4YOu499PaP5V9JNEo+37DQdj1L8DDWz6x9MtSmbbSkcvgdXVSXYhbrLavEUw+9QqHBcEZ7hR8aZ9VOd643rMtBnKa4P4UPiI+d//GI8cP5rNSDQzk9kqaunePIashDXg/JWkXjWWeBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755105383; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/vzN8wPcA9iD7oRNZZjvZq9B0/vfABdMxfyd+edq4jg=; 
	b=fzIOjNerQkYl18WMmAC95Xva0mnqlL85u99Fb2jQn5i4MUfbGEbfZzFART+YdTWbL63X8R1zaRMKziXHIZZlXjr09fUGsFTEj5VXChsJS0SNNYc0zQwPKwoyej/HkEsTethv8vCv+03hYFYGXBmE8IsvEboYLYivWrhixtG9XGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755105383;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=/vzN8wPcA9iD7oRNZZjvZq9B0/vfABdMxfyd+edq4jg=;
	b=hRsC4Ts2ejnqno6bRuz+O9Q/ODtnrI0mKpm0GFsGLwoZHtwuVM+pe5GydElQxCgM
	17N169BmTmgSC0N0gGho9RSnrg8cwH3cIfQI9H4HIXiTsfDFziFaYOZowCyW6SaS0Pl
	AQdQI3VJ3vsBnmEsMt1WWESs69+Yv6GysbI3W6GqvhbZIYC+8vcDHcfTUbNaGkDQdQS
	ewG9cCUxSrO36kQuIpb+BqZjBicn3q64ybDiSObDyk7sYdOTcQ+T1EqBAz/+RewdvKw
	qrLdtmJl+ZFdoW7SSygBQ2DpLay8Nz9kxEXAxdPLguJQbTFuwBYsIGANNoCYEKwRA90
	TGWvmJh+6w==
Received: by mx.zohomail.com with SMTPS id 1755105381384154.6661811070984;
	Wed, 13 Aug 2025 10:16:21 -0700 (PDT)
Message-ID: <eedd44480a76840e1fec73d4433c772c5bdc7011.camel@icenowy.me>
Subject: Re: [PATCH 0/2] clk: thead: th1520-ap: allow gate cascade and fix
 padctrl0
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi
 <ziyao@disroot.org>,  Han Gao <rabenda.cn@gmail.com>,
 linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 01:16:16 +0800
In-Reply-To: <20250813171136.2213309-1-uwu@icenowy.me>
References: <20250813171136.2213309-1-uwu@icenowy.me>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 01:11 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> Current ccu_gate implementation does not easily allow gates to be
> clock
> parents because of the waste of struct clk_hw in struct ccu_gate;
> however it's found that the padctrl0 apb clock gate seems to be
> downstream of perisys-apb4-hclk, gating the latter w/o gating the
> former
> makes the padctrl0 registers inaccessible too.
>=20
> Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
> ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
> gate.

Forgot to mention a easy test of this patchset:

Just install `gpioset` from `libgpiod` on a Lichee Pi 4A, plug a fan to
its fan port, and run `gpioset 3 3=3D1`. The expected behavior is the fan
starts to spin (because GPIO3_3 is the pin controlling the fan),
however without this patchset Linux will fail to switch that pin.

>=20
> This patchset depends on the display clock patchset at [1], although
> a
> rebasing to get rid of this dependency is possible.
>=20
> [1]
> https://lore.kernel.org/linux-riscv/20250813072702.2176993-1-uwu@icenowy.=
me/
>=20
> Icenowy Zheng (2):
> =C2=A0 clk: thead: th1520-ap: describe gate clocks with clk_gate
> =C2=A0 clk: thead: th1520-ap: fix parent of padctrl0 clock
>=20
> =C2=A0drivers/clk/thead/clk-th1520-ap.c | 385 +++++++++++++++------------=
-
> --
> =C2=A01 file changed, 188 insertions(+), 197 deletions(-)
>=20


