Return-Path: <linux-kernel+bounces-796449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7093B400E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F0201CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115FE296BAA;
	Tue,  2 Sep 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="00xqAEye";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="P3or6Al4"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFB28AAEE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816721; cv=none; b=ed8zm7fpeLNmeQPeLAlZ1hbO869YCeED/yuUiCLU6eQMS5TdmTXx5xJSqz0QXv9eHn5cS8g1zT3a7Q1L42fva/qn7WmwH62V65faeXXcEnpVnCLj7HmdVzItceA60hxFNbM/q87aDn7cWB5OGoPbmSzgJv8raukQZ5GCWs1TZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816721; c=relaxed/simple;
	bh=jThU+++meS9ppr3EAIf5NOwVtwNMN0vgWGhAhSSblOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6lSeHcfAJQZcb6K2WuTndNq8eIaNsksYfHa9kjY0BecTSwjoNYKXUlS7CPnvQwqYxuhw6MmX/YyyAsqFSWXSsC+lLX+zk+Rp83cZ6m/wnglgJY00zU8a9L9cwgCwy9lRZ6ZM44LGMpjftXTCkr7xVeJiPf1tnCoOWlv/DAf1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=00xqAEye; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=P3or6Al4; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B75D4209655A;
	Tue,  2 Sep 2025 21:38:35 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1756816716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIF/tA+Fo0hPGcbjDwLE3QlOhJnBRKftfSGPX7JVZcc=;
	b=00xqAEyeBXZ9IfXS1O24CBGbFmiVrwtV771aqRhc7+I8MmYmSXS5W7t0DNdFDx6CS8gwY5
	Py1V1VxbRPP/uyqbFa5lVs3/I8nzSg3EkXB+4WAc9/oioZ4K2ElV3vUNSjqRb4KtP3Mf9V
	umwgRnlzR0jw/yNYu6Ay+WF6v+4GeRPqR67Xs3kn5ZDhREu+UQTqARsWtoGTp34ya2scOp
	w6hoZXMaMVDSu6f4sYieX+C5AKHNUYICyWOPQY7aDUy+kFqf9iH/7R7k0ZbirjsHL0bVlU
	5+Ady/bHflTxIKbYgJWmXHUr6QY1nJ7CrjdcAaQQQ4HrkwO0ySLX3+rBge4jWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1756816716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIF/tA+Fo0hPGcbjDwLE3QlOhJnBRKftfSGPX7JVZcc=;
	b=P3or6Al4xgHDDbj3GvmIAY59tATS0l+dIKay+r2Ar6ULEe2b761EF8ghNaSKr8+y5aVsDP
	9s7x1l3+M7zYG0Ag==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582CcYFb168934
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 21:38:35 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 582CcYFl413706
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 21:38:34 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 582CcYTc413705;
	Tue, 2 Sep 2025 21:38:34 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: YangWen <anmuxixixi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: example: fix memory leak
In-Reply-To: <20250902120717.452-1-anmuxixixi@gmail.com>
References: <87y0qxp6rf.fsf@mail.parknet.co.jp>
	<20250902120717.452-1-anmuxixixi@gmail.com>
Date: Tue, 02 Sep 2025 21:38:34 +0900
Message-ID: <87tt1lowqd.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp

YangWen <anmuxixixi@gmail.com> writes:

> On Tue, 02 Sep 2025 23:13:42 +0900, OGAWA Hirofumi wrote:
>> Hm, what is wrong with temporary inconsistent?
>> 
>> If it had the race with future modification, it can be temporary
>> inconsistent. However, future modification will fix it by updating with
>> latest blocks, right?
>> 
>> Or did you actually get the inconsistent state after clean unmount?
>
> Thanks for your comment.
>
> This is not only a temporary in-memory inconsistency.  KCSAN detected a
> race where fat12_ent_put() updates two bytes of a 12-bit FAT entry while
> fat_mirror_bhs() concurrently memcpy()’s the entire sector.  The mirror
> FAT may therefore receive a torn entry.
>
> Since fat_mirror_bhs() marks those buffers dirty, the corrupted mirror
> content can be flushed to disk.  In our syzkaller testing, this already
> resulted in runtime errors such as:
>
>     FAT-fs (loop4): error, clusters badly computed (421 != 418)
>     FAT-fs (loop4): error, fat_bmap_cluster: request beyond EOF (i_pos 2075)
>
> These errors occurred even after a clean unmount, which suggests that the
> inconsistent FAT entries were actually written to disk and not corrected
> later by "future modification".
>
> FAT16/32 do not suffer from this problem because their entries are
> naturally aligned 16/32-bit accesses, which are atomic on supported
> architectures.  FAT12 is special because of the 12-bit packing across
> two bytes.
>
> So I think it is necessary to protect memcpy() in fat_mirror_bhs() with
> fat12_entry_lock to avoid copying a torn FAT12 entry.

Sounds like strange. FAT driver never read the mirror FAT area in
runtime. Why did you think the mirror FAT affect to it?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

