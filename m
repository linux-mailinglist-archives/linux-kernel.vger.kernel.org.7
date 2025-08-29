Return-Path: <linux-kernel+bounces-791293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C51B3B4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AB13BA586
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C428505C;
	Fri, 29 Aug 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6fG85mz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F12848BA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454012; cv=none; b=Vumox01nFBqbL69Nod8MOPtQWZ3MAWZ6ESe4RtJ9pG/GDH5BCXhewxUEbGshGlOmDZa3gufc+fdi7X+pAv4I3RxVcmZT5Ip7Y1qpZCnrQewMf/IIeKTTpKBG4E4LbQ1w4mV0hLbmjcxzv2xiTTjSoQaor047PCmjZ/+P2fO41V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454012; c=relaxed/simple;
	bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DskdQcQPxhUYe+d3caQAg2AtlIqI2Qoj1cqUjLOtUFTmIXv+7mBz2v2MeEgIXQYb/I4ceduxk9JHehJGTC5lUHes1naiUVCEjqI0S5oI+ndRebZnP1+NW4tFwKp1b60EnXOgjH0CQkwHZDPtdSKQyhrbtk/X0oor6GsJq4ma3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6fG85mz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756454009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
	b=I6fG85mzPPqORtloFhIUtZ00aU96L6IZ29EjYw0zx0837Iq29RHktTZmBlxzn3OlSBzWWo
	QxTmPWiM2LKSt4+9HtPKv0CdDGvgtQnC6QoIzo7k3J7p5SaZV57QdMULNz5cYWXjH/a1xf
	pFCZrs9gWE57OgJ2HIPezYMac0q0RWg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-oQP1GN15PEGi8RRrvTPu5g-1; Fri, 29 Aug 2025 03:53:21 -0400
X-MC-Unique: oQP1GN15PEGi8RRrvTPu5g-1
X-Mimecast-MFC-AGG-ID: oQP1GN15PEGi8RRrvTPu5g_1756454001
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7fc5584a2e5so171454885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454001; x=1757058801;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd/Q4wK5Af44IVTmRDhb0IMpmen0zove7usKL1pLP5w=;
        b=DzoHU3XLNgKPD3Zlj0k7M5GxwWNWX78UrTMyuhDZLcYvtR5oED7DOZa4VIcxddgU4d
         BAXbhqlJh7MITMT5Uq417e+oomL/CXmeqngD2eJN5m1jMSKQyyEGqU+WrlMl8fYuzq1w
         nV/sCxgwh1pHt1jfbnyt3qBe3kx8WjKqO4T/Ole8xNGttcal5vJfUwnZLOU/TAgAZ26i
         PC52RlDSxHzTcqw8PhCVkGGSNWVrGxsIknkvv3aRWkFEctABIIEubEnq7R6hb4M2RCaW
         3Or9MwQXoHQO2Ci3fsTrqkl5QUmVABnXXqx9LJuw86wHcrSOLbhD467ZYOsf+PcMvbQv
         QGjg==
X-Forwarded-Encrypted: i=1; AJvYcCW/+KD5EPi6j4kEbJ/LU4DrgUHBC4DtH0tB7GovBALZh9UGF7epmfE7rWU4bh7RbqaZCE0PDnQPsFuuBqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9jJDtodFDOChbTUKWNnlromH2cqllfT7sS86+w3QZbVgvuWH
	thfjiqqIG5+SdHBP3N7EqdnHyUJnlW0DXbxk9NsRK+nXt653V9GeUA8SWB+Uv/LVaymK0rH9a83
	VDfOBingN+CIUbo46drFy/O9vFDSrtWXcXR+qclsZZ4cmUGMApzTPB7DWTILCWoQ9IA==
X-Gm-Gg: ASbGncuXK64df2jKcc1ayzUrmxFuA7pBt7QdlNsSKcP4Yza4TUAyuC1Rm5oEPTwSLPh
	qEbPYeGlQHcSOPPJFAkwgdrVMwx2IJsR6Eb/VAWPD0VICQcOF49ByIQA0iF18N9PgdXx5XYjHif
	0KVrt8nAvnk77ECLEnAeL0L0zVubcF8sLP8/U4AFJQo1aD0vxQOn1f8tHJTWHStScBtU3kM9W6G
	7pn/r1wOuWCYx44P82V2W/meHreQIZAPodtSweSO7zGTqfN30qzLSNC5KAdlvjEL0bi1o2V2NT8
	IFicO6QI6v3j0jlw+Ay54d84HSU/Oa2qoO89fJPHvIRDpFrgXqhJYkvNqARctUQrvgbtSJzTX5o
	adaj9q+DQWrsWNa7A898gTt21
X-Received: by 2002:a05:620a:3184:b0:7fd:2801:11c3 with SMTP id af79cd13be357-7fd280114e2mr79778185a.17.1756454001389;
        Fri, 29 Aug 2025 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9OYt/OUzYXYXQDHJZwPmeAhxWwWDVQls1oZvlM8N0wCLdQg6ik5gqoc+qY2nFzfns/uXsYQ==
X-Received: by 2002:a05:620a:3184:b0:7fd:2801:11c3 with SMTP id af79cd13be357-7fd280114e2mr79774785a.17.1756454000877;
        Fri, 29 Aug 2025 00:53:20 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc066657fasm134986185a.0.2025.08.29.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:53:19 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde
 <sshegde@linux.ibm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>, Bibo
 Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>, Tobias
 Huschle <huschle@linux.ibm.com>, Easwar Hariharan
 <easwar.hariharan@linux.microsoft.com>, Guo Weikang
 <guoweikang.kernel@gmail.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Brian Gerst <brgerst@gmail.com>, Patryk
 Wlazlyn <patryk.wlazlyn@linux.intel.com>, Swapnil Sapkal
 <swapnil.sapkal@amd.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Andrea Righi <arighi@nvidia.com>, Yicong
 Yang <yangyicong@hisilicon.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 0/8] sched/fair: Get rid of sched_domains_curr_level
 hack for tl->cpumask()
In-Reply-To: <20250826101328.GV4067720@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <b64c820d-084a-40d9-bb4e-82986b9e6482@linux.ibm.com>
 <20250826101328.GV4067720@noisy.programming.kicks-ass.net>
Date: Fri, 29 Aug 2025 09:53:12 +0200
Message-ID: <xhsmh7bymlg2f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/08/25 12:13, Peter Zijlstra wrote:
> Subject: sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 25 Aug 2025 12:02:44 +0000
>
> Leon [1] and Vinicius [2] noted a topology_span_sane() warning during
> their testing starting from v6.16-rc1. Debug that followed pointed to
> the tl->mask() for the NODE domain being incorrectly resolved to that of
> the highest NUMA domain.
>
> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
> set to the "tl->numa_level" during tl traversal in build_sched_domains()
> calling sd_init() but was not reset before topology_span_sane().
>
> Since "tl->numa_level" still reflected the old value from
> build_sched_domains(), topology_span_sane() for the NODE domain trips
> when the span of the last NUMA domain overlaps.
>
> Instead of replicating the "sched_domains_curr_level" hack, get rid of
> it entirely and instead, pass the entire "sched_domain_topology_level"
> object to tl->cpumask() function to prevent such mishap in the future.
>
> sd_numa_mask() now directly references "tl->numa_level" instead of
> relying on the global "sched_domains_curr_level" hack to index into
> sched_domains_numa_masks[].
>

Eh, of course I see this *after* looking at the v6 patch.

I tested this again for good measure, but given I only test this under
x86 and the changes with v6 are in s390/ppc, I didn't expect to see much
change :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>


