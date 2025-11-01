Return-Path: <linux-kernel+bounces-881166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055FC279D9
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444BD18993E9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA629BD90;
	Sat,  1 Nov 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfrJOb4B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa4pWtfM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6067285CB8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761986640; cv=none; b=H7CjuZoc0Xcl3ga1sB08reLgZv9Z/dJlogX1dAFjxNESFIFj7qB/yvig1FAsnT328/QFkXqnVWT37ms6Jnj7neSKoDoFhYUf6eZ5ZNy+l7wwPj02/tX+VlcjKXcV5fczE1pg9xot0St7FelBWmKlDYkHllfTaFfWqtibtw40Znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761986640; c=relaxed/simple;
	bh=vqSBX4ZLTfcHH4WP6NpAV6KAQx1wO7zGlzS63hIjves=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ffG0brXbkPssR9TZ1q5KRsCXLrTRMKV9PazB6wIZexM9LF9nsA/pdS3y55mYVbkV/MaFFI8Mu/O63UZLaEocUIGYvikaRz1wKcXQ1R8KX2oTWYdWktqBUTVfKBigPtZf7qokbZbJlGeaSYiGoIQP54HnXQzqf/kXFMf1L9U8Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfrJOb4B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa4pWtfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761986637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqSBX4ZLTfcHH4WP6NpAV6KAQx1wO7zGlzS63hIjves=;
	b=UfrJOb4BIqjbxexEM0Ao7nSakEQptbqFKAeeons0FUA1UtGtFosklwm9Mc2Vg6uQfS8h2E
	N0PqY9qEMIrUmsa4OMAUvBPbmKyNRMbJ1GKg1QuNafFtIAzYBNQ9FPehHmB0CkA7e5V/M/
	HqdcWufpkXcaGrEcz8htZEyCMYgtOF0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-m5DS_W-dMDa2TPZSMkUHaQ-1; Sat, 01 Nov 2025 04:43:56 -0400
X-MC-Unique: m5DS_W-dMDa2TPZSMkUHaQ-1
X-Mimecast-MFC-AGG-ID: m5DS_W-dMDa2TPZSMkUHaQ_1761986635
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7051ea719aso356465966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761986635; x=1762591435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqSBX4ZLTfcHH4WP6NpAV6KAQx1wO7zGlzS63hIjves=;
        b=aa4pWtfMh0O4hIOE+vt5/E+CiQy3dG/EyrNgSX8QNhPX0whZviARVjN/36jlF99rUd
         VA4UkpfMXsmOJBd8vOOETwXUQnmgYNE1LSktGF/df2jw4JBMlNwIABoCZ3n73iv33ZPK
         OVQLmPEuas5DKdWrIQOSuLjX4AfGXDVdaRbMorCmVAqcuuI9nCxEGM5mnryIO/Z+szUm
         4KZdqtv++VnugxiA7kfSt/nS5kArgZf7/jMUr8UWxaxkGm2zY1EPJX4NdI+YvZbCvZQh
         nTt6x5DtlqQQyZH6OEFTRLk59pJQIuK3hpmJUEPZq6gEGSIoiVUKO6OvuAYp4VVZzGOT
         4XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761986635; x=1762591435;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqSBX4ZLTfcHH4WP6NpAV6KAQx1wO7zGlzS63hIjves=;
        b=WfcwtIDsbschYy3/MHNl9t+aFD6L4IQAUQcRk1GKJWywcvxHw6TUvMvd3wZruch7tO
         bM8+TA8vDRnLvqwB2aa7GAmET1UAi/WlWEoXFlsp9YM7EXQQ/296QMECGTRGqHcBoBQy
         RlkxtxMeoyB/LOl/UsFKQopeq/KDaYW+YaX4XcHHhoR7nMQ/JSTzdDVPY3l2JiCtF/qF
         nntbJ6KRCxl9TvgfjJ1LflXBcODuf1+3mT0/HEKC9Z+3GRDBvhYzN6taaGaHrXszlXPu
         jeeq5c7QPx6aiqppyN37/xU+Qt4Hs6EKiVfixuUQUHwS5mJauGRQuos4gFZBmsfNxA7/
         colQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0hFRpoDDJjv07NwsHv5sQZS5R37ozpwCASG4+9TVhp+yaSFclR/DzUSPn2KVq5bp2S5zLKi4gNBHihQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUECuyzUTd+l1FNT265qruGEcKtFLpdYoPiT6qhYGbsVUhVcWA
	VBOoaEGPwd0UK+sk0BspB/e4BXyfLFIp+kRGsgasxuVojN5mosLM/nmNBN4r3BngcZ+MUyV5tv8
	YhNDdCqWgQ6Qc6IPRseE+lCv7JRdCVkaufZU5pePJZv4ONrxVTLI2rg7CSPHTQ6X6Kg==
