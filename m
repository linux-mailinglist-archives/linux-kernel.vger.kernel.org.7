Return-Path: <linux-kernel+bounces-812232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DFDB534CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3FD3BE062
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E483316902;
	Thu, 11 Sep 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kahaefUb"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF020FA9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599433; cv=none; b=MS0mnAOVfzjywOo8c8M9+DhwO2t59L14/yTbpUNOXevJQAy72HUk91ebZZOceyGTylbiv80dTjJQpxM6T3zItLS4i6txPzvIHL0/G7gnRGIygYDkbSHC3T632ISrp/LGxLOZe7lABEoLt+1UyLg5MsPbReA5KyCfjfSb3APHzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599433; c=relaxed/simple;
	bh=4H1jk3gHqMGs0J9A7fWYd+JIW+b92sOQU1SeP+0OrhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJ/fGPsYHCCpVTt1HnnJa/MfLK0DVAUGzlCz8JoY+2kgGPN3FejHAFTxcNmYdyLjhiDXKkfrOpzPqkARtFnRHKSAlyX4XnLzZ6y7/FAGKisXKJ0pj0tI02dtvJSRxSiGSykdKFM3aQ9yhcnm9sYtM1ITe2QF0uf7o3widdKZWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kahaefUb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AA9C7C6B3BD;
	Thu, 11 Sep 2025 14:03:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 876D460630;
	Thu, 11 Sep 2025 14:03:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40340102F2833;
	Thu, 11 Sep 2025 16:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757599429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CDK2GVhKguRdAprpwq3TCBc/3qnYl+uGZ7pjzM5YAm0=;
	b=kahaefUbv/GwS3Tf82x07gIbaokOyyoAL8ctxaE9NVsC1xGcEeT6p0af1damiTMWd/F8uk
	rOSBSewqzHpSEnRVkrYge1mFKF+8t3vnJz+GK4tapukLMwrwtjpdC/yTzsyFUiDAuvyclB
	9emKDQqt7QnDMJmYamryPcpZk1MilFgpilabDDWceTuEZoElYRb2bg9CXKUFfHVI2W8eMd
	ndjbbiJT7MoVO18nOrjCeIrF/qW56ma7PjQRBm1R7EGiPx1SK6I0OvkhsZv2TjJmVNgAKI
	sVEm4/tFcYTE/UvCiJ4jRyEEqgMxUIaCnZijx3YxL8+47pKQ7U65S7phKN9HHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Santhosh Kumar K <s-k6@ti.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
In-Reply-To: <a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com> (Gabor Juhos's
	message of "Thu, 11 Sep 2025 10:33:48 +0200")
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
	<175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
	<454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com>
	<87348tbeqg.fsf@bootlin.com>
	<a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 16:03:39 +0200
Message-ID: <87frct9jd0.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>>>> Applied to mtd/next, thanks!
>>>> [1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
>>>>        commit: bf7d0543b2602be5cb450d8ec5a8710787806f88
>>>
>>> I'm seeing a failure in SPI NOR flashes due to this patch:
>>> (Tested on AM62x SK with S28HS512T OSPI NOR flash)
>
> Sorry for the inconvenience.
>
>> Gabor, can you check what happens with mtdblock?
>
> The strange thing is that it works with (SPI) NAND flashes:
>
> # cat /sys/class/mtd/mtd0/type
> nand
> # cat /sys/class/mtd/mtd0/oobavail
> 0
> #
> # hexdump -n 2048 /dev/mtd0

This is not mtdblock, the report was using mtdblock, not mtd directly. I
don't know if that actually makes a difference, but it is worth the try.

Santhosh, please send a revert for now.

Thanks,
Miqu=C3=A8l

