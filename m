Return-Path: <linux-kernel+bounces-833598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3BBA2622
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D38627577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA226A087;
	Fri, 26 Sep 2025 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ij4YEFUu"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C61F4C89
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860615; cv=none; b=l6cAoULOvLdn5hnVfZcpQ6aTJsAQ6oZMlTOINYW2eTqygTWjZISwAGtlVc9QY/s+jQ4Y1xQbfbwnlN8bzTfWsAV9RSDsXgFX7ZgDz9mMHSsrCDCiuC7y4cIi/2znGCmppc0kkzEg5OtQwtiIfAGilFcJcUZHryDS/tA7a1WvD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860615; c=relaxed/simple;
	bh=myD6mmp+C3rd+asDcbpplnUIO08Kl56ZQPwtwVLJYfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxe+wW4/LEKWOKRQarReoSCu0GskqZesbkIyRIHis+ch6c2GpnUHIT+zMoxmc+FFxIuXKZlT4mwv+Imsnf5gAihFxWxlq4PA85/apNpu1CQyTxpITCZ48pt4bzIq6WJmZTCPBtnH80EB2W9AbpMScJGLNqehPYcMsqdapeRATCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ij4YEFUu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b41b9b8e-6623-4e07-a132-515a6e88f1cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758860598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myD6mmp+C3rd+asDcbpplnUIO08Kl56ZQPwtwVLJYfc=;
	b=ij4YEFUu+oa614VbsJBwzzScs/1bDFmvnvUHbmy0pk8R0A23hnMhAG7QV96Qk3cb/9+3EQ
	/XMyxedTOpoGjZ5WWD1h1biG158XUNkuMfXezQ7vVwwQIbXihrv1J5mAMHkZpuAHK1rJXh
	CauSKZwV7Vs/bxbTKWAu/o8X0DbHzPM=
Date: Fri, 26 Sep 2025 12:22:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] bcachefs: Move the link counting check to the VFS
 layer
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250926022150.493115-1-youling.tang@linux.dev>
 <20250926022150.493115-4-youling.tang@linux.dev>
 <frs3oa3te2yznm2yttqfm2pjqdwlecwkad6y6o5dymyvk2jh4p@7zncp5imxdjp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <frs3oa3te2yznm2yttqfm2pjqdwlecwkad6y6o5dymyvk2jh4p@7zncp5imxdjp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent
On 9/26/25 11:42, Kent Overstreet wrote:
> On Fri, Sep 26, 2025 at 10:21:50AM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Currently bcachefs only performs link count checks during link operations,
>> during rename and mkdir operations, the link count should also be checked.
>>
>> This patch moves the checks to the vfs_{link,rename,mkdir} functions when
>> sb->s_max_links is set, eliminating the need for filesystem-specific checks.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> I applied the other two patches, but not this one. We can't rely on the
> VFS for checks like this, there's lots of routes to modifying the
> filesystem that don't go through the VFS.
```
vfs_link
     bch2_link
         __bch2_link
             bch2_link_trans
                 bch2_inode_nlink_inc

bch2_symlink
     __bch2_link
```
I have traversed the bcachefs code and found that bch2_inode_nlink_inc is
called only once by bch2_link_trans, which in turn is called only once
by __bch2_link.

Although __bch2_link is also called by bch2_symlink, symlink operations
don't involve i_nlink values. Therefore, all effective calls to
bch2_inode_nlink_incoriginate from vfs_link. Please let me know if
there are any calls from other sources.

Even without moving to the VFS layer, do we still need to add link count
validation in bch2_{mkdir, rename}?

Thanks,
Youling.



