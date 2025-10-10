Return-Path: <linux-kernel+bounces-848621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065CBCE302
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1677654751E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4542F1FC4;
	Fri, 10 Oct 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUAvtwX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B11A2545;
	Fri, 10 Oct 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119633; cv=none; b=QJ6TWn2aARofvu2ILCQIl8OlKeJ6mYOSRp94XqhOKr4nFvyh5bhtRYPBRwiEzgF7XKDm+VPFnPcspOcqmRqAAXYcyHloRMV1/H20YgdUet7J4ODysjJXz3NbswH/8hD+Sogqd7huEvHh/NMIeAuSClT7F4Dx6GzDy1CDTPtngOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119633; c=relaxed/simple;
	bh=FN++C03nbaDoVjSBUwMIY8GsFp4VFrAjhQGqg/sS1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojj3JBKGV2Y90it5SKQ1ZYxWi004Sfq4VmCewKf94FZ+jcU7d02FMM5YfgpqTFjjjISfoScJC1Af3+PAhcheGJ7BKOw9e5c6mmynlRkfQEZJRSkShIPp6SdMcjyuyP5j+vd5P91EGx9oQNl34pgqs7Fxr2ecY1H2K5olmWXEji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUAvtwX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F355C4CEF1;
	Fri, 10 Oct 2025 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119632;
	bh=FN++C03nbaDoVjSBUwMIY8GsFp4VFrAjhQGqg/sS1n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUAvtwX/c+Xyggkgv2RJR1UV2+Hr4VRQXyKbfA/BE+PVAlFH29ggmk+QmpbMmT8VA
	 7we7PdgcAsCsLaugYv9uFWnuWlm/l2LMSrtpJ1dAXE2cIDt/vMfYCyhPsTnxzgEVrq
	 dd/To17WRhMl4AYKYSk49WANTr6ULqMvFFzUl0Hv4LKuAyx53ohiUMfCPWyi+AszMl
	 bYJbh5FGym0ifRpUiCAHPWMDBFuuCekYwBCXa+0BG+5GV3HomYSqqO64N+jr6x34gs
	 TVuiDP/uFwa3PkTzZno/qTVyIgfcIH+y9IzgpTiw7ElX0Ww2mSMg1GP8jpEvv51ktf
	 nLtMxBBDdr66A==
Date: Fri, 10 Oct 2025 13:07:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add UltraRISC
Message-ID: <176011962981.619057.17240345269763319785.robh@kernel.org>
References: <20251009082013.1331361-1-lzampier@redhat.com>
 <20251009082013.1331361-2-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009082013.1331361-2-lzampier@redhat.com>


On Thu, 09 Oct 2025 09:20:11 +0100, Lucas Zampieri wrote:
> Add vendor prefix for UltraRISC Technology Co., Ltd.
> 
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


