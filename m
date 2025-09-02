Return-Path: <linux-kernel+bounces-797203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8241B40D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31035637EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64321E0B86;
	Tue,  2 Sep 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhd3hPwl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6D241667
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838835; cv=none; b=WVzeVwNCGt2VwPC0sSkqO3II2nP4ce+Vrn6UdVTbGiTCyQzHknR4vUEGeeAKByKi8/WyDYOyqFx5xVCEfU9iiDKz105xiT+2XEvGxzk2m1FKvdYzoO03u3koqzeFcrhsYrdCUy5dY/e48sSyc7mmvEY28EYsXxWXOjWrpcdRcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838835; c=relaxed/simple;
	bh=niHNVvGTbLrHGUofLzXOJQKNA7lJyWtdS3IisPCmbPE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mC/PxOKg/XB7maw9Xxnu0CbGGLE7XZiyQd7wQNT6ZTs/bGR5zfZQ7TA7/QH01YcXc5FWZ04I65MiDh/ImDHt22l5IT8gPttFVe0//N3jdD3+wsBcj1ouMB60WTor/Mv2/WbemyRSejYx0BacS0YCUy+fKXGLcqDDHi5wDv129ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhd3hPwl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756838832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5Iuf1X4+usrTx5fIL5N9qPxoTLIij37cao5pmfb98=;
	b=Nhd3hPwlhuCC5tpdmBPAsfPEA84rq+Uc4k4amSvjjZZzwtPLjQTXtvSDFuDsU2Zg99zpyE
	9DhDwlELWaCp6+/14wFnTnURVfzMhbILVTMuXPDHCUNu7/O+nmDuKx3e1GVYtG780nzahJ
	pl1dWvdf/ymT+FeAtR1Ngi/UU/D3bPg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-lzYcccE0NcmVDvPsw9B8sA-1; Tue, 02 Sep 2025 14:47:10 -0400
X-MC-Unique: lzYcccE0NcmVDvPsw9B8sA-1
X-Mimecast-MFC-AGG-ID: lzYcccE0NcmVDvPsw9B8sA_1756838830
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-720408622c3so17780736d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838830; x=1757443630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL5Iuf1X4+usrTx5fIL5N9qPxoTLIij37cao5pmfb98=;
        b=lrO4Bf+PRWvT7oHxOFSGnWvnKHI9sG9Z820zjqSJqgUDzZ+1BYAAqrkrrbPaeP5gV7
         ESWwl41j08pvDcqSwWFuP/aVwWJWIus9RMHIVDMOFJVx0elejm1gs0axZmTsj2alG1/K
         DU9bGeXRJqpIfJjBBAzlKcMV3ZC+dxvN8gnhgrnXifPvXRf7qBRj9Sov2TXU+7S0RcPx
         GMzCmoSM7PXw8o3Fhd66xQg5jNXKvhQpQlFQwAOA+fnuwOnkkq0PopBARd63AyBZYAM+
         asL9v0POTB3LoCz+pcfOfoiyFvrkb6H4QpcRadw9dTHXHNxHMLOW+RsrQguKCwrA6R4/
         4JgA==
X-Forwarded-Encrypted: i=1; AJvYcCWhKpkruugQxVNWfKT2tZ2YKrYcgAwlygO/Ooyws+EeDCVoYDOf++aIeCP+q88qswBluMhVcgaca76Wh0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0GK7FSsEY447SaEePyViL3lBr4OWRJvWKyPwmR9FNSX8MI8c
	RPb90uw+fp2lbpm7hOgv6Sa+T5ncPPdXch0nv/T/RAusI7yH54qyo9Va2qZqgfLSTlotD5bEgYn
	lcgFNJDn7wO2mDUbYz5lBZ9plU2ybfU5xXfagmOnFIePnvasttLBhrPXL1joGCShzAg==
X-Gm-Gg: ASbGncvp8R7J4aBEBNbNjqVVQbLmtQGoVX5SJrqY9oKejSl++J4cydKnvR0y5KPEyR/
	8tafMrM+yQreEeemsCxL6gt3OEDYkPNxqrSVntXoKGMpozfDssXWWQiy6cFBSFYpujNWK2dYetE
	hJnlUdMyUrfIWBCf6SOTvgD/XjEhpSlOs3mXf8b87P2cO1os8dGEOkpuX1xvWefehM+a04KrOdB
	HxEOxQSGRlT53/yodOCTxNMWNYvrW5A8wjg6YBPrpsslHqeZKs75B/4EkPAnEYCythluG9leC7L
	Ooak0iyfmKKx0q7Gdjmc9kYKxAS12mXzo6fsp6o+OV3M8J96tiXzrfAhofac2oGZO07KKWridIU
	iPYOFp/+ZMw==
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr129841766d6.61.1756838829445;
        Tue, 02 Sep 2025 11:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsXDCqrxLSsW18GhRFLcFTT86tc4vo6hE4zeQhE6MFMmYRH8/ZI2p1iYn7Y10qN43gJ30zqg==
X-Received: by 2002:a05:6214:21cb:b0:70f:a719:5666 with SMTP id 6a1803df08f44-70fac92194bmr129841426d6.61.1756838828872;
        Tue, 02 Sep 2025 11:47:08 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add668bdsm15895626d6.33.2025.09.02.11.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:47:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <530b6d8f-8987-4fd7-9add-eed0a823b411@redhat.com>
Date: Tue, 2 Sep 2025 14:47:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Cgroups <cgroups@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 kamalesh.babulal@oracle.com
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
 <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
 <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+G9fYvA=945et87Q=_c6b-TWjSBxy4H-X9iNsb1_Pj9GCXUaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/2/25 6:58 AM, Naresh Kamboju wrote:
> On Tue, 26 Aug 2025 at 19:56, Michal Koutný <mkoutny@suse.com> wrote:
>> Hi.
>>
>> On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>> Regressions noticed intermittently on AmpereOne while running selftest
>>> cgroup testing
>>> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>>>
>>> Regression Analysis:
>>> - New regression? Yes
>>> - Reproducibility? Intermittent
>>>
>>> First seen on the next-20250722 and after next-20250805.
>> Naresh, can you determine also the last good revision? That would be
>> ideal to have some endpoints for bisection. (To look for any interacting
>> changes that Waiman was getting at.)
> Michal,
> Since this was an intermittent issue, I do not have a good end point
> of the bisection.
>
> As I repeat,
> First seen on the next-20250722 and after next-20250805
> and not seen after this.

If this problem hasn't been seen again after next-20250805, it is 
probably caused by a bug in one of the new commits that has since been 
fixed. We are not going to look further into this until it is reproduced 
again.

Cheers,
Longman


