Return-Path: <linux-kernel+bounces-844075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FBBC0EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12EA04F4310
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA685262FD7;
	Tue,  7 Oct 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQxlaQOt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A87483
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830959; cv=none; b=DFfQzSrSu+2iTLMWJgm/OaTmSyNh328Wu8bsKgksqlmLzwtC8yEZaqsjjSfGfK8MByY7JU23gzovSqrVAEwjec76tVSRdYPs2fVtDlbsxjluv3IoHJVP8JbMUUP2m5lMmwjRlnW3VBxyc0nSzZIHrZBY+Gh/sifD9EMoWkLAASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830959; c=relaxed/simple;
	bh=k2gXPRmtd1TD4nz3Ql3EKl6sRy1fMt/woCrNSVaMfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA4th0V2M5HMhiuTCjutYqAo+h46K6PPD0K/DqqORSCSSOcuIVEg3moR2ttIN835lcZOnlg5Y3b9yjR1Ink0/M/O2iJX8tIz04PoOEZc8CfhltSopdDgTS3HXx8Y5TU3m36dfQS2MvtmbvMB7zg3plU8Qw8RgqASTfvD1xoL7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQxlaQOt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
	b=DQxlaQOt6yGeLoHI4FJFLegYtMFZMZjpnn+u7uvz/FxP6ZAvk+WPqbrDXcdZoAiA/b3hue
	bvVJkZY5unfeXjPlZ7uCnHphUa9KfQFZ4AOxm4qd1nxqySnKfBPnZIR9b7lq3JeWZPeX2n
	zccguwia1cBnKRyUkTLdjT2WYBH1zmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-pA3vOwtvOCqZtwU5Brz4Ow-1; Tue, 07 Oct 2025 05:55:55 -0400
X-MC-Unique: pA3vOwtvOCqZtwU5Brz4Ow-1
X-Mimecast-MFC-AGG-ID: pA3vOwtvOCqZtwU5Brz4Ow_1759830955
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so7113385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830954; x=1760435754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
        b=CDwVtX3iPcyiKuyJB//VNjgOuGvd+fMKVhzPxrlTqbsNH+kKs+2EBqcbdSfjTVUlit
         NE2dGQimTJaz1HbzKz2lEEn6lcYcNvG/lDVBc/h8iSipC30HwvCOsNYbSYVJnBMeWMzO
         XXGuX2tkoiIJU51PxouH4hIRYjewTzaIHN1ZPZG7gPCkdv6MGEYqtq6h9usoxGUYWoUW
         Fayu5yJyl3IYk3BaduJsTN84XENkdCAgXKkbh1LC1xsrsfVyabLziT6UCE+PrsyKDgFN
         xxphYoENXXQFSTWoYPv5UAr2dXH+DeGvYP+47p8ejMzuLX3HzRT9PGKF8d2PexWv0LrD
         bCMA==
X-Forwarded-Encrypted: i=1; AJvYcCXir+r0fiTJIinZKt5a1BUlk69uNktdaH/AeL9kV7Uemondee4ejbVnwizLhc80aCRutii4PoUqv8MysQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbf18bJFAiVU+3NM0QTeJaqvciPge1V/8KownZJRIoOcURYpiJ
	PmoebQnbher0M2e9oK6wmkcgQPV3w5oo77+is82+XqTocYeS1THXmc5uitwuAAwIRk9M7fqBFOJ
	cle2oYyeO5qxH6H8JTN2KN7at5MiXD0hJ3zdA/bg5sMSICJYAI3qMlYhGvv8Dwex+7A==
X-Gm-Gg: ASbGncuPXOrAL78QfOwGavm1HFT3HiR82m9j+Oi6fRb9Dgy8fdInCakZ+mpSKyynqEC
	TUrTeEsZikj9x45yf5rDxTt5x1L1np5926+AuF394fHTMoF9JK8fq7/kloCFi52S9H2eBhAhj7Q
	V1O6Mao2TwLEkaXKyEZNH/ircH4/e1FVmWhDPfxAQCDvOrZ1dKl7L7uVpQAlcK63WOXjxjhnU/A
	FI5QsL2wKYKxX7Y0uetdgrWZdZO6ai0GW9Q2+oQ43eL4X/S8DCUS0I66kNUjW9QpvU82QbGSRSU
	JeupsaoEOgBW0sqzb1R9BVXvMTvJi3aWocn8LFo1lK+akAFF4TNDpBQXvnR1ObL3N6DBMa8oFkw
	qNQ==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517375e9.4.1759830954663;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4OXSeLV/Yz7tujxNUfJFKucFJb4UstVFyNXz/DqV4md0An1W/DljziOCxTIGE8WujReEeTg==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517065e9.4.1759830954210;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa39f3d7asm13615125e9.2.2025.10.07.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:55:53 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:55:51 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
Message-ID: <aOTjp9z3MNqTQrpD@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104402.946760805@infradead.org>

Hi Peter,

On 06/10/25 12:44, Peter Zijlstra wrote:
> 
> Hi,
> 
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
> 
> I would like to queue them into sched/core after the merge window.

The set looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

For the DEADLINE bits also

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


