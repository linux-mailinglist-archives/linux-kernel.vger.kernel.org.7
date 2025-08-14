Return-Path: <linux-kernel+bounces-768959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6AFB26859
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6B4584EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAE301019;
	Thu, 14 Aug 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oyS707iJ"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F053019A1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179709; cv=none; b=AO0jF0x/IADA/prjrewG5V3Gc6j0k/Mkk4pnLRHa/9dEy0qPQyHnCC1gObW0Dr8Kwp/a1Suq3nn26EGQgQNLeMbttdVVs0GwqiqpBm4b8l5iZgzUdjTZeF0CSeASdB4el3BqSkb9L0TopyydG0ZdKG1UUqgRa6C02VPbu4CGAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179709; c=relaxed/simple;
	bh=7GlNJhry7TThYwVtorBJU7ypkucLCF+YWV8hYGJ/q2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C99jPYCIRBz1N/AcHoYoE2AOJM+XS8dZ46O2YNj/YfGstD072p08WuuH/QpQUw4Z6Hm47V/DsRAqZie+j342bmETbiYzNWxaPOEeXStZ6NNzUvehMkpJJIjHngFaLGKBIwDSJHl7IAU3oSp9bZi/fPVfURu7YgFRs3JWwTlsjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oyS707iJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70a88db0416so9868706d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755179706; x=1755784506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlALy2xhseF+yQTX6QJcUoYBFvoxQUQwSPoAaHJPRr8=;
        b=oyS707iJRfzFAambHeVKgYCiTzl8mlaTZxUTbsH4jTXqgmG6WUDBo3AXCd8HEquT8A
         sdMbK1rC2uqeICnQ8yfdJI0VTQt0xmp6ra7IKjd9c+siVXEVhhX/so2j+xeI4lpTRBHz
         ZuC+Wu8TeP1l7g5LnKF0UplstztZXGyLqpUQCTZC5RDpRvBghlF08sTr9g4Iugp+b9Lq
         Z2gb61x0aeEtVGAK+7ysTcT3BVwjoamoKnDQnyZYNRswRtMiwzyxsdKxZeNy20V82KME
         oQp8iuN+LCgyGkVVWVUPDBiBp5PnX850tQ3VQhqGd7Z60jwxpf8blJpB+W498/Jlwp0S
         vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179706; x=1755784506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlALy2xhseF+yQTX6QJcUoYBFvoxQUQwSPoAaHJPRr8=;
        b=U7Qp8ycHnk6GFiz0QCFuEHIxSs798XgPTtlav+altdugAXyCngTHxfKCKlwHjrgFZ/
         WQPSexBCEfQrZ0z9hH1Pp5QikrvlREikELMjmJ4prNLKAAB1/lVQKrt7oBcfIQ+RoDb5
         FR8Hfj8u/WRW+nw7ZXVYqBKqzD/EmP5yeMef1L17vs36Af5T2PyXFhmsjVpeb2pSkpRz
         6zP1e8dp3JgDfoUy9Vws79DqIV2YieAv1jVdO3eZ24tGarxhO0pRbqfokpoVkqynde/u
         3fuXPI0XskqmyMFJhtDPIRDTI/rR5f9TnQYaDPJP6XUSlzk5TgZ0VUuUbHDePqihfZ7p
         6VoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3NjgrzNHYgtlANYDoxrNpHuUs1pQYrGGZwYyfrBaJKgN38Pw4kSaqNBRaqk8Uam7r9odi9DH+O3HHyy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sOlnmOsGsawqEJmysSaA/fMoH9xfvpbXX2YrSJgvUbBj33dU
	AAv38bicnlAKbmz4AnqZB2mApgX1nEcBxMwt8c+JtERVGO/oYHFkGoVHaBP2I1uFRRc=
X-Gm-Gg: ASbGncsORWxh2+cDWgOn2fGugSlwStjvwSohnOc2bhMuJ/aO8VopKGaD0fyV4O5vyli
	L5tV+G33u7p72CyFe65CKetFTkYfPsePAvtY1PpCNvyH0otEs7CNnMWbER8IB7b2kcZjYEiYp9/
	JijlCdssljprqtMcqJ6YebHP0ux1qFUQgXu6+iNGqjx0TC22BjAilM0vHYLKyG3O1DdncbdwjgK
	Yn3uc6JGNWN5IPwxho3kmgvZ0//BgYT7Af+L4PPM3zaZUK+NkqYBlQljNBjVPcW05WwDX9JFPR7
	GrsW523o0pRQHY7TW0k5wf5mZGYEnOqgrtvCqCWYlBfQVIM300Y3aEatpN6n/pgDGgUJ9AbGlIm
	1+DnsjA8yqtLPSixsp6XIcQ==
X-Google-Smtp-Source: AGHT+IFL9mfmhIOtoP3f48wEW/B6LYJ+F/aJttG1hYQa0kKnXgEyKk/hQne+aXocVTXmvmyjVO0Ehw==
X-Received: by 2002:a05:6214:c24:b0:709:e095:128f with SMTP id 6a1803df08f44-70af5d0539emr51369616d6.25.1755179706213;
        Thu, 14 Aug 2025 06:55:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c0d80fsm12601116d6.80.2025.08.14.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:55:05 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:55:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rostedt@goodmis.org, surenb@google.com, peterz@infradead.org,
	mingo@redhat.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, andrii@kernel.org, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	yuming.han@unisoc.com, ke.wang@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH] sched: psi: Add psi events trace point
Message-ID: <20250814135501.GD115258@cmpxchg.org>
References: <20250814070719.865-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814070719.865-1-xuewen.yan@unisoc.com>

On Thu, Aug 14, 2025 at 03:07:19PM +0800, Xuewen Yan wrote:
> Add trace point to psi triggers. This is useful to
> observe the psi events in the kernel space.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Can you elaborate on a situation in which you would use this?

> ---
>  include/trace/events/sched.h | 5 +++++
>  kernel/sched/psi.c           | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..c23cb2bc76fd 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
>  	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
>  	TP_ARGS(tsk, cpu, tif));
>  
> +struct psi_trigger *t

Missing ;

> +DECLARE_TRACE(psi_event,
> +	TP_PROTO(struct psi_trigger *t),
> +	TP_ARGS(t));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */

