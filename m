Return-Path: <linux-kernel+bounces-796637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F0FB404E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D527D189300A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E930DD04;
	Tue,  2 Sep 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="zmIrKbm0";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="cfPTZzGb"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF392EFDB1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820322; cv=none; b=tTrGfFlVbI/AgQOZEUDwh9oV29DMJffq9zh2cOYBnywTqiC5OcvSO+uXszGsBdSsC/sFHz/+sgVx1cFMdHNRUh4Z3kVwIohX6r6PgU6Mub6o5vYGg6OPIcU3fFfR9ATYejh5NfQJY184sSQnY4D4gqX8ftqg6fcOOGNE0OmvzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820322; c=relaxed/simple;
	bh=U97gCFM6ANujxQVgOCJfSlGc8qJN502EHtLIHZ6ldhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4NZhDsE1sPCZiQ3MIgGonOKINfj1QVdnHVp9ia3tLTFcROcFw59Fsw4i5gR/v3dQzkG/h/2ZWNcUmYaJjOdtiibVK92LDTKev8fMsS01sR4yjZzas17kYEi9DobNb82/8nj1cQdErLFFBs/iHZrYOlN5nXjrWdhuMg6Icqe5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=zmIrKbm0; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=cfPTZzGb; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B1945209655A;
	Tue,  2 Sep 2025 22:38:37 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1756820318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwZdEDPvJgcmmCDousSc06KCvVKrry4Hq4hZoOWt70U=;
	b=zmIrKbm0gnyBRlFKcBs9U2U61ims95FtdEecrH2833ite0FSdJIzyvGoJQDiBphmU2Ymwq
	bSmaCFPORNkCSNEVQy4AY8RLy1GHptHVLL0NKUo6twfbwhz8VtlWuvppK327XVTmdH4jvM
	mi6RghBFwYF3pkkCs43HNFTqcp+ikMQhR0ir6rHFnAbr4HHJdYLZB2T39WfvSXTd49pwl/
	Z5aixLqxwX91FRIrmlBc5cqaaPbAk2HV4sXECYuV85QdV3XJcLUYm3esAcrrA7JH5w5KHy
	O6TI9GmKXCwmelcg8PGa7zpA/JDEXn9XeG98NyPq4LDiSKHElWU6IjiPzLRoRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1756820318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwZdEDPvJgcmmCDousSc06KCvVKrry4Hq4hZoOWt70U=;
	b=cfPTZzGbDF6z8dmKfhnKzlflPXxZ8Vr+01jnc7IISXRkOX4pgD0+Jb1Gpc8eB245gJ+cbr
	YShqDyxRH2I9IeBA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582DcaWg171354
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 22:38:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582DcagU418750
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 22:38:36 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 582Dcav6418749;
	Tue, 2 Sep 2025 22:38:36 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: YangWen <anmuxixixi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and
 fat_mirror_bhs()
In-Reply-To: <20250902132459.44-1-anmuxixixi@gmail.com>
References: <87tt1lowqd.fsf@mail.parknet.co.jp>
	<20250902132459.44-1-anmuxixixi@gmail.com>
Date: Tue, 02 Sep 2025 22:38:36 +0900
Message-ID: <87ecsp0yar.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

YangWen <anmuxixixi@gmail.com> writes:

> OGAWA Hirofumi wrote:
>> Sounds like strange. FAT driver never read the mirror FAT area in
>> runtime. Why did you think the mirror FAT affect to it?
>
> Thanks for raising this point.
>
> FAT driver itself never reads the mirror FAT at
> runtime, so this race does not directly cause runtime corruption.
>
> However, if the primary FAT on disk becomes damaged, user-space tools
> such as fsck_msdos will consult the backup FAT copies in order to
> repair it.  In that scenario, keeping the primary and backup FAT copies
> consistent is important.  If they diverge due to a race between
> fat12_ent_put() and fat_mirror_bhs(), recovery by fsck_msdos
> may become unreliable.
>
> So my intention was not to fix a runtime problem, but rather to prevent
> unnecessary inconsistencies between the primary and backup FAT copies,
> which can help later recovery tools work as expected.

You are forgetting what I said first. I said, this should be temporary
inconsistent. When unmount, temporary inconsistent should be fixed by
later write out.

IOW, I can't see why you claim this race can be the cause of permanent
inconsistent.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

