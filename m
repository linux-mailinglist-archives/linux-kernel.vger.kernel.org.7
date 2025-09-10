Return-Path: <linux-kernel+bounces-809882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76EB5131F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CF91C833FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05030103D;
	Wed, 10 Sep 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIM8hENk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B22571D8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497681; cv=none; b=Ye2Ft27t+3HXvbIc+vCKqPlwRswP6syQCkftv3muH3OY+l+W8/c1LZr3L7iubceqQhjm9yCMN3oX0DnYDp8bJkR00ICl67FAhqN5FbRDy4q8dGpbIJbdAiMkxjapb+FWZGo2Jo16D/sLtYu+ggWcIXvlX9Is/EC5wWAA5SfMfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497681; c=relaxed/simple;
	bh=0V31LUAQineHaHR+Zk1fa1rB++gkt0nxE0bE4w2NcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/WEqh6r4lOMrgi36Z8/G7OpRc0G8W0LiFcFVtkTWWxeWVnwy/Jo2h3JjUPPbKvdZbAqDYtbYqu9Xs08WN72z/l4zaLLHj+wEAR+5YazYWCGGFzXoHQmJ1tJXOOFMsDVqppFr/NA/uvCY0VAZ5MqcbGfu2P24yux3jBBPH8j2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIM8hENk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso43146635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757497678; x=1758102478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvtu3uafbueZeizVaV/6mc7Nfku5GeAYQMpYTXLT+4o=;
        b=cIM8hENksTTCHyw1JeXkRiSgdc4nODT2WcuLF3WBdoxMQUfE0T6KxW1DNWymmpwybx
         WFn9EXr+4pNb/4PBKoQwyOpCO6HDz6adWEH4v8c6lLBXSVrEw2ZmHsK5JLRM+sdULtsp
         jgogPgKa8XXcOziL6pMsbVczEyFc2shjm7bjhJq1oShzuBeb6twBUOvJGo0GeYu70XSK
         bKzg14dfbh/+P93qFNAklo3vhNoPe0WHLJlgNhplbJoyttroPV/JmXRZmeV4XvTzZTEn
         OJUDMnbl4pydzVfyBN4K4RbLAGI4m2Qe7RxWQVdjvxn8qag2hu47EUJyOc7CQAZGh1vp
         zC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497678; x=1758102478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvtu3uafbueZeizVaV/6mc7Nfku5GeAYQMpYTXLT+4o=;
        b=UFx5HfAIoyXimXpnHT6xyVAB9y9LJ7Yg52eMhLJVQm0PS1a6kzLEaevGdOFb3+WIuE
         y6wAF/44Wf0j7r7/Pb3rwS7QyEtlAMsg9yR3RWDbRIlqMSM/ijSxeduoqbTIVw4JRTZ+
         UxbtCA9aeglCGYGfy+YA3DEVnIegzhYLhXz+4qYDQw4pQyhEV/PhFzpg4szexIApr9A9
         S79F7lXJ9WTdAwctzH2tBrIvlbFm78h2MEAR8lHJY60BHtxCaclyRQ+TzvJ+mhXAXbF2
         UlegnCHnkdsLni9GP9JX7bKrIhWxtRV2za1oZBUAnZk1jBAfTknm1QN1DlwZmAOqGI1R
         ELDA==
X-Forwarded-Encrypted: i=1; AJvYcCWqnoG7/CtLSlicJNltbjdgpgYogyemQaDZOqEDepV8t0NqjTXWzlLCCV6RPmi418g3KKsbUswiSo+ixJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6h1y+2yOY9Qm6/c/sEr1V9LaFkuj7glIiaIcDUaO9ApqI/+hY
	B1HAiMKWPvWdfUGwBEkK/u6n+oujdn4ou41lMhXPOYSeGW02VNH6NIXzwDhWqfa4iA==
X-Gm-Gg: ASbGncuWlhbjajVrnzL4FMUgmwPB2Nseqze+4WrDvDmwi3WJEWnHmHRZM/0PtWoGDLw
	+UDu64TzYfeXeN5v0SusA6yG+nowFx1if57z4e8d1U0hGf2UILE5t4VgA8cuXS1s4kAnI/mF0D2
	4ueZkIFZg5uMeHE/6Umh4rlN49PHz4dgMJyZy55OmFjzQ6PZqY8N10wYE+TThOr66cohVa5MYmk
	emJC1ELNCOHUD1njhnrXjyVfKszZH3nlecWO7GTgTa1890y3xVEPjTpWBMxZy0/zTJcgCMQ6iGX
	5YS3ckHI0PfW+fUKo0B8YNsrflvNblOexATWTSP2tqGBX7uaP+02xrEiY1SIcZ5VGPd+yY7p0ch
	r2hrvVvgknvbDFQc9CJeCJevsxugaP44sISjWTpqjad9uAqOG7O06JRlnCpnZuLwgLtHqd0AdS6
	4OTl2i
X-Google-Smtp-Source: AGHT+IFWWYfR8ORYSi5S/6yVLRSE1Vl7ci8b3o8skMEhA51akRxc13pv3ScUUN6gVKKYUtaBgf3yww==
X-Received: by 2002:a05:600c:8b43:b0:45d:d718:3b9e with SMTP id 5b1f17b1804b1-45ddde92627mr142163035e9.10.1757497677772;
        Wed, 10 Sep 2025 02:47:57 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238832sm6017788f8f.31.2025.09.10.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:47:57 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:47:54 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/24] tracing: Introduce simple_ring_buffer
Message-ID: <aMFJSlbHRsvzYKaF@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-11-vdonnefort@google.com>
 <20250909182644.092b3e85@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909182644.092b3e85@gandalf.local.home>

[...]

> > +static struct ring_buffer_event *
> > +simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long length, u64 timestamp)
> > +{
> > +	unsigned long ts_ext_size = 0, event_size = rb_event_size(length);
> > +	struct simple_buffer_page *tail = cpu_buffer->tail_page;
> > +	struct ring_buffer_event *event;
> > +	u32 write, prev_write;
> > +	u64 time_delta;
> > +
> > +	time_delta = timestamp - cpu_buffer->write_stamp;
> 
> The remote buffers never get preempted do they?
> 
> That is, it doesn't need to handle different contexts like the normal
> kernel does? (normal, softirq, irq, NMI, etc).

No, luckily, we don't need to support any of that.

> 
> -- Steve
> 
> > +
> > +	if (test_time_stamp(time_delta))
> > +		ts_ext_size = 8;
> > +
> > +	prev_write = tail->write;
> > +	write = prev_write + event_size + ts_ext_size;
> > +
> > +	if (unlikely(write > (PAGE_SIZE - BUF_PAGE_HDR_SIZE)))
> > +		tail = simple_rb_move_tail(cpu_buffer);
> > +
> > +	if (!tail->entries) {
> > +		tail->page->time_stamp = timestamp;
> > +		time_delta = 0;
> > +		ts_ext_size = 0;
> > +		write = event_size;
> > +		prev_write = 0;
> > +	}
> > +
> > +	tail->write = write;
> > +	tail->entries++;
> > +
> > +	cpu_buffer->write_stamp = timestamp;
> > +
> > +	event = (struct ring_buffer_event *)(tail->page->data + prev_write);
> > +	if (ts_ext_size) {
> > +		event = rb_event_add_ts_extend(event, time_delta);
> > +		time_delta = 0;
> > +	}
> > +
> > +	event->type_len = 0;
> > +	event->time_delta = time_delta;
> > +	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
> > +
> > +	return event;
> > +}
> > +

