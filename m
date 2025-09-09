Return-Path: <linux-kernel+bounces-808603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB818B50229
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0164E2D69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59D335BDA;
	Tue,  9 Sep 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRyHgv3W"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F33218B0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434224; cv=none; b=ULz4EFhHMCAvSkyf55twlmi97vQ29wazCI2rgDmMvKoX3GdFkayYSKYaAdPrhG2BQGNwxBfW3nQy/ps7DELQ6c2Sw6omMOAa/13saArk1X35AU0XhK+hw6ZzYrwSp3OXBojfKET8dhWM6BmUheMYNkDomnLTYnnNwowvMjUNfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434224; c=relaxed/simple;
	bh=bvmtY118txyjfxnCSpGNzanxwErszIEgZjkDshuNbJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMH6FNETw1CBQZtJnDRUZNBJzmOBjVGE5gbk8EVQWMxJ2IryUO146+rbVgr2BjzHWyk4gFEyb4AhSC1DDWSlAl3orWVHDYw4D7rUk64sG/wSuywUgt8YzJGPY/hcBqLYidZ9+CWw1FiqoHcc0ylXtNhdv9StP4UoonfkZBAEhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRyHgv3W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso35354275e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757434221; x=1758039021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+NppKLzVrIsIoSaivdIxFGudWC05VGLRO9K0C3DxKA=;
        b=FRyHgv3W5U8JKjUdNBgBEukF7I82pH6MTp9NPt1tkQkjEJb84zJe4ONos+/4vHt15s
         tsPyDew5aD5CdTQnmfE/AxPn6vSb9VUquAgKqxt/WPHzo8JpVZ8wZGZmrqDQmj5iE0AZ
         1oJYtk1UVEHZGyvafKqOZdG702CAmi4qWd3coiA9BATMaRkcp/h4QHFiY5xCENX/CNjg
         jwlW3mGf0SGSJNGoHkEdCD9pUQSwr/k1kNKOT3YZ9wDN8sBjJ7pm2py7DBqjPRCGL0b6
         vaMh7ggTz5KsYArg/uxSzUH/oHs68T7ht3UBXQFON2fkqVjX9sB5qScHbnF3xerzuh9K
         oJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434221; x=1758039021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+NppKLzVrIsIoSaivdIxFGudWC05VGLRO9K0C3DxKA=;
        b=MqUPJYplNmq0smmrZaF4zYykYwaAvphMPyluzImkS6M41pQrTnA6cXdNVv7hPJfBv4
         xhtiWo400nHr9/b0HuPs0tT1xSeJTxNWKcZJYBIOek6cjh3isHHH3fZEnGM3zqKciZ6O
         LqfdnBic1HVj6Jqr1zmhTPM9yPs9Kt7vPs/2JjZeQW1+jFqah14S8yU5eME3QJqzg/Bf
         8k7egkopeZvRkFTAUkk2knH/NsJNNMWq/EG7sTqa9fPzhUfBtwd/GgL11nKQ4tWHU8Ut
         VJuRLVaKJZ9I4nxkUDnIIwfYtSl0d9Y910zxKH+MbwOfhYnSsHPXWk1Lz7G3ddx9BYI2
         UCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwxqCjXW+/o7MWWoEn804pJr7jjYfy9yHu5m+DtTHF+9vUyuuY02wCWEbVbLl6UWzdtmCW00L9VGVAVJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Wdzd9ay09Ve/rZo4iNJ19KXY5w6fEpuzo8AMxUGX2oH1mmoM
	Dun9IqONxyYH/89hU//CUGZKpl0SLHCdnupecfQ4SCsd2xNyK6TpI59D1KOqy+/jfg==
X-Gm-Gg: ASbGncsepcLX6P3YLcGQ/3G19safkHGnOylZRGyFZJ9h2k+UUINuh/T3I1kLwKMhqSb
	mU5ipqtjaoXXHNGyLRr+5gfY5O9VPffdz4FrMANlpvv9nV5l3elEEWHvz8wEVXvIUSqRv3y9fX0
	MpdEfGvl8bCW7wiY4W5rhhv/+GIOwwvz773tOYjjES/HBUvzz/93onev1F5j2x/iuTfhWXyhjCo
	aMK3fIhHHepRN3rzFXCdceC2xB7VxhG1hzQEiTprN0D1KS2ZCJd2fWaKOe8koCCQWZ0hsPgLqTM
	ATpaL651Qku0FNO7uDgCVISVOZSNMmO+ufzkbY6dZ5niwQNO4VrLPLOyYk7CWzwGJWLqUEQcGIW
	lydR5rDTiV58TzMJjvktGR6k3zfaaug8F+NsQQIjGJeIJ8Ck7ZAjDcq3Sca2Aa+Q3oDZ493UwMr
	ADFMRa
X-Google-Smtp-Source: AGHT+IEcQIe0OC8lSfD+aiR6eeprIeDl6s8EC4O8tczqPnzu992yeZRmguAnbDmw2y0KnALeXMKgPg==
X-Received: by 2002:a05:6000:1449:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e64392b8c4mr12530932f8f.40.1757434220628;
        Tue, 09 Sep 2025 09:10:20 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238910sm3069080f8f.41.2025.09.09.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:10:19 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:10:16 +0100
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
Message-ID: <aMBRaPzjR4OJVIWn@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-4-vdonnefort@google.com>
 <20250908193606.47143d09@gandalf.local.home>
 <aMAYvA9LSvfxvt_C@google.com>
 <20250909093848.402674b7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909093848.402674b7@gandalf.local.home>

On Tue, Sep 09, 2025 at 09:38:48AM -0400, Steven Rostedt wrote:
> On Tue, 9 Sep 2025 13:08:28 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > +		rb_desc = __next_ring_buffer_desc(rb_desc);  
> > > 
> > > Is there no check to make sure that the cpu mask matches what the rb_desc
> > > will have?  
> > 
> > The function is filling rb_desc[], based on the cpumask input, so both will
> > match when returning from this function.
> > It is then easy to handle the case where some CPUs are not part of the cpumask.
> > See remote_test_load() where for_each_ring_buffer_desc() iterates over all the
> > CPUs from the trace_desc but uses rb_desc->cpu.
> > 
> > Is it what you meant?
> 
> I'm more worried about the allocation not being big enough for the rb_desc
> being filled. I just noticed that the trace_remote_register() function is
> missing a kerneldoc header. Please add one and specify what the parameters
> are for as well as their requirements.
> 
> It's fine to state that the allocation of desc must match what the cpumask
> is. But the lack of comments about what the function does and what is
> expected of the parameters makes it hard to know if it is performing
> properly.

Ok, will do!

I could also add a desc_size parameter to make sure we won't overflow the given
desc?

> 
> -- Steve

