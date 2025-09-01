Return-Path: <linux-kernel+bounces-794757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD6B3E6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C758189396E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E82F0C66;
	Mon,  1 Sep 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPQ9smyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B426D4F8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736393; cv=none; b=n5ypcPZ+tuLQA+egw9TRNxg7Ubj7aTMT1LZspwKu2K/UCm/GTJoy8qsCGOG/6cA7Q9ExM+YGdrRsnQnYsN4HGHb8x2APOJYbeDZZjCj/RIp48b7WOdqCGBeqpd86ZiaVcJCqSbHGTiGh8++75cgUk+HrVWAmCtJuU7oFKtB8fpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736393; c=relaxed/simple;
	bh=qwR4eNLSEphXQYoDu4XlkNku43wQhu7Bs42cSMtT540=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzmEDy7IWptSfnaPnNRD/Xd1QvfaD6O8aBIZxJicPPV9iN3C20vsD14YwDL1srlgZ+hhNtFNa1N7vP1Bj+I4X8nzQJgbuLDxku4bMLvpFWPOmNByE4d+jiD9yXyatDt0ODiHnpcPj9Hr+AtU+fV1iNnEtFT+Q2Sah3sIc9+o1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPQ9smyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B60C4CEF0;
	Mon,  1 Sep 2025 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756736392;
	bh=qwR4eNLSEphXQYoDu4XlkNku43wQhu7Bs42cSMtT540=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mPQ9smyLLZAOt+/sSFM7ixGpGSb10fjRr5tJga38Wd9eFLAgpvsiQ1TQL0MRV3O05
	 H2eEK+HKCPbbl6h0gsXf43vrh8Ux/adqtnV37GuJ7P6Ph8gdRGXhJQiPb9KSw2E3ck
	 oCS5EfvU/ET1HkFBSBGVugHIIqNRBUfdHfgTIIafMv7ImXYo839qUldjCPZVF4DNxl
	 2AJrk6D7HLXsPfDkjLDhsSbH739ZUVySZrn+bZV/rtQuCrPMmMYloLtKqHL2piXEWP
	 /9JGaMNeOstIrkOERXwYtLKKqVJT3YV5BJWvAV/49olDe13PrOj4LqtB32ShqidNkF
	 mBICWiww/imRQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: ziniu.wang_1@nxp.com
Cc: pratyush@kernel.org,  tudor.ambarus@linaro.org,  mwalle@kernel.org,
  miquel.raynal@bootlin.com,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  haibo.chen@nxp.com,  han.xu@nxp.com
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: core: avoid odd length/address
 reads on 8D-8D-8D mode
In-Reply-To: <20250708091646.292-1-ziniu.wang_1@nxp.com>
References: <20250708091646.292-1-ziniu.wang_1@nxp.com>
Date: Mon, 01 Sep 2025 16:19:49 +0200
Message-ID: <mafs0tt1mw8ze.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Tue, Jul 08 2025, ziniu.wang_1@nxp.com wrote:

> From: Pratyush Yadav <p.yadav@ti.com>
>
> On Octal DTR capable flashes like Micron Xcella reads cannot start or
> end at an odd address in Octal DTR mode. Extra bytes need to be read at
> the start or end to make sure both the start address and length remain
> even.
>
> To avoid allocating too much extra memory, thereby putting unnecessary
> memory pressure on the system, the temporary buffer containing the extra
> padding bytes is capped at PAGE_SIZE bytes. The rest of the 2-byte
> aligned part should be read directly in the main buffer.
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Series applied to spi-nor/next. Thanks!

[...]

-- 
Regards,
Pratyush Yadav

