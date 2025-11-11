Return-Path: <linux-kernel+bounces-895323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A082CC4D7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F021189FD21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EE357A24;
	Tue, 11 Nov 2025 11:41:43 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E103043AF;
	Tue, 11 Nov 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861303; cv=none; b=tmZg0heZR57EsWTBHK4NLuwImvWXN0oRMMRmwfYwzlZx7V8jWAAhkeNtAfoJ+3IXWnuWNUiZRO4q8neP3/w+TR6e3bZcYXUc241IftDejEexsPhe2ceagNqiX1Akha2oj1vi0k7h+FGNiwTzs88uw5Rpy/1tlgrwE0M7Ii7bL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861303; c=relaxed/simple;
	bh=NsifAaH4IJiJWQHRSEMOi7t8dMMrh3UzrvwkyayXbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoLeSjX12k/OiKJyoLYnOPWWq5jH9QUP6CAC9DrZ/fLH9gSNEhkWvOUUVy39UNGfsykad2OREDbkbqnPZU56qPqJfIHqYsWFM2ai4ovi5JgVACm3c8OJXTlgJBzn3yn8oqwoeil+sJvlhHgPfoofkAKo2Aazqsvjin4nN2mdMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id EF2F1340F5F;
	Tue, 11 Nov 2025 11:41:40 +0000 (UTC)
Date: Tue, 11 Nov 2025 19:41:33 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251111114133-GYA1677599@gentoo.org>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
 <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
 <20251111101149-GYE1651402@gentoo.org>
 <af7bd4ab-38dd-4a5a-93e5-f457ae3460db@kernel.org>
 <1d469324-84c8-4b5d-ae68-d77e3c822656@rootcommit.com>
 <2eb5ea0b-d071-4e17-abc8-7db5c78919f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb5ea0b-d071-4e17-abc8-7db5c78919f2@kernel.org>

Hi All,

On 11:34 Tue 11 Nov     , Krzysztof Kozlowski wrote:
> On 11/11/2025 11:29, Michael Opdenacker wrote:
> > Greetings
> > 
> > Thanks one more time for the reviews!
> > 
> > On 11/11/25 11:13, Krzysztof Kozlowski wrote:
> >> On 11/11/2025 11:11, Yixun Lan wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On 08:43 Tue 11 Nov     , Krzysztof Kozlowski wrote:
> >>>> On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
> >>>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >>>>>
> >>>>> Document the compatible string for the OrangePi R2S board [1], which
> >>>>> is marketed as using the Ky X1 SoC but is in fact identical to
> >>> Maybe, just say it "same" to clarify the ambiguity?
> >> What is exactly "same"? Same die? Or same blocks/pieces? Whichever you
> >> choose please make it very explicit.
> > 
> > Maybe Troy Mitchell from Spacemit can shed light on this question.
> > 
> > Anyway, I could use the same wording as in this commit introducing 
> > "OrangePi RV2":
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=bab8dea259100a99e047fd11a48940b229d30031
> > 
> > "The board is described as using the Ky X1 SoC, which, based on 
> > available downstream sources and testing, appears to be identical or 
> > very closely related to the SpacemiT K1 SoC".
sorry for bringing confusion in previous series, we had no further discussion on this..

> > 
> > What do you think?
> 
> This clearly suggests they are not identical thus you should have also
> dedicated compatible. Let me then precise, I thought it is obvious, that
> except writing it more detailed in commit msg, you also need proper
> binding expressing this. If this is not the same die and they look
> compatible, then usually it means you need a compatible.
> 

to be explicit, the Xy X1 has same die, same packaging as SpacemiT K1,
so we should not introduce new compatible in the SoC level, but a new
board compatible in patch [1/2] is ok to me

I hope this clarify this issue..

-- 
Yixun Lan (dlan)

