Return-Path: <linux-kernel+bounces-852784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7FBD9E76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB847502063
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E6315765;
	Tue, 14 Oct 2025 14:07:48 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB50314D32
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450867; cv=none; b=GCG61tDcb7QJucKOfJFa31rItWpp8DUrNXOqURryH+v7t0CJwFKXekb9hl0q+wD8RzpS8GoY9/PG3wLV1UzbfCL3Sknh+p1nUrT6mBQxQxI98EFmM1K4Pw1ptTQ31nCnuNGirzSIUhPyZXzjZ4lPGeiRCgZrXXlBM2s57lOpIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450867; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aJ9c9qr5I8R7KNqg2YjWFmSCyPvDPiiazWIa1aJZEqe5KCqZQ3Ul3Mp7PcU/VcupEI2JvS15CMWsl306+k5zSrb+nb/KOoOeoqqUBRZwAxBRVu4g3cZYv4ZRpswVPet7Bux/rLR8TlhDgjKPUR36AyhWeKCyfFmgKh46y1VqvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EE7f12093308;
	Tue, 14 Oct 2025 23:07:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EE7frh093304
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 23:07:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <67aeccd4-69bb-4e67-98e8-2a15d5cbc707@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 23:07:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
To: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <000000000000e7765006072e9591@google.com>
 <676bac46.050a0220.2f3838.02c0.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <676bac46.050a0220.2f3838.02c0.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

