Return-Path: <linux-kernel+bounces-746651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87405B12975
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0155E7ABBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F021578F;
	Sat, 26 Jul 2025 07:44:47 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAEFBF0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753515886; cv=none; b=NfCHcC/GhJkKy0kVG9tbepDOwqfajWEYHwiB05Q8IRJW1EAsJLzt8YzmHF7My+DgrH0+7E4lXygX9fRYRAt5XJtNGCLsh+uh5k6NdZXt/xPiJ3mZaeiph2ZsrRtpwgsfz7yc3AWb4hFqETShwWV4Wv/dbksamzxyVVtCPUgKT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753515886; c=relaxed/simple;
	bh=SNZT4vjxGO37TC9V9I8pqfMM/LQiCea8Y0ZeD99EIgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFDMANR8LEBwzWgVXVO/+RoZ2mHxx6ntxIc3ad2PQxEA1zBH1wnJ3DArYSuDm4N7SfiqD3l8+1Nl3eML6S9vyV4WQupE/MUnFiMopJ7af7rjTnhgTq8CwumfavsU+8a0veQV7bRawzR+vqPo/RbH6q7Uw0lvOEDomldJJ40tSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56Q7ifur087134;
	Sat, 26 Jul 2025 16:44:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56Q7ifxh087130
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Jul 2025 16:44:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>
Date: Sat, 26 Jul 2025 16:44:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
        Yeoreum Yun <yeoreum.yun@arm.com>, Michelle Jin <shjy180909@gmail.com>,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable@vger.kernel.org, kasan-dev@googlegroups.com,
        syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <2025072615-espresso-grandson-d510@gregkh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2025072615-espresso-grandson-d510@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2025/07/26 15:36, Greg Kroah-Hartman wrote:
> Why is this only a USB thing?  What is unique about it to trigger this
> issue?

I couldn't catch your question. But the answer could be that

  __usb_hcd_giveback_urb() is a function which is a USB thing

and

  kcov_remote_start_usb_softirq() is calling local_irq_save() despite CONFIG_PREEMPT_RT=y

as shown below.



static void __usb_hcd_giveback_urb(struct urb *urb)
{
  (...snipped...)
  kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum) {
    if (in_serving_softirq()) {
      local_irq_save(flags); // calling local_irq_save() is wrong if CONFIG_PREEMPT_RT=y
      kcov_remote_start_usb(id) {
        kcov_remote_start(id) {
          kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id)) {
            (...snipped...)
            local_lock_irqsave(&kcov_percpu_data.lock, flags) {
              __local_lock_irqsave(lock, flags) {
                #ifndef CONFIG_PREEMPT_RT
                  https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L125
                #else
                  https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L235 // not calling local_irq_save(flags)
                #endif
              }
            }
            (...snipped...)
            spin_lock(&kcov_remote_lock) {
              #ifndef CONFIG_PREEMPT_RT
                https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/spinlock.h#L351
              #else
                https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/spinlock_rt.h#L42 // mapped to rt_mutex which might sleep
              #endif
            }
            (...snipped...)
          }
        }
      }
    }
  }
  (...snipped...)
}


