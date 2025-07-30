Return-Path: <linux-kernel+bounces-751389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A0B1690B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DE0563B60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD622D9E3;
	Wed, 30 Jul 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiFik3lQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CF442C;
	Wed, 30 Jul 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914613; cv=none; b=qk6d2guAosT8/Ma3uJWzq1fAV1zYMAkufAdSDctB3uJTzRm2aqQVXGHNj1UjP24jkFi2juWLq87sfKlGzdFD3U8jhmpKZGc+6VEMsT0FrcSI64QiBfyM+yEZ5Y/gnSE+EsCJnY18Bhvlun5ZxwqAOgbyxAr+KENHaCTxr7iTi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914613; c=relaxed/simple;
	bh=Ty5hOFOCnqR3+TxmVt5Wrhxdf9KjsnmTgra0uxnT61E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzFrslUihpN9MyUZFB8KqE8RZPDx4xTIMtFTA5jJXJcL0Bm7P3PnTJ3vt/DvRz7s0rvaQFH0W9eKMzr5lFCskoe31wnv2rL8b598znXyrwmIvui/TCu0X7zM9pIQLeJLB0wXt6ZPyilqZ1ROCXXXcMz900kA4zV/M2kPj8Ii/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiFik3lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A7AC4CEE3;
	Wed, 30 Jul 2025 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753914613;
	bh=Ty5hOFOCnqR3+TxmVt5Wrhxdf9KjsnmTgra0uxnT61E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiFik3lQlYH2t1kf5pDvKffiyH4xQp6wAKUJXocuXk+lCYMGQbQa4XtSu+xypdwdG
	 Jx4sou2B3FtFAGUbTqwg84DbujP7thW2iLlQGf2J1rpGBEXiZFWWdokkK/5suUYjtd
	 mi9aRETfoTE9z2gEJMS4yh+mmP4W3K1X7/RowZMIYWjs804Sg/WtiQhclewhZE2mfV
	 cxqaJGhsnlT7LLgyDJljkVrlrIDF0PkAi24p+vwVjO2XeIwpwImwZNbYz9W3efJtYe
	 yB+jk93/JQjJN3pBnY9WxcR2VdhfWl6l5apwAQE18V//PQCHSBW12o08HjnRtoYcmJ
	 ZObIs6Kmneh1g==
Date: Wed, 30 Jul 2025 17:30:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: memory: Update brcmstb-memc-ddr binding
 with older chips
Message-ID: <175391461181.1819073.14169607307672802524.robh@kernel.org>
References: <20250729205213.3392481-1-florian.fainelli@broadcom.com>
 <20250729205213.3392481-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729205213.3392481-2-florian.fainelli@broadcom.com>


On Tue, 29 Jul 2025 13:52:12 -0700, Florian Fainelli wrote:
> The older MIPS-based chips incorporated a memory controller with the
> revision A.0.0, update the binding to list that compatible.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


