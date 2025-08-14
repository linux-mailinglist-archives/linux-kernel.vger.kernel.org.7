Return-Path: <linux-kernel+bounces-767814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB90B2596F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30BB2A49F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E00246798;
	Thu, 14 Aug 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KWwg6lNV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E981BC2A;
	Thu, 14 Aug 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755137686; cv=none; b=F8GwudQ6JUl+ZNa9XlWZwF5+6pl+Hp90Fr2xeXd5xeYUWqHZPasf1F+MrVTUfaujMMmhYCDWlvBkiC/P06JgemJECJBln7K1olU6szokuWX5bFFm0fpFpenvQ7JLFL/ofZoHlC2bT3AdUWrgH03HCcIuy7Ie3Z8FwL+1RltKTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755137686; c=relaxed/simple;
	bh=TKVYO6A/sLZs95wSkW7D51yS5lCcT5G1jMqbHqh9ynw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z17S6D8u6jY1peVnVaK9lRUp8eEl4T3tDhyigy5kNlx22hCLg7kp9Yfq1NehjnJBOJgeaBvFl4bbTD9X53NcWfriPH5QVfwrrJijWLc7OIqYSKZb3MxGTo97sBkWxESuHnTVWuHth8OCwP/UevCe1+Y3grmCu525QK8W7JhZLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KWwg6lNV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DA13A40AD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755137683; bh=TKVYO6A/sLZs95wSkW7D51yS5lCcT5G1jMqbHqh9ynw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KWwg6lNVP1pDYW1KEmghdiU89RPgD3PTP1mqM7uDADBF/Dl8+eXFIkqf2i+362y7X
	 Hbg8kz3kYG/BaipHuWiTVRo42kYQzuCBYIcPz8RuIrzbGzCtxb9zs9ElLO781nqCro
	 o6ePm6/m40OU1IXbimNGf8KMP+IwCPjdtCy9dNuqIhHu2m8pQi51ocZZOsivdp4p/q
	 hbh1SvnEFLj2HP9IdAFyJGqD8nu/+XXdE1wW4RovyPwipMTLFxCBac5CLGUw4V7US6
	 wfr5DECzmyDy//uLk+pvTscnCDm++NyVIX1yzp1iBMrEtIsMroVYFJYGc2pfZj9Zu/
	 g2BppHWZX2h7g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DA13A40AD3;
	Thu, 14 Aug 2025 02:14:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
In-Reply-To: <20250814013600.5aec0521@foz.lan>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-8-corbet@lwn.net> <20250814013600.5aec0521@foz.lan>
Date: Wed, 13 Aug 2025 20:14:42 -0600
Message-ID: <871ppehcod.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Wed, 13 Aug 2025 15:32:06 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Put this tool with the other documentation-related scripts.
>
> This one will be painful, as it will cause conflicts with my series
> that clean up the docs Makefile.

Just in general ... I'm more than happy to put this whole series on the
back burner until we've gotten that other stuff merged ... it's an RFC
after all, and there's no urgency here.

jon

