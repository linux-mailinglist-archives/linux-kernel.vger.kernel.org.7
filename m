Return-Path: <linux-kernel+bounces-752000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51937B1702B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8641A16C179
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110852BE633;
	Thu, 31 Jul 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdKSG3Hq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C102367C5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960201; cv=none; b=LEqQYdIPUDDYjZe/mCe84RtVJM+pdEDY3czbARqQBizrJdjsbUPQq4MIXnDxX3BTb9QubEfoRpcTlcNyA/OZoW1DtIkYYN4xCf4IvcM6VqYVoSIuV8rjj1m7xbeORBL7cbBzo491G/eTX4ekCP3qjuRcdnhZv6o2FBgpaArvE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960201; c=relaxed/simple;
	bh=IaumhB1vEQ8mFtzl1x6wHFM0WGMN8/g+r/ERn78ZaHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y8SX8OVCPLUiPTgcjhU1DNxzSQMposkqLW4BMaGTZBacdg4hDKLBrIM90VxBwNPSXLXoSZiumJoa8O+gFNgImFMMrQzoAvAcMZJLdml+Kd7npmyJfDSAkexZ/v+UVcxiT8xiKrirSmxdFVVrYoWqnkk496qx0A283anpuiaQpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdKSG3Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50C8C4CEEF;
	Thu, 31 Jul 2025 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960201;
	bh=IaumhB1vEQ8mFtzl1x6wHFM0WGMN8/g+r/ERn78ZaHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TdKSG3HqmBCZ1GXCAA6Gb1sKcw0l15zuFWAApPyFOUJ91dcMFeqeFlFwc6Y3vvupE
	 3pzR3acZixD6P//0n8DfAC+arkf4RPuIhdFSshECWJ5HOmqZHTqMtK8/3SxWF6NS0n
	 5pwZfa4q/GIH+URgjUvtkvAeIHaT2iUd2bCf7E5hlx3Okbsg27MrjYbeO0LwfutWZq
	 uP5xq+4qGBRt7U+qmrRj76orTXNDQe7mYpMjBQ1vXj8ywH8f/L3x/T9jaCrBV0yQxe
	 NZSmcXEdNUKmBwhlS3Q0c4A1dt5ZjBdIFeu4lnYpevwcQiHDhYQ4GFkhTo2OhSE++R
	 p/y7jdxUNce6Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
References: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [PATCH 0/3] stmpe module support
Message-Id: <175396019955.1137478.912508239747809820.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 12:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 25 Jul 2025 09:11:48 +0200, Alexander Stein wrote:
> this series adds support for building stmpe mfd driver as a module along with
> the bus driver for i2c and spi. This depends on the cleanup series [1]
> just for avoiding conflicts.
> I'm not sure in which order module support should be added, maybe even all at
> once. Please advice if necessary.
> 
> Best regards,
> Alexander
> 
> [...]

Applied, thanks!

[1/3] mfd: stmpe-spi: Add missing MODULE_LICENSE
      commit: d73bccc362448001fa1d3973af69504811b710dc
[2/3] mfd: stmpe-i2c: Add missing MODULE_LICENSE
      commit: 0420aa9dead165d893547af51704a3676634b647

--
Lee Jones [李琼斯]


