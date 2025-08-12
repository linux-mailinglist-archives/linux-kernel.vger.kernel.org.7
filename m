Return-Path: <linux-kernel+bounces-765281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE96B22E04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DA1639AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D42FA0ED;
	Tue, 12 Aug 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBf4lzGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878342FA0E8;
	Tue, 12 Aug 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016823; cv=none; b=mDbKnMnS+xP15JAZRc52w654deTy22kGDYYwUwun85I8caVNzjQtCX/iNJc+httvSwVEF+CNs72FuBSPKNBeZ+mMg+NuhPei9lGaTeLZ99snj7ohM8DRjeljKKJSPOD/3fTsVli15Euf1e8iijUsnGLE/4rJ/5pOswCJz1bvK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016823; c=relaxed/simple;
	bh=FP3+W4WD7PYdGcbVMt4lMvxd4MweItxFCQZ2nbvYrjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qnNp3UqMuxxibsVEejdIKxKbYuzoEydBaH2CZ3eIALuibQwsjDA3OWY1WSDGhhlkWbMRgz8lUKct4Zz1k+vg6yjAgf6WhQ3EltIUfQjbS8wJp5A7mqPWarTOOgQgEUYjFSTqsIpzugY+qyf9oqtwkVc/Kh2blUZfzqWQei1N+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBf4lzGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E70C4CEF7;
	Tue, 12 Aug 2025 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016823;
	bh=FP3+W4WD7PYdGcbVMt4lMvxd4MweItxFCQZ2nbvYrjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oBf4lzGWc4rYRw2gl+eWYePVEg2rX8xAxmtPO5cxrradsZi1bZrEy+30vII34i0ip
	 rXKIO24aJoSJzZ/SDOfjHiXC6zQZ7sIZvFnt26+9k2+SI1OBfIY5UaWsbC7c2mESId
	 p2zA5dium/eA9SnECpUQGrWlmVBDIx2CAlMXVAshs83uEqLYDgyViFtVnTakG+uu/p
	 I9ORR5aIbh9ychmRqdBcE9L+dUJztmD6THfbJrchghA0J60wF17glFGHFYTIEy6rJV
	 paENv4Ieoscfn1Ov1ghpoPElf2BaiYQWRzwOyI8qlB73hMlvzw0mTFma+n/3eX62Im
	 JEvehX5CJsFQQ==
From: Vinod Koul <vkoul@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250806200138.1366189-1-robh@kernel.org>
References: <20250806200138.1366189-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: marvell,comphy-cp110: Fix clock and
 child node constraints
Message-Id: <175501682042.633066.13384009290495512266.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:10:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 06 Aug 2025 15:01:37 -0500, Rob Herring (Arm) wrote:
> In converting marvell,comphy-cp110 to schema, the constraints for clocks on
> marvell,comphy-a3700 are wrong, the maximum number of child nodes are wrong,
> and the phy nodes may have a 'connector' child node:
> 
> phy@18300 (marvell,comphy-a3700): clock-names: False schema does not allow ['xtal']
> phy@120000 (marvell,comphy-cp110): 'phy@3', 'phy@4', 'phy@5' do not match any of the regexes: '^phy@[0-2]$', '^pinctrl-[0-9]+$'
> phy@120000 (marvell,comphy-cp110): phy@2: 'connector' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: phy: marvell,comphy-cp110: Fix clock and child node constraints
      commit: 5cfdfc623835d40664f642b75a56d9934f24c5ff

Best regards,
-- 
~Vinod



