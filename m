Return-Path: <linux-kernel+bounces-857556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AFBE7210
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EB61AA0253
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A931284883;
	Fri, 17 Oct 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="qQKeUL9f"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569027B34C;
	Fri, 17 Oct 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689178; cv=none; b=FY26ip/PQiLdpVZOxBB2aIt8rgVY8M/L4AtCUar4NdoZTp4Y+QM9gekpkU/gnZ83CESYPY8Mh3JV/8yDDAqJYAct3gNeBHWSGQN3/JEQVcl4mJ4nSLGxXk3ms94e/ee0435Eg4OTh1lcBcNNrL/fYxaHdAC9gZefCI8AeEYc4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689178; c=relaxed/simple;
	bh=LWebXPXjK8TZe7NRiXGXFdgiR6KhJ+52RIjtJJXwWoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erPQRDziLAZSKSVFwgh0jbijAn2eUdJl06GDkD2qLeGJOTV800k927OHPL/Ym9IzonlpfMhpt6zgN1wxkwt2J7zmdyqnPZ6pv3vOZa39miz3k2/bQ0YI1z6ZmGeFFJNixJZMplo6LXtfdsTb387AWqrdMmdDXDCNejJ1QVFXHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=qQKeUL9f; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=l0GpXpfo2yqMk8lrtmMl3O2NGLxAtwJghNLZjo4X3Ls=; 
	b=qQKeUL9fHE3uE+67X6gIs+DScB21ChQBhhFZWFi/KmkEOEwTwkY/BlUVPoDF0fX7vq9/sJenKu0
	yWq/TmellfQ70k2+/tNwFDJ6baG21JrUty7NVcNZPI2G+2RuFm2EDvBW9RgdkqcY1u7ELfMsSICbV
	5wW4K62VdHfhS6VhLWIjlgArdab5xV6IkpRqhQ7KDd+kwGqVDLowHtQy4X5AzTXoQkXkBE9BdRzze
	B6qr27N8Qf263RUZFM1qD2WzLEVjsT6GhwM/dy/udcD/3UT0yExH4tF9MPnV+zUKwzWhi5q87z7EB
	n5YbSk2Yuq7YhBNUW5pscAOODUW0XmFX/YLA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v9fgQ-00DN35-1C;
	Fri, 17 Oct 2025 16:19:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Oct 2025 16:19:30 +0800
Date: Fri, 17 Oct 2025 16:19:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
	Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: crypto: qcom,inline-crypto-engine: Document
 the kaanapali ICE
Message-ID: <aPH8Er_hJ8WoosPw@gondor.apana.org.au>
References: <20250924-knp-ice-v1-1-1adfc2d9e83c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-ice-v1-1-1adfc2d9e83c@oss.qualcomm.com>

On Wed, Sep 24, 2025 at 04:29:37PM -0700, Jingyi Wang wrote:
> From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
> 
> Document the Inline Crypto Engine (ICE) on the kaanapali platform.
> 
> Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

