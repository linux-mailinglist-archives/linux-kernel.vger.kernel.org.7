Return-Path: <linux-kernel+bounces-808113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76222B4D14E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5823A6184
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A032A3C2;
	Tue,  9 Sep 2025 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YA6yO1rp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBF321426
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419717; cv=none; b=FUMHktWgBc5g0XrPwxiwHV9YGQkCnUrqXnGbqVY8zw5iiuM6TNKKxJVJkbQlVD4FWh7p05ecmj+Gz8H3QHQqZu42SdDk4dlb/WHU/twgoJ4O96SuP7MV4eBdfwwh12ZwuxCGLlRDfLIvzKdcCGgWNP4MrIE9xNEJRi3ARzzkrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419717; c=relaxed/simple;
	bh=e2bY/7qkyaiM/i1NmIYcr9PECxFTLhoEx9C77uMaccw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkOe09xfdOREL9pUDP6qItZs3Nj3UMKPfpUCam8Us/qxerLEOxeBjtWt7Uzv9kixsaWuSCk9dNbqN2LQAGPL9+INd1kJ+KnhaY32KADJQ42D3I7SxmvCSw4o0ytwAHhbECD5+RRHhZoO+4AecttZOQsrotPCZRjET6meVH/rJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YA6yO1rp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1842013f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757419713; x=1758024513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7vDbC+h+/IIbH/cXwkOmZAco4ey3LkcdIeQn9K9PmM=;
        b=YA6yO1rpCt9mH5rn7Aik1rwu72oWsprZ6nTKcO3enh8WJfwYxniaXF9tjmxQmvnNUj
         UMUdmmk32rdYu8DkSp+AJDYvpZqKgzfTyqdmZHriavkUZ/uj4n26KU10gOmhYiYkAyqW
         /5rBgBA5lLY+9QiiTpJSWgfNaK3ajpTtxXRovDrVrBYEFc1sU6rjz4YQ2nK/FNnfJs48
         83e7SyuAJrYnt8nfmPlgJCM9NcUbKNFdncNe7S+REpPx+MXgoUYz2Z+HonR9itn2BDHw
         SEebZEX4xjTnmAdB4z6pYuRvUNFjHNmtZ/gi/OaD8w1Vb975+OZpCXyOSpjOC3WIa8Tx
         SPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419713; x=1758024513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7vDbC+h+/IIbH/cXwkOmZAco4ey3LkcdIeQn9K9PmM=;
        b=aQpvu5IBe887L06ZoCBq6XKiuUG+TZtVTwqHKVt/fvs+pxmlonQv9+/86hVnzdKw1R
         E3u0RMc4YdlVleizU8yIdEfKMiQdesf8eyzZFX38Kzcu2AngsLNSqmYENJ7D1rX1xonO
         lHsYpPiYYlZguL814EXfVFPX2sGCF+dNwoGowLHmwTUEt6mUC1rd54qjRFxu4ybkuZze
         L9Gtf4nuKZFVP6nYy0BJTwBBuXsVa6VHi3rXWx2S5K/9JgVmZesXwutlZMqz77IujG2Z
         fsaK8YNunWBwPqzTokqSD+7Gue5UuYZ1HnXfjZLUFb0gG9qlqEiDeIZXv7SK8xc1uUxd
         fl7w==
X-Forwarded-Encrypted: i=1; AJvYcCU664+/k05m8y6W+aFLOdi2F0uNKhbdJRzU72M/OoAnp+T/ybNXtfcEQOtZOmb/iZfP6BWCfb12DMcPg54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hXBPyO+GsEOJR5ORHR+pFfeep5uP74Wr8rNeA77ybCrOT74C
	o8f7RMns9KuNFx2sM3W0GEbvtFnV6hHOCPoVRv1EFLo1oturRXe6hU7xuznaCO4WEg==
X-Gm-Gg: ASbGnctZh3fXkIN8IYG7wFjmCWRVo+WfIl2dvi5SURVz4Yq3LeSAuCUCzuYjOaW4XCB
	dF0BxzNJ6Xuuk+FCtofBiWobHWFHuflgm7L/smChCdHI+1E/lgUSVQ/VvkcDBCVakdJTU/nir7K
	/4pJkXoNb01yWdRsI8XeRFPnPgAX5WooDUEEoylCvPhqBsKCC0SMx2S2O25QWbN+fSaaldHCA9d
	3DRijI5pMA3cf64lm9E4v9CVStLj7kRCGINzntf4xmkIWkwXDL1nEjXfjziK6tLdDiFyO6DZI7k
	nSKBhkujhtADX1Q72ZhxfgKf6SKQNSrVhbyR0VwDohmi7jdruZjXmRCfDjX4ZRcQWYlTOyAub7F
	fUQUdLyqZ8Up69XX2FV2cX2DMoppOAe/X9Z/W0HVj0GSqpctfHpqzQr7nzQ0li+RuJlHFtvTjQZ
	o67cUb
X-Google-Smtp-Source: AGHT+IEmpSA1PmUMsgcmd2ZNoedzp7F9aWzukj/yEFhZuO5KFbaj8r4hHCaj2MqwR9Y8LELRFzynbQ==
X-Received: by 2002:a05:6000:2486:b0:3e7:490c:1a2 with SMTP id ffacd0b85a97d-3e7490c049dmr6915730f8f.10.1757419712364;
        Tue, 09 Sep 2025 05:08:32 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cb9sm2559883f8f.20.2025.09.09.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:08:31 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:08:28 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <aMAYvA9LSvfxvt_C@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-4-vdonnefort@google.com>
 <20250908193606.47143d09@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193606.47143d09@gandalf.local.home>

