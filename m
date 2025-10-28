Return-Path: <linux-kernel+bounces-873943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1321C151FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119F540320C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFDC30BBB9;
	Tue, 28 Oct 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA9hOK+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8A306B0C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660825; cv=none; b=TqTHahYYJvgbvzolizVdNlZqrt2IdWou/mZbRiK9xTXrheCIKtCPQSjka7Ur0nbqD3B5oRSdI+KYliFCgRO9O4TnDswbF8bHPmJymVXZ6iv8jkJVqB34+SR3DtFkri6PWQNjA1g27Ua9fy53gaFzhTFjo+SG1Q+DMB65CHSG2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660825; c=relaxed/simple;
	bh=ZYPPYcYAa1kfmT6ysEa9Ljp3mYRoXr0D4R/wdyfHVMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPfTLpZa4aIRLB3k6CV+PuN/hfIudCG9j/VFQG9L5vCcDJqHbWGogi9Ic3dTvvoO1lwf2HlW4Nx5fC5VR4Fhdf9MgpoG4bnZMfQ2REq0KNvto9vAG8S9btsS+VSmRRDocJp2cYS32vinL+/xEdaVxR0fkJqNfTwga5e4SSsXtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA9hOK+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761660823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLma0EwZTNjEWu7rLdG6tlLWGqLkYFGS9BPBZl6Fju0=;
	b=GA9hOK+78bcfv8ccNDl1dt92EVH6ZxwWXiNsw2mr+kBufM/K560RVqCa+jTcGi+XhA6WUO
	/jlbECtap3fKpUapZX9aAEdUiv2N5CZU/tzfBRx6QrSjBjuK92Vs7T09ojrpbSLV3HmZhs
	z53xDsqHnImbANyDQhfpGmJhBh96Mgo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-lIcNWg6TOn2udUXgF6rcig-1; Tue, 28 Oct 2025 10:13:41 -0400
X-MC-Unique: lIcNWg6TOn2udUXgF6rcig-1
X-Mimecast-MFC-AGG-ID: lIcNWg6TOn2udUXgF6rcig_1761660821
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-475dca91610so16694475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660820; x=1762265620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLma0EwZTNjEWu7rLdG6tlLWGqLkYFGS9BPBZl6Fju0=;
        b=smZWwWNAD15nGd6HbmwGQXh6+tQUeF7daHJC5+64GDpxtazTew5Ab5WK0/7mxIfziE
         DZwamjvUDnKKTcjr4WJvLvECeHjRxozv2bKhTQom/38DtKL2hn7kYX7LuKvqMLo2H6p/
         Sn0a7Nf2kGyoYzodVavwLHUNeX9ZuB2RmUssqGt5JJmPVcbH2LEjIPWO1+KlH62jWo7R
         ZfyrD4yLbjirRkvLgbs0ANAaXbJDFFONaCMbNDBeiuhJchJZQMWx0NM1osw+p8mu8mhq
         4z/rH9UR+TWcwSjjc+Tocc3vaRfKCggk6Zu+oc+aEO1r8VK/+SqnLqcSFUcp7SvzFzWl
         Y8vw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZiLOwQqU0ZAxlolkLF9zQBjh5vQEvCfyQZfr9cIlaavj45y5/pQ4pokHKMrj6SgJtpKQefXq3moKd7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDR1DNID/rnQ876NfrSikG/345035lYDnmybKcQVfGAG6VOJhX
	OOG4saP2/sILk5fnjkSVTFPsyDi/8BRepG6pVXG2ntTKNHJEbLFiJ4TwdWOXBRjmGNeFzM6cAJH
	qSv02Mby9tDbPh3T9QrQC60AnImkzLxQr1gQLohOGWUubTVWou83scGzVxo78bhRv+0f3Bjucbg
	==
X-Gm-Gg: ASbGncvF9BIrcr/VzLlLhXcNVqA1wXfjSd45JxSwJcVWo924Hhv4+CJ0ICtGfwOAwYP
	2K0n0FHezgmjciJ9FFyJjUBAl0kgU/f2rOPV6xF36vVAQ8RC3xZnTp8fkeAcMMKKmcD1T+zUqJF
	+CHLnIh5fMEaDtCLCq6vCMr5BKixt6uOdf87wU/0YOf1mET4oIdIiLEoWIqNtKLWVp2Nqr/7J+X
	BYvajctRcc/uiyuFds0reudXk+qy8aoZTWm5d+dZWzSZP8y0lT93z3uMjqmMvC5Q4Q/v14wBiQg
	6bM1HAuSBp4jV9bBMgKZ46TyoBLntkiM2Gr3MGaW6uw6w/u9PhCVlzbOr3kKDThadxQwfKFyXgL
	kWAf0PC3l49I7YIasokxInlEalHch1pWG9XTSnPgd864yEKE=
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47717e30970mr30854325e9.26.1761660820114;
        Tue, 28 Oct 2025 07:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMJoIr+9VMwEM/UpHxSZ5ud3h8YOPEJx3EhGLMpRMZ3b2fEAstiZZWHLqNm0zTaKo1M5X22w==
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47717e30970mr30853985e9.26.1761660819662;
        Tue, 28 Oct 2025 07:13:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd03585esm197768795e9.6.2025.10.28.07.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:13:39 -0700 (PDT)
Message-ID: <785c8add-ab09-47b2-94bf-a4bfe8c13388@redhat.com>
Date: Tue, 28 Oct 2025 15:13:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] netrom: Preventing the use of abnormal neighbor
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: dan.carpenter@linaro.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20251023124107.3405829-1-lizhi.xu@windriver.com>
 <20251023135032.3759443-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023135032.3759443-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 3:50 PM, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> SIOCADDRT & NETROM_NODE commands to add new routes, there is no lock
> between them to protect the same nr_neigh.
> 
> Task0 can add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> release the neighbour because its refcount value is 1.
> 
> In this case, the following situation causes a UAF on Task2:
> 
> Task0					Task1						Task2
> =====					=====						=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node_lock()
> 					nr_node->routes[2].neighbour->count--
> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> 					nr_node_unlock()
> nr_node_lock()
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);								nr_add_node()
> 											nr_neigh_put()
> 											if (nr_node->routes[2].neighbour->count
> Description of the UAF triggering process:
> First, Task 0 executes nr_neigh_get_dev() to set neighbor refcount to 3.
> Then, Task 1 puts the same neighbor from its routes[2] and executes
> nr_remove_neigh() because the count is 0. After these two operations,
> the neighbor's refcount becomes 1. Then, Task 0 acquires the nr node
> lock and writes it to its routes[2].neighbour.
> Finally, Task 2 executes nr_neigh_put(nr_node->routes[2].neighbour) to
> release the neighbor. The subsequent execution of the neighbor->count
> check triggers a UAF.

I looked at the code quite a bit and I think this could possibly avoid
the above mentioned race, but this whole area looks quite confusing to me.

I think it would be helpful if you could better describe the relevant
scenario starting from the initial setup (no nodes, no neighs).

Thanks,

Paolo


