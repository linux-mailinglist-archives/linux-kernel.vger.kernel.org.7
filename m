Return-Path: <linux-kernel+bounces-759622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1BB1E042
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4ED720870
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F585C5E;
	Fri,  8 Aug 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CWTs9ETK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75129D0D;
	Fri,  8 Aug 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617654; cv=none; b=ZUZgOKQI4LUSgcSgmcFSdBCRvZJ0iQ0jTAeEAN5AoZSnav8OT5AcDogRbhD9hRzx2h2N+2rlbSDU7pVd7ShiRRf3o1hAbS8TH0jTTKTKR6gDeQftdpZGslZKCw9V7b818FZ6nbNt+jaBWGgyMNcsKuoGTC+5pQ+uExWaPOXcQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617654; c=relaxed/simple;
	bh=THXhfIs9H9rrYB2vrX4MQGnujXZkNVq7DEecFH0R2bc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bpXV+1FpsiVKoXExjLrMfjWvIgEQYopLPR7GnzoCHp/C5JQienlA1r9ltawk90UL4IRcabVTj+G4gGlJCB75T3hCN0vZ6FetKIVlYd1iyoQl3aD/9tsXlcoZfbsfghrsgxG6hrdpu9C6fyWKqxpoI1Lobne3s3FUHtORaZS+Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CWTs9ETK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754617651;
	bh=THXhfIs9H9rrYB2vrX4MQGnujXZkNVq7DEecFH0R2bc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CWTs9ETKMKNU5vACd1Li7sftjh7SfZF8+G16VrXkmjc2puUADe9n2XkBxAMsc+Gmj
	 k6zsMKq0tD8KbbkjMsEnmSPAkW+tZAnVXNqS4CO4Bw3ntAm+opgbp7rM9beeaSdGnP
	 PoyoGO217ooYZ+MLJaR4hpYCi+fnb0O7GRs8a6BrdVy26kY9QiiWkHaSH1MPMXSVQO
	 EC2kaVA9ebD24Y1va02psaU2Kkxmh+bW5p131xgNLrNS2MDCpTrfHIBpYde+lSn1YR
	 9F8fDY9MH0b/NsZTQpzL6gIBOu1GHFJOhGRlrQbqTu2fV+K8qXAY+oj8KfTgdKGRdo
	 3mpYkp4ktMi9A==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4991E6AF39;
	Fri,  8 Aug 2025 09:47:30 +0800 (AWST)
Message-ID: <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing
 "clocks" property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Corey Minyard
 <corey@minyard.net>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, 
	openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 11:17:29 +0930
In-Reply-To: <20250807132852.3291305-1-robh@kernel.org>
References: <20250807132852.3291305-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 08:28 -0500, Rob Herring (Arm) wrote:
> The ASpeed kcs-bmc nodes have a "clocks" property which isn't
> documented. It looks like all the LPC child devices have the same clock
> source and some of the drivers manage their clock. Perhaps it is the
> parent device that should have the clock, but it's too late for that.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

