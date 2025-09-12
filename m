Return-Path: <linux-kernel+bounces-814325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03ABB55272
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EDF1891657
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C030F54D;
	Fri, 12 Sep 2025 14:56:17 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173818FC86
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688977; cv=none; b=QFCjCK/YmhDT59E+DhYUcCx8ZyW5AjU9nTmdQGfbpW3u5VwVV4BjOSF/uKKU/xM7IPvB85yu5FQcivES+Qg73YnBRvrc2v4zgVLr32RfEhoR+si0g9NKmu5zwkYXQQINJpuWmUYWUIBkjQY5730GucYTEHnAiYI1IaV3sdv3kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688977; c=relaxed/simple;
	bh=mxL6r5Bs9UIW0nwPMm1ee+D0lZBJ3SIVgEz9Bd2uEus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQy0glVYcHZRLP6eUMs81B5MZ7ubzG+BY7wTYv+GR/9HpC6WAKkIlZFF3ha80BahvxD/C3bkqTvzpygk6rxrJOswL/tqlCetujT1NPVnOpZMeFRfIMUyNudo2WLRvLvA50v2l0MigucWrKaj023KSxeol8i6OIejUKr4Nrl4PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58CDnZPh045395;
	Fri, 12 Sep 2025 22:49:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58CDnZPg045390
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Sep 2025 22:49:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2ffa26df-5a30-412d-ab38-042b6beb1187@I-love.SAKURA.ne.jp>
Date: Fri, 12 Sep 2025 22:49:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] secretmem: use SB_I_NOEXEC
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>,
        jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
References: <20250707-tusche-umlaufen-6e96566552d6@brauner>
 <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
 <20250707171735.GE1880847@ZenIV>
 <20250708-wegrand-jungpflanze-a5940464908f@brauner>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250708-wegrand-jungpflanze-a5940464908f@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

F.Y.I. This bug is still happening; more patches needed.

#syz fix: secretmem: use SB_I_NOEXEC

On 2025/07/08 16:38, Christian Brauner wrote:
> On Mon, Jul 07, 2025 at 06:17:35PM +0100, Al Viro wrote:
>> On Mon, Jul 07, 2025 at 02:10:36PM +0200, Christian Brauner wrote:
>>
>>>  static int secretmem_init_fs_context(struct fs_context *fc)
>>>  {
>>> -	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
>>> +	struct pseudo_fs_context *ctx;
>>> +
>>> +	ctx = init_pseudo(fc, SECRETMEM_MAGIC);
>>> +	if (!ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	fc->s_iflags |= SB_I_NOEXEC;
>>> +	fc->s_iflags |= SB_I_NODEV;
>>> +	return 0;
>>>  }


