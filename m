Return-Path: <linux-kernel+bounces-758721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC793B1D31F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39BD3A6F39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECE21B8F7;
	Thu,  7 Aug 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/jvAugV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E48F48
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550947; cv=none; b=p8DkEwPhQJMpsfDUJQQp5tyAoodrOTL33t36EkEOfo1+NxmIutiv9dWfq4oISNA5O6fJ8e09oRR4FQWtSBwDrG9KFcSZLMo3bM1pYxVMMfJp6iYRN8VaBJ2jXOl2foS11cX0Qipu3X4ZPRkZsF59VskDrbxrYiwDOBZq8/j6m1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550947; c=relaxed/simple;
	bh=mtmjPm9YXh2otPnOHOO6ccLz+0PoLCcHZTcYIPuLwOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWgWER4bwRsoTb6qDLPoqiHKjqPAJDwqWOjH0fGzUnrcU+DFmTkE+ZvKEyqxyR8aPwUZIedAenwvpzhE1XcdkhUZATyjD5LKdGd/zCuYUWAvxvaSByfgkxh2dlxvP97vHSTI8xAxNCLoDOZ6R2w0hIeSsv2lJy4kYjEY3BDEtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/jvAugV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754550945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XEkUsPN+k+MJU7kRrD9l63TqRFA4OQCOteatAqsTD0Q=;
	b=C/jvAugV7pMGoLx3o/OGwcDZtg2CKc1g0sfA0MXDR7iNJvodfsqNDYq1QRMC5iG03lm5LJ
	Di3H+38esryN2BUqiCuln0OtR5E2mVctXjXZ/9ZqgGhNB1L2BE8nLsQ8ZHf9cVaSfxV0uS
	bBiUxYWDEPp6Ez83OAT8qTcmHMJev7M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-a7kN27wcMoOySQIcstuNFg-1; Thu, 07 Aug 2025 03:15:43 -0400
X-MC-Unique: a7kN27wcMoOySQIcstuNFg-1
X-Mimecast-MFC-AGG-ID: a7kN27wcMoOySQIcstuNFg_1754550943
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e36e20d700so149961385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754550943; x=1755155743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEkUsPN+k+MJU7kRrD9l63TqRFA4OQCOteatAqsTD0Q=;
        b=pOkYHvZmtK2XzvM3vOuJBqydiKjZpofdlO/bzIaY/pbsL7BFsDxj631HPoS1X2L0up
         Vj2fDb72cb4Iv/8rH3iXzU9lf2l+9DjSf7Ecd4xpNSinl/9+boTA9/SSnocq94zWRcUN
         uT0+tSLY9lZjToSDt54Fo7pdj8WZw77ja7NawmsBqjA5fR2jW/3FC2KtqEDzki4g897U
         dxI5+iawMqbIppT7/O4T/DSQiTknNc18fFJj7myaFjlwDN4VP4PlzvH+l8Mk7kC7xRV2
         IMrBjUQaIVb0kKXXD62Uo4syoblg0W1n7Tv7GSU3js/RBkKiDWfIACvHuSRJap4Qn3BC
         f00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcZqaT7XSzRmmH93HuUjcEEvmia0U3HA+T0x4uXiDfgYcdts37FIVE56T9leVK9BhgF0KIqAGhkKAtfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0QM39bhb86/ZOT4i+yvbkq0OmqJQbPetE8mjE3UvfkLzEygR
	XMwboY7j+Lusl87ZrWnd4CnW3p7OjHpD2CP3I4KbMH6ziG3wW9NUF+cWW/C1Fex+FxvvL/VNuCD
	xZl9iNbabILJoB0h6J/cI/1jX/lEY9KBGXm+EnkSPKthy1BdSwKbhv1rEhY+4OXX1Hg==
X-Gm-Gg: ASbGncvePP3i4Y8VWNgQhjuTgfheSH6yUyrIZjqmRW0gVslOVH/sOk2xLR2aec63CZ2
	6x6LBeh2qQyfoqhHNR4yXJVndFuT1a0iLkIXBvfhn/RrpSAIXfe5bLST0IqC9S2M5IpbCGV/TnX
	7B6y0AgUzBo0A/vMYvpTm4YSj/tgzn5PY+Dz5xTtWSpN5ix/ucfRM3PNMTZ3xKrRufkiZiwJPO0
	iG+Q7MHfsmEJF8hnTPg8csGNdkhuuR8oCOopmQZyRJnTbA5MfMAA4+Ik2MDnpPWAb3k7UV5bWP3
	hTxYsfTiN//XH/jqhYGZk8/SlBxaQ9dK0yny68TJiv2pbCyD98g+qCC/oKH+b8hJx3y4eMbbwU6
	RxCUDZI0+Z8gPeT4RLkVeCnU=
X-Received: by 2002:a05:620a:1a9e:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e81ff9ae91mr302608985a.21.1754550943149;
        Thu, 07 Aug 2025 00:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9+WiBRRCq+H4RnB0Tr6tHhfPNZd1WZfXKOFerdMaIC9DXsn94l4MoDcA4SpZi97fGQJP2Hw==
X-Received: by 2002:a05:620a:1a9e:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e81ff9ae91mr302606485a.21.1754550942754;
        Thu, 07 Aug 2025 00:15:42 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-151.as13285.net. [2.102.14.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e817311ad9sm186328985a.41.2025.08.07.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:15:42 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:15:37 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] sched/deadline: Add DL server activated message
Message-ID: <aJRSmWCJI-GlApsR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250805155347.1693676-1-kuyo.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805155347.1693676-1-kuyo.chang@mediatek.com>

Hi,

On 05/08/25 23:53, Kuyo Chang wrote:
> From: kuyo chang <kuyo.chang@mediatek.com>
> 
> The DL server is introduced as a replacement for realtime throttling.
> When RT throttling is activated, a message
> "sched: RT throttling activated" is shown. However, it is currently
> difficult for users to know when the DL server is activated.
> 
> This patch adds a similar message to indicate when the DL server
> is activated, which helps users debug RT/CFS contention issues.
> 
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> ---
>  kernel/sched/deadline.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e2d51f4306b3..8e0de6cdb980 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2042,6 +2042,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>  	}
>  
>  	__enqueue_dl_entity(dl_se);
> +
> +	if (dl_server(dl_se))
> +		printk_deferred_once("sched: dl_server activated\n");
>  }

Not sure if we want/need this, but, if we do, I believe
fair_server_pick_task() might be a better place to put it, as it's
really when the dl-server is called to do its job.

Thanks,
Juri


