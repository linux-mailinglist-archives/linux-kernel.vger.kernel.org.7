Return-Path: <linux-kernel+bounces-750302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB8B159B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB02540DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E5290D98;
	Wed, 30 Jul 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3A0BGCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D7290BCC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861182; cv=none; b=NXzBWZA+kOeoxNfecUTNO+dPH0SjsaeEf03nBwoUzpZay95JHKZ5H8EIqJ2pi8fQDqkgcmsHhNym2eKLk8WWkR2TrJTezu0YyMknc9xTe+HyAJXH/kaYIcml5N05x9gIyY2H7Han8x7RZEzKi2/awWQKizNh5BNspP5Y/orSBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861182; c=relaxed/simple;
	bh=X1H3hXqlaWnLdPy+eCeGsGly+LveFNvnklIQ86AB+L8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VPiwtzNuY6qT/wTCuxBq6sls/fw8jqktcc6YPeaCuFPEMT9YPOrKySzhRYU8XwZHBbjJc4e8hLzgycJUdbHgpo5GbyfqIPVWZSycqZJkSat21Ma9DE2+yUH7t3WI6eMiLiijjQgivTbA3+v0njEmLdIBbjwm4kPYU8vuPu/lmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3A0BGCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479CC4CEE7;
	Wed, 30 Jul 2025 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861181;
	bh=X1H3hXqlaWnLdPy+eCeGsGly+LveFNvnklIQ86AB+L8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=I3A0BGCT4vsXH+ff6hvd6LhE9ZdL5FXlPXWsHDh1JSLwvOYsJy8gLsKUN7WdUkBUW
	 rbXuCk38RuA1xYlxi3af81BJ8d0LvSGBWvmbjHU1nJXRnBWFDD1ZirXDOlyC6WoB0x
	 Rs4jy8HOaYU7FxJl3zmhjr9OjUFdv5w31G/37taQ493GJQfr+jEd4xqH2dNwXBAH3p
	 lS5SXUqir1S5RXEGPPgSSGT4miFay7mBWE/DIgaGwHNngmqdPjoTTirZhAkO9wNj5m
	 QlQkJ+DFLI/XQ8UUbKB1+1iIQKkvpIDYy/U1JpznTPHsEdNW/DLq2vz4QIw/OCR1hz
	 KNg/gjQOJRhuA==
Message-ID: <ae41b064-f45b-4410-9854-f4c07ea1d0bf@kernel.org>
Date: Wed, 30 Jul 2025 15:39:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: don't break allocation when crossing contiguous
 sections
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <20250721020231.2482090-1-chao@kernel.org>
 <CGME20250721020241epcas2p1481962181d9f81f127e122736923fe20@epcms2p6>
 <20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b@epcms2p6>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daejun

Thanks for the comments.

On 7/30/25 09:53, Daejun Park wrote:
> Hi Chao Yu,
> 
>> +        lfs_dio_write = (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
>> +                                map->m_may_create);
>> +
> 
> Consider moving the lfs_dio_write assignment to just after the if (!map->m_may_create …) check
> so it isn’t evaluated when creation isn’t allowed.

Correct.

It's too late to clean up the code as it is near to the merge window.

> 
>> @@ -4171,6 +4172,10 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>          map.m_next_pgofs = &next_pgofs;
>>          map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>                                                  inode->i_write_hint);
>> +        if (flags & IOMAP_WRITE && iomap->private) {
> 
> Since iomap->private is only set on the LFS DIO path, you can drop the flags & IOMAP_WRITE and
> test the pointer directly.

Well, that's right, but I still want to check this condition explicitly
to avoid any missing case or further misunderstanding on the code. :)

Thanks,

> 
>> +                map.m_last_pblk = (unsigned long)iomap->private;
>> +                iomap->private = NULL;
>> +        }
>>
>>          /*
>>           * If the blocks being overwritten are already allocated,
>> @@ -4209,6 +4214,9 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>                  iomap->flags = IOMAP_F_MERGED;
>>                  iomap->bdev = map.m_bdev;
>>                  iomap->addr = F2FS_BLK_TO_BYTES(map.m_pblk);
>> +
>> +                if (flags & IOMAP_WRITE && map.m_last_pblk)
>> +                        iomap->private = (void *)map.m_last_pblk;
> 
> Likewise, checking only map.m_last_pblk is sufficient for restoring.
> 
> Reviewed-by: Daejun Park <daejun7.park@samsung.com>
> 


