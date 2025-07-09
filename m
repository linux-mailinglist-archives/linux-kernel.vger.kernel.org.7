Return-Path: <linux-kernel+bounces-723661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DDAFE9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923C116F684
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601B2DBF43;
	Wed,  9 Jul 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxWPZeAN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FB2D8796
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066361; cv=none; b=Q7AyGL+fAXgxmNbzTn1kDR02Ah4WKVS8HJCLm0Qcjd7NadL3et+RLVmAUDXvLxDzP+79dMLd6r8IRpeOMkByhbrcqsW3EzYDXHxZkKeeiGaooYeEU5K7n367rvzqKl5Lf3cjQ6VAnYJgvDbrND5zZ12w2rhgHSCTD3jgdoYxslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066361; c=relaxed/simple;
	bh=okuOq9AGi1/mlQI6ncE3VqtoSNyzETnOfaMMVNqyIDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cff66BZZ239qcp2UEU6vIeCCK5YWdJ57tfYvpNAXFjia0d5w0TDTsUm5xgsT6uPnOSqfhGAhXI/vSGOGNYMZqq/lTwrGEnWhI4bLKtoiC3uU/VfpIjnWar/ZJD971NkchuhVIAsD1nSPjwqOTe9yhQ0j66N7Sc6AkutPk17cLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxWPZeAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752066358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NonJB+AT1rN8fdqNhY5lbg1skZzA9cNFp04NucYZCc=;
	b=AxWPZeANAm8RSdmkn5ZKHDXgL4dMWS3CxH6Fiok1Of3604ybFZ8hY4KBwDRna4TArHUIEf
	EjoDeXVGo3oiACXURgHc1mQ2aOujNQ21R1pZQbeyMXKVWDc41etunGUvxwKeFFJbDbBwF5
	yKwPbMsChrs8gzv8ShLpwdm9+zh6JyE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-xooDLy4pOTWhrBoyrnN5Rw-1; Wed, 09 Jul 2025 09:05:57 -0400
X-MC-Unique: xooDLy4pOTWhrBoyrnN5Rw-1
X-Mimecast-MFC-AGG-ID: xooDLy4pOTWhrBoyrnN5Rw_1752066355
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso5145175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066355; x=1752671155;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NonJB+AT1rN8fdqNhY5lbg1skZzA9cNFp04NucYZCc=;
        b=AxdR/jYjUYNT+nOmT9R7HJ8U86D00lmqUlFYZq4TfJRaKxHWcg60t9/Tid9cp8SD5t
         k3pq1iO0tT6KgNAnYhhurD73BqoMRiBVKYYqI2gwFQE0eaChjEYWPzdk8Sls0n08IQAE
         qnYy78pTVPEaOrLnt9nhLqk5VZvuCD4VzteJWmDs+IqtQq2Y+jKROHJbYBjaE+NnMdbv
         cwX2UIwBIYFvVUPxwGpDmJIGPwEhq08iCjslVJ7q3lIhXlaSGDRf6ZIR6up9iRNgSWve
         deRctkBt/Cm9bxXlUKMiYc/xd8bgzg8iYk22V69oehqtYwPnBzJ2KP2CwxEiCe/J/I6p
         Ajyw==
X-Forwarded-Encrypted: i=1; AJvYcCV2qMKsxTH6ES3rtiHtuVxQhcbj9nfFaE3vsVYjYMgrCT4mS6pmu0gcR98q04D32eTHx69pWm9/DuhFP10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgeat88/6CcCVmzKARqcW3JRVIRoftQBTEz6d3K8brOG3JPPVn
	kQ1wZHfZOae1yxYeUHcxXzr+MPsbEbRTio2A0mBW5zobxj9HEBz5sDTT6HSabXpZtZt21IBHVpz
	P7cIys9j40DSsEhclmopk3zU6mcthank4Uv1+hY1Trc7HXUCN9sQy6ujfM0b40bY2nI5Hvy1Y8g
	==
X-Gm-Gg: ASbGncuoVxb5tPzHEYaHYXbpzicLQWtfgt2yFN406mfbOYlT6ZT8h+WUM3vo+z1rhvS
	RDRxKfgzw9CpkEv5okxNlA7lpwqL0v2jBOuXFAauHyOy/kaUtz8SjtQBMWDp4Seu3NuUh6puaP0
	S6D4BFyxigUXOQjZB+j3uqKuwfdf9rfFRUh3tTiOWMO9gLoDTrCnX+PLzrGR8AET7EEEW54dgsY
	TsKhoC4oZndzQYbbHChQ+FfkUIvRxFFMTDzQZTnE3RJCaFuTZr8z/nfsGn9CztLXVWgLf2/vWDe
	YLtkdlzbXE0M502pAszAMZyfaKbIg6o/Og27zANgYVn0kd/g5f2JPiC2HVDZw1aUSL/jjzxCU5L
	6uSXA5fM=
X-Received: by 2002:a05:600c:a086:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-454d561b8d5mr26737275e9.14.1752066354840;
        Wed, 09 Jul 2025 06:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfkACLGoa7JKSlV3+O1er0ru++A9NVlT5p+EZQ4mVchPilAXVAY/Ip3wx6V03YE5N20aD+tA==
X-Received: by 2002:a05:600c:a086:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-454d561b8d5mr26736465e9.14.1752066354289;
        Wed, 09 Jul 2025 06:05:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50dcc84sm23696105e9.24.2025.07.09.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:05:53 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v3] sched/fair: Use sched_domain_span() for
 topology_span_sane()
In-Reply-To: <fb527d60-f31b-4383-ab03-e17f0ba96a0c@amd.com>
References: <20250707105302.11029-1-kprateek.nayak@amd.com>
 <xhsmhldoyq547.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <fb527d60-f31b-4383-ab03-e17f0ba96a0c@amd.com>
Date: Wed, 09 Jul 2025 15:05:52 +0200
Message-ID: <xhsmhikk1pl8v.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/07/25 09:31, K Prateek Nayak wrote:
>
> How about the following instead of cpumask_empty() to avoid two cpumask
> operation in the common case where sd is initialized:
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e682bf991ce6..e889ae012c17 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2423,19 +2423,13 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>                       struct cpumask *sd_span = sched_domain_span(sd);
>                       int id;
>
> -			/*
> -			 * If a child level for a CPU has already covered
> -			 * the entire cpumap, build_sched_domain() for the
> -			 * domains above is skipped. Use sd->private to detect
> -			 * levels that have not been initialized in the CPU's
> -			 * hierarchy and skip them.
> -			 */
> -			if (!sd->private)
> -				continue;
> -
>                       /* lowest bit set in this mask is used as a unique id */
>                       id = cpumask_first(sd_span);
>
> +			/* Skip if span is empty */
> +			if (id >= nr_cpu_ids)
> +				continue;
> +

Oh yeah, even better. Just slap a comment like the below and ship it!

/*
 * Span can be empty if that topology level won't be used for this CPU,
 * i.e. a lower level already fully describes the topology and
 * build_sched_domain() stopped there.
 */

>                       if (cpumask_test_cpu(id, id_seen)) {
>                               /* First CPU has already been seen, ensure identical sd spans */
>                               sd = *per_cpu_ptr(sdd->sd, id);
> ---
>
> --
> Thanks and Regards,
> Prateek


