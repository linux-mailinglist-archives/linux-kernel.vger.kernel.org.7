Return-Path: <linux-kernel+bounces-724038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F1AFEDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AFE1BC071C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC252E7BAB;
	Wed,  9 Jul 2025 15:33:41 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370B17578;
	Wed,  9 Jul 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075221; cv=none; b=eV0PmC7DXBQOV81JRPAl6F4AkaWkNijw69am+GAlwdUb/I3GqqSuf+q5d/vpAaZxw0JIlGt2lV2fHxXxhbUVSmCvGiVPeItSPOH/Mlp1ECZsgTvmKLSGnfSIhwff0NosudtV4veoC+Kk8prMhbfGzkEP5uZ4gRg8+XY4wddQF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075221; c=relaxed/simple;
	bh=gQPhTpdl+CKVNNZyGf/LjflYEbCr0MV5RVav6zgi9B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfiVhPjQisFghZcaPkMi6UZNTm8Q0y1y+rqu0h30eT5aRMASNYBYl4i+T/xVlRou+ELdYbcINqRzo5Q8YlnvVAR87Cnf5+h4XEDByXQfdXr0b8u7aALBEiHL29oNk/1zspU5AqI4LueAbB9/5rmwbfXasv0ib+iapskSFfP4XLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569FX4eq082756;
	Thu, 10 Jul 2025 00:33:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569FX433082753
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Jul 2025 00:33:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <43189e93-2cad-429a-a604-15bf5cc95e43@I-love.SAKURA.ne.jp>
Date: Thu, 10 Jul 2025 00:33:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
 <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
 <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2025/07/10 0:19, Alan Stern wrote:
> On Wed, Jul 09, 2025 at 11:44:46PM +0900, Tetsuo Handa wrote:
>> On 2025/07/09 23:27, Alan Stern wrote:
>>> Which of these three BUG_ON's did you hit, and where did you hit it?
>>
>> kernel BUG at ./include/linux/usb.h:1990!
>>
>> matches the BUG_ON(endpoint > 0xF) line. The location is shown below.
>>
>> Call Trace:
>>  <TASK>
>>  hub_configure drivers/usb/core/hub.c:1717 [inline]
>>  hub_probe+0x2300/0x3840 drivers/usb/core/hub.c:2005
> 
> Those line numbers are completely different from the code I have.  For 
> example, line 2005 in hub.c is part of the hub_ioctl() function, not 
> hub_probe().
> 
> Exactly what version of the kernel source are you using for your test?

It is current linux.git tree.

  https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/usb/core/hub.c#L1717
  https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/usb/core/hub.c#L2005

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f27f70580000


