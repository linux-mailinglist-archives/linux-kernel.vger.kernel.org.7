Return-Path: <linux-kernel+bounces-845541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C86BC5521
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3BC188D8BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616332877DC;
	Wed,  8 Oct 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOIB6p9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EF16F288
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931663; cv=none; b=raK/1GwkAwEXS6OGDlNkR3pgmdtI/Y+TnZBLSneLdNOv+TCRAvJnGIH5cX4j3W/I/kyq3Udhwf6gE/9fDCwEHwp1iqbV3XGTk4rmxAFcFTWxJef6rKxllYb9UBDdS3esbazVNwynlsFvgg+lVCCvUNctXHtPL8KGXyx/veCk19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931663; c=relaxed/simple;
	bh=Q2YXGjIR+rL8BrcfhhvKfyIjtqjvZ8rgOU/s92qDdFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJon+WCI9JNrHOhHDwfjbVw7efLmKKTY4bp41bPfV0fZWP9KTBXxuMP09e4ajXA8R3OoMqJ/sN6U8hJ0mfkZv1psiE8IAO4qFu9m7BEacF368t1BwYSpQfD1r9SdVmEDezb0M+YmjLhYH7wsH9qIYqFBWmk7d0zc+3pGcD7orjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOIB6p9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759931661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
	b=BOIB6p9aOtnRSdDUKW1S/EkmQkA+IcEVwgZAEWXF6Tw4X4HIW3WA2tpgcLyw4dfWfKUb+u
	d/SKIUSjo4X7wQVPZcgKBcP4Si4rvgHt65fwasBi800BjQNIuG1vFvtN2uqeYWGXOP4MLy
	zm4qwRNiGsNUcpUdadfFyCmwNrFFSQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-xZhaaK3JNrGumO9xujCKLg-1; Wed, 08 Oct 2025 09:54:19 -0400
X-MC-Unique: xZhaaK3JNrGumO9xujCKLg-1
X-Mimecast-MFC-AGG-ID: xZhaaK3JNrGumO9xujCKLg_1759931658
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee10a24246so3926107f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931658; x=1760536458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
        b=sUMreqdC17z1FZvaetMQMwSpcNl55Opl+ejUqZU08DZdqZiYYkI6y1vhELAAA5KEXV
         vgIjlQL2wkSOAQ+lClYrlxrMYBZXVJNB0y1qj7f0NFz3HqqcfOqS1sKdiJB4a5QtDO5b
         rII9DpxlTH208crPxWUyu19Z2Gei01toCcgGLN6Zbte8KEGZeGYcFo1t8VIKeMnvvw5B
         xIWu74A6+L4i7SL+xXS8v4+gC8jxai92amjv0PblIoWKkDA8f4XdiQOPNcjz1QllAqlq
         gz/ezxZtXwFH9lFPEwODVQBXoxD21Wo81qlppeq13lhNOeeOXT8dBrGSjl7xkHerT01j
         SKKA==
X-Gm-Message-State: AOJu0YycunYZ/mOPEySxesj/xNQZj/ik4Zk2Oif+jCZWHEt6vKOAf74M
	EvZZ2R47YI/YheefzhtxjPJMn1n96BKRwAWDgg8WFqMXZg+15w0X+v9CzfDdUD4JFg6l7LLP3nE
	GrFRJo/dA6AdQIq8S17kh6NbENJhA7y5JNmliZKYB+Jwyo4NN6v3RbnW3jvuAmIlBelW1OoD8uw
	==
X-Gm-Gg: ASbGncsivpS15Lzi40in1X8gs2em/vFsOOAQRObu8gVbc0ub1sYAWqF9CGW/aZFrHPT
	m3knnXWpl7I7tX3VMhT+vYJCCOaTzgNxEY7XV1wPkcJ0BZJNONeYeRIic7HTra28Xre+RHdUG3U
	O2dapX0htx4OI8xVnkFvYTbNdw0HHvwA7PpLEtFQDTczUBRYMRjkEFKriGuFgd434icmyJkhHPv
	kocnHRN0sCUIa5oKKt5rObaSeaExQEbV5dWdjJcKJDLyhtaXEl93KkJxB4lU+1I+fe924fHmZmZ
	cyVAGYPGHceQACH4iPPm5lixiNU1CkuHigQM9CchpIQEjI36QU+oU17zKZkb7ZWvUwm6VhIrQOo
	MLKdb3ZU5TsPed4p9c2lvmXyYUpG8isE=
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172149f8f.37.1759931657997;
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6pPCr5ooWIlJwPz5RcCzOYg/HVdYm9VLX5s4KNvCsNHbATSOR8rWb5OHNt2RclD3WmUKfOw==
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172132f8f.37.1759931657552;
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm30003416f8f.18.2025.10.08.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
In-Reply-To: <20251006104402.946760805@infradead.org>
References: <20251006104402.946760805@infradead.org>
Date: Wed, 08 Oct 2025 15:54:16 +0200
Message-ID: <xhsmhbjmhh52v.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.
>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>

Other than what's already been said, that LGTM. It's good to finally have a
canonical change pattern... pattern? :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


