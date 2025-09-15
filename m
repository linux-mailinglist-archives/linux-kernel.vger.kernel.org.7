Return-Path: <linux-kernel+bounces-817112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B9B57E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3EC18912C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57253009C2;
	Mon, 15 Sep 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFo6SJFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D31FAC37;
	Mon, 15 Sep 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944431; cv=none; b=Ry1tE5bDzWcR7moyjphrwKntA7Lixy5d/Biwa0qyg9blYbgjD1fhg+OYscFm19J5cFpRuYZqS9nfR9ddNrCPTtse+hb9DBnwEbd3qZwK3ALqpPqMYvtuYx8zNsg0c3r2beh4QudLIM3yBPNwCjgX6n1qowx2PPeE4/81aFO9xq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944431; c=relaxed/simple;
	bh=2L0TCLurcQikiy6LERWvyLU5Bo9wU2XgceSFsaPD02E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q04yicFHUqKcnXrcdgYXtFwFZD8NjdB3/PBmMj56huVk+vRPgW5Iq/e/pRbya/CIVzBeN6ACLKc1w3Au5PKKU7IfH9Pk0hylZRAex8q5qwegEPFAWf7ykVCHazIw/n2GupPW546QgRKH6N2o7489muee19Gkxmc6VaCNstphLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFo6SJFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E863BC4CEF1;
	Mon, 15 Sep 2025 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944431;
	bh=2L0TCLurcQikiy6LERWvyLU5Bo9wU2XgceSFsaPD02E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFo6SJFppr+gpyl9VOZqDgu6d5hrCbvUYTK2ilkYtJZt7dR2DI/w2VKQzI+VHxIyp
	 DxfNnnnB7nL2DsbfQlYyHDCC0YAHTmuH1i3HHL9pI6c70vyvJ4qO7xd5F9ETcoe5RE
	 HFveWnFpb3he3WPSqbmU0tk2AtKnem8aQhyzdVEP4vLe+55QrMRpVD5FOZ5UsUdmKF
	 96duNO/Jn70uu7Y84TN/ZWL8FhMHgKO+5H5/S5zzsNOD3AeK7RWh9AJDWKfJuqIFDK
	 nMlldIAsVz5ifxOHi551Y67isBPB2+xMiwy612mNXuW5S1Fo6sf96pnp3h9ExebYbp
	 QbY4zDeGQkziA==
Date: Mon, 15 Sep 2025 08:53:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>,
	linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>,
	Stephen Boyd <sboyd@kernel.org>, Neal Gompa <neal@gompa.dev>,
	devicetree@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH v4 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
Message-ID: <175794440092.2724212.9818605948916059174.robh@kernel.org>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
 <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>


On Mon, 15 Sep 2025 09:52:24 +0800, Nick Chan wrote:
> The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
> existing driver for t8103's spmi so add their compatibles.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




