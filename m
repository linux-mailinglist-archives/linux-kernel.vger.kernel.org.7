Return-Path: <linux-kernel+bounces-867936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9CC03F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FA694E7D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5F15530C;
	Fri, 24 Oct 2025 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw1l1vku"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE578F4B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266731; cv=none; b=giMUXqoMsIQWwMOos1zo93S2CbclRRpBJ9as/yq4krsOwXx+NtmiHFqcjo/K6lauaGEdmyrcX++ign+Tqc+LWy+ba4VVGDwbfoKm/q4FHqt5LByNp7vydsv6u4XLLLsVWwpjudwYhDWw92k9Sdy934bj7hZVduMO/YXMtTCo2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266731; c=relaxed/simple;
	bh=dp/cP8zcAEvQUvgno1S48/Mi8rnaT41MC9uZ0aZ6H9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2brgFr2Qaj+laG+eOUUolin9dC2g6+e9k89MkLHIeHxc7K+kNfO9ZJBB74C/Cq8iTGOWRmk2Om8CAnJnrTYWWKxsu/yZ99uWi3JZBY0c6g96v2VDat81PyQjwR/SgTxdxyHEDBfqYw0wm2WbfJc5iedfLDUON2xTCiVVyx9PEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw1l1vku; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a226a0798cso1204122b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761266730; x=1761871530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiQAoFGDew/ZqTfreZLnGJFxaRca4v0mR/t0Zt3wPxM=;
        b=mw1l1vku56L7HpDQG9IYJY0DNNmV2gMQZKbybN1aKpHuZ92bFsXihhEB0RV4kg8SOV
         VasqW8wWBn88fB0b+tmfiMAMl0RXuraDXvxcWUkIpp+mEm7Iv/UaRp7H6WTBCT1pV2k+
         GghpZmzjbxuCIlhkHXM5iCS5tEaFrBbgW9XUZ3/VqEWh2uIs0Jc8oCJSZFR3qtujaHb1
         3IxcVnpdWNAz7flPUyFUO8ch9pigfM7COSUuxy+TosQ5xIkvcsrEUxQwzWyN2cZfuV0S
         eNgKyTrj/VIIZr3teOWIYgncNGolU+qXXfpC0dUWvfnsmZ5KTC5WeT64fN1/RDC4P9eD
         SrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761266730; x=1761871530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiQAoFGDew/ZqTfreZLnGJFxaRca4v0mR/t0Zt3wPxM=;
        b=rN1E7Qn+iUABDEKNtTYR+eoXBJHMGBLweL+SMUxwOAVyC1AVyKoMdYbWUOmSiu0wfU
         iwzMEcFx0lQetD3XgzN3Iy60bj+lkp4js+TZAIefD5lQ0zqSVU31ymSJA8P/rRynFTVS
         9b0o3rJimOnd0OWnFz281oDrbUcb4GbFVOywJceIKCqagvay3kHVhl/y+OsA46PCLzs7
         tk0066LXKhegnlz620jYp1Zru0biuuFeOi8ZWhfnEJ15kBIc/JsU1mG8axSH0tjyYnvU
         30zWsFy6WBlfjhTqzqDWcQLShGBMtFOU1z70frrA7DjRvIZqrhHxVb/y1IcG9Qlz5MyN
         p+EA==
X-Forwarded-Encrypted: i=1; AJvYcCXRUVnoFFTX1CX2yyoNW755Wv5S3qYCcl7jlhrDENPf/eLA6dWKfZwRQh61Yz/6RcdxAPVifgtUQayvhFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxUlCP/AwUC4TcdKclNQxq1NoatKM5AWu6satyCaVhnNMeO9G
	rnaudDiFubpbwMg2fXJ9sAbGGQ8Szsq0dk4Wa3pd1lCMgNBHnIw6ZE1OK0VbB9Lw
X-Gm-Gg: ASbGncuTteedtvhzran/Gho1J1WMDx6ONaSf17WWqua1svHuwRGxFv9Lzp8xPCH/SPZ
	8BOHJXkRW7zXZEHnxqbqpeJ+EK6SqE1RDool9CflNBK8lPtiDQSUWoa8nGdVVvnQ20xcGgvEg9o
	0ywBwAIRqIq/1CORWVgiU4xsujHNJjV4ZSZ1FSrSVWfrz3P1UIY0/sOMnl0z1eh9GyfW3RSvlyk
	e9UG6qiwe/0P3US3NyF3g/HyP5sOrYKOSLWtiq8OsTynB6A8TMfgbFow7tYoy2NFhgrY6V3kZ2n
	LFV+UYdWmfvMVXeAgRpI0k55q5VHJI/1sWme0OjlJr8s6Spf458PVborsRIn4dh+krgpVOozL2D
	cQ6yJhndx2XU2DAXDT6K26QN7lwEU48paYSU8mGWRVXlBAoQj/ijGd/s8yUc7Mp8dPRMnKOkZUz
	A8JdUqnlQ7ktTx5jjvzxA=
X-Google-Smtp-Source: AGHT+IFnnZIKoGCQomFCAGHPFnchCLdxRUrJ5xP0ExMryJO2JZfGanXAzObKKUl27Cc8JB6hozrsOQ==
X-Received: by 2002:a05:6a21:6daa:b0:32d:b924:ed87 with SMTP id adf61e73a8af0-334a854ac50mr33328122637.20.1761266729651;
        Thu, 23 Oct 2025 17:45:29 -0700 (PDT)
Received: from [192.168.0.150] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a602c8sm3973490b3a.7.2025.10.23.17.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:45:28 -0700 (PDT)
Message-ID: <c1400c7e-ba80-4814-b5a0-3d326d97d4dd@gmail.com>
Date: Fri, 24 Oct 2025 07:45:17 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Documentation: ARCnet: Update obsolete
 contact info
To: Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Avery Pennarun <apenwarr@worldvisions.ca>
References: <20251023025506.23779-1-bagasdotme@gmail.com>
 <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>
 <aPnqn6jDiJkZiUfR@archie.me>
 <b77b8a60-2809-4849-8a6e-a391eacf050b@infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b77b8a60-2809-4849-8a6e-a391eacf050b@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 23:43, Randy Dunlap wrote:
> 
> 
> On 10/23/25 1:43 AM, Bagas Sanjaya wrote:
>> On Wed, Oct 22, 2025 at 09:21:43PM -0700, Randy Dunlap wrote:
>>> I found the ARCnet Trade Association at
>>>    www.arcnet.cc
>>
>> That's ARCNET Resource Center.
> 
> OK, the ATA is  https://arcnet.cc/abtata.htm
> 
> I suggest changing the link.  what do you think?
> 

Fair enough.

-- 
An old man doll... just what I always wanted! - Clara

