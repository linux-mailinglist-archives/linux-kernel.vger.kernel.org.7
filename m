Return-Path: <linux-kernel+bounces-854647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C02BDEF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80D0501565
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02B25D533;
	Wed, 15 Oct 2025 14:18:15 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2E2627FC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537895; cv=none; b=AWxbE71bg97TJIw0libGj/su0ti7AQmFoT3XvXElu8Y+DrfedDly+Ygiv70T92KAc1pJREbXAs4bpiSuKpL6829nBZW+KNPcsCmq4A/Ps6ngvry5emUo6Wi5d/dqrNPOWVugFhI9ZhC0yB3Swm2L3BGiD++7cuTehpR1PIZTWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537895; c=relaxed/simple;
	bh=o+Uqq2rrwixiOflE63EhKy/zp72+iXMWcI4r+Nn767Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NPwfKHf7rijEG46cu8mM3jqBmGpLfIJApfN1s9TTp7Ux9eS5Q7StcdhYukoORSVFCFp7NTfnX5buEv0MB/mJnpsoDyWToLexh3fWVTCRKpBErL50WYgS7YQzPefMXuAC5LTvY031i5LwR1hu6YBZ05f/T3BYTBtvzPBZOtcDZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59FEI8Mj037169;
	Wed, 15 Oct 2025 23:18:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59FEI8Ht037166
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Oct 2025 23:18:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <75868356-8480-4c06-8354-51f7a8eb21d9@I-love.SAKURA.ne.jp>
Date: Wed, 15 Oct 2025 23:18:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_direct_write (2)
To: syzbot <syzbot+d5daa7d9e8e8d49ec379@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <689ff5f6.050a0220.e29e5.0031.GAE@google.com>
 <68dd026f.a00a0220.102ee.0058.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68dd026f.a00a0220.102ee.0058.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

#syz fix: Remove bcachefs core code

