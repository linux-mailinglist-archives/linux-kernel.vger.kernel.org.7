Return-Path: <linux-kernel+bounces-788263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D893DB381F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38FA461C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496D3019A2;
	Wed, 27 Aug 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GK67/QbJ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63191D5150
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296546; cv=none; b=RvKksHbBz8+iM7ymTIZ+ppURHVh2P5YGLKFmgYSNr3RW6aox+PMTslvnZQR7P92Wi5NfbT/oZZlq2QFwT7McnyAz5zXUFqFkTW+Behummx6wIUkSgSu/7JbHRky2e63OUB7buLYBaJ71bPSASED8xTgWHw9ewW97PweJ1GweSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296546; c=relaxed/simple;
	bh=lwwYu4b7HkthZ4d48ibk8AcBNS5pBrB2LkFCKCQuKUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm2/kvXH27LKdZw7rOlgb7TT2X4Wuhz8fqiq7uJJe6Rg25V6+vBRWvMRGen7e8XGLH4dbFlY+EDsVZxFPGEGsZwsHX+svpT2paejSsG9jL+Yv+FAvXzeUfDKV6Gl18DiSu8mOUQCffLFcP9pmI7tXjyip3VF8Aw+tB7xurXJkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GK67/QbJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so992470366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756296541; x=1756901341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vX8WnxRhim6a/G891Mxzmq6M4cjiItYNLRPlcq6KrU8=;
        b=GK67/QbJhcRHzply699VVp/OZ0EJfsnNAKQDin4CwbD+AntTLXaGx1mpeiC/h5QXWB
         Tep9HzihPZUrNRg8nNvk3SWununGK3l1FikBMA4iLhs76BkhSRTJEgWiiKorFW88DOiH
         iQGOe7Ey/r8IpUNYzXPFGsOzSBHjxTIt//ts6EuEvHOToVY2J+fBslZG/Qo7fV3cAeel
         dAUzhhG2Hz9HLhygiXI65IoeiHfslI+mKNix+PiKHm4fn4y/KZRlCnlDKPkKVbl4UFLW
         n4YvcEsTmRBcY7J+2kmbv/7BEn/lPsvJ8eoT5jHUAz4/nFq2pFeeLxDF1xdAhXkmtIpm
         cZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296541; x=1756901341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX8WnxRhim6a/G891Mxzmq6M4cjiItYNLRPlcq6KrU8=;
        b=WvS449m7mmLy2uRb3FzQw1XLdXx/JLnNeFDvqaWXF53QUfFUVzVDsuUVNk6dDNYLsL
         4UQ/odrtPbhtT7uBo4FAxtwbOa48uPmpHSF2oJpgK347n+rnzoTZph1vqnNVtcECvmoj
         Qid/wyNallPg3rXcIhok8lMCY+2kITcktpaNyB4FNpIuHN81RDJTOv0RmcISwIlhoPWj
         GsBQbM+7z3NN5CP1PBhZeNk0xnINCFf/os+OarH2y85LYi+Bjo+8AR21c0lmp82DxfYX
         lp2qbU/ByXXY/kobPa+SCK6JR3v3YaYR3L3YvD4KSSNRUyadK1HjMH3s7q8TfXH9sdbm
         WjXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYNfs1lgDvrVK6exDkj69lbALOy6IZzGVNkaUcyMz3eGqCV+di/MndRgUo9F4GqUSV++r//zlqFS4sV5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEonzFgYtQRRS4QU1vE8MIM3td0EV9qwFl2y4eqzx5nRMDR8an
	nYiGu4//wKqnAgfz9tQbB617pMpHzPbJ5gAAIzLioft2ZKQeIpMzSt6/BqxfjXdjTog=
X-Gm-Gg: ASbGncsXs6T267SiEwOQGTDbrTtJXlC2K40qGjuEikQ7fSDY4GJG8DEHWQHifmz3v5C
	N7op0sTBIwbhUkNEsai7MwXmaIDxoyt7lStdKfCsNGocCiXeQvpbkbzPFURZv7+Lj3iRDWCXpkP
	k/XIqkFrJxliwzJD/wN6THDgrzRyD8t2oQaS4vHylQNEvmeLSfmvyJniQDlB3QTigIGjXsk6E11
	bvBkmE72jCJGb4PZDAcWXnPN/suSU+6rkgIvxUeNekZOveuzTj3bRZ8274//Og+uDx7y72WKc6H
	YSbLpGrp8Nke4PwgygHfqZkpfmFTRsLuxGexEUUrjvhnY7diJptMjLNcka8EVPhQ0t+z990YWvT
	8MxspXud+FFf7AO4g+MpPn4qHbeK/wxjN
X-Google-Smtp-Source: AGHT+IFkV6Q0CKt4qC6zznsx4y1Vd+1Uv+hwAtPFJ4LUzI7MVdaA7UgPt9OrIwzGQLCbth5PUkMCkQ==
X-Received: by 2002:a17:907:94cd:b0:afe:c767:2ad8 with SMTP id a640c23a62f3a-afec7672c80mr139290666b.31.1756296540875;
        Wed, 27 Aug 2025 05:09:00 -0700 (PDT)
Received: from localhost (109-81-18-37.rct.o2.cz. [109.81.18.37])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afeb049133dsm321386166b.75.2025.08.27.05.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:09:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:08:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v5 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <aK71W1ITmC_4I_RY@tiehlicka>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825133855.30229-2-zhongjinji@honor.com>

On Mon 25-08-25 21:38:54, zhongjinji wrote:
> The OOM reaper can quickly reap a process's memory when the system
> encounters OOM, helping the system recover. If the victim process is
> frozen and cannot be unfrozen in time, the reaper delayed by two seconds
> will cause the system to fail to recover quickly from the OOM state.
> 
> When an OOM occurs, if the victim is not unfrozen, delaying the OOM reaper
> will keep the system in a bad state for two seconds. Before scheduling the
> oom_reaper task, check whether the victim is in a frozen state. If the
> victim is frozen, do not delay the OOM reaper.

I do not think this changelog captures the essence of the change really
well and it suggests that this might be a performance optimization. As I
have explained on several occasions the oom reaper is not meant to be a
performance optimization but rather a forward progress guarantee. I
would suggest this wording instead.

"
The oom reaper is a mechanism to guarantee a forward process during OOM
situation when the oom victim cannot terminate on its own (e.g. being
blocked in uninterruptible state or frozen by cgroup freezer). In order
to give the victim some time to terminate properly the oom reaper is
delayed in its invocation. This is particularly beneficial when the oom
victim is holding robust futex resources as the anonymous memory tear
down can break those.

On the other hand deliberately frozen tasks by the freezer cgroup will
not wake up until they are thawed in the userspace and delay is
effectively pointless. Therefore opt out from the delay for cgroup
frozen oom victims.
"

Thanks!
-- 
Michal Hocko
SUSE Labs

