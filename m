Return-Path: <linux-kernel+bounces-862288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D840BF4E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45C44FF383
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82A274666;
	Tue, 21 Oct 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXmgab11"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A8354AC9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030745; cv=none; b=SpGqrkqPL3rG4KCVmwYKa+9HvPCaMsyjPAf3uHTwrEYKhF/IEzIPAblfOejZvJFsocEnKTsAF9JD1h2dqQpOe+lDxeLrEARGwjkiuRbyDq1YTP8XUZ5zSXlIDHhOdHE1RxqVK830sPxPTczg/JTrKefH0fGZUInF/viUQew7RTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030745; c=relaxed/simple;
	bh=Xnv8H3ZDnKl4X1PB55r22TPaBVo2ZFPIGawukakBrjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CteC1ChOt9nMfzMM/iMhpix0rFAswjKRBhZ+LVInxnovO0aa1KwdCPXqfqTjDFI9/x0lAqIRQNrZ/yyWtDEaz5FDaRBPc5sioefsjHiEHeRz0iQ1Ilt7vcUrtUCSpENvyn80gdv6QnuS1Wj2keTCUrvC5sDj1dGwgj9IPkjXfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXmgab11; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so3577515a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761030743; x=1761635543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qt+4cDvPgX3lF8PjgvxPyZSbtTp9ulbbmZUT2eBPHA=;
        b=YXmgab11UW43YyVDhQLLRVouDfn3KWEOS0VkYsMnaU9PmlmiEAzF68QgZRChR4hBnX
         TVevgXALnxaiac0yX1fNIRSzLky50uoXrBST4V/b4mIpNmRvM09+/2cbW3OMI7ZWsG60
         MNmoehduIM1W7dIE8KfYny/XzdvL+60X7L/Jx3WAssi+l6Mr/ly5DpEtR/djHzOrkZTf
         FG6JpaeMyd5oUj7kFxNKbvypd5kHgrr7egdElUzgRUNeaf9V+OWVBDJqA0GvuRCtvoqQ
         yt1yHwPy8H+svYdH0WbuNPmU2I5op6rXiqKMgd0CUaJyscmMNB8mK/YPlW+i7WRNm+yd
         j0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030743; x=1761635543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qt+4cDvPgX3lF8PjgvxPyZSbtTp9ulbbmZUT2eBPHA=;
        b=Gx3ltRD43OoFozEs/AM5spok+ea7PAGh8DnHM5iWo+8DDy6xPATSPld2wXBs0k7CFA
         ERQDeaHZaLbb4yISY+tyT6i9Dz9VHYsL0n9QNPWkVebvLsgCT+NlmnTwGDVEURCeeVph
         +DYZDolW1cUOhdcXWe59ipXlxabtQ3H0uacX3mrQNFeOhcVV48B1LoWyjhm6YKAE9rcT
         up7Lo2nMXWrgsiHcOMwVGqR75/0WnFHY4Y5FlImx2JQh9aBqlnn58hmDYA3Jsxm/4RJs
         enefrBYvvH64vmihX3fR2fWbDQnbLM1ut++zHcotFuVtXJMFjev0yJFfGZxpvtW87WDQ
         yukw==
X-Forwarded-Encrypted: i=1; AJvYcCXq6AKMA1njc+TJbrbBJaRlU5I4GFH2ErYQfUulDbQAkjdsfTy0Rh3L9BBxByCeVNv1QtrG4ZrApsnjEyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+pQ5J87xGRexl7KQ8DRQNN51uqRSO7mI7S4GmN/7fos4CoHW
	SklaepLMAWv+kAjkWiyX0PnDyP8P8dmx8XRBi7QSbFupK70n7wSwZ4DU
X-Gm-Gg: ASbGncs3vDwsKXN+d4uzk8PwNEU3fv7d8NDpk1Ls7Q73GDCeku3j/boU63/csaANmS7
	Q+WUq0kaDhjVXAzOIFPkTOfaAkneVt6jB6i25rEzS9MgP8LBSKV6ZI3zCuyakhqaXpL1uGp1HO/
	c3klQPHkKdmBwynVPUL6p7vcuq+neztPhwKswvO8COJIm03X9a5y2hshVC0v7/r3MejlDVgh+9k
	uR33XZY/KHvLojRiHhMy1IXi/OjV7ZyXCLC7o072i6lJ6uOrZeZHLA7N3u1bMKJukw2NymKGWyw
	eBe6+gXg593t8hwq8eEiYdbnbUl+6Bs3gCsPLiEZOY/yEatrXx38G+785kFv10B4yGcx1vPm3Ng
	0lCaNVri9mC5mzlJBBM2iMhpf3+b1aczwKyI/wOdSrdLdT8oQ+veSad2lRCSmX0mnZT1TU6/uPY
	+jdbmhMPMqJ7P943gWvA==
