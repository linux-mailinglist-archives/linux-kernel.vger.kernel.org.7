Return-Path: <linux-kernel+bounces-627688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91EEAA53C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303AD9A46C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F741C8FB5;
	Wed, 30 Apr 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EVvDZim4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCD25E817
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038041; cv=none; b=qmADPYRvO3CN/xfFsgKYVJjaNjsLyG3UIXHYD5q+4iEbEU7io9K8L+0RP78lgcJod4LUJXGNhJogjTYwE2fX3yCzqBsVr+XT4ZJmjpO/JbsauXdFoDm4BxYNKgduyWnAUDyVnnFt0Lt2QcZeRo0tJ2MkmcxHeGAjLFVRQimXAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038041; c=relaxed/simple;
	bh=3XmVokB/CifUAMIBnKlc5SdMT9bEBK4AljkT9etnU6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMDBLAgkJuaep+I2fdqufdA4KZUNeOPyJdqhvYu0ZAvaQ0aGz2dmf9/W5B3eS+Ke1MGxKYqNji4AFBwkT8e4+tLWKmrxqtUW4RhwuL7YXVrjj/3UejvoWzxdUFN5pdsC+DGhHU8yiO7KbNz3F34MzxkqEaqiqUfYkZ14oSUpEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EVvDZim4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so266460a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746038037; x=1746642837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIwuIgznvi17Hp6RFjo5Q2QMaBhu5w5IFRJKWtuqdac=;
        b=EVvDZim4PHuzY4ldp2os4l6hECzuIMqxehHqU5rkklEnIkri23tE+HShvoLYw3aN1L
         TuNqUT3PYRqey4/C8PrDmDe5AJ2O8Wff2G4WuDSkzDKKlPLNIKYOLf+BTGrGMBqXsPr8
         DOjsnGh3OMjPaUYFZS+zjUILgQhRMrHP3ZiBhAQWHWiMARY/OKJpFwfTXeqAM5rmcZGj
         ItUjeZxK9BSSVqGaVMRuZGB5cly0hE6WIy1y7yGXdAV0bAJY3dmrMk4UrVup6fi73FnL
         rwnvuibjTDVzoadvxG+L8C1EBqJ6GYNfsl63nPtQ91rRxX8fqC5hlyP36MrXoDO9l3BP
         cltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038037; x=1746642837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIwuIgznvi17Hp6RFjo5Q2QMaBhu5w5IFRJKWtuqdac=;
        b=ixbDh3nAY1yJ+/nS1YkhPVll1zjXD9/xuJxutAF74jlSwVvpIkvSqZxS+ueo9p/EeG
         9QjA7a6Ai9sWGCzuls52haKvX+OS/jfzE52qQLAA5WJu4ofziO4qQv7REFrvDMXKcng9
         J+v74GdF2zU8xCfCKxHvCqPh7Ny+rbwWxlWA/lZmatnsDqS5hazc3Fb/ooyHgijWJXEk
         Gn8kKqwQ+6tikitxgySkShPbtWhGyFV1wsHPafWHvqmVZWphkEmCi6FExNXgozpLkQKG
         zCiXUXIzrJsrpI5gmXMXBJPpAuiEGXOL/YK9ZauY3tXA5Mq/HY7XdbIlI3Tcg0FxXnsw
         N0wA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Mch0NUl2yC1AQDygM86fL9szqR2ATpJewE9z0ENAe4ooP8NwZFbdwgps2/QV4pPbKhHxuUqW9nFtQTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DQHAGriOTz3LsFMtUVKUfWIZRh0OGpbdb/kUce6o1Y1g/rz+
	65ogBha3BM/J/+0uAXi4wA3EWSB8vDnoBzQyjUD1ph+kCXEV/lO8Zt4Ex6iQ20M=
X-Gm-Gg: ASbGncuNj6i8AagAvbyT3pwE4upyveMDmuD4i3JNr6vA8mBrd8DwsXI8RWML4joOovl
	7U+Gy/QqqVy0ROQG63LFzeell3UQ7Hf9CrdCTpRx3dr/be6BKI/S0VGLdrS1tIxRTeDKt51l+5v
	V9u3zHOBVf0zwaHWVz+QC7/OYttkOkKwAMRWaqZN9eYL2JaLGCV8yvdnqZ9eBEex46oT9h8hp65
	osMDhsY0r5ZLcyn1zO4T2Dgi04YMBCD3M1wWZ9p53PMUc4dPQcBB9wVtdqAjxfzLrZKb58QOsA4
	EudICMkkpM8kiN77m1FA73uWN3c4FKNmbt/Ggm6qZ8A=
X-Google-Smtp-Source: AGHT+IG88zM/KKN9CmIYW/jIAN02wv66F1WQldIGaiBbeFZOI1UfS80/b8VS6aqUQAp09ki+ghY4OA==
X-Received: by 2002:a17:907:72c7:b0:acb:5ec4:e944 with SMTP id a640c23a62f3a-acef425c486mr40305866b.15.1746038037390;
        Wed, 30 Apr 2025 11:33:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acecefedd25sm255311966b.134.2025.04.30.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:33:57 -0700 (PDT)
Date: Wed, 30 Apr 2025 20:33:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
Message-ID: <kmmrseckjctb4gxcx2rdminrjnq2b4ipf7562nvfd432ld5v5m@2byj5eedkb2o>
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <6zxqs3ms52uvgsyryubna64xy5a6zxogssomsgiyhzishwmfbd@lylwjd6cdkli>
 <6bdac218-a18a-4cb5-b10e-c369d90b502c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdac218-a18a-4cb5-b10e-c369d90b502c@huaweicloud.com>

On Fri, Jan 03, 2025 at 10:22:33AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> I think the commit 76bb5ab8f6e3 ("cpuset: break kernfs active protection
> in cpuset_write_resmask()") is causing the warning I observed.


I was considering
bdb2fd7fc56e1 ("kernfs: Skip kernfs_drain_open_files() more aggressively") 
in conjunction (the warning didn't exist back then).


> writing to 'cpuset_write_resmask' cannot avoid concurrent removal of
> the cgroup directory. Therefore, this could cause the warning.
> 
> > As I read kernfs_break_active_protection() comment, I don't see cpuset
> > code violating its conditions:
> > a) it's broken/unbroken from withing a kernfs file operation handler,
> > b) it pins the needed struct cpuset independently of kernfs_node (it's
> >    ok to be removed)
> > 
> I am not sure if it is safe to call
> kernfs_unbreak_active_protection(atomic_inc(&kn->active)); after the
> 'kn' has been removed. 

Thit'd render the break/unbreak mechanism useless if unbreak cannot be
safely used. Users of unbreak know that they may get an inactive
reference. IOW in this part of the race:

                                                                         kernfs_unbreak_active_protection
                                                                         // active = 0x80000002
    ...
    kernfs_should_drain_open_files
    WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
                                                                         kernfs_put_active

the WARN_ON_ONCE seems misplaced if there are expected users of
inactivated reference.

For your concern about atomic_inc(&kn->active)); after the 'kn' has been
removed -- that's a different reference tracking (kn->count) and that
should be enshured by generic VFS due to existence of inode that pins
inode->i_private form kerfs_init_node().

All in all, the patch makes sense as a code cleanup (the deadlock is
gone already) but it doesn't tackle any reference underflow (I'm
bringing this up again because of CVE-2025-21634).

If anything, the warning in kernfs_should_drain_open_files() should be
reviewed. 

WDYT?

Michal

