Return-Path: <linux-kernel+bounces-884043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4455C2F2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38353B2588
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCB218ADD;
	Tue,  4 Nov 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRgim8wm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JesOyuKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F91F37D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227732; cv=none; b=CqgRiNFJPKR8TWRYGs0RoJ1FGlWMpU2Q6MKbSlG8jNrT/N76FT9sq2HweuorFtGsMSDtRZDLzwafmXwsrgz7nxZALyISg4OL3zSIoeclLuj0XfZI/NvHaYVK/TP9FtJOmiPNY8W941ZeWEHnQaGLHl8MtWOH/so3P0sHclSSqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227732; c=relaxed/simple;
	bh=nALavD90YtUAUwK1yEQ+Fl0sw0bKiv/LwN6AWKl1/ns=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XkVKlAwxkDBUHWnw/S1/AVDsD6nGO6gJbm/lJL38DuUndPaEjR+Jx07Fu3wxrZH0rBAeDd0pr9t7+SPeM8qLfIGScLPtyju2UYiIkOrlWcoZF9plh+DFIg6cTRforQCznpyhZfpT7GLwnnCjGPALX2RHYAVh3acr/p67g3KU0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRgim8wm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JesOyuKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762227730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9vIh1x3SmNDr7XBqfO6Je4s2k/Z++Ha6rQOUWBYrSE=;
	b=FRgim8wmyvbBU4omRu00pOPfmmJ2Jp+csqtcTx09XX9/NxdKf52fURjZKlYnyNGtMbGkVt
	Br1p7uk5DjqiIxN78RPnRdLvgAVN4j1PItPfq08w+V+si0O2dIk9HTOg24qjlK+5bl0nO4
	AyAOJiZJEmf1/OUQtP+eSGZTMjscmRw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-9UqhLt5aPxap_gEOUM7exQ-1; Mon, 03 Nov 2025 22:42:08 -0500
X-MC-Unique: 9UqhLt5aPxap_gEOUM7exQ-1
X-Mimecast-MFC-AGG-ID: 9UqhLt5aPxap_gEOUM7exQ_1762227728
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf8faf8bdso149238501cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762227728; x=1762832528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9vIh1x3SmNDr7XBqfO6Je4s2k/Z++Ha6rQOUWBYrSE=;
        b=JesOyuKCU2P9uVY53JL9oSLwKIZGkrkhw2S2Yel7z2GdrpGwVFWJ7cMxL3He1Lz3Fw
         18E86zIHN3qnjcDR2fgyZN7oeBEh/ew3OAnEk4e2oFDeiCNBRRe0Fyq1s1rsjnRHLLaO
         dk4J3sni0uuufghJ+0bIWpAaDE0i7CUXQXNHQ5U69op9zVImNSMFBS8dlH24wklR51TC
         jc6EDb5Wk7p3ezFHyFMQWtdeFTkTZ2i2Bp+uOZAV7jDb/eNB2HpGBa3jxgJz/WtIKPcE
         jK7ANwrsQeYCB4tBIHKknq+0X1SW8Fr2lnDydrLhhEz8eSrkD33gTeQP4kjXj6owq90s
         ZdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762227728; x=1762832528;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9vIh1x3SmNDr7XBqfO6Je4s2k/Z++Ha6rQOUWBYrSE=;
        b=plntHRc86yvGqNzYQ9P1boiTCDxFOdqs5gKi9sRlxRdxtbfyHMDtJRnjlBYAOWI9ei
         2+rIjlQfD6kwtF68Hq46wBYWBQ6JEUsfZg8YSaxKAcH9A90u1dqiIdzLz2GdUKyIamxB
         kC4OXfi+prdG6w4WabW4wlkNJITN1MPVj5kL5nl9/8atVqqcPz6DxPp8GemMumnJyrpu
         Mjn4GxnvDlycQqonRgkwdMhckTM2+uCHrctgFZanqvQ7NFwIZlm9940Y7McWjLTolBnV
         psRYyGZhxfBdqX8/0w9xcyPj0GoJUb1lYgLEjSCXu0bkG3tSgacJ8VBcM+3nSMyUtSHb
         Q7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXkDvNyQcCJqASD91GPDCdC8HV3Pxl1sxNoeIRwcbErwXI9QIWvqrx7hWkj8FTrspEtmJ/YnJ+w6GyPq5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykw5Gxq2lOLAxb5OQpokQQEskXj6LXWF5+UFzQgHoKZLjz5X06
	YzSelw7l+qNt6UyQV+NAPssnZSQlVmnw1w0E4Au6hQA17m40DPuFymPrgs/jwb+fmEhAyOzpFiP
	dswbL+XyCmOmgbS3XrjhDLOnbTnDzic2GO2Coi3AQ9LcF1Sf2lH6h20nvtztDTezS4g==
X-Gm-Gg: ASbGncsyMqTp1bvl3ceoI+kw/PT8Hox/k5V3NV3ayI1jncWBXhQ9EZAQJETg5ThCrBc
	VJ9VOqeG9EBL4P6ZUqWx+n+Dg/AsmJMmJOG8n/PassX44Ex0sXkdoiv9Lv4iTF+8hWWxwMhIN7U
	rLzhoCInGvjWB8uM9dU1CXCn63ZL1FtSYzbMH92/eOuI50Si9aaWBKvofUbClDxAL+Krau2Cf+z
	09P2zQ3biNHWHp5MBHfJmTdrjtQuFyMU0SX/eI8blSQ4Jg7tX4r90f54kIc/dv/KJL399bkT0Yb
	zCzw4yeOARRTyIcZDxld0OZMhlsxHeD3A+qQIUCyAusItOZWx/wiYvmX4DjbyuJUE0/rzLR8TkR
	k9SgIhLszd8BsrwT8L66Z033W1COijjh6PtCgTgp99tf3vg==
X-Received: by 2002:a05:622a:5c98:b0:4ec:f5a1:a2b9 with SMTP id d75a77b69052e-4ed30e1023cmr213821241cf.37.1762227728403;
        Mon, 03 Nov 2025 19:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBL4mprOcyc8cXgHvQ5AlkiT/XJ4kSUe2h4HETd65StxQ+s0KyQ089NkZY32rNM+nYQ0VquA==
X-Received: by 2002:a05:622a:5c98:b0:4ec:f5a1:a2b9 with SMTP id d75a77b69052e-4ed30e1023cmr213821041cf.37.1762227728091;
        Mon, 03 Nov 2025 19:42:08 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed64f14f93sm3224961cf.26.2025.11.03.19.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 19:42:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5d755e54-ff86-4cd0-87bf-86290d4f13de@redhat.com>
Date: Mon, 3 Nov 2025 22:42:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>
 <aQizF0hBnM_f1nQg@jlelli-thinkpadt14gen4.remote.csb>
 <aQl0P90Q7X7fG5q-@fedora>
Content-Language: en-US
In-Reply-To: <aQl0P90Q7X7fG5q-@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 10:34 PM, Pingfan Liu wrote:
>> If that is the case, and assuming nobody touched the sleeping task
>> affinity (p->cpus_ptr), can't we just use another online cpu from
> In fact, IIUC, the change will be always propagated through the cpuset
> hier into cpus_ptr by cpuset_update_tasks_cpumask() in cpuset v2.
> (Ridong, please correct me if my understanding is wrong)

For kthreads, changes to p->cpus_ptr via cpuset is going to be updated 
with a new set of kthread patch [1] being reviewed right now.

[1] https://lore.kernel.org/lkml/20251013203146.10162-1-frederic@kernel.org/

Cheers,
Longman


