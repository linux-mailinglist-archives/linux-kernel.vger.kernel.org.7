Return-Path: <linux-kernel+bounces-838772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06408BB01B6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A813AAC59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8F2D0620;
	Wed,  1 Oct 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="koz662i+"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B762D0605
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317253; cv=none; b=TpHV9HU3U0vMpkrwOXZ03xOPPJcEyKELWlvKGyQQTC8cbOQ9CjUNVAaAlyG307MI7c2Rb1zmecmK3ohGIx3yad/63zodzNJ4gpLJz+es7BiydQg993Nire/bhDPb6qUBo9teKMxkFss6v6rfhDwUZFZMMFurfBDU9lp3lcMli94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317253; c=relaxed/simple;
	bh=DKeTx9fgYj2KCy4zwB4PbQA8LYgJe057ZFQ2d9vQuoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5pB35GZVxoBt/ja2ncoWsf4J/wC1TWl/HCNBslygbeJypSP8pXAhbV4M1He3oDwZ0UQz1WU1LujunNNRBQwNOYhtyNVil6LBGm2lVIJcmfmmhvdj3rMVA0hjF+Z7y2Gc76mjWdAXwEv8/ByjMF8+UvcVRqAQ+T76G4EhIXnog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=koz662i+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759317235; x=1759922035; i=markus.elfring@web.de;
	bh=DKeTx9fgYj2KCy4zwB4PbQA8LYgJe057ZFQ2d9vQuoc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=koz662i+Atc6nA4U5/9mb9kx5Ns2rD1eyVX3cHrkLbnm6+YT89lj4MDEwHNsv8TA
	 A09BBWYA2oUw1OsWb90VfRg3gncdaLGGgcwvPEtmkL+CmMMeWm7oFSAgpCP7pufbT
	 0VZtPzjHKvipYm9kt3HVJbBbDEfRMxnKjtOB901XmZxiSypgAKvDFo+Rbelszvbpm
	 B+q7BtTb1MlmvztjHh2Imluy9V2jmy7rUSGLV3Ob8xep9hJfO353zK6Fjy6rLmXSY
	 uCf0SKOXtf8QADtDxk2CAO8XrSjTYLZb2YlinHhLOWF8OxvhDmevCxx09T/zd2tfh
	 Xg8AIJjbGcHTJ85qRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1v53Md0lxs-0041WW; Wed, 01
 Oct 2025 13:13:55 +0200
Message-ID: <0acf13d6-d63b-4079-93ba-d53910e624d7@web.de>
Date: Wed, 1 Oct 2025 13:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
To: Lee Jones <lee@kernel.org>, Janne Grunau <j@jannau.net>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Neal Gompa <neal@gompa.dev>,
 Sven Peter <sven@kernel.org>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
 <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>
 <20251001095505.GP8757@google.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251001095505.GP8757@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mRjdZtzkH2PnIAzv3RMEMzOvTyR0RBUhgUu3Iz13PRmaFEf+4Mm
 rqugC01VtCF+3/zEeitAkFhcI+SiNGtxtVZvmOMOf0QUdwG3LBMunoIQS66bzRC5vW2fgek
 myRKNgL2YixV2jbrIfnQBLrtINsWMXQlZwayPx1oUqCfZczLHAcY7mapzv/t7hBzY8I+F+I
 WG3qWheqzwd9mpQHZd5og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GznlPwskjeo=;iU2IE+WS66pRaqPYE0phNm0W76u
 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

>>> Struct apple_smc's mutex was not initialized before use. Surprisingly
>>> this only resulted in occasional NULL pointer dereferences in
>>> apple_smc_read() calls from the probe() functions of sub devices.
>>
>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.17-rc7#n94
>=20
> Provide some context in your own words.

Would contributors like to care more also for the usage of imperative mood
in proposed commit messages?


> Don't expect others to click random links.

Should the mentioned information source be better known since a while?

Regards,
Markus

