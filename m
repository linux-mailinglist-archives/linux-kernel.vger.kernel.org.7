Return-Path: <linux-kernel+bounces-795875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F108EB3F8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AE01B22062
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F32EACE1;
	Tue,  2 Sep 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E227+7pD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654292EAD16
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802187; cv=none; b=mbm9GIZorpsnh7FuimcQ/WyiFLmeQ/jgciKeLVlOvWtpZL3/nyVNwj27s1kZD7/CXp8aqQYP06xvjQnvPA33f9VrSfek9PGSlDJLB+PyHced2dEbpvniQgwRcUwTiafqLb9BQ/rB36Tt5F+lq0PD35Q/YlcsdQk0g8Rl2PcNytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802187; c=relaxed/simple;
	bh=DjKt8UNzaYiXX1wbg6hcu32U0WJE+vcx7RIjaEDBBxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbWivTONi5rBbQ+KXtzU+pY/hY64AzKVhEmgKRqVuM5QEPoBhTDZVyxRLWpDl/Z9EAuqsnivn/0gTfQ/lUya2hkmSOHCFkA48xMBoXof4HDg31S0z0ggJbzYNJQdxUS5WMChEIZKfSG/ccOBnNChlTz/7vRr4opOOkmauKQEsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E227+7pD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756802184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPlpyJtfF/5pmu8TR1GvHY68fM+j55CwwknTKQNY7Uk=;
	b=E227+7pDckrw4+EZqAywOiWKOXdfc1NPrLWPpRMFUE9ICf2FTpZM+b7k+g3lOeE0G3i33e
	P7lNV6AvalfmG/gA6gjcZ0SADg2gtmxpgM9ceqCaPioKn7ts8RdtyiXavhiI8CqFCUP1Cf
	oqq3vXYgM83ortiy9XhbDX+9cVk7OeM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-4ZOUXeJTMfyf-EiCK80NOA-1; Tue, 02 Sep 2025 04:36:19 -0400
X-MC-Unique: 4ZOUXeJTMfyf-EiCK80NOA-1
X-Mimecast-MFC-AGG-ID: 4ZOUXeJTMfyf-EiCK80NOA_1756802179
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e96e5521af4so5540628276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802179; x=1757406979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPlpyJtfF/5pmu8TR1GvHY68fM+j55CwwknTKQNY7Uk=;
        b=tD1/gXpMXI0E9T5qV8wUFIgORpYz9ZNIgVWo2MzvLpWiqr/6ZyCqbFpslnd3nWekb0
         I6FDIdLCZVgmQj0u5h88arStjn2tqOmEskpCfQgBQqCeo17cuQ7txZwbyudfMlEaaVxU
         X4LqxjzmZhBiFszupKSvCPmpepRTdZw5sDqzstgdPRLL4FZKmODV+fPx+nERT0ZfrGiV
         pjI9wJ+q/CtpmbHqubhC2z920JVx6YkBzRDLn6q2ob6suUN8Kn6ztptBTwUtPdgf+siv
         /PWOYk5hk+yWvJO/PTiTwgHHblEZp2A+Mx0m4AsA6ybEc72PBHXfoov2/Pu6QuOGuFX3
         IeDw==
X-Forwarded-Encrypted: i=1; AJvYcCWSvknwaLLpTufIldXXY7BdYL9uYvgIV0e+ReE80MJHQktdWp6+GqWoQ/w7PJNeg2efkhTP6VRVOBgLqkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsZ+3zKSqHFpojM4+zPaFTxC5FV+otDNjXsGia0SWhg4Xpw+4
	Zzv9PyjyfLd3TLse4hdW8uVDLntjnJCia0c+ErpCnEq1JcWOsrgGzUYC4bfieT3+LbwkZt4SQJ4
	WXh/k4Bn1nMdIg5guUKMIr2x1WCIPbfW8YrIMl+SuF7FujBqVVuhyq2sX/s4+4yTIVQ98vzvl1Q
	==
X-Gm-Gg: ASbGnctftlUdEcfcA+rNSMXJSCRzolgETKx2L93PWEyDqfroLXqEoafRHYbrVqehjZ+
	9SpSZXzZFmCMdBKNU+Pk1g2HegVDEBRvZHOq8BAlAQ7DYk1h8W9iWWXen4HmUuCCsfWvtCcmDJF
	oVBzxMp964ktMWmPTPEDzrsTii5olOtSSM6dE1o3R2OUScV4tF9TFPOG59/NjhR/HW+a/SBjIvO
	7wGPNX2qWXijg2Jzr8G1c3G9e6KfpkL3L7qXABThN5HIp5PF2MpVtdNeqEkhCp6Ef0A9U2rzEjK
	A06Ixe4UWjPoIUEFaI2bHs1N6fiUzKSgJEvzdFAtrkfqmq0ftMD+612eDjWYpFEnz/gFW49NdF/
	UTfpGbxnCQKQ=
