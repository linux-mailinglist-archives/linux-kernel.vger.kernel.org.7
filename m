Return-Path: <linux-kernel+bounces-735030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46993B089B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EA93AF67B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E895291C25;
	Thu, 17 Jul 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKBA6RWS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9F288CBE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745781; cv=none; b=kq2KrHjkTjt5tEbb85bEtQmSUhJ0zWQtICKTIMFHtIA0lxLR1cBrQcOhc4Nj4eqhzpQLxpVVWvE3fmzwhiX5K0pLcEDZDG/W2gxUtc/AFwQV/H4+gTC5vL3RFuRH6vG7nZKthV/gTaBFEbw4qEMUZiZx7IXKAt1j4d2n4Gi0b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745781; c=relaxed/simple;
	bh=SHuWzHxNqY2Ngt4rDfsqJtpWf6RAhWXGTTjvv/eC2S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E48muIjIEP+F4kkR+LNwm8sCUWHKaV0hbvbhxo7FgpD7mWEVfw6DoEgKLD4jh1PwHCsizWdK/6Fb4bmkrQ1R+0v81AHJqXJtE9/s8oqONzpZADLconiw2falfr+RuSJbzAsmILzqI46OzKOjeXOIhlx8LEbQuR10HTlAoaovli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKBA6RWS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752745779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RKiR68U4o388Q3wroVuUHDb1qIpwPIC0YQhJHPV9igk=;
	b=AKBA6RWSQzIp3mjd1VlLcPHAPevKT3zR1TAwJZTzK2EGI89sjSrizzBPuVL+TrpkhQsJpa
	q1ncUvf1FLwGe+xg6q+A1nluktPQDsDCLkMOlSM2a1q60pXiWjwxvhZUOf0zd6jtmP7HuP
	VWB3ED7EpQ5YLjc/K2YRBQiGrHGSfWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-h7v-fcaKNVqaCP_XZeGcGQ-1; Thu, 17 Jul 2025 05:49:37 -0400
X-MC-Unique: h7v-fcaKNVqaCP_XZeGcGQ-1
X-Mimecast-MFC-AGG-ID: h7v-fcaKNVqaCP_XZeGcGQ_1752745777
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a52bfda108so383359f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745776; x=1753350576;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKiR68U4o388Q3wroVuUHDb1qIpwPIC0YQhJHPV9igk=;
        b=HDdo47QnMXcGND7mcsI+5Ae9h//CX+kjf6BQ1D8bIOTx9p7Ev5iHld4MaKivhzu7EN
         U2MPK8LyiDYUojFA7ZuNTT32KFi0IDMmgUe7w1YMnnkaBnTNJTZDtuKcjjtlV4mZ19qV
         dMdBpLkWjExi+1cAy0gb51aEwCZvi/ZJ1EMYx3ofUUpVUtpOCGz2bj8UDfGdBARFcDBa
         IKXFtTQl9WCRe9AspcPQrrCSfQMrXtVFcFIU9W7R8qX0HKZEVcMxOGJGzGRugamB3A2q
         jWs8fcJXjeKWs17FIGvj6joSmRaXiyAPolFcnAmkAIOQ0r9Ex7pvUip7lChHNP5pVojx
         mStg==
X-Forwarded-Encrypted: i=1; AJvYcCWktkqZ9HWbgLfSH8fuazqzer96r/9QgiSLgmOjNwt6pud3N4uuym2c0un99472IV2N6NA00ZoA4Y2hP/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKg7FOdGAho0pxW8MC8WyZixo21v6btKLRP5N5087iwZ9UPybY
	qxj4Bd8ZvzZN31XJqNL6tFqctF3/N+vVJweDyQ5kjbECCC0tUAz0jknZGR/cC3lkuTqqyJVP56T
	K2RHMoKp+83UpYMVLcKjA3oyk4KnwsRefRHuX766ak80C3NbM69Uav8AqJfmR4jfv8lH5YFWABc
	ifE66/0UmLEpCuBGkY14uI4MIzn6f4nmpHKEuSjy1OW5qVCkNeWg==
X-Gm-Gg: ASbGncu04Mg93GnkND8YBJRB188/XZ78/4CdvFhNDP4HimpOmnlQcAZ5s0MKWWUZos4
	QAhOtTmpWyLqaXAKFOKz8oH5WNZ5ztXarg2/n1ZgwmyfdDN0Y2MWDpO/Y3T1SW5wT/9kz+h7syH
	79wLjQ/eBxiRZRaLA8RWB1wzjvvc6hrdIRrvuDmaHRkGNDfNypJuDOphNdXEpuGLqYF78TPdg+7
	diXw28EMetyyHWgp7wx3Ki/V18G4u6BKUt7j2HaQtAZKHJiW8Npw2cGBG0rTobsQ/ag9Lt1uQRE
	lwGFU0FqpKkOI2C0d/INwbkc/AeIRQaasdMd+RLRhgv59GkQwQwdhDxkXmhrAad2cdlteVHMuom
	Ik3PTFiuc1KpCTeUiYuzuWYyp
X-Received: by 2002:a05:6000:43c7:20b0:3b6:136d:c290 with SMTP id ffacd0b85a97d-3b6136dc2a3mr1853136f8f.45.1752745775979;
        Thu, 17 Jul 2025 02:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGsVTcit7PTu40FCarp7egKZgHCinpgl8PFvus/miMHrqZDwhYYwDgA1nyHAhWzHCsgbwqA==
X-Received: by 2002:a05:6000:43c7:20b0:3b6:136d:c290 with SMTP id ffacd0b85a97d-3b6136dc2a3mr1853022f8f.45.1752745773514;
        Thu, 17 Jul 2025 02:49:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd17b7sm20071134f8f.11.2025.07.17.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:49:33 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>, Huang Shijie
 <shijie@os.amperecomputing.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <ef64a101-c983-408e-b738-4fde57901479@amperemail.onmicrosoft.com>
References: <20250707083636.38380-1-shijie@os.amperecomputing.com>
 <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d4ed8553-6a57-4b56-bc6e-ecadd2d9d75e@amperemail.onmicrosoft.com>
 <xhsmhldoo18dn.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ef64a101-c983-408e-b738-4fde57901479@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 11:49:32 +0200
Message-ID: <xhsmhikjr170z.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 17/07/25 10:56, Shijie Huang wrote:
> On 2025/7/16 23:08, Valentin Schneider wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b9b4bbbf0af6f..32ae24aa377ca 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11687,7 +11687,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   		 * still unbalanced. ld_moved simply stays zero, so it is
>>   		 * correctly treated as an imbalance.
>>   		 */
>> -		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
>> +		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_queued);
>
> I tested this patch, it did not work. I still can catch lots of 
> occurrences of this issue in Specjbb test.
>
>
> IMHO, the root cause of this issue is env.loop_max is set out of the 
> rq's lock.
>
> Even we set env.loop_max to busiest->cfs.h_nr_queued, the real tasks 
> length still can shrink in
>
> other places.
>

Ah right, and updating the max in detach_tasks() itself isn't a complete
solution if we re-enter it due to LBF_NEED_BREAK. Nevermind then :-)


