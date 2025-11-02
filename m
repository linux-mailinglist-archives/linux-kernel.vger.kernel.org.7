Return-Path: <linux-kernel+bounces-881740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7FC28D63
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD143B39DF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364F2236E1;
	Sun,  2 Nov 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul2QtWlS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0734D3BA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762079767; cv=none; b=bcsLRji1dfKoLYJfIe4W8eGzQtO06UkUV2AnfujK9CuG8MvJPaHD5M8hJ2zmga6GuZ5TcAu4FeePG6Kt/FV2DERPCLlQ2FDd6k/4eGp5CkAWMzx4Ti3HS4KINe0336nYppIdLSCxCbIOg4CAKQ9hjVNS63mho/TO8Y6eMwMhjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762079767; c=relaxed/simple;
	bh=QDjFHAnNGxJtqq3B2eRN6crskPhgy/pT5GpK0XQSS00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6njtW3BgOIDF3jxwgKTpJAv0v+hUZrlnSNadpw73J7h9nfzjc8kcHOwCJXQZ5l8GG/3LF5wSKD7FMFi8vBoJYNGYmByM6yxH8qX1SF1GU4YaNI+cDYJrmJ50uxZIAW9mJI8pFT/4c9Z7xh7YMNp4Fc1MUh370RCp+3zoaHUCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul2QtWlS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso23911655e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762079763; x=1762684563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovu4hk1QeQJCG4bKMFk7VDTxcv3q5N8PBdUxZwYYOd8=;
        b=Ul2QtWlSoDxh4MWqylZ77hg4fgrgfhBG/oBdfPiFpbVTzpuRWxE397hTj3ithGKGPF
         GTJULEaFTdN7hb9gjT12mgukgtU3s+/RO+WxcrdiW14ptIw8wAQEumWky4MuCC5mfyWn
         2ZuvwQ1xYqzJr8TNWIII/fgCup0TRkBBlQ3ygfoC9uYjhAh5KyHb21jhpkmHKOjcnt/K
         kVc2WVea3xb+YdayRdVQe2fcYI2ErHC+Kei7gFco4vr8OGbYuIsHnvo0hBfbhRD1LsJH
         CHmnA1NXlQ5KhAZ/tY4dvEzectJ4BTf2fff8TEUS6IvWuVdxpkjzkaBkW7yWQcmApZsz
         2oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762079763; x=1762684563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ovu4hk1QeQJCG4bKMFk7VDTxcv3q5N8PBdUxZwYYOd8=;
        b=VjxiDrH1SJWULTJZoIeKyDVqN2RbkXwDg87CL4tOnXPHpJQlqYX0qDxEkjMjLRdkp+
         /YEkDs57dlzJ0kimgwn6cxZ/NZhHGMznsPKawaU0oqIqMWSbHdm28iiE67GXwTaViNoS
         o/B5azyq8FwwVrnZdFFCqbfhLijgAqc0BIGNoDmfg7/iE9F5F/Qu/YCAAm1G9KdglIAw
         FtoW38tvAYALgG4ZbRB7195ELocLY/gl0WVxTXiF5gzUYQp9ZQsoI0ecdGbmOdFN99np
         O3xKbMcim+f0j/p7LFJfD6q8eC6MLoDtKgCZniUBFAtc8kXkvrasEhlYLJR5MqFcYmrD
         7W8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYJhdHJGSZG2MIXrpa9mBKwA1out3JnWoKT06BrChN/LzEyNnxTw3MAlA2aKim7cJh8Z2qJXWVfJmuRzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYw8KNrxJWpuHBJvWKiA6R2YL1E7o0EFr3o0gcglNA8nYtLvwn
	rnz71iFoAEYhPRjB06Uv8x9Mfi+NdsMFYmAUGLBsczngddo++rkAYqpU
