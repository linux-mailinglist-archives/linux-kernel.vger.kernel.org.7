Return-Path: <linux-kernel+bounces-773206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF6B29CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EE316DBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DBE170A37;
	Mon, 18 Aug 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PnBj5ONm"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2072E8882
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506889; cv=none; b=n5S2gzV3P8KfMbO1vKvZUCfsPtxzdjEiNwx3UImHg/ueHR0DKUtelwOs3eybM6X25UHdos2vxrN6ZVmdgr5IGYfuWp9QWqwzfH7HTrucodcvsN0kweLpXtx/Hb7FEqVgAI7qNnAHxWCILZkW2FVjfok3ABBFM5w2A4ZY7Uahqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506889; c=relaxed/simple;
	bh=mjFElnf4CUHuu+WMuqha3qqsEniYdH6RuKp765JP+Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaupQv9T5X8ByWwnKwkCLRsURCbKVq5znqjxEmeLJsRvqy4zA4y8UK2LL4dHxyjQ7NuioHqiGokCRB6Lhf1GnvOGV8fLK65OLRnVm/0NY5PdoYNV7UEfsuJu3hy+r4H1asTSjbopguA/pDzNG97hWzd2DeIEwBuDdgvWZhfZA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PnBj5ONm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5069A1F47D;
	Mon, 18 Aug 2025 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755506877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05uZQNCBQ/IPvhbxPL5JdbGCZAnK3adcFj09yVob0Hc=;
	b=PnBj5ONmj2Yn5z4ff+jP177N7rjlq64b37wwk7rHybTUCHIrFN6AqOup9BGYqFItEAqZl/
	/pES8TO8DayqbQUCGnIbFDy24UIqsywmZjqBH4kr3oTnZjFQhQizDtsqAMCA40/2npM075
	dbucluRnwlpwFrURVMiOnINoxTQdioxUi4f3DPJsGAaKe3K9EgKlov0wBqFpIpohjYqstm
	5vzDwB6fMuM0vbgUNq8a2UClNeBgh8YiNDxP0qwTy805EWBVULCTM+1j4yWT7fCS0GHlGE
	192aGCg5AtFEvdBaTVCRupO2r5LN5KMe+5v65ogfo4p07FbRm3HPK9cpwnXS+A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
In-Reply-To: <CAAyq3SZbPpVX_LyoYaHYhA3ZNeb0NYWQ4KC6-+uubB1GGCqZag@mail.gmail.com>
	(Cheng Ming Lin's message of "Mon, 11 Aug 2025 11:01:25 +0800")
References: <20250808095503.906244-1-linchengming884@gmail.com>
	<20250808095503.906244-3-linchengming884@gmail.com>
	<87zfca9kur.fsf@bootlin.com>
	<CAAyq3SZbPpVX_LyoYaHYhA3ZNeb0NYWQ4KC6-+uubB1GGCqZag@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 18 Aug 2025 10:47:53 +0200
Message-ID: <87y0rhyq12.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdeuhfffffdugfehleevvdfffeevvedtgfeuteejieeggeeltdehleetgeegvdenucffohhmrghinhepmhigihgtrdgtohhmrdhtfienucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhgthhgvnhhgmhhinhhgkeekgeesghhmrghilhdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopegrlhhvihhniihhohhusehmgihitgdrtghomhdrthifpdhrtghpthhtoheplhgvohihuhesmhigihgtrdgtohhmrdhtfidprhgtphhtthhopegthhgvnhhgmhhinhhglhhinhesmhigihgtrdgtohhmrdhtfi
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Chang Ming,

On 11/08/2025 at 11:01:25 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> Hi Miquel,
>
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>>
>> On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.com=
> wrote:
>>
>> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> >
>> > Enable randomizer function by specific flowchart to set the default va=
lue
>> > of RANDEN to 1.
>> >
>> > Randomizer introduces two new DT properties for child nodes to configu=
re
>> > the randomizer functionality and coverage options.
>> >  - mxic,enable-randomizer-otp: Specify whether to activate the randomi=
zer
>> >                                feature.
>> >  - mxic,randopt: Define the randomizer area per page.
>>
>> Can we create a global NAND DT property for that? Enabling a randomizer
>> is quite a generic step.
>>
>> > The penalty of randomizer are subpage accesses prohibited and more time
>> > period is needed in program operation and entering deep power-down mod=
e.
>> > i.e., tPROG 320us to 360us (randomizer enabled).
>>
>> Do you want to share what is the added value in terms of lifetime to
>> enable the randomizer, given the drawbacks which are significant?
>
> The randomizer mainly targets extremely unbalanced data patterns,
> which might potentially lead to data errors.
>
> Please refer to the attached document:
> https://www.mxic.com.tw/Lists/ApplicationNote/Attachments/2151/AN1051V1-T=
he%20Introduction%20of%20Randomizer%20Feature%20on%20MX30xFxG28AD_MX35xFxG2=
4AD.pdf

Thanks for the link, it may be pointed with a "Link:" tag in your commit
to further justify this addition. However it is sparse on details. I
would be interested by more details, such as "how many 0s? how many
bitflips? how often/likely?"

> Figure 1 shows that continuously programming too
> many 0s can result in data errors.

Thanks,
Miqu=C3=A8l

