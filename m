Return-Path: <linux-kernel+bounces-853796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD2BDC9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DD1927202
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503C303A24;
	Wed, 15 Oct 2025 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMd3LNBo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C93009D5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506827; cv=none; b=tgXubXjNNLv6vtwnLElJvOF5g938RpLlRF9jXQJjE+AvmhXmOQyTh/nUxKWqTxoG8/S1rgA/KaDeCat5I6C7p8mkXKo7kPu57fUtyvsczmxfFbdg9ENCMuqljt9KmWnI787uH1bBglM3/czDdvv1qXJJ5CHeWGo9Co8du4UVjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506827; c=relaxed/simple;
	bh=xb4zzcYL2KnFy6e6BD3VgLRhBMY4IIeKppErZf/mM1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZaWVR8LirxoVn8PgWTikFhvgvkaJlC2Su9bAeOtjZ+dr4nnjukqv5G1aY+qWa90rxuI1OcNHoqwrDhA+xkfo7+CgoBpb9DZvtlsT+3XqfigAGhiGqfWY8hkvdGhEdgSC7N4UuhUKGwPHKWvlbVEEC2uzueRo5HtL/JWHYO/4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMd3LNBo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760506824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEoDd74svqlEduKifpwv7cIyLG6I8M9pnEQfVC3PzLs=;
	b=jMd3LNBoE1Rn0M/Wlxx1L/Ct/RquZhbB7ZFrVBB5U1nRkzq5NHA9qwAeVL0/slZTCRbNKq
	oQ2ZeFcFX0urtRdNzI+vHzsO9M7XKFJFPR2qKl0Zdv0UGWVO0I98UD8frWat0BCZCeAV4w
	O/TOzWUyK+7sKpUOz5LFzjZSozQqnOc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-5nvo7vaXN-25RtKgbSGwww-1; Wed, 15 Oct 2025 01:40:22 -0400
X-MC-Unique: 5nvo7vaXN-25RtKgbSGwww-1
X-Mimecast-MFC-AGG-ID: 5nvo7vaXN-25RtKgbSGwww_1760506822
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so4660735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506821; x=1761111621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEoDd74svqlEduKifpwv7cIyLG6I8M9pnEQfVC3PzLs=;
        b=pkYGqXf8zKFRuC87NV6cHwijSOW6Cjy2x9KY0FI0imD5sYHvvQe2Mlg8DIIMlTua2c
         18nQAvuz7yN05hpdZ7co2dN0abu3371s3P2K6HVrimUhUrFThMnH9Ekz+H7jMA+SwOg0
         UMAGqUifxbVJQe0lzoEa1DGG25mVG3RxYDK7YnIK4AXYxvyrQXX0F5z37Z+L/8lUuW4D
         HVGo4BiNNCihvpgz8Vxwvd6kOomPbTY6aVFp4Gl7MTGMkGlYwdWe+N5VgZ8hfedEmrFY
         5NrgbBLUdgUzMKbLnep+6HrrJAlc+UoE5yDNmEdvGSCATk7zjVNj/ph5N00/dim55PeO
         HGfg==
X-Forwarded-Encrypted: i=1; AJvYcCXvrtWLJrt2Plc8uNSFXf9swZf05pSHRaYzBYKl1HuZ80iOfb6crA65F/XnKb8yVZGRw7gd0Pcth/01y+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxcqAtGutwfETeltZGdngq/uy6IqEfxRDy+8ANcLmDuA32mi+
	Ti9xgdhEJCTOHJ/D5LFVB9izerpoL4ZIz2wRHqzAZBBbdjfzSOVDVDMOjXcyeO1gETu+atzp1ZH
	ahRRcwCZbA28/YXBBQgCje6NoRMz0oxSetftp4a91SndME2pE4cdL+/PTxyJ3iTrmpw==
X-Gm-Gg: ASbGncut8BlRYz0UC233sUTZDZWU5+7Kco1MJYZyYObLSgwopuoYWgYh7kgQD/1wiyS
	6sxpoCT3rInPSb+OoEZKnOJ2BVpqfh/2Y//6pvopI+paeyKqwjtqBNpAY8Md0faXxPq7cJy87yY
	cxgjuJMWss8vFqSH/R/EDKGRlnGDunEhVlXQ2bQEFEiVNurswNds3IT9zOD5RuR1E7ijqN00XDj
	SbdmAK/d3mFYljKMR2BGSDeHDzFj68f1fXvYLxxipm+gK+Z7u36SQY47sM/+uG2hKJgReYpq/Yn
	eTOaioS+/NwKC7+QLkIkgWdRpKAUJq47JRK5ehhaRuQocXJFzR1n9bP5GzwvAgzwPkuufMrr
X-Received: by 2002:a05:600c:8718:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-46fa9b08f09mr211939475e9.28.1760506821575;
        Tue, 14 Oct 2025 22:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU0iWVr5hDy/Wa8txkNZa2TYgKsp6sO3SpxyFja1k/NqHZRr6xoH2B3Ir7cb9LapGPXMLwew==
X-Received: by 2002:a05:600c:8718:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-46fa9b08f09mr211939335e9.28.1760506821231;
        Tue, 14 Oct 2025 22:40:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e6f03a76sm11457634f8f.36.2025.10.14.22.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:40:20 -0700 (PDT)
Date: Wed, 15 Oct 2025 07:40:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014193300.GA1206438@noisy.programming.kicks-ass.net>

On 14/10/25 21:33, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 06:01:10PM +0200, Juri Lelli wrote:
> 
> > Shouldn't idle time be accounted (subtracted from runtime) as well, though?
> 
> Argh, indeed. Then I suppose we should look at bringing some of that
> 'idle-for-whole-period' logic to try and actually stop the timer at some
> point if nothing happens.

That was my initial thought. If we get to that replenish after a whole
idle period elapsed, stop the timer (resetting state), so that we can go
back at defer mode with the next enqueue from fair.


