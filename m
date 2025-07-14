Return-Path: <linux-kernel+bounces-730637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3AB04772
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29861A627F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22611273D89;
	Mon, 14 Jul 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="gKsa2RFN"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11326FD8E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518331; cv=none; b=UgFByeM+qosqcvm8j2fvBS93TzCuJhBQ1atPlCK4uyJkz9zsnkxjT+9GhRH0OMYhyqJzFhx6Mkiv5aXPKfLFk7ZKfI/xXq1WuT9Dqzy1q1dvJwbVaDOx3JYOObVNL9xvi85boV14oPUrpzzVzqu3+60qdlJEx/+ND4mIKBpVBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518331; c=relaxed/simple;
	bh=v+uq+g4OyjBweK0mxCHTIPrZkKjorfxmAUt1H4XzEpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuxReYfxBmdUBmXeMRJZlWRpygCDtG2SLWaSOjf3M84rmfA2hkgpUE0YVKjepkAcg9pBNOcllT+YnHeyuT/z14jXj5ADQM8z4AO96qgWyU5TO1VNT1Pdc1NMiCk+TlOwrgHMojysYKOhI5t2dmDaVV+tvGDPHS9BZuZb4uzWejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=gKsa2RFN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e0d65a87e8so197160585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752518328; x=1753123128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ81tyG6lDybUwtkVxIVT9Bpwsku1w3Rk2LkeAkSMy4=;
        b=gKsa2RFNOzYe47ABWTkgzZeEnRNvn3mL/LAGBBHRprHTmv98w5sPtBGN0yBZz8iVWM
         hA8FKzBTwkZUxGwfoYQiAuWsaU4ebTK9oyMCnoaDAwvDEyFYf8BHHye1pHj7Znc3Xvmr
         eEpVkmlPVVd5MYtTIH4wvz3LtoiUVzQhYk9XBGLAz+GB1KaK4pgz3/mJOa6Ca0JB3/Mr
         6AQhuPK7uxvYWcg660krQKLn5YayFybSoyCwq+iqtmaI75hcLP1KFRFhIkTlBVwfJDld
         pLMk6xgCUx64X238yQLoy12zr7n+glm34b7eRC8EWrDpX4Jr/qEi6lkRlUssEitbxs15
         1zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752518328; x=1753123128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ81tyG6lDybUwtkVxIVT9Bpwsku1w3Rk2LkeAkSMy4=;
        b=M1l1c5ZPJV0iQGKc2c7HyyP7Dsz+rQoEW7fTiD+QLDpuqteCbiFyTGEMzuORNe85sE
         RnEyxKbA5u5zmh9jjTsPvb26T2uvkf8DmMUqu7TvdhAQOt+Tr9pjaWaXKTQcUWndpUtS
         sHk4sPT6cqkB+YB1D9POiSiZ7C/lxNiECF9BVzFxRidkpEv63MJ2zOrvF6B5a6TjRr/h
         i4b9EVA03OBfzJOkeZ4H+wXyo2T907C3xikU+R/fawHqZFgBeEqIzsZRlPmn6Qb1htiF
         Up8M6uaTxUSjKrpTpjaMh2+lTFei4WU0uL4axJliWhA11JQgCvpwrlPisxuPLu7YABu6
         033Q==
X-Forwarded-Encrypted: i=1; AJvYcCU23pHr86t3lZyJuWkzDJY7OrkAuUvChYKfEsFwj3imR1gEmLTcyZ0qt1FrwrVj/ANvwzGk3tf9DizAkes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGcUYp59Lok/l/6F1EKYYHVpkvNsK3cboNfq1i1tVdQ8SwIiw
	r6U+U7q1L7bZKYKKCnvGOz4w8C6QlR6uzq5tlAtte63KNkhlpmVcsYTnQwlO7aEyVg==
X-Gm-Gg: ASbGnctUX80pxUk4Oyo0pNaorybhsy6t7lIw9cHobY1M5TzdCZVRwibCaYlkLMQ43Lx
	KZACpsUXK9ULK+pfF2DrJ/auFm07i/7znkK/iYyZCRLz3a3iLGWXvVBwcpGBCfmfztpl8M2rN+f
	QQAKPA2tmohP+6LqZttAflpXZF77Nvl7sz1WlNlPOWq5OXYdTyjyzfkL2tjFODpA7DCQatW/4+H
	A6jGCtH6FUiuBbUrTIgu8mLw+QM/mn1NOvqdZP1O60DHNjSNkPUfkhmxLDrDZc+t/hDLgSfnMbw
	RLe2wT+v/JHXBP3xbaDNnFOmMJCXVL0onD3sdYwkMl7RjgcV/tAnTW4dJojm40B6+5xcUE2Fv5j
	E7EFv3nn7+EytjZw/2MZkmEY=
X-Google-Smtp-Source: AGHT+IG96/g+s03fjfH//zQP0o37+NStU8GCEDW/E8BjA9gFeNY6DH3IzaJB4R8vrILfEL1S691pzg==
X-Received: by 2002:a05:620a:319b:b0:7d3:90b3:28f with SMTP id af79cd13be357-7dde9b5fcebmr1881696985a.5.1752518327948;
        Mon, 14 Jul 2025 11:38:47 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e334178dc8sm54274885a.8.2025.07.14.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:38:47 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:38:44 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
Message-ID: <f6e67c38-8d63-4536-827c-09757a8d5609@rowland.harvard.edu>
References: <68753a08.050a0220.33d347.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68753a08.050a0220.33d347.0008.GAE@google.com>

On Mon, Jul 14, 2025 at 10:10:32AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b4b4dbfa96de media: stk1160: use usb_alloc_noncoherent/usb..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a830f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
> dashboard link: https://syzkaller.appspot.com/bug?extid=b63d677d63bcac06cf90
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1614418c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1257dd82580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7301552ad828/disk-b4b4dbfa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c559b38fa1b6/vmlinux-b4b4dbfa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9c1da8b2a83f/bzImage-b4b4dbfa.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
> 
> usb 4-1: config 0 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 9
> usb 4-1: New USB device found, idVendor=045e, idProduct=07da, bcdDevice= 0.00
> usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 4-1: config 0 descriptor??
> microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
> microsoft 0003:045E:07DA.0001: unsupported Resolution Multiplier 0
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:69:16
> shift exponent 4294967295 is too large for 32-bit type 'int'
> CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.16.0-rc4-syzkaller-00314-gb4b4dbfa96de #0 PREEMPT(voluntary) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:233 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
>  s32ton.cold+0x37/0x9c drivers/hid/hid-core.c:69
>  hid_output_field drivers/hid/hid-core.c:1841 [inline]
>  hid_output_report+0x36f/0x4a0 drivers/hid/hid-core.c:1874
>  __hid_request+0x1e0/0x3c0 drivers/hid/hid-core.c:1987
>  hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]
>  hidinput_connect+0x1ada/0x2bd0 drivers/hid/hid-input.c:2327

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/hid.git c2ca42f190b6

