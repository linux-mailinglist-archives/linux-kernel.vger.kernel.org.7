Return-Path: <linux-kernel+bounces-814753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97443B55838
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78517AD90A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BCB338F29;
	Fri, 12 Sep 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQIJIIev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A78335BAF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711596; cv=none; b=SK6RnHphS5sFVp9ok0mCKEZjRTuBHdp+WgwEBhybQhAVychN6q+Rs/Sp88iGDftX2fN8jA1EDtI7Lxh5a3hypY5F/ALI3v8+87aL8dir43BV8FJ6wfFajQ3wk74wUUBFhfaZWy//cZ8ZeUtWDYP/AYgDBT03jj5BoUe80TEs3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711596; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfMTKtoQoRzbI9iAWDitA1V1QITu3t9NEib2Sbh81eR1iRIWM6cvmwuWUXMdD7XpCpC1GkV/1Sn68VprBmsNNXF3s9T3uaUc95JeQcNVrmOj4N9CpRiPOhL+lffiwOuBHppa9iDMTaqfqoDlBWLKJ9WSydSTgPeSHbAAJR/jsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQIJIIev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=bQIJIIev9FH0OQQ421DUh/0BJ8orzHzsXd6pcMjRXR1j7ViIh9czwS30v5cm72rRlCqpt/
	8XBZSmML71+QFP2gWayrtQck8q7YDV/vZkpfeVDZiBVyua4Oa7r/WNoTfQUvWcxOadWxPO
	YVJ2EenRJzss4EipZQ++j2ah5uSHqcY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-DLxJ1L5SMWumekmgIrn7mw-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: DLxJ1L5SMWumekmgIrn7mw-1
X-Mimecast-MFC-AGG-ID: DLxJ1L5SMWumekmgIrn7mw_1757711592
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b345aff439so68471801cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=vomyEn8oRY47lBkNFkvSFxdgH0FKWqCVgZZZCMIy9HRAwvQr3V6mxewY0cmJw+yspq
         p6+eRTgw5p0D1GWpQdnexqJSAT+Q4Tf/bh40QIHxdFuiURs+fExA/ANe43g+3TJ7YNX3
         WVbzumrpENzI8Z12HGhOz7f+1A56Nxbs4WFYS4VJTm5nrMiEGpZr0Ag4DV5Jsk5Ty4GL
         bawMlYbMMaj9r2Vv51CzL/IjOrqBZ6Hr0qvasN/ZSTaBXWLiSAQSxhUCYkJCLxQa1jfv
         VlUEol+1v8pF4Lr38D4SrELhTz3jsbxcRR61zHw/LxaoFxEMOLz5ozU0LGoD5Amh5Dam
         7PEg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbThA3aCpLvFIjaZmxzmWzQgajpwVHDxse7pEyoI3SrSBymH0tOzUf2SKaZx2ZkKaCnIpzqkX2x7BWkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0yFs1KqN2mL5wjEm33Coaz8Mf5n36t1vpazQO+/c9cBkhLgG
	mD7lzhRLkVnvnIyCsVunc4CIDv7EMV3usn30Mf1QPl96Vl3dvyol/izcXblwTl/YD/vfs3qKE/b
	8gIqeUN20CJfQq6bn1QxCJf4ejI6jlowW4mXkSODNDALsudIcBWFCwOgtS18aIotNBA==
X-Gm-Gg: ASbGncv8er9sPIT6m8HlZ2i2nY+qNi1vBhNNz5G8T9k0QIUKRn2SMeINzv/GDriUgAB
	xkYplhm85Rv7j+eogdZOFxL0JNGHh++Is8feF0iAJP8nz6J2gPFcctA9R1ypSoeQmLhqtbThakm
	KwueZ4BRvEHcxowHuwQR6DKFs+9j27zQ9T11s4kjAahi0nO867o8vlszyjRYIVcLm5tnmbjw6Zf
	UISl+xa908aNj7wvg5eL1qi2PIfgYAbSz7VsV/gB/Tg6hiUBbZEv8Z/mCY5lAVhc9TSdrOH9miu
	uO+NtDjxW5kTEUjlS7f4/gEPWxPpsOCDZEecNfxWeho/vZ0BNARPZSaKcbRF77PW0cWb00sWniP
	n2fIZmAv1fQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549541cf.25.1757711592216;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman


