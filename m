Return-Path: <linux-kernel+bounces-856611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0961BE49B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DAA422BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387622E2DF4;
	Thu, 16 Oct 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiQU7EmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163232D0CA;
	Thu, 16 Oct 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632387; cv=none; b=E16aanKqS6aGXKUcAV/qLzlrCY0EdUQxqs/et+e+3k78aAgaM3AOaZiudmiHg98kG4tT8w/KG7kFKh2owefP/bUDBb5evGERTBDNc93vM0pk9AI0/HuM1STehPikJ0b4P4rHARWMALW0ebJ92f6UjedihHsmS817IVt5n6/+Puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632387; c=relaxed/simple;
	bh=Ps6/tS1Hgxj9m4RTd+Gf9Pe8KrRYTPDWnoO8GqQp4fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+a4IhmU0EjQ+JrKrwyIF+PbVcXtQgXMFcx9AJWvP+NpMwdIRGntgAleVCJQ0eGu5P9lcqwUtt/L41JRoDa18/FLjZ4Jww87GGeu5x2p2ERGSNyTSy2rckD2JZGGFtvcqLmqrp2MiIf1CTqHGX89AhgXTnfcIhkg63uv0Bb+cK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiQU7EmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A80C4CEF1;
	Thu, 16 Oct 2025 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632387;
	bh=Ps6/tS1Hgxj9m4RTd+Gf9Pe8KrRYTPDWnoO8GqQp4fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiQU7EmVBZeKMBQ+55jHw1BHzJGoAYwNj+vfRCNyRerQBoTmBskNi0ML0zBBOWIvm
	 hZaBCGonW+tP3B2D/aX/q8RQDjsOst7DS9AMCgICneMGXgM6gA4AOki5dCi5UMTNhq
	 eJysoFt2gvo8jDjR1etBjORW6eUOjcIPpK8QAbVyzxtoJuIc8EHVUmuVhGAp4oi0K2
	 5QGAf2s1md7QoucnQQqbL9Ne43qoA+9B/gdV8NQTldUMSz1zu0vbBhyrjUn0G61d0W
	 iPZak4DeJ5/PwHoWCADWJrv2P5KI+OvinXUrJRrQmP6eVILL94o0AxYWHRCTlPtOSu
	 2ldxc89KZnSlw==
Date: Thu, 16 Oct 2025 11:33:05 -0500
From: Rob Herring <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	martin.petersen@oracle.com, pabeni@redhat.com, rostedt@goodmis.org,
	bhelgaas@google.com, arnd@arndb.de, matthew.gerlach@altera.com,
	tien.fong.chee@altera.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 10/11] dt-bindings: altera: removal of generic PE1 dts
Message-ID: <20251016163305.GA3255795-robh@kernel.org>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
 <20251015194416.33502-11-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015194416.33502-11-l.rubusch@gmail.com>

On Wed, Oct 15, 2025 at 07:44:15PM +0000, Lothar Rubusch wrote:
> Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.
> 
> The removed Mercury+ AA1 on PE1 carrier board is just a particular
> setup case, which is actually replaced by the set of generic Mercury+
> AA1 combinations patch.
> 
> In other words a combination of a Mercury+ AA1 on a PE1 base board,
> with boot mode SD card is already covered by the generic AA1
> combinations. There is no further reason to keep this particular case
> now in a redundantly. Thus the redundant DT setup is removed.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 73ba3cbff026..db61537b7115 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -31,7 +31,6 @@ properties:
>        - description: Mercury+ AA1 boards
>          items:
>            - enum:
> -              - enclustra,mercury-pe1

Well, never mind I guess.

>                - enclustra,mercury-aa1-pe1
>                - enclustra,mercury-aa1-pe3
>                - enclustra,mercury-aa1-st1
> -- 
> 2.39.5
> 

