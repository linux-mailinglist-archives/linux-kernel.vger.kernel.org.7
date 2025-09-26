Return-Path: <linux-kernel+bounces-833484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EFDBA2217
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3ABF1BC407C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4218A956;
	Fri, 26 Sep 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ER07EXcB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280628399
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849498; cv=none; b=SZ3IHmPv8DvS/HaMRAWm0uRL8B0JZbFmEHEhTyd2nsDFQG54MlydOciIHBtQEqOfSveEAvvvz2zmpK/IFMArP0uh7c/ZCXsCI8izEe3JjzyeCM3C+MfbFKz12x8MxnGuz+uwTU7nTxuJ2Q0nHtIatGpp1bBh3j+ULyfLFi35wEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849498; c=relaxed/simple;
	bh=YQJvmbPVzCBB9AqwjicU0T1KZNF5E5hS6jLBOa2RJdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcBSxpHdo97Q7FadaNiByKuuUQh17IVsqe5DtzobHep1wE1bSfyhqYG82OMYml0Lwe7Pyqx0TlY9fIIxyztjnH+EI63qgahy5d1OmOSWxU+0z8DHFY+bpn7JZ3UU5Jg0oGXMI9gv+9Zuhc0NnHB1LYggQk5hF4JJZ8Xlb993+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ER07EXcB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Sep 2025 09:17:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758849483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rA6Qll8D4Ppu2LfQkBo+Ym0X/sF3HTFfejLcZ32oa4E=;
	b=ER07EXcBc9FWx+PZB1SzmC6ONvobE0zL6ZZ0oryTmrYDzdNixSeJiwuOIGeRT1w4lf6DlT
	ff21yYbXP+lYZKPdyerEfjWqp+u3yaWvcr2NRSL2NFKiioPJ52P9Y2Axo79J80+Gxov8ZS
	3v/J2mSSQgldMk2rZzAhuBmo52zmT00=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Sensylink
Message-ID: <aNXpxBOHPnKp1IQ3@kernel.org>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-1-97e7c84f2c47@linux.dev>
 <5327db80-86c3-4b68-83fa-1788e5a30fc2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5327db80-86c3-4b68-83fa-1788e5a30fc2@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 24, 2025 at 07:41:44AM -0700, Guenter Roeck wrote:
> On Tue, Sep 16, 2025 at 12:46:44PM +0800, Troy Mitchell wrote:
> > Link: https://www.sensylink.com/
> > 
> This is not an appropriate patch description.
Okay, I'll add a company description.
Btw, I've seen other commits with the same info merged successfully. So
that's why I did that.

                - Troy
> 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 77160cd47f54079a39f35b570d69f7c4c2274724..ea4011d64ab9081d212a738839849d5814cf6c98 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1353,6 +1353,8 @@ patternProperties:
> >      description: Sensirion AG
> >    "^sensortek,.*":
> >      description: Sensortek Technology Corporation
> > +  "^sensylink,.*":
> > +    description: Sensylink Microelectronics Technology Co., Ltd.
> >    "^sercomm,.*":
> >      description: Sercomm (Suzhou) Corporation
> >    "^sff,.*":

