Return-Path: <linux-kernel+bounces-746984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14FB12DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C973C189D194
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A961CEAC2;
	Sun, 27 Jul 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkfrWAcW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3E86338;
	Sun, 27 Jul 2025 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753598997; cv=none; b=KrarwDcUYcMJbuwZ6owMoxzDDhdKIipa6nrGgEZlSY69zMnMVn5ipWi9LQ8XMPI2SOQpu+5Z/AMRT2HR2kF6xXXLGRv9QrDr/Kx+VdRMRRenuL3OLjEaBMWa8xXAxEoiDd/gPOQv/ddT068OgcnhOs3SF7l6gvEc0jTcus/1isU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753598997; c=relaxed/simple;
	bh=V8dORW7tMmAV30KNYrKlxeJictFmCZaadOCk6OMgZz8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qkIlKBEOl61BgD3HcLqexpS6+PGYocnn1WI5ZRpWD7HvgVAltsuLhmclejXDRxWrD1QPerzDPwGYQ0DHo0iyZrx7mJ2YWMoR1hTObXA6WOR/z6FeG3HiMgt5gnCeK4fQuSqB/WY70b5a6vJIf3slKYECtzRxZcv53il+klY01Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkfrWAcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CBC4CEEB;
	Sun, 27 Jul 2025 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753598996;
	bh=V8dORW7tMmAV30KNYrKlxeJictFmCZaadOCk6OMgZz8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TkfrWAcWHX7zsosnsQB0FI4KnLCQOKQ3V7LL4n+fdkaVTrBDFABJGwJmh/OW1vRYG
	 gB9xMtV2FCMzW3XxLaqdRm+FUo6gOlFaRKK9sx6HrrYF9sVbZsrQg3TcizEUJQ0hd9
	 5yzsmkX8Iij62zuIOdNg7RG7mo5GS/dyw7NQn5KRwuiTKyWOGg9X0JZ+rThitrF4VN
	 IUZzCob7yRt0+7/8awaNE5iEsbQf7jBvMmP1ASuDpWh6WwOvcCiN6Rq+QVorFedLiM
	 zpIILQLxyXo9VmY1N02pUFxHP8qz+P9xqE/lVXGu/vKySpLV/nUzpUQ832xNatjHVG
	 fxMRGoWt8Rorg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250723203819.2910289-1-helgaas@kernel.org>
References: <20250723203819.2910289-1-helgaas@kernel.org>
Subject: Re: [PATCH] clk: Fix typos
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Date: Sat, 26 Jul 2025 23:49:56 -0700
Message-ID: <175359899601.3513.3112185819678160186@lazor>
User-Agent: alot/0.11

Quoting Bjorn Helgaas (2025-07-23 13:38:10)
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Fix typos, mostly in comments except CLKGATE_SEPERATED_* (definition and
> uses updated).
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Applied to clk-next

