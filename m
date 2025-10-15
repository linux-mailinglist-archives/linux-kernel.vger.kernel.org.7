Return-Path: <linux-kernel+bounces-853711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92BBDC641
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1041018A6030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABC296BBB;
	Wed, 15 Oct 2025 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvaO4OEw"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232425F7B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500815; cv=none; b=COe+9XUVB+agXx19w71MIHE5lOkEQ/Hkt9wl3XrBcsc6lLUsSLhy26wfN7al0yPuTHYUN6d0WNr7PHRQIGpZq3xSU+EAqQyzse1HZUGHppPOqFdL+4G09d/UQLeOWyK8panWwUGg1OfRgAJzpXV2RMYA0WdGEtNIoxcLL9AKBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500815; c=relaxed/simple;
	bh=90nu5ejHTH2w8klUmkUE2g2YVvl4bXSM55SkccFfof4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuyuVAOt/cmxZY1NpqauA44pWcXd3HJOB/7T41NYAvbqflJaQQVpMa0/J9bcnsnZszGli+rqArcUbDRjgIVKz759syJTFc/FuD5pg0aF6ua3FGO51eoezZ7PcqazSiEU4/s4eNqAeEvTEtD1LgNUz6wFFET5AsF0u8ysgEXnKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvaO4OEw; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-637d39f35ffso1029578d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760500812; x=1761105612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25O4kccBtnC+yQP8jxbGfZ4sEqGyW1QY7yhZGOqsgSw=;
        b=TvaO4OEwSFY+CtvLrdrToEhycnBkMVJbL6hvx/UDQS6rsc0JIAOSnRDRgdXAkCgIgP
         YtFbmI36LwTJGgtdezf3+dWXT9k41LPQCP+DJob/Kbu/EQUlRfH6kq07GTR+ambBjytk
         tITM2zihHbbacupouRfL4NXfA+p4ERKdv1dhSV5Eq5tjEixLp4fgeOpFe9+7OFN1A0gv
         FOE7PTVSCmAKB1ynn4zhn0asHHhcL0BVTF7n6GKpkNH+efwtx8sXi4bMEYYEMqEltwZc
         AQ04UCB/6AW+aCPIWUFgzAkDaDmjx3pYDNYYF0uiLKB96wkMqKmT4AfWYSEHUQMPTN/z
         Fduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500812; x=1761105612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25O4kccBtnC+yQP8jxbGfZ4sEqGyW1QY7yhZGOqsgSw=;
        b=ux/AVetyyXCZHJGudT7QmmYUiuJc3EYi7OF/nrjuRE4nzkbbdr+20ickwp2jFJ2lAL
         XsnJG6ZOr+ghY//4NlOXF4uXWMm1iXfwmlokw1NJBOy7svwpThRsp0Yict+JcvT5ZSX4
         +JMfGPKstJYBquY1mcrjFe5lphOH/65JF8zC+tLdg25+dzFQUw0AEcT/b3VnLE6sqF5v
         1SxawGiGKIbX9TaNxV0NOybqAEG913zA741ASQQ+7dcW1N6MUr1fJ+Ny72c17Q84SIoh
         9UwCDEe1b3+dyJqfKhQCEQBX4BVux4kALTaPASVCq/HZdDDNfpxZ1R3c9HiG50kb+OCD
         Fzfw==
X-Forwarded-Encrypted: i=1; AJvYcCUcY340CyIYfSi/H6DGyV2AAifOOcOeisT2QMB250Q/+6zsHJ9SRqNSoSr7DOPmHQOxigkdlcf5NrQ+KiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOdh+UsPj87eWnPEkKR8Rbdcweu5cOrHAq+uMFW9bqh6m/72GA
	3tizIHN4nn6g5VauFiYkX2vmwGP8MDynknx+e7URf3LBwO9QFRbIuh5lRLG8nh3VkpOZ1j5uuWp
	5ZIDAPJDDFjYdwwYFmRmguWDJTfJOeCU=
X-Gm-Gg: ASbGncslQVzTDVTnzhWCk+s+67UrsUVRf8o1pfRW2zBCSCUYZjkbfymEfuH8pkgzi9J
	ko9MwNiqokkG7PHoplLyUDjockbPAR2s9AzkJNmVfSp+sJZx8H8+WXf3VdM/lMyew7uZF+GV/Ly
	BuxMiPbq5FImkCpAgDKc2ZBQsS3DEJ3cRToXmoYqq1B68C9QtiFpufhw==
X-Google-Smtp-Source: AGHT+IED0UlnmL4L83CwbEMWuT9hnx95y7m8K9g4G+HJg0uh5+EYc8jM5ktVZ+SDbGi9vIq6uZXpbcsCWtPQllqm9tU=
X-Received: by 2002:a05:690e:14c2:b0:63b:8310:512f with SMTP id
 956f58d0204a3-63d2bbfc1b3mr895279d50.2.1760500811682; Tue, 14 Oct 2025
 21:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com> <aO6N-g-y6VbSItzZ@bfoster>
In-Reply-To: <aO6N-g-y6VbSItzZ@bfoster>
From: lu gu <giveme.gulu@gmail.com>
Date: Wed, 15 Oct 2025 11:59:59 +0800
X-Gm-Features: AS18NWCI-ReyqwcFNhsZ-B_sbfBvh0sSMR8SdI7jeAAmqbyu7RffVJhCQVnxB48
Message-ID: <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>  Attaching a test patch, minimally tested.
Since I only have a test environment for kernel 5.15, I ported this
patch to the FUSE module in 5.15. I ran the previous LTP test cases
more than ten times, and the data inconsistency issue did not reoccur.
However, a deadlock occur. Below is the specific stack trace.
root@ubuntu:~# ps aux | grep ltp
root       15040  0.0  0.0   2972  1124 pts/2    S+   11:26   0:00
/root/ltp-install/testcases/bin/doio -N iogen01 -a -v -n 2 -k
root       15042  0.2  0.0   3036  1320 pts/2    D+   11:26   0:01
/root/ltp-install/testcases/bin/doio -N iogen01 -a -v -n 2 -k
root@ubuntu:~# cat /proc/15042/stack
[<0>] __inode_wait_for_writeback+0xae/0xf0
[<0>] writeback_single_inode+0x72/0x190
[<0>] sync_inode_metadata+0x41/0x60
[<0>] fuse_fsync+0xbf/0x110 [fuse]
[<0>] vfs_fsync_range+0x49/0x90
[<0>] fuse_file_write_iter+0x34b/0x470 [fuse]
[<0>] new_sync_write+0x114/0x1a0
[<0>] vfs_write+0x1d5/0x270
[<0>] ksys_write+0x67/0xf0
[<0>] __x64_sys_write+0x19/0x20
[<0>] do_syscall_64+0x5c/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb
root@ubuntu:~# cat /proc/15040/stack
[<0>] do_wait+0x171/0x310
[<0>] kernel_wait4+0xaf/0x150
[<0>] __do_sys_wait4+0x89/0xa0
[<0>] __x64_sys_wait4+0x1c/0x30
[<0>] do_syscall_64+0x5c/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb

Thanks,
Guangming

