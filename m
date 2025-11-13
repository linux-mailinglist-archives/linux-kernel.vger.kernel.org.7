Return-Path: <linux-kernel+bounces-899841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C9EC59179
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83C44F5113
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954F359F8A;
	Thu, 13 Nov 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+K2S2s+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlCiSuLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2D3596F0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051768; cv=none; b=sTRdFB/z4al/ClnxNa4I0KvLqwVFi2LV6UfIV5Vi+629+RaIpBHrkceeW/Ht6ks+wUUZP6JAyUtv3yfpaTQBFt+Zs0x+ZsHLNu24YhBJR0sKsl/tDHb2lUCX9rJ43Aij6BDD7n5NFg8NzCTTfH2LfTgjqZlqEyGn7NVuoA98/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051768; c=relaxed/simple;
	bh=eji/SSOdXF8gy4QaZiEYeuMQSUOPDcJ453Mxlf4rTC0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GmeaKeoe93ChC6eqP8uUo352z+j2Z875JkFiq7pJeY9GboRSSZ73u0sZ7AUKDR9var7UR+YCtTy51PxPOYdis/V2irT7B9a+aeAYsZiVR1nLJPITrcZs2zVc8eZYGysqDqv4He7r2q3CwsKsO2k+Tj0ptE5+kPZ1KmY0uAdDDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+K2S2s+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlCiSuLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763051761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
	b=f+K2S2s+21zpTZxD2rmo+tczRkunoAe2EjoMCUlBmc+W8ElHDURKcy2ozSkg7w9l/0ak5U
	73pvzzhnFr6Nx94uexwP9eskKGiQCuP3CGd5lgCTYT1YUFqVD9qQYlmfGwtXLkzRWpD4y7
	9/AD5ZRvQUl1gIGotaW6ecm2/jEodZ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-GlLwg40pPM-16MPpohezHw-1; Thu, 13 Nov 2025 11:35:45 -0500
X-MC-Unique: GlLwg40pPM-16MPpohezHw-1
X-Mimecast-MFC-AGG-ID: GlLwg40pPM-16MPpohezHw_1763051744
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b244ef3ed4so331865585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763051744; x=1763656544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
        b=OlCiSuLkZ4GA70g7C0pMk6Y3wzClq5qH3aKPjDhDnvn7O/oYQoccEUEwkm62ngc64e
         RIJeXG68jBmS0vt1r1Xa11lUrdL8SwiSp6JJidK52qRfbY/3Bd1Ra5s6kCAGl+ztCE1I
         +UqOxEZDpsWCbVdkwGksVsANdQ6Hy1mIwN8lm1hFfGZdeEp5I7IfyfNJK3l3JsNW22QX
         nICwwmTlc1wNvN2H4c7Bx26tx3cgVwQUL5alfZQVTS/TX+6Pnw0hK2qV8vLLGoVXbxut
         npNVKNEK/ci3Tn/iFegM9r2f+dG9EVvFb1m0BJvZMhN3vCNENsYvI9fhVWH55FVYSrmx
         V/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051744; x=1763656544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT3IZeq6xh+hTw96O3g7ZfztMQ4cq03lu+gFuSu+QgM=;
        b=fnrJjIr0h7JnPbZZ4pYdg9LM5nKEukw6M53Mr+sWjGiuyT1QCsa5y7HOryfO4bD3zO
         fZtIj8ABays0deO59GQ/UCPUz5w9n4pYDX6iixNZ0SSHcPtcVU3MepN2wVBJqQGcpTez
         XZZubnA3R/rmiUlcvjnlWVxuHy4SHJDrMAPe9hevPQq246d1z/9QgF/SbDvgFx2CLDtf
         oFHyyvPkR6TR4KngDiV1yw20tgBfhUTh9Z4iVgWWK5vu03iSZUbzOpRaXBRQBTCM/89p
         k9iXXKfKQ9s2d50g0AI60ucaBkxMu+VMxt2k+r6PgXbD//kE0knX9vxJupcXu+SHxUUm
         N1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXQsK+55H8y2nDviJfmdRxW912bw6iFn8sj4bJRaK2S46L1ynPTOStHD06CfIBsK/S+U6KtTMH4UONW+ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFLMHZMdfBIkC1M9/HOZ3eZeJ3zjRQvZnVRwZ2do4x0NgnCqc
	yPfkzkKRvoLoFXDJdQLc+8Est4frQAbkFDX+J8+0sE92JWE1vMrZvAUEYIJkszQOD/ZLRSei0Tn
	ezmyG1fKx1g+mt3tyD9mRco1uFMuPJIdPL5ZBsqf498ByZCQpdfZDd6caiXS3Lx4VZg==
