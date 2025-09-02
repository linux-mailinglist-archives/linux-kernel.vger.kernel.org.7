Return-Path: <linux-kernel+bounces-796141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C9B3FC62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA11B24D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845827FD6E;
	Tue,  2 Sep 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4YEubKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A402283129;
	Tue,  2 Sep 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808866; cv=none; b=hZ95ZDdJDc/pUe5tqVMqbWaTchnj8N58zXlIonF/VrjA1oiReafORJp2KjETZ1PGtUKTj9zx5L62aleJGhPHD3LZTzi9aPiEr1uScZd5R2dMwBI0jRXvxPt4H7sgrvBwBo1769Oxq6m8ovZTD4gLENm6ScdCBHGvshndYly1Q9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808866; c=relaxed/simple;
	bh=uI8N/k2b5a4xigarocs+SIkrTT3whuXZahPxvc9cJDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HvFssYdIC2kfBHlxUpTI+G7PH43D1+hQe0bP1rc3k4jikp9t1z8QifZjmni/cjJOv0ZWyi3jkV6FGGVtjNapeU681oNYSgsZO1MaXZ23TLiaHWVet5KUOctsNi2b4ZDBU4dEHGh40x+ob5VrqQ+vMy2JVy3XdDuiagYJhmFPqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4YEubKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D52AC4CEED;
	Tue,  2 Sep 2025 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808865;
	bh=uI8N/k2b5a4xigarocs+SIkrTT3whuXZahPxvc9cJDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W4YEubKPosvbbvLXcydxH3vT50Immt3Tz2N2C6tCO7BEc7pMeyFJz3UM2DvAI9nGo
	 nou+4w10IHi7fwB1hKeRb7BmwyPHS7htAx0szzLKCCrzh3N/MRVWMeNfKl51BVVPYY
	 4FFz+S1hDzFlQFU1JaodfHGu+k/GZVlmP+RyINU92NJFpDAzGY+zKV0N9siRpl0teQ
	 t9gnPjkyjK1aTid75KmgDza225aPnHD4MApTsZCWfPHLtLATISIdaN+4YbV0VhTRDB
	 p2pYtoGrepukDslb2nVlY0YYApBO+/2LtEWCa07Ue8hYuyNFXf//l1lISM7gZzf5J4
	 ZNC1D3qKr112g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812203319.729300-1-robh@kernel.org>
References: <20250812203319.729300-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add
 "marvell,armada-3700-usb2-host-device-misc" compatible
Message-Id: <175680886416.2256346.16037341204412579306.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 12 Aug 2025 15:33:18 -0500, Rob Herring (Arm) wrote:
> Add the "marvell,armada-3700-usb2-host-device-misc" compatible which is
> already in use.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add "marvell,armada-3700-usb2-host-device-misc" compatible
      commit: 36be28a566f10d0fde85373f7c674cea1d8e6933

--
Lee Jones [李琼斯]


