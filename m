Return-Path: <linux-kernel+bounces-746287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBCCB124F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C915A48DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73F2505A5;
	Fri, 25 Jul 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw7qKP3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582F10942;
	Fri, 25 Jul 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473285; cv=none; b=QD95Y7kMrQt2tyXg5WAGIjLSOdnEhjtq/Nz5LJR5XuakqGOHxcylpZ8II48zMdsb2AbTUfhbVT8c+rxDoziwdB+wwx3AITz2R5o9ua4AjWHKVNEv7bh7jI/IFSzr0Mcv/M9Zapl0Xu4/a3xyhadzxysMEQJjlcGJtDVL5F9Lri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473285; c=relaxed/simple;
	bh=pW3rxJt28+X4/37fXvYzVRDwoDmbz52C1Wc+pq3v7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYOwmYNBUgqTL1f4PRwOAUgXAVMmocfQCWHwApTMMnPVmMZ8AzQ2vUInxz/+jiTfW/kDxxFLYUJBCkKFuIwKsAFJwGcZEi3y3wX0g6SqfZgnQOHE+wMsfNPinxst3aS9zONn08CoJLqyhe6p+GI1Sbs5s5fPy7GXekW/SxwW9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw7qKP3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2037C4CEE7;
	Fri, 25 Jul 2025 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473284;
	bh=pW3rxJt28+X4/37fXvYzVRDwoDmbz52C1Wc+pq3v7hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qw7qKP3uPidnGSQ0KnCIcJLWmErWw0qLNPO3hscBWe70ZTGoNyYZ5+3H3YdY7TAkl
	 dAOMoYlKyjOx4UA52h8ddfBmt7DQOoTgbyFeoEPd160zLQs0LQcn0YoDdpu0IVln6Q
	 u7zXo24K1iHvayhVA8uRRwDysmwi1kYe62gH1By+/C0xW1vSO6n5OuqaoKV3DVJAFJ
	 kvRocBBP0JPajB7mHbz9fdJSjXLW8YtieXdbFEq3Jp7aR3Gq3TG8DKrE3FdzigEfmj
	 sPnt3Vx/X9YpMpIuvaj9hJOxY+jkDBKGxhQoZ+eJyt+U2fMiTy6FOxwHRSuK9XJEDH
	 utOAIO83G2KSA==
Date: Fri, 25 Jul 2025 14:54:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND 1/1] dt-bindings: interrupt-controller: Add
 fsl,icoll.yaml
Message-ID: <175347328262.1745453.16998846208226729922.robh@kernel.org>
References: <20250724164624.1271661-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724164624.1271661-1-Frank.Li@nxp.com>


On Thu, 24 Jul 2025 12:46:23 -0400, Frank Li wrote:
> Add fsl,icoll.yaml for i.MX23 and i.MX28.
> 
> Also add a generic fallback compatible string "fsl,icoll" for legacy
> devices, which have existed for over 15 years.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v2
> - Add conor's review tag
> - update commit message for old device.
> ---
>  .../interrupt-controller/fsl,icoll.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml
> 

Applied, thanks!


