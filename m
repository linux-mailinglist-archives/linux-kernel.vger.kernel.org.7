Return-Path: <linux-kernel+bounces-742714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1798B0F5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC731889173
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958D2EBDDF;
	Wed, 23 Jul 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6m255j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6728C5CB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281850; cv=none; b=X5K6F3cx0+Ax6YbYkIPo0SAuexuT5Sl1jlB7TyR7J9oIA/dGXIybU3CGudOchYgzoPuIiOPC6FfJ8dconpHfQ0AGPphIxUW4XNRvsTXMHD2tvXqx79+Of0zlImjvniq9qSQHXhZdQdiBQpQTrARPLjeumBqToczw7KoN9Ef7RME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281850; c=relaxed/simple;
	bh=U38uzK1JD3eh7n8ainK+EzmBVObrd/Wbs68IYFtlkJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmjB+1U5N2tC7E/UsX1iSZnz43AWygODN14j1gl/yL4K8PXUpsehZPONplwLOxNGB0ZSh9bBbpjbzo1JBxXoGh8GtQbT0T8m+HiHYOMu+xIrIb7FRkqoquZytaKiGdnDMGBquJQhk0ITOeuKwNc+xyrZYVnhOGbn9X5QTnQEOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF6m255j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753281847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/p4SDQ4c55h5NYt4L0gdvE81VFdueNu6fJt119haaJg=;
	b=MF6m255jKvTaPBgqO2FNU2q5L6QgaPL2VCFT4KrOOPPgw6lcbOMvmChv6JB32uCtMEFtjX
	eHXEU1gBQsTq/FT+fUh3E4tPo1vyCG2AScHVxHOzDQU2anEA1Zy2pLYqND+hxegyTQlv16
	qx7JEPj/dkQHRYoM0Xq4kjEmzV/kjos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-BoJ0ozL1MvOv_9ntDTjDDw-1; Wed, 23 Jul 2025 10:44:06 -0400
X-MC-Unique: BoJ0ozL1MvOv_9ntDTjDDw-1
X-Mimecast-MFC-AGG-ID: BoJ0ozL1MvOv_9ntDTjDDw_1753281845
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so54684745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281845; x=1753886645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p4SDQ4c55h5NYt4L0gdvE81VFdueNu6fJt119haaJg=;
        b=ULRoaTJOrMqZ6KTbwD2mHaal5wCe+0uPqJtkg6SyvT7/YSOjrjgkoBt7Uf2YP1KQoO
         NSbn9tSA9C8f0UbX1fzf0L2JmrS6/Vnz+6JGWDKorNoIbyORlhqesZk0CrWCfHGgIORj
         cKpz6uAY4ZCL6A5Icn/RC6NyHLC8qMESDUtq23n3pyUUcsOpCc4F0e9twYwxTtgRSwvG
         aJ1IAB2VLTiwG6v2yC68KFqh2/2K19unoTMedaWmMzRQ6r650mS3JaB4vkfCY6B4o28d
         9vSHb62ffvPNpuy2k5Ucsdly0R+A/jt/LI7R3otgEXYLsAWA4+is6euKwptnb96wblch
         J4Jg==
X-Gm-Message-State: AOJu0Yw659e+KYBQDSlBTP/IIKmCZE7+dNozLDHSx7ai2hvSlSZp9u1T
	vI9jztOc4ZNFBbUfrdGVjJP0biUqr53Ybqe6RODeOj95s4DE7bUmSDYTY0pzNHdJAR6t6vbWE8c
	50DijvgKCKz9dlY78Ec0Yk1yQbKLx9QUb5gLXkdc+cs5yKQ9omgF6Gsd28lS/3JPfig==
X-Gm-Gg: ASbGncuvicK+ETIWDLh3PRsMZzJ/NW2oksKwWCMV8qNN5BQD1nInGTYeI2TD0iyrNRK
	sZ2ZnOugjxNGahMGOFd0VELDpV/3xNSG+hao0NHaXbDpGuDcAtD9Ysr1BCpAFFIAxAZg51/BckY
	q5Gz7IJ+kBE8Yw0PHrQw0KEUDsM2uQtDhOfGm0WVEj7o/pPqAQ0J4UTcZ4ows5i5TWyU7mE3kla
	4E068+fmD9DJiqhBN5Kz/1bBpADJnnyskewJH69sPoIb/fVuVSwNqqr5D2EjOjmceTRm7wPsR3d
	o+ziXGI1v8fVR3U9ExuukwJ3uSKSXPqRBgUN4HJN/IJQGbgHaYe8rZcDgBLptWQnIGLiAw==
X-Received: by 2002:a05:600c:6749:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-45868c91faemr31094985e9.15.1753281844630;
        Wed, 23 Jul 2025 07:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElbWRfqYJ/mdS8d+XsgGzcJHxazzXCOQaW9zLlo/HvFPfzMARCXUHdoObxEfu79JxeZfuUDw==
X-Received: by 2002:a05:600c:6749:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-45868c91faemr31094645e9.15.1753281844133;
        Wed, 23 Jul 2025 07:44:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693e3028sm25461775e9.30.2025.07.23.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:44:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:44:01 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH v20 0/6] Donor Migration for Proxy Execution (v20)
Message-ID: <aID1MQEo2UeDewVr@jlelli-thinkpadt14gen4.remote.csb>
References: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>

Hi,

On 22/07/25 07:05, John Stultz wrote:

...

> Issues still to address with the full series:
> * There’s a new quirk from recent changes for dl_server that
>   is causing the ksched_football test in the full series to hang
>   at boot. I’ve bisected and reverted the change for now, but I
>   need to better understand what’s going wrong.

After our quick chat on IRC, I remembered that there were additional two
fixes for dl-server posted, but still not on tip.

https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/
https://lore.kernel.org/lkml/20250627035420.37712-1-yangyicong@huawei.com/

So I went ahead and pushed them to

git@github.com:jlelli/linux.git upstream/fix-dlserver

Could you please check if any (or both together) of the two topmost
changes do any good to the issue you are seeing?

Thanks!
Juri


