Return-Path: <linux-kernel+bounces-795742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEFB3F740
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8D9206685
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B12E7BC3;
	Tue,  2 Sep 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aphJ2tE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029722E7BAB;
	Tue,  2 Sep 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799858; cv=none; b=OZThOpdqz5qakraJbTvWURYPhX/30nS8zrBmU85rcy7dZFgJhUcBdIPwSPEQ75pjpFfXKZNKuvQR3aUPXXZFmbvc6w6pdwD89UMxvGe4on+w9m5sgbkw0bWL6azzxlVzmuDRST6LI0NbGnn1UOnvKn2l45H7aWS8VZpyz+lH6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799858; c=relaxed/simple;
	bh=Gcvqnyx8Usk/FWPQbu2+qHYvDN50/xAOdJmelSgFGmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvWcCe+f+1/whY3FDDOtu8sypjo+JNMfIUbCDa1ij/nM4n3iG2/AocoEVGIT0VatwHo5QqlWBNd6WUIczQBGofJe7BuavV62zLnoc8niFXCwPalPY0oIaO2kvxG1HmRgmPyEE8RuKLPfQZfqrnjp/zzrCfqcdjnwK+nfY7QGkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aphJ2tE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41405C4CEED;
	Tue,  2 Sep 2025 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799857;
	bh=Gcvqnyx8Usk/FWPQbu2+qHYvDN50/xAOdJmelSgFGmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aphJ2tE2lKg0ht07WmeV+lCEePwouSbeu64wnkgYb+khK2Tj6DN10V1/tjJSGBTE5
	 HgBQtN5WvjAx9ag+elPJiP6WrFczukBev4nM3r22/HmzIRTG1I9kpJXYU5H633Rr5y
	 fVSGEfFQQ6YSQp2rbUwbqS8vYizINRI9LmO5xg0wWfljrwPzO311zlkC4mzNox5CtH
	 TUuDywaVZ0UnJNreB0fcaiYoHskcyifIgVGFpmw5zA9ArX3na2QYaZP5Rki70YFHSk
	 mPRiXUDX3F1C7OG5lvmQq0GFLzaFL0bDB/rjj5emuuM9vE6V+XgiUs0l8xgIqG6nSh
	 kwSeV6S00qaQQ==
Date: Tue, 2 Sep 2025 09:57:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, linux-sound@vger.kernel.org, 
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	drake@endlessm.com, katsuhiro@katsuster.net, matteomartelli3@gmail.com, 
	zhoubinbin@loongson.cn, KCHSU0@nuvoton.com, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: everest,es8316: Document routing
 strings
Message-ID: <20250902-cooperative-mink-from-asgard-b7ed63@kuoka>
References: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
 <20250809151853.47562-2-jihed.chaibi.dev@gmail.com>
 <d5d0133f-1b42-4ad0-a3e0-2a2bdeb67484@kernel.org>
 <c280310a-d9cf-4bc5-989c-0fb8093f714d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c280310a-d9cf-4bc5-989c-0fb8093f714d@sirena.org.uk>

On Tue, Aug 12, 2025 at 12:05:55PM +0100, Mark Brown wrote:
> On Tue, Aug 12, 2025 at 09:40:20AM +0200, Krzysztof Kozlowski wrote:
> > On 09/08/2025 17:18, Jihed Chaibi wrote:
> > > The es8316 driver defines several DAPM widget names that are used for
> > > audio routing in the device tree. However, these strings are not
> > > documented in the binding file.
> 
> > > This forces developers to read the C source to discover the valid
> > > names, which can be inefficient and error-prone.
> 
> > Reading free form text is as inefficient and error-prone as reading the
> > driver.
> 
> On the one hand, yes.  On the other hand this is better than what we had
> before so seems useful.  Ideally at some point someone will add a
> binding for this but that's a much bigger piece of work.

Fair enough. Jihed, please send v2 with descriptions referring rather to
pins or device, instead of the driver. Even though you took them from
driver, people would just copy-paste this description later for their
new drivers...

Best regards,
Krzysztof


