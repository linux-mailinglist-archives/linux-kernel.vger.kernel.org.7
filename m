Return-Path: <linux-kernel+bounces-765292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D339B22E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871351896DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CDA2FE598;
	Tue, 12 Aug 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Vf9Gs9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF32FE56E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016908; cv=none; b=X5teBVS3A6RGc+4qt0ZuFDxWPqv+ZKHg6PFMaz9LE/cFFIsTLiGd/3hXyc+iIw/zDj8VIvaDHwu4QEUWI1yPkv9TysyPK6T+yxqhZ9PrZzP7QAN+Hy/DEp27Oep+cX2WAU9PlYp9NaDz9URPECIzYzuzqI8EKXEYDC2nZ8f7yfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016908; c=relaxed/simple;
	bh=hs1EeUJADn7q7ZOde0HvLyucF1ZRGoxSA8x+URMHgOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ArggZS0/IeZb2Cp2FkkFCMxjnLThLC70A/kxzBZ14tPmLwxBhoYd6hYs/44N4hrbnjK9X9NFliCNy79DhkWKF/zNgGKzHwqI7r4MbCTGvCh4NbjFn4EhKy7hLx14MjjsOsUK1mR2kVmdMUdcbtJ5fwTHw0xXV5EYnVieBypuaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Vf9Gs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37333C4CEF1;
	Tue, 12 Aug 2025 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016908;
	bh=hs1EeUJADn7q7ZOde0HvLyucF1ZRGoxSA8x+URMHgOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R7Vf9Gs9kQtNWGFJA+PkvyG9xazwBDXkknHrhuHeZnwGDhJlT+G24QynElQny6HB6
	 P/hAwS95X9AA+7AGhgGGof8AioNlen0OLkK/1y0dwLo4x/Zz2vS+/FHtJAxpq81Lnk
	 0wWTIyF5HcSujyUuqJ4RSTKIylS7HLh7zzkjjVELjhLBy76z3fZG1olK0DJr4OTwqs
	 iztpnDTIl8qLg9A1LHWLEMCM276dpdNWQqfNT9omvaxm2+lmCoEjFSwyiC0OuX297a
	 7fWoFYgc5heZ43C9bKv3+7ZEybyIjcO7yJKQC2pc39HKGo7E+7HEU38qEm/R3dTr65
	 N5bshTLv2i7Eg==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
References: <20250724154823.15998-1-johan@kernel.org>
Subject: Re: [PATCH 00/11] phy: drop unused module aliases
Message-Id: <175501690578.633310.16974700832772559803.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 24 Jul 2025 17:48:12 +0200, Johan Hovold wrote:
> When fixing up some device leaks in the TI drivers I noticed that the
> commits introducing the leaks had also converted the drivers to only
> support OF probe.
> 
> This series drops the unused platform module alias from the PHY drivers
> that never have supported or no longer supports anything but OF probing.
> 
> [...]

Applied, thanks!

[01/11] phy: broadcom: brcm-sata: drop unused module alias
        commit: b4e1e9108c948896661ecf5c61a29f6086e53f38
[02/11] phy: broadcom: brcm-usb: drop unused module alias
        commit: 33e64f6e38b2dccbaba8c3533cd0c45e1245c205
[03/11] phy: cadence: Sierra: drop unused module alias
        commit: d81e02d02b5f0c0f53e6cfb8982489fdacd546b6
[04/11] phy: hisilicon: hi6220-usb: drop unused module alias
        commit: b4d4af09092b50b940b37892445f0ae5a007e888
[05/11] phy: qualcomm: ipq806x-usb: drop unused module alias
        commit: 8cbb931b8ac285cd1ec46f8764a91a627704ccab
[06/11] phy: samsung: exynos5-usbdrd: drop unused module alias
        commit: a4c3d8015f4298d90d4d145101dd04de8854e6f9
[07/11] phy: samsung: usb2: drop unused module alias
        commit: 7ee2e0347cc781f0f87777558218961c51ec6aba
[08/11] phy: ti: omap-usb2: drop unused module alias
        commit: 36d20c023bfe98eb999ec5ba4f051460f6080564
[09/11] phy: ti: ti-pipe3: drop unused module alias
        commit: e709cc0741e8f155a39174d97eb9ae9c0cba2623
[10/11] phy: ti: dm816x-usb: drop unused module alias
        commit: 00837ae34f6321f9b6c290f92eb369e7f9259d41
[11/11] phy: ti: omap-control: drop unused module alias
        commit: e04f91e1d881120ff97389960cf7c765d510213e

Best regards,
-- 
~Vinod



