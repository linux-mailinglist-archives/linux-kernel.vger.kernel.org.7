Return-Path: <linux-kernel+bounces-870178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92478C0A1C0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D18C3475F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F7258EEA;
	Sun, 26 Oct 2025 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDtQblCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888F257AD1;
	Sun, 26 Oct 2025 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761442683; cv=none; b=ExMWPNg2lPhGuqScYNTCKx1FqqiQI6Q8F4+kameEfKxicVS1qcNz559ryiAjPaJhfxGLx9sVcAqdfY1UAecDDKo5hyXjhi797s/zRIK2qbJmVmiMiEs/VGkT7YQ1X9CmQjK4pkzqv+iMkFU8h0LgLm2uqJXFXscAA7uH1EC8phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761442683; c=relaxed/simple;
	bh=2HcKcgB6jHIZesXRvZwKQsoY54Ip9aqZx1tQ9AISVEM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mv7m0PjNLCYO3TctQVmNrtv9jxS2u3Z825AjnZT7CpPLsgf+fiuSjPuanO8F2Ic1auninC7RfKfAY+S8L7xgyoqZZCcaZ+MBJLRFO94HgxphJfFziyB6NPvk5nxq+Jg5IJjyYtXdhKvyXzS1mloo1nFufNe/jigwWwZPJR4VBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDtQblCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49584C4CEF5;
	Sun, 26 Oct 2025 01:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761442683;
	bh=2HcKcgB6jHIZesXRvZwKQsoY54Ip9aqZx1tQ9AISVEM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rDtQblCCtUCUKiRRrygK6a2CwpX8xhd4Qy53wJX6mc+rbr/NyIrFBOFeQYE4d4tSN
	 OnmJxoiUv1+ljxx1vqnrMQaRplVEB+gd4SX4zbzUc9D7KvgJ0ilpgSiblHuTq+DStQ
	 tBLXacxzM3rdEpgQV/8Tek30kaJ9HhVQQqNL2pPxc4mLtWBizUDtHyGPVTS0VKcSW6
	 Js2lA29S4SoDvMYTHw/31B+pVRAYhQtmTCWmv+QxFBN4Dxd2KVqFmixrF8FY/oUNNJ
	 Gsbzfz8XalHnTCYqLi1hZ1y7S6unGA2HZ67YYmwGYekO/yzdr1cyqfC+RCs2gDTTta
	 z6DDT+RAoM1tg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251022-da850-reset-lookup-v2-1-c80f03831f63@linaro.org>
References: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org> <20251022-da850-reset-lookup-v2-1-c80f03831f63@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: davinci: psc: drop unused reset lookup
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Sat, 25 Oct 2025 18:38:02 -0700
Message-ID: <176144268240.3953.1578810481049748800@lazor>
User-Agent: alot/0.11

Quoting Bartosz Golaszewski (2025-10-22 06:51:31)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> We no longer support any non-DT DaVinci boards so there are no more
> users of legacy reset lookup.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

