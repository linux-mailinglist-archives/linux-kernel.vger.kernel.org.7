Return-Path: <linux-kernel+bounces-807895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617AFB4AAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4920418947F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1E31A56D;
	Tue,  9 Sep 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hd7Mb8x7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3722173F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414257; cv=none; b=XdtitfhJqjmELUzmyfbbG89ACmCJfdzlVJVDy262hLewHIRf3Ycnrzvrp27QbVGZQTxxkc9AU2eeg0Rv5bfmpBf7RjMW3EsrnnBNyr0r20KPGbtSKKo6I103PWXMnrBKkLMhxmUWf1Cc8wRUBbHuW3x8A8P3woNV+AZlV4s5Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414257; c=relaxed/simple;
	bh=tOVPEp/MTlKsJFucvk1mXnIhVJM5p8v/XPG9VoLfBuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uqk4ORFxSGo9oD+CnDHAt6mGao1LhdYvwq5pP1ftvUFkXrDx0NHIb0kOe8f3YSrtgn9KWBETQRC57pwRj0sQ4EmFN5e/sp7iHoJolPoyk2qzKHSF0PTx4tOs6GO5ZI2XB9uA31YfdufLZS5PVyTF7ObWufvSoNzAeouPOtE0zKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hd7Mb8x7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so9809855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757414254; x=1758019054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XPlXUkVSDBce9fC5gXbf4dXNkncu4g8eJn8Euj7FzU=;
        b=Hd7Mb8x7KxzhzpWvyuHJ3sami7aSvxmfh827g0N++Jo63qRk5pc6WyOlx4WJWFoR9h
         nLrG7litHw4bBYEVQUnYhMLt5k1nRnkKs3IlNShyV5dB+t3pV05Ek6my3fgsUesbmSdN
         qk1XhePFkyc0xtColFltMaqJ0OstCAXRWJKnPGKEr2esVuXUem+lwE783r451y7k5gCI
         fcgj79PuDNmnNK9Gx0eZqmh/rKDdIoKMKKxomn/mkNl47tde+VEe6OO5vvckqBEsVmyn
         xW7OGQXV7NszOEjplhBQuVgu+91GCa6Hc4u0U8nd6qae8aCgKsT3FtcgRLPrkqvWg6NG
         y8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414254; x=1758019054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XPlXUkVSDBce9fC5gXbf4dXNkncu4g8eJn8Euj7FzU=;
        b=fgFC8+BR+DibgB5LZ9Axnx4ZpAbgpANG4iiNRZ3Y73rQkU9+P/IuvP/0pGgyylxce9
         d7ftLwx07uKEwEPuG0Kxh+cb0h3+nVYtVrmx8ExG/TtS25n1gXY595AL2+eNeZb12kc8
         k/coDxzSsWhRE7QNmZPU+OJkyJQgwbnse4WYv5ScDX5Dc1r6r6Pmd1G61D5PE4jr6z5v
         AoyQL1GseAKoBoDarW4K9sqnOVOELzcU/oNqVIk9VPQDXTVNAwxWBSBweGKYgQedh1RF
         TPLeoNPkEusGtvZ7k/az8kSm3lesAx1nAdirke2S7rUjytGaJlyKmzMvln2cvOS4mCho
         lV2A==
X-Forwarded-Encrypted: i=1; AJvYcCVd2rGq77a9Uma1mvajW2V3b4WxhM5PmQ0fEaLswr0av4TREG+vBEh73ti/ddu1sn4CgbpEhtuTKkk8VZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrEi+JOpX8sK41bF2GxJX0yu4UA4T7ZHAX98u5pNyBlo0JCc3
	Wosrj8N/m7Mq/Kpf3BqJNQJpsvmrVnKFKRZ1vKNzgpQgVe/QYzT5TISxq8F5cLKvjxI=
X-Gm-Gg: ASbGncuOFu0viBHVR7w1mkDN+BJNdYKsTMPUdO/uu4IrJAEe96uapXwPvK8lweo/ldn
	c9S5aNqDWqq2nHtac1Cg+HDvetMcC3Sz/716i0jivFxG5wJX0YcSn7ZgjMrd2BOod6p0YOXdE6T
	AxndL0LroHuPKT8kxiisWPb+FlvofPLHSW7DgTtKXvRC1xpnlg6AY14dCr5x5XH411TvN7yd0Su
	kMjiRtPmzUum2fxnpBtiyZ2gc2irO+scSdJOPcxZIP5j+3IQq23LM/ETgkNm1LJweA+yjoy0KBU
	dsQWE0LxBjnvH2X3ZodWDbNZbROZ4qcPpozWnf19wGanyd3mqZBZPp6LVOY/TfUec59X0qaAB6y
	/C+xMlEnmh/Z8qWcY297E0Cn0NwH1Gt3BFWYE6lZbG6YOb7Jd0WTOQTsAy/5fmg==
X-Google-Smtp-Source: AGHT+IGfn5SNs2T4O4mexjZwwy/qa+n2mx++98ZDMfxB1oIvg1Yybuz8AnmZMY2FNi85sSn/pbd64Q==
X-Received: by 2002:a05:600c:a09:b0:45b:73be:c707 with SMTP id 5b1f17b1804b1-45dddecf59cmr94488625e9.22.1757414253934;
        Tue, 09 Sep 2025 03:37:33 -0700 (PDT)
Received: from [10.0.1.24] (90-181-92-26.rco.o2.cz. [90.181.92.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521d88e8sm2105829f8f.27.2025.09.09.03.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:37:33 -0700 (PDT)
Message-ID: <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
Date: Tue, 9 Sep 2025 12:37:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] module: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250905090130.101724-1-marco.crivellari@suse.com>
 <20250905090130.101724-2-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250905090130.101724-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 11:01 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  kernel/module/dups.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index bd2149fbe117..e72fa393a2ec 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
>  	 * let this linger forever as this is just a boot optimization for
>  	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
>  	 */
> -	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
> +	queue_delayed_work(system_percpu_wq, &kmod_req->delete_work, 60 * HZ);
>  }
>  
>  bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
> @@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
>  	 * There is no rush. But we also don't want to hold the
>  	 * caller up forever or introduce any boot delays.
>  	 */
> -	queue_work(system_wq, &kmod_req->complete_work);
> +	queue_work(system_percpu_wq, &kmod_req->complete_work);
>  
>  out:
>  	mutex_unlock(&kmod_dup_mutex);

The two work items queued by the dups.c code can run anywhere. I don't
see a reason why they need to be bound to a specific CPU.

If I understand the cover letter and its linked discussion correctly,
the aim is to eventually move users to unbound workqueues unless they
really need to use per-CPU workqueues.

If it helps, I believe you can already update this code to use the new
system_dfl_wq.

-- 
Thanks,
Petr

