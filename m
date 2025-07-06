Return-Path: <linux-kernel+bounces-712230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03113AF065C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 00:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1688E4E3E49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 22:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F6218ADC;
	Tue,  1 Jul 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j+9N8xKI"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085772820B9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407904; cv=none; b=i7p+dmUOZ5mDXsAvPMVUKqlO7zY9RStCjY+z4GvEkXqHNt8TnRGXdmhFhKZKKly8agZlX3c2FglYKX7PgPKldWmW5W9n6lkFuWw+tnFN2oVFEPQfx+k1g8xagZvID3Zav97KXV4xHWJC7+PlKe8Hwpi/hSIQySiFtmJMWwOjHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407904; c=relaxed/simple;
	bh=lbMGo6TWThDq7KR2bXJch7rViTDDcfpd9TbPVD0/+qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BdVWYDAjUp3YMeiwUFgLiOQDKAsfz+MygkKRtPffg5/B2XayTEGARZ5bE3A7U8i6ZtudliQEFni+mp0j82JOunCfD+ZD80U7S660JFsOmlpiD0nKYMHf3/AJCfKUU2NDbgMTqbTDRhKmbvM9yIk5nXEG0z9rOe6ohb+qgGhCVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j+9N8xKI; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so36985325ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751407899; x=1752012699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/C6lLyMUeqaFXwqsOrVIFnQt3qm9OCpZxXP3pjLWLMQ=;
        b=j+9N8xKIMEJeDZFRLHkadjXoOjxQcRFdv3IrPtuDp9zQiqdWiWgIQ27HGRrGzt+xQm
         6QZRd2akixnrz0Cexdg26X3HNPF1ihTICZV6nzHm6i9+KsQ4IOQ8C6dDB5W5f9ECUIsa
         GNNRosIvNswNcZwGCJxR7puSJjQo+5XW6LbjmUgvWkcJ+FJZuxKB4Qp42qdoX6DxYzUS
         i3Y+8N2x7nmx6r2PrSmEUDWEbEO2ouLlbWpr04dZf6ksRHSXr7C1JZxZkzx0VmJNP7gO
         PDnNvNeVdBbfXzrOrhH5RTMlGnPHMwoFpTy0PMBRK+xuxGu+P2F4wznM9KE2TH6lFUkR
         Cbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407899; x=1752012699;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C6lLyMUeqaFXwqsOrVIFnQt3qm9OCpZxXP3pjLWLMQ=;
        b=jy9O0DdY1l/tWIxBgArsDRvYXg58FDHXLqnR5snGx1AGF5eec5KkeiwhD2MdLEzdxy
         i01xV9HUBYPnPgCcIsxc7yGfP4msWySCZuaqrdPo7LPumVegPdl6vAXEhpaFgNMoEt3C
         Xkdj9+7YVsBvjxb9HrJRD1Z6Ubpz4BAt4a2OCH/xUSnB+P+ouGmOT/OJZPmDIrCNBfn3
         HiFGuoYR1BzbIJ4D85pMOkqr6MvAGENyEvx2j76S8/WxiJSXM7740ifHX8P6fSRjthBX
         K+y5g+LcTZn3a7aOpC+JFq2pnW9ltcHwpbBS9tSxS9lpN13nimTuEwUNuvFJgv6Pw3Sa
         tgAA==
X-Forwarded-Encrypted: i=1; AJvYcCWaW03IhNuIYcKEC/Cp6UCdHZPomaDXYAxs809L8g2S3j9KFANDb+U3Hlk2ikUAEH/LEw7/PX/9HbnP/z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC78FmobAu4kCuYQopvJpnTC72IzMyEnEVSerY3ZIJWG+sn8s4
	G8erUY9QY/S37OUXQU3PiNv2iTNgDx4wtesz0c0NIU9EYLDuXT7F8HuExD2jZyc4nxw=
