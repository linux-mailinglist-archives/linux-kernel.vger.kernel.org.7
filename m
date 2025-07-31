Return-Path: <linux-kernel+bounces-751997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D45B17022
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BBF7B12A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14552BE633;
	Thu, 31 Jul 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5sa9myw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506112248AC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960053; cv=none; b=MQyt6mmR94156pMui3B/1+Yv91MGWtcEQK/fNvJljboOTqtMEEEei6TEdcwlJgW4DiTxj/UG1CoeciDjcHd/ps/SIM7k5tYPx5FdwpWw/aepc0ZJlZtHiUHACM+X9o+xZnnY3h5oilj8W3E2rfPlQLQDVHb40OrSG/f0LZS3jrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960053; c=relaxed/simple;
	bh=lImUF4ZBLpMGdiQw17RNIr2Nu7symGY42Ol5dyS/my0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KYe43GhbGx+d+nmdpgebWrNFpuE1KFshF5s5sB8kkjg57ITL2IcKEP1ckRFeQXzR4KSTYgQKsDeORK5RjhuQ1fu3hAouS1xwBunDSuag1lMToHS0FFC1ojRwV3Ma0D/3vZRTN7/gTF5cP9IUAVJ1agePujyTfKeb2Bjfr4J3ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5sa9myw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F662C4CEEF;
	Thu, 31 Jul 2025 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960053;
	bh=lImUF4ZBLpMGdiQw17RNIr2Nu7symGY42Ol5dyS/my0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j5sa9myw7oph0xRcf9vzdbBI9ib0DttNAG7pQVs+GCx2Aj50jcDjDC9bNeccsa9iw
	 GEweFBIvozaSBlNPYgni5JdREY4rOmRzqp23BFivHJOP9SrNxC7OhTle/mJJP7OHSR
	 6yqHiXxKDX4/qzbJ1+AdA07otcCn0tWaU336YIZ5e9zfMx2RdnNEHDru+DdZiAKSan
	 l66isLmjfIzLl37duak+t4C2QjfywXHL47YZilOIzqEvXzny2WU+1kotiTAP81zchK
	 dXWwNny5RGIw72DEfBToY5Wgt/aafuwTVqnXFMAIJju5yS+nDo99OAOgAgmrbK9ta6
	 nXBiYoBjWQ8fg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
References: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/3] mfd: stmpe: Remove IRQ domain upon removal
Message-Id: <175396005138.1136000.8754984127512092739.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 12:07:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 25 Jul 2025 09:07:48 +0200, Alexander Stein wrote:
> The IRQ domain is (optionally) added during stmpe_probe, but never removed.
> Add the call to stmpe_remove.
> 
> 

Applied, thanks!

[1/3] mfd: stmpe: Remove IRQ domain upon removal
      commit: fa4302510dff9b9cfc7e66308d6a6629fcc5265c
[2/3] mfd: stmpe-spi: Use module_spi_driver to remove boilerplate
      commit: 907c01a9b01ca5615f6c2c488321c7aad469933b
[3/3] mfd: stmpe-i2c: Use module_i2c_driver to remove boilerplate
      commit: a18d83d2dff7ecebc45eb6c285120b0c664093ce

--
Lee Jones [李琼斯]


