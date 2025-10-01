Return-Path: <linux-kernel+bounces-838408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6BBAF1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8743A5541
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9B2D7DFF;
	Wed,  1 Oct 2025 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYNnErEG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666092D7DE5;
	Wed,  1 Oct 2025 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759294513; cv=none; b=hvW9WBldmDeNSe11M1GGdGgLX233dzA8DN0wqXUCbpEzpnXEWVBqaKbttAmiXsgm7dFkemIaFNOnpy4Rp83obHm9bikMbjnt6JyeaStdONRC7ch/6HTpvNaKmVgJmS6NBl3486SOD1AOxzp6CICdLKxd+lS5XqKHPbtk3qyBqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759294513; c=relaxed/simple;
	bh=kwgHjF/CX5jE1SbU9T2drpu0MB7eKu61y+LTz5rJkUA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Tc6+c/3PzRM84AY5yN8sAbRIL3/DU9Ye8BsBpxuUIvz6X8inJUw3HgY8k306hgbHGHUXJ205DNQrc2LxQQtfDksuWWWfc1Q6qgy3mSN9/vhmoIm/XMAUcb0rrLcT1oX6qFeFgTIf3MPByasmEJ6wOb5omYarWuhpjfK6Q95vdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYNnErEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3930C4CEF5;
	Wed,  1 Oct 2025 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759294511;
	bh=kwgHjF/CX5jE1SbU9T2drpu0MB7eKu61y+LTz5rJkUA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DYNnErEG70eS4msfgR2urQwubpvLfs96k8drUp5q+dvyzLHCSM9lWA03xc78g/+o2
	 yhUoAGaANRmOudJIwMBEPp12+297GMakGrEW+J865wquaEcJEwDkDsVfn/Hp8Yr9+e
	 /9dOyLZ07tuOb7dmW0FljuzwvVfjMaCa4o0O4qttcsmb1+Z6su/mb28nf9yLf1SiUw
	 ZVw6cmZH9lwtDR04c2ddiyD4ydEdp78xqfMF1IajkaxhLZxcW9FolXZ1BNRe1TqBUt
	 3+FpJ1Tf9DjZvqZTjlzYQrPnYnvn4pU6OyjSjhrytkkbksedllolypUf7trDHZEuv1
	 m1wX+VCvHAQ+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250927-clk-microchip-core-compile-error-v2-1-3473dbae3625@redhat.com>
References: <20250927-clk-microchip-core-compile-error-v2-1-3473dbae3625@redhat.com>
Subject: Re: [PATCH next v2] clk: microchip: core: remove duplicate roclk_determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
To: Brian Masney <bmasney@redhat.com>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 30 Sep 2025 21:55:10 -0700
Message-ID: <175929451088.4354.12910948388139998250@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-09-27 17:34:34)
> Fix compiler error caused by the round_rate() to determine_rate()
> migration.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509280327.jsapR0Ww-lkp@i=
ntel.com/
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

