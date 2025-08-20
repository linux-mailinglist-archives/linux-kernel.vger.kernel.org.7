Return-Path: <linux-kernel+bounces-778234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE21B2E2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EDA0619C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CE334382;
	Wed, 20 Aug 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGR4Kexb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56E335BB1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709383; cv=none; b=rhyTzI6Et+DKALOtGwPpA0Gi5WSHOpwC38poFhwVRl7ZxcZ49XU2LPU9iK2tu7TF9oQAfQ1q8F0Fsm0g8N6g6uoLrHPEYqZvz/pnF8rrnb1p6t3bnW3T7WAgXdR3To1dFqa0paYg9s2WDpO5jBvVI3vdz7PX7FBPqVe3vOBhJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709383; c=relaxed/simple;
	bh=SdAZlbYllqKMy/tSyr57ludQpWHmOjbfIk0uPZ7oZ1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ParjOlZ4cW2058yd2hvuZwv36KfE3z2f5ZKcn9Mhz4nipVskkIlL5kXS1sjxVwbQe/b3dX6fl1WigXe31iMss1pS15jG+lgozuIMJUzi0YU6uql1ZaqPYV7jOF9qh0sfjpr0FC5JrkgH17efW2KHd6VLOqSzUSwKnnwQOF6nuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGR4Kexb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404CBC113CF;
	Wed, 20 Aug 2025 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709382;
	bh=SdAZlbYllqKMy/tSyr57ludQpWHmOjbfIk0uPZ7oZ1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YGR4Kexb2xFARGCmFQe3PJsORfVP72Cp0pmXbqH7lj7YL0H7uHY2uIUOe6LPehI0K
	 4NMDEBpG9LWwrQ7Amm89wPXBYyrWX6T3y7oak5MxavCws0azcd43kv6ZA+GZyzPURG
	 XSvP1X/yaZwkq50nc7x9kTOPqgkFh30bfUykLKQ0/wEwisRy/Jha98n4AS54MieU+O
	 IJVb4JNo056cE6zG+UQdTQrIuqQuqljl0yoCxOrnHKyf6879aG9821uO2/OvVheAQg
	 FwHni0aMIzRWucS1dTvgRRXcb+g6u95JW5U0MdlI4dBm0LwhmnlXYBJaGVgyVmtXTd
	 A1LY6+ydE5BWg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, heiko@sntech.de, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250814013943.2905307-1-nichen@iscas.ac.cn>
References: <20250814013943.2905307-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH] phy: rockchip: naneng-combphy: Convert comma
 to semicolon
Message-Id: <175570937971.66459.9785527061700801116.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 22:32:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 14 Aug 2025 09:39:43 +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: naneng-combphy: Convert comma to semicolon
      commit: a8f9de937dbf7bdabda72bd0c51e201e550129c2

Best regards,
-- 
~Vinod



