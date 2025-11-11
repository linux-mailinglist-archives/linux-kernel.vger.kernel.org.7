Return-Path: <linux-kernel+bounces-895768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4318C4ED94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E418318C3989
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC142364EA9;
	Tue, 11 Nov 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfQHDM29"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079E311583
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876095; cv=none; b=Nr66SgXf+QDhhYB3y0Go4Wu8sfxmdq53NzH3AOPhMRKKsLApJ/+q0tALPeRiP41YP1qmhDtQSVq0EIwZodD/7eEi4g5FkUcQHEO2+1/1k4GyvI53xj8HnBgX+ma9aj/h6Df/YLcS5OusHlFVGwqw5SwhYAOQpRUVYEqE3wkzRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876095; c=relaxed/simple;
	bh=2YsMTLpmOLn95OEADZmPKaAxC+FcbQoGHx2UChouhRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL9biGLfZ8E8xdklY93xMPCRYB3YuPHTuvvPcgJu8osZ9GrAFtBtZWIH0inIzqNTMD5AMHHZB+UrgL9l0EQaAkHmlcIPIW6v0AHxhY4PRIbbMcLcRX/Xu7Mo2mhGTVZzfW4OGcLJbY+jhv81xLV/OYM2TPt3BgpSzCWRrhTGi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfQHDM29; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2627269d5so340437885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876092; x=1763480892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjo+6EqMgK5JhcaDAg4iVPh7lPSM1/wDO/zr9B2pTG8=;
        b=IfQHDM29AF8g/g7sH6xLfqedCFeVJJzVxzp/olC3kOSslq9KJQySMZqyp96KdnCoQc
         79TU4MmjVW5q2p876etWuh/NUL98rhljTclqPxtzDsaf8oAJxpos5T9Vz0JChTpzlVPw
         zH3hTe/CmTY9R18LwuazryKTwjkexd9auRwtKWWN6Lgm0XGpfh9oTPEl7Z73ZSBjo4In
         X08cxktKDqg6K5VSXXYyhEKzqIrgPQrl6lPDHg1laNR+7FbAkGYcJhp0Citr9ICtwIGU
         hHoteofx+rqa5TtxQ0zhUqjzL8rRS/nY7Q0jT8cKJ0F22HmyWXteHaZztPm5ye88ly5/
         mb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876092; x=1763480892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjo+6EqMgK5JhcaDAg4iVPh7lPSM1/wDO/zr9B2pTG8=;
        b=m28KHz6qrcvCc1RS+stn4g+9q27ULnk2zCiotxuLyrie+BgO3+GJTfEfnRh3MAJQgM
         OboGnCc8r5omAIlF5UMxum7AtDxRtoGRbGi3XtCHL5PLSs36Z83YIWDGZeH1ld/faFcp
         /NOInrYAp3gKFZ8dqSUgFjF/TWuY0VxkejLeJafs2Z9k+gstb4dLrhauz3/WsRou2UAj
         PGHx9ErHJrhRJJZKscEdp7/W72Z8txcaW8QGn7Lviuola7mnaQoaBsxABbSC8KZtRFt8
         V8CMNPBQXd/NWgUHTI+zIbPXxVgzClsovg/gz75ynxi6jVUfILv73Sy0tO2IfTiYpD26
         UMJA==
X-Forwarded-Encrypted: i=1; AJvYcCWzu5otGbSngguZXoTiwcIM56N2lfHia1WkMzPd0AJpA/fqFDtXuYIyV08lBthwu08ah1gYrvMTXNYrtBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWByUhTB4xqZU5jmd09wbl5GumHF6L9hUPs4ge5uVUg8XE0Ah
	9c4TpRmxKoA9v8CAcF3w21eOhLiI310NMt7TEhI1kj6bXpr/WPQVS5lj
X-Gm-Gg: ASbGncvKxTZb3fRHH9cEYM9uy5ShghPZ26+DZoDhXpVs6Y/diWEUQ+RVOAkbTbK6tBo
	K5HyAd8GlQuLdyqBTTqm5b81tv7JBAQBj2BpifHdMKmvRkIPY1gC1S96ud9d4zJHM+qS0EUbS3A
	WJNRwAve8Cwnx5v5MRnWI6ymiIuekDvAavRLvKzTDNSvaR1xA+AgNSAsiI5+g0ZdUU6rIJUzO9k
	ahJBEftu2NODI4Z7O4f8fwn2yg1j+HUYgyttTjvnfJJUrI7t0Xfx4M7KfPdgHa/PMTROe7NR5XQ
	bGgbyqjFGJKqkTylzKqgdw2CAT44QWkqlybjZXTixU4TtwKsRTpGQscFkRDhHNtC89rGbKslJP9
	euUphz176S9UN9M2+VhrN0k81qAsU3mWCTsx4hVonWwelpQBk5IJr9Ag/6rX/3xoHX6Xk2g6zn9
	ifYyaXKkTw7t8TnQ==
X-Google-Smtp-Source: AGHT+IFJ5Gk9VZ95D4A12JbFGZOYydzV7K+WeCJvr4ZyANHVoUa1GE7mGCggYVoDXWOhm8w9/nF55w==
X-Received: by 2002:a05:620a:1982:b0:8b2:7ba9:8cf8 with SMTP id af79cd13be357-8b27ba991f8mr817713185a.42.1762876092576;
        Tue, 11 Nov 2025 07:48:12 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa00850sm5607885a.44.2025.11.11.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:48:12 -0800 (PST)
Date: Tue, 11 Nov 2025 10:48:10 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] sched_ext: Make scx_exit() and scx_vexit() return
 bool
Message-ID: <aRNaupq88QaAoE5_@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-8-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:06AM -1000, Tejun Heo wrote:
> Make scx_exit() and scx_vexit() return bool indicating whether the calling
> thread successfully claimed the exit. This will be used by the abort mechanism
> added in a later patch.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afa89ca3659e..033c8b8e88e8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -177,18 +177,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
>  static void process_ddsp_deferred_locals(struct rq *rq);
>  static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
> -static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> +static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>  		      s64 exit_code, const char *fmt, va_list args);
>  
> -static __printf(4, 5) void scx_exit(struct scx_sched *sch,
> +static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>  				    enum scx_exit_kind kind, s64 exit_code,
>  				    const char *fmt, ...)
>  {
>  	va_list args;
> +	bool ret;
>  
>  	va_start(args, fmt);
> -	scx_vexit(sch, kind, exit_code, fmt, args);
> +	ret = scx_vexit(sch, kind, exit_code, fmt, args);
>  	va_end(args);
> +
> +	return ret;
>  }
>  
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> @@ -4399,14 +4402,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
>  	kthread_queue_work(sch->helper, &sch->disable_work);
>  }
>  
> -static void scx_vexit(struct scx_sched *sch,
> +static bool scx_vexit(struct scx_sched *sch,
>  		      enum scx_exit_kind kind, s64 exit_code,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
>  
>  	if (!scx_claim_exit(sch, kind))
> -		return;
> +		return false;
>  
>  	ei->exit_code = exit_code;
>  #ifdef CONFIG_STACKTRACE
> @@ -4423,6 +4426,7 @@ static void scx_vexit(struct scx_sched *sch,
>  	ei->reason = scx_exit_reason(ei->kind);
>  
>  	irq_work_queue(&sch->error_irq_work);
> +	return true;
>  }
>  
>  static int alloc_kick_syncs(void)
> -- 
> 2.51.1
>

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>

