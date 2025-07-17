Return-Path: <linux-kernel+bounces-735632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E26B091E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC21892069
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA32D1309;
	Thu, 17 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe44jvOa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F581F9F73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769941; cv=none; b=QCsqUiwavivtqi2GVkxJXx8TOw9/d9/rYNJk/72vqOHnPTjoJuuCkmkLKaMCaYeZyYSucap9KwUuL+zXjg6X4CFl6Y4TM87fR7UKF+ne03RjHl8L4G3LWKK4qhqBU/TiHQq8OTXo74Bn7PMRNdYcj8J9acgiXpZsJUjpYmqKVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769941; c=relaxed/simple;
	bh=MpJFV+aPSPOS646jGgmCwGNBO7AtCG30xa3IJqF6CIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R90zaQ3WovrM09iHxGv97IJLhYWa4d42+Ketiwglzo8lQJIM5dtie2aYltIH2Z7Yfb/CeVQG6AdQOPMKwssivI7kHkdXn/idNavPq02uu5JqJGOlPSt9i8e6fGbrBF+QQ45Qizpc3zKPt8ZQ1cOMD1XIgtp2natsrBKbyn7Z+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fe44jvOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752769939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJFV+aPSPOS646jGgmCwGNBO7AtCG30xa3IJqF6CIk=;
	b=fe44jvOa85/vTp72hvaY4cfe7qYTzT81hefceC9ol+C5bn2m/2nEo4Isdiw5QOO3ctgA6b
	jZPf0rTfEEC0YUyMOPWsqSSM76ZXSWoZ3qks7pVtI8Exlr/YSK2jP8gAJlHj/0csD1bkRq
	4wHVkRig/cKeL7CCbZrhMdidlAU3+k8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-rpp-K43hPDyUwhBiOvIWNw-1; Thu, 17 Jul 2025 12:32:16 -0400
X-MC-Unique: rpp-K43hPDyUwhBiOvIWNw-1
X-Mimecast-MFC-AGG-ID: rpp-K43hPDyUwhBiOvIWNw_1752769936
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so7436425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769936; x=1753374736;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpJFV+aPSPOS646jGgmCwGNBO7AtCG30xa3IJqF6CIk=;
        b=TVWa2pG843dgaNc7xddVYDMkCAve4hVImc5VnHcm774e1asUufBCI74BSj+RNi7lad
         J4XzVUrz7MBJcsWLsNib5n9Sg3nbnXDK9yvu6E6U8DqW0YU5CxAnaIqc30d/TFPhdO4N
         0JiqL04Kh5zXTROZ5txL1M0ZhFsp/DedQTiC2zMdhp/vgwg0urRKkvJMA7KkbFoGWHzd
         tURNqnZ+eGg2ElPMgXq6XNZYN7YhkH8cBHByfCJRRv6hsgw6Ikx9w86IWF4Hp/T0yzDD
         /68fQXWBc5KffBgXsgqg33G2tvsbBAwZoXR7ellseyfS3OLuQFwTCSP8GElLB1JbsypC
         XrpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5T1tG+iIU06eCvUhMMtbepOWVCN3ONzengi2H6Yk5xe4KkAogwU7fatft6ucZ80mg/C/3pxVz4BJk6C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweO9wjeKSDIWuS5msnWUlWAFeIaEinp6hlu87heFziW93tBsxP
	qxBG/nbt16gmPIY706f2+jIh5A+su1i59/b4OqGvKoE1c9wUzNHNQocDQmlX+90IkWO0Q0CfWW8
	l6ZR4jk96WxD8HH1wEqWCiJAhFSFCXh6g44I7Cdo9QrwKwvDgHhdcwtVq/XSV2qV3WQ==
X-Gm-Gg: ASbGncvH/Sud6sSNj0iaZA7FXwKTGJMwMyLhypHT/i4RpP2lPdP37R/GjVbR+BUQwWT
	isWrlAlqdNPNyZknnpmu+d/D9GR4OahRh2XdCD2ApFwvvyCcem3QC/ibTLSBlUJmOTC5BwECSHr
	Sv413Y9IwwHOsWCo5uW/koWb4S2rcDw7mnUSKGHyJKh8Ltm2S2Pgl4OvX6mSk/oC89RWcbYzikL
	ngh8xlJaDnleakseGycZ7Sruf90YK/KGuFu5ydf+RbzrXEp2yWBVDIPOPfKvbnpIN3aVG04MCTD
	Vf1uzqm8b/DC5OBkPlt6a+qmO+CBY5A20baCEkYYiMnahUbEKkLPhubbVLnF2ukbUXXPCewNyJz
	9rN2IXnV2N1hQl7JnWhDVNFrO
X-Received: by 2002:a05:600c:3114:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45638e6d1dbmr20793665e9.29.1752769935690;
        Thu, 17 Jul 2025 09:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMbAGBVOjVMscocr2JjOUn/ENuqjVFO1L2wp2IonEyWWyxFCb6fzi16IHr6x4RYtpeTsTLyA==
X-Received: by 2002:a05:600c:3114:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45638e6d1dbmr20793405e9.29.1752769935392;
        Thu, 17 Jul 2025 09:32:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886104sm56903925e9.25.2025.07.17.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:32:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
Subject: Re: [PATCH 3/6] sched: Use task_work_queued() on cid_work
In-Reply-To: <20250703140717.25703-4-frederic@kernel.org>
References: <20250703140717.25703-1-frederic@kernel.org>
 <20250703140717.25703-4-frederic@kernel.org>
Date: Thu, 17 Jul 2025 18:32:13 +0200
Message-ID: <xhsmh5xfqg4mq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/07/25 16:07, Frederic Weisbecker wrote:
> Remove the ad-hoc implementation of task_work_queued()
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>


