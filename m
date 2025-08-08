Return-Path: <linux-kernel+bounces-760651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD97B1EE39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E69567DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FCF226D1D;
	Fri,  8 Aug 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="T3HOqMy4"
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F201F2361
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676455; cv=pass; b=E8NA7WpcZSII4DFbvYIW4hTIVLH0mnrD6Qr0mcWQO1gHwI3nvvAiF4n+YpntPXHGgS+69peOZZ6lEzRJBd3t6n7HwTQi2/l7NUpKMJ/i6nEn//HmnxK0qnnrh3yvLhkkb86HAChk/L1c43WRbY0aw+c9Gy47UR0wLPh6bKnF6cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676455; c=relaxed/simple;
	bh=lqLL1rHT9tteKGy8KZaQ13zkFg3oKqafk68sXdy2+0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5+8p7y8OBI8t24CWQ/CyUbmBJZAmFos9u4tAwAl7Pb24P6k6MT7rhBuKBt2nNPt8KN4GFeSprpNn5dNK3JoGKa9vuH3Bl3aOzabUGkR4Rxssl7dgCaUIe6yI/0s59tXodKDoCI9Q/oMQrmcjNHwv2TkckLuzd07qC18nRLft7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=T3HOqMy4; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 462D9183BEF;
	Fri,  8 Aug 2025 17:59:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (100-126-76-136.trex-nlb.outbound.svc.cluster.local [100.126.76.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F0B21182671;
	Fri,  8 Aug 2025 17:59:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754675982; a=rsa-sha256;
	cv=none;
	b=Kn1PGI0SwwJBgRsbSRyUkXVr7tkG13jhonxIUg/kzIsI5RFpc+CGNs6zaR/lYG/abeF8QG
	gScGYOOytgvHMeBB9F/aUM9CZo2eiElzYZHVz2KWvz6BFqT0qD1+ygvXu5MxAV4xmZiJ8p
	hxHS6KdYOh07wAGYD+1OEGBLTtYP56V23+Q6ARiIsNFLQGbsOI8V/0u+532YXW5eP9czXl
	831AOzL6NxU/eUJPUahvTyaKzMVZvvBwKjfbRqFwBmsQRH1sYIfLn0v5o+bl3VK9eggFQa
	g+PgBcbAlbmMAhLb+TOit5R1QO9hMqUySo2Ez6GMooiLDDPioJmC5rf3KxFBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754675982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gGL73zxk4OzSU6R7waRddlbQJnqfpbstTWZ96TI8eLw=;
	b=LjhUxrpiiHqPyRcq9619O8FYiPVoiK17xgROgFfppq2cAmE6wZuKPhXuMqZgTmnmkFfhP6
	OiJdFfdJOueHZSnlc0GCutEEOqgwWkxIMIjuNEd1zG9E/f4ZEeb2+CoKKs6ziQwxJSlwZe
	HvvbstdD0yxhIj0JEinQSaI3QTTX456CZPpmiUcydfmJJOJULRBtEaf5wrPZNP1ojeN0JY
	Hf/KMS1bKkW9jAUHBpFLa6ZASpZBhxCVhn/pDDb4qs/xrttY401kXNFmms5EKSPKQUT2Du
	+xOX8E+2iVJcGoQjI4obrc7oRzXd8uFTHByOl4wby6vFSyaqxZmNFVnzMoYjhw==
ARC-Authentication-Results: i=1;
	rspamd-698857ffff-gbb7k;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Inform: 1d2b724a1f000a16_1754675984156_2734134785
X-MC-Loop-Signature: 1754675984156:3909658373
X-MC-Ingress-Time: 1754675984155
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.76.136 (trex/7.1.3);
	Fri, 08 Aug 2025 17:59:44 +0000
Received: from [IPV6:2607:fb90:9ab5:e54:f364:62fc:1576:4c11] (unknown [172.56.13.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4bzBcr4BhnzPc;
	Fri,  8 Aug 2025 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1754675981;
	bh=gGL73zxk4OzSU6R7waRddlbQJnqfpbstTWZ96TI8eLw=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=T3HOqMy4sraRh5Rub7ldx7z6WvxFcEAZOFc+ZvDCouaXFkCqeotx762bT/Uy5AYLX
	 xq7FG697n7CkDJRaCYPfzbBv8zIG1099WYyuqwEbUgGGHOJV+f9FZWPiYby3TS62/k
	 HOMQgwYW5rVs08w/X8O17/dPuGaemHmPqQFaIyUrIysDJB8TSQkjEDFK01hTp3y2Xc
	 BHMOkzmQTaK+IkUlNZDpJwf/28i6u4L2tJdN87q5BhaloBcReksG8gpp0OzrzgticT
	 yXD7BlYCBNlUH85uH1Gsxp7ukiHXsE9ghVcKnED3Z745VPiLln3utkmPE5il3Vy4+5
	 F30edp2eyuruQ==
Message-ID: <68c086ce-64a0-41e7-8c95-5252dceba0b4@landley.net>
Date: Fri, 8 Aug 2025 12:59:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Dave Young <dyoung@redhat.com>, Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, weilongchen@huawei.com
References: <20250808015134.2875430-2-lichliu@redhat.com>
 <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
 <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 21:47, Dave Young wrote:
> Another question, may need fs people to clarify.  If the mount is
> tmpfs and it is also rootfs,  could it use 100% of the memory by
> default,

If you want to softlock the system when rootfs fills up with log files 
or something, sure.

That was one of the original motivating reasons for using tmpfs instead 
of ramfs for a persistent initramfs you don't pivot off of. Plus things 
like ramfs always reporting zero free space (it doesn't rack) so you 
can't use things like "rpm install" to add more packages at runtime, and 
so on... I had a list of reasons I added initmpfs support back in 
2013.... looks like 
https://lkml.iu.edu/hypermail/linux/kernel/1306.3/04204.html

(Ok, the REAL reason I did it is A) I'd documented that was how it 
worked when I wrote ramfs-rootfs-initramfs back in 2005 because it 
seemed deeply silly NOT to support that, and when nobody had made the 
obvious fix 7 years later I got guilted into it by an employer who I'd 
explained initramfs to and they asked "how do we do the tmpfs version" 
so I whipped up a quick patch and they went "you need to upstream this 
before we'll use it" so I went through The Process...)

Note that right now initmpfs isn't _specifying_ 50%, it's inheriting the 
default value from tmpfs when no arguments are specified. If you're 
special casing 100% for rootfs you'd still be passing in an argument to 
the mount call to override the 50% default, just as a hardwired string 
instead of a user-provided one (and again it would be a terrible idea).

And if you DO change tmpfs itself to globally default to 100% then 'yes 
 > /dev/shm/blah.txt' could lock your system as a normal user if they 
don't change their mount script to specify an explicit constraint. Which 
seems a bit of a regression for existing systems.

This new patch is because sometimes people making embedded systems want 
to devote more than 50% of memory to rootfs while still having the other 
benefits of tmpfs. One of those benefits is not soft-locking the kernel 
if something writes too much data to the filesystem.

History time! (It's a hobby of mine. Plus I was here for this part.)

Tmpfs was originally called "swapfs" (because ramfs couldn't use swap as 
backing store):

https://lkml.iu.edu/0102.0/0203.html

It was submitted to linux-kernel in 2001 (Peter Anvin was "?!" aghast):

https://lkml.iu.edu/0102.0/0239.html

Tmpfs got added in 2.4.3.3 ala 
https://github.com/mpe/linux-fullhistory/commit/ca56c8ee6fa0

And almost immediately people noticed the softlock issue hadn't been fixed:

https://lkml.iu.edu/0103.3/0053.html

So the 50% default limit for tmpfs was introduced in 2001 (release 
2.4.7.5) with the description "saner tmpfs mount-time limits", ala:

https://github.com/mpe/linux-fullhistory/commit/80fa70c0ea28

Jeff Garzik wired it up as an alternative to initrd in November 2002:

https://lwn.net/Articles/14448/

Alas, the result was completely undocumented. I thought it sounded like 
a cool idea (it resizes automatically!) and reverse engineered how to 
use it (ok, mostly a lot of pestering people with questions in email) 
and wrote documentation encouraging people to use it in 2005:

https://lwn.net/Articles/157676/

When I converted rootfs to be able to use tmpfs in 2013 (link above) 
there was a rootflags= but not a rootfsflags= (ramfs was intentionally a 
simple demonstration of libfs that took no arguments) and I didn't add 
one because I didn't personally need it: the 50% default was fine for me 
and you can mount -o remount to change flags after the fact. (Although I 
dunno if you can change this limit after the fact or what would happen 
if you reduced it below what the filesystem currently contained, 
probably doesn't work.)

Although looking back at my blog entries from the time, it seems I 
mostly didn't want to deal with bikeshedding about the name 
https://landley.net/notes-2013.html#29-04-2013

A year later somebody asked me why rootflags= wasn't working for 
initmpfs (http://www.lightofdawn.org/blog/?viewDetailed=00128) and I 
basically went "fixing it's easy, getting a patch into linux-kernel 
requires far too much proctology for anyone on the inside to even see 
it", and here we are 10 years later with the issue still unaddressed. 
(Open source! Fixes everything right up immediately. So responsive. No 
problems left to tackle, hard to find stuff worth doing...)

> and then no need for an extra param?    I feel that there is
> no point to reserve memory if it is a fully memory based file system.

You're confusing ramdisk with ramfs (initrd vs initramfs). The 50% isn't 
a reservation, it's a constraint. Both ramfs and tmpfs are dynamic ram 
backed filesystems.

I wrote documentation about the four types of filesystem 
(block/pipe/ram/function backed) 20 years ago back on livejournal, I 
still have a copy somewhere...

https://landley.net/toybox/doc/mount.html

Linus invented ramfs by basically just mounting the page cache as a 
filesystem with no backing store, so when memory pressure does flush 
requests it goes "nope". When you write files it allocates memory, when 
you truncate/delete files it frees memory. That's why ramfs was just a 
couple hundred lines (at the time he was factoring out libfs so /proc 
could stop being only synthetic filesystem everybody dumped every 
control knob into, and I recall he mostly did ramfs as an example of how 
minimal you could get with the new plumbing). Then tmpfs added some 
basic guardrails and the ability to use swap space as backing store in 
case of memory pressure (if you have swap, which a lot of embedded 
systems don't; note that mmap()ed files have backing store, and 
executables are basically mmap(MAP_PRIVATE) with some bells and 
whistles, so you can still swap thrash under memory pressure even 
without swap by evicting and faulting back in executable pages).

The old ramdisk mechanism from the 1990s created a virtual block device 
(/dev/ram0 and friends I think) which you would then format and mount 
using a block backed filesystem driver like ext2. This was terrible for 
a bunch of reasons, unnecessarily copying all the data to use it and 
regularly having two copies of the data in RAM (the one faulted into the 
page cache and the one in the ram block device backing store). Heck, 
when you had a system running from initramfs, you could configure out 
the whole block layer and all the block backed filesystem drivers, which 
made the kernel way smaller both in flash and at runtime. Even before 
initramfs, ramdisks largely receded into the mists of history (except 
for initrd) when loopback mounting became a thing, because you can just 
dd if=/dev/zero of=blah.img bs=1m count=16 and then format that and 
loopback mount it, and you control the size naturally (no rebooting 
needed to change it) and it's got its own built-in backing store 
allowing memory usage of the virtual image to be dynamic (ok, you can 
mlock() it if you really want to but you could _also_ loopback a file 
out of ramfs or tmpfs to accomplish that)...

The point of the 50% constraint in tmpfs is to tell the system "when I 
ask how much free space there is, here's what the maximum should be". 
Since ramfs doesn't enforce any such constraint, it always reports both 
total and free space as 0, which tools like "df" use to indicate 
"synthetic filesystem" and thus not show by default when you ask about 
"disk free" space. Ramfs will let you keep writing as long as the 
kernel's internal malloc() doesn't fail to find the next page, and THAT 
is a problem because writes will fill up every last scrap of kernel 
memory and then the rest of the kernel loses its lunch when its 
allocations fail. (They added the OOM killer to try to cope with the 
fact that recognizing you've run out of memory comes not when you mmap() 
a range but when you asynchronously fault in pages by reading or 
dirtying them, which is at memory access time not a syscall with a 
return value. That's a WHOLE SAGA! There really _isn't_ a good answer 
but people will happily argue about least bad FOREVER. The younger 
generation seems to believe that Rust will do something other than add 
abstraction layers and transition boundaries to make this worse.)

Anyway, the perennial complaint about the 50% initmpfs limit was that if 
you have a small system that needs 16 gigs of ram to run, but you have a 
cpio.gz that expands to 48 megabytes, then 64 megs SHOULD be enough for 
the system... but it won't let you. You have to give it 96 megabytes of 
ram in order to be able to use 48 megs of root filesystem, or else 
extracting the cpio.gz will fail with an out of space error before 
launching init. (This was especially common since you're about to free 
the cpio.gz after extracting it, so by the time it launches PID 1 the 
kernel has MORE memory available. There's a high water mark of memory 
usage while he system is basically idle, but once you're past that extra 
memory is just adding expense, draining your battery, producing heat...)

The embedded developers have been familiar with the problem for decades, 
and (as usual) have repeatedly fixed it locally ignoring linux-kernel 
politics. I first got asked to fix it over 10 years ago, I just find the 
kernel community unpleasant to interact with these days so mostly only 
wander in when cc'd.

The author of this patch asked me off list if I had a current version of 
the patch I'd given other people, which I hadn't updated in _years_. 
It's been fixed a bunch of times, https://lkml.org/lkml/2021/6/29/783 
was the most recent we could find, but the fixes stay out of tree 
because Linux dev is aggressively insular ever since the linux 
foundation drove away the last of the hobbyists back around 
https://lwn.net/Articles/563578/ and became corporate "certificate of 
authenticity" signed-off-by-in-triplicate land with a thousand line 
patch submission procedure document 
https://kernel.org/doc/Documentation/process/submitting-patches.rst and 
a 27 step checklist 
https://kernel.org/doc/Documentation/process/submit-checklist.rst

(Which will usually still get ignored even when you do that.)

Rob

