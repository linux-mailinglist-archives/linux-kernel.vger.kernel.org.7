Return-Path: <linux-kernel+bounces-877100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A9C1D31F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B47B3B8CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3D35BDC9;
	Wed, 29 Oct 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SvOSZpMZ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D762BDC05
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769667; cv=none; b=L1DPiA2cdRRziEMgKjG6+LJKDX5fqDoNJbnLvEFcGFLQ00mKAaf0XFggZbWT2WSCfYqLkdDTEd8r1eBGR2HSTxxed1SlYutZif/OMSx4kz96vbigXQ2SrjLJMCuFWEsAnyeFZ/to0BmPl0CNzRF4vsike7fOn3l/tu18CE7LngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769667; c=relaxed/simple;
	bh=V3XWUmSqag986veKI80eSIb6m7nPk9CLKVIRbAGcJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGlLc3ZJ5ZzgbS67V1I462y9F2WiKwjpXjeVfCC8R81Pv6vE+ELqOtt1rzA3UxVCQV61xKhkAbsOkLFjstI29hn/j1Ce0mCpt8SgbkRb60BRc95KZP66BoySPaiZBGFePC+6HJcG5ITwI/RBJVjKaldYmcQQn8Fh/OggQB5Lmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SvOSZpMZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Oct 2025 13:27:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761769663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTcYzXZPrniWZCkwHLSm2V6Hq8R2XKza/pCFwi3PJs0=;
	b=SvOSZpMZW3/p9h7JBDkzya4FoDoQEO9J+Px2YZf5sVJIhqCyP98bAFnuLqMr0hrcj4PUw1
	qkoyJaEFkwISobw8SIX80cnkrsphzxEfEb6YMSZKL0aTCp/jZZchjpNzYL46QSL/9dyIhn
	wOuyeVhVz2OK3K1f5wkDbsFQ9D0sxx8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: syzbot <syzbot+c41f3ddb8299a30a98b5@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org,
	yuzenghui@huawei.com
Subject: Re: [syzbot] [kvmarm?] kernel BUG in kvm_s2_put_page
Message-ID: <aQJ4tQJPiGF6M9Wb@linux.dev>
References: <68cd66b0.050a0220.139b6.000f.GAE@google.com>
 <6902734b.050a0220.3344a1.0430.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6902734b.050a0220.3344a1.0430.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 29, 2025 at 01:04:27PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    10fd0285305d Merge branch kvm-arm64/selftests-6.18 into kv..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
> console output: https://syzkaller.appspot.com/x/log.txt?x=173e4fe2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4522b3a704e0394
> dashboard link: https://syzkaller.appspot.com/bug?extid=c41f3ddb8299a30a98b5
> compiler:       Debian clang version 20.1.8 (++20250708123704+0de59a293f7a-1~exp1~20250708003721.134), Debian LLD 20.1.8
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13559c92580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12963fe2580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-10fd0285.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/65e2ebd050e3/vmlinux-10fd0285.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d47fc3df12e/Image-10fd0285.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c41f3ddb8299a30a98b5@syzkaller.appspotmail.com

#syz fix: Revert "KVM: arm64: Reschedule as needed when destroying the stage-2 page-tables"

Just fast-forwarded kvmarm/next to 6.18-rc3 which has the fix.

Thanks,
Oliver

