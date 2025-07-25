Return-Path: <linux-kernel+bounces-745381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CEB11925
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD051CE1B57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15A2BD595;
	Fri, 25 Jul 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDwJ1nJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9802BE65;
	Fri, 25 Jul 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428415; cv=none; b=usOSovzEpI2xpnQrnMEz6jiyWBR0Ef++lJvJExC2P9POujbj+uR7S6rcW+2r8J1M2MsdT9vhU3mWpctGq4r8S6aTGg5ZGyhZ+MgXREvo40pozDsPTzp6JDAXYGpNVzCzvEqll2efrfmBzq2S9a3XVneVPxRbdaFwXLFePhIIQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428415; c=relaxed/simple;
	bh=zkwE144btqrOh6f3+S/Z0K7VteOTSRKAEctuSxngV2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa/5l50EmOkGwNJVOZONLPPEOEfpCo+C6ctXdtEOya0DuQkqaSDUvrsh8eobXgKpzFNqF5vVKpB11bCj6yBxNyMXJczPKg2FJaNtYPm9ELeqbVBZ7gUJ+DiqqPxTQhCSJrc/xIr9uRXvWwL7RBDjn+xKzX9AWCC3sAFHbRYyojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDwJ1nJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35B1C4CEE7;
	Fri, 25 Jul 2025 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753428415;
	bh=zkwE144btqrOh6f3+S/Z0K7VteOTSRKAEctuSxngV2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDwJ1nJtPnvR1hvWu43yd/wUPqTVHDfBo1LeI2QDBk70GyjlUkLSWdacJK9Gxwowa
	 XrrfUCEkchRJs79dxQ0zCilHLZmwn4kAvM9pJ/o0hC5Q9vCg7ZyjtqnMzbQiiQhJc5
	 vuAPveSPLVF2wKrcvoxAu3f5Qk/jRhIv/6952re1iA6xuSTjyhxTbdmEV3fz6Fqcf4
	 KZtwE+lJ2YesfNNR9PZwzAwaYb9Ezk1lCfRVEH8VoIbezIsp80mi7LFqgj7ckHloAI
	 LryzejqzDhqmyVcXA5rb5M7LzRcC2VEW38wvw7yAGV79CgYfL/c8b2M4gZEINpR8v4
	 bnU3Lo517+ipw==
Date: Fri, 25 Jul 2025 09:26:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add LinkStar-H68k-1432v1
Message-ID: <20250725-muskox-of-authentic-gaiety-b8eda4@kuoka>
References: <20250724-linkstar-h68k-patchv3-v3-0-b9f87b7306e5@tahomasoft.com>
 <20250724-linkstar-h68k-patchv3-v3-2-b9f87b7306e5@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724-linkstar-h68k-patchv3-v3-2-b9f87b7306e5@tahomasoft.com>

On Thu, Jul 24, 2025 at 05:37:59PM -0400, Erik Beck wrote:
> Adds dts for LinkStar-H68K-1432v1 board, using rk3568.  Also modifies

Add DTS

> dts/rockchip/Makefile to add a rule to make the dtb from this dts.

This is obvious and redundant. We see it from the diff. Explain the
hardware instead of stating obvious.

> This board is a compact travel router.

Best regards,
Krzysztof


