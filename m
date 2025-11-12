Return-Path: <linux-kernel+bounces-896655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E87C50E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C73BBB88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA432BDC15;
	Wed, 12 Nov 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgH8q1jr"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FA28643C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931652; cv=none; b=a+9wJfS7pM7XJbhWFiRmqkeVenXCFN0hFpH20fyRt5hFGp0fCOElGl7bv5yMQBonMXAyCebAB0W901EQH2GJjNw6//OYxtCdReXhdVNz7rg4EH4zv5ZhHn6Sks9NJ+kAcEQbRr6UQ4B8ErJLvRqzGYWfg6ESfWpWtYS/PLMQOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931652; c=relaxed/simple;
	bh=cUgCmt7/S4H78nSegwnrwPgzDrfISuJQ8hnVSCrlVDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0PajoTe2n7/+0Rv87IVq1sYUeG/SFKkc9MnGiSrv6NqWOl1Mu/ojlM5B0S2bgHCNgxaard+In+BcCnTBDa2w2yzYAzt7WA9uqeUHTMUe9EKiqChWH88YyDG4p07+kaLSXfop9KHTwTyAt+Bq8vtNHYNS2K3Fcj3MMId1uds1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgH8q1jr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ade456b6abso432853b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762931650; x=1763536450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=XgH8q1jr2+XQgLkfDKCa/eUWE1ZvSrkjRxtr5lBbLGxRYdtzxNaRzJKM50Ux2SEHOn
         0BlAjFIYdWeA6qeOVyyZmDrK6k4OKLxGTQYKjGI7qHlLKCwbVIW0OFzrgEv4v5ewBziv
         lv4ohKUGv7dG6To2zsCiMcMO+Ruuo3xwZdTgTqKyLYSvet1wbq7QLkzDOvfx78zFlOw+
         MR3w5gfbC9TLFm1qlc0UjFCOBC78Zar1o6Tx335kme/yEGz0nsP3JeYSRpYmnGxuxOuv
         z5Wpi3dE0zdK4SoBYUa7rWSOkPUcOAf6XQY3Au3eII4YW4J+vud6XV4zDnR1hSYZ39Yj
         SQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931650; x=1763536450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=xDG8jtRIIP3q8WIo6t3BvWaw8hyFqaesApSzVmvRy9MmcsHC23EY9rZ56W5w+E3R5V
         oAev4LjNumP+wgXLUy63EHna8VTylH7E60XaMIlFFVpYUdpXxmOTIxF0v8zpwzIqIpVR
         5K0ZzMPLScgasuNrvnedhlZGeVLsx+WbLw0W812c9zkvAPCZfTVm+3X9SBlS5cwcgen2
         PIVR6ueMW19OXKVDYVbkWjJ8jqst/s4ixIySqHKYO/p4Ni5wukE0cFxodEq3UQ8EkEk9
         sMtrL1TRamj35tqn5aF9W91lPplqJX/lEWKm2FxiTovJgn6BHTm8lZgs5iF1SSaqL45Z
         NCmw==
X-Forwarded-Encrypted: i=1; AJvYcCUn6CqOsK4kcXPI5lYGNBEil4P1mNMMguffehcJmd3oK+Va7pQoxLn8lfLrrdtQo8CKLNS5moallDko5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfHnw0SmnDtXS+7kG06IuhmWaNgpbdesJfWSycKADCFzi9cCl
	Q0SlnIIbGceChZrlRqcLXLYMO7Ef6yGKL7oLQJN8O/wtc/QhLJIHjbGX
X-Gm-Gg: ASbGnctSHYlwX+fLQTRoMIbiPVMoREPVWxBhcgoNTiB3+R1oUtVwUSzbmZKxHMDetAK
	YbUOWqzyhGpZ83DqIEfmzSa0cTN2B2Ep3urQwNWwiwg0LbFyngV0JOgEb4/UkVXe5WMCaGVovft
	kCVTSf+snaYB1O+GMvw1+autpWigcgtmZOOhW/JosmFVDkE2UKxNs+pqL3JAVlpSslk5uwOHnd0
	LQoDVawWJ5cS41okI3YCsNmBX2qR4iqh6C4Hs1u2iNeTJ06pj3XbvDO/wKTODBKL1oQvjyiKqMv
	APZmYHZrXXqlePlHrUoaPSJ5jJsPITyON2yJG1tX81Lh/u1NovwsJV35YfrrcP00SdSSMoD8lAY
	7MNv1ObeCskJvLGQgWX344eq0UovsgB4d0Vam9HMUAhPYLlunBrlrHsOaFvEs5AnVBVXEHThFRH
	VyJYWw5jGnFVr9x5px
X-Google-Smtp-Source: AGHT+IFxIDHbMDQtJnDd1j29er8I9W16ktyYHaqy/e9kdgu1LMq6asMSVrMWec36NOc6lpyOhk0v6w==
X-Received: by 2002:a17:903:3d0b:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2984edde5demr21733055ad.52.1762931650013;
        Tue, 11 Nov 2025 23:14:10 -0800 (PST)
Received: from [9.109.246.38] ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca027esm19947645ad.70.2025.11.11.23.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 23:14:09 -0800 (PST)
Message-ID: <c91c87ab-dd85-4c42-9af4-a25ea2540de3@gmail.com>
Date: Wed, 12 Nov 2025 12:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <7f7163d79dc89ae8c8d1157ce969b369acbcfb5d.camel@gmail.com>
 <20251110135932.GA11277@lst.de>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251110135932.GA11277@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/25 19:29, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 07:08:05PM +0530, Nirjhar Roy (IBM) wrote:
>> Minor: Let us say that an user opens a file in O_DIRECT in an atomic
>> write enabled device(requiring stable writes), we get this warning
>> once. Now the same/different user/application opens another file
>> with O_DIRECT in the same atomic write enabled device and expects
>> atomic write to be enabled - but it will not be enabled (since the
>> kernel has falled back to the uncached buffered write path)
>> without any warning message. Won't that be a bit confusing for the
>> user (of course unless the user is totally aware of the kernel's exact
>> behavior)?
> The kernel with this patch should reject IOCB_ATOMIC writes because
> the FMODE_CAN_ATOMIC_WRITE is not set when we need to fallback.
Okay, makes sense.
>
> But anyway, based on the feedback in this thread I plan to revisit the
> approach so that the I/O issuer can declare I/O stable (initially just
> for buffered I/O, but things like nvmet and nfsd might be able to
> guarantee that for direct I/O as well), and then bounce buffer in lower
> layers.  This should then also support parallel writes, async I/O and
> atomic writes.

Okay.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


