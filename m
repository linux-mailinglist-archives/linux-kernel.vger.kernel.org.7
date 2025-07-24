Return-Path: <linux-kernel+bounces-744968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32847B11314
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B85A6446
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206742EE984;
	Thu, 24 Jul 2025 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bediCilz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F412EE962;
	Thu, 24 Jul 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392368; cv=none; b=qTUo7GenNuWC64P1i28kBLCMphvuAgwBUo8jbsieYJVrAW8nML6eP896dE4jGYXCK9Wlelw0ns+Z0hNueiOTfJ9HMCL7tytxb6VG++2p1Yg8El5ji1QbiNCdh9R7rdGYUl0uwTqrlKPMket6knAxtT0IXI2hfMKqARk8DN0av4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392368; c=relaxed/simple;
	bh=d7nh7vIZnOGTJ2Q7+CHcn6S/FQkqs3hhF4VLfbiutBk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=U0+DQ9RADDbj2lQRiC99KwTjJZUt/joWldMn7rmrMn0iRkrRw1hD+j6wz0yS2ko2bBMe5kQSykujP1bH3H+XUJycRFFLnUtippABLhHtzM5K3/LgJ3RfUBQkWC/FOZMh3r2OvUUQajADJNoU/zrKRdJhsv3wXqWiW0UIyv4VQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bediCilz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B05C4CEED;
	Thu, 24 Jul 2025 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392367;
	bh=d7nh7vIZnOGTJ2Q7+CHcn6S/FQkqs3hhF4VLfbiutBk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bediCilzphDUqADyYda7TkSGHJPd+s3alMQJh438M6Xq26Azcxe1d2POQfySLVG6Q
	 NGWV41CKOIQ8ERu2aeq41M3gqnm3AkgtYS19vddlVPl7fp96mUR2XzDkfkR0VzPYn5
	 Ro/jdnkQ14buJ7e36m+xn08jgQKEt2J5EoqF+VKUK0O3SrxOt1VjsVKeKW44YHcIuZ
	 F7JVE4+/imb2J2+gD0duceCke9cwH+UD/8tCt69kkbI1hvSVIALH6ZiXiybMxLURt+
	 Gc2i47TKhgtfDpM+EX0spX+gvpPrVhpOva24IXWFf05CXkPZRmu2QTwk1Y+x0sG9MM
	 vH0jTrkRH3FBQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250606162410.1361169-1-Frank.Li@nxp.com>
References: <20250606162410.1361169-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: clock: convert lpc1850-cgu.txt to yaml format
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev
To: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2025 14:26:06 -0700
Message-ID: <175339236615.3513.13676829954251081345@lazor>
User-Agent: alot/0.11

Quoting Frank Li (2025-06-06 09:24:09)
> Convert lpc1850-cgu.txt to yaml format.
>=20
> Additional changes:
> - remove extra clock source nodes in example.
> - remove clock consumer in example.
> - remove clock-output-names and clock-clock-indices from required list to
>   match existed dts.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Applied to clk-next

