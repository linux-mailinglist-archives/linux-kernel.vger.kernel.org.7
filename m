Return-Path: <linux-kernel+bounces-753442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D40B1830F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7BE1C231FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1DE263F5F;
	Fri,  1 Aug 2025 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Bv5ESVA6"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6621E50E;
	Fri,  1 Aug 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056821; cv=none; b=VC7PFSbOsH4LmHJm9Z0fEQ/yA0O0DNOLyhTKBUxz64GttD6zoFSduxpgGwGqQJupBLOam1sv5YJRBAweM6vTAtx6kSTDJRlCiYPrMvIWoLZdFhhxDcOtBvPQbQOrZg72pdiq9OXsNJ2vfUdY7D+ibhkyhVk7rRAAb1PBnxyYnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056821; c=relaxed/simple;
	bh=o1xQm3ex6rIpAJgljaZrp0uhiKxN9NvV05vWkM3szOw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ezYkRy0JkZfDykor1heF6BGclMiRNwyp13alsurMTLAE5Z8dYWZD7oYgJ5hTGF/wElx5ktUBjvAZAbgSaRHykU2Hw64nTXFcaGcwWjxJ4N75TEZ7lRMp91k2Vuy+tfodawNSMyix3kpNniqNfrHaN06AZ/PtCyGUO+3Fr0u6BUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Bv5ESVA6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754056810; x=1754661610; i=markus.elfring@web.de;
	bh=4fMoVd+d8obHSmWvTNNQhMGi/D3hyc5ryNyxStfLR4M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bv5ESVA6gzUbgnLX6EG6hdn+AGMcPXbBWSsU8dLy88ati5i+deZxKGjWateMRW4l
	 WjqsEdwhml4UkCdgLOTEypX5MFs9Of8Ui9UUaLV5GwNmVMzKfgopu9mW6FDKqgxIF
	 aDgB+04N2MiGEAAFddPNZeL7cR9wOOgxFdQu+x25ghVkqLYT20xzbbfl+yDvBlHCf
	 b2WfU6GwVX6rlexYcSSgHVPSS9qu+18FDzhp1VvgyNe4+cD7hrnYP0ppePO6/z7SM
	 uRJX6hvMZQzrGBkCjTydL5bt86BvquBTOgcBxl9JbN2O3GNIX7Ec+czWibNQA5nVJ
	 lM2sdFTZGd1aeE+sgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1u5kvc13dO-00nVQC; Fri, 01
 Aug 2025 16:00:10 +0200
Message-ID: <60a236c2-0b36-4a2d-b0f2-40371b8c9236@web.de>
Date: Fri, 1 Aug 2025 16:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Ni <zhen.ni@easystack.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20250731062331.1041773-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH] clocksource: clps711x: Fix resource leaks in error paths
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250731062331.1041773-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L8nYjihPJrJegUq+HCfvP2F5XWp/oL6IkWilrur6nxv06YRfUGI
 yRbm7n6mwgGQOzxk+pBLnLXxAli2MlpdDsaRcJT5hxfsqthF0sS/eUEmGXbx1lmD8aFNlNK
 Qqg5dNs/Ykg3axp8OW1x8zCPorjwxiUiH5wVPZptDvbLfjd2hkoOpg3wZ3Cc6ZKXjvLREin
 dqybxtPOfvmgKsLXi6qJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3/Fip8MlB18=;3bPHX9ujK9s0EQ5Orc2N2RMVimm
 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

> The current implementation of clps711x_timer_init() has multiple error
> paths that directly return without releasing the base I/O memory mapped

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145


> via of_iomap(). This leads to resource leaks when:

Please reconsider the need for the presented enumeration once more.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -78,24 +78,34 @@ static int __init clps711x_timer_init(struct device_=
node *np)
=E2=80=A6
> -	return 0;
> +out:
> +	if (base)


* I suggest to omit such a pointer check because it was performed already
  directly after the of_iomap() call.

* Would it be nicer to use the label =E2=80=9Cunmap_io=E2=80=9D?


> +		iounmap(base);
> +	return ret;
>  }
>  TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
=E2=80=A6

Regards,
Markus

