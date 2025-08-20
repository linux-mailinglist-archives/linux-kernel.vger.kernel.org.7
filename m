Return-Path: <linux-kernel+bounces-778238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53EB2E2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C7DA215AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE03376A5;
	Wed, 20 Aug 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNlWh2Yp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5533769A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709402; cv=none; b=I44qmQhW99/1Qx0V0wcJcFfXTaR0zC5t/SkFlySWrLoS0/FHAilmynsJq2Ol7jhbwLkb5vwsAmBgGcfPmCzLODyqZWIX7eyfn59DSwJPTfPR9F5nVpRG9OkqFr88rmcde7jDSDwnWpfPXS80J/jPkCwwDKYnr3d5MWb2Pqc9L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709402; c=relaxed/simple;
	bh=SElAD61LmEC7ET4fpxDnqoBXRvOTFLxIg4jB50/P65k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=foCrMOiY9/paA5uf0PcAH4oqXSYfjqJrJ3NbGPbSGQWNFd8oEveNYNnOqBzKknDZPrVJKJXD1vOsL0+2Id5T6QjxTFoq64Zv48NjFMLvJDE8i9DLSsjiWxbsJChmiKnQQnAnr00gqgZ9koQQ8O4Yjkxyp2vPhPbryINjDHFR1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNlWh2Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AF4C4CEE7;
	Wed, 20 Aug 2025 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709402;
	bh=SElAD61LmEC7ET4fpxDnqoBXRvOTFLxIg4jB50/P65k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eNlWh2YpJZPhyyLx498h2TO6tswQhXtvPVHFjQRkeaCr52XNN4goQti+2t5h7mE9+
	 Oef9XQB426oNQywLxIXFJfo0eWv8UjFyjSQCZlrS7l2QBhOmqg9DpCHzd0KjePZYl3
	 L0Femuwq5Z3XGTnpZCF1fSLHaZSB8ZJwLtBGNVRrLdHyiZ9ribJ+Tw2enofOfE460A
	 83eg+Wzui0gjQZ0JZ9ISJ9mXDQ2yNUQR10Y9F78SJDZWRRfo0T6XvbO9P7Z1MBt+JV
	 fRhsSwlV9un+f5M19o0g7cw/o6C1x4m/y/9bNyrsRfzu/ZSP1ov1VS6wr8J2dHUG2t
	 xw7aTxN1EA7eA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, aric.pzqi@ingenic.com, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
In-Reply-To: <aIIMW971BYsIk4As@bhairav-test.ee.iitb.ac.in>
References: <aIIMW971BYsIk4As@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] phy: ingenic: use core driver model helper to handle
 probe errors
Message-Id: <175570939883.66459.13384631190910835404.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 22:33:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 24 Jul 2025 16:05:07 +0530, Akhilesh Patil wrote:
> Use core driver model helper dev_err_probe() defined at
> drivers/base/core.c in driver probe path to propagate errors.
> standardize and improve the code of deferred probe error handling
> using this helper for ingenic usb phy driver.
> Inspired by,
> commit a787e5400a1ce ("driver core: add device probe log helper")
> 
> [...]

Applied, thanks!

[1/1] phy: ingenic: use core driver model helper to handle probe errors
      commit: 38404274bbee1f0001a490c0dc98aac32a4d7c9d

Best regards,
-- 
~Vinod



