Return-Path: <linux-kernel+bounces-601719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C5A87182
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574C23BD0F4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30A199FAF;
	Sun, 13 Apr 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlOQw3pe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E128F4
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744539503; cv=none; b=F3n6tGmyH9c7+rG11ieb1MpJs/ATF5uz6qSOn7zurSvepUwHIllF6HJjbTA2KcwzTHaBNWB9Y305dUw9XpysPYlg0NrpFvrbKBPCxPOPbTa2g9W3WQnqCVYTcFMUvF1eyhcjbnFMnjSsJ3a+eMsXMWoECpG7Sbjlp41Hi3pGJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744539503; c=relaxed/simple;
	bh=ErHM0KXBmIzSgllbEKAnlsbmbsSO3NBrDWRZS4AynPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVxwkmBdlginLtYW42JxOpnEi6c17EvTOFDd+f6MjWJYGSxrngoNkdpnvenJp7xS/1jbwDIZcEAL0FlFW3ZEqj3Yr/LlKEj0OKUMHOXOrGMXrFLoxgfqdSk0ZXmTPlTW2zxNTIg6eBhA3YoT4ZYTVyFHOpmMnMIKMf1P1uLuhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlOQw3pe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744539500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBni/JY02a1CDsHN5yYPIoZRjHqyTeDi/pp/KcYRYRE=;
	b=FlOQw3peCKBuz4pBeWCKwy3IVA9TVBPU3QGIgqPfDTbuh4UgapGAtBOWwsYPqayF62QMVL
	UHp1Oo0mwIBaGowCf708bBkf4UzlRdU76mzL9AyKkT5gjMufHjqxcXBhp8tfrDs+mSCkHF
	m+hBd1Z4ND4IZBCRe9Q4q/Zy8mF+Azs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-oZ5xsQ5jOJihTtK3kpZwHg-1; Sun,
 13 Apr 2025 06:18:17 -0400
X-MC-Unique: oZ5xsQ5jOJihTtK3kpZwHg-1
X-Mimecast-MFC-AGG-ID: oZ5xsQ5jOJihTtK3kpZwHg_1744539495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9075719560BC;
	Sun, 13 Apr 2025 10:18:14 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF968180B487;
	Sun, 13 Apr 2025 10:18:08 +0000 (UTC)
Message-ID: <4f1633ca-bc75-4e81-8747-52605ce352d8@redhat.com>
Date: Sun, 13 Apr 2025 12:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mfd: zl3073x: Add macros for device registers
 access
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-7-ivecera@redhat.com>
 <3e12b213-db36-4a76-9a58-c62dc8b1b2ce@kernel.org>
 <b73e1103-a670-43da-8f1a-b9c99cd1a90d@redhat.com>
 <CAHp75VfR_6gQdcBU6YDTvtX0A2NDjto4LXyjTteGLmp-u1t2qA@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75VfR_6gQdcBU6YDTvtX0A2NDjto4LXyjTteGLmp-u1t2qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 10. 04. 25 7:53 odp., Andy Shevchenko wrote:
> On Thu, Apr 10, 2025 at 11:21 AM Ivan Vecera <ivecera@redhat.com> wrote:
>> On 10. 04. 25 9:17 dop., Krzysztof Kozlowski wrote:
>>> On 09/04/2025 16:42, Ivan Vecera wrote:
> 
> ...
> 
>>>> +    WARN_ON(idx >= (_num));                                         \
>>>
>>> No need to cause panic reboots. Either review your code so this does not
>>> happen or properly handle.
>>
>> Ack, will replace by
>>
>> if (idx >= (_num))
>>          return -EINVAL
> 
> If these functions are called under regmap_read() / regmap_write() the
> above is a dead code. Otherwise you need to configure regmap correctly
> (in accordance with the HW registers layout and their abilities to be
> written or read or reserved or special combinations).
> 
Hi Andy,
these functions are not called under regmap_{read,write} but above. Some 
(non-mailboxed) registers are indexed.

E.g. register ref_freq is defined as 4-bytes for 10 input references:
ref0: address 0x144-0x147
ref1: address 0x148-0x14b
...

So the caller (this mfd driver or dpll driver) will access it as:
zl3073x_read_ref_freq(zldev, idx, &value);

and this helper then computes the addr value according base (0x144) and 
provided index with ref number and then calls regmap_*read().

And the 'if' check is just for a sanity check that the caller does not 
provide wrong index and if so return -EINVAL.

I.


