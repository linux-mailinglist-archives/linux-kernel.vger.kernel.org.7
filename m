Return-Path: <linux-kernel+bounces-731092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA82B04ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC201AA712F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016D2D0C9E;
	Tue, 15 Jul 2025 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TnoAxYeE"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1C2D0C80
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550089; cv=none; b=DZ1V1DUYazA588Lg0uwAM6IWIjaFwasEiUYx3vI5feddeQY6hKnNa2AN/NanFxM1FtknETIzJSDRKhwKXlSH+4F4138Mk2atH/LlwErvAeafoX1u9JIJYbu/2H91uOFbDZI9NzPDawOh5+b8apE4ftIGXuzaKmqHFiPMnujcBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550089; c=relaxed/simple;
	bh=7mgRibT/ZbIOVW2Gbk6Dm4nEtSF/6zwBcPbevZ+QDes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI0W/FDshSyfcSoyaHH9FTqC93C4osfup9n7BRHy8rM2s3giaIkFApwisiu1mfhHbyZ7s6npqSwIZn7GCi7cWjjeU6mq0mcEQG8adM3xgl3GYieZMUEBCh+Wy+QhFbzlq3/VH6pWSb6KLwycO/KXdiigvO3PABSi0BqMk77viSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TnoAxYeE; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752550076; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=onbajrNl7Mu5K2loRN3gLibZSvvla6ZkA3tMQGBrn70=;
	b=TnoAxYeE91EDDySGuqECiVlQZP7AE+DxUyjCS9ZpJtRuX9IcrEvol56PhQ9mpH16cf1+aU+8z7yThcHMhHmTv88NXOx6VLQ/wstnwu99PfmhbAZUyTp+pe023XwuYFA9yB9HOEMuEcT4o5BnKSMiUXIG5PtnpaVZoeurYnv0x+g=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wj-pYY0_1752550075 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 11:27:55 +0800
Date: Tue, 15 Jul 2025 11:27:54 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Askar Safin <safinaskar@zohomail.com>, akpm <akpm@linux-foundation.org>
Cc: corbet <corbet@lwn.net>, "john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	paulmck <paulmck@kernel.org>, pmladek <pmladek@suse.com>,
	rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Message-ID: <aHXKuiqELS1tmchE@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
 <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
 <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>
 <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
 <1980bfc17f1.122b80ffe36544.5266293070616137570@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1980bfc17f1.122b80ffe36544.5266293070616137570@zohomail.com>

On Tue, Jul 15, 2025 at 06:48:47AM +0400, Askar Safin wrote:
> 
>  ---- On Tue, 15 Jul 2025 05:34:39 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
>  > I see. How about changing the patch to: 
>  > 
>  > -            bit 5: print all printk messages in buffer
>  > +            bit 5: replay all kernel messages on consoles at the end of panic
> 
> Yes, I agree!

Hi Andrew,

Could you help to squash below patch to 1/5 patch "panic: clean up code
for console replay" in the nonmmu-unstable branch? Thanks!

- Feng

---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f34de9978a91..a84d3f7f5bbf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4533,7 +4533,7 @@
 			bit 2: print timer info
 			bit 3: print locks info if CONFIG_LOCKDEP is on
 			bit 4: print ftrace buffer
-			bit 5: replay all messages on consoles at the end of panic
+			bit 5: replay all kernel messages on consoles at the end of panic
 			bit 6: print all CPUs backtrace (if available in the arch)
 			bit 7: print only tasks in uninterruptible (blocked) state
 			*Be aware* that this option may print a _lot_ of lines,

