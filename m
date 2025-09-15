Return-Path: <linux-kernel+bounces-817643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D401B584D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9551A28324
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4872C11ED;
	Mon, 15 Sep 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMOY0bfX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D423ABA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961776; cv=none; b=I23WW4RlvF50oOCBewxOrmGY4Q4VxMxUP1kY4X083pcXtuhoaCsaIZSG6eYIjN5/HXRwZVt6vgzyOcfooC19aJ1eNyy6WbsF2CQWxQ4Uf/w87pJEBEzeVf8LhStnJtiOvrx7ymvqmUYtQ0j0K2rijnZbCqvOD0BmBUnGET9/CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961776; c=relaxed/simple;
	bh=ssLXklQa2sv4me1/Pc3Ed3Wkuo9uZMnk7M50G7qvATw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DFT414t2mQOugGGRc3wPmnRWk6yvq7K1aa3oGMXBJZvQoNTuJBtk1nRew/awRGEHzviOBHpUgioUy9x5K9ou6IzTeFPrhr6IIrI43LnOmu1gfo89C0uzYee0fNpa5xfyRTxupUKigKBB9UnG8ZI1fIQA2epHAaiMqncVhiG4Xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMOY0bfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJQiuuXM1OJgX/OTMX2LaubLVboY/ge/7we+Q6Xewa8=;
	b=BMOY0bfXAL1HZzHKvHRbCW9jLVRukBifrhTNJi+XS3Z5eF7i7SJNFroG8FuT1mqy0UkwU2
	APQkKnzhJz2OxB134iGsbRgqL05v/yDLk/QulWrvNxHzw3UJ6NLzlzA2FV3AEGItiKTFE+
	6z0BBDTh5qf+ckMKFCItxxnWDAYZBSQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-UrSbrblXNb6QALwZoKLYng-1; Mon, 15 Sep 2025 14:42:52 -0400
X-MC-Unique: UrSbrblXNb6QALwZoKLYng-1
X-Mimecast-MFC-AGG-ID: UrSbrblXNb6QALwZoKLYng_1757961772
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8286b42f46bso470656585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961772; x=1758566572;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJQiuuXM1OJgX/OTMX2LaubLVboY/ge/7we+Q6Xewa8=;
        b=m+T4jHL5Rn5PxmjCdVp31cb1GwSniWf7M25YC8OSAOvc8iWZgAQawCOnLByLLo8rhq
         87Owy+nB8bkprBrZz841K8XdZ+OJ7Pp5ksn8NYWjspXWgkisKdlKDZnEzbexKYGkiC5g
         dSEEP7Qpd5Jsc3NwDzscS76KtLJj2MIAMkO3es0BtXLXXdnZpjWrQBbAO7aop4Ae4R61
         t3jsdRWv1jyOeiaykVXFXJAqipudeLKacsemsHg0lJiqAlwoqpJc6LaH50Mi53GSqX8B
         onidtH5oHQ5dij08w42ISo95kogwjogMSp7XAXtrWRmI4J0jGNjGRjCrxAyfpConXDCA
         sXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD5YQwqSM4HeYL47EH0G7imG99yEGQBthWCYecwYlj5zicm6lJ8sqb/PYUf4INegBr8zk1e3gwgtJH2m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvd08b05rzVcJpj0dn9k3NNgGylm2XxN1mxw4XQmBnkniM7GPA
	uamkOxAGe1bIYuDeFhSECp62jx+wunE44gUHDue2Svs+ZaStgOP+Th4nv+vF6vUQn9Sil99POba
	F9h7j95uZUCXvsUZhlt2ZKk78F67k2cAQ5KYEm9nQ/gEdtPxa4lMq8dGjgoHZftYg6A==
X-Gm-Gg: ASbGnctr0xhiXYPFzvLVPqGFHCqN5rnq50vrheAAWv8RR7ndnMGCFX+7XesNY3IbAUU
	oAk76N4W0CqsGLsH0c4ptPG0MJRwvaeCP9QVwp8wfQBENuIosG6WKIfsYzddcc0MN4rEfuJc8ZY
	fulFnsLpPXXMtC7P5+JAmxaQDCfnWUSv/wbeTCMFstxafuSfMYYAqUNl3nWlrN7G4+LzhxAK4+n
	wEQboOIPLxP+vYTw5zk0ydOigofdJure0ISBEjKqMrG5m557MBLe9qmA4bSEoCSKLMq8QXIB0Pp
	ZSEgvUt/ZI8J++wPM5ZoP5CxAEJxyj4otY6zhBHjWkUNh5iSqdLKo5ABD9IbASaEE36IWNyJNLu
	+G1aEje4tiQ==
X-Received: by 2002:a05:620a:4626:b0:82a:fb2c:ae06 with SMTP id af79cd13be357-82afb2cb3abmr247631285a.1.1757961772144;
        Mon, 15 Sep 2025 11:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErSGDrCSZKUqkKtEwG0Zms+sT/vdQKZh07pc2eUIfZ6TUqInY9rvaVXqZeLtUlqPGmtBAGJA==
X-Received: by 2002:a05:620a:4626:b0:82a:fb2c:ae06 with SMTP id af79cd13be357-82afb2cb3abmr247628285a.1.1757961771666;
        Mon, 15 Sep 2025 11:42:51 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974cf21sm849092285a.22.2025.09.15.11.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:42:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7085a2a8-0f03-4222-9ba8-9281e25d8daf@redhat.com>
Date: Mon, 15 Sep 2025 14:42:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 06/11] cpuset: introduce cpus_excl_conflict
 and mems_excl_conflict helpers
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
> functions to improve code readability and maintainability. The exclusive
> conflict checking follows these rules:
>
> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>     not have any overlap.
> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>     must not intersect.

The term "non-exclusive" is somewhat confusing. I suppose you mean that 
the exclusive flag isn't set. However, exclusive flag is a cpuset v1 
only feature and cpus.exclusive is a v2 only feature. They will not 
coexist. You may need to update the wording.

After you fix that, you can add

Reveiwed-by: Waiman Long <longman@redhat.com>


