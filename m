Return-Path: <linux-kernel+bounces-797832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754EB415EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ABD1BA01F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED3E2DA75B;
	Wed,  3 Sep 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RDlZ2K3L"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FD2D8776;
	Wed,  3 Sep 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883480; cv=none; b=FQzUXdzwOOUJbyKAzlwjR7d4N9L2g/7AVuTEu0H4Ir0YqqVgD/yQs2X7LeBR6umv1357H8mrg5Uhv4vJcpnakQ4QNtXOAAEkrVk0QS6g3gz6LhrjFF1VuXVDVa97qB8E7tZXkrUKuXTIQ/iF9k0TSfjZj+svwNRWNtrbZLQUViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883480; c=relaxed/simple;
	bh=KTZ1wSbQR1lsYIr30IpvPmakl8nkFVk5+Wo0/3x+lJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bg1pvENYmXitLozMqDPhCPVR6f7n8y8CwnaPQdL6BVcaFn1umI3M8Sq9Sk3PsUOF/Ez2yXjKY1DebFFRoDuO6lJsBlkKsrLMgM4FqEUlKdrpi5qor/1hVqZYXEdwHJ7vpk+hr4AGF2DtzVTLb9oDXwyKjRERj/4a7sknR8KMSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RDlZ2K3L; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883475;
	bh=KTZ1wSbQR1lsYIr30IpvPmakl8nkFVk5+Wo0/3x+lJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RDlZ2K3LBRqdSQCbuZYKoC7FADTYf2w98B+9TyKjmQP1odliXjoKUrejIj+YhKtRq
	 RAtFad20NX7wK6Xy7aZBdCVAnInzCeB7Qu/rzcctuLQV0PrKMsHyElUu8qDTIEi4uU
	 XFF3yhKReLanl7OsJwj0N5zsS7HPrkj7ALSxevskrBYxEcBtKvlZqBvUNm09UKbd8E
	 7Y55v42caluktv8w2YxGXyABRAk0ZnqR0lXrTMGYuIxL6EZo6P9/rzHiDEfHzkIgnS
	 5+7Wfo2IY1dE8YG3wQjFwN2zdGvXojh6AmXHJ7w7Iv74cT9BHT+Qg0NrqlCW7Kp+57
	 TzpGTXI9tK9cA==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DF816445D;
	Wed,  3 Sep 2025 15:11:14 +0800 (AWST)
Message-ID: <f3ffa8efe3ba5274faa87e1a6e779f2b2c069a5a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:41:13 +0930
In-Reply-To: <20250829230450.1496151-1-robh@kernel.org>
References: <20250829230450.1496151-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 18:04 -0500, Rob Herring (Arm) wrote:
> Convert the aspeed,ast2x00-p2a-ctrl binding to DT schema format. The sche=
ma
> is simple enough to just add it to the parent aspeed,ast2x00-scu binding.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Rob.