X-Gm-Gg: ASbGnct9mpMJ0Plne0iqYXyb9N11toY+pEubg2+yrfiHzEKQ5Ptt9jiFNJaBhGfDWmS
	lxKR0MaMb8qv+N3Rul+9Vsf6NK40ITROaz/wh7cUNKwDE+pyczu9NUjWuiSohSX5dPY3bJhTIzm
	R6PW5XpQG45UTpQtdBX1zm6DUA1E6JLQQplUkGUDnEXRNXhyDy35ayNg0Mxk4fhcNoMc3gLuw2D
	bTq3NDcTxCUf4K1HbdljF77KD5q1OkVIApGfWTF9dXWRo4/CHHifH6lzV3EmLV5YpVxWK8lMHaf
	6gsVC+7ahspOTZLYYamfH6+VCI08lweOBRTkOSo/wgHsf1uoAv0ajWhU4YdttTsjC2UJEM6PC6H
	iS8rG5bRNjp5dbsngiwJpEjGCyQzlzw==
X-Received: by 2002:a17:907:1c0c:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b7070137d1cmr773981966b.18.1761986635252;
        Sat, 01 Nov 2025 01:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYuwI9LkI1rg7DX7ovxnjZ2EeJY71ZMPTvBJYies+ChUPxcoh72u9lsyipR35Td8cio6Mzg==
X-Received: by 2002:a17:907:1c0c:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b7070137d1cmr773980366b.18.1761986634765;
        Sat, 01 Nov 2025 01:43:54 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-102-57.net.vodafone.it. [83.225.102.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a9124sm393085166b.16.2025.11.01.01.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 01:43:54 -0700 (PDT)
Date: Sat, 1 Nov 2025 08:43:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Clark Williams <williams@redhat.com>,
	arighi@nvidia.com
Message-ID: <48ee3f26-7dbc-4c59-b98d-f9aeed980a43@redhat.com>
In-Reply-To: <20251101000803.GA2212249@noisy.programming.kicks-ass.net>
References: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb> <20251014193300.GA1206438@noisy.programming.kicks-ass.net> <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb> <20251020141130.GJ3245006@noisy.programming.kicks-ass.net> <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com> <20251030184205.GB2989771@noisy.programming.kicks-ass.net> <20251031130543.GV4068168@noisy.programming.kicks-ass.net> <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com> <20251031152005.GT3245006@noisy.programming.kicks-ass.net> <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com> <20251101000803.GA2212249@noisy.programming.kicks-ass.net>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <48ee3f26-7dbc-4c59-b98d-f9aeed980a43@redhat.com>

2025-11-01T00:08:37Z Peter Zijlstra <peterz@infradead.org>:

> On Fri, Oct 31, 2025 at 04:41:22PM +0100, Gabriele Monaco wrote:
>> On Fri, 2025-10-31 at 16:20 +0100, Peter Zijlstra wrote:
>>> On Fri, Oct 31, 2025 at 02:24:17PM +0100, Gabriele Monaco wrote:
>>>>
>>>> Different scenario if I have the CPU busy with other tasks (e.g. RT
>>>> policies), there I can see the server stopping and starting again.
>>>> After I do this I seem to get a different behaviour (even some boosting
>>>> after idle), I'm trying to understand what's going on.
>>>>
>>
>> After running some heavy RT workload (stress-ng --cpu 10 --sched rr) I do see
>> the server stopping and starting as the models would expect, but somehow it's
>> always boosting as soon as it's started.
>>
>> Apparently dl_defer_running is always 1 in that scenario. Perhaps running idle
>> counts as running something too, so it never defers. But I can't really see how
>> this happens..
>
> The transition [4], will retain dl_defer_running, such that a timely
> re-start of the dl_server can immediately run again.

Alright I worded it poorly. As far as I understand, what you mentioned is desired behaviour when handling starvation. We don't defer and start the next period boosting.
What I was observing was the server staying running indefinitely.
I run a test with 5s of RR stress-ng and 30s of mostly idle DL workload on a clean VM. I expect boosting only during the first 5 seconds, but I see it also after, where there was clearly no starvation (system was idle, probably a bit hard to see from the trace I shared).

Thanks for the updated patch, I'll try that and see how it goes.

Gabriele


