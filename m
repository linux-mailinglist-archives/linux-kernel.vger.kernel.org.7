Return-Path: <linux-kernel+bounces-869973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BAC09277
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554F5189A391
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673ED302155;
	Sat, 25 Oct 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cll+X/5F"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1461D5154
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761404835; cv=none; b=SG6WLi3cbl+2iwK4+N0v4d5eqCMnuLAf5iMOkXFSe0OWbMj7t9XAugHYYkopWI5H7IHOf4a75b7ave4A7kMmo8zhjITEQQqBtVNqoPRiyIyKEdkDeNshU3UA6s9/vRaVY5gv+4cyl9MtmicvsLX0+L4BgN8M5sRq2dMW+9yGfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761404835; c=relaxed/simple;
	bh=pdElZZTBRl/ohTApnI+0p2VE9kXSMqg2mVsZtsGTtng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2lfw+EJ0hCaxYtEzMgVArP+4XDOPveNMhkiFQLUsfmPtJGklWNGK/O910KyGIzDKmeK8uH/8RIsWY7YLMx7WvMAlBrBjzk2bGPN/+2WZy/fzZhd+I4RS/+cf/ZSs6X15cs350vlxdbOHfQmu+izMi+ARmSlEnnT3fUUZrPsKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cll+X/5F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so3001414a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761404833; x=1762009633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehGvucYryd5ksZM+NP6h3eQPQh9+jzxwKY2MY5g6NkY=;
        b=cll+X/5FdLqe3WCwunOhkW9FjmBZMoomMaql1u/VZzP3P1bjPZ4Z6d7zCOA0djomFJ
         MhemLQEGyo3l2VWTYwsDXJApVLu7VU1Jt2jfXNJWNU+jaTufDgY+Pw9K4YKSWJrr63OI
         gLyZwMkMeEPSYGHp4ETaBQ16Vsx8kwRM6HaKc/Gx6JuwSlUCuF4tAehRRSwtJ/mxLb+m
         vhcXw8FEmZ7IQvwnEziBmkFnBRZ8xcf+59f0XNEX916/qFsIy9q8lh5b7l/o1kKSzsy9
         X396vy8+oHNQnwURDP3by6WWnJ7DQVw6Qys/UtsHTpnsK4oMlJxoyBiUT2lCpJ1afl1V
         EUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761404833; x=1762009633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehGvucYryd5ksZM+NP6h3eQPQh9+jzxwKY2MY5g6NkY=;
        b=WNJ/cbHbNsqYmBVs5uGybXr9wpOMzbOPTAGu4oUfwfF7rOmaBGmsu8CGju/nj4XbPN
         qXy7IJvHTqHRit/U0nMY65QsrNyoLG8oLcaHnHK6GEOgUSQIc+dJ2ZxIR5rx7NbFQcUl
         xEAmEKR0wamURjYg9WttPv2CRTxSxHIZfP/mf/2/wzdcjEU3JMc8IGFnDSnF8/QrwKts
         UWd2yVdkTHfTaulrANdFrXxX7PoLkZUn0SWf6Uaik0NlY5acFC1w7mzbHHaznhqKcFUh
         42vNUhuwAlIMvxvGJqDRUEZ0MXP77xZlMyRDfKfVKaUl4fO5ugeaxmUFA85PGPwLKwCh
         ydqw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWegQB+3En6Gu5QdZtndoga5r+/IgjDc+CWu8X8QP3cMWyxj7ffKXyQwNHKhnVjRCj4PTqQ6VF3WKJ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylL2POrFazalccOCW+qRT6BZ/p0NwLK3WYb12bJFvxT3ojKeOc
	B39hFUVUuhBWbvHROP+IBCVCKl7djO4KYF8SRgzh2LY4Pd7EkrjdDkkQ