X-Gm-Gg: ASbGncvo9rfuH9Vr6jh3AG3BhDyecImuNJaAKTEh/aZZLlDwvzmWPPxGTPYcD1GA5H1
	u94isTBpXFalYp2MFNyC4Fijury7ifT6qslMZkokmJKdzq3TcU8OwEPupJz2tYmz9czDxLl5N82
	hWOSL0PyurQenYJVhtPauUxFOkmYdaxnZfciu1IlSGsgrlekFnnQqipHu0qUGfUrTGM277SxFV7
	r7NYfJcZdsT+f3C347yLfSmAJAlz702iYilrkEaRuXFJL8jmsfyFLx7Q8eFoTv9/fO5xBiV0Ik4
	c3g5qdhPWS3+d2W8VY+vNCgnLGiQJ28fkGoDgr8K+VyA+lFi+L3aO+p7Ueo/usrP1RFSBjr8bpK
	Iwp5fm3sOaB3PyiXshi3vStDg8lvQeSyarsQeoFI0VWUzvg==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3265481cf.58.1763051743743;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQFpx7ltJXzQEzs/abe+1AxOqVQWZvjF0Ua76N5ThbYdIc+i95x5FX7vaZTJCOKsnBikyGYQ==
X-Received: by 2002:ac8:5a8e:0:b0:4eb:a82b:bc2e with SMTP id d75a77b69052e-4edf211b77amr3264811cf.58.1763051743138;
        Thu, 13 Nov 2025 08:35:43 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87eed39sm14709671cf.24.2025.11.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:35:42 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <da750417-948c-4968-bdb3-9fd267fb9c10@redhat.com>
Date: Thu, 13 Nov 2025 11:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
 <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
 <20251113075356.Ix4N-p8X@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251113075356.Ix4N-p8X@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 2:53 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-12 13:21:12 [-0500], Waiman Long wrote:
>> On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
>>> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>>>> The callback_lock is a spinlock_t which is acquired either to read
>>>> a stable set of cpu or node masks or to modify those masks when
>>>> cpuset_mutex is also acquired. Sometime it may need to go up the
>>>> cgroup hierarchy while holding the lock to find the right set of masks
>>>> to use. Assuming that the depth of the cgroup hierarch is finite and
>>>> typically small, the lock hold time should be limited.
>>> We can't assume that, can we?
>> We can theoretically create a cgroup hierarchy with many levels, but no sane
>> users will actually do that. If this is a concern to you, I can certainly
>> drop this patch.
> Someone will think this is sane and will wonder. We usually don't impose
> limits but make sure things are preemptible so it does not matter.
>
>>>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
>>> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
>>> GFP_KERNEL shortly before invoking the function in question.
>> The current callers of these APIs are fine. What I am talking is about new
>> callers that may want to call them when holding a raw_spinlock_t.
> No, please don't proactive do these changes like this which are not
> fixes because something was/ is broken.

I posted this patch as a response to my review of Pingfan Liu's deadline 
scheduler patch as it need to call cpuset_cpus_allowed() to get a proper 
cpumask. However, there is an alternative way to solve this problem, so 
I am dropping this patch now. In the future, if there is a better use 
case that needs this change, I will push this patch again.

Thanks,
Longman


