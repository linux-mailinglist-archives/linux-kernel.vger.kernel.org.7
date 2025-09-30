Return-Path: <linux-kernel+bounces-837634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854FBACCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128FB3C6567
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1602BE7D0;
	Tue, 30 Sep 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgfOdVsZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A581F582C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234773; cv=none; b=rDatlK9MzxSfkrrfS5MNfmWSAMTv/iQVGUmmvCMdq6i++Ad6NG8Pg6pg3oenxKSlVaFAcjtMvXLTavyjt8qDadsqFuCYaOdi7EKmqDTtkIMVE1HZWF+LsJC3VrD2uPcrJnYnr4PtIzs/W0xo0DxwYy37uYtGTVDsL6UsQTdFUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234773; c=relaxed/simple;
	bh=K/02sF+wmK8zVvZYoYSnvHtVxTq3OlWrSzPnKA270yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsgigiTP3UXFhQv3ObQOCKCoaYv8vEf8YUrQZ39eG3THjKOYfKYABSdx3K3/D9kBbjrgwuox1cBo4yOeejnxxnlyuNJlG5wtlvgF4sj7mdkKmE5QrHzGF5/S83KriMyk28TnUFz6EpxZ062+BKIzbZ9+xNcD06DEcs230vsp5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgfOdVsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0011C4CEF0;
	Tue, 30 Sep 2025 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759234772;
	bh=K/02sF+wmK8zVvZYoYSnvHtVxTq3OlWrSzPnKA270yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DgfOdVsZlwSmJA7IW7k1lnvV4jlq5FSwwBDuzMpIZGBtUdDVSJgTquIthFlGa5Q8U
	 98BLtzqFOohEkkPbc8+FNu7gjY9gDH91lZ3yY37wiMqeZfQ1FunDIqwYk9aVycgpCQ
	 dXxcDiggi1UD9be3PF1r8wXAh7sugOD+P308J7IUiCylTcWtP1fagJFIAoAuTBVEiU
	 DjsygnIC5ZyklUWrMKJ+lbJToLW3Vi4CVgR6YK7x5n6zedQdHtCfnR97n3qgBYQMFF
	 1/JRi/+JyjcMRDQmpoKNYfnAxvKTmdlfBPrraklKJNyL2IozHxYiSgCJw1xVbYn8LX
	 py8sii1AYhYAQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Guenter Roeck <linux@roeck-us.net>,  Pratyush
 Yadav <pratyush@kernel.org>,  Cheng Ming Lin <chengminglin@mxic.com.tw>,
  miquel.raynal@bootlin.com,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Maarten Zanders
 <maarten@zanders.be>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
In-Reply-To: <CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
	(Cheng Ming Lin's message of "Tue, 30 Sep 2025 15:36:40 +0800")
References: <20250407075400.1113177-1-linchengming884@gmail.com>
	<20250407075400.1113177-2-linchengming884@gmail.com>
	<d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
	<mafs05xh6pf7s.fsf@kernel.org>
	<da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
	<a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net>
	<aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
	<CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
	<DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org>
	<CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
Date: Tue, 30 Sep 2025 14:19:29 +0200
Message-ID: <mafs01pnoceum.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30 2025, Cheng Ming Lin wrote:

> Hi Michael,
>
> Michael Walle <mwalle@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> > The root cause of this problem lies in the failure of parsing the SFDP
>> > data for the flash, rather than an issue with the patch itself. I beli=
eve
>> > we should not revert this patch.
>>
>> I disagree. There are Macronix flashes with that ID which doesn't
>> have SFDP.  And this patch is dropping support for them. See also
>> [1]. Now I'm not sure it is worth reverting this commit. Nobody,
>> except Guenter complained, but only *so far* (and that patch is in
>> since 6.16). Any opinions?

When I read this I was just hoping no one complains and we end up just
dropping support for these flashes that no one seems to use...

>
> I agree with reverting this patch. When I initially verified it, the
> devices I had on hand all supported SFDP, so I did not catch this issue.
> After checking again, I confirm that some older flashes without SFDP are
> indeed affected.

Do you know if these flashes are used in any devices that are actively
used and maintained? If so, we should revert. If it is likely they
aren't actively used, then maybe we just keep things as they are?
Dunno...

>
> Would it make sense to only change the `.name` field to use a comment,
> while keeping the rest as is? That way we can still support flashes that
> may not provide SFDP.

Sure, that would be a good improvement over a plain revert. Maybe as a
follow up patch to the revert?

--=20
Regards,
Pratyush Yadav

