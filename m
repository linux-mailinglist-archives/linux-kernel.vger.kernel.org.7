Return-Path: <linux-kernel+bounces-812364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04703B536FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4946F7B1108
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678A34A300;
	Thu, 11 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV4kVXSw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103A3469EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603448; cv=none; b=Fy5wBARj+aXW00Tpl0q0Sh2GKb3BTH7xx2DtilnBVh5VLICriEbt9GEMQQkoPh7/QIruu5n1kRN1gSbp2l405Giyaf2lTqD8x001UBuyoZxMMYMeG7WojEmBApgGLUnxyEtitWTOjo/Mml/vO7RRZXNA7Rd1HZbo6bXqT+5VS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603448; c=relaxed/simple;
	bh=xAoa5Zt+X1DsAQLeFHkUZFMOKBtYmLD+z7l6n7cxsuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oW/uQEiMO+gCLNvAl++tq9WH57F4Eq8BpdlvVoP9xVWQe7gpQfikavDnNGqMNPDhnheCwg1Efi+uA6t7XVnK/Ekw0leRTM3f/F/VB+en8RtGkHuApHCNtdaWJQ3Ejm8FYI2O3tzAnT7DFYvK6paInk8VZP9j+JZS/c11TOiYSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV4kVXSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40C5C4CEF5;
	Thu, 11 Sep 2025 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603447;
	bh=xAoa5Zt+X1DsAQLeFHkUZFMOKBtYmLD+z7l6n7cxsuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YV4kVXSwnaNA2em51xFChAmo4r7T/oi93EPpr2Cjvm/MayuImMm76OPiqHgoJGzlr
	 FqkfaEXSqIW9iy14sjvhO+lD9HlN4cTkas9s6Y5FRBRhyqos6tclvfbByL53pHa/a+
	 lgk4AmSzoVg4jOd3p5xIeXyW659ymLm4clHloh151K4zezne1tMd4D6xyRE/BsrBDG
	 QkJOMdgGsfFz3CIXqRojpBW/wt6+YbBd1pzMFGrHq5uLmU805tyg8QWtSrsL2rwcvN
	 /ZKc/Wdev2kuE7OQZB6axo6XdTHcmiahM6kbTQg1zmr5yEqwDR+freIKXlB1Ve5G1I
	 yFkXZC7aH7Jhg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Job Sava <jsava@criticallink.com>, 
 Michael Walle <mwalle@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
References: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
Subject: Re: (subset) [PATCH] mfd: tps6594: Explicitly include bitfield.h
Message-Id: <175760344663.1604272.4150799296397006732.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 16:10:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 04 Sep 2025 18:26:12 -0700, Nathan Chancellor wrote:
> After a recent change that started using FIELD_GET() in tps6594-core.c,
> there is an error when bitfield.h is not implicitly included, such as
> when building allmodconfig for ARCH=hexagon:
> 
>   drivers/mfd/tps6594-core.c:767:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     767 |                 if (FIELD_GET(TPS65224_MASK_EN_PB_VSENSE_CONFIG, pwr_on) == TPS65224_EN_SEL_PB ||
>         |                     ^
> 
> [...]

Applied, thanks!

[1/1] mfd: tps6594: Explicitly include bitfield.h
      commit: a377b1be3a0ed51ccabfe22908ebde065848313c

--
Lee Jones [李琼斯]


