Return-Path: <linux-kernel+bounces-831361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC4B9C742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C98DF4E0F74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0528851C;
	Wed, 24 Sep 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eICe0/vB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CB27E066
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755696; cv=none; b=jStExnjEEp1QsnMVOW4BjR4hSKAz/gTk5iBFycsDRFtGYBIbGNVc6UhjMeA6NRQIfNbb8eyCgQZuMiuRbVkNWSh7+i6bvXbVEELVpzpdK57dQoCq+3SeHeVQ3zLCXJ4qxPquKNYIyTHEdwLdIWtWTRlluu6dFyysQ3NhssRjez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755696; c=relaxed/simple;
	bh=FHz9QvNr3N90ksVna8Xeih/dvbD0MgQximufPDav4Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtMru7/3+RmeeTMo7L9N/JftNMBIJeKcMn6k0iCXXvM/QRN1kPowGBtQbXWmAM/idw+VsXZago2sMB7/rzbFzv9T0PU2MkKWa4FtsvftVV3wh1mdpI/W8neYvdhYxnx3K/6fh40KSh3i2lPzCOiY4y44IzPMMDuyJNos9ppySvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eICe0/vB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758755693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrpUHrdvoFbiEj+xcfKgHlliFB9WZ5o8OArit+Bt6SI=;
	b=eICe0/vB3zDpUL21eTHbBfco4MBc8HoY1WuWWnyI+tI/o1moq4VTmIlHNlb8MeQBJSKVDz
	spXKefjg9R/wkmB8G8PcgJ0BQsAY0hJi7NpfWK8V6BabtKTqs/WJGUKmUNjjKlEXVtkh7F
	NUnJqTSjLPI/mHgKZHb+gFuo25bfXnQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-U1XVHneZOD2NYnSDn62bkg-1; Wed, 24 Sep 2025 19:14:50 -0400
X-MC-Unique: U1XVHneZOD2NYnSDn62bkg-1
X-Mimecast-MFC-AGG-ID: U1XVHneZOD2NYnSDn62bkg_1758755689
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8874f33d067so55526839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755689; x=1759360489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrpUHrdvoFbiEj+xcfKgHlliFB9WZ5o8OArit+Bt6SI=;
        b=M0rejBtdtodYTvA78+B3+vhx0IFr9vk9eUmfMx4Oalwu67FfHf/0Mgg1mmzPckdn0y
         8wDRU3XhM5CO57s2Og1bn6z8tA0qEIGVq5vsn9GBu2cwX9uWuzwIQrAFxf4RzZsvJqwS
         celnduQJdLbZpDDa9T7dwjvWVZ1gHBHNb6vqJ5Da4819zdPPdC22nqM/5MUnWkgIN+Rw
         dDxIQhoXrfRSJqytoTseltaKn0JJBVKOkhWJb5+EOGvmP42NuqW5dPiUdFgihHePQ0Yp
         Sz8OauRtLiJW2QElO/qJEfUzkXM6PU3Rqf+tdBfK0WEegccBD5rALqzcv/6FIZDSG1AL
         NUlg==
X-Forwarded-Encrypted: i=1; AJvYcCWc75BGz4tD44WT1KKlM1b2O/tufRCkUc6ihK4zc6IPtsSLv0+QPNYCwa5LKSI8LWYbFezOiVSlI3l0/BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQU2WaIUCGOEv4lLxzsiuoKdVl3d8+1brjCjXmHeXN9A7stIK
	5ltOysbjkhrZIAyD+2R++06vLuDNU6M22Jo68GrENpZyZzU+Jt7yKEoq0P6gGo3iOmn9x7KcJQH
	Bpf4YZKuNIAj6Fm+a3xU+XmfuPYNW8TJQW0obIfvrap44DWr/N0+4q9tLrKjcqnMbuA==
