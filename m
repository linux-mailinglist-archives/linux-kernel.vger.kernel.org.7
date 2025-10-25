Return-Path: <linux-kernel+bounces-869894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C73C08F36
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43DB64E5522
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5452F39DC;
	Sat, 25 Oct 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5cjeQnK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACC2F39B1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388495; cv=none; b=on/VYUvuGQznvQHrp5lg/Jkw0nBM2wJ3dLt7uUkjs/HsTZKx7Jbow7OWC1kEMYTEJHOKbxaSGZcpcUJ6OMhp5ls2ATP3gPSGnGfOoAIeut36sUjGdAFSlW+MbIO1r2QI/D1bmDknE+Xupq/7IVlbC0BDTzLFIb90Gsyo03BqfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388495; c=relaxed/simple;
	bh=WRWML/qbTRtaGVVeIXWArIxHEk0Is/RWAKYy50k2JAw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OFR6xidWlm3FZtQ4yJ4J3oYsPusNEu6W0Ijdrcbd4fVPFF8oMFh8PUJGz7eXG5atYQvQQiwsKI6MREHfiiExzCW8fioCYWsQHQyGsu4evbW3TUqOgig+337hX0MNaKF1hUtP+PMkwkxGptvZDZ3ADSVk4kcRoXdvdeG403jBjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5cjeQnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B9CC4CEF5;
	Sat, 25 Oct 2025 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761388494;
	bh=WRWML/qbTRtaGVVeIXWArIxHEk0Is/RWAKYy50k2JAw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c5cjeQnKpJ4hhbO5vxspkQ70ZBaTNpUD3aQGBvHOC9J7a7a90eg1Zml9me6JJj07l
	 pwubRTjruH6epypgMG7/U2TUNeLMl1V+VztgFBBsT3BhXQ5d8yGtHZjGfnomwOXvIx
	 OXUV4EMP/gadYJmLoDAUxAZ3MPs/44F42P70uqN895DNSW37hVC55ZoftXrtIF+6jh
	 tXawtHBzrfZwEqiriITQDCZGMpEcFEth2fOPJHOiQMFOJ6/oodT3x28SutH9q0SKpS
	 UjbMiMcsQMLH6Sqwef+8A2Wx7cZRoL89WF4b40oFPektK3RauzBEB/AdJjSUW2I9Nw
	 X3lO0RXqSvi3w==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20251010011737.1078-1-vulab@iscas.ac.cn>
References: <20251010011737.1078-1-vulab@iscas.ac.cn>
Subject: Re: (subset) [PATCH] mfd: da9055: Fix missing
 regmap_del_irq_chip() in error path
Message-Id: <176138849305.19465.16067508552534255451.b4-ty@kernel.org>
Date: Sat, 25 Oct 2025 11:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Fri, 10 Oct 2025 09:17:36 +0800, Haotian Zhang wrote:
> When da9055_device_init() fails after regmap_add_irq_chip()
> succeeds but mfd_add_devices() fails, the error handling path
> only calls mfd_remove_devices() but forgets to call
> regmap_del_irq_chip(). This results in a resource leak.
> 
> Fix this by adding regmap_del_irq_chip() to the error path so
> that resources are released properly.
> 
> [...]

Applied, thanks!

[1/1] mfd: da9055: Fix missing regmap_del_irq_chip() in error path
      commit: be8512ed15826a24f4599ac48dd6168f9647d47d

--
Lee Jones [李琼斯]


