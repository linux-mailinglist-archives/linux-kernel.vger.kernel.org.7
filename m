Return-Path: <linux-kernel+bounces-766668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D333B249C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820601A24E80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A02E54AA;
	Wed, 13 Aug 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMS66+jH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980317B402
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089171; cv=none; b=ssHOFGJx+Dg7OGbW0GHnHznTplJNlkjZAZuZQqD1q8fjYLtpoJNQAR/m3RbwK4CJs0/aWqUKjL3UwU7R8AjaOdPpznYhApc0LzFgKqnNjRLOnSt7g6XFLAeopE3i9kAXXRCeu+5vvAXBG5Pb2uhbt/nB5CnR3mMh42rqpyU6Iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089171; c=relaxed/simple;
	bh=ZT0JpTvVCigZnjnkn/I/KbtOHKxQ7IUW9aNh+zCsE6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BcWzDCyiQzcvFdLoG2m52oyRDUfGSJpewrV2420ySt3PzjKFOUWts8KkHiC1UcrT8xhS70j5alnSvZbSXqZvvmc4h68axwhXWwP4G6uSNE/90pyaFjQ54375izRUhBvxYtwcC4lULu1mhrLh9NMCwDxJQaaqEcAqnqF6za5l2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMS66+jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D86EC4CEEB;
	Wed, 13 Aug 2025 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755089171;
	bh=ZT0JpTvVCigZnjnkn/I/KbtOHKxQ7IUW9aNh+zCsE6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HMS66+jHDTZz8nqrxMWaySstee2iZwP7X7bOke9Xus38Cro7xOaOQJHDlyE/VQ9Os
	 cxZhsr9MxtUb3+AROO5A/vDhMzunaX6vKRwgVpDgUF5UV+7KC2xZ6mchaFASBNugeu
	 w6is+Iv5adU3NCKthpqxbm6vxatFISvxsitmIAeCVkCGEF7bDNkEeU3VE3d09AjUHe
	 glUHYG7iy5+PlFS4EF3OWGQimoILktKko9oQRbMd4eDT5xxG3RxguNHyHGCDI7LzBa
	 D5mPHkdei0ENG0jpdD+yNMhzbgMuOhIH7DpsO1OxA918kn3yV98k3Z0QgB885sBemo
	 Vy3BU95hPubeQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: "pratyush@kernel.org" <pratyush@kernel.org>,  "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>,  "mwalle@kernel.org" <mwalle@kernel.org>,
  "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Bough
 Chen <haibo.chen@nxp.com>,  Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <PAXPR04MB85749F748DD87CE41452AEBBED2AA@PAXPR04MB8574.eurprd04.prod.outlook.com>
References: <20250708091646.292-1-ziniu.wang_1@nxp.com>
	<20250708091646.292-2-ziniu.wang_1@nxp.com>
	<PAXPR04MB85749F748DD87CE41452AEBBED2AA@PAXPR04MB8574.eurprd04.prod.outlook.com>
Date: Wed, 13 Aug 2025 14:46:08 +0200
Message-ID: <mafs0jz37wfsf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Luke,

On Wed, Aug 13 2025, Luke Wang wrote:

> Gentle ping on this, are there any comments or issues?

I plan to review it this in the next couple weeks (hopefully this one).

>> 
>> On Octal DTR capable flashes like Micron Xcella the writes cannot start
>> or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
>> appended or prepended to make sure the start address and end address are
>> even. 0xff is used because on NOR flashes a program operation can only
>> flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
>> happen via erases.
>> 
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Reviewed-by: Michael Walle <michael@walle.cc>
>> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
[...]

-- 
Regards,
Pratyush Yadav

