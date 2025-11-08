Return-Path: <linux-kernel+bounces-891720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916FC43530
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC7E1884E44
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB2284B37;
	Sat,  8 Nov 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KzNqIV1B"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC519CD0A;
	Sat,  8 Nov 2025 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640205; cv=none; b=Or+wcazDuxvjsE5HlGaD3XjUsQFSmvY3MrTYrVtVOc5ImukZJ9Zewdx+9Ox6IkUjE9gCWsJWOZC2cGJCdkl03A5eQxQI9/TCu7gF8PG7HAjbgT4DlLvn+9qluOJ0P1HBYIi77n9q2WgLJATGPuMewP9d5toVrqbHvY75c98WbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640205; c=relaxed/simple;
	bh=jOFvHKhEgZizZbYX7l4nURRm7AWaJu1sScC+F1d59WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaZ9I/NmN7BfkdN+lG/v+zMopZDJsT5J89rm0z5lzMJ4wwZ7+CHssQbJfvuyIEe4nVkSE/SiSY0GijVddbKu+NTQGV9MZ4I8Y6UB8mueKjkjcwipAvJphfKeQVRfb+SzU5D1AqjV+6nvvUTf/wYX8srwnZkztZ2mvo7w3WJS1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KzNqIV1B; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762640201; x=1763245001; i=deller@gmx.de;
	bh=jkH3XSq2P+LFZVX0oD4jti6JdS7MK22HI5kAsdgyCnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KzNqIV1Bvo0hbIlibvJXx3kUWY7SiktcDX09OWNQpls57PSYQNl1Vt8jX+o5C+eW
	 nrftktgY37BrV6P9S0N+z5AHX4dJpTmZlNdEQRkilS0s0bTLZITpcjyHoJKdpDnWE
	 EgtKv2vawNp3hGgu46w7lKO+OJSHwJCRp63E32y/dyqWr2LnihdpIplzRSl0fFquQ
	 efJQMGj//swdrLY9PxFT2lGqb7ZAppD1p8iq3h44dteXkAiBoJNgw6M8VO4BBu6+I
	 T9rIKc9wA0sFHhJ05B/29i6me5XuDOYHyN0Ot2vp+gUiLysAiLxpLmTd6EKPQ9xSo
	 JoWB9DvTOwRDockj2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.205]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1vhfpK3oNW-00LROg; Sat, 08
 Nov 2025 23:16:40 +0100
Message-ID: <cdddc093-8775-494f-a21b-fe23199d0944@gmx.de>
Date: Sat, 8 Nov 2025 23:16:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] parisc: remove unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 James.Bottomley@HansenPartnership.com
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20251013023011.955200-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251013023011.955200-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IOyYNYES8WsC+Llwqn8QgjsmvOJwe6SR05vXqncAkUSwFkxKLgC
 IS04NYkdXjas+n9cjIjHPnQJr25qW2oaA9IFnEy+YIalrYQ/RF3Uu1aESxoWNQGBCAkhE/L
 T4Z6xSnbgCwlwveMVaAgSI5ULGBg6Mj+P1Bpztx+6Yn8Y04qkKmfk2YItOVMYqRLzXsgROF
 KkZe2cXj4AKz7EYOChfMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tph42BBqTdc=;nzYt1rJrpq8QI9HVF2KKPSuSzyK
 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
 u6ADw==

On 10/13/25 04:30, Jiapeng Chong wrote:
> No functional modification involved.
>=20
> ./arch/parisc/kernel/perf_regs.c:30:2-3: Unneeded semicolon.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D26159
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   arch/parisc/kernel/perf_regs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


applied.
Thanks!
Helge

