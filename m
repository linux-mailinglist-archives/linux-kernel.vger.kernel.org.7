Return-Path: <linux-kernel+bounces-855649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B382ABE1DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640E03BEA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46102FB0A0;
	Thu, 16 Oct 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VPXkkEgK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724C2F7463
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598556; cv=none; b=bXT6TDskIWfXpXtcHfcaUfmjUxm2cEWALGR8hWywrM054RcTEBF1szmWm6h9b28qZED4wMdkgb7FWql7XStMt9xvbyNjNQmkkpZ+h+NW3wOYU18wEJLGNhguBFuDrYwUNYaz9f/0uGV+DEITw7w7SnCDsNB69ibDNCZyW5keZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598556; c=relaxed/simple;
	bh=5nHvZamFEkH9EvPLMXQNlxC9Wmfg98It5AsesLKv6IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ2MQp70TafK0ezdUvjR3D9350oYrlQAIhiKmEneCV48KSWkZHj1bQl4GVTI6pWTq7jJI0OD5tTLYPD+bLlY3tRG4HZmqfZPQVIq0+v8O1wt0LSZ2OlrHQ4QcYJ/uGpffKABnZ4aqBGSX6bst/lw5Oz3UK0oBaSVZ/xGJS3R+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VPXkkEgK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-427015003eeso116670f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760598551; x=1761203351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSIMe5l7UI5vEmVvxSYex6af8FroTpoooyg2xvpjJIA=;
        b=VPXkkEgKEMfDprue6Y7x6YrDDLHmf5xRxdo6nR+Dvr1jfATXn0FyD3o+5KddxxtpuI
         OJSrDimp2j7UPHe7E64jcFtHSeTB3peCDFKbSS0Q4yDzJjFGcz7vSJjyrBVed8r5q5iA
         5l9lD0Mz3DwHxuXlcOnjcdbhc3X+m9R4b/8hCVVZwRw0qeAtGbgT+wlnKJh9JwYuMSft
         Ph2rKHRTF12wzaL41q5Ak3q+QsHWf2+tHcTCLucDv5c1/WbvYiWcv5hH1WRdiP7KJrAY
         /moyDk3dBvt2SNr+muqeS0VXZ1+/AMTToo1llrgFEt1PZ3SLwL1crdSqQF2wCMo0Xsae
         1TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598551; x=1761203351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSIMe5l7UI5vEmVvxSYex6af8FroTpoooyg2xvpjJIA=;
        b=Co0RyidZ0M3tadtJWncA2MY96DsviJ/IpIEkEf51GO1DheaBxpX/had0R1tlo/X1q6
         qlV/ghFEA+i8VzLS+ZoS0SxMKC3iHI1/uCxny/c6BIskO5TZOFip8mmuxThk9QGT/0a4
         Su7oxtwZJC28iGWkZihqFdcE7F2qJBQ3yGayBasJRcD4kl5tQxZbFb0HcpLOQehBu16L
         YH+hJhn+ovZuDfghErY8IL95kzVZ7m1MahC7/T5FsnQT0YZZ0Vv6oKdppVsCMkr2XaUy
         G9zFqY45u60////TI8TctZ6bcq3xmHrgPycOFKfnXJ9Adu+Qwmx37rUzbVpHMS9J4IfB
         G6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXCvaXGyzqOzUIqGRMq5zUl2DD7ojRf0jHgZWwrVn/ITtnuIAqzdMzLIXIWovm8PwdhSB7rmfUux7Oa3s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9odREH3WbwN+8a9zpaRpGBPGIyXFssWr/FFO7UXd1sq15hoVO
	yBkFVFepJOIHuHHvj6rT06p9sxiLCs+MgcEB5syiIb5VxrPGPl3q4hYptjb5GLHLstc=
X-Gm-Gg: ASbGncvWGE3GGBwnCmMyDJbxKg8dXPa2YYrS/EqU7q3SixvnUL1aKxYUn8myWl2wGUn
	11wmEcQw/T+AO804wqqQwsInbIPKXQ/jP0w+Dbg3Au8rhA3+cNcPtxzvh2QiqKeOvpzBrregfaR
	+1qcDGrDAQv91D+8UfQPi+KWYSgfBCX7WX1zVQyu2wnONdzaMzlp57mlhjsC1ZFj8lmqa9OzOuN
	St8WYObpS4cO+wXHcX1iFT7VV7fYt/pgTcolPzb/PvkkV2wRM0tMtsmaEIbwP+rQNgLC2dDIxtm
	AXiPUxCFxRu/+McgQWrTvGV730z2LBeXEc2xKgMjUMSoVOelG36RBYXnEMY1m/+fMGMl59cMPiE
	J51XMxxouMRXyWi1MAEU2PcmYVHvFPoa6UdTGipGPmmQSLs0PqCAhPJ99mG//utHaXA1W/rzJ3w
	Kk3h8/zpZ+9a8B8ijGUDhlkkn3hzNh
X-Google-Smtp-Source: AGHT+IG3xHOgjpo7n0eMc01/ows8fVl/W9nPPptegztBLolxI1Z7VulTw5HECk2nkQioT21JP/vihw==
X-Received: by 2002:a5d:5f43:0:b0:427:151:3d9c with SMTP id ffacd0b85a97d-42701514223mr500660f8f.16.1760598551320;
        Thu, 16 Oct 2025 00:09:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099314ceesm18941095ad.16.2025.10.16.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:09:10 -0700 (PDT)
Message-ID: <51c7108b-19ab-499a-afdc-14e4a00431db@suse.com>
Date: Thu, 16 Oct 2025 17:39:06 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com,
 quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Vacek <neelx@suse.com>
References: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/16 16:40, Dewei Meng 写道:
> If fs_info->super_copy or fs_info->super_for_commit allocated failed in
> btrfs_get_tree_subvol(), then no need to call btrfs_free_fs_info().
> Otherwise btrfs_check_leaked_roots() would access NULL pointer because
> fs_info->allocated_roots had not been initialised.
> 
> syzkaller reported the following information:
>    ------------[ cut here ]------------
>    BUG: unable to handle page fault for address: fffffffffffffbb0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>    Oops: Oops: 0000 [#1] SMP KASAN PTI
>    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>    RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>    RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
>    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:1230
>    [...]
>    Call Trace:
>     <TASK>
>     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>     vfs_get_tree+0x98/0x320 fs/super.c:1759
>     do_new_mount+0x357/0x660 fs/namespace.c:3899
>     path_mount+0x716/0x19c0 fs/namespace.c:4226
>     do_mount fs/namespace.c:4239 [inline]
>     __do_sys_mount fs/namespace.c:4450 [inline]
>     __se_sys_mount fs/namespace.c:4427 [inline]
>     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    RIP: 0033:0x7f032eaffa8d
>    [...]
> 
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> Reviewed-by: Daniel Vacek <neelx@suse.com>

Now pushed into for-next branch.

Thanks,
Qu

> ---
> V1 -> V2:
> - Revise the patch description to make it easier to read
> - Delete btrfs_free_fs_info() when super_copy/super_for_commit allocated
>    failed, instead of NULL pointer check in btrfs_check_leaked_roots()
> 
>   fs/btrfs/super.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d6e496436539..dc95e697b22b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2069,7 +2069,9 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>   	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>   	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>   	if (!fs_info->super_copy || !fs_info->super_for_commit) {
> -		btrfs_free_fs_info(fs_info);
> +		kfree(fs_info->super_copy);
> +		kfree(fs_info->super_for_commit);
> +		kvfree(fs_info);
>   		return -ENOMEM;
>   	}
>   	btrfs_init_fs_info(fs_info);


