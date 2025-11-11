Return-Path: <linux-kernel+bounces-896167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C0C4FC85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73423B8DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201962E091D;
	Tue, 11 Nov 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDmdMGQ5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A72797AC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894903; cv=none; b=FYVmO/g/eLDAvpcnVqUalGrDbXTGWnI0T3DTF3cJvRbzeqc3NmhOUE8wsU7ckU8EW6QGYeoSV44EeeXhGzWYtVK5bSKyWLqk3asascCJFu2PN13T1oAG8pW1kiu6X9f5TtYCmqOL+Z1+gRYtqroEpKj1wVz5kyHax+ApbtE/pls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894903; c=relaxed/simple;
	bh=00mv0TjCUbXDRMs+VKrHJYkUdKXkKT462q4ka73JY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th92BYn9zTLK6Q6wAMhSVFJ+8zCFg0hmvPj6kHWzG+TmpgeaP84MNsbMHsW2mDr4cbx19V3IpcWgi/NEX58MvDGOBU7AaaKoj9UVEFbMPRmjStfB9uIvNcvqiEYf8Kmj70Fnc29tjEI89+iTTpT8V+F1L5CDn8Ak9K0ssv9DVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDmdMGQ5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso156380a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762894899; x=1763499699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOtZbxVqz3T0EH1q1J5hisXUupKcXN5oOYovjWYI2BY=;
        b=dDmdMGQ54eC8AihcZoP1DwUwOZ84UMouBumbPJmV7NyCMUXstvKJNRbpr/2i/Y8lAP
         RWc3Y6kUcJd7s41Il2BObfyPZBL7H9XOFTI5xHZhIM1am1rQ3ybdkwUpizbWuW+r4irl
         P06SHJbecjOuAqv2kzWfeK/dtBosGE5qa8DabdYshiD0Yjz6md3dVbL4LP/LTFK8VJ1S
         FhyaoQfZ813cmSsgU+jG5V6hhr33/xOdbcCujRuhfhtOdqRa8W6F+H52EygoTObM09gb
         Su0ABP06YmSP/zcJPGny4F00RnNy+vnvDR8J+mnciacD0gv5KjkbjJiF5R42GQ3pCF25
         pD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894899; x=1763499699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOtZbxVqz3T0EH1q1J5hisXUupKcXN5oOYovjWYI2BY=;
        b=LOB9rM+tz8a8HicwUBkDLnDY8GcpMOMN0IJowElohPYTx6KKbHHpE2MKDjbqLljoa5
         z+uUAQRHTv4zUa+T0sx05wa7qoAFTHkOG5WLQCskozcyUr5spWYs+bwNEIM8e3c80/u+
         lTsGNWcu8zE+NDdbtkZVDdizh3bsBE081i8MffM5/1xfuU01Z2CeXQDUY9m/iKQ8wPnM
         YwqAhY9pUOtv/sJSL5hSJw3zbh+nxYdnejkyl/O7btudI+DrdzTY9x8xJBhcscdsgqbz
         5tt0VD/jq4Pa3tCEmqqzEKQVg3DCANPicY7ZwGTvw63Vki8gCuVsPVrPDAhsvlcGc411
         qFGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMoSq7F5tpMxMa56G3x5Be0KawOcb4QeEl2o3V6ULSpBIncQl0hu+Ydwq47MdGIK458wiLmujr7IU3RKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOfHK0L3JU7TVia33NPPXMoUP4DLRvq1axmwV947+3pU7ENF7
	7CmZQDY4mqsX1D3ySTMavDdY39ZLZcle5stRkRfKg9WcdK3SCaKbvmWXnDkLALhC7Cc=
X-Gm-Gg: ASbGncswHAcdLwb8WAseaf/24fbS1M2li3nAAsoXm9yn393qlazS/N6kMBbHKU2W6qW
	mcSfi1zWUGC7jg8bIsTHWfXL7Q9MpoL+CJ7TTqk1H2vbYVvCLDcYpM9iR65GdyqNZpEQYyNIO9f
	1b1skdLSXpNZ/Ll1jGK8oUi+o382DJD39nwzyoNv9ZJUki7zxo9roPpNQNE/Q+lnHQP7ixah5LJ
	67LHlzJKBRdU7l4d7LFA/OjbpG+jDPqIIe2AK0L19RQljsNKY1p7wi5Ew3h5FQbrTOwE4YRL/4g
	ZAIsxUleBWYtQDzndGOO27XcZ+njGj95j5oGz4zb8DZhRaI0shxkhMu1R4JXBCR5XeAKE0RoVuu
	ci6exsecjSDibZwxg6IfFd/84JhtLiuXuXMbzceVNA2pDEXg6yv21Ey/2ntqySOBlduVSaxiyKI
	0ZxZjgF9UJ+pWNuDba/58KOhLP
X-Google-Smtp-Source: AGHT+IFHxQR5RsZZYuu15UkFc5wCGawdUUh/83F65t7RT/bR8gwY77ILDOKtOxH1D+cIwgNbNyoHRA==
X-Received: by 2002:a05:6402:42cf:b0:640:9d8f:3c73 with SMTP id 4fb4d7f45d1cf-6431a577ae9mr518057a12.32.1762894899315;
        Tue, 11 Nov 2025 13:01:39 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e12fsm14093400a12.34.2025.11.11.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:38 -0800 (PST)
Date: Tue, 11 Nov 2025 22:01:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
	lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aROkMU-OFAmYPBgo@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
 <aROS7yxDU6qFAWzp@tiehlicka>
 <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>

On Tue 11-11-25 15:44:07, Waiman Long wrote:
> 
> On 11/11/25 2:47 PM, Michal Hocko wrote:
> > On Tue 11-11-25 14:10:28, Waiman Long wrote:
> > [...]
> > > > +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> > > > +{
> > > > +	if (mem_cgroup_disabled())
> > > > +		return;
> > > > +
> > > > +	memcg = memcg ?: root_mem_cgroup;
> > > > +	__mem_cgroup_flush_stats(memcg, force);
> > > > +}
> > > Shouldn't we impose a limit in term of how frequently this
> > > memcg_flush_stats() function can be called like at most a few times per
> > This effectivelly invalidates the primary purpose of the interface to
> > provide a method to get as-fresh-as-possible value AFAICS.
> > 
> > > second to prevent abuse from user space as stat flushing is expensive? We
> > > should prevent some kind of user space DoS attack by using this new API if
> > > we decide to implement it.
> > What exactly would be an attack vector?
> 
> just repeatedly write a string to the new cgroup file. It will then call
> css_rstat_flush() repeatedly. It is not a real DoS attack, but it can still
> consume a lot of cpu time and slow down other tasks.

How does that differ from writing a limit that would cause a constant
memory reclaim from a worklad that you craft and cause a constant CPU
activity and even worse lock contention?

I guess the answer is that you do not let untrusted entities to create
cgroup hierarchies and allow to modify or generally have a write access
to control files. Or am I missing something?
-- 
Michal Hocko
SUSE Labs

