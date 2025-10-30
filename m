Return-Path: <linux-kernel+bounces-877462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC9C1E2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E249334B23F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F432C939;
	Thu, 30 Oct 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USN7XR6C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BE2BDC14
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792974; cv=none; b=H+4DjRrkwJT89LZtBHzK3BJfTm9xbMQEIBpSeM/9lS9BpHLXaR6jOjAvbusc82lXl36P8ZdDzTyjCj9SVKvKsedS+F7jur+NQWwg0gsg6PunWf+SWD39hbPx7CPnUxgdn61Ax7/ulKW/2Y206L9d2k5Z9vUhu+AT4b0q1NARcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792974; c=relaxed/simple;
	bh=UhU6JM6HTAytiRseqLgNBb5z0W7JX79FpGGtcaUXgGM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=sxV+9xu8LeC33MYJu3OpixgDKVzgZxxd9MXeXVKsFHxWr0aEOeI1GLQvIy2zkDDAzWZieArEL469mVw93ZcM5mq8usdKKlDhK9L5OSacjSOL1K3kqIwiLTzdQb0cP4zWlMLNPKUNWcnyoo4PT9CFCvJmRj+J+AHSz6RRN1OoMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USN7XR6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayWZCR/jgxweOgb/iiw0b8PNV26Ns8GZZgAmsPuN6Ew=;
	b=USN7XR6CO0aSfsIRS/6EbMK33kniHCoULgbdu5UxkKsGNCT8o1HKD3UbDskmCzUcF0tT/W
	+utAmSgEDkYrQnkADS8DBUQFMiiYndtImXx+gDCjEu5/G6uAd81UUskoeGn4IqjdBPZPZM
	iNqQJIgzkXTZru2Pgm/U6N6rXtkXrP0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-VKwvsru7OB2WW20kwu2tLQ-1; Wed, 29 Oct 2025 22:56:09 -0400
X-MC-Unique: VKwvsru7OB2WW20kwu2tLQ-1
X-Mimecast-MFC-AGG-ID: VKwvsru7OB2WW20kwu2tLQ_1761792969
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e884663b25so14972901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792969; x=1762397769;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayWZCR/jgxweOgb/iiw0b8PNV26Ns8GZZgAmsPuN6Ew=;
        b=P11euf3G6wqNOey5u8DJSUTd5rdKPJS94quhwqaeZ6BBAp/4TcjJ7sCKJoGw+1oMos
         4Lq82CKo/tbMcxBKuIbahYfewl2Bu+3rzP7umV/jlwXXPYt8naX8CIopwS7HWX6EcKY+
         6SDqZnjUbsklehXaUzWNTOeFjG+uMlaQDqdRGPRL6mRo7UI73HMgikZz7vh1nQldvTfu
         yO5JZ7vi2GAXRMozy0L+FWU9Kcj46QA9xrtn1wm5/OM1Nklvj9D/V+VIc8wo4X5nZC3Y
         QA76cIVf+uHebd2CXLwC/aQVCjhGB2V97SZ6FxsOrs/gK3fgtZrolKElh2KZbaurGMX0
         oFjw==
X-Gm-Message-State: AOJu0YySKRAt1UpnNYh3noYQjG7l+/9wv7F4SdELIrAtvg/Qby4GwczG
	B+CeqvcmMXzksiWP2e+E8ToU4vGFVf/N1fc+9uukVUCTo9ufYWguw2WnE/INGTgtU8jNXkLal9n
	SMfzIMCIGXpWa4QuraQkLpn+4o+DG4seE8I2KdCUmMzDJTIOd82lWV1HJEW0Mu5JCow==
X-Gm-Gg: ASbGncvQIhN5Nra20JJgfyoIDQ3Ut3Rmt1uMwTG/vn86rLURSDZjIT/JGOTHh4vLQuS
	FQD2qeviQrzt5dzhDXjBi80U1nOM5s3OO58eXPEYIDOWQwy/M9+fKTkbN184knYKSM3bq1Llr3v
	R7Zhf9H/uxuLsOP4hspQGsz/QtU1YCwv8MYIaEEpI0spPErVzQNkjUYC3uGwu9MpFeIbV0QFAQc
	SZdHOdx2nMEoKmDbA/V6Mucz0UyYgcasO5iBskStihWW291nOtizrM8vHSREqy81sQyhGqQH7th
	scR2XDv1sqvfsKtDZZmArRRq/E0LioO1+xU2bOBy3t8RrCnFwosqq4c57YSbhkIiPOEvkD02V+M
	aMnkWyJIf923u78eAaHHzD0NEGsFlTTa3sZ0IUGO9Ug46xg==
