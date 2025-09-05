Return-Path: <linux-kernel+bounces-803370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C9B45E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55579565B90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F19230217B;
	Fri,  5 Sep 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="C69dkyVo";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Qk2ea1Bs"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85031D72C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090233; cv=none; b=ZI2T+LPfhYTRWv1Yo1RQ4GnqQJgK11VxEciBaWrgijcWvZV0DCnBUIpjoSROC2PGeZIHOMYt+6+uAQlgUV3ydc92REdKm5jVvUeAG1dQTUzvAuGJ2iPMTun0vKkoMw46wqfnxY9feDeTRg/KrUqa/WRTy+2MjQkP5zT/Z71tQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090233; c=relaxed/simple;
	bh=sofE54YT1qF9RA6B6czOMDm06Z8ajhDsB5wvcToothc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7ceIIEBdwISJR77r3rPzCtb9pfmMVsEX89+ICcbZqGnViJgn0+/B9CJKXO2KulXMLw9IDmBlB4XCEGpYpWV6IK2n3Dq+1x8jucfjif2Ungyzqi/bFhomcNt8/roFqqPdqwoK0UvLSsaWeaaFB8nl3a3uHn74FDD1DTpYNsus+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=C69dkyVo; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Qk2ea1Bs; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2AB0A209655C;
	Sat,  6 Sep 2025 01:37:08 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1757090228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxYv8wvmwe8CZ4m5BCosbgsJRfJ3M/aSMrD/A1rZYhQ=;
	b=C69dkyVokZfWbIvGujXS4rsX+qj3Rj36M20RVIkud5lxg5kbYxbA0QdXJ4NiRb0zlpk+Ke
	SrNkXRCxgbRLJGaNWItsI42+L65yfLDwoRrAD5p4KtudSQptFkYIaEDhJagfqm872HpuxP
	+nmgUFqdEjeLnnSWXMy4WB0PiKuX7sX1et0YB6zsgJrF4yKbkxlqJeIxoahdjRFuH5IQ+4
	oZib8MHJZM5mve506BMwx+qusGJuM/1iG2BNOWPv3TjnX0Y8IqYEjjeq7eJGr4MuKq7uNC
	ZyGglOsCmSFpGaQTwJ1yiW2PfzuV3bURtlWokCLfg7p8/bTgwkNqy7U99icIHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1757090228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxYv8wvmwe8CZ4m5BCosbgsJRfJ3M/aSMrD/A1rZYhQ=;
	b=Qk2ea1BsC4S4RzKk9DplqeYW+NzKKa9otpdADp0fxBHRMUy2vdWUDpt9I6YdPWKi6FwXLJ
	OWXc586YH/B0PVCA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 585Gb6YZ035171
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 6 Sep 2025 01:37:07 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 585Gb6Pj073457
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 6 Sep 2025 01:37:06 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 585Gb6KG073456;
	Sat, 6 Sep 2025 01:37:06 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: zhoumin <teczm@foxmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vfat:avoid unnecessary check
In-Reply-To: <tencent_F5322517AD2A723568849905CF474A7D6C07@qq.com>
References: <87bjnqkpns.fsf@mail.parknet.co.jp>
	<tencent_F5322517AD2A723568849905CF474A7D6C07@qq.com>
Date: Sat, 06 Sep 2025 01:37:06 +0900
Message-ID: <87plc4n9e5.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhoumin <teczm@foxmail.com> writes:

>>> Remove redundant and unreachable name check code in dir.c.
>
>> Looks like you changed the logic, but no explanation.
>
> 1. In fat_parse_long:
> If (*de)->name[0] equals DELETED_FLAG, the function returns immediately.
> Consequently, the subsequent IS_FREE check can never evaluate to true.
> Therefore, retaining only the ATTR_VOLUME verification should be sufficient.
>
> 2. In fat_search_long:
> If (*de)->name[0] equals DELETED_FLAG, the loop skips to the next iteration.
> This makes the subsequent checks for IS_FREE and ATTR_EXT unreachable.These
> checks should therefore be removed.
>
> 3. In __fat_readdir:
> The same reasoning as in fat_search_long applies here.

Hm, IS_FREE() checks 0 and DELETED_FLAG, isn't it?

>>> Remove flags check in fat_update_time since fat does not support
>>> inode version.
>>>
>>> Optimize fat_truncate_time to return a meaningful value, allowing
>>> the removal of redundant inode checks in fat_update_time. This
>>> ensures non-root inodes are validated only once.
>
>> Also changed the logic, you removed the check of flags.
>
> Changing the return value of fat_truncate_time and removing the ino check in 
> fat_update_time is a minor optimization, as mentioned in my previous patch email.
>
> The reason for removing the flags check is that the enum file_time_flags has
> only four values. Since vfat does not support SB_I_VERSION, higher-level
> functions such as inode_needs_update_time or inode_update_timestamps will never
> set flags with S_VERSION. Thus, checking the flags is unnecessary.
>
> Note that __mark_inode_dirty will not be called only for the root inode. This
> logic remains consistent with the previous version.

OK, thanks. I got the reason.

However I would prefer to keep the current code, for readability and
future changes, and explicitly check those time flags if there is no
measurable improvement.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

