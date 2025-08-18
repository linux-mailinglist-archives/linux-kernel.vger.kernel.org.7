Return-Path: <linux-kernel+bounces-774362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6CB2B15A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F42A6DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6D277C80;
	Mon, 18 Aug 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ThTocsCz"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454D271A7C;
	Mon, 18 Aug 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544064; cv=none; b=JpOFmmvHuAbZLjKbbYiD1I6vOIvSR5FW5szwxMilOoY8F3XDdnB1tpSEl3RF+BgpkKv3adV0MhW7Hr2fuMVyBc4lOolx0SzF7aRNX4MO4qd8OLKNJrXv2OEU5C6QvcZqdUzMfAJGTdahYmIXDDntMT2FhDBTLPNctAGUIMPaGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544064; c=relaxed/simple;
	bh=eZdxLW88zfkblEQbCdbcQcKLZ2GUQxwIeoARmBrCWf8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=B1d6UIfknE4J80vXaBhFgXg31Y8GFnCUre28mHjoVJ37LYb6SX12ey4+uHW59uhCqFBJkQBDeYDWa2+GWM8HsCXYzrwsADo6R5kL2zq02xwCRdrVMTo6P5jwvjK8hamvglSZIhVL/kfU3+X9y+R5ipPnIo9bieISuzLa0h2OwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ThTocsCz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755544060; x=1756148860; i=markus.elfring@web.de;
	bh=eZdxLW88zfkblEQbCdbcQcKLZ2GUQxwIeoARmBrCWf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ThTocsCzFExJMQCfM2OIy5w6S7MTt/KXYUn+cZuZj8ib0rh1JuiyXiAxeOqt/LbK
	 Wkxofgo1miuKEQP0TWEXRAzHYMb0JnddREBx6vF6SM31jf6TFHbENYzgJLpIiPVGR
	 kgKx8ewnY3InhulBC+73To1pkbo2RP0/uYqM4CpOYKOnSWw3t7HVT1Pi1Gzmhn0JE
	 Hxj1IM6N4C2mxfe4PUro2aBeReFQrgjMvi310nK6mCWVUmB24jpJU4tkcKNLwfGCg
	 9XUcn1NMokWF1O1Ys0EcEnKQlYoBzjQv5dr0Wjj4h39CLxBiFjJxkbSQKZmhHdt61
	 2p70F3gFi1VHxzg7ZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1v6iW80VW8-00JR8m; Mon, 18
 Aug 2025 21:07:40 +0200
Message-ID: <6b2496d7-02ee-47f2-8b7f-f30e351e9b2c@web.de>
Date: Mon, 18 Aug 2025 21:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20250818140204.4762-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] extcon: Remove redundant 0 value initialization
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250818140204.4762-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pc1Vy6JwUu9Xg5WcDKekYgON8SQQX0BKolYdeFX1800X8VpqA8a
 OXdLfNeZk8xBhq3cpd4/7Uy+1g335FU36SAoA63cw/32WdAqu0b+aOWmQsLTB0TPBAEMEZJ
 6/z8jM86rITRMm9Lyi51/tOHkN6QfM5cXUF4nxd9xqCgOIHgHTUIBJCPINFAWW6tTroZbJN
 ckk/C4upaqhgTqJzQc6sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o0nCn/E9xtc=;+d9RYgKnmyG7fkopVPPrjvM9Zvb
 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
 6H4I5gAxQ7pzVgwE=

> The extcon_dev struct is already zeroed by kzalloc(). It's redundant to
> initialize edev->max_supported to 0.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n94

Regards,
Markus

