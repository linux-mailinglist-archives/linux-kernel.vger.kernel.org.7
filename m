Return-Path: <linux-kernel+bounces-783714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B3BB33190
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DF87A3EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584181F3FE2;
	Sun, 24 Aug 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlu4yj7V"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022527472
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055057; cv=none; b=CEzJDdHEwpkPp2e9MTjjB6RzNEOjUaSDhMERTA1q7L7yc/GZ/W+aV5g4N9vfVCA2mZ0CSAjHFHmbiJVwpMEIcHOB0F0OdK8bvySc3g2RLJZD0H87eraeDyTZ9cfYxSHuzcARH+QldFDMx2qhgfxL1hhQnbCPlMBYMI7tC1CI8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055057; c=relaxed/simple;
	bh=iGI3j3m7xmEU0qjzgGDJWM91UjKzuqe2KxabPydXJXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xul9v3JxSpE74xeuvVAOX5tfBNNitEiPKbucw5lqg9vvbDVgtIqUrOFHsYQrdarXqMZh2kAw26Ncmqa5Z7uPMDMobNFhWuVdA71/jrPW8NhMJDxhvecRFRUfqoxZ1mupLdYfzkDKG8P3Tm7E4mZ6MmU5IjvX3oGNdOGIPyf47KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlu4yj7V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-245fd2b63f8so33639185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756055054; x=1756659854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWdnE3QqvOnTVkBeUwBHNiXhFYB2DD+PzV4D0jhuPw0=;
        b=Jlu4yj7VmIZKHnmKoLnBLxMv3i4fmlANCf1HEnaxEERFN89/UgRkcIe6lwOMTfLoLL
         k7YDsYSL0Gby+/j2mbe4dvI4i6W8qxyCLEKXTxWMF7HjxuRrMRFKbcRAtq9TdC/Mvjbz
         RE605fX6ZhBlFsatICFu9SUt6UOorzEZ09AR2DKaYNhIPE099IsYKNlVNVAd5SQhLU+A
         aWB1SvPJFFci+cTbUA85RMtiFdGlu70/X3RrZaALjfa41c0L/8sRTHWbcx4cDtTqI4HH
         IHBAZ5JjhOG8BjONBvOgFPoUI9IDXyBC08HsjXPQV72wIGAB6Q807xGUvjNG2pr32acU
         Nikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055054; x=1756659854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWdnE3QqvOnTVkBeUwBHNiXhFYB2DD+PzV4D0jhuPw0=;
        b=RFijYAFv2oQmXq/CvzaqwuMOfCGVNBQLvrtWMMvRlYG3qbkoorXp+EkQosVIzus6X2
         iPhjZ+IB7XZAtPtHAUI5XXFhoXPcu2h/lfCTQ2X47H0CHtZ9i2t+UVFoF97bJQYTkTsp
         DQcWLH05bS51UjAAt9qh6KRlwVyZYiZ3JxttgYz6sZBCEpSFtgUBuAN9aA/+tOUpA8Sq
         Rkfh4+1FAXFomReobSSz9pQaVtlAx/4DIXgaXITx6h2s/sWAPSQl/3BLA5lUtkObiga3
         5S9QMAxDzuRcZmXLgPxl5qPEV6upgKKaJ3RD7ZqI0JCJkMTROz3eDhjgqS33X+Iwdt5x
         h8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVGeTOHV0/gpd2d33gWdjy/L3YZCXq7sZR/iYLCLpIOTYHGrccJHLMfFvySN3cLKQBBOkaemylfspnCVYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmh5AHeOmVPLY0TPwFl5bqUuuSFRng0TrkfPO362+C/Ys316Eg
	t+a9Ga8oIruJrVObd6Iv46a2J/XL5OOJNuEj6zT/UEWLG77xcOgdC6Nu6cK4EoMe
X-Gm-Gg: ASbGncsEFLmwlNX7YElAiERP7/bTRNNuNOHzpfsidmjqVDh4DTcof+d//Qp8RPAf+e3
	1RT2KnD/1ChPQI3nm7G6nv6/mg5yQc9qPC9avYfCWHq583+fAZW5BUe3M2UzpBzEz2pFrr12TL0
	1HYCQYYLx6cx/Ru5JK5TDdliRCqESFbPBl+U/az9Eflcoi8B5DaYLPubiNolve8yu4jPwGC+e9G
	8WxNiV1+eHILA1e+P70JgHBat9F64NMUaTx8v2lvE5PBe+tZHQu/0WBNn/DZXUis7tZPIG7sfFw
	BH/l7/XiMVAUUS44tum7PdvaKDLgPtKr0TgI5BD1l7QjQRnNYXbifz4wKfFESzcRDaX0CrIYPFU
	2VVVDY/pJlil2jAVXXa55ky5lBM+qTUu4BNg23nA2rQ==
X-Google-Smtp-Source: AGHT+IGKfezQDsIZ2HOwTft+hMXDJZm3c8RDXGSEF5BzzXtE7+0W8PVIoDGVOM+l7HLXJ4aH3DaHuQ==
X-Received: by 2002:a17:903:247:b0:242:9bc4:f1c7 with SMTP id d9443c01a7336-2462efcf6c6mr153982165ad.54.1756055053891;
        Sun, 24 Aug 2025 10:04:13 -0700 (PDT)
Received: from ?IPV6:2408:8362:245d:6225:5a47:caff:fe76:9e11? ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668879763sm46826905ad.108.2025.08.24.10.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:04:13 -0700 (PDT)
Message-ID: <016c3003-51f5-4609-b5c4-8888e974b854@gmail.com>
Date: Mon, 25 Aug 2025 01:04:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20250810133852.52389-1-cnsztl@gmail.com>
 <87wm6sk9it.fsf@bootlin.com>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <87wm6sk9it.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Miquel,

On 2025/8/24 23:46, Miquel Raynal wrote:
> Hello Tianling,
> 
> On 10/08/2025 at 21:38:52 +08, Tianling Shen <cnsztl@gmail.com> wrote:
> 
>> Add support for FudanMicro FM25S01A SPI NAND.
>> Datasheet: http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf
>>
>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>> ---
>>   drivers/mtd/nand/spi/Makefile |  2 +-
>>   drivers/mtd/nand/spi/core.c   |  1 +
>>   drivers/mtd/nand/spi/fmsh.c   | 74 +++++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h   |  1 +
>>   4 files changed, 77 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mtd/nand/spi/fmsh.c
>>
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index 258da42451a4..e288742ea8f0 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -spinand-objs := core.o otp.o
>> +spinand-objs := core.o fmsh.o otp.o
> 
> You're adding a manufacturer driver in the middle of the core files. For
> now we kind of inforce an alphabetical order, so please move it below.

oops, sorry for that, I've sent v2 for it. Thank you!

Regards,
Tianling.

> 
>>   spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o
>>   macronix.o
> 
>                                                  ^
> Here
> 
>>   spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>>   obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index b0898990b2a5..ea47028d021a 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1184,6 +1184,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>>   	&alliancememory_spinand_manufacturer,
>>   	&ato_spinand_manufacturer,
>>   	&esmt_c8_spinand_manufacturer,
>> +	&fmsh_spinand_manufacturer,
>>   	&foresee_spinand_manufacturer,
>>   	&gigadevice_spinand_manufacturer,
>>   	&macronix_spinand_manufacturer,
>> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
>> new file mode 100644
>> index 000000000000..8b2097bfc771
>> --- /dev/null
>> +++ b/drivers/mtd/nand/spi/fmsh.c
> 
> Otherise the driver is simple enough, so v2 should make it :)
> 
> Thanks,
> Miquèl


