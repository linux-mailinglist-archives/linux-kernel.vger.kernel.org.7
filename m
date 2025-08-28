Return-Path: <linux-kernel+bounces-789078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E02B390D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258533AB09A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3871DE4CA;
	Thu, 28 Aug 2025 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RsyobB3G"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265D6FC5;
	Thu, 28 Aug 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343467; cv=none; b=k05r8Rwzb7qLyMNpX2eLOAolEBqOZxN28AfINu8kfMWwjGCDwx+1Sal7nKHOROkAZ3Zd6baUKLFWs3+O8/BnV7ArWgMDO6YiRBpaibqVqUB+aY1FsHYYzo2gQhq3IaMDipN6o9u8Foih/DcqD/kRGWsH588cdoUnrKNoi4I7BJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343467; c=relaxed/simple;
	bh=T54sChdFCQYgAIe63tS9H5O7JGsgrowHeQQI8195BAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tduaHlQJOKgyktnS/3Oog3/q7NNDkvNSYK/nElDdYFH9f2E0HAvkbf5/8+AteLCg8GPUXkfUNCGC0I8+uT3MUiHx0DFbm+MQT0YGqQy2FOkbImkFqmSnqjsKj6nuFc2uZWesY1Am7/KrRkLJxBR1qomYmrWw+SPSow7DOx2uyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RsyobB3G; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756343459; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8f3eyUP4EDg8Z+h3Vm1+LYpznbLQKSbkGehfEGu1b9k=;
	b=RsyobB3GTSyyyTEnpNOAI0XTNF0ZxyW7MVHxgmOxW9iqknQQ7duzFYEElRGFoiL6hk5Isp4SumFT7ENNBZNrRM9BelfySGABYSPo4T/3dXKc/QoiyZ/tXQzEJ9Wxz/m+1jt+VFgRyfH4xhm+cnOYt6BQgMHuvnUupYeDPpkzW+Y=
Received: from 30.221.144.151(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WmkrGUA_1756343458 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 09:10:59 +0800
Message-ID: <e0af0cee-9477-4179-ade5-7df879e22f02@linux.alibaba.com>
Date: Thu, 28 Aug 2025 09:10:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ocfs2: Properly reindent filecheck
 operations list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux ocfs2 <ocfs2-devel@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
References: <20250826024756.16073-1-bagasdotme@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250826024756.16073-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/8/26 10:47, Bagas Sanjaya wrote:
> Some of texts in filecheck operations list are indented out of the list.
> In particular, the third operation is shown not as the third list
> item but rather as a separate paragraph.
> 
> Reindent the list so that gets properly rendered as such.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  .../filesystems/ocfs2-online-filecheck.rst    | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/ocfs2-online-filecheck.rst b/Documentation/filesystems/ocfs2-online-filecheck.rst
> index 2257bb53edc1b1..9e8449416e0bee 100644
> --- a/Documentation/filesystems/ocfs2-online-filecheck.rst
> +++ b/Documentation/filesystems/ocfs2-online-filecheck.rst
> @@ -58,33 +58,33 @@ inode, fixing inode and setting the size of result record history.
>      # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/check
>      # cat /sys/fs/ocfs2/<devname>/filecheck/check
>  
> -The output is like this::
> +   The output is like this::
>  
>      INO		DONE	ERROR
>      39502		1	GENERATION
>  
> -    <INO> lists the inode numbers.
> -    <DONE> indicates whether the operation has been finished.
> -    <ERROR> says what kind of errors was found. For the detailed error numbers,
> -    please refer to the file linux/fs/ocfs2/filecheck.h.
> +   <INO> lists the inode numbers.
> +   <DONE> indicates whether the operation has been finished.
> +   <ERROR> says what kind of errors was found. For the detailed error numbers,
> +   please refer to the file linux/fs/ocfs2/filecheck.h.
>  
>  2. If you determine to fix this inode, do::
>  
>      # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/fix
>      # cat /sys/fs/ocfs2/<devname>/filecheck/fix
>  
> -The output is like this:::
> +   The output is like this::
>  
>      INO		DONE	ERROR
>      39502		1	SUCCESS
>  
> -This time, the <ERROR> column indicates whether this fix is successful or not.
> +   This time, the <ERROR> column indicates whether this fix is successful or not.
>  
>  3. The record cache is used to store the history of check/fix results. It's
> -default size is 10, and can be adjust between the range of 10 ~ 100. You can
> -adjust the size like this::
> +   default size is 10, and can be adjust between the range of 10 ~ 100. You can
> +   adjust the size like this::
>  
> -  # echo "<size>" > /sys/fs/ocfs2/<devname>/filecheck/set
> +    # echo "<size>" > /sys/fs/ocfs2/<devname>/filecheck/set
>  
>  Fixing stuff
>  ============
> 
> base-commit: ee9a6691935490dc39605882b41b9452844d5e4e