X-Received: by 2002:a05:622a:6116:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4ed1ec551fbmr46503711cf.52.1761792969038;
        Wed, 29 Oct 2025 19:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN1SaXmioY/1yk3NpF2WY8rFglGlSx+PXHkmPdC6JFoEo5hRWL+1yCn3FdwwETy+O2OlTD/g==
X-Received: by 2002:a05:622a:6116:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4ed1ec551fbmr46503581cf.52.1761792968643;
        Wed, 29 Oct 2025 19:56:08 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba387fdb2sm101382041cf.37.2025.10.29.19.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 19:56:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
Date: Wed, 29 Oct 2025 22:56:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
To: Thomas Gleixner <tglx@linutronix.de>
References: <20251020112802.102451-1-gmonaco@redhat.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
In-Reply-To: <20251020112802.102451-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 7:27 AM, Gabriele Monaco wrote:
> The timer migration mechanism allows active CPUs to pull timers from
> idle ones to improve the overall idle time. This is however undesired
> when CPU intensive workloads run on isolated cores, as the algorithm
> would move the timers from housekeeping to isolated cores, negatively
> affecting the isolation.
>
> Exclude isolated cores from the timer migration algorithm, extend the
> concept of unavailable cores, currently used for offline ones, to
> isolated ones:
> * A core is unavailable if isolated or offline;
> * A core is available if non isolated and online;
>
> A core is considered unavailable as isolated if it belongs to:
> * the isolcpus (domain) list
> * an isolated cpuset
> Except if it is:
> * in the nohz_full list (already idle for the hierarchy)
> * the nohz timekeeper core (must be available to handle global timers)
>
> CPUs are added to the hierarchy during late boot, excluding isolated
> ones, the hierarchy is also adapted when the cpuset isolation changes.
>
> Due to how the timer migration algorithm works, any CPU part of the
> hierarchy can have their global timers pulled by remote CPUs and have to
> pull remote timers, only skipping pulling remote timers would break the
> logic.
> For this reason, prevent isolated CPUs from pulling remote global
> timers, but also the other way around: any global timer started on an
> isolated CPU will run there. This does not break the concept of
> isolation (global timers don't come from outside the CPU) and, if
> considered inappropriate, can usually be mitigated with other isolation
> techniques (e.g. IRQ pinning).
>
> This effect was noticed on a 128 cores machine running oslat on the
> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> and the CPU with lowest count in a timer migration hierarchy (here 1
> and 65) appears as always active and continuously pulls global timers,
> from the housekeeping CPUs. This ends up moving driver work (e.g.
> delayed work) to isolated CPUs and causes latency spikes:
>
> before the change:
>
>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>   ...
>    Maximum:     1203 10 3 4 ... 5 (us)
>
> after the change:
>
>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>   ...
>    Maximum:      10 4 3 4 3 ... 5 (us)
>
> The same behaviour was observed on a machine with as few as 20 cores /
> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
>
> The first 5 patches are preparatory work to change the concept of
> online/offline to available/unavailable, keep track of those in a
> separate cpumask cleanup the setting/clearing functions and change a
> function name in cpuset code.
>
> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> nohz_full from covering all CPUs not leaving any housekeeping one. This
> can lead to problems with the changes introduced in this series because
> no CPU would remain to handle global timers.
>
> Patch 9 extends the unavailable status to domain isolated CPUs, which
> is the main contribution of the series.
>
> This series is equivalent to v13 but rebased on v6.18-rc2.

Thomas,

This patch series have undergone multiple round of reviews. Do you think 
it is good enough to be merged into tip?

It does contain some cpuset code, but most of the changes are in the 
timer code. So I think it is better to go through the tip tree. It does 
have some minor conflicts with the current for-6.19 branch of the cgroup 
tree, but it can be easily resolved during merge.

What do you think?

Thanks,
Longman


