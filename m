Return-Path: <linux-kernel+bounces-752194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B9B1724D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9131C21047
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32792C15BE;
	Thu, 31 Jul 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPXZJa6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CA1E502;
	Thu, 31 Jul 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969698; cv=none; b=tt7Mg6DDPG88JYosOv2PWXKFtmwI2tPSk1cG/cAYqzSPhNHTDd6DdYursIlD0oJeI3uguX2pI9T28LxJGVcFrXBDjuH83j7FJeXTD3Cl1Rfj8fYoeUx317jvP2HQpNi37wNTL0T6z4cHdBOVWn4+Xqa6UJZiDB2lliU5/5MI32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969698; c=relaxed/simple;
	bh=Q92AxWyd2wLBi6j5UGUyDa2dOb67fl0UgsLftyKpIik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQpZGXH9i3EABNvKRgkp+A0KWMJdz84LMYT6biNNgYS2mV9DyGovrvhwLu/SQ+69sXKEacxzDvYPzFVBxjoyuTcd9rcdYvyYiIr8Ak26DcFt3WYUEm7618DQGgHex3I/R5ZxvoZr9Q+ReOekB+nD6Zcy779kRlF7X9T0vKwUCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPXZJa6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06822C4CEEF;
	Thu, 31 Jul 2025 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969697;
	bh=Q92AxWyd2wLBi6j5UGUyDa2dOb67fl0UgsLftyKpIik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPXZJa6gj5rXxgdo/Xw79VqAJwhg31mBX5riQDGbZbbJZ8mdQNTdNozNBFd+pHfAK
	 xPe95Gpba4YyMWCOO73WjN7rfBJxP1suTJQ2d4Z7YZ3RbhvkvK90tx13k8q8zpC7A0
	 uNnx7rGE47Ro4dUFgB85nDS7/mNOfMU6ONTJvZ/+ZPh/c9cBoXsJxMGmzsfGopxAOj
	 ifkFQbjDSpqKJsDgf1gdyzsKxVlbc95qvJci4+Jg5JoYonj1s0ZzWQjoDARLCG2EZR
	 X5TdxzPrLma/hk5MIageLnK2665BSik4KfiLN4f5cQW19NPKLGMEmAqCkK7Xw1QpSw
	 7Rxrzx3d0/UrQ==
Date: Thu, 31 Jul 2025 14:48:13 +0100
From: Lee Jones <lee@kernel.org>
To: srini@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: allow
 nvmem-layout child node
Message-ID: <20250731134813.GJ1049189@google.com>
References: <20250730172248.1875122-2-heiko@sntech.de>
 <175396964012.1212829.4001330716835123166.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175396964012.1212829.4001330716835123166.b4-ty@kernel.org>

On Thu, 31 Jul 2025, Lee Jones wrote:

> On Wed, 30 Jul 2025 19:22:47 +0200, Heiko Stuebner wrote:
> > The MCU has an eeprom memory connected internally, that for example
> > contains some mac-addresses for the soc gmac controllers.
> > 
> > Therefore allow defining the nvmem-layout for the eeprom.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: mfd: qnap,ts433-mcu: allow nvmem-layout child node
>       commit: 17edd13a0916c7c84966b4db96fe744986c3a04b

This should have been applied to the previous set.

I eventually worked out why it wasn't applying cleanly.

-- 
Lee Jones [李琼斯]

