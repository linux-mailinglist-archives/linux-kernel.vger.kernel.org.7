Return-Path: <linux-kernel+bounces-893221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06793C46D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5DF3A7202
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371430F550;
	Mon, 10 Nov 2025 13:18:38 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCE30F800;
	Mon, 10 Nov 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780714; cv=none; b=dDG9om25JMLq3K9jHeJWc9owQlfGkP4PV5MejRSzFQnbrkykzlc6I/f/oj8Xj/aMT84+j7P1ieVnJ36lUVnakdrlzijnToS3ppWFQslUwLUWGNk27+j5Jxgg7b9E9Ojy0y2+36JIXbOAIVT6jBc33oqldVP4cetU/z0B3DZyajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780714; c=relaxed/simple;
	bh=LfGrKo3YYZD2l2hXjA0gXOCu8xjIGMYKjzEOK+GY8hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHW3qWNxJXmLCYl9fjRl9rZFAt5al8UIP49/BErhAe5er7astfybvz3jEcr14IolbVbiABDjhEFmzmeLqF6EGCdtwGw8ECfT5B49G1xl6T5ZnkUW7MMqOr87NbE40cfu77pQwrm7lUoixiPhjLHMOGrFJ4f8hdf1z81eGkLmh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6C36C340EA8;
	Mon, 10 Nov 2025 13:18:31 +0000 (UTC)
Date: Mon, 10 Nov 2025 21:18:26 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251110131826-GYA1585958@gentoo.org>
References: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
 <20251110101110.948198-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110101110.948198-2-michael.opdenacker@rootcommit.com>

Hi Michael,

On 10:11 Mon 10 Nov     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical to
> the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
..
> 
drop this blank line, it's not necessary
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

-- 
Yixun Lan (dlan)

