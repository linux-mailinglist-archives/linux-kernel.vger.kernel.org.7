Return-Path: <linux-kernel+bounces-892811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D409AC45DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83ECC3A7957
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEA2FF661;
	Mon, 10 Nov 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkt29zTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3567B3E1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769775; cv=none; b=sgsvNP7SdWRxwTWlcNnt7j+VFEj+n3U0DOZNDYhvk/d/o1QCuO7X9DZBLGfiMKXLRyeziSlsla0wrCYEmLyiDkj9cJEO78ehA1sLCY4jmFEYQjfzjVygR1aHoHMrOhVtJZqWGZcJCkoo1ST/S/xoRi7rs67lkAwzR3egrTLDPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769775; c=relaxed/simple;
	bh=DJA5Aa/vg9m7bpPMnFdOHwCVKA+4Me+gV58laoWd5cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FulByfq3AFop6ZfH9NZ7V9rdyYN8NpREPUQn8r2I/v7UEIlURdfG/SztbKzDBkSYCOlVaZ1ECdybyGKJ6lKfyCZV+BXQmHEGtDzuxDCYWXZ0PuvSf0K0SGvpaKwYoMnqW5C4zCSJE56w/lkAb/T7+ROhSEhQnjzi48bMRJSxsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkt29zTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098BFC19422;
	Mon, 10 Nov 2025 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762769774;
	bh=DJA5Aa/vg9m7bpPMnFdOHwCVKA+4Me+gV58laoWd5cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bkt29zTo+SOJmqLIOVUOauthXmJqxSbhtbJDQ6lq4RuVobrP4yqQm/DV0WxvAU2e2
	 YKR0KaEAc6P07f6hLk2zya+gbDBK9Q+pPM++fbtGt9VKfEz+phBFiFLcdoMTP5NHCr
	 XMBR7Z+O8kWe4s88tvYrUH5nHvWaUAwlGIL7z/o6foHUAuRSafviGk11byqrLaiKpk
	 zVWkt/FCkf5YGdAP1UfZWboGADAi8CtjebRmoXQMwCa3RuElCWl3OiAgyLvKnY9fsH
	 /ywJh5dO2ElrqnMtWZUw/GxjMsLPtc3npybpTnqYvL6RbbKkQpuDMUgdj5HZUN5PeG
	 kGtaJ98xkCfKQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <31d01667-e80e-423c-bdab-8d05831d575d@linaro.org> (Tudor
	Ambarus's message of "Mon, 10 Nov 2025 09:08:07 +0200")
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
Date: Mon, 10 Nov 2025 11:16:11 +0100
Message-ID: <mafs0v7ji9or8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 10 2025, Tudor Ambarus wrote:

> The locking tests look fine to me:
>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for reviewing Tudor.

I would like a re-roll with the commit message updated before applying
this.

>
> Sean, if you care you can extend the documentation on how to test locking.
> Also, you may drop the non SFDP data from the flash's static definition as
> a follow up patch.


-- 
Regards,
Pratyush Yadav

