Return-Path: <linux-kernel+bounces-745522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03CB11B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7AA3AA5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872323814C;
	Fri, 25 Jul 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="o1b7uiHy"
Received: from smtp66.iad3a.emailsrvr.com (smtp66.iad3a.emailsrvr.com [173.203.187.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D42D3ED3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436809; cv=none; b=hl7QUJmrILk6w9N2nCY0dPZCWRSgAirOpx0jeYRX01qZChA6jt0gMmBZArgEasJz26vpz0Mo/4W5Kg58Z+EYGjMpZylEvcLWfPWBOGdQzDeFG1m9F7BLDCg7K5NJ2TtwmK6h/sQ1HWXa+HlRJGRDRA55GA5K36kNbDsYlCgcH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436809; c=relaxed/simple;
	bh=qLhzR4zVcgsidFXKYDbJwZj6WZjAqjn6z2O3xV+rgI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoS3ZnZTlgEK/4APHgvAAwmPQTp6v1V828AsL2XUSwF4IhfKhu08wKYl2zwtTbg1ub0VbmhZSs2KnJEVTwPYJdOlwyJTcSHbXjpcbvM4Fvm7dB70wuFv+GWJ8fKW8S71eyBA5Lsk2NcqLvWPAOTkqpnrXJRoPq4DijTtpxDWkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=o1b7uiHy; arc=none smtp.client-ip=173.203.187.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753436490;
	bh=qLhzR4zVcgsidFXKYDbJwZj6WZjAqjn6z2O3xV+rgI0=;
	h=Date:Subject:To:From:From;
	b=o1b7uiHy+6KM93CMHjKMfrOBouZ4KX/pxy+X3KUXRcXgL98P2Q2ahlI9tO/TCJHs+
	 1kkDRlrvFYn751ic+Wkofp+PGOHjceekeSyG7v5s0OrGoiFkOBHVITBKpjGBYqLGTv
	 h0x6uAgFlCgvo3V4EUKpsnUs3r8adIpHMpaqyl88=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A84A4252B3;
	Fri, 25 Jul 2025 05:41:29 -0400 (EDT)
Message-ID: <7cc194c0-1ce2-411b-92e3-fb1b6c63f062@mev.co.uk>
Date: Fri, 25 Jul 2025 10:41:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: zero-init data in do_insn_ioctl
To: Arnaud Lecomte <contact@arnaud-lcm.com>, hsweeten@visionengravers.com,
 gregkh@linuxfoundation.org,
 syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20250724210451.108177-1-contact@arnaud-lcm.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250724210451.108177-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 0b9acf69-2c66-4ea1-aa1c-9dc5cdfb6a99-1-1

On 24/07/2025 22:04, Arnaud Lecomte wrote:
> KMSAN reported a kernel-infoleak when copying instruction data back to
> userspace in do_insnlist_ioctl(). The issue occurs because allocated
> memory buffers weren't properly initialized (not
> zero initialized)  before being copied to
> userspace, potentially leaking kernel memory.
> 
> Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
> Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   drivers/comedi/comedi_fops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c83fd14dd7ad..15fee829d14c 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -1636,7 +1636,7 @@ static int do_insn_ioctl(struct comedi_device *dev,
>   		n_data = MAX_SAMPLES;
>   	}
>   
> -	data = kmalloc_array(n_data, sizeof(unsigned int), GFP_KERNEL);
> +	data = kcalloc(n_data, sizeof(unsigned int), GFP_KERNEL);
>   	if (!data) {
>   		ret = -ENOMEM;
>   		goto error;

I thought my commit 46d8c744136c ("comedi: Fix initialization of data 
for instructions that write to subdevice" would have fixed this as long 
as all the driver code was playing nicely, but it seems I was mistaken.

I don't think it is necessary to use kcalloc().  The buffer already gets 
initialized (partly by `copy_from_user()`) when `insn->insn & 
INSN_MASK_WRITE` is non-zero, so it just needs to be initialized when 
`insn->insn & INSN_MASK_WRITE` is zero too.

There is nearly identical code in `do_insnlist_ioctl()` that needs 
fixing, so it would be better to fix both at the same time.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

