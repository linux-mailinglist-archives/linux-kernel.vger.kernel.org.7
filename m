Return-Path: <linux-kernel+bounces-826252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F69B8DFE3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411337A988E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9624A046;
	Sun, 21 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0qPF/YA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818CEEDE;
	Sun, 21 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472389; cv=none; b=IcLmTzIc0wLAOAt4XuOU1TCv4WANwJkVyarMFLrWzJMAn0PiCrlpEGoeS9f7b2uR5kXFYi7GIK3d0BkuZxsZ9WuGvFzn22jULGmclFez92Ib/CrwWVA9aseU/fO3hDYU/AyhAwF2WJiRsyJRspDk98YQ4mjjo1oI2/f2V7X7zDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472389; c=relaxed/simple;
	bh=5Cg2M5mdBA51WLv72+0nMAPShXd7ntb3KGFkfyKWP7w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ViwXAseZHnTuBR6H5jiTl18QyMTvmNqafD0bbL2/UcVVXyEfLUDEm2CPe4tsZMv6t49NCdcL53u2pSRyylssyOW/NNs4IQPI0bOj4CAjcTVqntn6QRtulEttCjuxP/ZmKQCjzswhvy5MZnk27g47tKeoYKawquth4/XB/g0fvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0qPF/YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17712C4CEE7;
	Sun, 21 Sep 2025 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758472389;
	bh=5Cg2M5mdBA51WLv72+0nMAPShXd7ntb3KGFkfyKWP7w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q0qPF/YA7f02hqqMlRsC4NpyGBZzmjmEmqfaHItxf4QLx09JqCYD+7TKx6jcgislr
	 raDDQZhdtYgHEuADuCpqPPryWiIvZ3Sad++9rp+vh4sVarfAHVKkpC+9Keb+C4OSxn
	 xfJhnAyBEezvkXjc4+xvPbNKK5cnoOL45sob+91JWJf8m8moLlxvuzlEm3hmT1urxE
	 QwcTqyYj4SKww53v2oclEq7HA6bpk+Lde1PMW5Y51NoZjG4jXHZR41jZEcKPWKpQ/J
	 ucOBJVC0tQUHs+PTWTiUx+fXWXYYA9BmPhy/AO+AbVYZF8fpzfkM7W9Ue8wPRoj/7w
	 zDp8lm76RCTsA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250825150932.3695931-1-wenst@chromium.org>
References: <20250825150932.3695931-1-wenst@chromium.org>
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Sun, 21 Sep 2025 09:33:07 -0700
Message-ID: <175847238786.4354.6043816943509142899@lazor>
User-Agent: alot/0.11

Quoting Chen-Yu Tsai (2025-08-25 08:09:31)
> The `flags` in |struct mtk_mux| are core clk flags, not mux clk flags.
> Passing one to the other is wrong.
>=20
> Since there aren't any actual users adding CLK_MUX_* flags, just drop it
> for now.
>=20
> Fixes: b05ea3314390 ("clk: mediatek: clk-mux: Add .determine_rate() callb=
ack")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next