X-Gm-Gg: ASbGncudAlYb1wh20AJyr1tLX+R/EDboYT4oZKCK6vmyf1UjkOh0R18jR/x4EQdmgRg
	hWjg0bNkW+cNSFbfZbcd7yG28LQksdwB7M95KIvPS7gvGFGvOuxrnmcw1qDN+9iDaTy41nTeCdh
	USHN98tFsb1IEos/qOjqU9BkXt+oelGhSJBa2dng2JUGULGqwUetivWiom5zp88YHWqISj48+6t
	pteeV7CF4y3Std/Ch7irbTL1iHpOlbsRc2ICOo4ihhGCpNxoQiAz3TLPXYJkX/uDkxbPWsxc3t/
	p0TK4CkAjPG+Bnfb/zucrrmyfzHmrxar50hETS4A2MeXmaFHpaX1x3iGXKc=
X-Google-Smtp-Source: AGHT+IHBL+x2rxNNPfn7H3hH8BaYEbswfG0ZtGkE794RnSeRPX6UIVwaxDaqDIxVYhRcKkCp3nEgUg==
X-Received: by 2002:a05:6e02:18c7:b0:3dc:88ca:5ebd with SMTP id e9e14a558f8ab-3e054a4d268mr7817595ab.20.1751407899020;
        Tue, 01 Jul 2025 15:11:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a0915a0sm32002225ab.45.2025.07.01.15.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:11:38 -0700 (PDT)
Message-ID: <90fa0bd9-71b7-44f7-9175-641d43e9fe1b@kernel.dk>
Date: Tue, 1 Jul 2025 16:11:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird delay introduced in v6.16-rc only, possible regression
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
 <20f07b3b-194a-4dfe-936e-0f159bf44485@kernel.dk>
 <69ea6e7a-a6f9-4199-9dc4-01b37092795f@gmx.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <69ea6e7a-a6f9-4199-9dc4-01b37092795f@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 4:07 PM, Qu Wenruo wrote:
> 
> 
> ? 2025/7/2 02:00, Jens Axboe ??:
>> On 6/29/25 3:45 PM, Qu Wenruo wrote:
>>> Hi,
>>>
>>> Recently I'm hitting a very weird delay when doing development inside a x86_64 VM.
>>>
>>> The dmesg shows the delay (10+ sec) between virtio blk and device-mapper:
>>>
>>> [    3.651377] virtio_blk virtio4: 10/0/0 default/read/poll queues
>>> [    3.653075] virtio_scsi virtio2: 10/0/0 default/read/poll queues
>>> [    3.670269] virtio_blk virtio4: [vda] 83886080 512-byte logical blocks (42.9 GB/40.0 GiB)
>>> [    3.672096] scsi host6: Virtio SCSI HBA
>>> [    3.708452]  vda: vda1 vda2
>>> [    3.711073] virtio_blk virtio5: 10/0/0 default/read/poll queues
>>> [    3.729879] virtio_blk virtio5: [vdb] 167772160 512-byte logical blocks (85.9 GB/80.0 GiB)
>>> [    3.737535] virtio_blk virtio8: 10/0/0 default/read/poll queues
>>> [    3.747045] virtio_blk virtio8: [vdc] 83886080 512-byte logical blocks (42.9 GB/40.0 GiB)
>>> [   17.453833] device-mapper: uevent: version 1.0.3
>>> [   17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
>>> :: performing fsck on '/dev/os/root'
>>> /dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304 blocks
>>> :: mounting '/dev/os/root' on real root
>>> [   17.871671] EXT4-fs (dm-0): mounted filesystem 00a85626-d289-4817-8183-ee828e221f76 r/w with ordered data mode. Quota mode: none.
>>>
>>> The VM is running kernel based on upstream commit 78f4e737a53e ("Merge tag 'for-6.16/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm"), with a lot of extra btrfs patches.
>>>
>>>
>>> The v6.15 kernel from Archlinux is totally fine without any delay.
>>>
>>> The v6.16-rc kernel may have some different configs, but the config is used for a long long time, way before v6.15, so it looks like it's something in the v6.16 cycle causing problems.
>>>
>>> I can definitely do a bisection, but any clue would be appreciated.
>>
>> Probably a good idea to go ahead with a bisect to help pin it down.
>>
> 
> BTW, a little more digging shows it's the `udevadm settle` causing the long delay in the initramfs.
> 
> The rootfs is an ext4 on a LVM lv, so initramfs is required to mount the rootfs.
> 
> So it may not be the block/dm layer causing the problem.

Even the more reason to bisect it then, if we don't quite know why it's
slow.

-- 
Jens Axboe

