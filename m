Return-Path: <linux-kernel+bounces-854626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB20BDEE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A691357A28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A332264B1;
	Wed, 15 Oct 2025 14:02:04 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE691DF748
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536923; cv=none; b=nsNkLm5eL4CsE66C3lEp1L9bFAEFL+l62VA1OHuTDB37+xBtWlyfB/x8Ofm7VARBai40yM/Jg+efRHs0pOv3QNmdRiZyMF7U+SZDFhDwyD05XExSi8/XJMi92PV0moxCX0+gJZV6Ily80q1KKPA7fluBl5oETEVGaOlhBiDV89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536923; c=relaxed/simple;
	bh=+vBzEN3coPCSS7/a0ZO3MBiI3QLDwRnMFrRMVnnOThY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vA+Q0tOJ4GLVcff1kHkfm+XhECgiqbcs78zGMVHS3GPZnNcvejk0L1jYVufw/IMHm0zslbsceRtMcJkms1Oz1zskiruIEFWOhA+ITjUCUUjbteuuTrUh86JJKKX+SJP+I/q1acVD+alsztbobl+20BsbSt72TYm50kv9StEMBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59FE1oiO034212;
	Wed, 15 Oct 2025 23:01:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59FE1opK034208
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Oct 2025 23:01:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0610a0c-536f-454e-90ec-ac83ca0c7c28@I-love.SAKURA.ne.jp>
Date: Wed, 15 Oct 2025 23:01:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_find_init
To: syzbot <syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <68bbccf3.a70a0220.7a912.02c1.GAE@google.com>
 <66114372-5bd8-4f1b-8aea-1f6c4ec91bda@app.fastmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <66114372-5bd8-4f1b-8aea-1f6c4ec91bda@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

#syz fix: hfs: fix general protection fault in hfs_find_init()


