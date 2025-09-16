Return-Path: <linux-kernel+bounces-818070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA4B58C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6065F16D596
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DD2550CA;
	Tue, 16 Sep 2025 03:29:45 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69896CA5E;
	Tue, 16 Sep 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993384; cv=none; b=PyoDYLDSIz9lAAxG1MDeWjtUuK1tbq7ZAlr2EVMshK1uOTY1Oa80cNmJlf52V1RpeAT/66vkdCM7CazUuCE+FAF9/193i6Oy1hyisqyP/92H1eTPWHUwCZkGxA8Zj/4Ksb5Mv6ufOWtAJJB+5jTdrmBL0Oztl/EjEF0NeGb8B70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993384; c=relaxed/simple;
	bh=EhWdJEf2wBD7X3jzz/fAR+SIbs7mi1J+rFqwmwmk+nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvdJuFZPwEQgZiD62kIh+THsRnwwuBiBFXRRhJCGiEpGkvfXnnF/IItPWs/lcKXctTfeewYN0CdC7kjQRDls2xkoOkgpbjvpPjBkC3q1CijE65ajrqZwUNPWaHvqLzpjCy+aLQ6lhMkdb68EKlX8ouVL3fxVuauAEkYizKJoJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: esmtpgz11t1757993315t735adbf3
X-QQ-Originating-IP: bCdIXwVAGF6MwENTPw+HEEysn9sINOX+5ML4W6MDpzk=
Received: from dkx-H410M-H-V2 ( [183.51.122.206])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 11:28:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14883937900501578486
EX-QQ-RecipientCnt: 17
Message-ID: <EEABCC59F39E8FC5+04995f9826d047eeb5f4bada25c3dd93e50983b0.camel@t-chip.com.cn>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3588-RT
From: Kaison Deng <dkx@t-chip.com.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Robinson
 <pbrobinson@gmail.com>, Jimmy Hon <honyuenkwun@gmail.com>, 
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonas
 Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org, Andrew Lunn
 <andrew@lunn.ch>, Dragan Simic <dsimic@manjaro.org>, Wayne Chou
 <zxf@t-chip.com.cn>, Kaison Deng <dkx@t-chip.com.cn>, FUKAUMI Naoki
 <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>, Conor Dooley
 <conor+dt@kernel.org>
Date: Tue, 16 Sep 2025 11:28:33 +0800
In-Reply-To: <175794446144.2732898.9504412064423841025.robh@kernel.org>
References: <cover.1757902513.git.dkx@t-chip.com.cn>
	 <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757902513.git.dkx@t-chip.com.cn>
	 <175794446144.2732898.9504412064423841025.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MXE8fio8Dejk8AUu/Aqvn7gY26XHjU32xF0F+vEcnzxjI2i5enOzEo6u
	B+Dh6kz80uah8B8wUaswfzDCl99idnuFMqxfqBmD0+Ozp1sdWfDcwP+omq8ENC20yjP/RPv
	sR3xDVUXXXsKQm0eoJCp51cc0OTFTG6g2omqHKYDPWy9IrGrpNbvj5APrDb4Y0SZi22En3y
	spzi1xIJjOgOdtkprq+niRa135qZMS/dheINQIHfKMc3aC+mhvWt+9oCtHxRyACbUKMh4S3
	zVvxDSykETpXHoObUGt09y+dhaGorYk1CC2ih+d6eKc+lNMedI0qPaUabqB0Qg8QRO9RmrW
	xhryliCL+TufmiSVO7yYQ8Puh2bGAs74td43hoEkNBIh34ks7eGfJsTAzeYHlO/jVvw8L5Z
	aSzDPiWoqD7BjY8yqD7pwN/IJl0MErhI+RLTeehgAsU66aqS0ZKu4yCJKvt96J7aUOOYe5g
	HltZQAr89sq7tbcOlQzBQ3ZCTmPUUX/bOvCY23ptl0oTOltYRHyqqT87ey4fWKlRxJ/eoLB
	7Mw1ay3A3qTJXxZ0hqNSmEIsZ42nExMzvc6aOrUPBXLMuU4fpCQ1AdXbgzp08zlfwUpXZtA
	Z4u/htrpaxMF6n3rgEEFhNLw2BnmmNZoMJVduT3C0+g2MpdHu6ZjBx+Xr+gR/KRRWZ2wmPx
	zFJoZcv/wQKaBKdudUUoiBtz2ibMrYLbxCAYYWj6zKFqQnaWLix1tDtz4wzuNkHIYEVQO3L
	jAV1peDbst0RDjfc2FJol4FKi8Lsn0lX547hpJ6Gsf88XAgZ71CE/XzAUclfDLITIGJ8E0z
	7V0EOeVvsvDIx544wcZiRj4U2u1T2FboByeh52UqYuephd1BwtfXXHy0B9QfGxkk4ZF3fm0
	JcfhmDYIm+Xig8tryg2jDRD/gSxC9GFYLqPCX32hs3nq5h3BtlGrYI43Cd/Iq6gmvjqb5xo
	5SJPcLaKNJJKYyxgGXpM9b8aBqC8Wqo8vD5tCoRtZFQ7JUm4lh5l8ha8jYq4xJR+k3/a0Mo
	mte8wVBFwqnZp/spPEfRFyDyhGKaDkvuLZlVCfWJKRXaz3QiJC
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Mon, 2025-09-15 at 08:54 -0500, Rob Herring (Arm) wrote:
> On Mon, 15 Sep 2025 10:22:04 +0800, Kaison Deng wrote:
> > This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588
> > SoC.
> > 
> > Link: https://en.t-firefly.com/product/industry/rocrk3588rt
> > 
> > Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions.
> However,
> there's no need to repost patches *only* to add the tags. The
> upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Missing tags:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 

Ok. Do I need to resend the next version for the missed tags?

Kaison



