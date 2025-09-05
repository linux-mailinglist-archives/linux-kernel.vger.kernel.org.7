Return-Path: <linux-kernel+bounces-802727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C8B4560C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9411BC027E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123E34AAFD;
	Fri,  5 Sep 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="o96GCiO2"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1347343D7D;
	Fri,  5 Sep 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070855; cv=none; b=oHrRLvRR1PH3VGTEUW928sLiIEnN+1D5nw2Cym4KI4F8LcaEb5eS5c0wgl7+CLblQJSt7H/TZeKBudkw2y046TQdXU7mfq3ovZI2CsUwKcswuaXkEWROb4UJjZV+GDn2PjNWvm+jRj8AYvatrTZMI2aEdP7ixTx8MamzI9FGtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070855; c=relaxed/simple;
	bh=5HzWcQBh3bia5o4joak4np/uOYFU3K97GsOE29udmec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T65HId/92Jyw/bjl9JchI0qf9KmWA2jZyOpvGRhSKzxYWeKmTyWnyV8SBAgMfKHGmZSytUpshM1tcFuewyRZI0eQvv2Linq5OFO8rJGt47TstCsixV6nsK/f8FDDIGfyaVsLLVmAwxNgYv0exK2CbaanQkOdr5PI4qJIuCIBw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=o96GCiO2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757070849; x=1757675649; i=markus.elfring@web.de;
	bh=LCAvWYHsBSFyqI2uNAKAmi52zNXLw+pNRZnW2lCla9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o96GCiO2042VlA8gMbN9qtejHZo2gVbsGPRLx+OEN4cmWZuMFsRnQP9TuBKU07l5
	 lQXmSqgxy8KTli4JEvNBliEkK/Q6+Tk2Vzp4p6L9AI5p2ufebK39tKnvLmAwaRynq
	 TQjR81NNYlrmPvVdd/md2/eWTO51uG56O6XukTm113vuI3DJIHxpxd74fUFhgUCOm
	 bQDN9q6z2HMzTdzf6bF5dxZDjNLi7Ow9t+G9Gs7iLrUXdzuHDTsDCzuZ4RQGCjgHg
	 jzoieZ/AonBd9200tnDv0czTnqUEi8fD9sOEYdLyggRNwpzNlhbphPMZrm+w5GR6C
	 KxfGkF1mQwLVVAxHow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.210]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1v7MRu1eFP-00NPYm; Fri, 05
 Sep 2025 13:14:09 +0200
Message-ID: <b22df436-7bf1-4909-8150-03b65f657a60@web.de>
Date: Fri, 5 Sep 2025 13:14:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Sharing data processing resources for selected SmPL
 scripts?
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
 <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dhC7ybqmL23njrt7UT/+4qc5TQDxWVEljRu2NXnAQpARWq3REP
 jlgbJ0TmHVR/07ZaVe/2nWLRQDd34qKISz+7M/d/M5u9H5izkluIYIEk/uAqat32jXmvfxh
 nO/HheGU7lWfkUu1Sjz4stipvBJQSs+JkAgODiJhrh5fmirRr65xt6rI5jty1SAstGhaKG8
 FGrT4d5LHjCoSj+7bISbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DrOq0z8AcYU=;s9FI7dbLSEfELAA0XS4DA0C3Fhd
 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

>> @display@
>> identifier action;
>> type t;
>> @@
>> *t * action(...)
>>  {
>>  ... when any
=E2=80=A6>>  }
>>
>>
>> I interpret such a search approach in the way that it should extract so=
me data
>> from a lot of source code places.
>> Thus I imagine that it results also in special software run time charac=
teristics
>> which matter especially for big codebases like Linux.
>=20
> I guess it would be quite fast,

I am curious how such development views will evolve further
(depending on the data processing environment you may use).


>                                 because it will just find the deader of
> each function.

Header information should be found for several function implementations
from selected directories.
If you would dare to try the shown SmPL script out on the complete Linux c=
odebase,
a huge diff output will probably be generated.
It might be more helpful to try it out on a few header/source files
with a more reasonable size.

Other data structures might become also more attractive for the storage
and documentation of found pointer types in combination with known functio=
ns.

Regards,
Markus

