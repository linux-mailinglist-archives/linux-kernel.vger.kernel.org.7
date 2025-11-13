Return-Path: <linux-kernel+bounces-898769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5DC55F70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72883AE392
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A3321F3E;
	Thu, 13 Nov 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0CLmSqu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8B320A0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016303; cv=none; b=rRj84JO+qS9MCfsIHLh49UqRTkD5JFityfLAxwOCr0d0EwF1ttq4G78OkYIzlf6UH07pNXwwYZzlZE2YGiZaiiy6jfKRx/TCxDZK/h5bEv+DjLPZM5Ohtlnv0Qr/HvtpQxN+ZX0cRN2sduPUyMIOgA+BsneTtCSp2WRYCwAfJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016303; c=relaxed/simple;
	bh=zW0U/Jj9Zj5cp+rpQ/nb/eNOgY0kP5K/zUMpKvWQ5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAJkjONfFCk6lWs4mq4wfvTDiNL5A9Bp7lEg5mvb6xwp/kMy5KIHTmexQGKTeebZDuefISs0WOY5icOelvhBbgmRxmfedogUf0sipOoIwBbQIm2pAI0cok7H3oVDl31Nt9+9N1odlUA4JbMg8Ln+zWMhoaF2Ab71pe3Va5IRZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0CLmSqu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so512643b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763016300; x=1763621100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=t0CLmSqu4ffwnPQ+SDa6MBbM8gxpaZrCgkTr9I5CJJd/J1XhteI4XZ/+k78ZhMpZvn
         XV2wDgApqtAxc0e/Q78cGSpmBk6xdRjX42mcEy9k0mesoe5oexQR3sZZAwk4ffx0eVkA
         ef1WmUpEdGubidEDPTLiXWD6hOcOexkspSH5FzyNalJiE2sB70HmBtHZXlarFBiDnQ3U
         WZtphv6LBBovuTEBBGhh5Rf1RXc/eoPRhEcfYoPhCaKAE2LOM8EjkzBz4GqvZodbplGg
         b3FJMG6/OiYMbKNG8Ft89XlYouuwcwlEhwOunbhNWSrRwcaGOP9bAsrCBkS0V9eFlYdw
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016300; x=1763621100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNrsYC8dvbwkQ0q38sJTUQW/VSDJEZpXwI2c7yivRYY=;
        b=pSYgSJSR9SQvBK5f+18DpWJo54WZ2/WvvvB3Dh6w57hvC8E4JASLPlwMpm/24DbsoS
         mX9M7ydKlYJjbxuXxRnaEQTIu+SB2N75tC3MWLNOmDIio574OfNO5rgFAKd6lgXnmSQS
         aoHqs8udp8tDqsBlfQfO285M/0SyOOIifUGY74WlvRDPzeZUlMRgfVJlueO2F1J50gsE
         geNSMawSnO/UPdnXs8RqshDVvkj98x5NMiTh9sVHuOO25Nqu2pn1lWMGtqO5TWwZezk/
         i2wghaBtbiOHpcW+3fOiWmpvdPPl2quxyMQYTpDOBVoKeUPAoVX3XwnKhOX4fxjvn6ux
         tObw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvHh0jy7JsnbonPpZQ78prZ5LP6WailU6iGw1/eqvCLthNQqRg4OjjbxV8JrTLWx2viXV3GTTuHkN/Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQwHBoHUZ49pL84+7Hsdr+qAjnaEczVBIUB+5ME5mIW5cgHlx
	REqmxiCHJSIAhLB4sebSZgzsHxFa2S073hxRNA+NUeq17tiBuClOdCW88uaRbZ6bt9o=
X-Gm-Gg: ASbGncvLEeqK/fzQr+na9BsQ3xlLoa4D/axyf2hmhdCnhgMl4sTl3fwR7GjyNyZQmzp
	FwhrPSOej2EJEzAyWQtc0LJ15YysZEtApOvJTsSjv9/Kxkf4vntHrkOBCOV8RUEsoKi+8orStMI
	3tmZV/BUQ4n5rVIHtV36KsmkH1G/DtzVVFNvtBWZx8Hkh8QqSYuuvvhNdARD578+rUuPsc/JfXC
	CrsRF/16FUvWCsufz7CJ0dOpVkang7g17J65VovdybV2D6A7I469YPsk2SBkcZOIYi6WBSIj/NW
	HlwndONExQjcf6dLrRyHvFba0SzJQhhXeoG+CpzD29Ry8E5LlflON1jdCCJJl7cpTWQUFN4YjKj
	pgt0D/l8MOOokxx1kCed8Xr8Up8w0HNpsSCZ9Z1WtCe684HU1m4lKI3XSxlO5qzsNitJTS2a7fZ
	vg
X-Google-Smtp-Source: AGHT+IG/YrAEmV2pNfg3Yz0x5My5Rp1QA12LboDz6ew0EMfuz/CKACL8CP3RpYoJ2sNr09LmKQyELg==
X-Received: by 2002:a05:6a00:3a0f:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b7a2d91dcdmr6725319b3a.10.1763016299642;
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151380sm1099354b3a.38.2025.11.12.22.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:44:59 -0800 (PST)
Date: Thu, 13 Nov 2025 12:14:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
Message-ID: <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
References: <20251112235154.2974902-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112235154.2974902-1-wusamuel@google.com>

On 12-11-25, 15:51, Samuel Wu wrote:
> The existing cpu_frequency trace_event can be verbose, emitting an event
> for every CPU in the policy even when their frequencies are identical.
> 
> This patch adds a new policy_frequency trace event, which provides a
> more efficient alternative to cpu_frequency trace event. This option
> allows users who only need frequency at a policy level more concise logs
> with simpler analysis.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/cpufreq/cpufreq.c    |  2 ++
>  include/trace/events/power.h | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c..b65534a4fd9a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
>  			 cpumask_pr_args(policy->cpus));
>  
> +		trace_policy_frequency(freqs->new, policy->cpu);
>  		for_each_cpu(cpu, policy->cpus)
>  			trace_cpu_frequency(freqs->new, cpu);

I don't see much value in almost duplicate trace events. If we feel that a
per-policy event is a better fit (which makes sens), then we can just drop the
trace_cpu_frequency() events and print policy->cpus (or related_cpus)
information along with the per-policy events.

-- 
viresh

