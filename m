Return-Path: <linux-kernel+bounces-779216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977AB2F089
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B7FA22975
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2328C2E9ED5;
	Thu, 21 Aug 2025 08:05:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9AF2E9ECE;
	Thu, 21 Aug 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763510; cv=none; b=gl8kqthNKsmMHAkjV6SD5KG/BAvvqPKPsGzDS/mq501/ajJABIHzM6jPw+fsshPPb+5Bb2v8tcanLJcvzbeNEW3vlCQvPRWpsXxu7RcMOQ941gjzvKnuPHK7AIIh/eQj8bvYiSmIZGGxhoWplqkbQZEXweuK8WkILro2qz/yydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763510; c=relaxed/simple;
	bh=xujlK4f4nsLmmcHmO++zn6YCGlGxYrtPlci9BS0YYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IERzK4lUjm0MCMyBRzubTjgj3/kpldS0Uqn73lKpoI3XJOmgxty3lr58MNHOJOMaDCh8Ndbu6E3VUJQH9wdnBu7r5Kn3xphe2PpQPATUOStiugMhzCXHK2REKVbXT3YMj/Cg4Q9PaOlNadsBIWO/xzLkE3Expoyofd9Llug+F8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C931515;
	Thu, 21 Aug 2025 01:04:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09E063F63F;
	Thu, 21 Aug 2025 01:05:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:04:58 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Deepti Jaggi <quic_djaggi@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
	Nikunj Kela <quic_nkela@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
Message-ID: <aKbTKq04umCgS_eL@pluto>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
 <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com>

On Wed, Aug 20, 2025 at 11:44:26AM -0700, Deepti Jaggi wrote:
> 
> On 7/30/25 14:30, Deepti Jaggi wrote:
> > From: Nikunj Kela <quic_nkela@quicinc.com>
> > 

Hi,

> > Allow multiple SCMI instances by extending the scmi node name to include
> > an instance number suffix.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
> > ---
> > Changes in v6:
> >          - Dropped 'this change' from description
> > 	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com
> > 
> > Changes in v5:
> >          - Added Reviewed-by tag
> > 	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com
> > 
> > Changes in v4:
> >          - Dropped 'virtual' from subject and description
> > 	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com
> > 
> > Changes in v3:
> >          - Added Reviewed-by tag
> >          - Removed the patch from original series[1]
> > 
> > Changes in v2:
> >          - Fixed scmi nodename pattern
> > 
> > [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> > ---
> >   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -27,7 +27,7 @@ anyOf:
> >   properties:
> >     $nodename:
> > -    const: scmi
> > +    pattern: '^scmi(-[0-9]+)?$'
> >     compatible:
> >       oneOf:
> > 
> > ---
> > base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
> > change-id: 20250728-8255-scmi-ed963ef8f155
> 
> Gentle ping!!
> Could you please review the patch?
>

I thought this was already reviewed/acked and merged since ages....
...also the wording-change in the commit message LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

