Return-Path: <linux-kernel+bounces-801883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47262B44B27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9DB1C834A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B71DDC35;
	Fri,  5 Sep 2025 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlY/DkIf"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7A2746A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034764; cv=none; b=a+9Y5LjtELWQtFSr4k0YtncgzxT7snTA9wd7E1mEoFWL8zV+dQ29CcwmrGUmPF/JsUhWyIAZzWpIcpgXXtrpau1TDISzJXFmzAavZWCp31dIfFsrYd0jaNlXJcK4UctupGAS0JTATqPStLxuhNsMZDNou/M3vKzndaoGDdnOMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034764; c=relaxed/simple;
	bh=Bbruro+lBjMgA7mDH1pp/r8lpqXNWdfm79qWVynzU8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf70DZco1lqiofYqDQ2oEBwiswjizrsX2mIUdzGdyCatV+NUwypsFrDv/6ZBPGyHRq3ZKL0C818tkl2RQeb2pDS7PbnyZfIUnizOwnlQDOs5DXXY3BH30BnDtheFIitYfNeoSKFhv8iW3zcx4RJofsKLWnkEd7zyCfi1hqeSVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlY/DkIf; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso14796185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757034761; x=1757639561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I2+OXiSohga9/Gw4Byp3e+y1P+U3kLBsy650if5j28=;
        b=FlY/DkIfQ9TtCSSK04UXvd6ix4RU8j3doQexAiic48eGtbQGK1Wu9r76/03hncT+YX
         Ptcd5ZMAOCE4KOf/rRyQj9pRv0pf/S+Sqcq9/zz20b/Ev/SY13WqVGDVNcJFld4EqZRp
         0Oyq+jsa8T9uAIHKRYWSfj6lRI5f8xYFZSmNW8OssLlQjNWxz29yo2nbQHbL46+L+svc
         PMbCDaJJrgdiYrss0QO8IgpuFw1GIy2Q+yGkCmXmrC0BVYeNpT6S30bNCoxUVQ7OjHI5
         2s4l/xVUqJM9W7dMFUAaBMZgrLZf5gbvsY1gb0423Hgf3MaapFOD4BXMFQ8vgWkkQHl8
         9qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757034761; x=1757639561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I2+OXiSohga9/Gw4Byp3e+y1P+U3kLBsy650if5j28=;
        b=NqpOqicfPOxnqloC60wCxenMLu9A7AxxGroI7GE84I341Wh2VoYuIFpSytw2p8/Ax6
         /ikB+1Tg024gUZoKTU1ZtzUleL73/2pHgRAfbxtGKLZdCcN4JtkNWhmD6lApLfSWUe62
         VGF6NKK5an/yuKJcpACdxqHpX7D2Up6GKUnikByWCFWDbSh6ngN138unoMw/YRYPp8ky
         srtpXKZLUhyPmpuh06t4f67wx/Qhy3Ci8Ian/7dlKrx4WVNMq/g5eDz0rTZ6A617tNX+
         EopKRdVWi3Gk1EpyZpC0Z3R5NrKDbfpDx9gEXGZx53OXI31Rn4peKK9J6CCc8eT19foW
         bZRw==
X-Forwarded-Encrypted: i=1; AJvYcCWSqj3SjO65pikmZmLCj38z+E040DZeu628ScBN64wzY33twwQvDmZaqqA7eCCbgEfzpKrbIXdCIn6Qv4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwi0dNd5RZ1yhA4mrydFS1GVsv4/eR1y0PzjSP6nBwPd0Njz09
	Xh0YZy6L6IDTtYB5758X59XquktOX47ydJsMWIXep65MHJmKL6pKuTC16G9Et9bH
X-Gm-Gg: ASbGncsEBOsqdqphVTZ4qXgfBTtG5Qw2KSXN6EE90CkxjEEX+HxMI4az85DBLdprYK+
	1scaTMd7ocEOdw4zfrTJV/B9mSpo7BslDiMYrV/CPZImRSrHeSTm6wgng8LMb2Pw8W8c3V1XQKY
	e0pYvBE7NzTqslKSVTK99rJUausfH9bHNib1YrtclvyFeVR/GBKPoY0if48FvQjhXFd1a1TzQNo
	2ZBe3q0O6xCDUcUjPZqFJy21htCkb2i/vtSnl4HKpCMWc52wqAUJsW73WoE1GRmaOcf9WhqqKeI
	6WEcR9W5gVMiv9VRF3TFrb5ZUH7acr47Y499FnCTL8/ev8WbU1E73EY3m2nEWZ0iEC47TyDwJM2
	iV9odNSXBUGTl/95kOao7xNpXlImEtUZ9EFyEpAcG5VmYltwiTtkTup+xozWG4LZRI34L2fO0sh
	Pr+Pq9fLTutiHDkRSeHUI7X2zsKkg=
X-Google-Smtp-Source: AGHT+IHEIC6vSNOwwGEEe4szY+c5GG/HwlLiZbSIpgmQ55Qnsrq5gk6z9VLuTQAFFNbDZOzOjPQ8Ww==
X-Received: by 2002:a05:600c:3b98:b0:45d:d9d1:80a3 with SMTP id 5b1f17b1804b1-45dd9d183dbmr776225e9.37.1757034760495;
        Thu, 04 Sep 2025 18:12:40 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm119315935e9.16.2025.09.04.18.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 18:12:39 -0700 (PDT)
Message-ID: <72d087b8-1af1-44a6-88c4-04a9ff98f660@gmail.com>
Date: Fri, 5 Sep 2025 09:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: fix task_numa_migrate to consider both task
 and group benefits
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: jianyong.wu@outlook.com, linux-kernel@vger.kernel.org
References: <20250829085529.15686-1-wujianyong@hygon.cn>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250829085529.15686-1-wujianyong@hygon.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/29/2025 4:55 PM, Jianyong Wu wrote:
> The comment indicates that when searching for a suitable NUMA node, we
> should ensure that the selected node benefits both the task and its NUMA
> group. However, the current implementation can only guarantee that either
> the task or the group benefits, but not necessarily both.
> 
> Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..58c899738399 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2568,7 +2568,7 @@ static int task_numa_migrate(struct task_struct *p)
>   			/* Only consider nodes where both task and groups benefit */
>   			taskimp = task_weight(p, nid, dist) - taskweight;
>   			groupimp = group_weight(p, nid, dist) - groupweight;
> -			if (taskimp < 0 && groupimp < 0)
> +			if (taskimp < 0 || groupimp < 0) 
Perhaps you misunderstand the comment, && means either the task or the
group has NO benefit from this migration, it wouldn't be done.
But if you replace it with ||, you will ignore the target node that
could benefit either the task or the group.

There is more logic to consider the benefit for both task & group
in the later function part.

One question, why not
if (taskimp <= 0 && groupimp <= 0) ?

Thanks,
Ethan
>   				continue;
>   
>   			env.dist = dist;


