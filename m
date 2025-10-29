Return-Path: <linux-kernel+bounces-875417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B2C19067
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA21A462ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75B30498D;
	Wed, 29 Oct 2025 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYa7HjWB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91E3112A5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725390; cv=none; b=a/wki3EwU2665fAVEfeR1zkbwix8WxRrLRa8f9411UU1eWQ5wTc4GQcsIZ+0JLR5khfRpkdGcFUMUhd7MpEItC0ZYiy0d5D+4AeHtbUujBx/Rfbv4WiHiZpSrTStNyPsMwbcV8YLmXlNGCgHJy9GjwT8DGlOUTumAkpDoEfEkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725390; c=relaxed/simple;
	bh=QTD/mxMJrrUsbITBRf9v5qnC5G+GX+6TQ1fzVrRn0eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inBz0/Ylx28kEcxKDg3anju8FYlt/Bsfv8iNcI+5HML1XcC/1s9siq0NJWDjW/TYcN/xLniKHfxOwuuxdvx66JJN0uq5+LE8Mv/JXt3VIlFQxKpU9bg4oP1verJs0+tDZhbyiBWaWKEUPZFEt/rwD9WlO77V0dWE56Qf+nfXQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYa7HjWB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so7037525a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761725388; x=1762330188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LNjuAHfdnVrSLNCRy6xIGgJea4x8vYhKPXV6kMxxL/4=;
        b=IYa7HjWBMqeUT1EUGWNTdjt20SH42CnEuu0m0qojBunynxEEDyKX3TY22JbAi6WviK
         UjFD4L/TxsvI8d/JLO4OizXJpLl9A5Zfhb3qLg1moWzNrYe9O9zA0ExOONYsVzs2Sc+c
         UjbWOSlq0MokSy7UUkD9gX7fUUoDe5HqYtqo5wBz7caFmTcqrw+kgdZhjlGQb74TkZys
         iFVDsLM1dH3KyRT+NEPtpXIxfnS5VmZItPd3PcjILF/1dNvzTkFYi7b6DSof9GQU6uq7
         dhGOpgjGQ7AYwK8xFwWygllJMkqYWfa05V/mA0iEZwo4N8oqly3asD9Ym4pBvTTIMSy6
         f5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725388; x=1762330188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNjuAHfdnVrSLNCRy6xIGgJea4x8vYhKPXV6kMxxL/4=;
        b=WZ2zzjcg5deFujYtqYXpkFBf+dhC1T0V0DTHMmE8W5KhEhC6bTWxOQ4lNmt+9dET+J
         gvo86cx7F4obwT9vmTX2UYp9pQ7GIgs/SxBf3fveYlNtxbf7t+ifPOlMHuVGO7D/zWoS
         04DeyW0p1S5dIIlpDVAe0pAqtVPZyVq7XMYoX/pFzTyq1krUJuPI2CQpeWwOC1S4jDH/
         CB6BsENiEl+b9J/+WgRawFaKofZoekB/C+jVHY6gH+wm7A9emu+94fNzPUMNqZIJlxiB
         FphrWwAr+wRBNULdthrgec0lGIMSIbr1gIs3a2o/2/SAjXeeNBCso5o0ELm726P/4i6e
         rSPA==
X-Gm-Message-State: AOJu0Yzbek/pYL2JYYfbxYuSdSLWr+jwG6PuzaHBk0yVwCTvPYYhcYmB
	p7cXFzO3Kz3o3L60yS/Qd+0ylAjdXBaBEF/hQNm91+CMtFzHiF/mv+lR
X-Gm-Gg: ASbGnctEs0DuSLLYcNt9pjihHcCY63mz9GfFWuHF8A4vdxMJ/iaw8Fi/h77OeQpl7Xq
	HXJp/0/n63aLG6crefbZshychrAJiTBNDGwYWo2Z+KKhElO1YIbBsC4SESDlGlOxHNH5S6ZNuUL
	d4fjw3/YhcoumAbUIi9nuizF7RONhBlq/lkfky24mRa/PngCc0P6bKKpt/XVjYJ4PGwQKuAGuIz
	JhUSnQi86Tgje+Cy+ZpW7qnUtJpi3+LlmKvUCMU+aH/eZikTj/aiT9Z7kpFElDo4Zge0n3uvHAJ
	B1NR7QEKPeGBoHWJyp+7NsNESCYWSYEjwPBeBjkXddzJju/x0fxxBSKI3XlIy1/jfRdQBVjyGSm
	pn3as/41hIAAZ1zqyeexW19o6O/WWoIM25adBqb215CvN+vyihlaZiOaXNPzEcsBNfk837N9iRk
	lOydCR0agCXEr7hGxcCQY=
X-Google-Smtp-Source: AGHT+IHoaokniGP0kWn4TpMtslZohdgaOiOqzJLjzpjzZxa2pu385BELGmeW9ExGf9YkZ/j/vnWN3w==
X-Received: by 2002:a17:90b:3ec4:b0:33b:d371:1131 with SMTP id 98e67ed59e1d1-3403a2a455amr2149965a91.34.1761725388367;
        Wed, 29 Oct 2025 01:09:48 -0700 (PDT)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f3aeesm14620399a91.14.2025.10.29.01.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:09:48 -0700 (PDT)
Message-ID: <f9cf5992-0357-4702-be73-881c9997929d@gmail.com>
Date: Wed, 29 Oct 2025 16:09:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to access i_size w/ i_size_read()
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251029063105.989253-1-chao@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251029063105.989253-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 14:31, Chao Yu via Linux-f2fs-devel wrote:
> It recommends to use i_size_{read,write}() to access and update i_size,
> otherwise, we may get wrong tearing value due to high 32-bits value
> and low 32-bits value of i_size field are not updated atomically in
> 32-bits archicture machine.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   include/trace/events/f2fs.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index edbbd869078f..e1fae78d64a5 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -204,7 +204,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
>   		__entry->pino	= F2FS_I(inode)->i_pino;
>   		__entry->mode	= inode->i_mode;
>   		__entry->nlink	= inode->i_nlink;
> -		__entry->size	= inode->i_size;
> +		__entry->size	= i_size_read(inode);
>   		__entry->blocks	= inode->i_blocks;
>   		__entry->advise	= F2FS_I(inode)->i_advise;
>   	),
> @@ -353,7 +353,7 @@ TRACE_EVENT(f2fs_unlink_enter,
>   	TP_fast_assign(
>   		__entry->dev	= dir->i_sb->s_dev;
>   		__entry->ino	= dir->i_ino;
> -		__entry->size	= dir->i_size;
> +		__entry->size	= i_size_read(dir);
>   		__entry->blocks	= dir->i_blocks;
>   		__assign_str(name);
>   	),
> @@ -433,7 +433,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
>   	TP_fast_assign(
>   		__entry->dev	= inode->i_sb->s_dev;
>   		__entry->ino	= inode->i_ino;
> -		__entry->size	= inode->i_size;
> +		__entry->size	= i_size_read(inode);
>   		__entry->blocks	= inode->i_blocks;
>   		__entry->from	= from;
>   	),
> @@ -1006,7 +1006,7 @@ TRACE_EVENT(f2fs_fallocate,
>   		__entry->mode	= mode;
>   		__entry->offset	= offset;
>   		__entry->len	= len;
> -		__entry->size	= inode->i_size;
> +		__entry->size	= i_size_read(inode);
>   		__entry->blocks = inode->i_blocks;
>   		__entry->ret	= ret;
>   	),

inode->i_size usage in fs/f2fs/ also needs to be updated. For example in 
f2fs_need_verity(), which may not protected by inode_lock.

Yongpeng,

