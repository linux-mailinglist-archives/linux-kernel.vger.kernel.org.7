Return-Path: <linux-kernel+bounces-753769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C5EB187A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20258172E39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4F1F4281;
	Fri,  1 Aug 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zaboa37G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939684A04
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754075760; cv=none; b=O7IQNkiQY2C6j23teEnwAHk1RG7kFTgNqW9jG3iq+iK82EaT0G0Hy2ggBOpQfSltH50lEIx5wgRLnwtNpQljR1xsMjnnrRq6xlmyWtr62NkFyrewMcJXUvfURdeo27DCXWdB2hY3U4JMWL/KfPOK5gpYVS4w5L817RGWyw897+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754075760; c=relaxed/simple;
	bh=LPxxBqyUtuhunBQa1XtPyeoM3QB7q9HjNF7hwp1jNjw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GVKQ1mzh8Lq+fVlanYGkfZRdJM9uBOJLCeccsgVuJY94Q7YCbJmL1+bCog1YvzSaQIxpZxpIjRipEad3u1bQg0Pla16YpDzsqt7SQe3wqMVoIp2fCfyZq/F/0Fgaua7/kNoCk6h7PS9Nt0b1VVtyhEQG9meWpGnmFGOdMng+Un4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zaboa37G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754075757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IoEkqN8bWPQyjPBIdox9riuiUBdYS+HyRElQBWW7IA=;
	b=Zaboa37G10K3s8+Wx+mD6qgFC9x6axBequ4mphp9UjBE5n8YJvSEP9tSTnEOJMqrJyYgoW
	nxbPNwYNzkbB0SvcJyutL+MPyN47RZlY+jjpLExXN3fJG/AFQ/1vDC4Y6dvwFRViXDiSuw
	a2fl15dMKfmOj8KIErxlbC7p7pMvSBw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-MqvoEo9VPgeV2PFulU7jUw-1; Fri, 01 Aug 2025 15:15:55 -0400
X-MC-Unique: MqvoEo9VPgeV2PFulU7jUw-1
X-Mimecast-MFC-AGG-ID: MqvoEo9VPgeV2PFulU7jUw_1754075755
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab44642abeso21694681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 12:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754075755; x=1754680555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IoEkqN8bWPQyjPBIdox9riuiUBdYS+HyRElQBWW7IA=;
        b=aTyuR5R59mMSgp56x+t3Wpv+nS1yB70CchWBbZDSgHfMy3fyP4DXFt16bNTZ/jhIk9
         9GCZFFu4iZcf3xmx9dSB9HXJXEq2UD0kOugRIyAj50Zr3xdbOanjlJDs8pA7bvTCALMA
         dCTxP4k08Cr18YjOV2a/pgx1fWV4gpLev9TcaQyMCEbTXkG5ewuJ2OI4DEwwwVYWkTa8
         kr0k4/yuIcKytzsqdLeihznEJTIPEzynH+/kujdQCwX611c+ar3OpqH4dtTeyv/H00jL
         RmvI+bFO4O9TtaDfFvLjylVaHE9mlQLT1oi8q2ErHgL2vuUkz0dIv46h95P1t1dCzXPI
         C9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUpCqUwUcWr9HpknF5zr29C2lDb4sLnPqXg93CX10Qs8ZxKrjcfPf/XFbHRTve3+038d2yJgAh+DwxTzsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywah3Im6DAHoKfNRy+VADkf/hnhFXNJgHKNJiOf788eUygxOgWG
	zJDYcEiwGdxkfxW9GvfU7d2p/SLAtdAYQeHo+SyE2OdrrQqkeE/CyDr8lHqoh4Gu5dU7c1WvKUL
	GwSrGtFPIgw9bebpA5LkcT9Llt+a3zJi5c5Q8p0euPip7OJ2ORzErEk3w3GRQICPqSg==
X-Gm-Gg: ASbGnctQ3dj1UBGqIieVjNW701cxhgafQObLVRZ4CKMqYtA1wd66qfN8IFaAczIYIcJ
	h627cUcw7VT1G+mOJdVR4T2Swqx2I8r+E6v86l4gN02cVjGPNKuxFEGYLF6FJS7001Gi7DA8zp7
	2M7GzyWcIsTEAJDsTskxvcsZI89/NAQNF6KF1bhxBUXplrFbmGUm5dXx8pe+mUV1epq1LZlTIzc
	fXRBXNIAcy6tKnJhY1lsYKLcucoBlO4P5yKnFOz/pHUqBhP0g6ZqT8dZafYxTLfLz3AtIV1Rnsj
	N5Z55PyR9Wwz6XPCiq+rRx+wZNG4VZVOB7X9j9uwaIqKyubuRVISDNImR047EUnD1xkDCleYBc3
	PZOvR20jK3A==
