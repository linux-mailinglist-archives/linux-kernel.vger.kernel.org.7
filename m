Return-Path: <linux-kernel+bounces-852903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D5CBDA320
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5357B5023C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5A2FFDC0;
	Tue, 14 Oct 2025 14:59:34 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660119D093
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453974; cv=none; b=lqX3sNZQZmKxEcHZ1QZJsYs/BBloUpSFo4sGAVrxvCPETqvMf8sptiXwtjjBRHow14XFJHRR2Leq+wniYoQqyA7iaQsoyUyz/fSsUJD18VznRcJpfmfhio1Hy2XVcjAJsbl8aVbptxx+0x/zkmr+2wfMAkqi66O56R3m2JPyZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453974; c=relaxed/simple;
	bh=Pe7SZtMJam45KWCoqEg7vdFDhTltPbuePEBl3c9BQGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvuwjb7QH7r4dHYafrvOcfD67XLeIWDKnF8ytPXFUv/eJ8be7GB/gLvEGI17UJMisOBCs0xHRwr6TsMSugxNL6GM6qxdCMShCJ5mtAUa2mKN7wpww5Dh4oFni/60TZa+jzjJtzGjwI+vyYjgpj99p4pmbq4987r4EokVLrrjTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EEx9Qo002315;
	Tue, 14 Oct 2025 23:59:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EEx9cP002312
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 23:59:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <04bd83f8-2a34-4756-8309-8f2fbdb0f239@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 23:59:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: prevent operations on NTFS system files
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com,
        almaz.alexandrovich@paragon-software.com
References: <20251014143942.643856-1-kartikey406@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251014143942.643856-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/10/14 23:39, Deepanshu Kartikey wrote:
> NTFS system files (inode numbers below MFT_REC_FREE) should not have
> their size modified by userspace as this can corrupt the filesystem.

Excuse me, but how can truncate operation succeed? As far as I tested,
truncate operation on files in $Extend directory fails even without your patch
( https://lkml.kernel.org/r/842b3b43-0a1c-4fe8-adff-94fdb2cee59b@I-love.SAKURA.ne.jp ).
Are there other NTFS system files which do not belong to $Extend directory?


