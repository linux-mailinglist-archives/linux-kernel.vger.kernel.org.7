Return-Path: <linux-kernel+bounces-785821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE8B35176
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61311B605B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD631D5141;
	Tue, 26 Aug 2025 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNlhrMQB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D9A927
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174541; cv=none; b=oxXupgfw/YnDwEFFN7lpHG8VUVeoN7BbAHM6izrB7JRL4cgD0Oi0Knq9W7F2K3JEh27ISywdFT032kyqY3LiteGpl93Uq8cMDO4k8YIicpJKtOiXGquADDSQFL+ARSr8kDiPChO/xoNr52HibPnCqpoSadWZxYXnyEW3RE81kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174541; c=relaxed/simple;
	bh=lNn91KbVZt1MO8O4XMP7lZJ2kB5e/przdBqRhbBK2+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=he48qrTlDOVE7TXPBnFmNiFIwlCF6OAS8++SpomGmn1unzcMoOCcP/8rbS6YCdJui5WK0MWhjEyi3nbLu61Y/JtKCK2dR2tUuFLxfNoVDAYZLWuqJcan8/Fw51Clldsww1H2igY231tLY6JS/hRbNABHDBRX1Aix07v7QQkW1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNlhrMQB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244582738b5so45009895ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1756174539; x=1756779339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iv07/KZb2f9dDjde78c38QxQX9Rd8L9eycmeggHBGOU=;
        b=NNlhrMQB8JCAvjLKklda8N19vCFNFdK8gYcnGcAPb3B8Gl7iD3EzN8WhfDEwF0i3ai
         HmaEmHj3nAZjmea0CVqujske6JHRF22enEVXNEI/pGjhkinAlrjmSqEd4lP2Trui2hLV
         NBU5BYnklLHKPDlsSm5a1gPfx5yA4pVJbtQXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756174539; x=1756779339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iv07/KZb2f9dDjde78c38QxQX9Rd8L9eycmeggHBGOU=;
        b=KrJaR4EZ5/NGWEgBH9qvfLRIrKx2/0QxfXXvwtFVlDO8PqJpHM2wC18oBeXV9DMbYq
         SWuNgFuPv8kegmxsFHg4uoRAk42wj0W8A3btkME8Zx4MuWde/T6HBcc2oHSJyA5nIGY0
         kS0nGuv+dqT8LZk4jaJc8US71gyQ0cf1nsG7E5nVZ6M0Ql7bp+ScuotXgy3tun4Tmt/R
         eFSiR7fMVaYEW6/v47ilqTiPU87IfuIAo/hw7T8WxjuNlJyBb0cGcxFlzDyzFfDcXV13
         HlyuDh2Cyfj7v9qRVIK/2XkR3g6v0nLHgSQA72Kr7jWb6usAuQc/KZ7Iyi5JjiqBkyyr
         bCMA==
X-Forwarded-Encrypted: i=1; AJvYcCWB/TDvcwWMa9IrHlZXFzscbOhA5wzO3gxzTmS6u9Gw1XOVbR6iFYRpjhoT3kNbS+fXxloSszrwYDGR6QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTLx5sjiKqgkM0QMeBxeWvrZkwgUC9lrrFE5ki5F+APW3Tkfi
	lafgxeSo8hCpyDPdyrKNBJmMlPH6Uw9N+BDM4KB+bgKuwICiYmecEP8tEXsAeTiTQ8NURj4gVoe
	FP+L7wew=
X-Gm-Gg: ASbGncuEU1f9cozgtnD5hP0MtbpBeHIdFWWPfA8gKk5nVavk5Ia8xYHQX3i4stO5ZGJ
	fdujVoPfLmp6lTqk4XKt2RU/Jphvxo0jJquiLp7bS5+0KVk4S+EtLZTYCLKvKUeu5bSH5CvCcdr
	q5CkzUcxOkCG7mcg3aB6bTNeg4fdBwqvIoj9m9jVfWEz+kQS9bK15K2GJiy+2jarlWILGzPSV7s
	L6yU084o5yhq2Gu9/vH0tyGWQlYq2mDwjNl2XdUx9QfSspXzDiIh8EXHggH01o803QPwUmvhNy8
	VW6Uz1PZ4AKJhUAb4u3VShOJzKS3qrstABV3WzFnGSt8iuqHfEfyIMHEvI9KzsikdHEm0W9hjxj
	Ub4UIx7rJsc8vB2G+QKZXpqjFB+TbXg4yIDvZ4g==
X-Google-Smtp-Source: AGHT+IEl90DE1zmnqNRIEzCk3KpFZ8tkAbZvjeW5FkOiMTSV0pQ6tPOU2Y1tolJnm2RBcLKGj9Herw==
X-Received: by 2002:a17:902:c943:b0:246:7d53:d40a with SMTP id d9443c01a7336-2467d53d82emr141657515ad.12.1756174539032;
        Mon, 25 Aug 2025 19:15:39 -0700 (PDT)
Received: from [192.168.100.106] ([103.80.12.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a5fc5sm80869965ad.52.2025.08.25.19.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 19:15:38 -0700 (PDT)
Message-ID: <4d5bad8a-6afa-4284-8f78-b52e2cfedbf0@linuxfoundation.org>
Date: Mon, 25 Aug 2025 20:15:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: David Gow <davidgow@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Marie Zhussupova <marievic@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250818120846.347d64b1@canb.auug.org.au>
 <1befd7ab-f343-450f-9484-0cef21fe2da8@linuxfoundation.org>
 <CABVgOSm2_FGfjQpUBttuUH5ZrMEqnaGkYVkN6N96wX7Qs8EE2Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSm2_FGfjQpUBttuUH5ZrMEqnaGkYVkN6N96wX7Qs8EE2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 01:44, David Gow wrote:
> On Tue, 19 Aug 2025 at 00:32, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 8/17/25 20:08, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the kunit-next tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>
>> Thank you Stephen. I did a allmodconfig build on 6.17-rc1 base - didn't
>> see the error.
>>
>> Marie, David, can you take a look this. Looks like conflict with drm
>> in next?
>>
> 
> Thanks, Shuah. I've managed to reproduce this with:
> ./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig
> drivers/gpu/drm/xe
> 
> These patches fix it (and a corresponding drm/xe test failure):
> https://lore.kernel.org/linux-next/20250819073434.1411114-1-davidgow@google.com/T/#t
> 
> Ideally, they'll be squashed into the corresponding patches, as
> otherwise there'd be some temporary breakage during bisections. I can
> squash these into the original series and re-send it out if that works
> best for you.
> 

David,

Please squash them and resend - also I see a kernel test robot
error in patch 1/2.

I was going to squash them, but I saw the kernel test robot error patch.

thanks,
-- Shuah

