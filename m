Return-Path: <linux-kernel+bounces-794727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F9B3E660
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8806169341
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274533A01D;
	Mon,  1 Sep 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a4BaWx6f"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4C33CEB7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735109; cv=none; b=SaJXiel+uxb79MxmyItVVgD8qqd8EfDipuAjLGeK4sKSoEiiWbcFSRE6TW3KD/QmGsH+Gb6DbCP1R1laIJy4SvCfewEtQDzLnij5wrb8WgCa3dPBPFDUYblkbO2d01OdjxMribvRniGl6ZCNZCaSS8y4FOSwTVB+hxDxRT24WCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735109; c=relaxed/simple;
	bh=S0yLM5w3znPY0Axu0ZQ8jCfSkm8iJ3z72jLaz68LOvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzNMKFG/lrKh7A4vE7Aa6oVAk6cl80hjRbkHIZehzi63tqA/Qepy2fav4iYniNliE+bFN3I3dR6UY7mdpgl62KMNKwKqKC+/1RTd7y86SAItn6xyaUP95W7kf719U4DMOv8y3lN56dGlob9xri9cEEWF2Rtvrf+fzU0CDS0phNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a4BaWx6f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d4dcf3863dso913600f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756735105; x=1757339905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueYdCbMLexoztimExa3457paCNKQkUYPulx+AE/Qd40=;
        b=a4BaWx6fJvqwG4YMaZvQsvmrB6exVWaSntbs+GKKBLfmGKONXZFA0Rq9lGWLZelITc
         7i0aK0APJGB1klVt1gDFguMBHKeYxawfibk27nwawraeEYDCWnTCjLCycSgX4fI0HdGr
         tUEpfv1XTnC//ezsp4+UldoBKR2YUHohjSRc5PTB6LBN+TgOpIHG9oOmdQ+chZeRfEXv
         j0o7lkty6vvbljJmgK5NAYnlYJ+O5FnNECPIcIHDluo0Vrqo2LSPaob9ioBKi+S4NolF
         7zvN9qj9CFH/wcNJx0xDS00GHDlfU7wYiHTEf+8DRPDzDVdKk3qWtb0qpIoot2kMA109
         igWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735105; x=1757339905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueYdCbMLexoztimExa3457paCNKQkUYPulx+AE/Qd40=;
        b=utw/Ak3ueaCQ6qnt3a/7SpN6k0f9iRYHOXIRNcLD2lRbyAEkrJk0jfjVdgYoXoYx+L
         MSyAEh8A1QHVsLxp1IC+F7tFtQwHX0rsyjxeXQe4QG2U88RuyNYNXOEEodvLgGVD8Umv
         8LxucjrcetkqJ1LFcSqE03aNsKMCs3SdiXmC6TYlRWsAVRTnrSZT4qP47L3wAnOyH2kv
         Wf7QLbAQ2NH8GlIKODrJ9qcA3oJgD3MIX0JqN3dfJy0zDatuEN32faRCHwyFx6ySSpRc
         +eRuNLuzdFGjj67Q1QnSAYeaAAC0xEi7f2pFZfdy3ATsNshbuy5xzGycjIkvLbcz2UHE
         DktQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4+DWLFqse04tlIIVXd5NwfQrCWXyjd01TrD+QtCq3xteJTjXJoUHhycmerW5fKiYHdKWdWdglDWz5stU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNmUSuEOMtq3Z79Qj2pUvi1VdR0nxQ8lhM24CGN7D18Ob2kfN
	wIDmlGSpjJQKUU0Zcj6qipvRz8+skhD7UHwDQMfx0D62lVTVcZwundDQ5DinQXLQ0oGx5kZ15j4
	EImpd
X-Gm-Gg: ASbGncvOHTU8YTOqvjjK6tZ/mCTH3JmLeRBVvq+Z6wHhumvTw90SWwHo5iCK0vOkQTr
	MKCZbS5zSHFzJyKJWhBN2Pz5JSxXAIwQH5wTJtixZEQpMNcS4c0pD6A2MgIVPZFIP7VkbKG/xRa
	JgzwtQghVcDDOc90sXk1FnTHe3HTOodf90lVwJBFhlMY5+3v/CtxVTpSd/kea36DWnBB7iM8MQz
	0P3exSvuIHaPWlXdtK0edRh4MdxWKuJnqjlHoUuvKM4Wj3CJojkkOvpcDu4VECgIDRFtsXSMPfV
	ojbnbEYuSLyviSszOBluW6UVMnHuhtYG2GYoOSwuY1664kzMcR7ACd0XvWdSO9ezPf26CiSjki3
	4odTqz86UHMYZp23im2J0OJCMTEVVDfOWIFw=
X-Google-Smtp-Source: AGHT+IG2Yr2jjXAkZHUpidJxihTiVMsaYn3d05/QQCYWt2Zb9lpyUMvnPQCYNVDURtcLZR4iIeq9Rg==
X-Received: by 2002:a05:6000:2c04:b0:3d1:61f0:d253 with SMTP id ffacd0b85a97d-3d1df828682mr7655133f8f.60.1756735104898;
        Mon, 01 Sep 2025 06:58:24 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf274dde69sm15435253f8f.14.2025.09.01.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:24 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:58:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, fengbaopeng@honor.com,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liulu.liu@honor.com, lorenzo.stoakes@oracle.com,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de, tianxiaobin@honor.com
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <aLWmf6qZHTA0hMpU@tiehlicka>
References: <aLVKYz6C5bXYG1v3@tiehlicka>
 <20250901093057.27056-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901093057.27056-1-zhongjinji@honor.com>

On Mon 01-09-25 17:30:57, zhongjinji wrote:
> > On Fri 29-08-25 14:55:49, zhongjinji wrote:
> > > The oom reaper is a mechanism to guarantee a forward process during OOM
> > > situation when the oom victim cannot terminate on its own (e.g. being
> > > blocked in uninterruptible state or frozen by cgroup freezer). In order
> > > to give the victim some time to terminate properly the oom reaper is
> > > delayed in its invocation. This is particularly beneficial when the oom
> > > victim is holding robust futex resources as the anonymous memory tear
> > > down can break those. [1]
> > > 
> > > On the other hand deliberately frozen tasks by the freezer cgroup will
> > > not wake up until they are thawed in the userspace and delay is
> > > effectively pointless. Therefore opt out from the delay for cgroup
> > > frozen oom victims.
> > > 
> > > Reference:
> > > [1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> > > 
> > > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Thanks
> 
> Sorry, I found that it doesn't work now (because I previously tested it by
> simulating OOM, which made testing easier but also caused the mistake. I will
> re-run the new test). Calling __thaw_task in mark_oom_victim will change the
> victim's state to running. However, other threads are still in the frozen state,
> so the process still can't exit. We should update it again by moving __thaw_task
> to after frozen (this way, executing __thaw_task and frozen in the same function
> looks more reasonable). Since mark_oom_victim and queue_oom_reaper always appear
> in pairs, this won't introduce any risky changes.

Hmm, I must have completely forgot that we are actually thawing the
frozen task! That means that the actual argument for not delaying the
oom reaper doesn't hold.
Now I do see why the existing implementation doesn't really work as you
would expect though. Is there any reason why we are not thawing the
whole process group? I guess I just didn't realize that __thaw_task is
per thread rather than per process back then when I have introduced it.
Because thread specific behavior makes very little sense to me TBH.
So rather than plaing with __thaw_task placement which doesn't really
make much sense wrt to delaying the reaper we should look into that
part.

Sorry, I should have realized earlier when proposing that.

-- 
Michal Hocko
SUSE Labs