X-Received: by 2002:a05:620a:a51c:b0:7e6:9753:db16 with SMTP id af79cd13be357-7e69753de88mr38615185a.14.1754075755158;
        Fri, 01 Aug 2025 12:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDPs+RipZsZgw8ymStNPU+7l0q2MgRcJV5IeUYxdmkN1NqFWa645L3nt6+ToiX3mLwT8pKyQ==
X-Received: by 2002:a05:620a:a51c:b0:7e6:9753:db16 with SMTP id af79cd13be357-7e69753de88mr38611285a.14.1754075754763;
        Fri, 01 Aug 2025 12:15:54 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f706406sm248580885a.49.2025.08.01.12.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 12:15:54 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e3ab032f-8e71-4cee-983f-14eb57294c16@redhat.com>
Date: Fri, 1 Aug 2025 15:15:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] timers: Exclude isolated cpus from timer migration
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-9-gmonaco@redhat.com>
 <664fc8e7-98f6-410c-976e-2e497e5132f8@redhat.com>
 <aIy8E7IdpPr_KFtF@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aIy8E7IdpPr_KFtF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/25 9:07 AM, Frederic Weisbecker wrote:
> Le Thu, Jul 31, 2025 at 02:25:30PM -0400, Waiman Long a écrit :
>> On 7/30/25 9:11 AM, Gabriele Monaco wrote:
>>> The timer migration mechanism allows active CPUs to pull timers from
>>> idle ones to improve the overall idle time. This is however undesired
>>> when CPU intensive workloads run on isolated cores, as the algorithm
>>> would move the timers from housekeeping to isolated cores, negatively
>>> affecting the isolation.
>>>
>>> Exclude isolated cores from the timer migration algorithm, extend the
>>> concept of unavailable cores, currently used for offline ones, to
>>> isolated ones:
>>> * A core is unavailable if isolated or offline;
>>> * A core is available if non isolated and online;
>>>
>>> A core is considered unavailable as isolated if it belongs to:
>>> * the isolcpus (domain) list
>>> * an isolated cpuset
>>> Except if it is:
>>> * in the nohz_full list (already idle for the hierarchy)
>> For the nohz_full list here, do you mean nohz_full housekeeping or
>> non-housekeeping list?
> nohz_full.
>
>>> @@ -436,6 +437,20 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
>>>    	return !(tmc->tmgroup && tmc->available);
>>>    }
>>> +/*
>>> + * Returns true if @cpu should be excluded from the hierarchy as isolated.
>>> + * Domain isolated CPUs don't participate in timer migration, nohz_full
>>> + * CPUs are still part of the hierarchy but are always considered idle.
>>> + * This check is necessary, for instance, to prevent offline isolated CPU from
>>> + * being incorrectly marked as available once getting back online.
>>> + */
>>> +static inline bool tmigr_is_isolated(int cpu)
>>> +{
>>> +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
>>> +		cpuset_cpu_is_isolated(cpu)) &&
>>> +	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
>>> +}
>> Does that mean a CPU in the nohz_full non-housekeeping list is always
>> considered not isolated WRT timer migration and hence will be made available
>> for timer migration purpose?
> Exactly, because nohz_full CPUs become idle (from a tick and timer migration
> POV) when they stop their tick. And since they are idle, their global timer
> are handled by the timekeeping CPU.
>
> This is much better than making the CPU unavailable like is done in this
> patchset for domain isolated CPUs, because unavailable CPUs must still handle
> their own global timers. Unfortunately we can't just fake them as well as idle,
> like we do with nohz_full CPUs, because that would mean walking the whole timer
> migration tree everytime a timer is queued or modified. This would be too
> costly.
>
> Indeed that should be commented somewhere in this function.

Thanks for the clarification. Yes, I agree that we should better 
document it in the code as it is not clear why we are doing that.

Cheers,
Longman


