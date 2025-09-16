Return-Path: <linux-kernel+bounces-818894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C821CB597B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3D166E26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2604305071;
	Tue, 16 Sep 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBM8UdOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047711D7E41;
	Tue, 16 Sep 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029635; cv=none; b=rvDsD7iAAJP21ry05JKjS6Z/AZoeN8dpVVpNKAdkaMno1gYB5YhCyUZWimOVsObeO+b5BwZ/AWUX0ME6RCIf3uVEAK07q6he2pYV9JJa1RIpG2pwkpf/XV5YAgtd9VmAvFXGSwsiGSRlBQE6eFliCHG+9n0mX6y2pRhjWxZ2T6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029635; c=relaxed/simple;
	bh=js/Dhw9q7ZrGUdTOX9dqiXEtYoFHhuhzGJRzbX3urvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byEryhK6Lyd/pKMl2Ri0G7qTjznZlqoU52Zt7hK13rYQxGzm5uIOt32WqkpJ9M/vBH1B2cdC5nXUfCCML+5tnpTWipospzSLsgSf21I/YHyygxA6R+K6fHbMJ78sHRczMzzKei5cAWp4IxFrqBACVACVXuaEhLouPI5y8kFKROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBM8UdOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61173C4CEEB;
	Tue, 16 Sep 2025 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029634;
	bh=js/Dhw9q7ZrGUdTOX9dqiXEtYoFHhuhzGJRzbX3urvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBM8UdOE9kEKABZbSGUJ7s5W3dqN3pkSSO9EJ7+o81jI7c+EeWOZFiIx8C9Yfv1CG
	 SJfyphuo8oAM3EjvHCkAkt4h7AvSIYICOHffGPPuIaGdApicsYD0a2VN6sCQEK6L9E
	 A4sUGJiGBkl2Azt3ch3axjjVKhwdEm7RWSAZ+Rfrq9t80GuxM2l+yWB6oaeXTLWaFw
	 uWEBgAPgfmdph50u+JqEAlgjPhfj0wO12xHhbtbH1DFAuCG0IBJqaKrT0DkdfAPyTT
	 UgL5YixNwz5izOF/z0ZKtxgtxfwvNqKCNVtgBKlWqgeC1U/acIY9vWwhKWbNoaOqUn
	 UrPxcqcCd0CSA==
Date: Tue, 16 Sep 2025 08:33:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Joel Stanley <joel@jms.id.au>, Andy Gross <agross@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Stanley <jms@tenstorrent.com>, linux-riscv@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Michael Neuling <mikey@neuling.org>,
	Michael Ellerman <mpe@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: Add Tenstorrent AI ULC
Message-ID: <175802963274.3650143.11466278944413670465.robh@kernel.org>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-1-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-1-ddb0d6860fe5@tenstorrent.com>


On Sat, 13 Sep 2025 14:31:00 -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Document vendor prefix for Tenstorrent in DT bindings.
> 
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


