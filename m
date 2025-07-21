Return-Path: <linux-kernel+bounces-738615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71C9B0BB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B7A3B05D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052E1F2B90;
	Mon, 21 Jul 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YbNCu/Po"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5F1E261F;
	Mon, 21 Jul 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066571; cv=none; b=mV0f42clyFn0btQUbJ5A9Nu/QeT1ZEdSaMcoBuBEIlGUOZhLO+xt94c7DKelZo5s2qHM/iksR6lc4MKTZepZ0D7O5in7t/Qtv4g188a1QgazLYh9hsMBgkImAcloEfeNaAgKJrBpiQ4EBfEVTDsvpZn44RwNOG8rpnb1JvUwQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066571; c=relaxed/simple;
	bh=7BPqW1cEZsOLDmMMhilrOtMWGShmritRXRpezUwnt68=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h6cJNvsPy92mnInFi0VKMbysNnt4boXM1eEqkGfASEK68jFdDuPsjujOgJCouP+qWkrimDfkAbeMJHYtYobkPPNtpjnz9IJd5921ZSh7KzqNfQJzkyJVy8ZuuKCD6Hk7mVn8A1Ci1YJh+fB0iYJX0tvKNV6meIpkOvWw0lJUyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YbNCu/Po; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753066567;
	bh=W87XvFsGffB8xGXVZpZqbL392kTL9i9u0J60EHG2ppg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YbNCu/PoNpFniR4YxOHYt4NjifP22P+A9DT730H05t4UKv1cctexlK91Q4ujsAeZ1
	 +PxxKnlv2m3QXa+RJXE3KLHbJr2vqKaRuaElcDQXvGFjENL4NGDoNSuKEz5fsqYF9U
	 AyNaXwUEXGv1UIkM1cZlMylaYwgYlk96Qsv5g+irUkv8hB/hWZ0CgcvX3pWDcUzCe+
	 sjwz5jlo4q3+k6JpjvKIQdyDCU6vkSoSUrytfGnx1doExXqW4rEKmv96/ZS0aGig5p
	 JaG14Uyn6L9IO6kzT4K654SFKQml9BENfSIcsusobPph0dkf6Hx7M2i3UTwNlV5Nra
	 nH5V9H6Xv1f2w==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AA297640A2;
	Mon, 21 Jul 2025 10:56:06 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com, 
 joel@jms.id.au, venture@google.com, yuenn@google.com, 
 benjaminfair@google.com, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250706134207.2168184-1-tmaimon77@gmail.com>
References: <20250706134207.2168184-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v1 0/2] NPCM845 reset and clock device tree updates
Message-Id: <175306656659.1278425.12587512480138536293.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 12:26:06 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 06 Jul 2025 16:42:05 +0300, Tomer Maimon wrote:
> This series updates the NPCM845 device tree for the integrated reset and
> clock controller using the auxiliary device framework.
> Patch 1 combines the reset and clock nodes into nuvoton,npcm845-reset.
> Patch 2 adds a 25 MHz refclk and updates peripherals to use it.
> 
> Tested on NPCM845 evaluation board.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


