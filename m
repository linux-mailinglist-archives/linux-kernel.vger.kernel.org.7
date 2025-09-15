Return-Path: <linux-kernel+bounces-817761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFDB58636
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E81758CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8F296BDD;
	Mon, 15 Sep 2025 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nsuss6TG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E679283682
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969480; cv=none; b=gSsCmVe9VOPDvqPxVXhlQLzZ+ufAT2f+nko7uZR6viPzBS+J4H4s7eB+CuWvA6+mJo738rMzp/rOcPv8n3pgWvoxD60Z2Sw0k9PmijT5S3RNU59aYZhslVazPsbQ49sq46DqZFlet/5+W/1+LH9iZFz/s1iFZgr7JuEG79cpzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969480; c=relaxed/simple;
	bh=gSBcW45s16hJL1h4JORD0BXMNvr3/+WDFr/c3yqwes4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1LlKFoYp0HNbxEurRRfFpnaN4q/vXXcjxbMxzxy4FjbXSO9KWhZ8QCnyBAl7J6BRAqq1rpWDxS5p2pJ1qxajRzeEMh5s1tAj+axpWY9VofRWxVmt8F/zfv7kGUaoiP7xlIlxhQPIIz9tLL4L5kz2WnRFCQqNLidlMPDx03CcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nsuss6TG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757969478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOMr9SAO3u5wgAz3CRJrisoyKwgRYko4OWapp7xVpSY=;
	b=Nsuss6TGBZWtbBjVj/56V7zoLtnpMdz8HzRlB2FIb3mPHxloeMVkZfq5t8uDdvI826OOeU
	f7wcC1A9lqoASp0K12Jp+8gfancJJCaPIIlPfQbIVSMl7Dru7zRuzyIniohwnS6uLMfxjb
	zn+D/ZbRtItr73D8NRhXtWQeTCfnorI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-lZb5xo-OOJy2qT07S0GIBw-1; Mon, 15 Sep 2025 16:51:10 -0400
X-MC-Unique: lZb5xo-OOJy2qT07S0GIBw-1
X-Mimecast-MFC-AGG-ID: lZb5xo-OOJy2qT07S0GIBw_1757969470
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7726a3f18a0so45800156d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757969470; x=1758574270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOMr9SAO3u5wgAz3CRJrisoyKwgRYko4OWapp7xVpSY=;
        b=JwDwb86A0i2tZj6WeDzaq6aF2t4zDqgcstqZJNBBQ6WHa2U9XCzgH3ndPT49YC+gR+
         rG7zZcRULzz67ncGkzUe+ZKAajP9P4+O0v5AQmE+cddq/srulg+GIGHufl6Ht5I19Smb
         G8GpMJhjNt/QjsRHeSzOXES6hQ1e2Oo9sM5GR5qK4dZBbiFaC77o0Vue+3H0hF66vlr9
         d1j6U+8lDatRB/MOo01VVV4AnMXWn5p34Q6WHSRPQ8sUPZ8MXVI2xqQ6StxBrNhQKJ9Z
         VkWIY2izf0s9+2u8aKyonE6pjiJJ0orQg2PvDhovCJuLscSedAixj77b+TqRIu3hwK4B
         pKDQ==
X-Gm-Message-State: AOJu0Yxv1Fkmjv98qkntZfEbcPo7L2nCFS/lNjR9T1A8fznW4LfhP5OB
	vvii31Amwt2aZM9tdrUwxQVUtWb+fcCpc7p8dEbL3Zl13cbEBAkFzpW1qOXbmsthE573eVJ0e+e
	vGMRpkNhLnIcWP70Huz9kZyr3HIo44RXuELSfjpqpZ4RFiwwbr0gvWAzcc8tqwmO+ew==
X-Gm-Gg: ASbGncsq3D4wSP0PGdT/V1FMb8S8Gd/OYUvE6lgxuCdn3NGh1aEACGV+oAxKi2SW2Ud
	n8kWXuYVgUbZf8/AAKbsZWzRo8EFW6eDcKPuUrPmgz7Vi07YxPzTl3LmwubuToDLZfguFPWSJ03
	l4mwx2tHVPgqpRsL1eG8C/G0hSOjs9vESa6OzzXXueBTHDegkcaWtRyfARpUTYRoAOWAILlFJ56
	7Z/wH+eyoXh/m6lyqqFPeTxX0DqdLDxgS3UHIB9bOKZ6sI/PFtCcW9hlcLG1lq7Moxkwx39UdAs
	D4VuD/LNRXlkl7ea8yOoZmg+w2akMzhfD7oZ
X-Received: by 2002:a05:6214:d85:b0:77b:e56:4205 with SMTP id 6a1803df08f44-77b0e564816mr84054156d6.40.1757969470116;
        Mon, 15 Sep 2025 13:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoYLmdIb3Nl2+KxO8kfeLmdxlO0+34K3AskfequOVhpHMFSdrtgewyxL9LqdgnVBDw2F8F+w==
X-Received: by 2002:a05:6214:d85:b0:77b:e56:4205 with SMTP id 6a1803df08f44-77b0e564816mr84053866d6.40.1757969469773;
        Mon, 15 Sep 2025 13:51:09 -0700 (PDT)
Received: from thinkpad2024 ([71.217.32.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-773292c6357sm51294136d6.67.2025.09.15.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:51:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:51:06 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v12 9/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aMh8Oq6El_xV9Ls4@thinkpad2024>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-20-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915145920.140180-20-gmonaco@redhat.com>

On Mon, Sep 15, 2025 at 04:59:30PM +0200, Gabriele Monaco wrote:

Your patchset continues to pass when applied against v6.17-rc4-rt3 on a
preview of RHEL 10.2.

rtla osnoise top -c 1 -e sched:sched_switch -s 20 -T 1 -t -d 30m -q

duration:   0 00:30:00 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  1 #1799     1799000001      3351316    99.81371        2336            9         400            0      1799011            0        23795

> This effect was noticed on a 128 cores machine running oslat on the
> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> and the CPU with lowest count in a timer migration hierarchy (here 1
> and 65) appears as always active and continuously pulls global timers,
> from the housekeeping CPUs. This ends up moving driver work (e.g.
> delayed work) to isolated CPUs and causes latency spikes:
> 

If you do another version; you may want to amend the cover letter to include
this affect can be noticed with a machine with as few as 20cores/40threads
with isocpus set to: 1-9,11-39 with rtla-osnoise-top

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


