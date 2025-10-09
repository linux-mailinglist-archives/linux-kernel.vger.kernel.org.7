Return-Path: <linux-kernel+bounces-846903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C5BC9615
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AB804E40DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F72E92D4;
	Thu,  9 Oct 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYitykHZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509D2E7F02
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018056; cv=none; b=opeJYX2G+d3mofQpJiAeCqqOd7ArL730knh51nNjC/zqsYastcqqj2TlxSkEm9ZAmpRDEr7OrKxKrMxUbAmU82QtvnGEKI9T3PHo/t/PdLcivi2rusXvhwggSbOFvAUnD680vp5BYOB4F4m84sGEInJ2dxQLNud4+AAf5wPyI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018056; c=relaxed/simple;
	bh=TdGo8TYPQ0gR/fS1GEwL0EPX/a3UdVGgA+hZAf40w+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVjA0rOewPoaZlSduxlXA0JCJUIIZ5xZGSY6no9E7X+qcr7Z3/qr6OBn2YiZde0BHrLeWFEcqApG0JTvOhThjEqhpzrpnOC6OUGHfYuDJZKEoePe+kbTwtLoodEchsfpWTvRAZs1Zy9ePl1MUnskP561E+Cx3ZIsbe7y8reGwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYitykHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760018053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8cEwoHwzHjd3BLR8ExQK5PGNIYBuC1FqGQKBGcp6So=;
	b=iYitykHZHZpiyIVvG/HbcMqpag2PuuWfU7XCvMxxyzpeXj+OW0Rm72ZlajRev6Hlavj+WV
	0o1BCuyyqv4o/hKGLhe/ssV6FCZj3S44GthGOhWPB5wmJFhUmru+9S8E6oyG9OK5cMx6j7
	7yYFtTYcLbv2mkpuAwwrph2SENu77Bo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-djhTlPcXOde8NSmc3OT-Rg-1; Thu, 09 Oct 2025 09:54:10 -0400
X-MC-Unique: djhTlPcXOde8NSmc3OT-Rg-1
X-Mimecast-MFC-AGG-ID: djhTlPcXOde8NSmc3OT-Rg_1760018049
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42557bdbe50so1208693f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018049; x=1760622849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8cEwoHwzHjd3BLR8ExQK5PGNIYBuC1FqGQKBGcp6So=;
        b=pGJGuT64Vj8GqI5UTIQ7ITmdDMfiN/9gTDMPQnIP/m4qy4hW3A9HunzvFpIvoZaBkU
         9rCVhk9UyKUq6mfMUEPKT/24yqN7GfhKwFK9zqSjyGxPirWViTWZmq2bLPwVtE1YGEWV
         +LFTBzkjGu9b9840XqsCFr1Z4fLRigpAa+x6rkFiANILcdMTNqcVuoADq3/8JTfX8JPd
         8fENv3p/4JFybnLzpe+Cpv2fhT0/1B8zBGbkxCtWRroD9yB6fvz+Cq1cufN0cBuCC5c+
         Gs+1UlYiX7J9yzUxoRQLkPqLEqPtiIJKhMD5FFG4fE+hzS+ipG+6QX5RWHvHwOQ/xCfE
         z6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZ+XDMnMF1cBHzS94dhk3GMSRzn03QcQV7jPIuLUF8mb4xoXRIlEP8RI8fQMI4YuUgELkRnHbn+bWCHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Qf963DnBSmbjCOoaFiQVbhPzjh2NpkJ2tTAMqQjhhL2Z1AT9
	cEb3j4VW2jqSB+o03S2Z4GMnE0q5kRu0vneybtCKVGkWZD7S+umSUuSRLxKFzaG060RDd4Pajag
	J3IRYG0u1Q5LAvX1i1kqfweolGbU9+Ai8WJIEf4cT24VlqD5Hf8rhlIu1dlvwxgYSow==
X-Gm-Gg: ASbGncspq1gFmutDAv1UXL/O+LMyStqOIhXl9PeBOfKguT0i0CMHf5T80LX2ClLShi+
	dnV7NtLifvEEps8o+ZSxCmcf5uxqzT1WOjaCApTa0seOYwzVxEZgFdtH2dwJQ94PoH4YZawYClv
	5/k+HV0TkNOs9csYiCJPLkI8tuqjVYpnMbk6dDBotD6H5JGGzK6tIuhKYIs+WVAYJ1Tcmz7oOCC
	Kruf7AevPeVKukXsf5pJslDm4ZL8FJFytnBB0u+4eOvkZMwYHY4GsBS1sWlRlCvrM9FKtlSQw4p
	/zIMD7bIh5GrkPnzH3X33X7d++kkAn1mXciSWm4vs/Akgvfz+Tnkscdmczl+O4m1PDshZTmnbh/
	3sA==
X-Received: by 2002:a05:6000:26d1:b0:3fa:2df7:6a0a with SMTP id ffacd0b85a97d-425829ee53emr7408965f8f.22.1760018049332;
        Thu, 09 Oct 2025 06:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ/8MsxFrzKCmHq5d4yjkcV7RwIUXvn1VDs8nPuEzaq9UOMUEaZcxzNaixtyucoW6t9PGXSA==
X-Received: by 2002:a05:6000:26d1:b0:3fa:2df7:6a0a with SMTP id ffacd0b85a97d-425829ee53emr7408946f8f.22.1760018048952;
        Thu, 09 Oct 2025 06:54:08 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf11197esm51253935e9.6.2025.10.09.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:54:08 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:54:06 +0200
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
Subject: Re: [RFC PATCH v3 14/24] sched/rt: Allow zeroing the runtime of the
 root control group
Message-ID: <aOe-fqaL3uP6ukCq@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-15-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-15-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> In HCBS, the root control group follows the already existing rules for rt-task
> scheduling. As such, it does not make use of the deadline servers to account for
> runtime, or any other HCBS specific code and features.
> 
> While the runtime of SCHED_DEADLINE tasks depends on the global bandwidth
> reserved for rt_tasks, the runtime of SCHED_FIFO/SCHED_RR tasks is limited by
> the activation of fair-servers (as the RT_THROTTLING mechanism has been removed
> in favour of them), thus their maximum bandwidth depends solely on the
> fair-server settings (which are thightly related to the global bandwdith
                                                                    ^
							      bandwidth

> reserved for rt-tasks) and the amount of SCHED_OTHER workload to run (recall
> that if no SCHED_OTHER tasks are running, the FIFO/RR tasks may fully utilize
> the CPU).
> 
> The values of runtime and period in the root cgroup's cpu controller do not
> affect, by design of HCBS, the fair-server settings and similar (consequently
> they do not affect the scheduling of FIFO/RR tasks in the root cgroup), buy they
                                                                           ^
									 but

> are just used to reserve a portion of the SCHED_DEADLINE bandwidth to the
> scheduling of rt-cgroups. These values only affect child cgroups, their deadline
> servers and their assigned FIFO/RR tasks.
> 
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---

Thanks,
Juri


