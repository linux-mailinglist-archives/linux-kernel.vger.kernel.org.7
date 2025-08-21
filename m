Return-Path: <linux-kernel+bounces-779350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852FB2F2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449651C22BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2692ED854;
	Thu, 21 Aug 2025 08:52:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62388F49;
	Thu, 21 Aug 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766349; cv=none; b=kkxynYCihm0Z6N86cBhnlM7T4NUIrw9h8aP8MLxth4iAcHAEa4oG4+hEJCqXt7nw3akoarUFD6bAviuYv9QflRk5ocfj2to8BXAQqo0oVp+N1nI8gQXTsIlC4CIqTtPjb1w2SgmhjWVSAoYaj3zhEiPPSYw2riOhxF1cLdSV/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766349; c=relaxed/simple;
	bh=mF+ZCQJY6Y7KLMuzi/iAroDjO1KS/7rPsDMjS1aBYPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFGOdVJTjB0Rg1hR2JQOgWaWZ4xl6SIKG/dRuiV9+usQKhOOc5VZWNJRXheUdu2AQhVpox9HDvO0W6zjXmScZZKTKtfPoeg/pJ5Hs3kZtVIdQZKIIcRG00gQ2oTvxBORj6bBk77fA3C8p+kkBhR98IhZEZ68A9SBfUSo48rtetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDC4168F;
	Thu, 21 Aug 2025 01:52:17 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339333F58B;
	Thu, 21 Aug 2025 01:52:24 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:52:21 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
	Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
Message-ID: <aKbeRVsLpXcpiyHb@pluto>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
 <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com>
 <aKbTKq04umCgS_eL@pluto>
 <a59908c9-38d8-492d-9e3f-5560d272689b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59908c9-38d8-492d-9e3f-5560d272689b@linaro.org>

On Thu, Aug 21, 2025 at 10:29:00AM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2025 10:04, Cristian Marussi wrote:
> > On Wed, Aug 20, 2025 at 11:44:26AM -0700, Deepti Jaggi wrote:
> >>
> >> On 7/30/25 14:30, Deepti Jaggi wrote:
> >>> From: Nikunj Kela <quic_nkela@quicinc.com>
> >>>
> > 
> > Hi,
> > 
> >>> Allow multiple SCMI instances by extending the scmi node name to include
> >>> an instance number suffix.
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> >>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> >>> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
> >>> ---
> >>> Changes in v6:
> >>>          - Dropped 'this change' from description
> >>> 	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com
> >>>
> >>> Changes in v5:
> >>>          - Added Reviewed-by tag
> >>> 	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com
> >>>
> >>> Changes in v4:
> >>>          - Dropped 'virtual' from subject and description
> >>> 	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com
> >>>
> >>> Changes in v3:
> >>>          - Added Reviewed-by tag
> >>>          - Removed the patch from original series[1]
> >>>
> >>> Changes in v2:
> >>>          - Fixed scmi nodename pattern
> >>>
> >>> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> >>> ---
> >>>   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> >>> index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
> >>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> >>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> >>> @@ -27,7 +27,7 @@ anyOf:
> >>>   properties:
> >>>     $nodename:
> >>> -    const: scmi
> >>> +    pattern: '^scmi(-[0-9]+)?$'
> >>>     compatible:
> >>>       oneOf:
> >>>
> >>> ---
> >>> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
> >>> change-id: 20250728-8255-scmi-ed963ef8f155
> >>
> >> Gentle ping!!
> 
> You cannot ping gently while screaming!!! (you see how gentle this feels?)
> 
> >> Could you please review the patch?
> >>
> > 
> > I thought this was already reviewed/acked and merged since ages....
> > ...also the wording-change in the commit message LGTM.
> > 
> > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> It was. Twice! This is just unjustified ping.

I'd like to add a new tag at this point.

Reviewed-!!-by-!!: Cristian Marussi <cristian.marussi@arm.com>

:P

Cheers,
Cristian