X-Gm-Gg: ASbGncvcMN3ER3oPJgcpct6s3ZGkEJJci31rUugrz35hiYVKPMZTN04ylPZTtcHg3hE
	N7V7+OWvpObcJzRdYR+dGHmvbqgwxT4noFbTANsRorU3JfA9nHOdxA/39o9TR/34iZGuq8bm05c
	GlIzBLD4/OzFbfwJ5xQSGyRcg7ERzKxiNQsyMn56q9HJ/IPWisACBye5fdv8/IdhYplREMZol0b
	npYnPaFFMrhON+kvT5NMxHsQBnC8Qd3MlgnV1cwwslS06KYoHz8C5zZHUUjjGCECSs1zLwWJfpv
	VBQd0Yu3SV3Xl+HT9xCMSbM4ZD3YsYQPyZEwFXl754f1BPk/JAAIBWOM1CLNdH03x+4s+j0uaY+
	Cbsjypx1wffRNK7jaKZWx+PbItZGwDHDYGS6ORDeuAFFsxGtg8m0twzAWy3TLgLtEFbpuEyE/lg
	eSf6p13LX3x4EZzBttSD/JXOSyPQjRjtXOlaj7jx/fUgjuOCaM9MlX
X-Google-Smtp-Source: AGHT+IHL30gVPu+1tpP35sbbUpZLKsl40U91AdkYUoDD4qFiMCXwuao1AO3rSfpQub8UcTTdTBgniA==
X-Received: by 2002:a05:600c:1c1d:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-4773086e04fmr100701075e9.19.1762079762968;
        Sun, 02 Nov 2025 02:36:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fbeef62sm64496655e9.1.2025.11.02.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:36:02 -0800 (PST)
Date: Sun, 2 Nov 2025 10:36:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Linux Memory
 Management List <linux-mm@kvack.org>, u.kleine-koenig@baylibre.com, Nicolas
 Pitre <npitre@baylibre.com>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 6/9] lib: test_mul_u64_u64_div_u64: Test both
 generic and arch versions
Message-ID: <20251102103600.65754bf2@pumpkin>
In-Reply-To: <202511020421.ZZPBAIIw-lkp@intel.com>
References: <20251029173828.3682-7-david.laight.linux@gmail.com>
	<202511020421.ZZPBAIIw-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Nov 2025 04:59:10 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi David,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on next-20251029]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/lib-mul_u64_u64_div_u64-rename-parameter-c-to-d/20251030-025633
> base:   next-20251029
> patch link:    https://lore.kernel.org/r/20251029173828.3682-7-david.laight.linux%40gmail.com
> patch subject: [PATCH v4 next 6/9] lib: test_mul_u64_u64_div_u64: Test both generic and arch versions
> config: i386-buildonly-randconfig-004-20251102 (https://download.01.org/0day-ci/archive/20251102/202511020421.ZZPBAIIw-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511020421.ZZPBAIIw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511020421.ZZPBAIIw-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> lib/math/test_mul_u64_u64_div_u64.c:142:9: warning: '__div64_32' macro redefined [-Wmacro-redefined]  
>      142 | #define __div64_32 __div64_32
>          |         ^
>    arch/x86/include/asm/div64.h:78:9: note: previous definition is here
>       78 | #define __div64_32

That is preceded by a comment that says it can't happen for x86-64.
I think it would be better as '#define __div64_32 @@@' so that you get a compile
error.
But that isn't part of this change,
>          |         ^
>    1 warning generated.
> 
> 
> vim +/__div64_32 +142 lib/math/test_mul_u64_u64_div_u64.c
> 
>    140	
>    141	/* Compile the generic mul_u64_add_u64_div_u64() code */
>  > 142	#define __div64_32 __div64_32  

It needs a preceding #undef
Although I'm not sure why a normal build doesn't show it.

Looks like I'll need to do a v5 :-(

	David

>    143	#define div_s64_rem div_s64_rem
>    144	#define div64_u64_rem div64_u64_rem
>    145	#define div64_u64 div64_u64
>    146	#define div64_s64 div64_s64
>    147	#define iter_div_u64_rem iter_div_u64_rem
>    148	
> 


