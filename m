Return-Path: <linux-kernel+bounces-753103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4623CB17EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B9E580AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CC16A956;
	Fri,  1 Aug 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2JfY//8"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404D21765E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038727; cv=none; b=GQgnC99COeAoVDXjyzQHNPmvAlHq8MvhkuRT281i9oUsfwzqeTGXdJG1eNnM0A5TCTCPl670kN4RBbrErLVp9lQWqDT7M1aOx68HWugJsyihgTQWSQDi56Qp99YD8cKNkRf9EHLBKl9T1QXrsxybazP+0RSR4HABaf9XuysVz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038727; c=relaxed/simple;
	bh=3txe69c4r3/mtA7HOmXZzOu7QHDTYMCFM0j8pcPXR9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haEMi8EUJiy00TxcyspckOH7WJuzxTkRFo5CHQyCPGBH1QYu8uZUKgHvVrFTFuWjMP452yHd7pwkB/O24gIPtswvJ7vi+abXEjzNfzqrV0K/zC0yylwlQZPmV4gfwgQan1Fw1pg6EZDvTvUviX4s1xedL8lTv9TSIJWWqG73x5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2JfY//8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso328231cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754038725; x=1754643525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOl1MSYefTojCErZh8qsltNJ6k7ijFO9awKdnwF++pk=;
        b=x2JfY//8EP5VeNUFJgXtn6HcJuAa9Ar6OL1qfVlMCvCgNmDwYw8wHFB0x37mJbfqGP
         w53WmsdH2me48nVC9zAdYjWKxPOKi79AxKy5fLXD1sW1LwAl8KhwNJeTNzbfYYdWwPBC
         RflbSrmM3FPe5WPqb2a49sRW2L6EfHUmarMntAJIkjghRUOkHSyEsA06ixRSCSP+5guS
         PHdDcP1JDHAMRY5DEcsFjsNlpgMAp/Zqh7Gb9xEUTLPidC7Bja0ur9ZFOkogcPC3THT1
         bUIu9Daxph84umtbpAP8Sdfci+p2dPXr0vHxP8hc0TdAEpXwFw8tGKhHj0OE169ebojp
         u/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038725; x=1754643525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOl1MSYefTojCErZh8qsltNJ6k7ijFO9awKdnwF++pk=;
        b=DDAOWfZHpal5si1Hn3uXJouWku9eR+HWqKrntIO4y144LLYqYga3W8cp88nv14BO9y
         yXbUlz3qzN7glc/OC/GDRugbpuV0JMIVSXx8lTwRjlX0qc7a+qNrrB95bzt3u/ixadyS
         HdlyFCdpZvt0R/VDGi1px49c4L+tbfOJVWjB4KiDEUMPoZgnaUojferQz5eN851fbV0X
         rrHi/JKz9A0aX5/wHZA5kdX0RqMi6BrW+KuMbuaQkVlKTusOaFOyNHK/zPNrmZ1Gm98F
         HQPdRLzHPUREZAabKh/jDVcdj3FnJ3DBULfPpXKcOH+liyBkeNJw8JzCn/h9Zow0ij4a
         vLHA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Gq4XnPp/RMhF70+klog3K6kCit7iE92NwRAX+nfOvU1HJhchQ5o5zJk2kCAh5fbue1GdOAw2n70gyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zBiY3EY7IUSttd6VW4UiXsFGvD0yMqfKSWPFJD3C7+1zGvfe
	Dle3VoseExgcq+ZUcuLP5cxOSdNKnMkNOSWKVulL4gGgsm72eonPAvzOg2ZYsgXC5koujvLujwr
	YjyRI6ioeQ0pehvKzgZ8o4jaG9OF4Sak7Hh4H9U7t
X-Gm-Gg: ASbGncuvXe9FFIv0WNbIkLlovBtgqMWNm3BnDXxeGoPcf0bxWo/JX1sI8eZpdGLrBEN
	Ht8MsHjVzQFgy58o1tqFkipFgUL5BCvqrBi/kSdkGQjIkpnBNE81EsZsUndaixeLADeE83N2KjO
	bPt7+KUpzoH28wI4YIFK9udVMz86LIlwFC/O7F+Jhl3vlqI3KbShFPjqVMcMerkYKCSofv2Xg8M
	H5LNc0=
X-Google-Smtp-Source: AGHT+IGZPZiZmkmsedPPxEFK1Zi9PX6A5w9q/2u2I8oM7+JwumozueAl6dLcW1n5UHd4+U/mtefW/B5M2HP0G1G56zQ=
X-Received: by 2002:ac8:5a16:0:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aefe4c3990mr3789441cf.10.1754038724829; Fri, 01 Aug 2025
 01:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7> <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
In-Reply-To: <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
From: Prashant Malani <pmalani@google.com>
Date: Fri, 1 Aug 2025 01:58:32 -0700
X-Gm-Features: Ac12FXygzDscixfovYhnPuPs4Q4VoA30a7tpfkC611rVjiBE56c-KasZPY6RYqk
Message-ID: <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, lihuisong@huawei.com, zhenglifeng1@huawei.com, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

On Thu, 31 Jul 2025 at 01:32, Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>
>
> On 31/07/2025 06:34, Prashant Malani wrote:
>
> Hi Prashant,
>
> The perf counters could return 0 when a CPU is enters a low-power idle
> state, e.g. reset or powered down, and the perf counters are in the system
> memory space (the target CPU is not woken up unfortunately).
>

Thanks for the clarification. Reset and powered down are not typically
considered "low-power idle states".
Please re-word your commit message to specifically call out the "reset and
powered-down" CPU states.

This begs the question: why is this work function being scheduled
for CPUs that are in reset or offline/powered-down at all?
IANAE but it sounds like it would be better to add logic to ensure this
work function doesn't get scheduled/executed for CPUs that
are truly offline/powered-down or in reset.

BR,

-- 
-Prashant

