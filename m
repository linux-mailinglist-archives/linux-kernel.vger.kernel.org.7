Return-Path: <linux-kernel+bounces-826785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AADB8F571
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CD03BC034
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2F2F6567;
	Mon, 22 Sep 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TQ81andO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5CA920
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527518; cv=none; b=oJStw0xvYdDqsuRP9bJYPuF/Im0PPCw0ieKumGI9e6JU6Qtt1IHq2zd4cgkSxNNuUPge2F00zB187dQ9l1NEEGr1ZrFkB0ZwdI6EIbnJTokJtfYUe8LELQ/3MQdtsLUsbF1ZY0s800TLuD6iu2bpjwCm3TEkrMB3G0AF9IyZutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527518; c=relaxed/simple;
	bh=AigsWdrV8U413sLiWYn0DWOfNdAi83yiRHcmu2AqNU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8Z+rjwG3iJxr8DV3RzLMo3ud3iIDAIRz5ns2Zzq0EX5ItWeiOUkflT+b6KPI7htIzC1ntEbDcC89ITOrjbKpZVgvog2WA+Re5EylzC9z3gHz7IwL41GWnLG1MIDSk9VYY9Q9IeHxOSxhr0ZIg3TxCVPZuLbap/4D+hlImF3CGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TQ81andO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so931508b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758527516; x=1759132316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDel7pcF11Oq6yCh9tIpX43vHF5ddtSDLUzVljmeUyU=;
        b=TQ81andOj0RiDNXpmRhHleqRETx/wj6FE5qD80u74ywpg4erqzE3GJWURBe9q7wGgB
         Fp8Ulz8CKqCOoXVzdriotZqXQk66usBlVZNxoZIK1MrELuW/PmS3akxqc7vOgAJm+K1L
         YIeQW2WSKiTrC3D/87h2ZdhNYtv9tlNZBLqpMcnXuhAOZ+PGYlqIpVTb29koKkwaNGGL
         tqm9kFzih/OtIKIbmvBFgI417+R88rjrs5XROctZY0AS9dwh/kgRjU8EP36JkJfUTLR5
         54o8ghh7dEowtFKPW4AX83qMprbBRpIVGktb2eZ2wCJhwOgOV6LhtyS6xn6njvyvoxlm
         BPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527516; x=1759132316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDel7pcF11Oq6yCh9tIpX43vHF5ddtSDLUzVljmeUyU=;
        b=FzGUlg2L1SaGTybp/iVBiN2NvbrEHcUB1GutEXlEjJYSLNIoUmK04fzzwuXqCwgOZ0
         VrNKPoOhYze81neugKIitV+W4vI4a21hHrduVPMLfofDBU2ZKIr2IOaLWR9YXH+zI9C5
         hcUJXvpMc+bUiPQEkGRvlUpuFdIAvJnZ4pTrLBvBCfqCXmcyKT6QnAaJ8rYwIsd+HGQx
         28ezeBgBTr3jnvJrV9k3GWTX0nlf2+xUrbfFHH583OrVPNJtDdB2iIPSPkiE9XPt6sGL
         cmza4CX/R9jbZduzd4JRGXjkWjPwnPsuY0lqdTzBHY370UhMfY2XAQ+7sKtgAVPgetjT
         PQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuGP40KNuqqKcSDn4kN0rQPHjQyFUkOXcJWcLRIxthhnKbTHShHmvAwJPN9woVz5D1uH6R0jNI79E0jEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IDxeyJHGR+2YwOOZo+sAuAAlH3JJhCftNSeNAtkntiVWakba
	yJjSs+Rdg3fFkWUwpuT8v2jUHlW6W4fyAqRpyZpjBkUgx8A6W6uxlMdWXlA+l9RjJFM=
X-Gm-Gg: ASbGnctaQe4lEO+YSh2pTN3Vnq8f5G8srYBx74Wkl85KPMTrf4Og2SIObL83d3LgB53
	U+/tn3GD50fqZWRSBZBydxdxgTGtBADkGhM58aNW2VQtszPHgtFtOP2HWWXNDv65brtIbxtYKBY
	8LROj4bOZkSL95kryzQYZ9xzVD2NaWoGlb9rdZgE7tDYK2D0Rfie5c0lmk0DlKJUE5prj35vmSm
	mApQTgu3WUIkQ+f5lsocpEMmYffvR8XMnbQOh261lS7XNx0v8Y0ecb7/WuF0ibQhm+Ak+ya+nCB
	Yaw6JA/WEZvpVRUvd0p7QHWSRMAqFnrB+pacF/qgKCB2CBXLKTstT7R2k5rXie7r2Y9HVeYNQVA
	PgFWt30ZXJ5WIyAdDAlxP1meF82SHEdN1YzLUv6vd3SB2oTGzVLk=
X-Google-Smtp-Source: AGHT+IFvNwMFCIWEKmfCSKTgy3OoaxHXYVww5vD36PPLuuFVpvLur2RM9yIrNxaf8MVuw+PgrnqE8Q==
X-Received: by 2002:a05:6a00:114e:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-77e4d31e124mr13772451b3a.8.1758527516015;
        Mon, 22 Sep 2025 00:51:56 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315029c0sm3020093b3a.47.2025.09.22.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:51:55 -0700 (PDT)
Message-ID: <7d76e5ce-22c7-4b9c-bb23-d0ccbe22b745@bytedance.com>
Date: Mon, 22 Sep 2025 15:51:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] reparent the THP split queue
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shakeel,

On 9/20/25 5:33 AM, Shakeel Butt wrote:
> Hi Qi,
> 
> On Fri, Sep 19, 2025 at 11:46:31AM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> In the future, we will reparent LRU folios during memcg offline to eliminate
>> dying memory cgroups,
> 
> Will you be driving this reparent LRU effort or will Muchun be driving
> it? I think it is really important work and I would really like to get
> this upstreamed sooner than later.

I will work with Muchun to drive it. And we are also discussing some
solutions for adapting MGLRU with Harry Yoo (private email).

Oh, I forgot to cc Harry in this series.

+cc Harry Yoo.

Thanks,
Qi

> 
> thanks,
> Shakeel


