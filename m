Return-Path: <linux-kernel+bounces-848730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03DBCE721
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899E419A29B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE030171B;
	Fri, 10 Oct 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGqpZBGG"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8C2EFD90
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126832; cv=none; b=pJIJXMJTo/wkjM0oEtWPGOx4d06ZmpZqM3SbX1oEKU7lvDFX74aG6NivLwvSkV2EjJUljlBbdsyCDm998tgX8QppIv+QmqR34MA1SARjoIuo/70ELDqVvHoPwLY5Tp+FZ+p1e7HhufA+SWsg3f+6Y8UINS+SN28v3uixICGivx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126832; c=relaxed/simple;
	bh=qJNQginXw33OCL6otz/mio9dtPI95vuO0c28D6VMtAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5tIyrX/MHbSJQHMUg8DgRupWEs7Eckzj5aSpFqwwUc6ohY/oHXesQ448SK50PXo3XS5eoQZX4mwPi2K3UkxZU18DDqu24XtvKGV+U74ZcWcig3UhDtMP02M9ivwbmIij5iDYlFGMGpd6hyO1/IUxI7IT96WN+VBtg8FgLoUX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGqpZBGG; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93607aec358so46992139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760126830; x=1760731630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C9TGYFUXxVemAwR89Ulh9sGzSp7qA+8XlrADAfHgVc=;
        b=DGqpZBGGjcYvuhn3d1qtBAPuwV6HidoG/f9LxCAAAM2hziVAae/CJyC0oigmkXLzvv
         Ga93rLuSxyVYcz+j0LAzOKF7KT8i792q8WG9oCm5pY5IIhe0RU9bzaDIWhdtWGQyABwn
         RA3hdEC1ygms6StQIxlZy+OsIfJnfgZPhRi+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126830; x=1760731630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C9TGYFUXxVemAwR89Ulh9sGzSp7qA+8XlrADAfHgVc=;
        b=LdcZ0/WnfZGcMHyH8gVhUiYVf5gRMX1O325LkuEvaELBs2HlGjLDUhAyX31QPPzq48
         GuFK3Mk8JITzQQwdY0Op500QUwCj0CMKkdkM9mX6o9h8XT8AS2Ys2a3b9VRaBVnNFHux
         ViUJcMaRX3QO1tL9C/eVDvIU7q/zeaLbQTPXyxlhvQpg9f9y52Z+NOgdT1AldHQcCzyy
         ZHw1facDA2hqLlD7UQemJF1bUKpFJzEd8VnPoJihP1fKTTPva6cuGJPSb6yUdyniULg9
         bBww8jWmaHGFWTnv2jiR6vWxiffFmia3eyJ1yLuQPiA83X9A+eCHYI1gLBPPzmFzHx7t
         G8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVD9Jg+3/u4q8eUh+UZut9jbzFencs9UOwKeNEHii8N4fc1WONmD+tuqjKjawAAkbfu7+yPcEjPS1mbK8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eRW8i6Ns415lFnFO8WFkJV/tKq+kdIBdhWmu1e+gKfR2TTfn
	Bb94EMmKHIF9rT5xIOrL4uI7ymm+YZDoYcVa7Sp1pniQRuytXG8JOt2xD1+gkhR1vGk=
X-Gm-Gg: ASbGncu2Hp+xOzLQFwlWQDXrMGQW3TPo64DrLEDTq/EfO4tVM31qyW5BVxb0rQjYMAP
	5The2qXxO4sRLYQS+3GqEnmt6E2NUtO+OFRVVeDZT8spIxxU8+OpX3Qik94C5IQDqCaNOKllkr0
	3Vh9X/W2ciPdCF3h7FrAYQ905dSTM/2+FUnEPidDLVSxqgG9x1yT1D9DO7AOz1x+QTXZTEyZayD
	aSEMPXDWvuEz3CORddLKgvsBqBXrhAzpE0gMitT5Dqm83OyYErIxf44+DEmMpqxcaOOihAUasuE
	I4X3h6dMNHv3oJjqXxcQbRXOcXHfA2ubXFu/foUihFgHFL27koV7wiOJf/bV2DhXhK3Cr6uTpWn
	t/nZ9ZSDQXrD4fb+PU7s5cJUpJNb2m+QQ1Qop7fcuHcCwZ5eiRgxT1A==
X-Google-Smtp-Source: AGHT+IF47OBorJnDZLxogs92bg9DbP41Re55bcWPxH2LtcWYwZh2W54OFZb8SOadJVjAyPp0dDz4Zg==
X-Received: by 2002:a05:6e02:2186:b0:42e:6e45:e0a3 with SMTP id e9e14a558f8ab-42f873544bfmr138691105ab.2.1760126829993;
        Fri, 10 Oct 2025 13:07:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9036cee5sm23494755ab.32.2025.10.10.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:07:09 -0700 (PDT)
Message-ID: <75584276-6d30-4e35-9e59-e084c60d1c5f@linuxfoundation.org>
Date: Fri, 10 Oct 2025 14:07:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under
 label
To: hannes@cmpxchg.org, nphamcs@gmail.com
Cc: nathan@kernel.org, shuah@kernel.org, morbo@google.com,
 justinstitt@google.com, nick.desaulniers+lkml@gmail.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, david.hunter.linux@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sidharth Seela <sidharthseela@gmail.com>, SeongJae Park <sj@kernel.org>
References: <20250929172724.75108-1-sj@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250929172724.75108-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 11:27, SeongJae Park wrote:
> On Mon, 29 Sep 2025 17:24:06 +0530 Sidharth Seela <sidharthseela@gmail.com> wrote:
> 
>> Fix warning caused from declaration under a case label. The proper way
>> is to declare variable at the beginning of the function. The warning
>> came from running clang using LLVM=1; and is as follows:
>> --
>> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>>    260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>>        |
>>
>> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 

Johannes and Nhat,

Assuming this will go through cachestat tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Let me know if you would like me to take this through my tree.

thanks,
-- Shuah

