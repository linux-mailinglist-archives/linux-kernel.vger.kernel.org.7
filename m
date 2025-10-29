Return-Path: <linux-kernel+bounces-875931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D2C1A294
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A47E1895E87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4D331A68;
	Wed, 29 Oct 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c+bKWr+F"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230932D43D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740300; cv=none; b=Pn/+qtgA6lmBv9XwFcyUSG8QbnRXqimY123vYAqXPzdSmlOJbwLKTr7oQXxQgqyQ3ixLFtqBWmyzho8wPRLQvmLmvMOslbBmz8PjAzzuLKpYgApB+6jeeLFjWN/V539zvM8h9l2O96Zg211liga4RV3CZffgasJprgDZ8XDLeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740300; c=relaxed/simple;
	bh=1UGA4qoMqm15HHbjzPovQXhSggkJzmGWb4ZVKoa2/Yg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qHwAr+U8q5bVd0tF1TRsprW2YZCGM3BYMT2mpIBmRAB/pUDM2Qy+yH0hxsp2JMHhTidIqXY572SoSdBkSDpFAvNSCg8ErfpxYHVfxaXxTnhGOiC7ObJmstyVZBLu6BtSthrLNsSCf0yn1EFRbrGLUTJHWTBzFSndTe216GdlMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c+bKWr+F; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761740272; x=1762345072; i=markus.elfring@web.de;
	bh=1UGA4qoMqm15HHbjzPovQXhSggkJzmGWb4ZVKoa2/Yg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c+bKWr+FriEbHiIHrv5l0bHTfkgWhpwQ4BIUKOKgkwbqUPdXRaAo+HAUTCbeH5SA
	 UxjlHqrJQ90VwJLhyYdFBdjG6uEOFeWqUzMVb2oGqMOnfADRr7oHqjcpdJOlS2Jj4
	 KyxATVbV4eYUSPHlVuXG5ep4oejW79GkEE5KDRf3wHELyFiW1uaulMl8Y80KQK1Sg
	 uGNew+KOVUdsQZtmDxjBynzpi6afGp0TTNdvSEAl2z+gCdfCx4mMdbMGE1Z6bjBzk
	 w5FCGiD8DkH23MguFhWfVRc4xF7ddoEiuulTjb76GSz789zcfEg4blBgaeD+lNKpN
	 cqbSuYEVWDehJaA6cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1vOHiv2LSP-003bEj; Wed, 29
 Oct 2025 13:17:52 +0100
Message-ID: <41acb188-07bf-4fd2-a5ef-6aa22c3633bc@web.de>
Date: Wed, 29 Oct 2025 13:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
References: <20251028172828.625-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: fixed: fix GPIO descriptor leak on register
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251028172828.625-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4GIo9tNGkHW1ZlTK7tpVA1jpefUou3h/WPcUAM/DwNsrIHy1YQo
 znpMKSFvLUy/tIEJQowJn+vus6d9oVqpRB/llY5MJvAigMiNhunt6RBT2nUffQeZaLUzzaJ
 bvShWYa/GdBn+i0kY3oAHIwgH3FgyI4pMdUKQ8jsJAEipNcOtgRmSj2NHk3u6Gmq0+8LqvA
 ywIC6JIq8ACLeKkJU4B3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fmmhr0ELSKo=;UoccxsA2YGKyDBVlVX59QBNCLgU
 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
 ncqJg==

> In the commit referenced by the Fixes tag,
> devm_gpiod_get_optional() was replaced by manual
> GPIO management, relying on the regulator core to release the
> GPIO descriptor. However, this approach does not account for the
=E2=80=A6

You may occasionally put more than 64 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc3#n658

Regards,
Markus

