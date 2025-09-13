Return-Path: <linux-kernel+bounces-815322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9EB562A9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCC4189DA67
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B523E350;
	Sat, 13 Sep 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="zPJVTfEw"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85382214236;
	Sat, 13 Sep 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790415; cv=pass; b=u55teX2dKPHIpG+Lm+nEAaLLsa4ZoaVM2tlHWQEm605zcoe1MxDoiQ+ocucK/iEZMCOHZwfU/5i8KTqd6gXAiiJU+B+OYPcsu5iWLTEAJeJKApFdaarpApBP5K0CzBHFtkUKfYzzumbq0mKfUiYYkkErYZ9+OOs+EfljdAZvMsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790415; c=relaxed/simple;
	bh=Ue+heATPxUSmCAzJfwMONOybrBlnu8e7QJ1gGPBQrAA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rBs0clNoFPFZ0uNRfX9z38QGGkn8DTz0ui5bqVEveqeCGS65a0a5KlL5qDQtA0XP/GIMYC2r6gXGvyEMRJMT9D1Ipsv+jfKylZoSisYDQ/RZkcUZI/TyVZBbDqAPcYXdkD4HhODu0WRrMxZbHgCt6st3vLhAzyjOGqSxPGgeKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=zPJVTfEw; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 217691032C8F2;
	Sun, 14 Sep 2025 04:06:49 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nHA9VnH-mq9; Sun, 14 Sep 2025 04:06:45 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 6C88B104A17E4;
	Sun, 14 Sep 2025 04:06:45 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 6C88B104A17E4
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757790405;
	cv=none; b=dzugCXHCu1Qqiqfz978psy1rcIlI5EJU7LqyMKgsA2SFf0t4Irvl0OwuJXWj1e+Tz3WGVx3c5mXKbjFN9T0MnsRs2HIe0c6YlhQs4YDxey4YKsSBdHfI4LIr+bBDN/l8NzIIAGJZi8uOdpHec7iFDcrd/6igTwPDxvnOpzSG0RE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757790405; c=relaxed/relaxed;
	bh=VGmRmgzF9O/74mQ+eSoKjnDJ4Ms8RvM/BPlTQbxlWGE=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=0jYSsai07BFA9uQBCC5ZGAF0oeMHA7I/gj7EGT1htl+XSbrJuOe1eANiyM1KnSfdva6rokcjazaXROo15y/8nf/b5mAR322k4B/uHpMpRMc8bB5VqFr/GgULeiI58kPgUJvb/QEb6N+xk9UevdZbBRXQExaRfb+Phrie7b5AJzA=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 6C88B104A17E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757790405;
	bh=VGmRmgzF9O/74mQ+eSoKjnDJ4Ms8RvM/BPlTQbxlWGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zPJVTfEwci/XqBoANtKoWSENSH2K9tSm+5inR1gDvBVpqqzEp7OQmkdZQkWZdphIp
	 3Wz41/EJIo8o0QRvzd2iVUtuqkc+ByPgyxaK/z/7ADSemmANa3UQ2qcWjWljwP0OBx
	 yhKlHsE5SInYwJlG99UzT1+D1MSUJBlYnuDtO2lo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Sep 2025 04:06:45 +0900
From: weibu@redadmin.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, mpearson-lenovo@squebb.ca,
 derekjohn.clark@gmail.com, W_Armin@gmx.de, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH] docs: w1: ds2482: fix typo in buses
In-Reply-To: <208fa944-6aef-4acb-ba39-d351d364c53e@infradead.org>
References: <20250913173413.951378-1-weibu@redadmin.org>
 <208fa944-6aef-4acb-ba39-d351d364c53e@infradead.org>
Message-ID: <453591332395354ff5fed38bf0ea9349@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thanks, Randy. I went with “buses” since it’s the more common spelling 
in our docs for hardware/data bus.
I’m happy to follow Jon’s preference—please feel free to take it as is, 
or I can drop/respin if “busses” is preferred.

Best,
Akiyoshi

2025-09-14 03:42 に Randy Dunlap さんは書きました:
> On 9/13/25 10:34 AM, Akiyoshi Kurita wrote:
>> Correct a spelling mistake in ds2482.rst
>> ("busses" -> "buses").
>> 
>> No functional change.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  Documentation/w1/masters/ds2482.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/w1/masters/ds2482.rst 
>> b/Documentation/w1/masters/ds2482.rst
>> index 17ebe8f660cd..5862024e4b15 100644
>> --- a/Documentation/w1/masters/ds2482.rst
>> +++ b/Documentation/w1/masters/ds2482.rst
>> @@ -22,7 +22,7 @@ Description
>>  -----------
>> 
>>  The Maxim/Dallas Semiconductor DS2482 is a I2C device that provides
>> -one (DS2482-100) or eight (DS2482-800) 1-wire busses.
>> +one (DS2482-100) or eight (DS2482-800) 1-wire buses.
>> 
>> 
> 
> Well, I'll leave that one up to Jon. The $internet says that
> "buses" is preferred but also says:
> "In both British English and American English, busses is a less
> common but still acceptable variant."

