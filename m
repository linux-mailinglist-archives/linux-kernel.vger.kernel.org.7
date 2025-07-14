Return-Path: <linux-kernel+bounces-730103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8EBB0403A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8016DD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A9248F5A;
	Mon, 14 Jul 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fedjZVEo"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586E1FBE87
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500206; cv=none; b=KMPwNDcAH61PEIw915KJithsLFg7zW8nXbXsoEAva5wQUbRuLBJa/xJEDLJEUs6Bwyi2jjrvtfGt8UsRECXy4to0mVD0KnV7mUf5GhaNxLVh5I9gqojSVPwHKLdG/sAMwhQMTHd8S8BFkwX+nAq8UCitCVmtY4HCRVRCSxa7sXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500206; c=relaxed/simple;
	bh=AFwuCN2vX0YXwi1bAc0uRw1duEUI/zG6mrRV1RTe8vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deDuysMiTJcu5rrKsbftYZF4sajiU+v6poylJAMqAhZSvypocHDDeIbTkrU7CLuoow19fQTZxGBehtG8/1hYNd6KE1dRCm52nHHxVK4DXEpAd8DvqYbuDQGWaffKLoVQNGjAOOSk6bcSf5Hj+ZcNyLJJ070wM7EnCzKNah8II0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fedjZVEo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d3dd14a7edso611569385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752500203; x=1753105003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzEuDbRvDYwQi9yz42oCAYTj76hJiOhQZR85jUMWpaM=;
        b=fedjZVEovtpIk6GnKqLQ0x2ceygJjssfBNQHnwRkPaBdCiygMMLw52sMfZQBIFEMha
         tVuah9ynOAfM0LoI0IXk+Hzyqx56YIsGGpJeG8xKUTqpZta3O4olzGSmyUrrKmc9XwrJ
         nsNrb1uJPhcsdixsr9B60fZulBP0FpVPnJMH97vcn3Z6PeBouYIOKP69lZITISp0TfPH
         CJJPNFy4R6x/bEUWTeiPFnkd8vbKBmpYw+/q+o22aw1oxa3o9vG1Q49TC6oVmj6shAsV
         ecfeB3y8wpuquPlD7qmWLdvKqNRGd9hF8EnNKNOJVSSBIsXpYF0DXeyjwl+r2MiMt0Dl
         4eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500203; x=1753105003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzEuDbRvDYwQi9yz42oCAYTj76hJiOhQZR85jUMWpaM=;
        b=o3tYw0ZjClSZabxfjSRBQqhbY739VYjWkjXeq67Efp4VDOD6exDn6Py4djUlcOzLSz
         2s8yu3//HQfk3iEXiKgmWNruyCaGUbbcGV0/KDpVXc6PEk3Ni1RBlHRUaYU9rRZ3sTOW
         Z9nl0v11T9I/cimKNNe+YLEtTqsuHaO45PkCWqz/gUwKHYltKahE8gTtDOR9vc5J42w2
         kX4KbRZyWUyi8hHo59SeBnvBtqpDcx0Y8YVxanxhN4zWUG7+rA1zUoyRLrbj79UGLVSK
         rw2uKRySxYeIqBTdDukXVJEbBwdBpQ++CDX5Vzr1/lMn918syv2QJ1MFOQxB5wr03jCw
         jXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JEcc4FRmQvk44ELLE0D7d8Ogsla4qzcUcoomc9997hsO00q5s8PG4ynFu4uL4sCvobidE2+Vt53Xi9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbF73dqLVjpziV++ACLH+DXZ2KzUT7UypKVEZcCq3txU0XqRD
	snXm+9yM4KdY/Zm5PZXo3NDQ5J2WevWP+0Zo7jhgSq1C7qzDsMkSnMQa/zGdZSARHA==
X-Gm-Gg: ASbGnctO+aZhhLZ83r7Z8F7n3ieu99FhO/TBsX6xroYhJYK155H1RYyHv5BrllXvrpZ
	uSefvj9Xm9POjtaSzxhDdhh61S0H4821ZxJvpgRzkM6wgFiQ9hMOWkmFAMPD6/95OCHK2kIXHo3
	BfIReY03RkdLYDz/Bpm4b6CdFT3BdGBhy+/wcs3jjDQobOHEYSyv/TeyUIpMY05rZYSgeGXn8KQ
	22uWS3dBBhT6kwgJDgl41Kbw0LQaKipGC+hQ+XYmAL1cX09qDwYW1z+ObrVka6cA/KwnSgojFFs
	TBzyyqvSI9b05kbMdHeLJJGGV22QhSWN0Qr0Y4bd5jmyXg1YAElVW7sT/GwG/MCCPk6OvSuAWW0
	hLUYxRJRVPSBu/Mc4O6ZDJuo=
X-Google-Smtp-Source: AGHT+IEkMGy0P93fi+8WY7gmhCfOfV2V9LDV8Tp6KgMmdWe1QqVkN12EUDvmUpKqXUFSah8FXeWtSQ==
X-Received: by 2002:a05:620a:1b98:b0:7e0:6402:bece with SMTP id af79cd13be357-7e06402c8c7mr1302094385a.38.1752500203091;
        Mon, 14 Jul 2025 06:36:43 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f705fsm509506185a.33.2025.07.14.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:36:42 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:36:40 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, hdanton@sina.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
Message-ID: <9c3926ff-1012-4da4-b477-41a305aa0f98@rowland.harvard.edu>
References: <20250714024903.3965-1-hdanton@sina.com>
 <687490b3.a70a0220.3b380f.0048.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687490b3.a70a0220.3b380f.0048.GAE@google.com>

On Sun, Jul 13, 2025 at 10:08:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com
> Tested-by: syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         c2ca42f1 HID: core: do not bypass hid_hw_raw_request
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=138330f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7367e34c3d60253b
> dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

#syz dup: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in mon_copy_to_buff