X-Gm-Gg: ASbGncvq6//z8RAB6ADf1iF1HmUoW/PIc9ahFg+8wIe8NV/o0QT1yqM/Gtcy4VmgfMr
	eJ05DxjWkpVf3lehWwRGBVRZKMVneBmmmUiEp3AKCndxz4Af6HZ5IsAF1E2QSA16Cmp3B/hWvln
	E1duoUhmoLYnKyOi8ElxNI33jbYeT4CWnpPim6ztzsBC9sNYSPxHwPKFIFpv3M+KfJBKCEngpE/
	vJu+9wKwIzhU6RAABCBfVIH1zFhOKoavwWNHzW51jv0ZclZQ0P17JZemsakdVjvUUXcA5R2rEQO
	KSF2WQZS05c/A3tAvXKc0DJR0oMXJeSmxNjbl6rUXsiF/slStSMJ6LDlF2QSztCBL5DwJZbkj+d
	n19EeBXfcVqQGhCGl65jYoQ146cfwpK2N/a/6uyvy7Q309Z+v7hw7/qJQOtI6tso2PUaTYWGZng
	5TXpPNzH6k+f10z53dzNtl2lMCF+BsNfiMZ8+Co881lPYNUKxtZ7/EQrdRKudPAlWiiUknfW+lK
	gVDHBtk1KJSzvBG9In1j80=
X-Google-Smtp-Source: AGHT+IHc2D1me194quCxZvcS0NmqKlfdcG9goQhTzdjCPdL4h6Tfx4LteJBnMLzm8AlcYT1LIELvtw==
X-Received: by 2002:a17:90b:1b4a:b0:32b:6151:d1b with SMTP id 98e67ed59e1d1-33fafb98ac1mr12129890a91.8.1761404833441;
        Sat, 25 Oct 2025 08:07:13 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:896a:5f1b:2412:be21:3a45? ([2a09:bac5:3c3b:a82::10c:59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed73a7b7sm2605532a91.5.2025.10.25.08.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 08:07:13 -0700 (PDT)
Message-ID: <4aeceb66-ceea-4171-8806-95bd11a928b3@gmail.com>
Date: Sat, 25 Oct 2025 20:37:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com,
 ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251006223805.139206-1-nirbhay.lkd@gmail.com>
Content-Language: en-US
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
In-Reply-To: <20251006223805.139206-1-nirbhay.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/25 4:08 AM, Nirbhay Sharma wrote:
> The call to kmalloc() to allocate the attribute list buffer is given a
> size of al_aligned(rs). This size can be larger than the data
> subsequently copied into the buffer, leaving trailing bytes uninitialized.
> 
> This can trigger a KMSAN "uninit-value" warning if that memory is
> later accessed.
> 
> Fix this by using kzalloc() instead, which ensures the entire
> allocated buffer is zero-initialized, preventing the warning.
> 
> Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
> The following syzbot test commands were used to verify the fix against
> both linux-next and a specific mainline commit. Both kernels were
> configured with CONFIG_KMSAN=y, and no KMSAN warnings were observed
> with the patch applied.
> 
> An attempt to test against the latest mainline tip failed due to an
> unrelated boot failure in the SCSI subsystem (KMSAN: use-after-free in
> scsi_get_vpd_buf). Therefore, testing was done on the last known-good
> mainline commit below.
> 
> For mainline commit 9b0d551bcc05 ("Merge tag 'pull-misc' of..."):
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9b0d551bcc05
> 
> For the linux-next branch:
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
>   fs/ntfs3/frecord.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 8f9fe1d7a690..4fe8da7fc034 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -767,7 +767,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
>   	 * Skip estimating exact memory requirement.
>   	 * Looks like one record_size is always enough.
>   	 */
> -	le = kmalloc(al_aligned(rs), GFP_NOFS);
> +	le = kzalloc(al_aligned(rs), GFP_NOFS);
>   	if (!le)
>   		return -ENOMEM;
>   
Hi Konstantin,

I sent this patch about 3 weeks ago and haven't heard back yet. I wanted
to check if there are any concerns with the patch or if any changes are
needed. The fix addresses a KMSAN uninit-value bug and has been tested
successfully on both linux-next and the commit from the syzbot report.

Please let me know if you need any additional information or testing.

Thanks,
Nirbhay

