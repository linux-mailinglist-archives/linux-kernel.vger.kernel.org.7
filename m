Return-Path: <linux-kernel+bounces-778063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24026B2E129
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83932AA1E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA01FF1A0;
	Wed, 20 Aug 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBPkUwpi"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212E4C79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702792; cv=none; b=D8asWlI2+cFLs6kRapVH7IM7ocn6nmmZT2fXfJHOAxKAYF1i/OKpvYj/bB5DiHKho01QaTMu86Kc6aHZuUQlNlGaBG9lhLqvhLFIsMEUGqnSe2QIy7r328NkjRDJI8s+HllIghBInsCtWDV0a6eo7FZVY8hEoLn/a1pgAb5GppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702792; c=relaxed/simple;
	bh=yI0HadZsSi9K9jcVAsF3zjD24uk6FF9CqaCC5gh3OG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDGXGbuglhDozzpJENNJP6P4uAbFJa9WQB24uXZlPBPuSfdoIK76uFiMwMeQBIrAZJUY5amcFE3Z+eU1YS+7vNWB6/BTN7VMDnlu1WuogdduUTyKOfZeEjUEGwz5OhTSuxBBtzOowbbHpyeXAoh6RXs2TYyg6tQseLwuF1TjJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBPkUwpi; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e94eb6b811aso1577049276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755702790; x=1756307590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFUStKMRHDPj6JYBVxnbw6Z9AEEYTWrR4Fi5aFJ1Z90=;
        b=DBPkUwpiga3C2EOl5DqK4kz97h5ZEn6P+tdRbbLEHR+CHlJB8rq05lUDijbMP3VbUb
         WI8osCqy16dY+/lsK6FtBjAAv+Wt1y0GwiA2nBimqI9Kr6apaOueT+9timzqN7b9gqAc
         UVyZNjGqgvhQM4wAY9LWizKmm1LuMBI/1Km4YR3x5jL05ppdqNtVufTVYJ+CPuMOYQTx
         BAtVl8lmMqz8/0CjrEWAsgBgCt+OoubDG7PvErYV+DfYbYN7U6mdYxj0MiE/lBJfowhN
         0v19GpcEOgkYhNbw4KRu7goyJp+EXMkZXNGsYreS/LFW5oyv6oUmlpH8ygf4d+ceTIgS
         4rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702790; x=1756307590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFUStKMRHDPj6JYBVxnbw6Z9AEEYTWrR4Fi5aFJ1Z90=;
        b=f0TZb1658mBW+4Lxob1Zvt8Q16X/owSJ7x636L2nlWjqY2Ludu4bw+4Rke1LkXL9y4
         5qymfXHTLZxub1EimUUzWJZ7rJhlelGqi9uh6N8c6dZx57asvtquD1X0vnscZ5KoiKMF
         39zA1z+6Sr/1tSIobwmXQI8x57/paPoHRvByhLhwF3XvCV/Kqlu5J9rbOMa1VnybS6Q/
         A5G+fR8K6m+5o/c3c5gaCab7iiIgQEXIyrYAsDD2ez9qnhpAjt4NjXxZVc5jkU6bYoQc
         Z/QHRO7m+jTsEeyDI8LfdTPHWP4iu0kIeUCL2iY6Tj5b+1zEUW6bJx7fOLKbN+uwK68M
         VyqA==
X-Forwarded-Encrypted: i=1; AJvYcCVq1i9uUfroKaN67tNamnOxdR4NCnZPuuNiF7TLM1ylgUlrESl4YlYRZvBgBGwjAKp9MHj2VFpCVHzp0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonKvb3/MInE1l9kVLVmz1XA5dox1qtaK+h1bRftdDky0HUukM
	2D6cEBcMPAhTF6YbA3lSXnc/vbwx0yAiec2xnhPQarpvWOJtk/ucJpBZ
X-Gm-Gg: ASbGncv1cxavLpvVxVoEQRy3Ox003FsrLIR907bPQI7Uhc/fO9jVVZ613gelnQExviJ
	6b3LPjj1CtRcAMDtSej1jidg4m6OiehqHm8vSgFDhCz0Z8JiBQJ1Zq34UQ4d/fc0ASHj8T1TUbr
	q0V1Z7SMDd30meM6mT0jnrpHi8LtmmGmRCGLuZ+gcuE5WX9QXj06tPjDFotx5+zCddBckDd6oAn
	jj63ARBNfJE369MgOKOGd0hAmKggbDHelk5QMKUzUjT6eMfjqNdwpRVSkbCDDqGpsp+Om/+GDD9
	txUWTPw4uRJDI3KvwmRc9QKr0XP++sFVXN3OO0j+5KZVd6Y0huP+oR32c7D8PIIeWQHupKH8jRI
	iH/pJBUN0R7hiZ5g0Tick
X-Google-Smtp-Source: AGHT+IGBD2iZAT2VlXMJEW/2T3OnRW/5IceBSHatfF1swKy5WFUb7kGAyVXVwSLkF/TyCFnIK2I5cA==
X-Received: by 2002:a05:6902:6c15:b0:e93:4a06:96cb with SMTP id 3f1490d57ef6-e94f64c9f8bmr3251284276.2.1755702789638;
        Wed, 20 Aug 2025 08:13:09 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm5146211276.9.2025.08.20.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:13:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Wed, 20 Aug 2025 08:13:07 -0700
Message-ID: <20250820151307.1821686-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820012901.5083-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 09:29:00 +0800 Hillf Danton <hdanton@sina.com> wrote:

Hello Hillf, thank you for your review!

> On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn wrote:
> > 
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed.
> > 
> > Instead of holding the lock for the entirety of the freeing, check to see if
> > the zone lock is contended every pcp->batch pages. If there is contention,
> > relinquish the lock so that other processors have a change to grab the lock
> > and perform critical work.
> > 
> Instead of the unlock/lock game, simply return with the rest left to workqueue
> in case of lock contension. But workqueue is still unable to kill soft lockup
> if the number of contending CPUs is large enough.

Thank you for the idea. One concern that I have is that sometimes, we do expect
free_pcppages_bulk to actually free all of the pages that it has promised to
do. One example is when it is called from drain_zone_pages. Of course, we can
have a while loop that would call free_pcppages_bulk until it returns 0, but
I think that would be reduced to unlocking / locking over and over again.

As for the number of contending CPUs -- I'm not really sure what the number
looks like. In my testing, I have just done some spot checks to see that the
zone lock is indeed contended, but I'm not entirely sure how hotly it is
contended. I can run some tests before sending out the next version to see if
it is higher / lower than expected.

Thank you, I hope you have a great day!
Joshua

