Return-Path: <linux-kernel+bounces-811733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2920B52D25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE856760C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF72EA15F;
	Thu, 11 Sep 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er/B0hSH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C52E8B9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582734; cv=none; b=Q9EZ1yI+uJOo1/TDybXBNJi6CH+yc0+1CtQ59lAanXLUUK8VBSxy+DsysgHc1rmIoF7u2l4mzYLnVMbreVfbga337M0U2RlJomFY3KY2AhNPtPiey03bYlx2Z3iEi01xSmzfxQngF4A8ZLpaKCEpA+j6fSDqMoiZBDfyXwyrc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582734; c=relaxed/simple;
	bh=I9rL4aMWjaE3biDe3hS5ZGHguzepHP1jxJxNdVfkp7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEETO1RlYUda1mfBY9tii2336hwB8YCY+lK7SJ3kQt6xa3tLWDWWbrN1P3FdO8EWSO0MIWMyAazMc1u4T59S4yMnXAmiaju97SguiBhIBnk5nkEF+kcIyPytkxKyaxkZ1xdof+clF7TqEf8uJP2ATMFCzC07C8HhqdlTk5QeUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Er/B0hSH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrI/DI8/+2hPnuj3YPtrhQRSKFu76HdDQVoeV7xYSL8=;
	b=Er/B0hSHE+0+/+DYEva2WUqnNc1BAhwIFSNTOnIiLSMuZDH5r22fCnMtcFcfD5+Jgw66pH
	4rkScxDiR/Msw2pjE+OdljtY8r8dXL+DmlC16DBEflxFehjTCT5KZ+R0nqh8HblyYL9+KH
	58XhncSviEPC//JeXpQ4vLLZTZFq2S8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-fkIF7jqaMeKS9Np3PuED2A-1; Thu, 11 Sep 2025 05:25:30 -0400
X-MC-Unique: fkIF7jqaMeKS9Np3PuED2A-1
X-Mimecast-MFC-AGG-ID: fkIF7jqaMeKS9Np3PuED2A_1757582730
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e76376cc75so50890f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582730; x=1758187530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrI/DI8/+2hPnuj3YPtrhQRSKFu76HdDQVoeV7xYSL8=;
        b=YVAybFsYuTLPtiDDaW2U5KQ8zEU93jmWK6suf5fcbi2Dq+AUunDRYN4TFmDV35TtJ3
         Vm2DNICozZ7UKo+HQjRDAemwMQW364M15dy2WKJqvMUECeHH5c+Eg2JSOBXf7L5aTeNV
         5Cnj16ACXnsUvaGB669GDGLFKgmFMXuyYSW6lFxyjMGCf5tBwt3ikeM86BjvvCZ2wq/9
         Cym0zD8eIj7DLZAt07S+JKcQBiFXmW+5WV/PlMh5CF46tbbbTYqD6hrwrjPDftsOaD2s
         g991HOSjG7/L/W6amE23Vc+KevgJ+zKRgQRp0TMYCxwyKb44NW1ADuLB8VT8Nf3zceBe
         0BIg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/M77Bs3RXQIHGgMJsdC4zZZIp4M/47nv3nDXZOJyVQnAPIakuND6kacvKm11VEEZIumUzBFaBomQkxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSowjL4lL0domiN9cNctr4gkOqoy0q7RTqryXolTvMUkNdW0b
	BR/OPQIebDQ0zy+3xdgichG+4N7pTRmIkO9vPA8GHRIV1RkorT80Sfs7Fne/3xU4poSw+JnbF1J
	NVnAOVfAc6+8+E6WgVbk+KKLfS4DnuD/af+WPzRs2DFEPvvFNBTqAic4dAXWgSCTCsw==
X-Gm-Gg: ASbGncslumVhpazHazUhj8PxAByrav54NUruoFzt8Tsl+knPKJ6SeM60iN0oXw3nVa7
	REzLjImEDcTnGFCKD0cYnhqjknZRPln/CZe+E9soB5ftjjGfRGALjtNm5byb6wPRdO7KW2j3dii
	YiOcTWV8D0qFG1KsjXOI34ZVqSMoTTZF7MX1Jm1PSg+abjE77lxzpgfSXGlabbCOZMLIOEwnD+b
	ayPmnsZtcQy4udrx0/doMBV9p+qamp583Pz6LRJU8jZpasn3hzgXW/sf1HsBohnitO7U5ffmk6W
	7XXigBmBaVnfrMiEs/15PT7z+jxQmlCmR7Rm7OBX6jE=
X-Received: by 2002:a05:6000:2c0c:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-3e746bffe2dmr13867591f8f.44.1757582729636;
        Thu, 11 Sep 2025 02:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2H+JPCFwbra3MAMOkZHX+Stii7EUBqUCAy+sBwWd6ZjwXiYMgQFhgrblInn0ElSZrVl05Fg==
X-Received: by 2002:a05:6000:2c0c:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-3e746bffe2dmr13867535f8f.44.1757582729043;
        Thu, 11 Sep 2025 02:25:29 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2d43sm1694588f8f.59.2025.09.11.02.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:25:28 -0700 (PDT)
Message-ID: <86200ee5-c0dc-4a70-823a-ae36b2e6c544@redhat.com>
Date: Thu, 11 Sep 2025 11:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue
 users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250905090505.104882-4-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/25 11:05 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This patch adds a new WQ_PERCPU flag at the network subsystem, to explicitly
> request the use of the per-CPU behavior. Both flags coexist for one release
> cycle to allow callers to transition their calls.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> All existing users have been updated accordingly.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

This and patch 1/3 do not apply cleanly to the net-next tree.

Please rebase and repost.

Also I suggest to split the wireless bit out of this series and send
them to the relevant sub tree, to avoid later merge issue.

Thanks,

Paolo


