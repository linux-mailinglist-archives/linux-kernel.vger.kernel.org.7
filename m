Return-Path: <linux-kernel+bounces-729169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD1B032BB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122E63BBFF3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B92857FC;
	Sun, 13 Jul 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="uN0ieuy3"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9ED1BC41
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752434380; cv=none; b=sJkLaaBFdCQpYpViJBWy/zy1GV0kO/gZ8ZiB0hUTTz22ikhC3Uvwwwldgl+T7VK6UH9zw1PSiaIihRjRuF89tcJb2FDzQCZ1glveR/6d5wjhhOdGBRmweasFeVRrZFhCsVhue9aiD/jo0NYwASSr/Yu8RNx/9MscKn5ECKTPHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752434380; c=relaxed/simple;
	bh=Dz9Nrd23/h+D0OAbLCheONZQH5JNDDp+EBXaUGM7iPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Lr1/S8UMB5OquslOUocjualPdpJDcN5PS8ewhVJ773xsIPLoN8wZe3aSYheBQRafe2nI79OV81CNV3Dq9/Gy6eYj1IzGI0t7lvuOwvDCurfacBZx8g0/u1kqGL21LLtqR7UtFIC937sF7BoIOZK2Yxj2gFpZxou4BsLNDcM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=uN0ieuy3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab3802455eso24144601cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752434378; x=1753039178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7N66BOOoEFjiJc1Bb7wi8qfy7ECChKd31KVqGQ2Gcg=;
        b=uN0ieuy3wyhiVmtQf7gAfhcNv/eCpTEw1XnQv5FPJ5fP6zhwKB2A6wxwU7FBvr+SGU
         e7Bq73cYqP1zDOl2uy4n9J8Z8DlAe+D2FNPZhX+VZWpm8J6KSjwLrXWMNT1oCekADqa/
         KOMbMqggClx/tq+eBKv+e4GoMdNzbQxwj30bcA7mW3k30JJAh2Sa8IsIkxe8Nq2H7Qsz
         MgvrPXtKKx1VJNqE9cn7FkLtYDBzGA8C/u0FSm2HLx8S6OwHXG0YR1Ebhj7kgUnlzPIy
         7G7add9U5GuDx8GlQEplpxXTqrulwd8R/M2qc99y2TzyzOaHYg5WX1szi0/29Kk1YEbT
         6//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752434378; x=1753039178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7N66BOOoEFjiJc1Bb7wi8qfy7ECChKd31KVqGQ2Gcg=;
        b=emtUu/9GUQqO3GXVfbr4/y2e6G73prucmo5rlAJyd7JnN8sHkw3Qz2fZhCr3OwMvbH
         tkbGMVDIj0hyF/TOhMOUHwtsgHC5DiPEdq57Zf/Yj/7bin2WYFcpwIIyp1D/mLXrr3UU
         mt8bYvLzipsrC1zOlOpykcXq2Ait2k63yZY0ROMlyDlcgulD5AsEqQawQ2FYInAzTq/E
         yXSzfg2bIgH0Xv2LouzOF+pNCWD/KgbUOVDjAX3XK6wEGa7qPGQCKKbsaNdh3cBCDhwU
         byY4dK89UspSesD81ogRUM65ocPTeMHEbyIh3x8f954TKPMs/pkcmoyNBfQ9+HTqt+RV
         Fw8g==
X-Forwarded-Encrypted: i=1; AJvYcCUDSjeOVRI1+FAT/xfaWU7wcc0DSICvG5uUT1yeBYTtH1jMSB56jX95uRnukF50SJMI1ncT+PlM96vkEuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEkwmLX/RHNGrgK6M2gcJ1iJfllNmM+5kka9nt04jDouixTK1
	YuIzQrEkdu033nKLdoRxKWgBt2xznTpcjfsS4KJT8GZHxBz8hFjNmwMVZO/83hevaQ==
X-Gm-Gg: ASbGncuhqNp8jb23G/yZFgRdL3NwucPycZrkVEe7sB5e13BMy701ZDJSwt5MdykWdd5
	eY24CNbJXgeFqpcoiH+9PgZPjDV1HWpPIHI3MxlXyq7k2Hu2LA0bclh7T6CRPsrIk4uleoUP0Xp
	np25g4Z0V5EXarBZbHLoRdXuYB/6pmupqUkY8QyIBw2/RerCkDFANE7kIIvuxL2CSwSqemPzOzF
	AoGIhum6q2cbAonY1ZDKTWbk5U3KNTn1clSsz6fFcDUEKcjCdKKEjH18d8cBBS4AII/q8dczrND
	cguSBi6rqkR587/pL727tTiQp8wOQWBChYtKcTLuXV2nWCIvsVg1rtsvd/xEWRVDDUC0+FJd8YR
	/uPnbTjh4QFXF8CXeMst7RH0vS+cDbwUIQg==
X-Google-Smtp-Source: AGHT+IFeL5zqsclbGt53P8JJz5Oakl/FajGBFk6cyyrPaSa+ENBtKY8kgiVfmKrtS0TZL+eVfwKdOw==
X-Received: by 2002:ac8:5912:0:b0:4ab:6eef:315b with SMTP id d75a77b69052e-4ab6eef3840mr9139271cf.23.1752434378071;
        Sun, 13 Jul 2025 12:19:38 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab04d910desm27368091cf.9.2025.07.13.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 12:19:37 -0700 (PDT)
Date: Sun, 13 Jul 2025 15:19:34 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
Message-ID: <e8fe21fa-9a2f-4def-b659-063d55a40f3d@rowland.harvard.edu>
References: <68653bfd.a00a0220.270cb1.0000.GAE@google.com>
 <6873a1fd.a70a0220.3b380f.002f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6873a1fd.a70a0220.3b380f.002f.GAE@google.com>

On Sun, Jul 13, 2025 at 05:09:33AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14725d82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76c2fb9aa0954fb8
> dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f50f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12725d82580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/33ae17bacfc2/disk-3f31a806.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f476e6d9400a/vmlinux-3f31a806.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9ae9e3684ea3/bzImage-3f31a806.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com
> 
> microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
> microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
> =====================================================
> BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x5a1/0x2630 drivers/usb/core/urb.c:430
>  usb_submit_urb+0x5a1/0x2630 drivers/usb/core/urb.c:430
>  usb_start_wait_urb+0xc2/0x320 drivers/usb/core/message.c:59
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x27c/0x5b0 drivers/usb/core/message.c:154
>  usbhid_raw_request+0x4ab/0x690 drivers/hid/usbhid/hid-core.c:-1
>  __hid_request+0x2bd/0x500 drivers/hid/hid-core.c:1989
>  hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]

Try again, but with Benjamin Tissoires's recent patches.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6

Alan Stern

