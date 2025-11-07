Return-Path: <linux-kernel+bounces-890882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1CC41468
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF73BFBE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CA3385B1;
	Fri,  7 Nov 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Rjg2m0Ee"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F01946DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539983; cv=none; b=LNDxZ9sXhSyPc6fAcibwHPeRCNOOiPGatjpvUd01mYdIlhyeop/Q3dyAghNL2UbCUgBKcyP0KMv0p+AfP9kRbFSLwAqeCGxTAops/64XD4BleDcs7PxShzGZQFuPeC8klON6vB3PkVW2weVU0nbdynMOXxI3wmh0W6pwZvXOlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539983; c=relaxed/simple;
	bh=VgG9s1HBgFKG8X0J47BWMcB3Ws+yuJrhOI8gs2NfCxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVgvO2hHHPER7rs7hjxiKw7KyoIxHjhesp4mSxpelU8nu1pXowxFgjqgp0gTGPwctUxx49tRw9JU0WBPyAjggBygyltSMgeLXtCCUAuT3gVTDLjTfHKdSUxd2K165eYp+1RKFInpu+nfU7+XISbAFdQuH3ZRzxelxLhpQdMMs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Rjg2m0Ee; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762539958; x=1763144758; i=markus.elfring@web.de;
	bh=VgG9s1HBgFKG8X0J47BWMcB3Ws+yuJrhOI8gs2NfCxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rjg2m0EeCKVzKsTIoqDPWEYpJ1OnW31s31J+YrzcwQ17wiZpFolbR9a3lnsTAs0U
	 MykuDJNr6l05mK2iJC4F63ZlqBap+87t4JKuktpFa4xsoKDXAGKWtfLB5rRXxItW6
	 i6SC62Xc0XPOKxdGszYdwZoa/N9TEKr4GB7dkWW54IfnK5CN+BrOzi/JENN1nfCzX
	 ai8f0E+bT8xRg3ux0H6xb8yn4lhCl/6JNaJFV4kP7FkVRrdQcU7QmI5AfARTKB6AN
	 uUF/2tsVRJZ6I3fSZOGtEBtZd1d+U4a7l7X1j9LIIU8ryEyRDum4TuwNmSF6bnD+z
	 gjMc/EfINuRMefY4lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYcpr-1vlyir00A7-00O6gQ; Fri, 07
 Nov 2025 19:25:58 +0100
Message-ID: <14f5091f-b647-40c9-9c32-6a705c2d6c37@web.de>
Date: Fri, 7 Nov 2025 19:25:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] ubi: fastmap: fix ubi->fm memory leak
To: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, wanqian10@huawei.com,
 Yang Liu <young.liuyang@huawei.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
 Liyuan Pang <pangliyuan1@huawei.com>
References: <20251107100057.1091153-1-pangliyuan1@huawei.com>
 <7857ab09-7808-4abe-9df1-66235291436b@web.de>
 <DF8B15D4-4819-47E6-9BB0-268AD0204C86@nod.at>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <DF8B15D4-4819-47E6-9BB0-268AD0204C86@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qUFbe30IuuWTFk72/3nUs0ICF6i2iaahBaWze6oDF6svIHse/54
 a4oBRZAX2S62qpEQa9mt74uLi02lWVOIHeZE6T4XRE5jEDUgf9cH6s2Kg6a+glviA5nbfsN
 AYj+lqYRQLbQat9dMIrRaE1wpjTJ2CpgUKYnxMhPncY/R/1QLxrVo9itxiDDQt/1qAIntvd
 RU938XkdW2MyNjQ+gsQ+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M5/BJFN1wQE=;kzTK+/0BZ5hXwMcbmYLeL2N8ZD+
 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

> > You may occasionally put more than 60 characters into text lines
> > of such a change description.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc4#n658

> Feel free to ignore everything Markus says.

Does your feedback indicate then also that Linux development process documentation may be overlooked any more?

Regards,
Markus

