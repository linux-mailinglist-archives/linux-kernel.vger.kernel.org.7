Return-Path: <linux-kernel+bounces-832663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58320BA00BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117E94C6422
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1B2DEA67;
	Thu, 25 Sep 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OaF5ZXCv"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9D2DE70D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811075; cv=none; b=PoEXmAbWL4eZrUzArErqaZhs87QhqEL87VFdQPQDca3V8OXyjSX4ec8BWZ/ZEyjgU/zdkXv4uw3BNlKxzy27waYPp9SdSRHCzm2eezXapOKFCRdu5dxQb3b7iqNOP9MY5JMjvTYnk514yrQTwyC0a0unWgulQLybj8GFzT0tWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811075; c=relaxed/simple;
	bh=qsMfxYBrK1xcPBJMO2obsA9w7fsBTD8YdKoTkcv2jEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox3oFdUGIBUg9ZnYGCNJenLOUl5OvB+ujyPyKd13xTD+IXS462l9+v8HLlFtxK+yGCbfGbEnslVutQQjOJpSisvv8sHUD8KqVzVf2u26/u0SIZ2r17wP7s2Kj/oLd5r/xfwETpnWclNhidbdbgBIlynwhXtcDC2RsSC8PXOkcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OaF5ZXCv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m9Mr88ryg4l74a1fZPu2FPL1YOAK5V9355/JgF5JWYo=; b=OaF5ZXCvh9qXhDmBDfq0kHxqqa
	tott9KPRk5iIdnqm0J614htC02h/40dQV55a11t6U0ZOXNJRRC8cZst0u3HIrySp2MDl57IauPS99
	snMmrCgi3/zIgtMPJbLYN2drmcC3D9ZoxSq9TSO1xFfkPPzCwIC0/Anc3M33RAWYo5f1QZZyH/0QB
	z7GdbD7eCjnqx4J9bhDSUL3P0s8wcILfgqczF35TMN3EVwxuOfOS3VZmlkn/XMZy6cudJZAJWPLDO
	pYH7Fl0Z85+kwlgjsv79sTE0O1/eh2b+PmFKrpGJp2aTkcmNvjH0vmckV+aLUS8KhiV44cKW18EBk
	lJkO/CqA==;
Received: from 201-69-111-249.dial-up.telesp.net.br ([201.69.111.249] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v1n6N-00HRCM-23; Thu, 25 Sep 2025 16:37:43 +0200
Message-ID: <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com>
Date: Thu, 25 Sep 2025 11:37:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?=27Thomas_Wei=C3=9Fschuh=27?=
 <linux@weissschuh.net>, Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-dev@igalia.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
 <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,

Em 25/09/2025 11:24, Mark Brown escreveu:
> On Thu, Sep 25, 2025 at 11:14:23AM -0300, André Almeida wrote:
>> Add stdbool.h to the list of nolibc.h includes, otherwise tests compiled
>> with -nostdlib will fail with "error: unknown type name 'bool'", even if
>> a nolibc stdbool implementation is available at tools/include/nolibc/.
>>
>> Reported-by: Mark Brown <broonie@kernel.org>
>> Closes: https://lore.kernel.org/lkml/833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk/
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> 
> Fixes: f2662ec26b26 ("selftests: kselftest: Create ksft_print_dbg_msg()")
> 
>> ---
>>   tools/include/nolibc/nolibc.h | 1 +
>>   1 file changed, 1 insertion(+)
> 
>> --- a/tools/include/nolibc/nolibc.h
>> +++ b/tools/include/nolibc/nolibc.h
>> @@ -116,6 +116,7 @@
>>   #include "sched.h"
>>   #include "signal.h"
>>   #include "unistd.h"
>> +#include "stdbool.h"
>>   #include "stdio.h"
>>   #include "stdlib.h"
>>   #include "string.h"
> 
> It's not 100% clear to me that we should add this to the nolibc
> includes given that nolibc itself does not rely on or offer stdbool -
> I was going to send something out adjusting kselftest.h to unguard the
> include there.

If we don't include stdbool.h here, it looks like 
tools/include/nolibc/stdbool.h cannot be used by any test, and 
unguarding <stdbool.h> would defeat the purpose of using -nolibc?

I'm also not 100% sure as well, lets see if Thomas or Willy can shine a 
light here.

