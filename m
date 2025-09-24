Return-Path: <linux-kernel+bounces-830061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4DDB9896C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A94C1B20DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD327E060;
	Wed, 24 Sep 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fMXEa7Ii"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96327E056
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699810; cv=none; b=pL8DkFo8V2fbwrLAdzo+1JQ2HN/yTHZ7ZGZJGC7Ko9endzisyro6S0Umgx/3Qblp9yZZp+0oTYG4bsKEfJC60CWCih1D1FXov10Ss1bQqtDTAMYgvNqNcGyh4ehrCe2j5QkkbmwCazi7S01QC9JJ9QywC19JT+yRdkKRJ5Vukg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699810; c=relaxed/simple;
	bh=5MQiuICX+qhuDPMPlez/jYp6u/IfLM0nEYdX+GOc7uU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lmILU7+6jUeUiJIeGN3UX6XP9R/m/4qAAGkprMyZnIWxWT6GKu43yDpG6bkni12T5aRxRazSvAZ8ok5BIrTdDIaMTNslPmLeTWGvgeS/3a4EnM/2fQQy9553bOpQiXzvC56ttcMZrMd8EBwDpRcZ1LIf8qTbGXkP0D0RVyVno4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fMXEa7Ii; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A276B4E40D1A;
	Wed, 24 Sep 2025 07:43:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70DBA606B5;
	Wed, 24 Sep 2025 07:43:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95138102F18E0;
	Wed, 24 Sep 2025 09:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758699803; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kVm9WUZprq8Oz+SY2IG0V7UF+iOnsRaBXZJyJc3BusM=;
	b=fMXEa7IiY4ulp0K7jeHZd9LsNKG+xjGqwEvwAj+h0qnZHKX5YNdLm1mKcJifroCcZmjhNa
	jqziOwapABmIWd71jA9sYCVMsO+D4iwqbKBu8NtfEi15LTcg3g22mCSkrJwbvm9nJFBb4X
	p58L7YIk6c54TSBNcZd66cQkOxvL/Lub34FIh9H4WkHEadnZuFJx27BHS60N66bgRf/1cm
	3RfT6aszI0rOLd4OFnzq8m60yAi4WlXOsIZTyUzAvB8DMc7NRmNMO0WW1sKfiRmvZu/yKc
	4wGWfk0gCCJ0nwzun9nKaWgBjEjT/hl/Shb5HBn4eGKTxNfuwT2V1S5DQ2F+/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Johan Hovold <johan@kernel.org>,  linux-mtd@lists.infradead.org,  LKML
 <linux-kernel@vger.kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: rawnand: omap2: fix device leak on probe failure
In-Reply-To: <1341dc6b-49da-44f9-8b57-6828a64114fe@web.de> (Markus Elfring's
	message of "Tue, 23 Sep 2025 19:05:19 +0200")
References: <20250922152204.15702-1-johan@kernel.org>
	<1341dc6b-49da-44f9-8b57-6828a64114fe@web.de>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 24 Sep 2025 09:43:16 +0200
Message-ID: <87zfakpa7f.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Markus,

>> @@ -2083,10 +2084,24 @@ static int omap_nand_attach_chip(struct nand_chi=
p *chip)
>>  		dev_err(dev,
>>  			"Not enough OOB bytes: required =3D %d, available=3D%d\n",
>>  			min_oobbytes, mtd->oobsize);
>> -		return -EINVAL;
>> +		err =3D -EINVAL;
>> +		goto err_put_elm_dev;
>>  	}
> =E2=80=A6
>
> May such an error code assignment be moved behind an additional label?

I don't think that's how labels are supposed to be used, current
proposal looks correct IMO.

Thanks,
Miqu=C3=A8l

