Return-Path: <linux-kernel+bounces-767933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70131B25AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0D3AF3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0A219EAD;
	Thu, 14 Aug 2025 05:11:53 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AC213237
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148313; cv=none; b=GuNuMQX6eo9x2eZo9X4hKWMZhqjzR4TCzrDWsj6O6JMTgE18lmCccEaPEk8thLxLWIsb0Wns0aePbvihJX+LaF2YBRVUbBBL8+ezLDMDYF7/s4BuG10iANIY01r09XRvuM431BZE3ZYX8DPFZt+kBNoDSm5x6fw/Us1aVy+aVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148313; c=relaxed/simple;
	bh=ib0m2WYde3ocUwOUbSBQNFPAlQdXdbLUOcyM2Tmxmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoCzFV1UX98E1YPrNaPM+fKE7sQzAGtcAS9w0xmEceVIKKRkfYPxnO+L9NQjeOtNMwxQa2zAFRZ1v7mYth4dw5RNHlJpDEes2mF9/xcts0KDQgRs6y3Xe9CTPjXg+Km3X7hmzhAc3boa6wcc1NfCx29KJspC3hgvioBobDxKOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7f5.dynamic.kabel-deutschland.de [95.90.247.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC32E61E647BA;
	Thu, 14 Aug 2025 07:11:03 +0200 (CEST)
Message-ID: <be90ba43-316b-45fa-963d-7faa14b2cb4b@molgen.mpg.de>
Date: Thu, 14 Aug 2025 07:11:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] peci: remove unneeded 'fast_io' parameter in
 regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Iwona Winiarska <iwona.winiarska@intel.com>, openbmc@lists.ozlabs.org
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
 <20250813161517.4746-12-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250813161517.4746-12-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Wolfram,


Thank you for the patch.

Am 13.08.25 um 18:14 schrieb Wolfram Sang:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
>   drivers/peci/controller/peci-npcm.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/peci/controller/peci-npcm.c b/drivers/peci/controller/peci-npcm.c
> index c77591ca583d..931868991241 100644
> --- a/drivers/peci/controller/peci-npcm.c
> +++ b/drivers/peci/controller/peci-npcm.c
> @@ -221,7 +221,6 @@ static const struct regmap_config npcm_peci_regmap_config = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.max_register = NPCM_PECI_MAX_REG,
> -	.fast_io = true,
>   };
>   
>   static const struct peci_controller_ops npcm_ops = {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

