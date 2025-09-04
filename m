Return-Path: <linux-kernel+bounces-801018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD8B43ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DC81CC066D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6731B102;
	Thu,  4 Sep 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5NyE1DF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6431985F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996100; cv=none; b=Unj4jXurh/5TDKEVYs4ikQNkLCE2Hf5N3j+A8IE4Jy3wJ3FxhKih+oQXtrYddEZwdAWAOnJjVH+RWs2VMUDcVVo5PxGMN+IqUMs2x1W+w3UB7KmiD97GvxlU6EqS4g3ICW8BLd2khHe+l6Bock9SxKgfpfl5Kmqfhran6Pkhkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996100; c=relaxed/simple;
	bh=7rNh+q/6GiZsjQK3QzeqsPQyi4srMLPWub0MT1cyFO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TaKAahZKZXuG30mbotjtGJ29SL0zHKoxwLX9B1LbC9Djlx0MaaKXHcbS0cIleKjD2/lT9yBiIRwOVTFGXIZnDushYSyBguEDbXJZqdX6CUwLTsxECNodCFKQ4pgp8ppUn1DU+AymTRMvEPMDzldP9Ay163ImGyZbg37U59hlnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5NyE1DF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415F2C4CEF0;
	Thu,  4 Sep 2025 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996100;
	bh=7rNh+q/6GiZsjQK3QzeqsPQyi4srMLPWub0MT1cyFO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b5NyE1DFepVzAcZVQILT/DQmvh8W6tjkIn6o6jyJWZJcnM1qke69hPWQPCMl9R2lO
	 HeuJ+iPMnY0Sj9VwXK7R5o01EFkk4OX/Jvwqi1kXNuGFc1oZrEikrOjdiSQ7z/LonE
	 4PQGlSKyZD2nH+kmq3QhZflAxy0qohsMOL0m40cLR1jCVcaqOq5lggG8Yc1Ty1VRH6
	 q1TXlWcYF4HV1qh00mCl0yzIW5yECPJLL/6BQU7ZfsgzjYe2iJtpToVSzkhVOBajwR
	 PZWLuSXp9ZQmVzY3fEek6VoXlqhZlKgzJ+oaQ+v8c6Sf2O+pe1orgBJJpFdM393dPx
	 imBlksga+P5Aw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <miquel.raynal@bootlin.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <praneeth@ti.com>,  <p-mantena@ti.com>,  <a-dutta@ti.com>,
  <u-kumar1@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: spansion: Modify addr_mode_nbytes for DTR
 mode
In-Reply-To: <20250904131309.3095165-1-s-k6@ti.com>
References: <20250904131309.3095165-1-s-k6@ti.com>
Date: Thu, 04 Sep 2025 16:28:17 +0200
Message-ID: <mafs03492uwam.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025, Santhosh Kumar K wrote:

> The nor->params->addr_mode_nbytes parameter defines the address byte
> count for the current addressing mode. When transitioning between SDR
> and DDR modes, this parameter must be properly updated to maintain the
> correct addressing behavior. So, implement the necessary updates to
> nor->params->addr_mode_nbytes during both DDR mode enablement and
> disablement operations to ensure address byte counts remain consistent
> with the active transfer mode.

Doesn't spi_nor_set_4byte_addr_mode() do this already? What is the
difference here? Are we missing a call to it after
spi_nor_set_octal_dtr() in some path?

Also, do you see a real bug with this or is this purely theoretical?

[...]

-- 
Regards,
Pratyush Yadav

