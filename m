Return-Path: <linux-kernel+bounces-797906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46659B41707
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7FE7C208A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D612D7DC7;
	Wed,  3 Sep 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghEgVQ6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA492DCBEB;
	Wed,  3 Sep 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885329; cv=none; b=Phr3OkcxC5jqLcObM9kNzeehB+jYx9YpzNv202d4WcAmynVkhJPajzibb3GSblcsyIujYENEKOhx2Pgfl6Q1C0yGISYpO27R9XZZt/82drXOnVdI6b+poTNMZM3VpmFrTa9vB0/5tjG6FKN5KDbE4jNzUCLnWKUOcBkCR8Ke9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885329; c=relaxed/simple;
	bh=AUQkPJJyFsCdN4dGiQxkxrP6VObpYHg553Fbls0FctI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbBZWQUgDzed7X5fIc4kFQsI+9NVD+JEURiTYZCGmdEdmn+nLCcDa9B1sNCa2nTOB/75jLnPQu7X7lFK2mJP4bWoRByxGv4E1ESa/qeqKOWagoBuVqvbi2dMhRVwnw0MIw0loZY3sKeHKeluGQdTdpHvfx5cz4Dp1h1NEZ6Sor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghEgVQ6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D350EC4CEF0;
	Wed,  3 Sep 2025 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756885329;
	bh=AUQkPJJyFsCdN4dGiQxkxrP6VObpYHg553Fbls0FctI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghEgVQ6g/p9TOmf0ypFyrJSobtbW+L7V33tGccKnZ97soO2WiGOMkFDrqhJv8/Ebt
	 vkl1JmqFcdupCAuDn9JdY98TEb2igZ4dTM/RjzZuOKc/SX2q7jaDkzjiRTTSWjKs7U
	 3VJGTVcZ/kjYW+lhQfgaZfEv5MNLmYxNMQPHnWMEC6cJqMaKM4o5Wq/fUrCpnLcuD5
	 t9PzLRioBiiMSHl6bDmLrbZkr8uuED/GaNqG7U4frsmDY5cRVuudw9khvKc0FsDEDU
	 vfzcwTV6g027w3GqENoTBTZOqf0Nt1utVC6DxllsgOHv7KO2mfIHIRVsykfdXBo6Uf
	 2K4TOR/rm+nAw==
Date: Wed, 3 Sep 2025 08:42:05 +0100
From: Lee Jones <lee@kernel.org>
To: Johnsodn Huang <kusogame68@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	sef1548@gmail.com
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
Message-ID: <20250903074205.GB2163762@google.com>
References: <20250902142749.13724-1-kusogame68@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902142749.13724-1-kusogame68@gmail.com>

Looks like you corrupted the subject line with the commit message.

Please resubmit.

> From: Johnson Huang <kusogame68@gmail.com>

Use `git format-patch` and `git send-email` instead.

> Co-developed-by: Nick Huang <sef1548@gmail.com>
> Signed-off-by: Nick Huang <sef1548@gmail.com>
> Signed-off-by: Johnson Huang <kusogame68@gmail.com>

It took two of you to correct the word "and"?

> ---
>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> index d783cc4e4e..d16c82e398 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> @@ -41,7 +41,7 @@ properties:
>    clock-output-names:
>      maxItems: 1
>  
> -# The BD71847 abd BD71850 support two different HW states as reset target
> +# The BD71847 and BD71850 support two different HW states as reset target
>  # states. States are called as SNVS and READY. At READY state all the PMIC
>  # power outputs go down and OTP is reload. At the SNVS state all other logic
>  # and external devices apart from the SNVS power domain are shut off. Please
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

