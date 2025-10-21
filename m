Return-Path: <linux-kernel+bounces-862075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55973BF45EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8FE18C587D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796F275AF5;
	Tue, 21 Oct 2025 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnWjqXCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF2233721;
	Tue, 21 Oct 2025 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013154; cv=none; b=BPQsX8ZHkcocuv3G+aIVh6GJwfO4S7pFhfCYtutI8BbvOmXhqwaLg+jPLDv1QPqAOQ19c97MJ8kxiUqC8UoBV7u6nt3eVKHxKpBji2Ax+8elR8kObriw4evJNazxa0kIuaH+Hm1uaymGSyPmFEm0hLb/jM8HnLQf+Mdz7ZTrvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013154; c=relaxed/simple;
	bh=GB7X+plXVOgL1XCSblZIKjmqfgsgXGvSSQmBrLyjZDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXZ+EKVsFpcMxqn/231PicXvTnO9Bjsyg9XTusUbEkT93qmFl10ltdRgeOyz3G3Rcs18k0A+AiIUbtgwJLrsx018zb18XNVL3XeAx4UoxGR+JiKeeP0iGQoX8IwKpREqBQgiGPlLMeQxBI18dHKXjxbNqf7L2Qe+dkRbHpGH29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnWjqXCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E673DC4CEFB;
	Tue, 21 Oct 2025 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761013153;
	bh=GB7X+plXVOgL1XCSblZIKjmqfgsgXGvSSQmBrLyjZDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnWjqXCM5ds+JJr5wqcIYzHLk5Nvvo2bCAKBRHurgiCXroK6LqQUBVbGNNsmtnwH8
	 pKrpDz5uYO/8i7OyzIQ60KVDYtwqEM1OJ+MO4KEwUFRh2aP3OLyBEfeuk7/FxLNu4y
	 gHk2WOYpbeabCbiMNselBBplwhmmCVrCAxiezhmbEG+CkbsRRdu82mp1LIc+5eqCI0
	 90Pw6L3Af6ucfdEoib6lDgOBEJP2idMEVmhAumqCsUachglgw05RFtz9UY1L4ZcEFY
	 2GAFV6r4g7CG8olGp/diqUK9aHTGnaC7XFhhUDMvYwMpIGufPwubzHaeE1ToJKaqUH
	 Xnua4NKRjcgTg==
Date: Tue, 21 Oct 2025 07:49:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert actions,s900-pinctrl to DT
 schema
Message-ID: <sy72qccedkudtndyfg43mra4vrlctxjhgv5nkzaw4ojeppiisa@7a66eblvmlxo>
References: <20251013191218.4136673-1-robh@kernel.org>
 <CACRpkda6y0anNZ0dCHf_OQp-2q1g9LfXWqWD7mS44L1rYsZKDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda6y0anNZ0dCHf_OQp-2q1g9LfXWqWD7mS44L1rYsZKDg@mail.gmail.com>

On Mon, Oct 20, 2025 at 10:56:52PM +0200, Linus Walleij wrote:
> On Mon, Oct 13, 2025 at 9:12 PM Rob Herring (Arm) <robh@kernel.org> wrote:
> 
> > Convert the actions,s900-pinctrl binding to DT schema format. It's a
> > straight-forward conversion.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> No comments for a week so patch applied.
> 

FWIW,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

