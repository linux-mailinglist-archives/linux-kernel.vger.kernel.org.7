Return-Path: <linux-kernel+bounces-647675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D550AB6B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791421B679E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60EA278E51;
	Wed, 14 May 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1h+8wh4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CB277038;
	Wed, 14 May 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226318; cv=none; b=MxJeaaLrtoCoDkgDhH+HvaEMGCvDPhWg/IKGfEcmXMGN/qbpA04c0EgNoi8kUIMfKNY7m1Rau8K1HdyzvAV23d5j7kfPCJ/e1yqgo+dnRFX7zJWoOO6Fdu9iG/WSx3gfH3rX7PPMfwrdoW7uhQAu1BFGuSl09S1Xooi684M3ZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226318; c=relaxed/simple;
	bh=ZRAbtDLU7nP6o3LdOmMc3nAAyiNgbM8NKuOVKfOJ8W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji46UF2tUg3bgIm2v0d5PmIRnX8z15bP4VVBeJ7dvlH/UQSt/vx/2YhIm6FhPFPyDswO3P6CRU9NxWIWJTwKGO5E4xHQlNTL3R853A7k6MGQLvhqt1iQN8lEyDPcPAqknb9VuSUlrzIEGX0CLcE8NDON+LIO6nTJrYwFrgsMtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1h+8wh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E945C4CEE9;
	Wed, 14 May 2025 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747226317;
	bh=ZRAbtDLU7nP6o3LdOmMc3nAAyiNgbM8NKuOVKfOJ8W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1h+8wh4M9WYHlvQBBJt8UhjWW7n06dcTRpU2HcbXxZEwu9RwNhTKVPC+yneJNMZB
	 x3ZjUS+ohxAGqbDVY3NbF/kh9sr/2xDsubiKpuNayqz6l20/BnBiIxw+eyB7K0yohf
	 BtMf3re71j5ozdb66cSmRypL8rn4FvcMbLJRv6vLZqO2BD4lIe3MAbvavBmqQ/5nyL
	 VfiavAY79QjbnoEzqpIxCcJI1KS/54rXt3Ze7KeZcTSmC5emLahMzJp4C1Ok28JZHu
	 wuWOAN2cqHoz1SYrTYFS5/BLqqhx+gHCZVuOA2DiOzEPNDaUbwwudf5onaHfoExTNe
	 yTPDuje/sgJ8A==
Date: Wed, 14 May 2025 07:38:35 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: Re: [PATCH v3 6/7] dt-bindings: rtc-rv8803: add tamper detection
 property node
Message-ID: <20250514123835.GA1729201-robh@kernel.org>
References: <20250513161922.4064-1-markus.burri@mt.com>
 <20250513161922.4064-7-markus.burri@mt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513161922.4064-7-markus.burri@mt.com>

On Tue, May 13, 2025 at 06:19:21PM +0200, Markus Burri wrote:
> Document tamper detection property for epson,rx8901 rtc chip.

Looks like a lot more than 1 property. Explain the feature and why it is 
needed. What the change is is obvious reading the diff.

> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
>  .../devicetree/bindings/rtc/epson,rx8900.yaml | 40 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml b/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> index 03af81754482..c2e542c9bdc6 100644
> --- a/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> @@ -9,9 +9,6 @@ title: EPSON RX8900 / Microcrystal RV8803 Real-Time Clock
>  maintainers:
>    - Marek Vasut <marex@denx.de>
>  
> -allOf:
> -  - $ref: rtc.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -33,6 +30,43 @@ properties:
>  
>    wakeup-source: true
>  
> +  tamper:
> +    description: Subnode for tamper configuration. This
> +      subnode is only available for epson,rx8901.

Wrap at 80 char.

> +    type: object
> +    additionalProperties: false

blank line

> +    properties:
> +      buffer-mode:
> +        description: Set the buffer mode to inhibit (0) or overwrite (1).
> +        minimum: 0
> +        maximum: 1

Could be boolean?

blank line

> +    patternProperties:
> +      "^evin-[0-3]$":
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 3
> +        maxItems: 3
> +        description: |
> +          Event input pin configuration.
> +          The configuration is an array of tree values and contains
> +          "pull-resistore", "trigger" and "filter".

pull-resistor

> +          For a detaild description, see epson-rx8901 datasheet.

detailed

blank line between paragraphs.

> +
> +allOf:
> +  - $ref: rtc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - epson,rx8901
> +    then:
> +      properties:
> +        tamper: true

Don't need this. It is allowed by default. Invert the if.

> +    else:
> +      # property is not allowed:

Drop comment

> +      properties:
> +        tamper: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.39.5
> 

