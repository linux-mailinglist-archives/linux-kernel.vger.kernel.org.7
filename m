Return-Path: <linux-kernel+bounces-768823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D7B265EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421112A0F31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57D2FC89A;
	Thu, 14 Aug 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8Wfiok+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127912EAB9D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175887; cv=none; b=qpsEbvtHXLHbFH+u5j8ii8AAnV9UeOJrXok5oh9qhL55MtaiDxpvD/M6I+wXmaJHOwjH9dNmw+E/EcEnkyI+FeZ0LeCL2ICjhR867lZsl79VMZ14H8+zXipBAaSi8mI6UP1ll6hEVuZOgCYHlksivd6IzxBbhZ3odTTPIKJZ8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175887; c=relaxed/simple;
	bh=Y+DCvJyCn1+5H2U1n2OFd5C6MI+p2rhRKZ60J12j4C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5tDtoK8OxCCct5yars41/P0B/9OaiIDk5bEDZIUa7gXzqXHEbQde3yADt0ZAzLkR1CbPmBpgkeb/D6HXPBWRGxsv1prwR+5XPukYg6hnVFRgzwRglQM7N68VRlEDEwgH3Zfp8hrnX33KT7j535TkEiMi81g2IyH7e2eOh0IAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8Wfiok+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755175884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4W5+FSnPHxvGP6uuKlQ3woMBstxNWGEX1P81myxCppA=;
	b=U8Wfiok+/zbgoi7NlYfDwSG/Gwzc/67TUWbU2lmxXU1gof06N1jVOjNz8Lthspzdvb2GjI
	gJ22dKWB/F9u8o+Uxf0hRd+di+l28gPbnmO0L0Ynj/cCChJFI4j11PUI7GqR1er8hEJ93X
	d+jy1VI4DtjvacUwCUX8j+dMD5h1fqw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-479lxv96PrKBmcRFrM292w-1; Thu, 14 Aug 2025 08:51:20 -0400
X-MC-Unique: 479lxv96PrKBmcRFrM292w-1
X-Mimecast-MFC-AGG-ID: 479lxv96PrKBmcRFrM292w_1755175880
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9289baafso18887246d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175880; x=1755780680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W5+FSnPHxvGP6uuKlQ3woMBstxNWGEX1P81myxCppA=;
        b=ZIiYo6CmQxDtFtInd/aw8fxBCL8m55u1pnula2roltzK+PI14wSRnc/g6KJwF3b9D+
         n/AC2dDPmbL+dWjqUIJRuCyuDSnlo9pVzU6BBJ3+qXkAnh+3KW8qaDxErlr9FoNatwXk
         JZKanKgRTcagR9F45P2N+/d5ulTmvqUGzFjfB+Xpwm0GQZMtiCVqHentAzHIPkeYupHz
         1bVo4k+dCZRpL2fIwwoIc/dmOPc0DeDtOZm8OuOGrbOjXrQJKzKUt6HrQkwZBDlBhtun
         pSTf3bFZb+M+Dkk0NCmodzvWa0D3FKHMRz2h9nEI5I9xJKVzPmB3wfhYHf8kq37sfDXf
         KpJw==
X-Forwarded-Encrypted: i=1; AJvYcCXOJMDDr7Mmyt/RBNtSi1UeobYwXLa/PQl3oI6/+btNwXYzJU+66jSTwwvilkZqvLGRn6OK7SCGFV+2pnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybs3VrfyUHyKE4QUab7BUwdLdVdv/tuBW+Ma6KtYjeO2c5dUyt
	6jMC9iFiXRz4Izf4uBfVaLnCEn+NtwQnm7GPCRuJUuloRicuDJeye4AdhSKR92RgdMJKQxqu/6L
	BLEMAuog5K+RTt//4rVrkqkNe553101wgcqrdKN5g54bjna9gjiwP29WkysNlAxxMYw==
X-Gm-Gg: ASbGnctAkXmKsFJVF+bNNFv0Xa1NRXEcafoDGk2UqNQP5IXu37Pul37lcVVsk39Oy7u
	NKDjczptOh7bzkMYvBLoEEvAr9O2Xi7At4pVmw4OvkCCYtY/Ys2RGLLSUDw/1qCpf8dvFUhiiDH
	RBYdbBTdOW2fnZdJvDoLTW4pF3wDXEqa+baSude52LYehDM7NIyFVxhpBeYu8dYlq6tlNF8jS2w
	ocMkPFPCjqyU1ZeVS674+/TNZT8r7gLH9fXcQnvpwrX9W7tZvcUnSnwZwzRtU0qnhe4kvv0pOiz
	FZ3Qz6RTrIuRpd4YnzXwYp4F7fFX/3lnWEtxKqlPrYezrFyb3my6ZCl2glcl4DhiJorw1g==
X-Received: by 2002:a05:6214:ca4:b0:707:2b04:b038 with SMTP id 6a1803df08f44-70b97e5f5dfmr37432006d6.23.1755175880065;
        Thu, 14 Aug 2025 05:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4RWnlJE216hwe1dZT5/7NYa+bee4GOVVMk3QIFG0Uli5iDUUNbONg8z3Pv+VmQ2AvMMS9oA==
X-Received: by 2002:a05:6214:ca4:b0:707:2b04:b038 with SMTP id 6a1803df08f44-70b97e5f5dfmr37431676d6.23.1755175879742;
        Thu, 14 Aug 2025 05:51:19 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70adc1d4ed7sm12446776d6.16.2025.08.14.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:51:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:51:12 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v2 07/25] sched/rt: Introduce HCBS specific structs
 in task_group
Message-ID: <aJ3bwJ5eRtjffd-u@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-8-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-8-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:

...

> @@ -467,9 +474,15 @@ struct task_group {
>  
>  #ifdef CONFIG_RT_GROUP_SCHED
>  	struct sched_rt_entity	**rt_se;
> +	/*
> +	 * The scheduling entities for the task group are managed as a single
> +	 * sched_dl_entity, each of them sharing the same dl_bandwidth.
> +	 */
> +	struct sched_dl_entity	**dl_se;

This is actually one sched_dl_entity per CPU, right? If that is the case
the comment is a little misleading I am afraid (mentioning single
entitiy).

Thanks,
Juri


