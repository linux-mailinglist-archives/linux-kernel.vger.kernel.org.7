Return-Path: <linux-kernel+bounces-836536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD142BA9F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA63C0D09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BE30BB88;
	Mon, 29 Sep 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+Ag0KUB"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00041B87C0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162032; cv=none; b=PdnzCZnRyrmyX7O6xzOmHie5XMTSKddmOacMps9YJqa2a6PprRaRR6H2QvZgmxPq8b+td5EujADs9avO6Jn9Mq1GJtTwpR6CqWyr8yOu/A2EtKJ5sZkUhRVL1o2jGmw/HgLDJ61OtLGWguI4e8Rwxtpvy4tNj/yCp/Eh9IZx+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162032; c=relaxed/simple;
	bh=hIk+72cnhQ/vyXYspLR5rqsPDSDikL9OCAzZiu7PCpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM9kyv7oKf5PhPYXzmOviN2UcuIVDLyC/dnDw0vqRFKJe0VY6TRCezaVh4XP7Xl4ylwCvmNsqmZBM6H9OpW+VxWfaVl17ZtRWJOGF8DzyPczOuX2kiFDDQkkYf/kkj1rLCQz5/EHMilKVn4njlXu6DizFa8/PIolmIufXniAIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+Ag0KUB; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92aee734485so39162539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759162030; x=1759766830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=929brNp38LQE1zEUdewrHj7AY0N4kam7Q/lhFDeHYEw=;
        b=C+Ag0KUBigQ64v2D9RxO/mf9l7iiV7pJooTmG8FbNaKoSzHjHvDBcOo3XIEaxNfcE9
         YQAaR8j+8iUlBNv3M34/SQLZMi5ZmBrDEBwfKr+CeprHoGXaXy3SC9B1WGbZMiwo3pRh
         A2JfNVugh5ihSVv+Mt/N6aqT6ooBRUU/yWKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162030; x=1759766830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=929brNp38LQE1zEUdewrHj7AY0N4kam7Q/lhFDeHYEw=;
        b=DaHxCS3FJtBOHz3PwwAUiJP/0h1FF9WAZFzG24HteSYLruIz85d2vuB2JWcYOJgAHK
         mCVgTpmkgpW7PedsuAx1bKbdYcqtvnYqW9F3yopnb+mb0RfhckZmhmi1JEqc6y6x6GTh
         6l7tlqEMs0S30ex3k5IRSOkrWsiOvG4ysqa27NuvRFVWzk9Okm7sNGE/f++lHaGYImfL
         ysW89KUiESFRYAsw87ZCcCMay/NWwkZf3w7yo88IcDDHvvcyMihoFeo/tGa9iLsQ+cpX
         hDiePrwN0C7K3ky6WTxv7inXiz5lJlMIb4qcl7SCVEPkE2iuJ730B2TpDXxyprAvF65B
         rMYA==
X-Forwarded-Encrypted: i=1; AJvYcCVDpKOPKrtT4woVKiAsYVdLs8fb8L3a2jL5grbqnzkxXuKvAUZfAo0AeoR9+U/pbHUs3Fe82pbtVabO0Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fPhw6TyYKI1r+XKFeUF+uw+VWtWE07xEmWxzfldZuZhNImjH
	8YByu9/4hYpAdYJzPmb55oJSIzr7f9xXjzVHRBHQj5SNvYF/Ahgdxet1rxvebdys35w=
X-Gm-Gg: ASbGncuOdwjQz2g/KZ0l6g0euGasklH1LBtaotlyTuOQo+zaczRBDDUpFYe9RTGcKWT
	lYSasPmpj9ZihUanAwHbXVAn4VTMGwzH6LjQ6xMYBk5qiX+O5PdKjPvhsTMdN6YLQ/Dpos1/MoC
	m9DF3qb7cVKsAjPkojNIplqJ4bCQbhS6HD6m2DJzDycpqSUbyJbDbZW6TBHfBg7SUE6ElgqOdeW
	IRKUEZiGww6HQXiIEfxFAO/iT9/DcTVTSctndqpztFfiJq97t27aIk9UzdEpror01ss4sLW58lk
	L0WM6tIkMhYuP7cybwR+9rMN2pDrzVvKjY4cBF44lXCTTSikaqu5npEJBHhQY2lQb0Ocmf9I+Ct
	s59YRcGGQfDYAlrR4GoJFpFYu25bvgtkXoopHOyLccjIHcFbqXEzjdzQO
X-Google-Smtp-Source: AGHT+IGGQnZ9lMbLnEDujEK9tAloKwXvVr7upeO6oa8FE/9AtgzYPiFIpmG1O1IA+cT7ly4JhGxJ8Q==
X-Received: by 2002:a5e:c206:0:b0:8eb:1451:91c7 with SMTP id ca18e2360f4ac-901528e52cdmr2112358139f.5.1759162030006;
        Mon, 29 Sep 2025 09:07:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-903faacabb0sm446872339f.7.2025.09.29.09.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:07:09 -0700 (PDT)
Message-ID: <31594439-66f1-42e4-b122-e5888bcf2e12@linuxfoundation.org>
Date: Mon, 29 Sep 2025 10:07:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during building on next-20250926 - kunit.py run --alltests
 run
To: "Berg, Johannes" <johannes.berg@intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
 <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
 <PH8PR11MB8285FB2BB207666DE9814F61E91BA@PH8PR11MB8285.namprd11.prod.outlook.com>
 <0f3a1bad-4e8e-473f-8f78-92a6b96450b9@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0f3a1bad-4e8e-473f-8f78-92a6b96450b9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 10:05, Shuah Khan wrote:
> On 9/29/25 01:07, Berg, Johannes wrote:
>> +Miri
>>
>> Hi Shuah,
>>
>>>> I am seeing the following error during "kunit.py run --alltests run"
>>>> next-20250926.
>>>>
>>>> $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit
>>>> --jobs=16
>>>> ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in
>>> function `devinfo_pci_ids_config':
>>>> devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped]
>>>> Error 1
>>>> make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
>>>> make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> Yeah, really my mistake, I didn't consider what happens in the test there when iwlwifi is built but without CONFIG_IWLMVM and CONFIG_IWLMLD.
>>
>> I think we should add those to actually run their kunit tests too, which would fix the build issue, and maybe even CONFIG_IWLDVM to increase coverage of the tests in iwlwifi itself. I can send a patch for that.
>>
>> All that said, the patch that breaks it is in linux-next via iwlwifi-next but seems to actually have missed the cutoff for 6.18, so we're good for now and I suppose Miri can even squash the build fix into that later.
>>
> 
> Thank you. Sounds like a plan.
> 
> I will send my kunit pr to Linus then.

Later on today - I mean.

thanks,
-- Shuah

