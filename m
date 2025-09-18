Return-Path: <linux-kernel+bounces-823181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E0B85C11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD82189F69A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E8311C16;
	Thu, 18 Sep 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="uZV5m+5Z"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDA3112B3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210262; cv=none; b=rqTsKVFdlo8j//JPHj/QypYEblWw0EfFiW82EHetRmG3rSWaxChqOGVceOyfDEwahGqk6iban7k6bNVvVB8WuZ9kQJ9PbEPfHIypxe62HZ927osmbgs0/4AyakwBF/QKinvIRKLujjyXgZe1xV5I1+sLXUX1O+jtshUg8h5xZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210262; c=relaxed/simple;
	bh=2Tb9OeqfqChMAE/bW8nihG5bBkS+86woGLLzweX2qi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hob5Zomj4M4sXwcFHmDPVIiv3Aj6M2be3EYD0V/3OFF3YbV4w9XLCI3O7XCK0hbTSrK/4Fr7iSZXvVRR4jGIEvCtL0yVPMCWiJ5Q/2VzBppHY7ivIEDeHhhJ5juhxbk6anKhfqOeNHRZNioKzQihCzpdsdT1oI/ExaE9OcB4e7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=uZV5m+5Z; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88c347db574so35704039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758210259; x=1758815059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYhrldrOGtsDoKDXkPai5Tm2eHb8T6uZE7LbE34+y/M=;
        b=uZV5m+5ZiO/EpqQZ1B0dAqQxg1t9/Yud1hON+cg+Jy2eFykM8cclQo7Ie6MCe+Ny8l
         b2nLtE5vm9pbeRzXCuzJCTsPWrx/TjJLiOOyz48qosrrYCFLGpemJtZwNB2X0d5IZQpn
         BAhpJkmVirRocdZ3sJw+AghvUuoq4xxDHKlmnBtiI1WEs1Qy9qpaThec9dUFeAlpbS9c
         O0F7NhqYEc01dPJY7o/j37sHLHeSJC/xx2Pv14ja+8ZjyBgMzJfd39lIEsR9PWPA+nel
         9n5h6dHpnenC01pG9AhlLXrSwRSKwqJElkylPkbeLBxqq7Zvxq3D5dHerhT706UmP7Np
         wnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210259; x=1758815059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYhrldrOGtsDoKDXkPai5Tm2eHb8T6uZE7LbE34+y/M=;
        b=nWBZ4FAQIvPFcM3pO+UxcoC2cZ7USZIYMZrkOObbGKpaWBPTgIOCiRbNW8B54Ph8A2
         Mjzjmeigzk+ENsNJSM+C2dXkdvL8xI2a7/NQHhpid5590kMeJgH4eCS8w9HIi9kxFS60
         t5fY6DLhNRj9wll7xIs5vPd9qCpTPWr3g5P5ADvGB6Qb/V/l1gNr7C2W17gYfKcxfy0g
         mQbNAcIDofyXTdFGE2Hn6T5UITe9cv5pSKiL3mVQ0shWsscB4BysV4CCSlayq6GZ28CE
         Mjwx2gOstJ9KYnt7Jrp8YSY5XlHeyjb+3SxrlfMm7kbTDddGacuuGXuxsD+fSx3UK2zR
         FqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkI0AM9JUBXw7fUTe65M1/ypUA/8uX/p/YKfbFlh/9eSradJsZ3EbadkG7ylkufYaJcjZuSubnWJywipc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jvSytOmCK+ewqfxemtsM7+06Hp9DMCrT6o1zQn/eRfpEjlQ/
	i5fr2B6xBQyH5pFEWSM5u/lKxmVzmv0p9eSdwzOewDosi/tD3Wm85ugCzvavClwEERk=
X-Gm-Gg: ASbGnct28H0iCz1Ves7drHiFTxg4Nj3b/zUDbMN2xshf8bYuBXgPGR8HVmkSkE1Cxaf
	BtjkZsyY/iNWXf4MMj5GmHHi9GvsOHmIswQuHDP6UAj0X5/XEFZFAIy2o3Z/pOBmkc4A+/G18VZ
	IsRydH6ie6P33t0xqWiyVk6Qb6xZ/re6W6061OVXMZ7Vqg0QgAn2bYYotwayHrJ7zLveTClddC/
	03PrJ8nQhwdalFh9DIAs5Xcu0pVRTIpsQAvOuArzo1z7dItGXV/yHmCN+lbbeg17j1zqzEVym9W
	WN8MgY3bqbY4TQz40RJtuMRAIX/40tSmmZKcATwW/BGiGTfLIwBUdV6tARH3KXyOe6Ov2kKl6uD
	M5H2aAKqWhP3KtnMMsF8a62Qsb9eJC+Lm24ux/b1k8K7xtn8gn1ap9GopmMLp/8A13p7fzrD7te
	wh9jFYYw==
X-Google-Smtp-Source: AGHT+IHyY949yC9PkpeT/QOBqAaxoqc0DHrnN3CUC5h5A0iVJ6RUW339AkYSX5xvq1CVEEDiEGOZ/w==
X-Received: by 2002:a05:6602:2c95:b0:887:50ab:5c8c with SMTP id ca18e2360f4ac-89d28b42cb0mr960281739f.12.1758210251747;
        Thu, 18 Sep 2025 08:44:11 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d560d3993sm1050465173.67.2025.09.18.08.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:44:11 -0700 (PDT)
Message-ID: <057f2f54-c370-455c-95ca-83f97d884f3f@riscstar.com>
Date: Thu, 18 Sep 2025 10:44:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	void *bufp = io->buf ? : dummy;
>>> simply s/bufp/buf/, embed pointer info into variable doesn't really help
>>> let's leave compiler to check
>> I called it "buf" originally and changed it to "bufp" because it
>> actually advances through the buffer (either the one in the IO
>> structure or the dummy buffer) in the loop.
>>
>> I don't understand your comment about the compiler.
>>
> for the compiler to check the type.. because people could even name it as
> 	u32 bufp;

OK now I see what you're saying.  To me, "bufp" as a pointer
that moves through a buffer; it would normally be initialized
to "buf".  Where used, "buf" doesn't change (points to the
start of the buffer), while "bufp" does.

It is an established convention, so at least to me it's carries
that meaning.  I am *not* using the "p" to indicate it's a
pointer.

I looked around for some examples, and there aren't a ton of
them, but here are a few:
   setup_dma_scatter()
   __cmdline_find_option()
   tmc_etb_dump_hw()
   dnet_start_xmit()

I'm planning to keep it "bufp".

					-Alex




