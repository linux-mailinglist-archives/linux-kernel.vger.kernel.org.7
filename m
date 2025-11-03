Return-Path: <linux-kernel+bounces-882454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42804C2A81D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10A73BC9B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3112D7DC0;
	Mon,  3 Nov 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qaJIqKJP"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2D2D7DCE;
	Mon,  3 Nov 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157199; cv=none; b=VjSjB3k+NmQ1EdVGqkz8Ndmdi91dvmcsuIZBIcl7DISAQNQLQNDg/wV7jUHlwdUMKnn2RskD0ELgBkGY5G0uTB+uEUauqXZ+8AC2+pW8NXNRs0y9JBq/Ang5O1PVG5Kxo8NJ1Hyw9dXYXUB0K1h5lV/mVGcP30OHIoqzkcYhxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157199; c=relaxed/simple;
	bh=/74cktSMYLp+ktcjEue6HWwDM7axHBFgOQmdgvIC1gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb+ResaLvc6FFw2h6XGJTi2AYsRUFkFP7X1o6jJRsYSih2+B+mbKfIK0wE1x6vVdRZ7sCgKLbtorcEISapps5AIr8gMZy8wVazwfzgzDqNTQ2OaeweuIawvluZuCYZC3ZJofvr8NMh7pNhV6i3nz+QzLTm6BylIWIkJcrz969V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qaJIqKJP; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762157129; x=1762761929; i=markus.elfring@web.de;
	bh=/74cktSMYLp+ktcjEue6HWwDM7axHBFgOQmdgvIC1gs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qaJIqKJP9ZwNzwvm53OZ8AD/3L3yjImYrj+/LsoEf0J7cHj60eZIAnHhv1lCJ649
	 AY1f4S/TRmRMAlZugyOPgg9OlrSMT+PhGnQSHRXVAV3A0e9OOul+3TsrMFnvlEnxt
	 YqcrwUlcvzN7Wt/OmSTuuURJeFZiPIWmEaafkx64mxKGSsqwuT9UyH/Rz1l/r553n
	 DX7KObEPmW8IgCaE8oKvP0mHanDG017376A9TjWYuWQuyZLtr8Se0JEhL3IZ66kt2
	 30vRTQToxjeVrkQCCPYO5HzpF335XaByVlAH4+FQ7T28zz6Z9FP4IE+JGV++SpIJj
	 lrTRhyOucBvULtuEQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1vKFQ12BSi-00FRkI; Mon, 03
 Nov 2025 09:05:29 +0100
Message-ID: <65eda66d-a6cd-408f-ad00-c23b8f675a73@web.de>
Date: Mon, 3 Nov 2025 09:05:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clk: keystone: sci-clk: use devm_kmemdup_array() once more in
 ti_sci_scan_clocks_from_fw()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Raag Jadav <raag.jadav@intel.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Corbet <corbet@lwn.net>
References: <a8e94921-a426-4db8-aed6-b6e17e88b8e3@web.de>
 <aQTLHlv2_V9Pgjk3@smile.fi.intel.com>
 <06be737a-365d-4a2e-89dd-72fe415bc7d5@web.de>
 <aQheXQLhrn_fOnyz@smile.fi.intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQheXQLhrn_fOnyz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QGujYg4NANfYF8P89orDyKUdGs0nUSvUGX7V/iErFROWOCTMr54
 BoynwWdOCgeLn1k2Ad1m4uh25eN4KFGGdjnuVuD0nUao2ke8Z9UkXBpqvCLL7A8AI4cRLKu
 erDooRE0txexIxsFSHtsLmGZFZbPWlkj+zYtcfD3S9INyNC6KlUjBr186aPpIMRfyyRm8bD
 b3c5LwHiXKlmKXgTGIW/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NUrLSnLVcLI=;wdNnC3K5R7MW9Fneki44Pw3ep1K
 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

>>>> Fixes: 3c13933c60338ce6fb2369bd0e93f91e52ddc17d ("clk: keystone: sci-clk: add support for dynamically probing clocks")

Will further adjustments become more helpful for the affected function implementation?

Regards,
Markus

