Return-Path: <linux-kernel+bounces-634529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A3AAB250
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A344C1B19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 04:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFB379D7F;
	Tue,  6 May 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="blIsO1yF"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306482D644F
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485709; cv=none; b=vF6Q2j/ubwwYTKXPGamixHSgHH6aYgIXqIb2w3UEnD6hir1ONczam24M/n6VkpA69/rLXMBQySaqxLxVUo8yYMKFx6C+afeYnj8XfmoW+aNqe5A6fgTy6pR0FoajQkyphPFjRIYxsdb9aMW7mLyK7P/T50for7Mt8o/XmHUPOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485709; c=relaxed/simple;
	bh=Mg2CXirr6UvTh7WdZZfM5Ugt9d72LzrmXthHN3w72ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OORbrXCEDmRuAldr8iydwOgJQ86KoPe7v9/o35O62Xni92OvHIbJadPVZWSHstAXp7E4jlERTBENvgm77byB6bZs7Tc1A1DmQGyfo6Bzmx9zftRagyYqMqY9XfLi2dO9FdkWZgWQAzF90bT7q6WdJHd2gmXo0gvI/Qu9nCbeqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=blIsO1yF; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d812103686so16021075ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485706; x=1747090506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0MzPmtdmRQ2wegGs8YL88YA21hMeqRHBV5NTQWj3A=;
        b=blIsO1yFR1IS5CrCYFZYFmR327mV7FkydBSGwie6Tjvt3b98gzF8pnEsl8F5Vguv7K
         i/qgSoFkZU3KHommCYOvrE+AS0gItoRUfQdp8RltmPYg0cUFJOB8f6PDHs+U2u6I8aQC
         RJDWdDyYKasyW2UzoO7dT//Szhq3mzOHcisv/1YvGgYf999lVrJmzd87M5oIbxvpCwDp
         CZnyt2HjMo7V2jhgnICrsQJSgohO31XdfkCVzLL9fjV9tDOm6i/SX2Nueo4mwHR57Rtn
         3AnezZ4eJCR6CnY4pYCFjk3tY7b/1cGQxiGL+uWEy9g0FMMsP4mb/189u7AoS/Uv6j5V
         AEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485706; x=1747090506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv0MzPmtdmRQ2wegGs8YL88YA21hMeqRHBV5NTQWj3A=;
        b=mDguj0KRchYUPjMAc7+S/yos2/CH2oNKj2mwEsHmPHHV8jWBuIEpKmvxEtIyqrrMME
         dSPdbxmaejvqGsigzbgbxNUVwo5njWrOD5th25B56i1lQMisSc1n7b4zoL5qQE7UZvYS
         pXLctkbWDtUj/Gik6ywlfnK55th/Cv8GnNcTHI57eKNJg1V42AqvOlnsFzwvtwnkSOHL
         TNuswC8JTKidiL8cKXCNJMPp0vugwK8q3rTVUoRCpzbzmaW6nkWNxPUTK9I2mAL1dP+z
         PXDiXY8oJWy3qDK3wXOqeyRW8E2J8ddlPbBNqTie0Hczi00ogThGRLds7XAW0prDYazt
         D1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWIqCnbIUe+GtM3Wms01b5ajRIF9dcJlWERixTxA/nkYjUmW1XL4lwU4NyY9Zad2h32qOSlXHYr3/vruUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7cusgyS3Gsuz4BEq6iT+Q8LrX9s4cDoz7qnrmKwfF8CKolGg
	4Rh1qxm2gti3yBc4hh8n4RkCsaLiwzDsC9Ad3jq7r09Jmm0z1H/Fck+F5zPz5wU=
X-Gm-Gg: ASbGncv/510hGB0cH27aUklRCP5c8HVjCMN3Zjy7WPzfyyo2dll6MwOiXwkupuBlFun
	lfIgG5XSctKXRKZSguZIZlQqY+s0qlphEkI6p4BV/ShL0c2gaPrnr/aXtjCAuVKNPlhXnqWESnd
	VIgi1fJ15Xtc7v12aWrmgcfcAUHAe5ajdY1qjZWeVUeph+ZgzYP2FR+N0pHFm4JzW0wMEjB+TnS
	2OLCik4bu/Cjtjfw7wI/xtkktY2ihbj+ICNR3eHQEhDWufm8tSP3S9i8LAkBmQdBb2UH03TCQvp
	cyhoZofzlT3Cz1+KyUtUJoiVMhhShHfvDDe7bA==
X-Google-Smtp-Source: AGHT+IHD8ML20CAJxh1aMxoelraKxk40IzV2DcR6+Tf1u925PW2sSl5JHvnPoT+pcjPADCDtKFI1gg==
X-Received: by 2002:a05:6e02:219c:b0:3d0:26a5:b2c with SMTP id e9e14a558f8ab-3da6cab0417mr15472125ab.8.1746485706305;
        Mon, 05 May 2025 15:55:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f6dd89sm22445675ab.66.2025.05.05.15.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 15:55:05 -0700 (PDT)
Message-ID: <818fd481-3925-43bf-af04-a10244a52d66@kernel.dk>
Date: Mon, 5 May 2025 16:55:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
 <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
 <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>
 <aBlBdBl8uKCIVOPG@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBlBdBl8uKCIVOPG@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 4:53 PM, Uday Shankar wrote:
> On Mon, May 05, 2025 at 04:44:19PM -0600, Jens Axboe wrote:
>> On 5/5/25 2:34 PM, Uday Shankar wrote:
>>> On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
>>>> Hi Jens,
>>>>
>>>> Can you take a look at Ming's comment on the first patch and merge the
>>>> set if things look good? I can rebase/repost it as needed.
>>>
>>> Bleh, sorry, I meant to send this as a reply to v2:
>>>
>>> https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/
>>
>> Let's give Ming a chance to review v2, then I can get it queued up.
> 
> It looks like he has already reviewed all the patches in the set.

You're right, was looking at the other v2 that you posted today.
Now queued up!

-- 
Jens Axboe


