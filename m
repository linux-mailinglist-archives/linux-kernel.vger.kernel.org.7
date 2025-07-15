Return-Path: <linux-kernel+bounces-732507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA96B067C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068167B5345
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91A273D6D;
	Tue, 15 Jul 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OHxHEM6u"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A072615
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611526; cv=none; b=AG/9tXyd81lMX/YzKJbmarrCzHuvdM5kmAxd0JDyQFw7RQVh9dTocbbiLbBqdZIPZQTXV5eC71YcRxqClF4NEDWv3CIUJOM/oQFDSy1Y880QehyZNqDmHitN/WvtLXsxr2DqpRdwS3EzL21lnHrwUAxgAZ3opVzmc5RpU/YKjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611526; c=relaxed/simple;
	bh=yPL7sb0I3vyYl0WYaM4Pb1VIFoqbIiQUNo9Rz261Ue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBlc6c+jaH3LHBaSHG3C6UN5f7fElmVvuhpirmvruzEvz8/En0cAAWMOZclmy+QbuGLC8V2nP1JvlJyxeHBHufAINB20MFa4ksMdF91qTdfM55/+C5otEOJpKYaIT2TFNXFQpwnrC3zRaDbacUFKqRTjCr71mpIXrPs4uB2pjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OHxHEM6u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oV9T
	I9+WIfNxHB52qrKd+4mDBoXh5YTq2uE9DShiIqo=; b=OHxHEM6uG0/V0nVW0wHP
	+awGoIpUz7837FzcreVK0YwTT7JmDYzRNqAMEt0KdKdLzmSkqngW0wTmjize18Gv
	xtKJRYNxu3f3I2MCCmbzvGLQ8/EWF2JEzBXRYvVhywRYoczwxTp8BhJ6xPfkpgGs
	0qdlA8nAZrkgKNOuIh8MpAxnbKUekHXslaXNFH5FDFGXkUZAQR/NrsZtSy+XJfgT
	kOrGFtHvSCXF6Yzi3RfR/qOW4tk0QXibjMHg20DKqeRJ30qYZnxZPmrVbrc/sFUQ
	FWvOZHJ4JiDg/H5hPkU5HEVPTCvwRn0Sc+B+fSoaOmetn+p2g4zhDmzVa9WwxfTf
	GQ==
Received: (qmail 3035793 invoked from network); 15 Jul 2025 22:31:58 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jul 2025 22:31:58 +0200
X-UD-Smtp-Session: l3s3148p1@IsDyqv05cOAujnsR
Date: Tue, 15 Jul 2025 22:31:57 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	gastmaier@gmail.com
Subject: Re: [PATCH v5 2/2] i3c: master: Add driver for Analog Devices I3C
 Controller IP
Message-ID: <aHa6vc9g8lpvPdWO@shikoro>
References: <20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com>
 <20250715-adi-i3c-master-v5-2-c89434cbaf5e@analog.com>
 <aHZzImGbgISePnNJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZzImGbgISePnNJ@lizhi-Precision-Tower-5810>

> >  M:	Jorge Marques <jorge.marques@analog.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> > +F:	drivers/i3c/master/adi-i3c-master.c
> 
> Add i3c mail list?

Not needed because it will be inherited from the I3C subsystem entry:

$ scripts/get_maintainer.pl -f drivers/i3c/master/ast2600-i3c-master.c
Jeremy Kerr
Alexandre Belloni
Frank Li
linux-i3c@lists.infradead.org
linux-kernel@vger.kernel.org


