Return-Path: <linux-kernel+bounces-800108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B2B4337C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C3480067
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD728A1D5;
	Thu,  4 Sep 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGfYw72w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E03288C2B;
	Thu,  4 Sep 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969930; cv=none; b=W3uNKzsxQkaGrdiehu1Ax99Xplz+gBvmdMzed6K6FzPYQqfZe4FbjVAo6KvWHZPVH4H2cSIYSmo0Z/khyMRcCyoIJGcnMxGF+bjKZVcd0RpYypxm/zurbB8gOqa+42YZgyTfVS6Ef2nLFXhy0CA1YqrURd18XBfEWPx44nwsaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969930; c=relaxed/simple;
	bh=nsWPOXptcws3LmA2fzzVR4kyWSf0qK48tWyV8KOMfak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VM1bzmhpmLudeEcqrT3gShtxsJIUoaW1uD6vr1X+iT7V551pma2GDJuyIyiIy1CM4suWQmwDG8AXMSZL47rRTDcXZc/xZo/ES29uv/MOwXbJDL9wlJ+/74p/4zSgKPCdKs5RPPArNjXtHbL+Mj7cNeaus6TyccYzqc9gVA3JZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGfYw72w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED2AC4CEF0;
	Thu,  4 Sep 2025 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756969930;
	bh=nsWPOXptcws3LmA2fzzVR4kyWSf0qK48tWyV8KOMfak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LGfYw72wKDHtgABcH0eYmfwUwEzVp7T4dFppUFX1/VdjlgQTZp5RODeKGpYRuwHEf
	 yu0xeo6JvEC+qYsWAwpvfgh3dqH15lI8yFEWGCyzc2mx1sZogoSL0a7JZRZad1jFO8
	 WwJ8KNrqwtbhv56bo1U/fl9R1sdFTUaZf4ATobzRAf5ZNUMZrNX/QuELmHvoIr0JI9
	 ROjDo8BzqKqz2JzYbvcgh1scsoKTy1bfw/5GZV8TROdJgT10f9mGF09FDxQB7uN5DL
	 8LUXKUij0o6OyH6D99wBm/HoudKi4pVePHnrlnOoaHGyOEWVNFpAXKZx3Rbv3Shdv7
	 lhllXzdcIRy7A==
From: Srinivas Kandagatla <srini@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902071305.88078-1-zhao.xichao@vivo.com>
References: <20250902071305.88078-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] slimbus: messaging: fix "transfered"->"transferred"
Message-Id: <175696992890.290094.1187086751443771707.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 08:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 02 Sep 2025 15:13:05 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied, thanks!

[1/1] slimbus: messaging: fix "transfered"->"transferred"
      commit: c5c87fc9fae7fcc86671f23f15f61fc13167317e

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