X-Google-Smtp-Source: AGHT+IHYtQqcmKB7yaQZvSOyk8N0Ik66n2fKAvbJQ2zFuAsou1ZH5dPCdBb1dBwC5saJJbcxPhd05g==
X-Received: by 2002:a17:90b:2fcc:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-33bcf89380bmr19665205a91.15.1761030743304;
        Tue, 21 Oct 2025 00:12:23 -0700 (PDT)
Received: from [192.168.0.22] ([175.119.5.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddeaea7sm10174272a91.3.2025.10.21.00.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:12:22 -0700 (PDT)
Message-ID: <a4bcf251-e1cf-47ef-84df-5c43b2b288c0@gmail.com>
Date: Tue, 21 Oct 2025 16:12:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: serialize writeback for inline-crypto inodes
Content-Language: ko
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 jeuk20.kim@samsung.com, d_hyun.kwon@samsung.com, gyusun.lee@samsung.com,
 hyenc.jeong@samsung.com, j-young.choi@samsung.com, jaemyung.lee@samsung.com,
 jieon.seol@samsung.com, keosung.park@samsung.com, wone.jung@samsung.com
References: <20251016051621.7425-1-jeuk20.kim@gmail.com>
 <5257fece-d947-4a33-8f66-4db5e8b73a28@kernel.org>
 <e26ec66d-36db-429f-befb-8baad14779d9@gmail.com>
 <75d0a52d-1662-45f9-ab67-909b906004b3@kernel.org>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <75d0a52d-1662-45f9-ab67-909b906004b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/21/2025 3:51 PM, Chao Yu wrote:
> On 10/21/25 11:33, Jeuk Kim wrote:
>> On 10/16/2025 7:12 PM, Chao Yu wrote:
>>> On 10/16/2025 1:16 PM, Jeuk Kim wrote:
>>>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>>>
>>>> Inline encryption derives DUN from <inode, file offset>,
>>>> so bios from different inodes can't merge. With multi-threaded
>>>> buffered O_SYNC writes where each thread writes to its own file,
>>>> 4KiB-per-page LBA allocation interleaves across inodes and
>>>> causes bio split. Serialize writeback for fscrypt inline-crypto
>>>> inodes via __should_serialize_io() to keep foreground writeback
>>>> focused on one inode and avoid split.
>>>>
>>>> Test: fio --name=wb_osync --rw=write --bs=1M \
>>>>         --time_based=1 --runtime=60s --size=2G \
>>>>         --ioengine=psync --direct=0 --sync=1 \
>>>>         --numjobs=8 --thread=1 --nrfiles=1 \
>>>>         --filename_format='wb_osync.$jobnum'
>>>>
>>>> device: UFS
>>>>
>>>> Before -
>>>>     write throughput: 675MiB/s
>>>>     device I/O size distribution (by count, total 1027414):
>>>>       4 KiB:  923139 (89.9%)
>>>>       8 KiB:  84798 (8.3%)
>>>>       ≥512 KiB: 453 (0.0%)
>>>>
>>>> After -
>>>>     write throughput: 1760MiB/s
>>>>     device I/O size distribution (by count, total 231750):
>>>>       4 KiB:  16904 (7.3%)
>>>>       8 KiB:  72128 (31.1%)
>>>>       ≥512 KiB: 118900 (51.3%)
>>>>
>>>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>>>> ---
>>>>    fs/f2fs/data.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index ef38e62cda8f..ae6fb435d576 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -3217,6 +3217,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>>>>          if (f2fs_need_compress_data(inode))
>>>>            return true;
>>>> +    if (fscrypt_inode_uses_inline_crypto(inode))
>>>> +        return true;
>>>>        if (wbc->sync_mode != WB_SYNC_ALL)
>>>>            return true;
>>>>        if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
>>> Jeuk,
>>>
>>> Can you please try tuning /sys/fs/f2fs/<dev>/min_seq_blocks to see whether it
>>> can achive the goal?
>>>
>>> Thanks,
>>>
>> Hi Chao,
>>
>> Thanks a lot for the suggestion.
>> I tried tuning `/sys/fs/f2fs/<dev>/min_seq_blocks` as you mentioned, and it also achieved similar performance improvement on my setup.
>>
>> Your approach looks cleaner and better than the one I proposed.
>>
>>  From what I see, even after reducing this value from the default (2MB) to 512 KB on my local system, there doesn’t seem to be any noticeable performance drop or other side effects.
>> Do you see any possible downsides with lowering this value that I might have missed?
> Hi Jeuk,
>
> We're using sbi->writepages to serialize large IOs, once you tuned default
> value from 2MB to 512KB, in Android, there are threads issue [512K, 2M)
> sized IOs, they will join into racing on grabbing the .writepages lock,
> I guess that will cause potential performance regression, right?

That's right, that could happen.

I’ll run some tests to check that, including a few other cases that 
might be affected.
I’ll share the results here if I find anything noticeable.

Thanks for your help!

> Thanks,
>