X-Gm-Gg: ASbGncu0SiC6VP4P28/wauViQQ+0z5zYv4wNUAaXX0JFDOS+M3QhRpHdQOBQLQqvLXp
	umy4+m89S1jji5qkB5zstVWWbaDpdXGCq+T37Fh7H+hiuR3xPxv4C/sURc3m3GdKiFo+XqR6hXp
	7TJX822XAJ84TTrV0f/hwBq+OWH9BzVKINW6fcsq4wTdbpQ6fxkKEjuWYorztJiK+Xq2fxHezW5
	eUslje1Zi9TW8p/FmwXTRuk1OITSpHc0tXlAO6VBEDrmUgi/fQ7cQdlyTgh27osVnXEfiiR+5hT
	wtkOoXG0ppysv/+iSm8NX67cRoAPmwSgS8tuLQCb/+tNzYyQDCMbQHCoAWFpLjoiRnGEtxe27w=
	=
X-Received: by 2002:a05:6e02:4419:20b0:41f:6b74:e238 with SMTP id e9e14a558f8ab-425955d01c5mr19617535ab.1.1758755689347;
        Wed, 24 Sep 2025 16:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcZ4Y1lj47HBIrBG1qA74lTGNhKIEIZ2hG7k1V0eNNq+JbBebLEu9zatMHXAoQMSoX044Ubg==
X-Received: by 2002:a05:6e02:4419:20b0:41f:6b74:e238 with SMTP id e9e14a558f8ab-425955d01c5mr19617375ab.1.1758755689015;
        Wed, 24 Sep 2025 16:14:49 -0700 (PDT)
Received: from [10.0.0.82] (174-20-23-24.mpls.qwest.net. [174.20.23.24])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6583ef2fsm200515173.31.2025.09.24.16.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:14:48 -0700 (PDT)
Message-ID: <24cb212f-fac1-48c2-8418-0160f92d9d84@redhat.com>
Date: Wed, 24 Sep 2025 18:14:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
 lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
 syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
 <aKaW9bi5INq7OwGy@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aKaW9bi5INq7OwGy@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 10:48 PM, Dominique Martinet wrote:
> Hi Eric,

Again, apologies, not sure how I missed this as well.

But circling back:

> syzbot wrote on Wed, Aug 20, 2025 at 07:58:31PM -0700:
>> UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
>> shift exponent 32 is too large for 32-bit type 'int'
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>>  v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
>>  v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
>>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
>>  do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
>>  do_mount fs/namespace.c:4138 [inline]
> 
> I thinks the mount rework triggered this one (full copy below or at [1])
> [1] https://lore.kernel.org/all/68a68b57.050a0220.3d78fd.0012.GAE@google.com/T/#u
> 
> From a quick look the old code bound msize to 4k-INT_MAX, but the new
> code accepts higher uint32 values.
> To be honest I'm not sure INT_MAX even makes sense as later allocations
> are likely to work :) but for now something as simple as this is likely
> to work (I'm not sure I got the test thing right, let's see...)
> 
> Shall I just roll that into your patch, unless you know of a more
> appropriate limit?
> There doesn't seem to be any easy to use variable about max allocation
> size, a limit of a few MB is probably sensible but I don't like
> artificial restrictions just to please syzbot so happy to defer to
> someone else here.
> 
> 
> #syz test
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 55ba26186351..cc65330ee684 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -302,6 +302,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>                         p9_debug(P9_DEBUG_ERROR, "msize should be at least 4k\n");
>                         return -EINVAL;
>                 }
> +               if (result.uint_32 > INT_MAX) {
> +                       p9_debug(P9_DEBUG_ERROR, "msize too big\n");
> +                       return -EINVAL;
> +               }

FWIW if we need to limit msize to a signed int, we can just change the
Opt_msize entry in v9fs_param_spec[] to an fsparam_s32 and anything
bigger should be rejected by the core parsers. The parsed value would be
retrieved via result.int_32 (vs. result.uint_32 here).

(I had seen {Opt_msize, "msize=%u"} and thought "unsigned" but missed
that it actually used match_int(). So probably a couple other spots
diverged with my patch as well, though maybe they are of less
consequence.)

-Eric


