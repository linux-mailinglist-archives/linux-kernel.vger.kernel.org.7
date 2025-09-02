Return-Path: <linux-kernel+bounces-797164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E04B40CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A91B619D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7234AAE5;
	Tue,  2 Sep 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ptMs6HRy";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="mRcnncoj"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A28345759
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836311; cv=none; b=bfcbKzrfyj3TQnqtmmRc885Pud+evgRI5Q9PayTS3DOkennRLfIPNfU6h+X1A/AMISrmEODdZhSNP8jvcxdnW5NMFECYz9/2BhTEcufx9ZXstFklxwmDCqJwlp3MHOHwb8+1nsP7csEfKEVBV9aj5fhqW7pVYxdVaPJ7pezoxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836311; c=relaxed/simple;
	bh=xyKvKic1Qltdc9PhKk7CsbIp+xWz0irCgHbKh1J27Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOemQYX4SSa046J2HrlS6saB9C4WNaiUiQ5mklBoKaBQroT3EP9aiK78/JhP9ZTzU0Fwtoi/xb+IphBl4dR5Sr4+VHkkzSvA/rAIe+ayqE/+1sCDcPMJ1VFW2uKaLM7ZHbFtof49ekfmaWoS+DgRH9ccL/d07nT5kiLhnY3a5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ptMs6HRy; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=mRcnncoj; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id CE4CB26F765A;
	Wed,  3 Sep 2025 03:05:06 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1756836307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOlDxXgt1LmAwrCF6dgvZbprMFEjda642u79QDT3ipU=;
	b=ptMs6HRyMxxXEiCrewlT4C7CGGHd7l+D/YnkoMWcm4eA7mLe1uGyQHu08XpgO0oBxAvHoj
	Mdc6C95H1fuJKSujG+zJW+bOCfVWbKED34F/+nEYJGMutfK+HbBZVhl6J3okbBewD8dFFu
	8acqR69PNC1sUeBzQ8twwMsbTauXG6IltfmnJ/+R2TvASsSqjnbQowX4k6oWBMjbEUGueK
	iSuDfNlTR0nfjAJHBaWoywLHkcHSjBqNnXzsBibKUwZaiI3H4gNN5J2bSK2HZpMhbEwLcG
	tlT0Zv8q2yYTBzaIOstJjje3ixjxzVaje13LYTkDcY7/4FQkAnoroyQoQhU/ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1756836307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOlDxXgt1LmAwrCF6dgvZbprMFEjda642u79QDT3ipU=;
	b=mRcnncojTB3dZakgSSDGemW1CclRtXXDAiMm0zBHBy2CQvOA05Gu7+CXi1quiFi8/t5rVt
	8GyO5/0h5zHAUkAg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582I555h179148
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 03:05:06 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582I55kH434775
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 03:05:05 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 582I559M434774;
	Wed, 3 Sep 2025 03:05:05 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: YangWen <anmuxixixi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and
 fat_mirror_bhs()
In-Reply-To: <20250902142044.9815-1-anmuxixixi@gmail.com>
References: <87ecsp0yar.fsf@mail.parknet.co.jp>
	<20250902142044.9815-1-anmuxixixi@gmail.com>
Date: Wed, 03 Sep 2025 03:05:05 +0900
Message-ID: <874itk20j2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp

YangWen <anmuxixixi@gmail.com> writes:

> Hi,
>
> OGAWA Hirofumi wrote:
>> You are forgetting what I said first. I said, this should be temporary
>> inconsistent. When unmount, temporary inconsistent should be fixed by
>> later write out.
>>
>> IOW, I can't see why you claim this race can be the cause of permanent
>> inconsistent.
>
> I don’t have a reproducer showing a permanent corruption
> after a clean unmount. My concern came only from KCSAN reports under
> syzkaller, and then I tried to reason from the code.
>
> In particular, in fat_mirror_bhs() there is a path:
>
>     if (sb->s_flags & SB_SYNCHRONOUS)
>         err = sync_dirty_buffer(c_bh);
>
> So with -o sync mount, if memcpy() observes a half-updated FAT12 entry,
> the torn value in the backup FAT buffer could be immediately written to
> disk. In that case, even though the primary FAT is later corrected, the
> backup FAT might persist inconsistent content.

Sync mount doesn't try to keep all of consistency. It is trying to keep
sync the minimum blocks for consistency. The primary should be always
consistent, however this doesn't care much about mirror FAT.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

