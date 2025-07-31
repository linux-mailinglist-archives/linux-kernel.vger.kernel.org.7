Return-Path: <linux-kernel+bounces-751510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2374B16A75
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71303A692F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAB1A23B5;
	Thu, 31 Jul 2025 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC2sFl31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469B8F6C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929306; cv=none; b=j4EdWGg0ZWGLBk5dbpxxhDn8TXIhXfW9+Er+9ofsDBCuCxEeApLshnvouh9cctCwTWUpwO16UMmWGCEeqy7aFpvNTBpCPffF1yzzSPszYqhXr2tfd913m89k+LucxNvlaFBZdVJsNAES0YJNeAQCWr/YNldp1tNgH/k5I7klCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929306; c=relaxed/simple;
	bh=UHqwiB2HFxlaVsf0AnH8LVGWkwp0vtIC3mHZAtUnuAQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oCWDuTGEzhQ+XEyl0JYaIFZeD32/pKvkkSZKoLK7te3M+p5IJdxmAzYqJ3TABBObUDpti4ptDCQEeqUQtip5wePu9UYAmtt5wxatGJmDsjL/6qf7p57hAcAgUohyHfIuhIPMHiHPUm6tpvS5iSMlsN8uPNaLpZEc9Efww5EO7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC2sFl31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B73C4CEE7;
	Thu, 31 Jul 2025 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753929305;
	bh=UHqwiB2HFxlaVsf0AnH8LVGWkwp0vtIC3mHZAtUnuAQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LC2sFl310tDMoPB/5IHJmrjNm9jxZ0JJYBlIAqQiiD8E/3Wdj/PReN6zVq5oqGbyt
	 LVskMebEmxNu1hHyycf+bDPL/vQhk/nNVmmuH+c2W0O9VOVgjeO2EZ4iNYgQ34Foep
	 Evro3GGlU6VTtrGbg1/Y3vLT0widZcA0iIb9pNDmkxKr0/ehb6FlJxmSJ1DvFY6PTA
	 XidDL+wDmPuQrataEN77hTaUoHWYq+hdtnkIxFt4BtdZI9p9BX1UIMkNZMNYryqWiZ
	 IdIKNWvSL5wtINm2QcPAr038CUel2I98ydYQ/Jwn6CPgPds1kqyOdm7fJxeSFUxZsx
	 m5LCiu8bJZ+DA==
Message-ID: <68c061ad-cbb7-44e8-a905-c13b9ec81c62@kernel.org>
Date: Thu, 31 Jul 2025 10:35:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Jens Axboe <axboe@kernel.dk>, hanqi <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 23:20, Jens Axboe wrote:
> On 7/28/25 2:28 AM, hanqi wrote:
>> ? 2025/7/28 16:07, Chao Yu ??:
>>> On 7/28/25 16:03, hanqi wrote:
>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>
>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>> as Jen mentioned in below path, right?
>>>>>
>>>>> soft-irq
>>>>> - folio_end_writeback()
>>>>>    - filemap_end_dropbehind_write()
>>>>>     - filemap_end_dropbehind()
>>>>>      - folio_unmap_invalidate()
>>>>>       - lock i_lock
>>>>>
>>>>> Thanks,
>>>> That's how I understand it.
>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>> you can walk around for write path in this patch.
>>>
>>> Thanks,
>>
>> I think the read and write paths can be submitted separately.
>> Currently, uncached buffered I/O write requires setting the
>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>> f2fs, this is done in the following path:
>>
>> - write_begin
>>  - f2fs_write_begin
>>   - __filemap_get_folio
>>   As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>> issue shouldn't occur.
> 
> It won't cause an issue, but it also won't work in the sense that the
> intent is that if the file system doesn't support DONTCACHE, it would
> get errored at submission time. Your approach would just ignore the flag
> for writes, rather than return -EOPNOTSUPP as would be expected.

Jens,

Do you mean like what we have done in kiocb_set_rw_flags()?

	if (flags & RWF_DONTCACHE) {
		/* file system must support it */
		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
			return -EOPNOTSUPP;
...
	}

IIUC, it's better to have this in original patch, let me know if I'm
missing something.

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b8d24097b7a..7f09cad6b6d7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5185,6 +5185,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}

+	if (iocb->ki_flags & IOCB_DONTCACHE) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 

Thanks,

> 
> You could potentially make it work just on the read side by having the
> f2fs write submit side check DONTCACHE on the write side and error them
> out.
> 


