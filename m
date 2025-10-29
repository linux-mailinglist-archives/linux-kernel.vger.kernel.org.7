Return-Path: <linux-kernel+bounces-875112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A811C183B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1025E3513E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF42F5A07;
	Wed, 29 Oct 2025 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgRjpogV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B902F549E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711994; cv=none; b=k1kgYms6v68JfNOyddipp+R6sS5HdlF0FeByGg5k5hYjIS3fbRKi2idIeTWh9weZg6RNzDQvLFGim8sMYGz03CwgyuFap3E21mEc7rfNCruUznDLGjm3YKZBi36luOALFq906Q26PRM6UjLtyPTowlNc44/ddvIvvXMTSkmfF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711994; c=relaxed/simple;
	bh=pNrkVZRg0qtgUOiit6EQFAAv9auGuKi23YsrTYy0s+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIwy4H+fvVKLT05v/o9kWgKLX759CNzEO5n4BTMsr4VvnnTM9XuwoN8kPchlzpuBYiQ7lv6D+/aoT/jtv/zz++PwLb4C8u5moClv+Oi4Vs859y7ZIWcwW50k6BzUwRwCM1wdaejonwp9hTDRcWhjJyGjpq2kDPu/N5ney6ocjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgRjpogV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F561C4CEF7;
	Wed, 29 Oct 2025 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761711993;
	bh=pNrkVZRg0qtgUOiit6EQFAAv9auGuKi23YsrTYy0s+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgRjpogVTcQB5uIUkngmqJrKUREu27UwjCGfWj9EqxnCWz4+6uYJn/YOM1C3lTNvY
	 YYdp5rjFoUTgyaLzH13AQjjAXuslgnCBpYdnnxmWnbMzJ8ZljIr7Eeq2s9lou89a+G
	 Q8QL9YY5jxQ0zetYJiVSfVZJDWiBkqCy9pguXk+20k+vf0ygAcKNa0B2WWxMDd2YDA
	 +oD4lLqeysMTNYEr/pzh1InWsydeR9Whe0yxoDRjLBxCv9HUFxg6Lf9GZ+hAgP9n2J
	 W1eYT8j16Xb6bGRGclP2sd5BHD2ex+YLx0xyjus/NMh12/6lCVdMaXbnbsHleqaLTN
	 APi9oHqALojCw==
Date: Wed, 29 Oct 2025 04:26:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add fadvise tracepoint
Message-ID: <aQGXd0lI5MeHyGbX@google.com>
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
 <81602674-b9f4-4ab2-91f5-0afc762e7cc6@kernel.org>
 <7040b501-6e25-42da-bda0-a15614a80d5d@gmail.com>
 <490569af-8e87-4cea-81dc-3bc9f59aa2b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <490569af-8e87-4cea-81dc-3bc9f59aa2b4@kernel.org>

On 10/29, Chao Yu wrote:
> On 10/29/25 11:13, Yongpeng Yang wrote:
> > On 10/29/25 10:06, Chao Yu via Linux-f2fs-devel wrote:
> >> On 10/29/25 03:54, Jaegeuk Kim via Linux-f2fs-devel wrote:
> >>> This adds a tracepoint in the fadvise call path.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>   fs/f2fs/file.c              |  2 ++
> >>>   include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
> >>>   2 files changed, 34 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 6d42e2d28861..4a81089c5df3 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
> >>>       struct inode *inode = file_inode(filp);
> >>>       int err;
> >>>   +    trace_f2fs_fadvise(inode, offset, len, advice);
> >>> +
> >>>       if (advice == POSIX_FADV_SEQUENTIAL) {
> >>>           if (S_ISFIFO(inode->i_mode))
> >>>               return -ESPIPE;
> >>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> >>> index edbbd869078f..b7f5317b5980 100644
> >>> --- a/include/trace/events/f2fs.h
> >>> +++ b/include/trace/events/f2fs.h
> >>> @@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
> >>>           __entry->ret)
> >>>   );
> >>>   +TRACE_EVENT(f2fs_fadvise,
> >>> +
> >>> +    TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
> >>> +
> >>> +    TP_ARGS(inode, offset, len, advice),
> >>> +
> >>> +    TP_STRUCT__entry(
> >>> +        __field(dev_t,    dev)
> >>> +        __field(ino_t,    ino)
> >>> +        __field(loff_t, size)
> >>> +        __field(loff_t,    offset)
> >>> +        __field(loff_t,    len)
> >>> +        __field(int,    advice)
> >>> +    ),
> >>> +
> >>> +    TP_fast_assign(
> >>> +        __entry->dev    = inode->i_sb->s_dev;
> >>> +        __entry->ino    = inode->i_ino;
> >>> +        __entry->size    = inode->i_size;
> >>
> >> __entry->size = i_size_read(inode)?
> >>
> >> Thanks,
> >>
> > The other "__entry->size = inode->i_size;" in include/trace/events/f2fs.h also need to be updated?
> 
> Yeah, Yongpeng, I noticed that and fixed them right after reply:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=bugfix/common&id=ffd21bf791143957f6ff1fc14d7dbd6e8466b320

Please post the above patch separately. :)

> 
> Thanks for your reminder. :)
> 
> Thanks,
> 
> > 
> >>> +        __entry->offset    = offset;
> >>> +        __entry->len    = len;
> >>> +        __entry->advice    = advice;
> >>> +    ),
> >>> +
> >>> +    TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
> >>> +        show_dev_ino(__entry),
> >>> +        (unsigned long long)__entry->size,
> >>> +        __entry->offset,
> >>> +        __entry->len,
> >>> +        __entry->advice)
> >>> +);
> >>> +
> >>>   TRACE_EVENT(f2fs_map_blocks,
> >>>       TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
> >>>            int ret),
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 

