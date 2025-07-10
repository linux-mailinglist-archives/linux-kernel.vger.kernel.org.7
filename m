Return-Path: <linux-kernel+bounces-725382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B31AFFE50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143BB7B4245
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65CA2D3ED1;
	Thu, 10 Jul 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcgQ97ug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C642980D0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140349; cv=none; b=gRkC5PQvfJvYxkfEC2Q9WVkgAovAnP8p5cfM5mWZe6eCBvD6zDg7M/PhX91VwZKNX7mNXUSrds4jH67KAOYaxu+mdgUdJUt0BL+oA554HOyNYf6eIYMkId6OU73xVlTbEpKtv5BTMk11anex/I0qJX6hC5m/F3zvS9IdKRey8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140349; c=relaxed/simple;
	bh=s094nnHI8Ya6ISRwM2Ef/UymmN9TAegq8YURS8gtBO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P0xEDzPaS3bk2TZhRvezEnYLCOLDkDFDwoGBusKz7D2sRasAnYv7XhsUM05uqRJxL8zBOVwBod7/NlQ++LnIau38TEa0HG/kaijZ92ZifkCCNpC/ox1PCgio09ErRB2iRuNLQ4R4A9jwNpHJ6YAGF2cO3aMFDbDzLN8EY1fomko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcgQ97ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04E4C4CEE3;
	Thu, 10 Jul 2025 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752140348;
	bh=s094nnHI8Ya6ISRwM2Ef/UymmN9TAegq8YURS8gtBO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pcgQ97ugxwFP4GGpXlZYc0BCPdVElEEfwL4Gi4zxpOZdrvMOvJpIdIq1UPgJAmzxk
	 t2ENz4Bwq060F1gsSI63RbiDySPeTR91ay64ob8E0pcMRwUNe1s6+OQ2BPq0SyuhoN
	 6scPGA9HD/GRq+NxfNDD9C+rckqTkG+3ff2PKZRSBpJdVU56I4tgULKLhQzKnMseZB
	 i3cvJcGvWUSFDWiIjGo85plPlZnt2bEexAp/XK+wpvZmOLuFaydebIygrWC3X7135e
	 efPBfCzbDHiLRNQb3XmyE3BrtH7iWMMUmuBkHRJz62ScOZBX3BCAx/WjRElMQ+Chz3
	 cHaSQSLPAQrAw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Fabien Parent <fparent@baylibre.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <r4k3pgd3ew3ypne7ernxuzwgniiyvzosbce4cfajbcu7equblt@yato35tjb3lw>
References: <r4k3pgd3ew3ypne7ernxuzwgniiyvzosbce4cfajbcu7equblt@yato35tjb3lw>
Subject: Re: (subset) [PATCH] MFD: mt6397: do not use generic name for
 keypad sub-devices
Message-Id: <175214034660.1450853.10120775474738135399.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 10:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 30 Jun 2025 16:01:06 -0700, Dmitry Torokhov wrote:
> Do not use "mtk-pmic-keys" when creating sub-device for the keypad to
> make sure the keypad driver will only bind to the sub-device if it has
> support for the variant/has matching compatible.
> 
> 

Applied, thanks!

[1/1] MFD: mt6397: do not use generic name for keypad sub-devices
      commit: aea2ceab5917b72d37a2b2008e9e2489877737a9

--
Lee Jones [李琼斯]


