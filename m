Return-Path: <linux-kernel+bounces-896431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B97C505A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 933A74E1DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486622C11ED;
	Wed, 12 Nov 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W8LVKXrU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954C22370D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762915309; cv=none; b=r8j1kXTg4U9Gx5kgxKy9qX8iIdpz88vIxmif+VWNg9eE9cUS+Uc9a5KbjfQPTs3tJGcLnENOExwow2ec/qwkKWp4hXT+7jGn8fAW0ew0vM4HUamofulUH+CG4yNA8On+QucbsrcDRkqvf0SWRmQMrbdVFakky8LQ7XnOzyMIrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762915309; c=relaxed/simple;
	bh=HIVpb3Ea3Ha3qhX2lJOwmi/pBuCHvki+N/sLtjmo6aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G22ZlqepDePgj+Ojp+n49U6hUpiETjpvHGPgsb9XCQdFivVvX/Nybzi8HOZ6wq9HUvNTGU0pANwbZHSC3OD4JqbVIPcoqI9E6fyxZja03a/c31NdsBwaNY1z+KkhSpW305WfYdCFEUlWobYNcYT5Wv82fSAygR5SmpeendysazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W8LVKXrU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo293871b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762915306; x=1763520106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SY2jrNudIcovqQRJNc7JsWf0TAxWFuPgrrhqfAGrE=;
        b=W8LVKXrUA9arSo7nzaQgCsd3fiZpGhZnv1T2kM55JzLB0V8gXA8lT22u1318ZUOQQw
         9Q/INC2pnfzfiQ9KI1uZyYN9CggIpW7M+cZ/PYL0r1MM4zC5V5T8muxbB4nYfeQQX6Bx
         Dy2ImybhuG8sJVaLC3O4vrdhs++K5Bomx91FEsI53rBYE2uAuPMatxqGCKINZu104SNi
         RrHE43wtj+Ui6wntyuvhkcKMGguBRt09Keqc520jUc6k7dmLmqCf95E7dN7H8wsjkW/8
         LpK54y4L8In6+zbH3CSUFqv9bcTyBoDEZ7vTVqw7KiSApNlpeBc+hb6gUdBjOOOQ42bM
         ulhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762915306; x=1763520106;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0SY2jrNudIcovqQRJNc7JsWf0TAxWFuPgrrhqfAGrE=;
        b=K4EYoen941kgMM31ByqC2LaDwlmVA9Dg9Q9U+FMCV8WW1PAWzbdesn0rYEGJai6FmQ
         DA1iqcbaLp4tM8pU88fVUwVd3+h1F41dzQ/Ko4wYfmZ19JnGa5w98s7lrwJOglge0yto
         5t90bMOZMeQksq+WwX606vkzZ7YM2y/mRsodcjkUyeS8Rhy4096kZset91Kco7o8gxc1
         L0cQ1o/DSKza5sKh48XZqorU2FVKF6M1Ll9ZLu4gYGqHqB8ANbzX9Hg4SvwLFGQZFWEB
         i7/uHrWTkwPV66IyQV7PMR9Y1L8j2e8yLwQ2ylCyYeKCr5b6FZXkGsCfufbVHH4W9dJF
         tC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWWNu/Iyq8E9ZnxtDdIxzU2LbqtBIfHxa4MaQ/Qc9qkQQ7wHWBOyadDe6+Xwz5ErCs53x2S6cSMSGG5T50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynk02BZZSEQWCdvHjIM44B3Sll0cBgY5gKfchsehJmuIOa089s
	8PDTzBy40eLBo80O3dw1m3Vc9vEL45I53PubU/ymWoiGnkIwtlbkhf7DQDAbeHrMQ2k=
X-Gm-Gg: ASbGnct2EmKRkoANmzq4UEkwM2PTp9SFoWJ0MZdrDbyVsjovLHCzlCJkWhQ2X08JqUw
	VNW6ediWH278PF3tPrFXm+lFXE5H3iwksWN5UEwCgQEBXCPwPLCmg74eJklhVofzF940/ePFp7Q
	+1GQF0zpwyq05T/MQFZvd7LR9ykqlhyMvLK1uS1TMGhMRZvEORjpFWKdLZhJPkFAFho4qNI0LF0
	uegwCeTY8LJceoLFBXfPVtIwiv3SByXh64+/tOCEBGCoqjV/gTnt8++NL0IycEKP5ONnxcfV5EC
	2F4f5hD18ow6VqjlwEVK/jpiOeBPqSlEm7sMh6qoIWn0AfZbryFrvVzD8sY6jakuwVG7CYY1sFo
	tdGHe1s4llboY0JT5Xv3URAPDOD2/eJe6mZk2EAbn/x25JmN3jsGVp48vA9oHyMcjx4Y9qW42XO
	Pa1SDl55zsZg2Q7pa0+5MCVJq9tyNr
X-Google-Smtp-Source: AGHT+IEhPnMTTjFvd8o7FDm0+wskWq7IorNzJpkMdMYERkG0Z/5C/fzOHPtBRgRo7ytLz6bZEYfcow==
X-Received: by 2002:a05:6a20:3d81:b0:34e:1009:4205 with SMTP id adf61e73a8af0-3590a069af6mr1657057637.27.1762915305962;
        Tue, 11 Nov 2025 18:41:45 -0800 (PST)
Received: from [100.82.114.220] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf167e2a5asm1064796a12.18.2025.11.11.18.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 18:41:45 -0800 (PST)
Message-ID: <be07fa50-12ce-4fb9-b2f4-445eaab220fa@bytedance.com>
Date: Wed, 12 Nov 2025 10:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
 <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wenyu Liu <liuwenyu.0311@bytedance.com>
From: Wenyu Liu <liuwenyu.0311@bytedance.com>
In-Reply-To: <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 11/11/25 21:54, Michal Koutný 写道:
> Hi Wenyu.
> 
> On Tue, Nov 11, 2025 at 09:44:27PM +0800, Wenyu Liu <liuwenyu.0311@bytedance.com> wrote:
>> Consider this situation: if we have two cftype arrays A and B
>> which contain the exact same files, and we add this two cftypes
>> with cgroup_add_cftypes().
> 
> Do you have more details about this situation?
> Does this happen with any of the mainline controllers?
> 
> Thanks,
> Michal

On our servers, there a kernel module that registered some control files with cpu controller(with some hacky code, finding and use cgroup_add_dfl_cftypes() via kallsyms_lookup_name()).
For some reason the module name was altered between version iterations.
And due to some accidents, unfortunately, the updated module was reloaded onto the server that previously had the old version installed, resulting in the cgroup becoming unavailable.

Not found this happenned with mainline controllers.

Thanks,
Wenyu

