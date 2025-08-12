Return-Path: <linux-kernel+bounces-764430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F61B22303
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C991B63847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10372EA142;
	Tue, 12 Aug 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUkfStex"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581662E9EBA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990400; cv=none; b=u7KJMT9eO+V1Db5aFKZc9PSRaGXsmZBDP+mTdUifwoa19ihlOnYjNjhmePGCnjsDzymtXBO1B0Qo2LTL8+TcIj0xjCOdt2SG4/6e+UCgtx/ey7hUvV9GQNofTb6rP5jIyw8WXOpoh6FEtrAOI1NIzoqseZM3XrFzGftNb5csm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990400; c=relaxed/simple;
	bh=Gvc1uOTjmEqPJcwCoE9dIs5ZnM0sYZG/d0hfJkKcJPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAZMGyTl8zqo7DXuelY7uqLA1vt9/K1rOPjj+1f78GWkhVumfLwQXCK1P0SvJS3qyBf/xY6/1RR6qnkdBhnMuOX0MVTQWD/ZZe47vhJhUwOZ5BjVLM5efUTCvVM2DXytKnFQhpvYf7XYhOxAqX4cBD5M6GbVQ1tyS7fQdPLhap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUkfStex; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxV23h+jj2aij7mNe5BpPHMzEkSRxKCVWuqGGR9MF9s=;
	b=WUkfStexm9rEktTpv8sY6S63no7lQyt97ljeXNb/xHp5oKRxGj4AIp5HQ0BkKRG34/gLll
	wN5zyM0phXaQ3hSD63B7+QFA5l5ex8sSdDJMRoaOFRalj4h0RQpD7uEEU7kICSjti1x6VC
	aUokAdQc3UK6qimYzSEU6qxcx3rat80=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-MulYO20aO5WgQ_LgynyBfw-1; Tue, 12 Aug 2025 05:19:55 -0400
X-MC-Unique: MulYO20aO5WgQ_LgynyBfw-1
X-Mimecast-MFC-AGG-ID: MulYO20aO5WgQ_LgynyBfw_1754990395
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e667b614ecso1126346785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990395; x=1755595195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxV23h+jj2aij7mNe5BpPHMzEkSRxKCVWuqGGR9MF9s=;
        b=vrc6VrWeMeuxD8Os5D1CzcPQGzn7GNpWwkUSAi7wXkK5swXlBzYC1ssciVNAqSW3Sx
         TPu5we4qm9DbYR9thcqY3jL60F50/qs2fuIqW9x6bjd+YaahAEtVNNEP54OkQRVPFLLx
         A1Xk0ASjrEs5TVYsINBWPYRC07VCPnsTQCEJxqsOaePF7gqb5zf7Q3N1QwN3OtRXb6S4
         xeX0IM9EckNe3gtnOEyocRdEUxGWHaY6CDGcQhNDZpApJNB+U6LhRmLS1vBx9ezvjVlw
         8WU3YzUe9Ns7ahlAEoekoIN1n+/6Sb9ydRjNH3fvQZR1CLFc+1DsTiI+A2Y/kTAcLaa1
         OOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSql0Qr4R1vynfWaQVlGeLV1NZgnL4QmXr6Tlphvdy645/mbcgn2lrxA8TB2K5VU7EWl5iIYIFFpzB1oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5fLd/PTLwcyZOppTR9Ngjbn0d1U7lRTC8tFjKmoYHeZQqIoF
	g+JFmNfiYvX2sAMTnHDzIItQNzAbz8yacO0INGA0ADiYe2FAIdnsT+NjZ4phWyuBV6FerCCixSP
	E+VOqjrbltlj3HBPvPAAWk5KVoV7RfZ+POeGWse8XeSljMw1chEi0FhHHafs4Dt2OcMD+9NUoGt
	Z8
X-Gm-Gg: ASbGncvdAGymhgi6UgFJ00Lx0RzI0pw2El5Bjrg4+Yr3Lq7k2CrxLLXVjME7qDag94p
	lEX26FLZnjvTtYAUzF9W3sFwAjDk+Aqmuweudc9mkba93/wgYjXXUuTfIF51K2ACgIquecM4bEd
	AmacOAxj+3LoW/OEiAjSllYuuu2zurpihIbmiSHU3E17JhI59YWk91A8UxhxzZ2aOHUYCVKha+p
	ND5s13shq78qmb+LMN/J/zkZyUTTecR0Qmjgo7nxoUmM1cwo5NIzy2ry8lBMPMbuTyyOaQJqYcj
	+xAcaqWJQ4hMZ0080ZhB5ErXYkzpdvvnDN6iVXO0LmaaDR7S6BZXewsgjAveKfdCRxmg9g==
X-Received: by 2002:a05:620a:aa1b:b0:7e6:9cc9:ee32 with SMTP id af79cd13be357-7e85880135fmr441570885a.18.1754990394811;
        Tue, 12 Aug 2025 02:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OeDXezhY8mFsl7ToEkgY9Jd89xMA/WrP3Bdz+akDEz0gZ+iECHZb4NPFzH+syxxUK1tIpQ==
X-Received: by 2002:a05:620a:aa1b:b0:7e6:9cc9:ee32 with SMTP id af79cd13be357-7e85880135fmr441569285a.18.1754990394439;
        Tue, 12 Aug 2025 02:19:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e69e15f5e0sm1392973085a.69.2025.08.12.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:19:53 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:19:49 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix dl_server_stopped()
Message-ID: <aJsHNUrMdGg3rq84@jlelli-thinkpadt14gen4.remote.csb>
References: <20250809130419.1980742-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809130419.1980742-1-chenhuacai@loongson.cn>

Hi,

On 09/08/25 21:04, Huacai Chen wrote:
> Commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> introduces dl_server_stopped(). But it is obvious that dl_server_stopped()
> should return true if dl_se->dl_server_active is 0.
> 
> Fixes: cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

This looks correct.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

> ---
> I found that after commit cccb45d7c429 ("sched/deadline: Less agressive
> dl_server handling") there is always a message "sched: DL replenish lagged
> too much" after boot. Then I found this bug, but unfortunately this patch
> cannot wipe the message.

Does

https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.com/

help with the issue?

Thanks,
Juri


