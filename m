Return-Path: <linux-kernel+bounces-893658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221BC4815C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E889F4252C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01231285C99;
	Mon, 10 Nov 2025 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aZDpW1Rc"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13867283FC8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792606; cv=none; b=cz6pc6+XfpYuHcvGYweSNxGe0SEbPcwYLNYYqIPePA5YvMcYP46VkkXNG1qUxmAAGVaoZeWE8GQSg7NZrm0er/94d59dlHxWOwNGYv5KYLD/DZMtaOj2kyG2eDBvBqw3yW5lfXMoHGcy3oXVXEaxjJ/TVk7VDqvDv5oKlwjSDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792606; c=relaxed/simple;
	bh=3lvZ5poEGFQfHxwl3ERPUYTDsg81b/5oMjVOtlxG5oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttWUGZVNoT2tDW3+AuvvZaTSrmDtu4TAija6M7x5b1mT6wdZ2Bfgb5543eyXRYa7kK+GE26HB4T26VpLCVdi66WnnaHSGGSsXr3/ok/Ut28TfA7EcgdrpsIeT3vBwAchDZvYvmfRhlf9WbQVGzVFq98N7Q6rvPHnzp1iJpxr9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aZDpW1Rc; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76896942-0f84-47d0-90ca-7bfc5d39318c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+P7K+rz0Ws/ScnZWiTNIBElASi6e33VQ2WL92YsmHM=;
	b=aZDpW1Rc7Ox8OUMVxRfBV2n7iIwaFCOTeIgUYRm3px8cVyQGd9a1anbO4V2kjPTBssfN/W
	/cYMhiR8uPV0c+kKOjL76dp82ahwxOgJl1sxHQxy4EL/PBmaO6cV0HRkBRw6H+Wk6pGc/C
	VO8EIEQF8c8iuyGTBo4W2gwM84TXMS4=
Date: Mon, 10 Nov 2025 11:36:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
 <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
 <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
 <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
 <31d01667-e80e-423c-bdab-8d05831d575d@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <31d01667-e80e-423c-bdab-8d05831d575d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/10/25 02:08, Tudor Ambarus wrote:
> 
> The locking tests look fine to me:
> 
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Sean, if you care you can extend the documentation on how to test locking.

I'll take a look.

> Also, you may drop the non SFDP data from the flash's static definition as
> a follow up patch.

I don't understand what you mean by "non SFDP data".

--Sean

