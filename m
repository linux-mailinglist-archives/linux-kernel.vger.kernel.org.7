Return-Path: <linux-kernel+bounces-720708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DFAFBF81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D296189E875
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB971D54E2;
	Tue,  8 Jul 2025 00:53:46 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40041C8611
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936026; cv=none; b=sVisFHURZLmuUFq4Yk1gvwhD4iKmtqv9R5CqtRscTTt/Orlg2r/I+xgcHZn7UCct/CygfhVNBSnTed1CRntqalY8DwB1HNzdcbho7XHwyb74xx8jEXd83+f/ckIvTlplgB/mTIfWk2qxz1F7zPEABf9EpqdPvoy5iCFogJIDwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936026; c=relaxed/simple;
	bh=L71YvKdbsnyzSxctlheGIVhUWFL7HKw4lIVFEzCDGus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAp7+hd1FCAg2QjOD29HWg/B5mQnoWaawF2lFa7XWJTUF5f5VQs8Bsr3MCll5GGBPVMW9sbgoAd+Mf5cKOCUakb38IWsYzVLr0+Jl21ENrE4iO0dB9nF8qZ5DTATS7hbamqqlo66wgaHLDKaFbwCxAODNirP0xuA5fGg9aN+PP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5680qJLw054763;
	Tue, 8 Jul 2025 09:52:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5680qJRE054758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 8 Jul 2025 09:52:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b8769d22-fa19-4374-bbcc-be3f06f420bf@I-love.SAKURA.ne.jp>
Date: Tue, 8 Jul 2025 09:52:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
To: Hillf Danton <hdanton@sina.com>, Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
References: <20250707005946.2669-1-hdanton@sina.com>
 <20250708001848.2775-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250708001848.2775-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/08 9:18, Hillf Danton wrote:
> On Mon, 7 Jul 2025 10:39:44 -0700 Bart Van Assche wrote:
>> On 7/6/25 5:59 PM, Hillf Danton wrote:
>>> and given the second one, the report is false positive.
>>
>> Whether or not this report is a false positive, the root cause should be
>> fixed because lockdep disables itself after the first circular locking
>> complaint. From print_usage_bug() in kernel/locking/lockdep.c:
>>
>> 	if (!debug_locks_off() || debug_locks_silent)
>> 		return;
>>
> The root cause could be walked around for example by trying not to init
> nbd more than once.

How did you come to think so?

nbd_init() is already called only once because of module_init(nbd_init).


