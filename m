Return-Path: <linux-kernel+bounces-686819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99324AD9C30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 12:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520D317A90F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898A1F30BB;
	Sat, 14 Jun 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLUChVXM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952D24B26
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749897568; cv=none; b=nVAHSa7seeqoUzt7UvsPP1Jf/hMJsW3nT45rF/ZJs67b0RokDGmcvlKQkQZsNoP3E+livS+Zxkdyp4BpFwufHw1cSSNnIh+y6rpQdlasLCnKcDvosaGwg6OiBb6HLsa7ApdDn3Pg1Z9x6SVxbydIk+2mhrrmBoYxPBl1lZpYuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749897568; c=relaxed/simple;
	bh=ljuppTqyX9qOD/vtLwotTaA9fqBjfssPGpbLtG8Pjsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2i3b29Gy9mP/69Xh/IjQbj7HvGBNuBogW7CBl4yYflgwOdLCbv9jq7C6kgw/w8uD/KpTn23sHidjVcE8fWxqXOfgPgoh1L6havnaR8KESUPdXFADAUYu2SrLhFmPwwiKvllSxdqFt09V0uYvSGZnD9xLwelvjp6uqaKO3kBrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLUChVXM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749897565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfJRAujRjuGi7KQbNecOBzzOmJkqRWWoAoZaJP2IUfQ=;
	b=ZLUChVXMiqWrkCyec8HRcmdi1gkuickRh6CJ+TXGSq1pnoPBApe7fg2UCelHdjCkrlKSkg
	qlPcfwT4nPBPLk/xJNS8N5Lxl9MxvArpj6OqbGanicgN7E+YJB9/zDJ98SlV4ulukxdXLU
	fDI3jBC/YzoQ+LTDWV+nZO7nXRGPtL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-G2aoBe6gMUuwFE-f18DMzQ-1; Sat,
 14 Jun 2025 06:39:22 -0400
X-MC-Unique: G2aoBe6gMUuwFE-f18DMzQ-1
X-Mimecast-MFC-AGG-ID: G2aoBe6gMUuwFE-f18DMzQ_1749897560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA721800289;
	Sat, 14 Jun 2025 10:39:19 +0000 (UTC)
Received: from [10.45.224.53] (unknown [10.45.224.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51270180045B;
	Sat, 14 Jun 2025 10:39:10 +0000 (UTC)
Message-ID: <00780331-37cb-48ae-bb87-06d21a9ec4d1@redhat.com>
Date: Sat, 14 Jun 2025 12:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during
 probe
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250612200145.774195-7-ivecera@redhat.com>
 <202506140541.KcP4ErN5-lkp@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <202506140541.KcP4ErN5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 13. 06. 25 11:46 odp., kernel test robot wrote:
> Hi Ivan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dt-bindings- 
> dpll-Add-DPLL-device-and-pin/20250613-041005
> base:   net-next/main
> patch link:https://lore.kernel.org/r/20250612200145.774195-7-ivecera%40redhat.com
> patch subject: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during probe
> config: alpha-randconfig-r061-20250614 (https://download.01.org/0day-ci/archive/20250614/202506140541.KcP4ErN5- 
> lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 10.5.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot<lkp@intel.com>
> | Closes:https://lore.kernel.org/oe-kbuild-all/202506140541.KcP4ErN5-lkp@intel.com/

Jakub, Dave, Paolo,
should I fix this in v10 or in a follow-up in the part 2?

Thanks,
Ivan


