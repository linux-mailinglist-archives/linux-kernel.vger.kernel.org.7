Return-Path: <linux-kernel+bounces-800145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B960B433F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4148B3A51BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EE29BDAB;
	Thu,  4 Sep 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRE6gby3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3E29B78E;
	Thu,  4 Sep 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970959; cv=none; b=F+1EfCaHPA/TGj9aIG4hu9kl5xuNE+jIJxV0M/hRC2Sdzwt9B/NLPtj+x9af8RBOrxiL3su2JY+rvvRzf+qZWDZkUtAma6BkG1ZFc7WiRN9dbbRiN3N90fMcj9cO+ws7j7fSXo9QZw1npX4TknoiIsd9k0nVDDDhGXy2sjmX9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970959; c=relaxed/simple;
	bh=ZfDC/ITMRgaGG6h9hvAFUqwnJEvgAnYkZF1Z1AGJOhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2pBmGXcoK4da3sBzhsOqCegpF+p9W8Yc6UuSBAcueDQU4HZnxAqb4KYaFKQjjY+jsZZiz7ayy1JM8BARQ3IA5X4Xc8Pr6GqvrtStggUoHyCqTunKdAyirY0nuyV2lx3vnnD3I4OdREo8/1X/YTPTbMOR3me9WyuJo43kJYbJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRE6gby3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DC3C4CEF0;
	Thu,  4 Sep 2025 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970958;
	bh=ZfDC/ITMRgaGG6h9hvAFUqwnJEvgAnYkZF1Z1AGJOhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MRE6gby3g/PKtN4d283wXDO3RQCpNJ/cS0zZp9OYUHEYIN05Mb7fo42b7vw6srfUS
	 wMRKT5W2AGlOl1EvLwXpVw4ZUruA69531j7AkHeSI9thGPhsufC+G1EsRB+0sWCfb2
	 5RVrZhYzu8S52+Y3gCJATZteAQUoRz1Vm6JN3Sa3T4GdFAilkqzKUH3deOdywx9T9f
	 pOzwHgfk4rpLBaL99ZJDtqfpoOSPSNGiz+LfJBE2Ucvkx5kNVCrYTam5DWaDKKPEIY
	 gbDUNYEMkVJLOhXc6fkF3poKUHo98Z7bxuFGob0GnAFHT13GO760GOsnNugh4zco5n
	 6wspu8B8OOapQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Chester Lin <chester62515@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ciprian Costea <ciprianmarian.costea@nxp.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <cover.1756800543.git.dan.carpenter@linaro.org>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
Subject: Re: (subset) [PATCH v3 0/3] nvmem: s32g-ocotp: Add driver for S32G
 OCOTP
Message-Id: <175697095597.8283.15697258146228301679.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 08:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 02 Sep 2025 12:47:40 +0300, Dan Carpenter wrote:
> This driver provides a way to access the On Chip One-Time Programmable
> Controller (OCOTP) on the s32g chipset.  There are three versions of this
> chip but they're compatible.
> 
> v3: Mostly small cleanups.  Re-order device tree entries.  Remove unused
>     label.  Use dev_err_probe().
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
      commit: a3430382174a78a4a6b981feca44bcaa405e0f2c
[2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
      commit: f7605ba1859724d44a7be4994335b31666110c84

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