On Mon, Sep 08, 2025 at 07:36:05PM -0400, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 09:13:51 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > A trace remote relies on ring-buffer remotes to read and control
> > compatible tracing buffers, written by entity such as firmware or
> > hypervisor.
> > 
> > Add a Tracefs directory remotes/ that contains all instances of trace
> > remotes. Each instance follows the same hierarchy as any other to ease
> > the support by existing user-space tools.
> > 
> > This currently does not provide any event support, which will come
> > later.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
> > new file mode 100644
> > index 000000000000..de043a6f2fe0
> > --- /dev/null
> > +++ b/include/linux/trace_remote.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_TRACE_REMOTE_H
> > +#define _LINUX_TRACE_REMOTE_H
> > +
> > +#include <linux/ring_buffer.h>
> > +
> > +struct trace_remote_callbacks {
> > +	struct trace_buffer_desc *
> > +		(*load_trace_buffer)(unsigned long size, void *priv);
> 
> I believe this is one of those cases where the 80 char limit is more of a
> guildline than a rule. It looks better to keep the above as one line.
> 
> > +	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
> 
> Heck, this is already passed 80 characters ;-)
> 
> > +	int	(*enable_tracing)(bool enable, void *priv);
> > +	int	(*swap_reader_page)(unsigned int cpu, void *priv);
> > +};
> > +
> > +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
> > +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> > +			      const struct cpumask *cpumask);
> > +void trace_remote_free_buffer(struct trace_buffer_desc *desc);
> > +
> > +#endif
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d2c79da81e4f..99af56d39eaf 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -1238,4 +1238,7 @@ config HIST_TRIGGERS_DEBUG
> >  
> 
> 
> > +
> > +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
> > +{
> > +	struct trace_remote *remote;
> > +
> > +	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
> > +	if (!remote)
> > +		return -ENOMEM;
> > +
> > +	remote->cbs = cbs;
> > +	remote->priv = priv;
> > +	remote->trace_buffer_size = 7 << 10;
> > +	remote->poll_ms = 100;
> 
> What's with the magic numbers?

The 7KiB value can be modified with the tracefs file buffer_size_kb.

the 100ms can't be modified. I could either make a tracefs file or just a
trace_remote_set_poll_ms() function so it can be modified after registration.

In all cases, I'll add a TRACE_REMOTE_DEFAULT_XXXX definition at the start of
the file.

> 
> > +	mutex_init(&remote->lock);
> > +
> > +	if (trace_remote_init_tracefs(name, remote)) {
> > +		kfree(remote);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void trace_remote_free_buffer(struct trace_buffer_desc *desc)
> > +{
> > +	struct ring_buffer_desc *rb_desc;
> > +	int cpu;
> > +
> > +	for_each_ring_buffer_desc(rb_desc, cpu, desc) {
> > +		unsigned int id;
> > +
> > +		free_page(rb_desc->meta_va);
> > +
> > +		for (id = 0; id < rb_desc->nr_page_va; id++)
> > +			free_page(rb_desc->page_va[id]);
> > +	}
> > +}
> > +
> > +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> > +			      const struct cpumask *cpumask)
> > +{
> > +	int nr_pages = (PAGE_ALIGN(size) / PAGE_SIZE) + 1;
> > +	struct ring_buffer_desc *rb_desc;
> > +	int cpu;
> > +
> > +	desc->nr_cpus = 0;
> > +	desc->struct_len = offsetof(struct trace_buffer_desc, __data);
> 
> The above is better as:
> 
> 	desc->struct_len = struct_size(desc, __data, 0);
> 
> As it also does some other checks, like make sure __data is a flexible
> array.
> 
> > +
> > +	rb_desc = (struct ring_buffer_desc *)&desc->__data[0];
> > +
> > +	for_each_cpu(cpu, cpumask) {
> > +		unsigned int id;
> > +
> > +		rb_desc->cpu = cpu;
> > +		rb_desc->nr_page_va = 0;
> > +		rb_desc->meta_va = (unsigned long)__get_free_page(GFP_KERNEL);
> > +		if (!rb_desc->meta_va)
> > +			goto err;
> > +
> > +		for (id = 0; id < nr_pages; id++) {
> > +			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
> > +			if (!rb_desc->page_va[id])
> 
> What exactly are these pages allocated for? Is this what the remote will
> use to write to? There should be more comments about how this is used.

Those are the actual ring-buffer data pages. I'll add a comment here.
> 
> > +				goto err;
> > +
> > +			rb_desc->nr_page_va++;
> > +		}
> > +		desc->nr_cpus++;
> > +		desc->struct_len += offsetof(struct ring_buffer_desc, page_va);
> > +		desc->struct_len += sizeof(rb_desc->page_va[0]) * rb_desc->nr_page_va;
> 
> Shouldn't the above be:
> 
> 		desc->struct_len += struct_size(rb_desc, page_va, rb_desc->nr_page_va);
> 
> ?

Yes, that'd look way better.

> 
> > +		rb_desc = __next_ring_buffer_desc(rb_desc);
> 
> Is there no check to make sure that the cpu mask matches what the rb_desc
> will have?

The function is filling rb_desc[], based on the cpumask input, so both will
match when returning from this function.
It is then easy to handle the case where some CPUs are not part of the cpumask.
See remote_test_load() where for_each_ring_buffer_desc() iterates over all the
CPUs from the trace_desc but uses rb_desc->cpu.

Is it what you meant?

> 
> -- Steve
> 
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	trace_remote_free_buffer(desc);
> > +	return -ENOMEM;
> > +}
> 