X-Received: by 2002:a05:6902:4187:b0:e95:3636:fec7 with SMTP id 3f1490d57ef6-e98a575d3f7mr9810597276.3.1756802179011;
        Tue, 02 Sep 2025 01:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN1rW921wMnlhkrowJD62Ue2sE0nnUiq8xQvdxYpOwafskgnuVzhDNETsAfUG/ascbcpgGRw==
X-Received: by 2002:a05:6902:4187:b0:e95:3636:fec7 with SMTP id 3f1490d57ef6-e98a575d3f7mr9810577276.3.1756802178465;
        Tue, 02 Sep 2025 01:36:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf4bfccsm409044276.10.2025.09.02.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:36:18 -0700 (PDT)
Message-ID: <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
Date: Tue, 2 Sep 2025 10:36:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: usb: r8152: resume-reset deadlock
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 11:55 AM, Sergey Senozhatsky wrote:
> I'm looking into the following deadlock
> 
> <4>[ 1596.492101] schedule_preempt_disabled+0x15/0x30
> <4>[ 1596.492170] __mutex_lock_common+0x256/0x490
> <4>[ 1596.492209] __mutex_lock_slowpath+0x18/0x30
> <4>[ 1596.492249] __rtl8152_set_mac_address+0x80/0x1f0 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492327] dev_set_mac_address+0x7d/0x150
> <4>[ 1596.492395] rtl8152_post_reset+0x72/0x150 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492438] usb_reset_device+0x1ce/0x220
> <4>[ 1596.492507] rtl8152_resume+0x99/0xc0 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492550] usb_resume_interface+0x3c/0xc0
> <4>[ 1596.492619] usb_resume_both+0x104/0x150
> <4>[ 1596.492657] ? usb_dev_suspend+0x20/0x20
> <4>[ 1596.492725] usb_resume+0x22/0x110
> <4>[ 1596.492763] ? usb_dev_suspend+0x20/0x20
> <4>[ 1596.492800] dpm_run_callback+0x83/0x1d0
> <4>[ 1596.492873] device_resume+0x35f/0x3d0
> <4>[ 1596.492912] ? pm_verb+0xa0/0xa0
> <4>[ 1596.492951] async_resume+0x1d/0x30
> <4>[ 1596.493019] async_run_entry_fn+0x2b/0xd0
> <4>[ 1596.493060] worker_thread+0x2ce/0xef0
> <4>[ 1596.493101] ? cancel_delayed_work+0x2d0/0x2d0
> <4>[ 1596.493170] kthread+0x16d/0x190
> <4>[ 1596.493209] ? cancel_delayed_work+0x2d0/0x2d0
> <4>[ 1596.493247] ? kthread_associate_blkcg+0x80/0x80
> <4>[ 1596.493316] ret_from_fork+0x1f/0x30
> 
> rtl8152_resume() seems to be tricky, because it's under tp->control
> mutex, when it can see RTL8152_INACCESSIBLE and initiate a full
> device reset via usb_reset_device(), which eventually re-enters rtl8152,
> at which point it calls __rtl8152_set_mac_address() and deadlocks on
> tp->control (I assume) mutex.

Decoding the above stack trace will tell for sure.

> __rtl8152_set_mac_address() has in_resume flag (added by Takashi in
> 776ac63a986d), which is set only in "reset_resume" case, wheres what
> we have is "resume_reset".  Moreover in_resume flag is not for tp->control
> mutex, as far as I can tell, but for PM lock.  When we set_mac_address
> from resume_reset, we lose in_resume flat, so not only we deadlock on
> tp->control mutex, but also we may (I guess) deadlock on the PM lock.
> 
> Also, we still call rtl8152_resume() even in reset_resume, which I
> assume still can end up resetting device and hence in set_mac_address()
> in non-in_resume mode, potentially triggering the same deadlock that
> Takashi fixed.  Well, unless I'm missing something.
> 
> So I don't think I want to add another flag to mark "current owns tp->control
> mutex" so that we can handle re-entry.  How about moving usb reset
> outside of tp->control scope?  Is there any harm in doing that?

According to commit 4933b066fefbee4f1d2d708de53c4ab7f09026ad, the
usb_reset_device() call is intentionally under tp->control protection to
vs double reset.

At very least the proposed code here could end-up causing an unexpected
reset when SELECTIVE_SUSPEND is set.

I *guess* you should track the current status explicitly to restrict the
reset at in the !test_bit(SELECTIVE_SUSPEND) scenario and explicitly
avoid delayed reset during resume.

Ad very least you should add a fixes tag, a proper Sob and use canonical
commit references.

Thanks,

Paolo


