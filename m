Return-Path: <linux-kernel+bounces-817974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E661CB58AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8718973E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651820E005;
	Tue, 16 Sep 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgGFrS2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD61397;
	Tue, 16 Sep 2025 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985022; cv=none; b=LJynRJAnTogV30FJGL1OTxDwHwnUd2aCrHPcnepYk8xO49pyQPwV4Sk9SwzMXef19l5Nvi+BuM6nGr631giRC2pVzL72vr1VMAaR3x3F8UF+jgDpAj0TSexfi9K6IY8+aMY922Uhp/4fgNNuQJhmA8XD1pCLssZExxdpSax6kVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985022; c=relaxed/simple;
	bh=ZQTPa4qCqNPQcCVuZYmnA0IF9BNND4cuu2KqMd7rREY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=GLasAFlM2dTq7ZDBLQ+iCpYv5mgr6giXzXppA2UqsxGtKbTpnbdebcuITjSa9TzlOmanoPErzF5OB3xWPHGe9Or55D8pRYaCX+ItPzWr1KfXwmdV9JEyjPdY4sJy6SuosFX6yU6plyU5GBYHRrQ3VHjpW5YtBr1caUC2hdLskzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgGFrS2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1223C4CEF1;
	Tue, 16 Sep 2025 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757985021;
	bh=ZQTPa4qCqNPQcCVuZYmnA0IF9BNND4cuu2KqMd7rREY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AgGFrS2o4WwL1ZKfZEFpXhEgHGnfqzHJ5gPlKTVGVLbKnf48eNvoW8T4HWu2WGiRQ
	 IRSKpfiFSjcYxi1I67e7sPy5XWTK0xp12ueSiJnvHaHuNOnp9yrwzqMBHBb5u8KS6W
	 klI3eHO7Id/R7cC1jT3yb8EbKtGWj23dPa7wQmGsYtLXk6oQxqk+6G0F3K+yIncUne
	 MyRvo/3wPzeZrV2gwYCz521jYW5SEqNsYIIOefxrDlKi3HpzSbYzh/cLeJDZ8XSpJY
	 YZr+4+L9lQhKpXXcK2hcZ7wZri53neY5F6phvsCxGKwUS9McCoWf+1DWP5QyQOEgJV
	 2A98CeTju/0wA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250906201657.1734462-1-robh@kernel.org>
References: <20250906201657.1734462-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: silabs,si5341: Add missing properties
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 15 Sep 2025 18:10:08 -0700
Message-ID: <175798500854.4354.9264692780454178471@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-09-06 13:16:56)
> Add "clock-output-names" which is a standard property for clock
> providers.
>=20
> Add the "always-on" boolean property which was undocumented, but
> already in use for some time. The flag prevents a clock output from
> being disabled.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

