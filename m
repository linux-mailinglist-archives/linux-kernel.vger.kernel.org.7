Return-Path: <linux-kernel+bounces-721520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C865DAFCA50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DCA422C98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924A2DBF43;
	Tue,  8 Jul 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULEryIYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A062DAFC4;
	Tue,  8 Jul 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977336; cv=none; b=OpTeIB8ChX//cCXX7E+pBthgXz/jd/An4yeF6la5+spYEWlxpdsC5V7eQhuV7BxGZNvAHyYnjL5EUibFla1wWqhZTijjtSfvhw55J/yd+M443+Qd8eLAY9jKaYMth+xuYvO1EScSeh9qJ0j/HJxe16NGaE1PyMSFBe/6K8yHkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977336; c=relaxed/simple;
	bh=B0g5hFvwTeqKj4wm5BvSAN63W21W2eIqeHjN7u+FT4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my8z7VA4xRMoV6UMaboSMk7NT+IvFkWWDsselMYZsSpDKqniQ3PWTmevPOmSX2FlgqDKeSjbnGRDiBjvUyXibwZ1asSa9+XA2Go7TiAnoNORuhapv4gGEhcfYhIzI0DUSv0Smp+Z+puEQKWzwdUMow0tz9uok6XgHxnRGHKD6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULEryIYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B947C4CEED;
	Tue,  8 Jul 2025 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977335;
	bh=B0g5hFvwTeqKj4wm5BvSAN63W21W2eIqeHjN7u+FT4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULEryIYN0mY5+mwA6pRzpYcZs8vowo0qnnSGFe7ekqiW+YW1MxrLzbdjGSJLF/8V9
	 l7GQqMUa/LyXtpRvHo7fJ8ptjYOm5p23vdViWLg89P9JE2ky6l5ZzhXdrzXovkxxUx
	 RtcpjT+oAG1yJb9S8MJVlLiwED7ls5Rf0bPGp7P+0YCLVD4RgZmmuhYSqAOEAoXhZG
	 45+u4Y3Uk7bV8k/qPpomaVWbx+fRDppemVkFibFJuGTxx4h4oHP0yxbQkNMfYRIMo1
	 ngEZszxcPnO+vhsjwsLSKvpniObA612KywRV2X7Vo4qjG/Iu2A2Lk5VHMtNliVbGwZ
	 sy2JHtat0C0cA==
Date: Tue, 8 Jul 2025 07:22:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] docs: dt: writing-bindings: Express better
 expectations of "specific"
Message-ID: <175197733309.276747.1347706075364482943.robh@kernel.org>
References: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>
 <20250707095019.66792-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707095019.66792-5-krzysztof.kozlowski@linaro.org>


On Mon, 07 Jul 2025 11:50:21 +0200, Krzysztof Kozlowski wrote:
> Devicetree bindings are supposed to be specific in terms of compatibles
> and other properties.  Short "specific" has many implications, so extend
> the description to cover them:
> 
> 1. Mention no family names and avoid generic SoC fallbacks in
>    compatible.  The list grew, mixing DO's and DON'T's, so split it into
>    multiple items.
> 
> 2. No properties implied by the compatible.
> 
> 3. Document desired lack of ABI impact and acceptable solution if such
>    needs arises: clearly marking it in commit msg.
> 
> All above follows established Devicetree bindings maintainers review
> practice, so no new rules in practice are introduced here.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> Implement entire Conor's feedback:
> 1. Grammar
> 2. Split DO/DON'T in compatible section
> 3. Rephrase the ABI break
> ---
>  .../devicetree/bindings/writing-bindings.rst  | 27 +++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 

Applied, thanks!


