Return-Path: <linux-kernel+bounces-827027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C137B8FEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601B87AF6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FC296BAA;
	Mon, 22 Sep 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAxl2Xr9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D0284892
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535689; cv=none; b=qW8rsMu1P0SLJnWxtw3cx0jlePor8Ig2KNoEjHzunfbWKG7FktqkjLV99ot6xEidXg5hZ4ubkzmR8y7AAMBcHmpi+DkUfOOjAEBgDqtUHMCrH2vntDfuREJ/nNQkLHwHf5y4MYJ9oDMjFosJoAe1SyBIl+phvBFK8TW8HBTcez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535689; c=relaxed/simple;
	bh=cAm0eq9eyT2eOSLB4XhXJiMkXGKd3+SiNlAldUH4zsw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=inTAYMae8diHasaumcKHpa8xvK9bLgtjwCNS1jBBFi0vBN8k/UgKw3RcLB1dAhhfIQYBhbJbunto8R3tqUOeIqTG8hj9KDb1VNAX7krs37RS2ki/yq1lkNTX3OEjwU4eoEshFh9D+/b+zUEWKGbFSkvQXAaGSRIeQ2IrLiBTBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAxl2Xr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758535686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAm0eq9eyT2eOSLB4XhXJiMkXGKd3+SiNlAldUH4zsw=;
	b=AAxl2Xr96Rle6TfDoE/98J7BpSPKo2BsRiycxtbLS2DQrtn5/AzZZKtxSqVeZfeOBhuqIQ
	uPhJTN+5kxrMVR14cr64QZoOgxgHm8caSfh+2fU8o25FXj+MxUvC3/GJ1vCnYlfQ6D3hTf
	t1/cWJNeeBXOQWBzl2t7bKCSttBoRYo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-LfgFi1OQPUCBGsEZEoSkMA-1; Mon, 22 Sep 2025 06:07:59 -0400
X-MC-Unique: LfgFi1OQPUCBGsEZEoSkMA-1
X-Mimecast-MFC-AGG-ID: LfgFi1OQPUCBGsEZEoSkMA_1758535678
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb78d5c35so623637666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535678; x=1759140478;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cAm0eq9eyT2eOSLB4XhXJiMkXGKd3+SiNlAldUH4zsw=;
        b=RdoeoCCPfYb1yjTC91GLaCkxlmB3QodZsE0tWtYRD2e4HNQ8pEqj8kW8/UBlclLxFk
         l3+JDD+UCvft/WlKgXf04mPYIDzd5JKXW2u/rFqIHftZGR1CjUzy3CB+uMNtILSi/sZr
         TqEiYLD2ZfFrZ/YS22DfJFLznYmQn7GyLjvi6NyoVFkG1eVebSMtO7w444L21YGeWeac
         vwq1bXGyAScLMs1VM+FjtQqOrM1a5qPxh2X95EL6iQqRJddp+X7rRW9yiXxv52l7Rpok
         Tgi167Xd6LJfoUbFlPHvXbVuvf5ZOBKaIFnM0SodMwCHjurm7BLp/j9OvQRh+EBB0aq9
         zegQ==
X-Gm-Message-State: AOJu0YxFgsi9HdvGanTOplYnoh7jvchY5x/SUsd4zqLHuCtLKLbZyqjN
	FGKkAwqknKNPqLzpsCq0QtqNfFZsR5XUr7zn1T5lLoGM0GBUdXb2xUq4SKPcIfG00TJe59t76Jt
	NCyUOwqA74re+pJQCloZdFnuO1KbW39FvDrw6j9rkw5SgC5bI/RzdeKpfa7Uk1AyggY9e6Mcscv
	bw
X-Gm-Gg: ASbGncuiaGU4LxOzfAdX/UE8CH5OlBZLIrbCiWMA5iHdCYummuyaxgo5Qain40hL+o7
	RPdFLTwvbSAX8vcX6JNApoXHkkvqdbhzangS+2Y3BtZ/PeAHP0J/WsDb1LT8xdpYWZnMQlSYBpm
	pRm+VQIj9y5U+PeonrWA2T3crRwukDvJBQRyNaCcZv5eqXwoyamz2wGlqf4G5XwtutA0PTwrlL7
	3dc7h/gW+bWAF2DOSdz6auqrtOrWWyyCPo6jgW7ANERURpAWwoF1TtTaEUJvu1ADzWzBwMeNUYN
	34AKcLAC5Ec6nZMSp0c2LSakTODdBKMYWp18
X-Received: by 2002:a17:907:6d1b:b0:b08:85d0:3d8b with SMTP id a640c23a62f3a-b24ee9ddcb0mr1168674266b.21.1758535677734;
        Mon, 22 Sep 2025 03:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoIC/YkwVgRoaCG08LeD3p4X9qVxXrh4nkjU74ky1A/nAbq67Jc1y5S1AaHkf25q4kCkAO/Q==
X-Received: by 2002:a17:907:6d1b:b0:b08:85d0:3d8b with SMTP id a640c23a62f3a-b24ee9ddcb0mr1168670866b.21.1758535677241;
        Mon, 22 Sep 2025 03:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b293fa07816sm473940166b.50.2025.09.22.03.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:07:56 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:07:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Message-ID: <e4035ff8-729e-4fc7-b40a-0775dada8811@redhat.com>
In-Reply-To: <aM1vcBuOSh8OV7mN@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com> <20250915145920.140180-19-gmonaco@redhat.com> <aMg5EzmxG3hG7aJK@yury> <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com> <aMhcYCCJDFWoxcyw@yury> <aMlJqDjWNyak07LX@localhost.localdomain> <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com> <aMqdzQcwvkjl5WNA@yury> <1d15af4ab9f8f63dafbf4810a76eb3d547217596.camel@redhat.com> <aMqq6zr7_dJveu3o@yury> <aM1vcBuOSh8OV7mN@yury>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e4035ff8-729e-4fc7-b40a-0775dada8811@redhat.com>

2025-09-19T14:58:18Z Yury Norov <yury.norov@gmail.com>:

>> When you create a non-initialized variable on stack, compiler does
>> nothing about it, except for adjusting an argument to brk() emitted in
>> the function prologue.
>>
>> In this case, non-initialized struct cpumask is already on stack, and
>> switching from
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpumask mask[1];
>>
>> to
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpumask mask[1] =3D {}=
;
>>
>> is really a no-op.
>
> Alright... The above is correct for optimization levels > 0.
> With -O0, 2nd version really makes GCC to initialize the array.
>
> https://godbolt.org/z/e1zG4K7M8
>
> This is not relevant for the kernel because -O2 is our default
> optimization level (I'm not even sure that -O0 is buildable).
> But you may want to mention that in commit message.

Thanks for testing that!

Makes totally sense. Although if it's something really unreachable in the k=
ernel it may not make too much sense to mention in the commit message.
Also I'm not planning on sending another version after V13 [1], so we may l=
et it slide.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20250917161958.178925-1-gmonaco@redhat.c=
om


