Return-Path: <linux-kernel+bounces-869830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE8C08D08
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD611C6533D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E82DC32B;
	Sat, 25 Oct 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4Z3/HON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626422DA776
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375982; cv=none; b=JD4ItQEk6uZDJQ3DR+Zedf3Tn6tzaX8jkfQ5cfJc4X3ux0HZOOTb7rFONIhy3rusUL+HTaqiqGaTN+VrjBLJLhFuHAfE8ZRxf8y48PVK/ZK7Qk6+atdy0dD1CL38beOMoWHH3dySKJAJwdC7yMlZYULcD3KKBiQqRredUNhuI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375982; c=relaxed/simple;
	bh=sYp+Js4E3+bzU3qzbHlEnJXPbRsGbFxtzKuDGYHaj5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QaCEevPudalh293I7B1bgHnUVH7vIIwekob5Jquj5A/Da5ovp4Qskm2m/87J4UoLUWphsnb5OS7ArjrWzigc3hX9rzlU7a6xCRXde13UlqEjn1qjSX47T4skyeHqeCVx4iiw3drD6U02ynQPLuoBgrhRPlgdAQbLJ/A9bpe4ek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4Z3/HON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20680C4CEF5;
	Sat, 25 Oct 2025 07:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761375982;
	bh=sYp+Js4E3+bzU3qzbHlEnJXPbRsGbFxtzKuDGYHaj5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=A4Z3/HONJy1z170Q40NOTVjAQTQmJqSgkZSZTM/C29LEmgYJ5IKV7nLfjXL45FY8S
	 Va5GDodRTH1KKH7u9BcS5Qg58F9AJ87Fd4Wfprv9es47U5lC+QG3OfLcmL/0mTUtCn
	 XtGwVS2DLeDV7nMYkYADhYvWYj2D6qd/R89f/IS5UGaQOzgA7xMf/aR1hz1m9nRqYc
	 X/PKYhvhxk4XDrCTK+erYZPzkjrU3liVmh3invDR5paY1IilwLqb9NBzS4RFGy7wO8
	 hRUgZWDocM8bjjR+z2ySjvr27M1QKErJyTM2hKDSKnUz6czPCwRX8E0T2thN3//oNp
	 WzsKUpiFG6AKA==
Date: Sat, 25 Oct 2025 01:06:20 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Alex Elder <elder@riscstar.com>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    conor.dooley@microchip.com, dlan@gentoo.org, Frank.li@nxp.com, 
    guodong@riscstar.com, fustini@kernel.org, geert+renesas@glider.be, 
    cyy@cyyself.name, heylenay@4d2.org, apatel@ventanamicro.com, 
    joel@jms.id.au, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a
 module
In-Reply-To: <20251024191550.194946-10-elder@riscstar.com>
Message-ID: <9307eca5-deb9-318e-9ce9-29ade3650758@kernel.org>
References: <20251024191550.194946-1-elder@riscstar.com> <20251024191550.194946-10-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Oct 2025, Alex Elder wrote:

> The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it as a
> module in the default kernel configuration for RISC-V.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>

Acked-by: Paul Walmsley <pjw@kernel.org>  # for arch/riscv


- Paul

