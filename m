Return-Path: <linux-kernel+bounces-852771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA633BD9DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F94F0E04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B9314A62;
	Tue, 14 Oct 2025 14:05:18 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94283148B5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450718; cv=none; b=Bfx0eOP5XfQ6NaAPPE9vDsXf2skpUJuCgeVv42M/oyAfikVTY72BHMneYK7obBWRahxKNpiZLhe3nk3GQMdbRlUqijzskhkIotEvSJBLa4fRD3XP5XxG3MPwC8AQ4GzFTEZQWudYLIrRdfOagR78dSoJ3Y0ER5bs4GMguBwATww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450718; c=relaxed/simple;
	bh=aCXpmIjkw0uWnQPYZDCW3PqKsAS5c+axQhh2OYEVMfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=obG5+gG0dqJq1v3DPZGKxHe8wt2jPmUkqLMOVvBdDK0FwjoiW6DF2dhb6hQDb2QnmS/0FueJseUo/LpqPkAkR8gtikdO4UsvnSw/95ZoWMLsJh5GDwMiUehNLEk0XD0hFxsG2RMgUidNvgyz+M7jo+xp+SXecENxbky4RanaCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EE5CuL092894;
	Tue, 14 Oct 2025 23:05:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EE5CtQ092889
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 23:05:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6c81ba07-33c1-44de-af67-4643afc7ea07@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 23:05:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] kernel BUG in dnotify_free_mark
To: syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <0000000000008b529305ec20dacc@google.com>
 <68c7c4b2.050a0220.2ff435.0391.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68c7c4b2.050a0220.2ff435.0391.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

#syz fix: fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

