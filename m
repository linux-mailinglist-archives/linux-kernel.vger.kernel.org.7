Return-Path: <linux-kernel+bounces-808387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EBB4FF22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841863B8E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5934167C;
	Tue,  9 Sep 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZSLIy9Z"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549C2EDD52
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427413; cv=none; b=Z8XqAp22VvmpT87WR6qfjmp/BoB/nLmj/z1t84rCGTfnWKL0/Tgilmr3mbZr453vD5r9SfsK4Rv37QPHSSG9vWZuwdPOjmizTgk/CaNT6vLjVgX63ofeLdtMAukwOX1fOdiaGj7KSlPDKIcfhDD8eNDqfVJuPQeDj8/wpQYKaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427413; c=relaxed/simple;
	bh=o+VqiFi1ZuJKXK/R+K8Ffj0lVMmVJnNeQeEd17w/NPI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MipHS0eMZPB7O5VHlM/1fOzfg+K8Sz/+zcff8cyHA8P8zR4VjBe+U6Nc317R+McYqvtqTN2r46kNW5g1Sa59BnNGyQHFhlcIr1FqccYtxm9RWP5hv41hBMJ1/YTce/pu+sXOtkIvVUv5O4w9ucpYcGyjHzdnTGbMTkZitc8dOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZSLIy9Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2518a38e7e4so35307055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757427411; x=1758032211; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBPCbx1t1DtRFy/Qmvoz+7PpnPwODyvsfSiVPNyKvTQ=;
        b=ZZSLIy9ZcrR8UT488nV34k2lWSG2XAWhYoWMBQ4umwLUfSGZZoHPb0Oql7o0PRb/MR
         lwTexgiJSbpJS3Bi+PlPJExiAAE5Z3HkoL9a49cXFLDy6JUp3LWUO45u63f15jtNuIFH
         azKEZ6giBniPrJ4x7mHARtkx/+bIcfdITJ++YOp7tcd0SHExTKaX2l4hU0RXzu+32YJ3
         4hNc45fQHxqqsrCH3FZAsodArEXEVDw3ct3do9jjhYyoDrQXPJZXKFB1FmxnGx+mtlps
         w9llkZ4CXVDLLh/1Mpxbaua/joOmEg0rQ0ucXdmSd309sGTvFR+rGVmKmMEBkesATcdZ
         F/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427411; x=1758032211;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBPCbx1t1DtRFy/Qmvoz+7PpnPwODyvsfSiVPNyKvTQ=;
        b=lpaySn6ooZRv7Es5BkZ+XStiSemUkNkP4N0xARDBBxXSAqnEk0ILLwgbw3HCNcGo5U
         EJHQoePF3Mo1/ECy3AGLazDbaiikP2elhXN2NI0NelcJZ3CtZMZd+EmYcoxVUFOMMNH7
         cQKrD75jF3OHYeBNxBmB/ushYSyd9SvCpcE0s6J2ad1cq8VrhqsK34tWYx9t64O1oaat
         KyK8Uu8GgZSD8osDhs1H1rxTRxMs386mWlc+531hjYNvA5IoKi+rKJ/YGzXASqinL3HU
         o4vjeoqXnbmO8kM3VVfLXfKJaI8rAhsxLWHCH99mEkDmB/CgNmsVz20powUoJg5v3wlx
         pKGg==
X-Forwarded-Encrypted: i=1; AJvYcCUIxNB1nS3rxjC4EoeKeHIdxWu2o7TusYkaq0jmWNiXp17Lex5RvqHHheh6rUr0A0JzOKQArfaJg3uelQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHJZs+CkPWNp/I+Ll6telTQZPQga6tAZap9AZ6gOV1VUs74Gt
	F7WKWQjqRvA7j05ZEjf0aJ7G5tF0xVCCjxoKQBNkh/zsEGxoCBKAobFk
X-Gm-Gg: ASbGncteZo/aC1ItVWQcIaA/ahaKWZ6dOyqH2g/XZzjo3qYqp1JrQZERiKdvpSMq+8Y
	3JWWPPF8vaiMzb5Zwz9ASRRrZe0Q53aNZpf3sTmqLQeQ9N892jKjoxBR+hT64KNkBKf7bbQHWmb
	tEsR84D4PgMmzJZCsguyIDjUxGdwEz5PlDC/7syrWy6Pdm/CXzfRoiG6mXpOyzpAZzmWVQ3AQA/
	CdCIJbm/RYf4zRIUSYejdMT9pH9kr9TjNfvKfyLLNo6D+PWSOuTwQPZCVLaEJYYNWMmEPYQy4K+
	9VIxi9kXHDZbF279l4RuDRVexBFKnjKYE5C8R8wdhRG7VanxtYWnaaHLixvzcJeUD9rX37lmIgh
	a/I2krxQkSBAciZQKNTgSaOkb7Uc8k4BCohrqDNYIIUobXmZCd7Q=
X-Google-Smtp-Source: AGHT+IEnAyzLMxqnxsLrvjbSykcpJDqbEB5tk3wlxNjto04xhv0xpGQJTdUpv/FS+YKjD89GTMMNpQ==
X-Received: by 2002:a17:902:f70f:b0:24d:34:b9e7 with SMTP id d9443c01a7336-24d0034be6cmr205718095ad.29.1757427410945;
        Tue, 09 Sep 2025 07:16:50 -0700 (PDT)
Received: from smtpclient.apple ([39.144.103.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9c2b12f9sm171757705ad.101.2025.09.09.07.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:16:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
From: Vernon Yang <vernon2gm@gmail.com>
In-Reply-To: <20250908162220.480d7014cc6c6ad2e14748c5@linux-foundation.org>
Date: Tue, 9 Sep 2025 22:16:34 +0800
Cc: Vernon Yang <vernon2gm@gmail.com>,
 hughd@google.com,
 baolin.wang@linux.alibaba.com,
 da.gomez@samsung.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <441CA7B5-4D1C-4334-AC1A-2CDA87530478@gmail.com>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
 <20250908162220.480d7014cc6c6ad2e14748c5@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3826.700.81)



> On Sep 9, 2025, at 07:22, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Mon,  8 Sep 2025 20:31:28 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:
> 
>> From: Vernon Yang <yanglincheng@kylinos.cn>
>> 
>> When the system memory is sufficient, allocating memory is always
>> successful, but when tmpfs size is low (e.g. 1MB), it falls back
>> directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
>> will not be tried.
>> 
>> Therefore add check whether the remaining space of tmpfs is sufficient
>> for allocation. If there is too little space left, try smaller large
>> folio.
> 
> Thanks.
> 
> What are the effects of this change?  I'm assuming it's an
> *improvement*, rather than a fix for some misbehavior?
> 

When we use tmpfs and the tmpfs space is getting smaller and smaller 
(e.g. less than 2MB), it can still allocate 8KB~1MB large folio.

Thank you for your feedback.

