Return-Path: <linux-kernel+bounces-751832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E797FB16E08
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29EF7B08FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B100290DB2;
	Thu, 31 Jul 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSzHP8yH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32D218E99
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952380; cv=none; b=pDi/CwbeW2ELLtLA+D0KMb4crzwvnX/2Lrs9wHLLGUEOTNG3yk/x7MwZRoqMpe+faJdFcZmVJMTsAXP41l6vh9uXv33ZElHCvE6d6ISyW3zFz/VwyLntc5ithOkZMlOPSda934hgOot2sfUsRJ/+Gz5qCLlqWXmCrBnOdE+bMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952380; c=relaxed/simple;
	bh=wF3sqtw8d08ZFqjdL5Eoz/8zYvcLTNhMrj6Qf8+JNfU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JiKRUP9HuWeEDxbtHbAK8DjTsM2eiPsKFdCELx6NEwrR3EA3O1hI0PSNEFMYzrvb6UE5JabXzeods85xjkbXucUE8pBqautHyGtiPpRH0Yk24s8jBXjAIs79hJqbJH7XoF0dzpDf5WKgVkRc1vQlvXoBgAufQ+//8+IdDL0dicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSzHP8yH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3520C4CEEF;
	Thu, 31 Jul 2025 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753952380;
	bh=wF3sqtw8d08ZFqjdL5Eoz/8zYvcLTNhMrj6Qf8+JNfU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=dSzHP8yHwNHEhCMG3uhvP5yafZt80hbKg0d8MwYSyWGWi5UJYS7QkWJWeWGd0JPh6
	 onUKp+/pCJPMYHpy3dKEDK8vix//BgqgdBUFcWYnSjjAydaHgsZbt1dhZNAfG37Iyl
	 KldJnM61bLUgm2lmVHGsoAA5kTu4Fb62pZXDD34Hfg8Wu0HekHQ8QqKv67k/r2R0MA
	 vMW09xCAuQQAAxZiwjkAwQjUvaajqY2N8wId15yjnItDcUQl+mELoJArU2GFVMW+qH
	 F2dk22BCduhN4IZJo0+PjD/JMQjVZhNh7XI3l5f+G48pSOiBSmwT9WOe2S2Q8+nwB4
	 huMaw59hPhz0g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Ioana Ciornei <ioana.ciornei@nxp.com>
In-Reply-To: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
References: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
Subject: Re: (subset) [PATCH] mfd: simple-mfd-i2c: add compatible strings
 for Layerscape QIXIS FPGA
Message-Id: <175395237951.1066658.3222139000178153711.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 09:59:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 07 Jul 2025 18:31:20 +0300, Ioana Ciornei wrote:
> The QIXIS FPGA found on Layerscape boards such as LX2160AQDS, LS1028AQDS
> etc deals with power-on-reset timing, muxing etc. Use the simple-mfd-i2c
> as its core driver by adding its compatible string (already found in
> some dt files). By using the simple-mfd-i2c driver, any child device
> will have access to the i2c regmap created by it.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: simple-mfd-i2c: add compatible strings for Layerscape QIXIS FPGA
      commit: d3a09d5e5ce66a91acfdbcf09d7193d2167b69c9

--
Lee Jones [李琼斯]


