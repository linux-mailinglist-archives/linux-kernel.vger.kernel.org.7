Return-Path: <linux-kernel+bounces-653082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C52ABB4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B121175931
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760D1F8BCB;
	Mon, 19 May 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="bikX9Aj0"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521871DA617;
	Mon, 19 May 2025 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634439; cv=none; b=azExIxGTRGZv7BCmDYV4vTNQqhFr1ILAMCcVVnyzonKvUYRnms3Efs34V/LJyN5bmVwPZCghqv+WHu++bgLc9DRmgowSQy9WGIiA1Bv8ZYi/1IsGGwoMfe+TD+2ZJRAK/u9FAUhVxBmfaSGIHws/FIs6gQXjoOUX9wDms0MWZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634439; c=relaxed/simple;
	bh=y8+cgVGKozzcLhskG6T2cA1ptF/3oBXZUGRIfGql1PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz4EQBcuuFzvcjooBnlXCBRbWoj4X4sHBTk5/13UxTWuDt/ck8YMyKOziG0xfberxYsTfIuplk21Q2SyZEqNYXIIoe3AOAZ1rPSnYxmK0AMpj1++nEZxwd7fSrhlyZClBB6doV06l+I6j7M7S0cWIcUEq+9NKfGeSKEB2Q4x8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=bikX9Aj0; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KHB1YmBr5prsc7T//Il8yQ3wXH6P7KIQaca5dF2r68Q=; b=bikX9Aj0/ZW3R8mp6etSgKgSMn
	B51dwrb21vEkAfxpw1bXFRx3YW3e0iJm/wj/3s534re0yqpec29J3u1t/eDxRLaIUebe7/WVQAmFH
	wJ4+TgZZw24PZp9o2PW6l7Zc5BDfg29/5FXNIjrhqxsLtyGXh7crOYXOSf090NR6IB38HxxvjjJhY
	fmLqP3gJKYMHaXQUvu9LVQqm1niJuvVILnMWhXegJD9SYN4kDMhtldeIOq7wB2P3YCDKjEzL+1Aj+
	UP+VgV4F7Ol6m7CdJdcOzn6r7U4kfQPplQinV+lWRtIRiXIcBzETOqf4+oXBOxQ+HnpJZKq9zL1GC
	07KpRv/w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uGtY5-00785p-0u;
	Mon, 19 May 2025 14:00:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 May 2025 14:00:29 +0800
Date: Mon, 19 May 2025 14:00:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Hartley <james.hartley@imgtec.com>,
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: Convert img,hash-accelerator to DT
 schema
Message-ID: <aCrI_dlXsYIDeT-O@gondor.apana.org.au>
References: <20250513184118.3052496-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513184118.3052496-1-robh@kernel.org>

On Tue, May 13, 2025 at 01:41:16PM -0500, Rob Herring (Arm) wrote:
> Convert the Imagination Technologies hardware hash accelerator binding
> to DT schema format. It's a straight forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/crypto/img,hash-accelerator.yaml | 69 +++++++++++++++++++
>  .../devicetree/bindings/crypto/img-hash.txt   | 27 --------
>  2 files changed, 69 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/img,hash-accelerator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/img-hash.txt

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

