Return-Path: <linux-kernel+bounces-728286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA61B025E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B583AEE58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8B2E92DF;
	Fri, 11 Jul 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="XpVhQpsD"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B423183C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266783; cv=none; b=t7t4byHoN6Pm4iDehXVEW3NC8vj2bw8uN+dRRTeyt9os/ajCyaJRuT6QexGpI6/xkDo3DtG2CG4C257fnO+N6xrHq/IjVJ3S7QWUH/6zwhJWyAX8fj1Y5BE1ntPGE7St2RznEAal0wdnxJcjz8Js0lzRS4xvkXmrsfTzdPbkWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266783; c=relaxed/simple;
	bh=AAlz/UNfwYp2GvbLqNZX+BzmyQ99uNNeAi7y95YMYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxqVK/1sA1/+px5ZQo8wt5QbusN1L7Qin5wad8kag4GGHkPjCZ6UCVgY517zvZNQH3d7b4YoAHmJsU3aEAsOrPYzs5P6Cv2sKdpbUcgJNFzRS82KRvOOcpCKuZoFhw5vkHK0aP/qS7fCW0CkAHhlPwrmZ7HNK4z6v93Ylh6OqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=XpVhQpsD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1605311f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1752266780; x=1752871580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V16pgEq2LoIwxvVcW28uJdtUBFBodUNrvMVaP4CH9y8=;
        b=XpVhQpsDYW/StxLnKydvD71/oQyFMsrwK4g5pTnBXeFG1zuhGLVyHQjahkwGTrp9K9
         3LtFXyFi/Sjo1aA5/UH/vHb3RA8SZL2c1ecdWAzyTumDXV+SpqY7K6C9xWUsoit8M+OV
         o+GFwcoeFnx/LgExkmpEDQWFaKvsJKPp6PaivI7o7pQu4o12pEda3oKcyQaHe5zeLkXy
         J7MUj+nDOxjw7DFlot4pXWTnfvlo5gDmiBF+aymmxBo9+x5qAAZFN4bEkl51/8QI6wyF
         cT+nb2pTVE2eZ0nyijU+JAtHp2BPpDJI/ffcYkaPA3k7iNcb3WHi/tfkDw27bFOVKP+7
         eYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266780; x=1752871580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V16pgEq2LoIwxvVcW28uJdtUBFBodUNrvMVaP4CH9y8=;
        b=P6Dh2FrmyqPHCJiqVv+xNSpX/eHgV8U13MCyfgt5xxhGgWNDHmQFp+GT7vGtNdqEUt
         fh/sZE1XEpjWqYjY0+Gwvnn1jYCZgMGelSs+DAXr4Ir8wSFMKde+As6lqGEnQE//EW3n
         wjhSgrrTYGl7zs1tTCgE+qxVwcQ4YPKS2TDrA8I5x0PKBjxzwXEf0myqH5LDa3I0Up5d
         g8e5QFKLDupn8UUsKx+KYAq/8FpDADjJFebsoIjd9VgxLTAV2NGb+xpwutltz32uov6W
         7828804VCzB7euRYzL40LjUQKh9obV5cn8mBj6GOJkaPw2zy86ZZ+zmhOLZk3wcLgOir
         //fA==
X-Forwarded-Encrypted: i=1; AJvYcCXfTW3E7HBSSP+X8tfQ8zAlwjhHUHdZSBbl9qy3uOrFcRR6vSZb6oxJVJl5BCFXGc0MHgxv066DGZ1qpC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrARPUG/heYRXtoGRcYzSRKtL1thCZPY2+5zuGNFpbz3uq6/5v
	NSxO/iHfTqUPf+qoHeS/nksJ0wLkTJBbR+qiRUxl+GburidM3fW7JIrYh5HgzClTAw4=
X-Gm-Gg: ASbGncsGZg8jz0QpfH3l1zb8KLDNQtNrhPywft1rNsvxsXbLUMEFM7PhOwZt6YrcHen
	a7ZKX21bCBOkolueBMjljqhfIevcEc6SOMKHFl0MzYWBPm4D77kXdivz1vPyVhfQM5pQ6kavvTw
	0jK1rlTZ9eWazQMQhwlJ8JkBRMZX/EkcGt+FxFTZGKU50Qe9u4hffeLwR3YZYW2xRu9+SqPoQ2u
	rG33j4nzh1f0WqZlUtSq+ztMxSDr6cZxK/yiDHj5JBmbcuRdwEqv3UKjzoBi+5N/CNSHpO2hINp
	xzilcG/Y+YGxbsr3qw0Mc3zKvlTDVlV6N2M+8Jv1OEdzPOz6atTB78QGNZlitCO3rKyqBoo9rYi
	zqSsHmH868a5teH+B8LQEQKCm9TnQeWbGgD+Yq4NuCG1trQ6vmFnpQbN8ygY5T4UMW6/U4ZLO3G
	rHGPbH
X-Google-Smtp-Source: AGHT+IHTqWllTe4YdW70kMG3P51HzHNZlYKrDtpT/RTO+NBYzPUEJ4+H3/CabZ+iQn7Kw1/H5a/Z0w==
X-Received: by 2002:a5d:4083:0:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3b5f18d3732mr3637814f8f.49.1752266779749;
        Fri, 11 Jul 2025 13:46:19 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm5349311f8f.87.2025.07.11.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:46:19 -0700 (PDT)
Date: Fri, 11 Jul 2025 21:46:17 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHF4GRvXhM6TnROz@equinox>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>

On Fri, Jul 11, 2025 at 04:04:17PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> We are seeing the same NULL ptr deref upon cdrom release, as reported
> in [1] (Chris Cc-ed) in our fleet.  Currently on 6.6 LTS (could be the
> same for older kernels as well, I didn't check.)
> 
> Phillip, is this a known issue?
> 
> <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> <1>[335443.339262] #PF: supervisor read access in kernel mode
> <1>[335443.339268] #PF: error_code(0x0000) - not-present page
> <6>[335443.339273] PGD 0 P4D 0
> <4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
> <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
> <4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
> <4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
> <4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
> <4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> <4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
> <4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
> <4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
> <4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
> <4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
> <4>[335443.339367] Call Trace:
> <4>[335443.339372] <TASK>
> <4>[335443.339379] ? __die_body+0xae/0xb0
> <4>[335443.339389] ? page_fault_oops+0x381/0x3e0
> <4>[335443.339398] ? exc_page_fault+0x4f/0xa0
> <4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
> <4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339432] ? blk_queue_enter+0x5a/0x250
> <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339506] disk_release+0xc8/0xe0
> <4>[335443.339515] device_release+0x39/0x90
> <4>[335443.339523] kobject_release+0x49/0xb0
> <4>[335443.339533] bdev_release+0x19/0x30
> <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> <4>[335443.339548] cleanup_mnt+0xaa/0x160
> <4>[335443.339557] task_work_run+0x6c/0xb0
> <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> <4>[335443.339577] do_syscall_64+0x7e/0xa0
> <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> 
> [1] https://lore.kernel.org/all/CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com/

Hi Sergey,

I have not been aware of this issue until now, as it pertains to the Uniform
CD-ROM driver, wasn't copied on the original bug report. Happy to do some
debugging by all means though. Please could you give me some more information
about how you're triggering it - i.e. is it particular discs? I am grateful
for any information you can provide.

Regards,
Phil

