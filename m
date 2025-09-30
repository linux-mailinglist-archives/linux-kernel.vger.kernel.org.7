Return-Path: <linux-kernel+bounces-837706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E43BAD013
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23073C05B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5000303C9D;
	Tue, 30 Sep 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="Ldg81QLw"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0B2F5301
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238225; cv=none; b=PCQmlWd+ies281rCjkMHTfobWEkgS5l5N6XcoXUpDfWHdj4tJw0fyIMtA2VV8+09+K/9J+0q5hDGUKADX6KP3mPPCck2lG6iT4Rfc+PWBO5qhc+SlRS71d5bg2Bl7E78pX+PqQQpBtQlFcnBc5F6rv3yZBnO1udnZ/wOBWreKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238225; c=relaxed/simple;
	bh=UyCxDrrZzUT8zGZfo+Gzk8tgmUCGTYZ7qS0TdC3wFDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lav6xR7hg2kom17WfZEJZq+J8yDW0dQ/wN8cvC5MA33jNwV9GLlKl6WGymB+9ZFV2Lg2OsP75vTbqdWoOdzSwQioH8aPZbJ6HXxNmNLqg0z3ilRdvbIkIKIBx/0ljmGh5GOHjBNuQoM+Ir9H0mY+jeE47QmUXbmPNR/QYSoGBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=Ldg81QLw; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:content-type:cc:to:subject:message-id:date:from:
	 in-reply-to:references:mime-version:from;
	bh=UyCxDrrZzUT8zGZfo+Gzk8tgmUCGTYZ7qS0TdC3wFDE=;
	b=Ldg81QLwQ0rvqH+tgxMdbODuP3nlmjnc/SAk5R64rjJrk2sZjq7LejtlqnpUregLhKeKjlyJwP11X
	 kGb5wMaL/qB8XGjyxHbBK7NCqmW9ou/35yGCLRoxUPHLUonIfKQ+Ra5mAI+26Y1fwZPa9vmTxHmuTX
	 y3T6J+azHzHm518R8QC7KjeIQDtlzyx0bo2DJIsecZAob3AtkVjSEt4b4YW2DCQaPUwXEYwVQA6/og
	 gPBEsA1TVn6D09qAACQrElgs7fNVfVqTupBPXtvI3GRtYBCLvQ/IMSoP0vGSGjPG3rPqRVUOixWHJF
	 gMpi6Fzd2nO8Got61Cs6uZLIxc6A74A==
X-MSG-ID: 960fe147-9dff-11f0-867f-0050568164d1
X-Forwarded-Encrypted: i=1; AJvYcCXbG/H5UuslD1aU0g+vfG4GE/Z46vBVGcd/Hzy5xcYvCLwrpyBKfjz7FE4tnowlnmlB16drB68x2xvFgE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEoLfex+hSRjgwIkGTTDU9YKujraisnUOw6Xrp9YfLYTfzVoQ
	QzA66VLHA6NE4pTQ0/0G8tkUvxIABPUmhzJTSMae6BnrEYZ3pYygJCu2efaevbG5+GC7vB9QhI8
	rAJdEva+Npi3hF+/zTOehy7v+n6lChDk=
X-Google-Smtp-Source: AGHT+IEZpmUSSznZa3rcjquI8wBv8ZJiyiwjBQHfDOTQ+O92mufKmzERFkvjrfpPB/2t9FApR7bP0UgDW1B1GrDHyyM=
X-Received: by 2002:a05:690e:586:b0:62a:b545:54b4 with SMTP id
 956f58d0204a3-6361a822839mr17586176d50.26.1759238150375; Tue, 30 Sep 2025
 06:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407075400.1113177-1-linchengming884@gmail.com>
 <20250407075400.1113177-2-linchengming884@gmail.com> <d98f6eee-d5f7-43b7-bbc8-d6e7e274723a@roeck-us.net>
 <mafs05xh6pf7s.fsf@kernel.org> <da58fc81-3c99-4951-85bc-e3c139283b5a@roeck-us.net>
 <a2a0c40e-69d7-4408-add2-88616c92b0ca@roeck-us.net> <aa2a4480-9b78-4ed9-8f9d-b18a87eb01e9@linaro.org>
 <CAAyq3SYybDgBvkTKh2ZB4UdKq1XV_nnzx3Tj1P915W5x_7_nNA@mail.gmail.com>
 <DD10QMSJVZ2K.26U45JAXV5EY7@kernel.org> <CAAyq3SYyqi-oR8T039Zd0uaF6UieX3SdF9UF2kxOG6+yJqAEUg@mail.gmail.com>
 <mafs01pnoceum.fsf@kernel.org>
In-Reply-To: <mafs01pnoceum.fsf@kernel.org>
From: Maarten Zanders <maarten@zanders.be>
Date: Tue, 30 Sep 2025 15:15:39 +0200
X-Gmail-Original-Message-ID: <CAPB_pE+f7QGNaBgWz6OSOmfBAdCoOgnUhCV=KzUR94vWt_pEYA@mail.gmail.com>
X-Gm-Features: AS18NWBAFFJpNfkAj_8jYdQKO9YeMQdBqD1VwzpimmSkxxS4FLynVx0YdFMrp0A
Message-ID: <CAPB_pE+f7QGNaBgWz6OSOmfBAdCoOgnUhCV=KzUR94vWt_pEYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: macronix: Drop the redundant flash
 info fields
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Cheng Ming Lin <linchengming884@gmail.com>, Michael Walle <mwalle@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alvinzhou@mxic.com.tw, leoyu@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, Sep 30, 2025 at 2:19=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
> > I agree with reverting this patch. When I initially verified it, the
> > devices I had on hand all supported SFDP, so I did not catch this issue=
.
> > After checking again, I confirm that some older flashes without SFDP ar=
e
> > indeed affected.
>
> Do you know if these flashes are used in any devices that are actively
> used and maintained? If so, we should revert. If it is likely they
> aren't actively used, then maybe we just keep things as they are?
> Dunno...

The non-SFDP parts have been obsoleted in 2009-2010 according to
Macronix's PCN's. So they're pretty ancient.

If we choose to keep the patch in, I think we should make it more
consistent and drop support for the smaller flashes without SFDP as
well. The behavior is different in the spi-nor core for SFDP-parsed vs
non-SFDP-parsed cases.
In particular ID's 0xc22016 and 0xc22017 could be handled in the same
way I believe?

Best regards,
Maarten

