Return-Path: <linux-kernel+bounces-814179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947CB55053
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4256416DBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400430EF8F;
	Fri, 12 Sep 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDD1fCTe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599F30E857
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685828; cv=none; b=VDo3LVI448PDV/EEop2OCB9gQMJj/18jzdMqIQ9Oks0/cAJoTW0XkeccQVIyTgLZBXJKArDnd8xXvAzCyDWbkVthhiMa28Kd+eZVNV/9t5LokMPrSYaJ1BNTfWxFYOkioPIU3pP1qclRGgp0adN7TRM7++zdjAUo7Fcs38aM0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685828; c=relaxed/simple;
	bh=1I9+Pj5YQSChf3iBDwOVDQ5DkCm9d8fa1LEnpkGTDlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyT1d7CN2sn0Ya8iOH2nLvfJUuJ0S1TjnkGg5O0xcgX4tRjaEBi9uh1t89+DqeqfOG0aPPYAsy0M3Y9ChHuZ2lGQ7Ne2Mc3h9EIj0KK8+ZkRsqS/RN+MSGNw/Wo279xDMWRPKQnXZxdciK1U/1foTLGNI5Jz1sc8l5X9siMIUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDD1fCTe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25d44908648so10930165ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757685826; x=1758290626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1QxBTlE7wBHAWIKlSIVw+tKYZtGp4FqMWgYg6ZMy6M=;
        b=FDD1fCTe0boeNQMn0OkkSqRGKuFiBhKfXtBambUo4DvrRts4OvHU9pCRWOEzjhcStI
         xbmOOPlNyw71Fk/BnXI4mE2k5GtA/1e2qYfWWWLFU9QUhi7WdGlZtMEAhjXrSthCqBAI
         50U8AUTMJMeonlPSJyc+K6qfTBXcqwkYfbmKX0/ekdK7VrERh5R5ysvygHhmbBhNBEkE
         FBum+0t0IRmmMjzzx3volw4q2NhV/uTIogsKMJUATZ91D6sthep3kS94OjB0nkMuwWrE
         /vx7BE9rjZv2DXai6D28c9+20oqwAUxseecxziMeG2kKIDhqHDFptyyflDNBRALkkTND
         mDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685826; x=1758290626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1QxBTlE7wBHAWIKlSIVw+tKYZtGp4FqMWgYg6ZMy6M=;
        b=hHqMDPkLxBsnvxwJEesoyQdPNf7BM7toGSpz5IXFM3HQU7lQJcfT/BmjgvkyZtQ3dJ
         Y7KL2UQv/x3ygMNfTDTF3GeuKM4o/EtZLqtSFxjzLtKS6TSIMPGttgZguAox0CoYoDJd
         dm6AC9/9kZha9YZIGfHOrRUPlR8yo4CtR2kQn+TVlbSVdPm4z5E4PuwJjSjLPhrDbXUX
         Sex5DCVCBBPv4/lkR5FfMTVBum0tBmDX91C4aO4vgE+m9RtWYhrAb5eyFjZpGTApCjMR
         tb0utpjJELsbBNijxsxnpA7NnsQAhBdMwjXJM+X3Ff8M5eoozH5xukCUAQQRfLNmQyCh
         +mqw==
X-Forwarded-Encrypted: i=1; AJvYcCUYlG7e4lRBTOBWVB1C50Q2z4TIxBRXSNIVSYlc5xMwwSN81sMBtI+Zf+OIsK52U0Pyzvurl0UTfxis3mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmp5BDR55CpJGgjhHQeVe1sYc+7rdEhbC36+rYc6PAmKG+21r
	zdk1/yNigJwU/q7D5pz38i+m5ttGxD9uxfojVUPlXrct+YiRL3zW/jCt
X-Gm-Gg: ASbGncvu4qOkb4wuQ0PSXKHSj9DciWdbVE6WmQ9pGOUzcIERSUJPzPZvEW/DbVIvAdf
	cXDNWJifrRvpWoGkq1LRHD/TgNXbCnNwdXqTexWmjCB7YAqxn30IOXy+b9wLdGTNhFHsc9vE2q5
	UmmeheUFFh62sHhUjxjxAzJNUlTXfAZKuUHSbuvcarbE4CUBD8l7hs8PehoE1lX+QINo2myn2cn
	fMpjeP+kIX/FJFCJ/wZLm1pPA+2UaxZxrfNhrLUvaLhym8gHSA2sl4UepOJJoZyGpLH+qoxuQ4p
	4lfVQZZAmQqDOLQyt7kh11ItZ9eUQsVzZ5VjRuI0Ggn0W4Wq5nMd1Z25Dgc2hxQI+lO8UdRNoYr
	mHQWuWxwaWYtvXUjADRPJ4+vP+BdKBlklkz0bkGJ1eqPEeT1P7ayEvYZ6BAIgdllsg0+cHHjRU3
	9CLa0=
X-Google-Smtp-Source: AGHT+IG5X1Gan6zjQjJMTNF/rCRnIvsPNEFCkkjRGBaWPrcJK0WciPjQY9PjPdMsK2clZM3/U1Sepg==
X-Received: by 2002:a17:902:ccca:b0:25d:f26d:3b9e with SMTP id d9443c01a7336-25df26d3c13mr21633615ad.11.1757685825575;
        Fri, 12 Sep 2025 07:03:45 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293d12sm49743615ad.39.2025.09.12.07.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:03:45 -0700 (PDT)
Message-ID: <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
Date: Fri, 12 Sep 2025 23:03:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250912130420.6c14dbbd@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 13:04:20 +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 12 Sep 2025 19:15:44 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> [-CC: rust people and list]
>>
>> OK, Looks like I have to bite.
>>
>> On Wed, 10 Sep 2025 15:33:34 +0200, Mauro Carvalho Chehab wrote:
>> [...]
>>
>>> The current approach of using LaTeX for PDF is dirty:
>>>
>>> - Sphinx can't produce a LaTeX file from the Kernel trees without
>>>   hundreds of warnings;
>>> - latexmk hides some of them, but even it just one warning is reported,
>>>   the return status is not zero.  
>>
>> This sounds interesting to me.
>> As far I remember, I have never seen such strange results of latexmk
>> under build envs where all the necessary packages are properly installed.
> 
> I saw it here on multiple distros including Fedora (which is the one
> I use on my desktop). Media jenkins CI running on Debian always suffered
> from such issues, up to the point I started ignoring pdf build results.
> 

So please provide exact steps for me to see such errors.

I don't have any issues after strictly following the suggestions from
sphinx-pre-install under Fedora.

I even invoked [...]/output/latex/Makefile manually after running
"make latexdocs" by:

  - cd [...]/output/latex/
  - make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape" -j6 -O all

, and all the PDFs were built without any issues.

Quite puzzling ...

Or does your Fedora have some Noto CJK variable fonts installed?

Hmm ...

Thanks,
Akira


