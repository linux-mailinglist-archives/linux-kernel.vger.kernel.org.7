Return-Path: <linux-kernel+bounces-856610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C760BE49A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D101C4F0B04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522632AAAE;
	Thu, 16 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJaStcqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14E329C6B;
	Thu, 16 Oct 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632325; cv=none; b=ZgWCs2iqwb6CdzKgp8hPaw64rzqVM0XTrXc+b9R4RDLc4v9zPZk+P6ueGNpKBR4WLCJ8wuFQ5qpoNwOHsHgBIrWyuXH3K203DfyttmerkWepkhIixJgNkdPfTCr7ElLGWaq+KMYpOwm5RZHheOfcJeYa5uR4i+Fad9z2nXusYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632325; c=relaxed/simple;
	bh=z1R0W85DdWS38NEWhVvry5wtDwvTTDiTfnRrh1x8t2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyGRRiNiEFTH7qVv+Ogq77awaj6G5uuHG92kDr8DBhrltuz7qdJKCV7dL1XvTaJnL+SR+9OTjOsj8qtvQZp0G6zSBCISSJuOUgJPSDDBf/I6ZrRqr1y0EqW9G+eZjKSr35YY2lzSoKJXBnARn0awy+ZytPF3mPv86VTDiRjQ7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJaStcqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462B5C4CEF1;
	Thu, 16 Oct 2025 16:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632325;
	bh=z1R0W85DdWS38NEWhVvry5wtDwvTTDiTfnRrh1x8t2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJaStcqjesb4KP8cS2FbjpL8swA94OaCO67rDQw9dJtZtrXldzYsrDyjyRgs9UKyb
	 RGzMne80jaiC8sKXuAo552oM2VlFoWhh9sCakKh29dJP0rbgO/bIk1i/MRBUDuhysu
	 mP601sN+JsF2GKgoSZWBJik7BNwjpN6ZgLaDYjNvmI2KOz+kx5rPygHgN5v7UPHkr4
	 wJYU5uuxvnj/rTOs0t2ArmqdkpfM10C9ZqPHqJVFOsgRvRJRUPu8u1X2l5oIfCa9un
	 ODbFhMh93b5KzPI1qsM6o6FnVXd16XHAt4sm3WfYofdmfRR63Lg+hCIU+WG/JNJwJK
	 DvWpYOb6JLrIw==
Date: Thu, 16 Oct 2025 11:32:03 -0500
From: Rob Herring <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	martin.petersen@oracle.com, pabeni@redhat.com, rostedt@goodmis.org,
	bhelgaas@google.com, arnd@arndb.de, matthew.gerlach@altera.com,
	tien.fong.chee@altera.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 08/11] dt-bindings: altera: add Mercury AA1 variants
Message-ID: <20251016163203.GA3254688-robh@kernel.org>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
 <20251015194416.33502-9-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015194416.33502-9-l.rubusch@gmail.com>

On Wed, Oct 15, 2025 at 07:44:13PM +0000, Lothar Rubusch wrote:
> Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
> carrier boards with the Mercury+ AA1 SoM.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 72cf04b22a08..73ba3cbff026 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -32,6 +32,9 @@ properties:
>          items:
>            - enum:
>                - enclustra,mercury-pe1
> +              - enclustra,mercury-aa1-pe1
> +              - enclustra,mercury-aa1-pe3
> +              - enclustra,mercury-aa1-st1

Alphabetical order please.

>                - google,chameleon-v3
>            - const: enclustra,mercury-aa1
>            - const: altr,socfpga-arria10
> -- 
> 2.39.5
> 

