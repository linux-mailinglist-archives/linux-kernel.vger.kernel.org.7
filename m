Return-Path: <linux-kernel+bounces-775225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F337B2BCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E18218843B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE931770E;
	Tue, 19 Aug 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrX0e6mX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983426E6EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594883; cv=none; b=h3NI5DAX7pipLzaLwImrmTQl2MSmPkY9VOaX77mt/8YmKZRM6bDyoJy4MSQSgoZe/cttnVt4p9fBeJr+4Omm6YxIYQi0evheGMBc3lJQlxgxthKYMMr7urVPqcqnmHm5nJ1GlOedWMm8B77m46lJzZ3WM08yy7V41EMEQ0muY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594883; c=relaxed/simple;
	bh=IoV7WBKUuYn16T6F/r3wlHg0NlMpdOlWlmfnqLYAMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRShmS+Zwz4QYezmkb5HXQ5537eUblbMxiQ2gx9HNaQu+FYO/GvENlOrXrAcmh/Gwgjc4NEgBFF2MYjAD7zKH5SaD3KfPQv5A0mh9ucm4WNPs21bLAx6ve16YtmfRsQjReVithPMIbsWRYWPXZ+KQj2qIvCQWnSlD+F4aiQ9cZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrX0e6mX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755594880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBft0XKYlUGliTx+DSLRnykfjvI7iBuKLMaBXeDuquI=;
	b=HrX0e6mX9SCZPaSPfQ6qi8Cs8J5VIl9AsoG8qcf+y3Mkq6Cg5OK9Za0cLQBttWnDS453hP
	QMcS+fEkhZyb9ISaFSY1amQoreaNYtu+5Kuu/bfbq8IJaZzEMK4FgAOnbrzg7pRgJk8pyg
	NmOKzIz5wTjQWuT5wEroqzifgy2zH0I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-42lerZmnP4uSArfD-hclNw-1; Tue, 19 Aug 2025 05:14:39 -0400
X-MC-Unique: 42lerZmnP4uSArfD-hclNw-1
X-Mimecast-MFC-AGG-ID: 42lerZmnP4uSArfD-hclNw_1755594878
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87063051dso595309285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594878; x=1756199678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBft0XKYlUGliTx+DSLRnykfjvI7iBuKLMaBXeDuquI=;
        b=BLCZO89CvTPcyANzgGS6a45c/UnkvsYH/cokMksjc4kqWzrVA7/g/8Zw/Zh1JowqPw
         UDN38o4tocRCfqv3mvLM4zep0a8gfH+IiNurrSrj4UwRSviupY0BvBPVqRQpGz15mJhE
         nBIUgIRyZpG6IYPljGvyLotjUTYU2TRVySicLcgfbGzI1qEqg+uHMdg4IQX2y/JDEDoW
         YHVSJUPp56pQ0MtfYG5+F5+1WkfejXKimojvIB7MuIZ8ilYjQxjcazKnSjrOVfcuLGMh
         5VbKsb8lXmwv5pXzfZv5O/LaVeLs9MP5sgzJnmOQUQHkF3B0+kcd4hgN0QlZzN+KbFuQ
         PXLg==
X-Gm-Message-State: AOJu0YyQ+K0V3NsuJo6C+IRfgrgaG56MRuCZv0GlAmwJRSCheM4PWQAz
	X4rFxfQO3YPhAmJotrao032m4P8Z7Y2ZjqFbabWToTqKiUYr7R4oETDa3V7uJu+HLt8tcVM7ajd
	QnLoix1SQcZBtUEGiNT3Bb5EQzSFXh959fOSEGMuOo0IqdjI10br7xn7HoJqsWfZl3A==
X-Gm-Gg: ASbGncsO/qpJVz7CMNFybRLSsrtOnM36cEGNqEdP/k48oyW8itTzyv3l/aw4hJ4Mfr2
	ld2mGdjBwIVMEPLAwf46SdLSqcx1NdrgSsdTkEci7NkyANUGGXnaWK+1RBESKfmm9Urx0wTYnmr
	ssrm7MwJ1xtDN2I68uK8Jy2ZgS9JFZ2EJxmSjX+5XHql3yMuvm074CvhnrwBc7+Q/0VBOX6CQtI
	79vdIB23LC2Coi94ZLWMAYHXss4HUfZeGmmEjlvYHItpVZDcwAdcZkH/gNAQ3Y44E6gM9NVdqkZ
	AFRk3sI13HnKW11UIpInpSMybccuFagyp0CWFoeFHqfbNs+Gg26z1V++J7OmCVbW2BQY
X-Received: by 2002:a05:620a:a48b:b0:7e9:f81f:ceba with SMTP id af79cd13be357-7e9f81fd24fmr40070885a.84.1755594878506;
        Tue, 19 Aug 2025 02:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmEoj+Ud8zs9th52SpZwFEUaYKQf8oz1qBWLxnyzGAiTxqSStJPJDiPCnTXIiBo4xdTU/u7g==
X-Received: by 2002:a05:620a:a48b:b0:7e9:f81f:ceba with SMTP id af79cd13be357-7e9f81fd24fmr40069585a.84.1755594878120;
        Tue, 19 Aug 2025 02:14:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87f16f9ecsm712066085a.24.2025.08.19.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:14:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:14:32 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-12-gmonaco@redhat.com>
 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>

On 19/08/25 10:53, Juri Lelli wrote:
> Hi!
> 
> On 14/08/25 17:08, Gabriele Monaco wrote:

...

> > +  static bool verify_constraint(enum states curr_state, enum events event,
> > +				 enum states next_state)
> > +  {
> > +	bool res = true;
> > +
> > +	/* Validate guards as part of f */
> > +	if (curr_state == enqueued && event == sched_switch_in)
> > +		res = get_env(clk) < threshold;
> > +	else if (curr_state == dequeued && event == sched_wakeup)
> > +		reset_env(clk);
> > +
> > +	/* Validate invariants in i */
> > +	if (next_state == curr_state)
> > +		return res;
> > +	if (next_state == enqueued && res)
> > +		start_timer(clk, threshold);
> 
> So, then the timer callback checks the invariant and possibly reports
> failure?

Ah, OK. The 'standard' ha_monitor_timer_callback just reports failure
(react) in case the timer fires. Which makes sense as at that point the
invariant is broken. Maybe add some wording to highlight this?


