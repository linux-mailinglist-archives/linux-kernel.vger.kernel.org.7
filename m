Return-Path: <linux-kernel+bounces-775944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138EB2C696
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0377B959B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F882EB850;
	Tue, 19 Aug 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Boc5VT9N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2B215798
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612551; cv=none; b=i0PfbGlXBJsjydikjsvXmd0xsTQPN3XKdVTfcKNuhyvgEKMRMsn1x8KojVMCefWForwD0awRysibsm7Zmci426yvNNawEL2cZxU/Duk0pkxhrUPNMKkY0/QhD8b/XsAYNYE3w/vcBJXbjRdSzhXSODnjd1lqDkL1Ke6BbSsL3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612551; c=relaxed/simple;
	bh=tGP4OKVdnzZ9oOOih1y0lLp8kV38hEqKnDk0VZvIMyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQ85nCRhQH2yhwCwP04zv0NowcJ7t3WJHsNYM6TBEY3lYpQOKDEpxetxQe+iwnAzbFCdt1QnuC9tJ8q1ylppOeVgChn2PBKB9amPmaorpWIRrbsci82DSWHaeKdl0LAZ1Hk3CjY8a08Z/jU1VBpJsvITrz9gVJ3LYSJxXStnk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Boc5VT9N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755612549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vIupUps8hqQgORfigE7OFuQeNVsMJFzhnF2D+wkJXvY=;
	b=Boc5VT9NMqoh/Iqfu4BLZEI61U8ZEuBlAdvXIEvtymraDMbOqog12GmCtpgCnrJ8j2AhVs
	eXtwrmXXWmzQJ3PMgFWNdkAdb0EyCr6aD8oAp/4yMPvHSbciq90wm2LhPtNHYq/WxFLpYx
	x0oPSAc/NRCUq1+AcwZJPF2xsct463Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-uO4hDTbeOAmjehlj0TzGHw-1; Tue, 19 Aug 2025 10:09:08 -0400
X-MC-Unique: uO4hDTbeOAmjehlj0TzGHw-1
X-Mimecast-MFC-AGG-ID: uO4hDTbeOAmjehlj0TzGHw_1755612548
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f55eb56so123355706d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612547; x=1756217347;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIupUps8hqQgORfigE7OFuQeNVsMJFzhnF2D+wkJXvY=;
        b=DBpukLF4bUL2ebnZ6Am7Wp4EpAhgKshOUq0YNiw17n/Z8OvBLCDzypZRG7tkOqfIV+
         Z44EdjbkHM8HgByuczR4PtpdpnBTgRfE0CmuKLMubTeNlRs6sKQeIKgawZ9HaCF2Kkae
         HQcvW+kPBiO31ySL24kzXrC2XSxZFqPqvkrg+8hLiRd7D6T+APWVhu/6bSdAf/JnGoiE
         5zl6A2HSh3jiYxC1iyM3Wa2bfisbgV4DVEGxuzy/n79NGb1eZl5jtvdcp4xmaiQoqri7
         x4VKVjMXVLss5XqBu1G2RPGTckWqkbP5NJRJIWlkGXlmYFBC52CbOoYUt1Vmea2fLPM/
         aVFA==
X-Forwarded-Encrypted: i=1; AJvYcCVnNmDjfaiDbgpSnbdBtbXLqGyognE/u8GH+DoRDUfJ1B6mcv+oiKJJQZWMnZh/wcAK9cX19lVu1Cx1hmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQ3GJvTs8fFOrGMJOn4SmKzejjw5BcTYOOEjYOpCAM2wIu5Cf
	d0d3tXjyZ10Ara17VOlTMx1TC1YNQ1YrD+Pq5kF9OiipOM4Xo+YFeorUoEIWC3TUSlOCp8LIWCi
	U+EKuweZ5OcuV84coinuf8Rv6/acoGdz8iFEYyZzm/A+Ua5cvD5JkF1gaqRjJpGFJLw==
X-Gm-Gg: ASbGncvSjBqcGLP2CSiLsrUH4ddMgXC9JEdzKn3i2PFGipUts7A/THJz0WRGmDSMl3Q
	1/mq7yYaaCk7xNobEtmblknqEXF5s5reC8UXcCzrKdgOn2I0TneB0Hl9pGHfLZh4hNN/P0Q8S66
	NSCemV9VRZcDJ2SZQbKxnGvH305RMkCGrmdlgAlArsvnvP4H7IT165Mkg5K1JRLmtwGUX+kk4Ss
	/3XJmliX7j9ipiH3Xubun4YmlcFI+KKqR8xlHS8eR/9bA+AM50+vC4USDaAmI4vRqcHi+ZT8yYZ
	/l1RCM7uoTmkMOd2AWaKNTyTkJWg5YtZNO/CIKeOMGHgh2zQqwsJj2ftob+5NzzG3xD5bKTAxmb
	mj6CajWJur9x1sUGfYAGoaLYa
X-Received: by 2002:ad4:5767:0:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70c35b9165fmr30026766d6.27.1755612547302;
        Tue, 19 Aug 2025 07:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb60BwkQkgMaR5OZD6qgu6EOgKWMlGd2ljLG88fXQ0YeTnohMkKxX79CLxiNgtWZxghmphYg==
X-Received: by 2002:ad4:5767:0:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70c35b9165fmr30025666d6.27.1755612546154;
        Tue, 19 Aug 2025 07:09:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bc70c95ebsm20683246d6.67.2025.08.19.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:09:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Ben Segall <bsegall@google.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi
 Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
In-Reply-To: <20250819093427.GC38@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250819093427.GC38@bytedance>
Date: Tue, 19 Aug 2025 16:09:02 +0200
Message-ID: <xhsmhqzx7h08x.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/08/25 17:34, Aaron Lu wrote:
> On Mon, Aug 18, 2025 at 04:57:27PM +0200, Valentin Schneider wrote:
>> On 15/07/25 15:16, Aaron Lu wrote:
>> Apologies if this has been discussed before.
>>
>> So the throttled time (as reported by cpu.stat.local) is now accounted as
>> the time from which the first task in the hierarchy gets effectively
>> throttled - IOW the first time a task in a throttled hierarchy reaches
>> resume_user_mode_work() - as opposed to as soon as the hierarchy runs out
>> of quota.
>
> Right.
>
>>
>> The gap between the two shouldn't be much, but that should at the very
>> least be highlighted in the changelog.
>>
>
> Got it, does the below added words make this clear?
>

Yes, thank you. Small corrections below.

>     With task based throttle model, the previous way to check cfs_rq's
>     nr_queued to decide if throttled time should be accounted doesn't work
>     as expected, e.g. when a cfs_rq which has a single task is throttled,
>     that task could later block in kernel mode instead of being dequeued on
>     limbo list and account this as throttled time is not accurate.
                     ^^^^^^
                     accounting
>
>     Rework throttle time accounting for a cfs_rq as follows:
>     - start accounting when the first task gets throttled in its hierarchy;
>     - stop accounting on unthrottle.
>
>     Note that there will be a time gap between when a cfs_rq is throttled
>     and when a task in its hierarchy is actually throttled. This accounting
>     mechanism only started accounting in the latter case.
                     ^^^^^^
                     starts


