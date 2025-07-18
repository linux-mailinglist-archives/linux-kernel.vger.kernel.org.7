Return-Path: <linux-kernel+bounces-737285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4AB0AA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E69B1C27335
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD52E7178;
	Fri, 18 Jul 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdPNWib+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39417A305
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864562; cv=none; b=P2J7JpWV50wIlQ6UwwixsEHcvSv8zd5cemWhEMPL7nHLR8TFQqMfFGBUPLwBfQL/7QpWn/ZlBKgkIn8MIjS5OA1jpUzlFEAEaycBxn9KnagiAnLCr/+x/KgcbEiO0AuOU40QcrDXDkoNNmhml+5kQ5JUDjLriTfus7EFCZfuG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864562; c=relaxed/simple;
	bh=ULlesmjS5PFQZPW54RmQGYtLDk2yABdXv6pNygSeRIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qe5ifkJLN7LDSfftquuwnL6wyd+ub32MuNWJCKk5vlxvE+SB/GiCAHSaOqAl0Mu+qaf8BvqlGb9zFIDhnZ5M5FSE1xkC6vXskrWB6Dwqgfuf6VllRYikjadGXdhHHssSHuzCJa5RBZ8Pd2gK0I3yR7qXHU6NC7Ll2sVb2AWvJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdPNWib+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752864558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfFH2dwzfpC7ZyP/hmnBxHRuZUoAUkM22jnjjaSzvZM=;
	b=HdPNWib+0Kkfqt58E4/slicGspJUomVp2U4Gr88qkxV71hiftvWTqD1fEuZVo4n/UCbcwy
	Wm3LHKP0nAOeav6/cgRUdX2BnljrO9avvWLVU9dz7gJBYGaEf1Qr5RMCGqJEgxWqfmsTDs
	3+nsoaGo1O/5dGM5Zw+X48KVqkcQPQc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-o1frwSbSNrKlkeWxWC4hUw-1; Fri, 18 Jul 2025 14:49:16 -0400
X-MC-Unique: o1frwSbSNrKlkeWxWC4hUw-1
X-Mimecast-MFC-AGG-ID: o1frwSbSNrKlkeWxWC4hUw_1752864555
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1120142f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752864555; x=1753469355;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfFH2dwzfpC7ZyP/hmnBxHRuZUoAUkM22jnjjaSzvZM=;
        b=DrJX7iTFHYAPAREkphabxTFC+JgIq9J28z1toZoS+/kkl1HCk+o3KwLZlH5TW1NY6U
         cqOaZiKH1caBZwKNoXNS3pVEUKcQ7IUUpOVHdVqil1tuSdpuk0+Jz3mHm4UFGWeqpRlX
         ART9e5fJn88bP1ik814xXA/x3UHX0YfXb/nYFV+mZEaY20Dr81PiY5L+TbpjIbZZA38O
         JTgxJU4NLHCGAMiJPocq4ii3HmvNZUw9L79vYcoSedQMloyfVfw0xHKH2ORfNZ0e2a2c
         RVCoRhy7ty1u1g7SOu9nc1QGu268GsyrL5ur6437yTGtt6B8yZPlyMuOisptE+ZnQceE
         80UA==
X-Forwarded-Encrypted: i=1; AJvYcCV9iPLWBJwvaARQbxfJ2OiG2PRtU9F+3Q3G0dYcfAIRq97cqli9kzpp1bfsRtPDRfp08EmC0nxy0/tUCIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhY23bfSmOkhekjuh+f3KNNubmWuDzRYoVVebsZ65ULsqk79m
	/2CWQXuwS/htLLbtnl6nM7STxhx85ycZ3UK+ItUBvnMiXLsPwZBnHyRxMGrUev2ue08XInjBazo
	ZypVZse3rOAeP5Ps8egtKtFUZ08PRM2ZmZtGkVdjeVrnKLpGLicKKzYQ0fST9PmHTLg==
X-Gm-Gg: ASbGncv/m7i0t9IIwbu7CTHHqvlUVysR15CSf8RekiESzDZpOcxihO9Ez2Mjs6y8Ttv
	GlAyY52hm2UeJIUsdZGJZWPjZlyx2nGSSVkDBQfVaXb+gzyf0f47xrGeHTfE5TijgMVtkflkdhL
	K4E94upQXxESHgdWdBHir7kNdM8pnMwpHzU8eRZgHlsz+8T7uYxI03D1JojD2n4gVpql3frR8vd
	DQmWBwyV7fjiGehjnm3SSUGuhIEzgqePTdkIzN2uqr6msJ8qAdcNufpc7KQmfoyOZbTkFm6UpnP
	K1zVzn271s71wGZ4ddidtOo4HS5GwJitLCsUdYN8ZmV2sLSEdrreL3EEM4WzRxbc7LxhgzVt6QQ
	5X8ba+CsPi/R5vxPdMoJ9l069
X-Received: by 2002:a05:6000:230b:b0:3b6:333:256f with SMTP id ffacd0b85a97d-3b613eb49f0mr6445231f8f.58.1752864555208;
        Fri, 18 Jul 2025 11:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEvdy2Ibqkq//oE8hgTDYmKH+Cm+wAm5HaovvgjifaODndod3ePm/secMp/YkVW9Yg79Badw==
X-Received: by 2002:a05:6000:230b:b0:3b6:333:256f with SMTP id ffacd0b85a97d-3b613eb49f0mr6445216f8f.58.1752864554821;
        Fri, 18 Jul 2025 11:49:14 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7fasm2589037f8f.69.2025.07.18.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:49:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org, Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v3] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <20250718063523.9232-1-shijie@os.amperecomputing.com>
References: <20250718063523.9232-1-shijie@os.amperecomputing.com>
Date: Fri, 18 Jul 2025 20:49:12 +0200
Message-ID: <xhsmhy0sle3mf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 18/07/25 14:35, Huang Shijie wrote:
> When detach_tasks() scans the src_cpu's task list, the task list
> may shrink during the scanning. For example, the task list
> may have four tasks at the beginning, it may becomes to two
> during the scanning in detach_tasks():
>     Task list at beginning : "ABCD"
>     Task list in scanning  : "CD"
>
>     (ABCD stands for differnt tasks.)
>
> In this scenario, the env->loop_max is still four, so
> detach_tasks() may scan twice for some tasks:
>     the scanning order maybe : "DCDC"
>

How about something like so:
"""
detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
iteration count limit. It is however set without the source RQ lock held,
and besides detach_tasks() can be re-invoked after releasing and
re-acquiring the RQ lock per LBF_NEED_BREAK.

This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
as observed within detach_tasks() can differ. This can cause some tasks to
be unnecessarily iterated over more than once, for instance:

  env.loop_max := 4
  detach_tasks()
    // Here env.src->cfs_tasks only contains two tasks which can't be
    // migrated anywhere, so they're put back in the list each time.
    env.src->cfs_tasks := [p1, p0]
    // The iteration goes:
    p0; cfs_tasks := [p0, p1]
    p1; cfs_tasks := [p1, p0]
    p0; cfs_tasks := [p0, p1]
    p1; cfs_tasks := [p1, p0]

    // IOW we iterate over each task twice
"""

> In the Specjbb test, this issue can be catched many times.
                                         ^^^^^^^
                                         caught

> (Over 330,000 times in a 30-min Specjbb test)
>
> The patch introduces "first_back" to record the first task which
> is put back to the task list. If we get a task which is equal to
> first_back, we break the loop, and avoid to scan twice for it.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


