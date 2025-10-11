Return-Path: <linux-kernel+bounces-849165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB6BCF536
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CF4EA038
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C027934B;
	Sat, 11 Oct 2025 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UbUepKmZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F727932E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185684; cv=none; b=ZdCjphwbhgSpYP8WvP1Tz4f9LVtyVc/ZjO9d5iIfEOfMG/mwpKjeY3vL2E2oQM+R7/QAVQ/y6+8/dA+3cjc0etcyTmGJthyl2rNYBy+YI8vkfMcSBUgN0qbGfwcw5NeP6M8FU/O050KczY98QlIrm3W68ZVA13C9UIrbBszC/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185684; c=relaxed/simple;
	bh=U/bl4ufAGST0N6pp6P6QL/PdrCDtrBFQXgxa3SEYU5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZHnppjVRXr6BwY9dItVj/KJqRuN3ME5X2F4RXodD0dudS6TDI2bLAKA0G+GyxSCGwXsls7pbww/d/mhO/4lBhn429NS3nvhFChvYUgmorTHmmytqdWK5r2bwrI6EZOUI/P2JXs4MRPKQpC99MhgYWGVMcQrmlnB6lgu1dYxdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UbUepKmZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e5bcf38e0so2698115e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760185676; x=1760790476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ua7lmyd27eInt35pO6SDJb7mOB6WFfFMRzMLdmFDywU=;
        b=UbUepKmZAVw8HAXK84gZWudkghv4Iyc57kGRRZtmkehPeIqNHdrtbnmEQm8YwSC/Nb
         tbpNheBO+5H3/P+GzJPL/v94ZKRLGgKYOEuHvYGxIQLf/22AAZo1J6DbsG1E9SJGfY7+
         Q7SaB0j07GxPM9HjAfuLtwlYVhttxFeUI0cOAr5qOyNQwRDyb1Ca0QqY99oF7m45bn0g
         HkQAcXiuO/qpNgtn4oFmzZCr2c26Br6w9IGgjwaEL17fNUTtzF2xSvX6WuK0jG22jFc8
         iVa9tbcPB9eO357KGAnf47MB1M98YmZrRsDQM/jPf0Cyk3Jsfi2TN9qugHuO42/2RNmo
         WhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760185676; x=1760790476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua7lmyd27eInt35pO6SDJb7mOB6WFfFMRzMLdmFDywU=;
        b=HEnlpPpVEdo0f0crpTa/qViI6qnV4Z+iD+dGBkuwgQ+De5kPXxm36FhZiznqn2Tlln
         Ac0+to8fPHifbSj1W2YUn5hWYTCHHHT8OVtl5HZhtmEXwmt2Ah/V6/wpDq8d7zeS34lq
         Zl2uV5TO1J44vHsKVfntwfMr4QjWAnyJQSTJfl9AU2B9SxxBfuNFrUhWx6kfPEtQ4OZW
         OAHA6D2huEJwZt8+DX0Djq/YEMD5OY2n/T+fvqxDQWlzfn9xpL+wE0fGQ1cde6aBUNl1
         15kamWb1uvnbE7M8Q5QIari5qSGoSyTNjtZ9t+uvnVwzwgLyizh46I+w3/VXoKFGIRoP
         1B1w==
X-Forwarded-Encrypted: i=1; AJvYcCX69ailCCzkA4dTcMI1/rzpAJVl2JOUB56xYPPbAfJu8X+PePAhJxt67ax2q8226T0BTDtWTiiQwS6OVA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybO5uRQL8wlm8xLw9Qzi7Erj4IuUn3voGK/bYs+b6dGVkyDhSX
	Al6NHB05AyNf9Iy0943HbzbmRtEEEdkf6UOHaAT5E0PTBQk/wkVOQ7GkuM7IcLIQn+0=
X-Gm-Gg: ASbGnct+BNOTDoegtiw0GHKNBRBEN/UxUeeu74m+MLDkSRWQoJiyoqUomEkTiS64JKx
	Vx2A0obNwvRdOmk3HQ3i1J71yAyo7Eq4fR4+TFSmrF7gjibAFbvKa7XSL8dBHa5asUqwjTmL3Vo
	sluU6QeRQY854caaETjqABqhBSkx7PBEOmcd/A/JC7oOnNxCxGIp3CvtE+i2KuwdZj1Yz/4JNrt
	5Z5zCyXi2CfK/Sze2Uvr7td6BW4uWhK3SlBH90pnHkpzs73fVBNbQksffFgEZgJvF4f96zmsx4n
	1DQR5gHwr7rz7Rpf4S7ryYWzT9co9v3qHXQBVhtgoNnWP0ry75gBHNFDMnKqnOATTACulWYHsdE
	kcXXUNlCY8MTyq5aj/Tf7kOG86IwD1VWnyG06wwIK5Mh4XuREEO/qMWXI7WI=
X-Google-Smtp-Source: AGHT+IEAdlg2Gh0gcg1uE0GMJdTUfQcPJt3WUFLJaaVI49VLpHYy7PNu8N1h46WTGsXqH8cxSdbBGg==
X-Received: by 2002:a05:6000:2401:b0:3f3:1be5:ecbf with SMTP id ffacd0b85a97d-4266e8e1e70mr5314151f8f.7.1760185675736;
        Sat, 11 Oct 2025 05:27:55 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc8bsm83288575ad.38.2025.10.11.05.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 05:27:55 -0700 (PDT)
Message-ID: <7eb9af90-9ed0-43ec-ba8c-fb78a57ea099@suse.com>
Date: Sat, 11 Oct 2025 20:27:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix stale extent map cache during COW operations
To: Deepanshu Kartikey <kartikey406@gmail.com>, joseph.qi@linux.alibaba.com,
 mark@fasheh.com, jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
References: <20251011083244.822985-1-kartikey406@gmail.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20251011083244.822985-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Deepanshu,

Good catch! With following explanation, your patch looks good to me.

Thanks,
Heming

On 10/11/25 16:32, Deepanshu Kartikey wrote:
> Hi Heming,
> 
> Thank you for the detailed analysis and feedback.
> 
> After further investigation, I discovered that the ioctl call in the reproducer
> (0x40406f06) is NOT FITRIM as the syzbot comment suggested. Decoding the ioctl
> number shows:
>    - Type: 'o' (0x6f)
>    - Number: 6
>    - This is OCFS2_IOC_MOVE_EXT (defined in fs/ocfs2/ocfs2_ioctl.h:222)
> 
> So the actual call path in the reproducer is:
> 1. copy_file_range() - creates reflinked extent with flags=0x2
> 2. ioctl(OCFS2_IOC_MOVE_EXT) - calls ocfs2_move_extents() ->
>     __ocfs2_move_extents_range()
> 3. write() - triggers BUG_ON
> 
> Inside __ocfs2_move_extents_range(), the while loop:
>    - Calls ocfs2_get_clusters() which caches the extent with flags=0x2
>    - Then calls ocfs2_move_extent() -> __ocfs2_move_extent()
>    - __ocfs2_move_extent() at line 50 clears the refcount flag on disk:
>        replace_rec.e_flags = ext_flags & ~OCFS2_EXT_REFCOUNTED;
>    - But the extent cache is not invalidated
> 
> This is exactly what my v2 patch fixes by adding ocfs2_extent_map_trunc()
> after the move operation completes.
> 
> Thanks for your time!
> 
> Best regards,
> Deepanshu


