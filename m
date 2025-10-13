Return-Path: <linux-kernel+bounces-850433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD09BD2C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C398C1894343
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA65251793;
	Mon, 13 Oct 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iu7JmbDX"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D7257827
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354592; cv=none; b=s14jvQ7KBOzlkQELtqVpPVIJHuMlqKX3mqBZ9MdhbXoC88uraYJOofee9g0CCOw5NBCo66VwYTN3ubFxFrjLmCjBbvgji1dYCCiVBXc6GIqH049DwWH3aMK9va7IZrpIdMi/3ms5GRynhLFRaUyO6uIACJ35g0T3CEScxe8yKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354592; c=relaxed/simple;
	bh=bhuJegvTvAcQT0dEuoeIfFInmqmjZ1Q+isoUdA/Q6xA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U8/ieVvO++VWdG/2vfpQ+ql99tO7d4NX90RIvarzRey0WZ3N3LLE7yO6KAQsKmIUXAB+mIp1UTXu4zghS6/NrQu9pTNfo03ejDNbj+hM1P/eUzSWx2TPomOvmrjAc1BIiKE5ghhMsqA21nkDP9d9UJFDV1pUdf/o4NcyLUPfsbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iu7JmbDX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760354586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg/q8gaLEXsqld9FivxIEfM5ipjG9i1m/rctrdOvWIE=;
	b=iu7JmbDXS09ExiGoWBahy4+AbAU0q26cy0aGZUaC2VqCGiyu4+l+zkCpzaz4vICmLPDqhi
	G9tafSk2uhs4kuSbF1JHpNTRTPpEtrcY4pPU9a2Y0JVor6puVfJq61dL9cWJWumsA1Hbni
	7+dfViMzAyWk/xY4KMCmqKn3RCa2TKY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
Date: Mon, 13 Oct 2025 13:23:00 +0200
Cc: Jan Beulich <jbeulich@suse.com>,
 linux-hardening@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8DD2E1-61F3-4882-8266-3F828377DA35@linux.dev>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
 <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
 <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
 <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
X-Migadu-Flow: FLOW_OUT

On 13. Oct 2025, at 11:24, J=C3=BCrgen Gro=C3=9F wrote:
> On 13.10.25 10:22, Jan Beulich wrote:
>> On 13.10.2025 09:36, J=C3=BCrgen Gro=C3=9F wrote:
>>> I would even go further and drop abortstr[] completely:
>>>=20
>>> diff --git a/drivers/xen/xenbus/xenbus_xs.c =
b/drivers/xen/xenbus/xenbus_xs.c
>>> index 528682bf0c7f..c891af7165f5 100644
>>> --- a/drivers/xen/xenbus/xenbus_xs.c
>>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>>> @@ -550,14 +550,8 @@ EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>>>    */
>>>   int xenbus_transaction_end(struct xenbus_transaction t, int abort)
>>>   {
>>> -       char abortstr[2];
>>> -
>>> -       if (abort)
>>> -               strcpy(abortstr, "F");
>>> -       else
>>> -               strcpy(abortstr, "T");
>>> -
>>> -       return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, =
NULL));
>>> +       return xs_error(xs_single(t, XS_TRANSACTION_END, abort ? "F" =
: "T",
>>> +                       NULL));
>>>   }
>>>   EXPORT_SYMBOL_GPL(xenbus_transaction_end);
>> Hmm, which xs_single() indeed takes a const char *, it then casts =
away const-
>> ness before handing to xs_talkv().
>=20
> Yes, the cast is needed as xs_talkv() can handle reads and writes. No =
problem in
> this case, as the string is only read by xs_talkv() (write type =
operation).

I'll submit a v2.

Thanks,
Thorsten


