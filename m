Return-Path: <linux-kernel+bounces-826349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC772B8E469
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B5217AF65
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012F1B423C;
	Sun, 21 Sep 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvaiBt07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CC26E71C;
	Sun, 21 Sep 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484245; cv=none; b=H0HhSOa1nZmo4NGzgXbkByIqf3mkNgNKA0sotSAeVVeRtGLdUkAtZaXgCibvzO/4Ckme/pTc6nWbbqcnVAoFmXJqOz1m5WNQj8+rIHxiCWv2dJFEtqoytlDeJ4AbQCv7H0zxHeX3VUS4qPeFGoIDrAr32cfe+EnPsavnU4HfQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484245; c=relaxed/simple;
	bh=nzIWx7UZnKV0wXpHNPqCT/yCqNFA4bqMUL38PIecq7c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sueVXW0KJC/1ImS+RiE85Qk/qhC6+IFtQ4jQgAN/VrS00OnsI99k3IA9RFAv0vGsIRYxYnZsYArofRJuXmSNrmlUVFyA4EVK1Oi9L+B784Su4/UujFD+3rhndy3FuRieIJQcuVa946vtq60rA3ZluD49PY5DBdI4DdmbW+LS76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvaiBt07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9740C4CEE7;
	Sun, 21 Sep 2025 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484244;
	bh=nzIWx7UZnKV0wXpHNPqCT/yCqNFA4bqMUL38PIecq7c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VvaiBt07Y3GB+wmcIwnAVKi437iCWAPquPOYwYNcbKUgVJ2GbFYH58kz8oMBVpjSt
	 EYp9AfqGNu+jJz2kbsvkBcqUbzFUbpyUhWeeF7kjoYiAvDCHa1FdfCH8HZNtGlIq3O
	 ahrjqCDhK0QUuAuU7BtDA+6hRBJD/Yhq32jfFnpWRQtO4g6RJ2ZvbTDBwqn36P9FjD
	 2tgvN5wmUcbueLCAS5GkEp4WqYBp/h+N7sQu5QXFVOXDUej62ShmrG4eYK+qBe3A+v
	 ItePJO4LWlD3TIZTeH+kHNagRPfVnAcdFO+leFSx9L/ZVhgjt/xrgNUTrQdd97NYer
	 MIUpFrP38+cBw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250919142649.58859-4-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org> <20250919142649.58859-4-ziyao@disroot.org>
Subject: Re: [PATCH v4 3/8] clk: loongson2: Support scale clocks with an alternative mode
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Sun, 21 Sep 2025 12:50:43 -0700
Message-ID: <175848424324.4354.14718670578549381149@lazor>
User-Agent: alot/0.11

Quoting Yao Zi (2025-09-19 07:26:44)
> LS2K0300 and LS2K1500 ship scale clocks with an alternative mode.
> There's one mode bit in clock configuration register indicating the
> operation mode.
>=20
> When mode bit is unset, the scale clock acts the same as previous
> generation of scale clocks. When it's set, a different equation for
> calculating result frequency, Fout =3D Fin / (scale + 1), is used.
>=20
> This patch adds frequency calculation support for the scale clock
> variant. A helper macro, CLK_SCALE_MODE, is added to simplify
> definitions.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Applied to clk-next

