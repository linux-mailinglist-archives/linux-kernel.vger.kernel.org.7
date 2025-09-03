Return-Path: <linux-kernel+bounces-799534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D514AB42D43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211FA7C470E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4B26F463;
	Wed,  3 Sep 2025 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iz3y9e2Y"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425A1FDE01
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941404; cv=none; b=dV5GYgXhbgFmEIoR0pjfHN8u8XLHK9KUqsB0eFuS5c0MX1k9NUzQJ9LChUp6qP0oJWAMzreM+UmanOPCMiy8DbNDHJtLVroAAZ+4qJFZe7WGHyjyZUDZSq6jREoSl9/J6KGeoMRsDdyMVaDsQduxu4x9V90obIW5EIxrhT3x0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941404; c=relaxed/simple;
	bh=pFx7XWcGl6utlmWhzJGmvbSQZ1HAvh4p4+RjC+57UmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zmta+MQcy+sQfFD45TbQJY1eYYvGEUSov8VtU5CnEY9g1T7+fLj3+GbXRuvnzMIhm8Md6Q2zGaAnbOaJmOElXp+TSP0O+TSgqcRtSC+w7MNvWZtY8Db3FGxaoAbjE8areTki8JcgiV01Y+oUOnrJaEny+zejbnjBhrzUnokFTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iz3y9e2Y; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f2b6e0b93dso2624195ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756941401; x=1757546201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KPINxE8NLcsO2+XZfNzopULJzjAwBxz5WLUo/LdzEw=;
        b=iz3y9e2YJ31NRNmT80QNw49auXg1RvsfX5AA2b/ga940YLPxeC2HkQaa3bmixXbMFR
         JRDQyf0MdCz3y+yEJawQTOV015+mjJktxbat6hnUtxzFZ0O+TOMqp3Vs+LzO2HgTbCSU
         1F2ED5awlJx80sFZgEnYba5/22ZiIdJprZRxJ8cXURgN7xYKkUiyd46/xvwED0CJJ48P
         ZedaI4nrqlt4PtrsP/L8IfMmCV8ZBQLxeTI7VMpWwKFsP9NkT8fc7eoYzdC3T88BVTW/
         2NQzUvi3feRRBh24SIKgz3srUiluoxrzq5hEQdxX6+eV5/DP799GmBzoz1qNekL5RzpY
         fh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941401; x=1757546201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KPINxE8NLcsO2+XZfNzopULJzjAwBxz5WLUo/LdzEw=;
        b=NtNRAnmvZTz90WuDllWsPNkr1EtaieUd4gqXkUaMwkNRSk7Xx2ZWSHIj3kGmdmnOYb
         ZHJ89eVQP7W3iv5e5+R7LdW1WcWg+Eblr4HkZT7XUEvz4NqGHaz2kB8LEZ29tv2hGNHg
         erITjJXsqQNXO6zuWqO/7LxMezrwnDSlQ7IHoIelGD9WSry1QHkPt1AfnlAVpvIdHj8+
         qKy/om/nDOL8s7Ni/KYZb114JgHwbj5pi6Nf2qxQKm7ttVPeGVjoLzMIvpnTS7s6neR7
         8dQItcR0JdPdqjcklk8rHod++Dsx1e8bHTemQ6KKaAX7dnP3fQfPIoEJUwgozBFOQQb9
         ZTyA==
X-Forwarded-Encrypted: i=1; AJvYcCWpsZqXWdale4vuovxN8JdSJgKdw2MWcPnpyBOwhWSsT2PVpbhrYNGlC1FVfK+LSYoJz4YKf3xISGUgGaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfZ3NGUjVgRHjo3i1nb4hLWLFqvrUx1AlCgGnBbQqKIlM3TGT
	GQx7M7LFqIjLj7R7K7TZ97g3TVLl5TCS6ACc2rn+GoVbJCXzuQO9/SGxR4cFBWNrPMI=
X-Gm-Gg: ASbGncto9GMolewT06mbt48Yl0HeiKOSvxD6YSKiuFIdZPV/YqsOZde3+yiLwiN1AGd
	A7+Kg35DVSdNJuZuwdatajV81TtgL1OyvqL7gEuZWuYsBn24onlL4Y9Arv4c7B1YoOKOs8tM4Vt
	Rcfvd6430Bk+x1J/mXoF0IpnXZNDqZ8NdBLIXyHIgxKmLSXocgxHwej2QU47GGnZt+hKiXCYfAF
	jI2GGu9EAfVjRXrQCANcY6WNNR9jiO4C0ABxluWRGKcO0dBXR5OJpaQgm9fe+RmT2mIrbcYUeJM
	yd/pctt0VAC4R6yY5ACjh6oPOfreN1B7/zilMhTUzuC9WShscFNStaqX+x4xt5fJCZW0lKdmkoF
	itz06iIRR+ZrUXL/7cQ==
X-Google-Smtp-Source: AGHT+IG01+W9C+jp8uuJ6RhPj6TWC9qjYtGqfBKyHCxLVVNZ/WZUlprqA6pmAZkb2nBGyflgs6jh9g==
X-Received: by 2002:a05:6e02:1aa6:b0:3ed:a76d:bce1 with SMTP id e9e14a558f8ab-3f3ffcac8a0mr233316755ab.7.1756941401095;
        Wed, 03 Sep 2025 16:16:41 -0700 (PDT)
Received: from [172.20.0.68] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65c076d97sm18857345ab.19.2025.09.03.16.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 16:16:40 -0700 (PDT)
Message-ID: <51277999-41ec-45ad-a074-2352f46c882e@kernel.dk>
Date: Wed, 3 Sep 2025 17:16:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: remove WRITE_ONCE() in io_uring_create()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902215144.1925256-1-csander@purestorage.com>
 <28b5e071-70f2-4f46-86af-11879be0f2a4@kernel.dk>
 <CADUfDZrpJuq7QH47XTBvCFsENm88WQGX2YYnEPHat_UD6nLC=A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZrpJuq7QH47XTBvCFsENm88WQGX2YYnEPHat_UD6nLC=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/25 9:32 PM, Caleb Sander Mateos wrote:
> On Tue, Sep 2, 2025 at 6:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/2/25 3:51 PM, Caleb Sander Mateos wrote:
>>> There's no need to use WRITE_ONCE() to set ctx->submitter_task in
>>> io_uring_create() since no other thread can access the io_ring_ctx until
>>> a file descriptor is associated with it. So use a normal assignment
>>> instead of WRITE_ONCE().
>>
>> Would probably warrant a code comment to that effect, as just reading
>> the code would be slightly confusing after this.
> 
> Could you elaborate on why you find it confusing? I wouldn't expect to
> see WRITE_ONCE() or any other atomic operation used when initializing
> memory prior to it being made accessible from other threads. It looks
> like commit 8579538c89e3 ("io_uring/msg_ring: fix remote queue to
> disabled ring") added the WRITE_ONCE() both here and in
> io_register_enable_rings(). But it's only needed in
> io_register_enable_rings(), where the io_ring_ctx already has an
> associated file descriptor and may be accessed concurrently from
> multiple threads.

Just add simple comment saying something like "No need for a WRITE_ONCE()
here, as it's before the ring is visible/enabled". Otherwise I bet I'll
be fielding a patch for that in the future.

-- 
Jens Axboe


