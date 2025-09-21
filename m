Return-Path: <linux-kernel+bounces-826355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41DB8E497
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E35717C792
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9D256C83;
	Sun, 21 Sep 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egamWNpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F21A9FBA;
	Sun, 21 Sep 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484965; cv=none; b=nqBdvzrk90IkBpjik5KF4dYMzlKn+mmXRFIReyjiixGCNB6zTdgx1DU8rEi5g/0aDcBN1JaoBN4/+tqHVcGx5XnbqUzJ7FkMoKsy9g5Mfju9xb0U1wnx0fEXkrrfWObAdogNHwmoI47YGEugsDwG6UAVAIZsUhbu05ex1XMhRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484965; c=relaxed/simple;
	bh=9/23kr7l9Mie4jX+p6zICO/yiliJHrV8QtJrD2UJNCY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=B39B9IbWDrpNbeNYxD1V+XnStAcfTMUlXJutgrKaFyXN6C2nHNgZ1KEyiKZSFHFvDAtS5saoTBzl9i4f7K2giVfaLHAD+0bdyo7QOdCBzUSu1c1C6TPXHiCD6bYYdGEQz5mSAc49aa3fpa3AcyfAqk9jz/kkR7TsyodSaNOU4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egamWNpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E98C4CEE7;
	Sun, 21 Sep 2025 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484964;
	bh=9/23kr7l9Mie4jX+p6zICO/yiliJHrV8QtJrD2UJNCY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=egamWNptFAMJt01ufNWDz5LneHoAej88B8H2o0FBQkYMK+U/oa1StMAOJfqJ/yYwL
	 YNsEghEGelGUeRuoLc9dE6MPE9cdHMDGczpaCBlqyvuWQtM1UdbM4b7Qer2bdW4Yqa
	 FjrtUyKcGK6g/VUFkWQyWWXWykaKPe+aON3EDnETtJ3Mde0mvVqnYDXfw5uPo6whQf
	 z76cUS0XYpAjKNuyA/DCw2akGecMZr4Hm4+KO0c9vwseiFh+a4SYStOV/k5hRTpW5D
	 /QmouchIzu4u9s37XCHbXMAOAJeVFsLZdUzzHrOk0mTgbNlS+SwoigzucyOIELapVL
	 GaLsHp2COXbQQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250830122752.57670-1-rongqianfeng@vivo.com>
References: <20250830122752.57670-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] clk: ep93xx: Use int type to store negative error codes
From: Stephen Boyd <sboyd@kernel.org>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
To: Michael Turquette <mturquette@baylibre.com>, Qianfeng Rong <rongqianfeng@vivo.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 13:02:42 -0700
Message-ID: <175848496291.4354.10936954302224095614@lazor>
User-Agent: alot/0.11

Quoting Qianfeng Rong (2025-08-30 05:27:52)
> Change the 'ret' variable in ep93xx_uart_clock_init() from unsigned int to
> int, as it needs to store either negative error codes or zero.
>=20
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversi=
on
> flag is enabled.
>=20
> No effect on runtime.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Applied to clk-next

