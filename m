Return-Path: <linux-kernel+bounces-866841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D3C00C64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A6A189A982
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF7302747;
	Thu, 23 Oct 2025 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwztSIhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66146279DC9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219325; cv=none; b=F4bTHgxzdpJsSIoqs1Y1rnUxMWT5JlUnJM/whp1swK7uzzez7mbX81w0rmTPhtqhtkSZX2GL7DKHLO5rNUxjQhmoX0y4EcBO3t2vwc/AVdvE5jkZ5LZBaqpalsHdd4+7g71C8TiYvFyjCFEKvUXoELXXhey242UHv5KqOspK620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219325; c=relaxed/simple;
	bh=d8rz3zIwAwu9M9rBfgRioNMIncSdp2C2P3bxzwJ3Zrc=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=VtbKYqdM41ZufrpnZiJ2sIIQEO9gLMksB3RGsXvpgDEXyPGvZ22Z+Gw8/rB4Ul9f44ZjsUYYi7pPR/+VzdZ+d49RmdXYD33qa702AwezMyjw2bcycWrQ4DqGS251Oil2RRtP3zsE+ytftGt8id2t//zdAwbN+QBVgy7PwrG3dXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwztSIhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44433C4CEE7;
	Thu, 23 Oct 2025 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761219324;
	bh=d8rz3zIwAwu9M9rBfgRioNMIncSdp2C2P3bxzwJ3Zrc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=mwztSIhRT03cJoNoZebHH56YanbdiQMq03NIX1h9noC1v9QeTAGs9Q91D6f8TLhii
	 onnAFGn26g78iInyewejiE9XKKN5bpmiIHbMvEHvFIzy2i/8ia12GMjHJo6fHETNCS
	 Pm38WssKUcHF+ZcxM4/Kam8maQEtpMowAQYlM1EVxfAcSDpwK1eegxC5MKcTwLyIcf
	 Q+Uy2uKPsLy9ywtwfBKKJKEsZiI8uKApP/Q73NzVl7gNpIniSh4GNPh8ohiNeh4IJA
	 tZTpmtMIvfTzZ95DiMrfop2RTrOHd9UBbAVGwlJMZYsZcbosF08E+2+kB2xUobsiUg
	 APGrKH04IdCnA==
Message-ID: <464a144d33bc61580325aebac55f0617@kernel.org>
Date: Thu, 23 Oct 2025 11:35:21 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH] drm/tests: hdmi: Handle
 drm_kunit_helper_enable_crtc_connector() returning EDEADLK
In-Reply-To: <20251022092233.8020-1-jose.exposito89@gmail.com>
References: <20251022092233.8020-1-jose.exposito89@gmail.com>
Cc: airlied@gmail.com, cristian.ciocaltea@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 22 Oct 2025 11:22:14 +0200, Jos=C3=A9 Exp=C3=B3sito wrote:
> Fedora/CentOS/RHEL CI is reporting intermittent failures while running
> the KUnit tests present in drm_hdmi_state_helper_test.c [1].
>=20
> While the specific test causing the failure change between runs, all of
> them are caused by drm_kunit_helper_enable_crtc_connector() returning
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

