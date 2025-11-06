Return-Path: <linux-kernel+bounces-887599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DCC38AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2390C18888EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCA18C031;
	Thu,  6 Nov 2025 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="MBzR66ys"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488717C21E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391755; cv=none; b=UA1NsihttLUMaAOAjCK5n0ercxACHBrJG0QMQkm0xREKTwxU1C13sqM+x7MUGIRQNJtZYz9o0HAvPhEIjjQm8EJf8kI2LvCdkTcwfpAsbIh3QPfW9NC5/sVb3r/ynB9Btu0pXgiJQreN3K0RS3w/SNp1cetCE69kSLdmsyFBt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391755; c=relaxed/simple;
	bh=rWJD7fOJucZBRBNCdl9FSeYqDAYjblAO00u6gYjtoFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auxWSvt9Sn51ggE3pofdNc2d+XaVdHL8vSFbSsDJgqCyJit+ejhj7KtmAEmbyIJh8DptAICM31MSIYwBu1NyboKPrp+T6JEQrsU4us3GikEOXUDRp9LC/2v8LE42A9pb5emd9zTmbQfczbyvRdyjh7WleQZ9VTw4Iro6Yv0G69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=MBzR66ys; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2955623e6faso4309485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1762391753; x=1762996553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRsgaC8ss8dReHk3FVo+RoaiM02EzQKn4ozr1E8wmPM=;
        b=MBzR66ysOhf87KtSBBmg+Z2d/DMIObKcpbcZP8F9h4WyVfYvYMxftu5kIiHfY29rwD
         BvvtN/V3tE263k1uc8KCJaYNGiMR7zTr3se78CNq6rBsMbgA5x2hPzEM86LQaAICLceK
         YXljQY5E+y59t7h82WKRitLKaHfqyGTu4WPD3B/zjsPKUKIfYP1PpOdItkinb/jtxfC7
         bs/42L35E/rn6GzBk9vTZGPYPK4ynngekvlGkhdIgxIx5f5y0L5EKdlbtcATlZMLyA+u
         gW6zyDI5Tj96kKNaQTGKVQSC+Q4wFHOLSpzUAAzPoYuNcle4mq76LZ3mRcfLyATMQPqC
         VDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391753; x=1762996553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRsgaC8ss8dReHk3FVo+RoaiM02EzQKn4ozr1E8wmPM=;
        b=dpJ3BtilcglZjCh07+zQF0ddn67E+xHuqc39VAV7M/q/lkzd3RfTlmpY3zhMBIjiCm
         L3gMnbs7ROZggxz9IsVVJaJY4tggs5N0MDibT1IcbXa3qGkfkUHCKRslgE3Nj2q9AGc7
         11h+t07/3mY1OtJNTIc3eXLkkjqhCb06oi8SNt+7C05sHNDMRzuLczaJE2XPQYfDed9F
         hOjZmOcb87ZEkTFHLnA/SV/x4ESmDiW0+TCWU/FWXH45mpNWALntdrU2ZqKbCvk4W4HN
         5jinabucf7n7UXZPpCmciqzQEZV3POe38QNbBGA3Lg0/9awIuPB1ZS/ZOc1zVVJZlO7I
         /KfQ==
X-Gm-Message-State: AOJu0YzIO1BbTZ/2Zv0ojvE1/ryq7Xgq3zoQEKF+7vr2jplQNI1FlpBb
	FgA4jtZYTKL7QGT9hv94UjJkmVXs+MSw1MO8ccbBcpSXt9WreBUhKYany8ETJP4SW1Q=
X-Gm-Gg: ASbGnctClZpDWbPeHXpcT8HTk7n/2v0baqRp5C432PdJUy26AsI6xtNZ1cOUuTV9xSV
	xDVTOaVgXMKJb33rOZv3rqddzcR8aOC5W4g7mr6Bs3/3ngudKE9oRZHcu+O1xUoWpeGGiaaoe/D
	tbFLkx6CuYXw9oZ7LK9KaKz88Xs8sV52B345J3MJ0Ghm66MjtBVH/KI7qldJO0xJVwZJW1BQArs
	qN88dGXAOoGf0ZLd7qeB+7pkt6USiyzsCx/IDs9dsMHY9Nq7nm1Y5lvPv0y10HudKZmlcKb5h7u
	qYecHpB54gGRjLrLOGnDkN/+usyMlDQ58agwtrU1+rXdAXmTA0Y3bQvK5c25SpWk16JFar6zc4I
	REBrqaW+fqc7qOzw6EqFeh424SxsaeNydhdnh0va2LRNehIoFbKJUE+rEcuLjXVn8MhjTZVUxVg
	xk/GhSZCLtXCXM
X-Google-Smtp-Source: AGHT+IHvZ/AAdyAs6Mh/pOF8WKt6clsCkXL7NjluIbdhCby5pW67go9BJd7r9RRWaIq4lwntET7pGg==
X-Received: by 2002:a17:902:ce04:b0:295:54cb:a8df with SMTP id d9443c01a7336-2962ae4cc76mr74019175ad.36.1762391752967;
        Wed, 05 Nov 2025 17:15:52 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm8020715ad.108.2025.11.05.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:15:52 -0800 (PST)
Date: Wed, 5 Nov 2025 17:15:50 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <aQv2xkFKWTdU6xU1@mozart.vkv.me>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQufmyZ7X7NdfiCL@slm.duckdns.org>

On Wednesday 11/05 at 09:03 -1000, Tejun Heo wrote:
> cgroup_task_dead() is called from finish_task_switch() which runs with
> preemption disabled and doesn't allow scheduling even on PREEMPT_RT. The
> function needs to acquire css_set_lock which is a regular spinlock that can
> sleep on RT kernels, leading to "sleeping function called from invalid
> context" warnings.
> 
> css_set_lock is too large in scope to convert to a raw_spinlock. However,
> the unlinking operations don't need to run synchronously - they just need
> to complete after the task is done running.
> 
> On PREEMPT_RT, defer the work through irq_work.
> 
> Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Link: https://lore.kernel.org/r/20251104181114.489391-1-calvin@wbinvd.org
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello,
> 
> Calvin, this seems to work fine here but can you please try it out?

Works for me, no splats with that on top of next-20251104.

