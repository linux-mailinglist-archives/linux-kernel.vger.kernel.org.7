Return-Path: <linux-kernel+bounces-720762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A27AFC028
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931427AC366
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC4218ABD;
	Tue,  8 Jul 2025 01:41:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FF1EA7E9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938911; cv=none; b=iBbQRr6pgRbwkU7jLZ3CDyEOPh8eoYZNluWrdF8tHgzXem/2u/T9T47iOTHSkVXoLYvv6BqA13BNr7DxDezId7KHkmnaIldr21VqMoqn12XuXFSEGp/YZbmzH7kXvmFvCUXR6XSfUaA4p2hBkcMyb6eyvrXCbkTVh7+zej9ZVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938911; c=relaxed/simple;
	bh=JTYBR0cRdd+qGPbhlZBgIFsHHzvCLiingGYHaSBTq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGxEut1AeqRO1dF6cxgqz8ISP19luwNMA8DGs3tWf1Sl9neY+iKuSIJHFVHmcfJQBwMRp18nwAYT3xMI3izrluCs4O8j6NhTbkX/7eiarov0ywX20vN2iKgqJfhxQFTsA8auYX4hb8mr06eDaSiosPcpB3DhhCg+DLDD4m0obxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A90D7C0410;
	Tue,  8 Jul 2025 01:41:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3DC4220026;
	Tue,  8 Jul 2025 01:41:44 +0000 (UTC)
Date: Mon, 7 Jul 2025 21:41:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 David Laight <david.laight.linux@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "bsegall@google.com" <bsegall@google.com>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707214143.59ce744e@gandalf.local.home>
In-Reply-To: <c22ff02d1af74ccca59e3a2927da8e67@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
	<20250707195318.0c7f401d@gandalf.local.home>
	<92674f89641f466b9ebbdf7681614ed3@baidu.com>
	<20250707203057.1b2af73d@gandalf.local.home>
	<c22ff02d1af74ccca59e3a2927da8e67@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 444qc56z1491naqsyogsgxturqww7paz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3DC4220026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uCKJJ7wWvTQ+V0S+5tNXINWBcGXFdU+0=
X-HE-Tag: 1751938904-234604
X-HE-Meta: U2FsdGVkX1+JDmreEanZ4el4v8Fp2MUdrqxSj64xBjL9LelcdmDpOmO0s1b4bi158sE8L46BuOs0vfxboqQvrBslgsEvk4uqFsmYKiYbQSSX9eNPRh7sDBjXaz2Z2idnK+9FexW9VtusMzhZt44vbvp4LyIyAz4xmJh9/VRYOxi5aaWVbKCFWe0xUFa62/FL5QUxN3Ji4HaDzEyFtTz+6D9scm1dYJGz42wKPzDzYv3/3k7VnZJ5G5r0nID8UcCw6tiOIk4HEX9TfvMSQIJrAsRKzhRShQzyUfLN+VL5EFnkAurDJHeRA+CSqO+LFQY8jpMQ1ks/tN2yQYnQxPNwjYCkdDPxQTdK

On Tue, 8 Jul 2025 01:17:50 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> Stime is not greater than rtime in my case, (stime= 0x69f98da9ba980c00,
> rtime= 0xfffd213aabd74626, stime+utime= 0x9e00900. So utime should be
> 0x960672564f47fd00 ), and this overflow process with 236 busy poll
> threads running about 904 day, so I think these times are correct
> 

But look at rtime, it is *negative*. So maybe that fix isn't going to fix
this bug, but rtime is most definitely screwed up. That value is:

  0xfffd213aabd74626 = (u64)18445936184654251558 = (s64)-807889055300058

There's no way run time should be 584 years in nanoseconds.

So if it's not fixed by that commit, it's a bug that happened before you even
got to the mul_u64_u64_div_u64() function. Touching that is only putting a
band-aid on the symptom, you haven't touched the real bug.

I bet there's likely another fix between what you are using and 5.10.238.
There's 31,101 commits between those two. You are using a way old kernel
without any fixes to it. It is known to be buggy. You will hit bugs with
it. No need to tell us about it.

-- Steve

