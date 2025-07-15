Return-Path: <linux-kernel+bounces-732460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C2B066DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38899565D43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4132BEC5E;
	Tue, 15 Jul 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hkHAjOSR"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02325C713
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607772; cv=none; b=ryrVQW3EruIotAiOcH0iqOvYaws5xbVhebPQSi62+I3/FamRy4p39/Op9wzDuyjJ7XebeW3Z8PtM/YVVeOy6ArwR+lWDUL0gDRVYsTvX0nDS9GdFSQP5rjHmzW3SbMzrtoUpMDgOhdRVeXRXGTtsmM2ImR1c463zNn/dtAocR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607772; c=relaxed/simple;
	bh=9zJeKzTRHVevMm7kxy2lCgzqahHeXAdAbMwfEa6E2Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfaj1IkKeUrpa0shDV1QX5ENvz54Z9EgMDXKwJkU27KWsRMyc1QW3W6zU8wEfJ/XoXSEfEFex7f3m/pUekNRKcplQ3PhoTcvT26b56XYWdzl/ZB+HIbNcJtHv5501du9hhvbCfVefLBvWKvKLyqlynk4i7oZ+swVEHBW9heL2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hkHAjOSR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso47460676d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752607768; x=1753212568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Loh5GQDiloUiD9GZ7ScpbDnX416undeoJbETPhllnVQ=;
        b=hkHAjOSRcZ5amyt9EeqvdvP2dlirbnWOboJWGuuBZ5OudENo9fDcf5kAmoGk3cA+fL
         wG5Xah1NgPMfZApRAaANZ5qEj4s5YgLbqsrEnmZE3nvVZ4EVVdvAN0vJ6i/PN4oClh1l
         dRpdhNdHds0Xr85KehMk81w7IPMqj8VEeStOvdQuNPnQjY1VmQsKQfHv/JJzZvBqhGCW
         HvGJwTLRFGgojRC3crjrjTfewBYdSt29G1Y9LMxq9iCjy/osT/Tc+j3vIe7wx6AIeSIR
         ciHjPbeXb2FDHPJq+OipnuXJhy93yKBYbmGHjeJEfAMr/dhlOMveWhBxPKD22qRlmrPP
         lMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607768; x=1753212568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Loh5GQDiloUiD9GZ7ScpbDnX416undeoJbETPhllnVQ=;
        b=LpmvEVF9sHkjMZ3AbSTsxB2DetNsW0SI2ZcYEZ5f6gbc/a492YhPH3t8DHcxBtlE8L
         YwNCM+ZytS957djuopZGlU6vEIQK8VR9eaUQKID0SFb+fWIstAfE9gsnCLn22bINQbP4
         J4XWSy3stN/M+TnJm7hPCWMwMG+9akyA9TL52SKGjW0G0jVtFmZk6JVACJ/KskjKluVs
         koND054LtdYNpg6dOX3DHqKOFCHsTPM31ue1d/dmJuq97tIzri7dVbp03r9LNCuf81xT
         cdOcLAralNEQW2BdrdurYNJnATgar1R9HyLJzCk8sbMUmqlFFdTItT3xF8DCbuuohvZF
         L73g==
X-Forwarded-Encrypted: i=1; AJvYcCUDHs/Sj6uWN+uinMd9DbtgoT1y+PcAl2mQE8XNZw5DzltsygzdpUz8fUVkVhUXs349egLY1k4HFNeyBig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3kRpvVSXOpjyh4qpJkNjVatwBNWIoiswVXvrg22M09h2nRy5
	P0rHm6FH/mz3FJex3szFENpRywUI9Qxm9OiRvpIGZ4twvknCCbWpwKN8iskyjd4yiA==
X-Gm-Gg: ASbGncuwh9pI8o10vEbBfLReZUwwKkP2+I5qA6TkFLyb1IN9scdRF+7d0s5dDsbwT5A
	BqJYL2c1gAOIOuZP0rvC7HHG8yetQzzDr1Hb8TkNjmSVv9C0tWmD38mDufyhBAoSzrFA5rlwLAE
	KMnWE8yWWrc4isZYkyijgXNb4JyprDZSuPnSzCLcWg/1qPOfguO0uWFyDeGgt0pIJp6Cy8cZo6b
	apPHgKbYZabI87V4FYdRW6Ehuus8KZGpp5ejEWnBx+cckW2dOhr5ftB4JryqzSBq8VRcKPttd8z
	kyBy1Lfr6vmV+9P+pKpIgdlM/xNW1TNuboGJBZoprSOqRY5N30Cy4EkNaJ4n8Mdrb87IcwOKs4Y
	EwCig9gqim19/gyhiqw5UHTqp1lrgs3+dbbgnluTLXMhQpq0mam2IDNHKGbgHxK8MGeBIlgk2ZC
	yGQsr5l3AF6ijLeskSZKvKoEuPJg==
X-Google-Smtp-Source: AGHT+IEr4XuG9GG+SVei+ldy19H8Vs3K7iAwtvPWvgTFHm6dk2vWEZOQi4+KzKEj69mM/Ew7hW373A==
X-Received: by 2002:ad4:5ca4:0:b0:704:8524:ca2d with SMTP id 6a1803df08f44-704f4809538mr8785246d6.1.1752607768419;
        Tue, 15 Jul 2025 12:29:28 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-52.harvard-secure.wrls.harvard.edu. [65.112.8.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d396e6sm60941816d6.57.2025.07.15.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:29:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:29:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
Message-ID: <8bec1698-5008-428f-8e71-ec002def0c54@rowland.harvard.edu>
References: <68753a08.050a0220.33d347.0008.GAE@google.com>
 <f6e67c38-8d63-4536-827c-09757a8d5609@rowland.harvard.edu>
 <ea7f1f42-273b-4c07-8bf2-769992dd9ced@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7f1f42-273b-4c07-8bf2-769992dd9ced@rowland.harvard.edu>

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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git c2ca42f190b6

 drivers/hid/hid-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -1838,9 +1838,12 @@ static void hid_output_field(const struc
 
 	for (n = 0; n < count; n++) {
 		if (field->logical_minimum < 0)	/* signed values */
+		{
+			pr_info("s32ton: n %u val %d size 0x%x\n",
+					n, field->value[n], size);
 			implement(hid, data, offset + n * size, size,
 				  s32ton(field->value[n], size));
-		else				/* unsigned values */
+		} else				/* unsigned values */
 			implement(hid, data, offset + n * size, size,
 				  field->value[n]);
 	}

