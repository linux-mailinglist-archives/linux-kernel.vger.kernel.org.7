Return-Path: <linux-kernel+bounces-790563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F488B3AA41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CB814E05A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDA278761;
	Thu, 28 Aug 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOVqyIev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC542BAF9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406885; cv=none; b=Rf9vB4GJ89rClH7W59kUdX6CUvV265RJjNu7g88y7rwTVdrSSduxiBfiFvGzxiABnEMrcOk0r8wm6OhpFHgg0E2BYMonivtq/nDShhP8RkRQ0kwc0Tuphx+LA7qdINF9VX6NEt2aay6hLzrkQETJE1hmla1WfFC5Nwofd8kwHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406885; c=relaxed/simple;
	bh=7rLqUiYyTfGf1T2lXhdc3ofCIgiLuEcG1HR+EKwtaaE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f8vDR63jZQkMj4UfH6hdiFRaVzTTsbGceV+ev+JIfd+8LkI5BDa1VD1aKwRkktV6lyMLCArPjvgj3I19rOrEfv7rxhrbSJmQiO8H9EuGdNjuYx/fnbkTzmKlKBOrDwSBW+V1MZ/ogu86bSP37A00shukqsWmNaeN9zdszTQRX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOVqyIev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756406882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rLqUiYyTfGf1T2lXhdc3ofCIgiLuEcG1HR+EKwtaaE=;
	b=eOVqyIevG1SLJelOI4IhHsHtiKinVT0uzDtm2dDg0L/ksBFnSRiQ+2Jf7pdutxXpBeKGFP
	zbxnUSUMJbIrdfsl1di8pcOeNfY24Zl7b8P3yR/H+0zVe7wpRHZ3cBGTi3YRlIjuP6jcDK
	M3CtsvWuhBiOmIxZ/NCrCIR7bFmS/Ak=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-pqIu9vHAMvqun1-3-psXSg-1; Thu, 28 Aug 2025 14:48:00 -0400
X-MC-Unique: pqIu9vHAMvqun1-3-psXSg-1
X-Mimecast-MFC-AGG-ID: pqIu9vHAMvqun1-3-psXSg_1756406879
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e950984545fso1513720276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406879; x=1757011679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLqUiYyTfGf1T2lXhdc3ofCIgiLuEcG1HR+EKwtaaE=;
        b=QICad5lCjjHSuP5H34d6MjpIJ+TPd3zUrc53EGi9zmUYNE3AmnfmgpqFszbaT/6Xc8
         6uP8q8xm40F8rE2HFhz4qknlQw+t7FEhTEtnxWsQm8GpBYSu3fm8ykL714tRKpMu9u75
         UdR7lnRp3tbuwDmzu06zMzPoSDk+qbuoFcMTSIRbjjKE35QAkF3rcR7uEEqssdlyzNn1
         FyWdQQyWEe1qtb4I7Ybr/oH53K0iTBJ2fBxtgUUwVBjOoxIoQE7oyqis2hvezTc+BvrK
         zy6KWUobBi7jnhtRoJWkVLKpAQR6zfUQT72TpXXIFS//Nz+mNt5vreK/6/S42AVZDStI
         r/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUcgXIw5qrtpKcLoD4vSn2n6HaJM/nHW9YxGO87AdROFcN2JxNWs4KMLo4mSD8Ih0zFyflXECL8zjA8oks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZEhB5aZgMN8vxK57pn3t69/ePNzOYFWxl1hP0km/LW09HXiI
	PxeDmO4DqmM9CAxCVzCYrtsdy27qmERpOYCgKHtW8qxjMFcbSxr0TeKAd+gE0h1SZ1BIjtlKtIx
	LWGVl2TC+Lm4sFQhH7sKI3/YRxphqx0MNuO+fkI2YLhcI39Vhr6WxX8/wbN3yc4wTNQ==
X-Gm-Gg: ASbGncucMHrtTwakAz1V3K29NULiDN+YiGCzRI4E2js8puySisPHb5HoJngAs+hl+4S
	coPEuokOnz8oTrbxnxhmSdzq5hcHgzSdFlPZIUKXUeXHG69tAeTQYeApSi7vN/yTYLph29RHqrf
	edMG+rV2yq/fJ3XswMD5ulIDDpNsl8m2OC5jm6ztYTzoRsElVRQrp7/B5Plqe33O4OsXlzhSNJt
	d+cOrg3ZusHP9g83kFcyGk52EFwv7rb1L4RpxILigK/L/gpIJAdZHGUWN/TFUTyf9VCOxQHxTs4
	byqDw9nM063jp9wwjaTGeuZwLzyZAKBq0m24m2HlhA/K0mmuh9zT6tu4XrlK2GdjUej9W/o=
X-Received: by 2002:a05:6902:6186:b0:e97:f3b:a5cf with SMTP id 3f1490d57ef6-e970f3c084cmr1556249276.50.1756406879030;
        Thu, 28 Aug 2025 11:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPa+cEWt0rccm+FR69tEreMYMdozxieXj9AL6zbvaqHbENbkq0QILula/g9Y9hmi61uQkkpA==
X-Received: by 2002:a05:6902:6186:b0:e97:f3b:a5cf with SMTP id 3f1490d57ef6-e970f3c084cmr1556226276.50.1756406878607;
        Thu, 28 Aug 2025 11:47:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9833e2c1ffsm68767276.0.2025.08.28.11.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:47:58 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <716b6ce4-fa21-4fa4-bfd9-f192257289db@redhat.com>
Date: Thu, 28 Aug 2025 14:47:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250828182037.qkdKVaTN@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/25 2:20 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-28 15:06:26 [-0300], André Almeida wrote:
>> Thanks for the feedback! I will send a v2 addressing this by next week.
> Any objections for getting Waiman's fix in for now and your rework for
> next merge window?

I would prefer this as well. Thanks!

Cheers,
Longman


