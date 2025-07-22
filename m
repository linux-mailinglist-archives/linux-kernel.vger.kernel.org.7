Return-Path: <linux-kernel+bounces-740764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F0AB0D8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574747A80A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CF2E499F;
	Tue, 22 Jul 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHBT9260"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D92E427B;
	Tue, 22 Jul 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185847; cv=none; b=ROWcAvan38O+75/jjtC3tfXhE3W2D0+PltWJZMDwi4HxGe2lq2EjOvB0vs5gleHBwA1EmIFknCao8g5aVfHfYyGPmujBiITj7HM4+GGb+LIPuK/lHEAk9euJUxuWttSCN2dQMArPgd+0Hxcxpb++MDDC5B1rKGChxxbumRffGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185847; c=relaxed/simple;
	bh=I2lMK5yIvdP/jA9NOaRRPQBYgXxHPBZ+mNpgrZMCBq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bMe06KUdisjPyU2IsTzPLvBtuxwL8EzDUj0ZKLbJzuHEJWS6J1e88XV4Ni3E9UMztDxY4aBJBRfBpTSX5Gtdqup5OalYXlz7cMSLOhrU0HY0swWcLLoH+twR/ZChhP0Fw59iHboePruZklYBz53kLpv73EDV6Q/CtgFRdtmaWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHBT9260; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4B6C4CEEB;
	Tue, 22 Jul 2025 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185846;
	bh=I2lMK5yIvdP/jA9NOaRRPQBYgXxHPBZ+mNpgrZMCBq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HHBT9260gVBegZf9q2/s/DtGProGRQ1gCMD5dFK6I38rSALrKr0sKf5rgiAfF4dKH
	 3JbG0igrR9eTQy7afQUfp4FuqNGJFPG4+b8+sVOWmgq2SRfNRXzbg1ZWQTZ1vKF97t
	 E6CBCLH/P7XimWXA/PvOM8JZtIgbfu0hb8EW15bJ9Wx1u2DboCQ54n75hizeCEHdCb
	 BbUny7Ulx0Zu1EAw7fA+iAbmy4nGGTJFlRB68IGwDNQs0OrlewuaotfGUO3S7RigQ2
	 OAmTHF650Vl4sCxK67ogTy2pyTn/jgOzTOTelOxSh0bohxS18stpj1KP6LC/W7FO0g
	 PcsrqgT8cGSsQ==
From: Vinod Koul <vkoul@kernel.org>
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, sanyog.r.kale@intel.com, shuah@kernel.org, 
 yung-chuan.liao@linux.intel.com
In-Reply-To: <20250721084729.102130-1-suresh.k.chandrappa@gmail.com>
References: <aH3LEmB3hafb3T8E@vaman>
 <20250721084729.102130-1-suresh.k.chandrappa@gmail.com>
Subject: Re: [PATCH v2] soundwire: replace scnprintf() with sysfs_emit()
 for sysfs consistency
Message-Id: <175318584458.92576.2976362021387846762.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 17:34:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 21 Jul 2025 14:17:29 +0530, Suresh K C wrote:
> Replace scnprintf() with sysfs_emit() or sysfs_emit_at()
> in SoundWire driver files to align with the guidelines
> outlined in Documentation/filesystems/sysfs.rst.
> 
> This change improves the safety and correctness
> of sysfs attribute handling,ensures consistency across
> the kernel codebase, and simplifies future maintenance.
> 
> [...]

Applied, thanks!

[1/1] soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency
      commit: 35323d8ab811cc8a02dc9ae9f60fb22acecb6d59

Best regards,
-- 
~Vinod



