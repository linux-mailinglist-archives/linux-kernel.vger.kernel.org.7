Return-Path: <linux-kernel+bounces-799798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72AFB43069
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864B0A002D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265127FD48;
	Thu,  4 Sep 2025 03:21:08 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5B2580F9;
	Thu,  4 Sep 2025 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956068; cv=none; b=Z3wzSLH7r5194TZ4ao8+ZV/yIdEMF+ilAArnKrN9l+TN5ZI/+iEKChyJpEyseg6KaJB9YlAaQSLVo9Znyu7/roriKGuDu8nyc9dw5OPqZmZH6DX9n7aPGayXIfN1eNY1dZj96dDydxkKTSED0XwBm24Pi6e/BAsNzRZ2+pEVtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956068; c=relaxed/simple;
	bh=uUYadek0U0lSLYgMmZzc/zWIFhEdSzUtNynSG++lD9k=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=fLWtzeXN2Ztdix78Cz+EZVkC52NmmFAJGgOL0zft9f+SBaWqsHEYTigCb5C57PGzuzazOlJ6+34olQIajVJJPRuejsS3yLT/wHZG8qodOU4GQ8KduHeovk2A6RWdFmIDdfGQwMTcWhhivW+jPJdmg0EikaJY6G7ks/oaz9II3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cHPrT30vPz5PM3f;
	Thu, 04 Sep 2025 11:20:57 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5843Kktu082422;
	Thu, 4 Sep 2025 11:20:46 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 4 Sep 2025 11:20:47 +0800 (CST)
Date: Thu, 4 Sep 2025 11:20:47 +0800 (CST)
X-Zmail-TransId: 2af968b9058fbd8-93a82
X-Mailer: Zmail v1.0
Message-ID: <20250904112047291x0u6rEj36pRfhR9daQdFa@zte.com.cn>
In-Reply-To: <202509021454480003xS5M8WmAIQT2F_IiSd3p@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn,202509021454480003xS5M8WmAIQT2F_IiSd3p@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <yang.yang29@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDAvM10gdG9vbHMvZGVsYXl0b3A6IGltcGxlbWVudCByZWFsLXRpbWUga2V5Ym9hcmQgaW50ZXJhY3Rpb24gc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5843Kktu082422
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 04 Sep 2025 11:20:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B90599.003/4cHPrT30vPz5PM3f

> It's more intuitive and easier to understand the patches if show the
> output of new features in git log. And we notice that if PSI or
> delayaccouting is off, delaytop will output zero data, I think we
> should tell user why it's zero, since not all user knows kernel config
> will. Else:
> Acked-by: Yang Yang <yang.yang29@zte.com.cn>

Hi Yang,
Thanks for the review. I’ll address them in v2:
1. Add a message to inform the user when PSI/delay accounting is disabled.
2. Add new features use case in Documentation/accounting/delay-accounting.rst and git log.

Best regards,
Fan Yu

