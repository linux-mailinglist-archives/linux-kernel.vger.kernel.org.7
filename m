Return-Path: <linux-kernel+bounces-859026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD70BEC811
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45CAD4E410F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05924728F;
	Sat, 18 Oct 2025 05:28:44 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523739443
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760765324; cv=none; b=u2aLXm4WBLWfErUxeDwZStkx1aU4b2H0fsSG5clovg+nNFxrYR5pcGAb9/BvNzOD4Rq/W/1HDhG7IhfQV1gNj9NSX8zJjAh8jumTC8Mrl9+fhAjk2MeKFvWnhWw40cRyGUKHjcKsnG+R7bAIgsPQenDupqEKbijB1TS54YTXRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760765324; c=relaxed/simple;
	bh=d6qS3sMazyET5es1dfauU7Kfa9sZXLeTxfJ5kFAPT3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SPUhtwRix89RkVT7uwJ/vsOfXK3h2h1Xn55xL/CV0iD73zvRRkf02Ml7OQTzTaxs9wQVp3jdJaLT0fFRR42VCrOjAKReabJ+pBVmi3aj2Zpd+drSZiDlQLWXbnBuLkyI8gTdFMTWRUANmRrX2MMb5u/QIGKtEXYMdAb884NU8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59I5SWnE004830;
	Sat, 18 Oct 2025 14:28:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59I5SV1p004827
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 Oct 2025 14:28:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <40b7798c-c5a9-4698-8008-dacb2e4d31d9@I-love.SAKURA.ne.jp>
Date: Sat, 18 Oct 2025 14:28:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] INFO: rcu detected stall in watchdog
To: syzbot <syzbot+0bab26cf3949891fb534@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <68f2c9bf.050a0220.1186a4.051b.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68f2c9bf.050a0220.1186a4.051b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

#syz fix: media: imon: make send_packet() more robust

