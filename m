Return-Path: <linux-kernel+bounces-682291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB57EAD5DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B04C178216
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163061B21AD;
	Wed, 11 Jun 2025 18:16:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280A2E6128
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665760; cv=none; b=FX4eW/VLVuCuv4YnKg0mrgw6Z2e9zS0X9ZIHyE3/AEbGkek70AJs9l1+/anu8Y05j0tKEocJzEEYWSWx8oIZWgLDD9FGz50vxEyAIlAsXEazpv+gNyG47PLqapu3HzUqdN0znxotRW3Q20k/UOOArjVdOu4xmNtpdnW4klTz25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665760; c=relaxed/simple;
	bh=ShxLF+BQufGmHMrV74DXXvxSMTrFEmKWtn9TGUP97OY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PWgafZJBwrxcD7sbBK5uQD89gEBgd64DrYA7ei+MPvbxpAt0ESByBUf4Z18Z0qYj2YFMZEqMNGh/VUaSsKmy0p6IQNq7IxjiovMSoQCRy2wnu9h4FbZJNA2Hqle1/d+84l8LLTrUZcSvq1wJMwjo+B+i72KSHNdlyskyXHjOXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1uPPyh-0004Yh-S0; Wed, 11 Jun 2025 20:15:11 +0200
Message-ID: <e3e7d5fc-ed5b-4292-bf60-4e536386f3b9@pengutronix.de>
Date: Wed, 11 Jun 2025 20:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Co-existence of GPT and fixed partitions (Was: Re: [PATCH v6 5/6]
 block: add support for partition table defined in OF)
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Riyan Dhiman <riyandhiman14@gmail.com>, linux-doc@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Christoph Hellwig <hch@lst.de>,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@infradead.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 INAGAKI Hiroshi <musashino.open@gmail.com>, linux-mmc@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, upstream@airoha.com,
 Christian Heusel <christian@heusel.eu>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <20241002221306.4403-6-ansuelsmth@gmail.com>
 <5e9a80d6-6c89-478e-99c9-584647661f5e@pengutronix.de>
 <CA+_ehUwa69Qa96yy0=K9AiCEJbaZt9oGCRf5gJDh-0_14shbtA@mail.gmail.com>
 <4218cdae-07ee-433c-8a68-bb07885e43ab@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <4218cdae-07ee-433c-8a68-bb07885e43ab@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 12/5/24 13:12, Ahmad Fatoum wrote:
>> Or you are telling me you had a downstream patch that declares additional
>> partition in addition to a disk with a GPT partition table?
>> If that's the case, I'm confused of why the additional partition can't
>> be declared
>> directly in GPT.
> 
> Many of the older boards supported by barebox used to place the barebox image
> and the environment prior to the first partition in the unpartitioned area.
> 
> To still be able to access them, fixed partitions were used and the rest
> of the system was described by MBR/GPT partitions.
> 
> This was partially made necessary by BootROMs having strange expectations
> of where the bootloader needs to be placed, which partially overlapped
> the MBR/GPT itself, making it difficult to define a partition for the bootloader.
> 
> For newer boards, it's more common to place the bootloader in a GPT partition
> now. barebox has no DT binding for generically describing such a GPT partition
> though, so boards may create a fixed-partition "alias" and use that.

FTR, starting with barebox v2025.03.0, barebox' default is to fix up a
partitions container with a barebox,fixed-partition compatible for
everything that's not an MTD. This avoids clashing with the binding
added here for MMCs and possibly a future binding for partitioning EEPROMs.

Cheers,
Ahmad

> 
> Cheers,
> Ahmad 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


