Return-Path: <linux-kernel+bounces-807375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067DB4A391
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297361888CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605C304BC9;
	Tue,  9 Sep 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4M0GeqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C521FF23;
	Tue,  9 Sep 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403124; cv=none; b=IQpuwSb8dciAjH3Nrn9bwDV7mhOjND7ny/jOchf/qthxu0RCb7aZAxqWz7nWfcwyC8KBVYU0ihLcN6XRY/8mrWVP3s3gzcmR9HSiEl0YLlqAiAO9kgyc6g9pPU4UEiCDpVGr7wxW4CeDzBU3rrhq+FmYd+eoYjAppt8Lxr4FPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403124; c=relaxed/simple;
	bh=tCqoK8+8l4HoLkfeBErfXAHZKgNG8757+5Zhpl8dWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJH4Em4mKoyYHTY6tWZ5ouLLYx69U4k9zeRruoGWubrjP+tijBuHZ+EkkXLeV1nBHiDxS2DLsNdoNWwMnFlF9gRdEfRQnaJZ6Ecrq+wHUOB/MtRzShUUA0GdTnE3JxEYs1MO+oQgH4CcJRVf7wq88t6Zr5kp20d0GXHrxUelNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4M0GeqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC92C4CEF4;
	Tue,  9 Sep 2025 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757403124;
	bh=tCqoK8+8l4HoLkfeBErfXAHZKgNG8757+5Zhpl8dWMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4M0GeqGSsSX4Y4S8pxZFZK160Z82Y5c9E88to32tLpfDcHEe8Jyc5M41+Ue5wiLz
	 ybGlrvBEEAb1rNOJFSEfGReZX2U/TODKG/aTaIiWKbpmFVbN8q+H7G++bffxdVf2Ov
	 GJJFB7CCV0gPK/UgsesYJK5Yy+yFxlr5j2m0wrutZKVLsnga+B242mn7w5npkheNZM
	 6ns4/i9sSL5BJrUpD1k+rqbG4b+73mv7+MbzTIqF0g3kZDRl5bVMwvrCOg2S9gTk1h
	 ERWB8SM3F0XIuAsPLPeQczW1jmnO2FTAIAWwsRNsT7mj0jlZgkbb1XSxBtWsN+A7Gk
	 QLFsMSou3UJXQ==
Date: Tue, 9 Sep 2025 09:32:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Aswath Govindraju <a-govindraju@ti.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb/ti,am62-usb.yaml: Add
 ti,lane-reverse property
Message-ID: <20250909-curvy-happy-pug-eeffda@kuoka>
References: <20250908162052.355341-1-richard.genoud@bootlin.com>
 <20250908162052.355341-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908162052.355341-2-richard.genoud@bootlin.com>

On Mon, Sep 08, 2025 at 06:20:51PM +0200, Richard Genoud wrote:
> On some designs, the D+ and D- lines are swapped (on purpose or not).
> The PHY can handle that with the LANE_REVERSE bit.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> index f6e6d084d1c5..ba894d610af0 100644
> --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> @@ -36,6 +36,11 @@ properties:
>      items:
>        - const: ref
>  
> +  ti,lane-reverse:
> +    description:
> +      Should be present if D+ and D- lanes have to be swapped.
> +    type: boolean

What is not working with existing data-lanes property?

Plus, lanes are swapped per port, not for entire device, no?

Best regards,
Krzysztof


