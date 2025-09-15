Return-Path: <linux-kernel+bounces-816727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6EDB577AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CD0189E4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A012FD7A0;
	Mon, 15 Sep 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ALi8gjj0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A714277C88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934475; cv=none; b=fttQxHpIfHWLJG+GdEFVllujjQSPYQotH1unu2frITf0y7nSz9Kr3CRkKMQpsu0uoEy7bo39ep/NLVKDoyobkp6LOCwVPSnxPT1DGOZEBc0rsBSl4t1hPdnc2DP+f0F4IwCJ5vJ5H2yEGVPmlrTgnDeZNu7X9rfCzWwBNOxon9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934475; c=relaxed/simple;
	bh=jn1UDMrVa2RkwDackfdvSPicrQA1mPEJmzSV+2yR/3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKXk2QSu5eZAxALNFiVg/+q1ff1l0yRj//LPjMmktCD7XWgHjzCNCyKF09Hm4OdcFpsPwuWEK2PaQdKOdRHt5yNhC581o3RXC3Km6oV/12yTm9AmKKV97/wVA4YuonqMQr2G0a1R7S+VzOQHoXWJ41YPDHa80ZaOChSRsrmZ8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ALi8gjj0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8a4cso5104768b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757934473; x=1758539273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdq8TPOWgd9r2bHucRGGKVjUvkEbkZsPHnW8zymhVdQ=;
        b=ALi8gjj0pD7U8hmJKIvBKQaiErWndKs/VfBXIYzWzILgbmRBUwxX1176wyKFAMhe84
         4jxMhaEIzLPbD6MhM0U7t+z8ApYtNyHjq19CLU/sjJwWufwYhW+6EwJepLaLXGT+epQH
         HY+3G7isrDhBRSdsY1m5JkMnh6TGNkg5YwbVV1txMI+JmfYfy8a+djRDbI1x1+45EX9R
         g9ZxSH4cQs5GUIu+/lzzAdwsW3WB71ijhHSjX6e9CWywarc3VLsnIJ1w0JMqisGMbZWi
         7O0+5xh7kUkoSURMbXjvJb/JbtWH6p5V1B71BmUyjRPEbcimwHsvxOBlGSo3vFzJiFFB
         RkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934473; x=1758539273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdq8TPOWgd9r2bHucRGGKVjUvkEbkZsPHnW8zymhVdQ=;
        b=FSifT2kxe8cZjSRk/cfcdEecaInEdES87063yZUeIk99vKrM2v+6CBC6GPdKvU+pFn
         EmvkaCmFmKpuRCmV+0XL457gz4uw3aec+uNtAmrE0H4auHiqgGTEYiihZY4p1/nX7Jzk
         esX3KIK2TphTb2FzxD9IO2WJ0POJeWswlqV1zXISBASWe5xYuPKEPeJBKyZbufpNtsWf
         Uxd8rd/XXOesxa0VrB92V+hdOhbxSMQc6fWqZqqd89tmkaALacD5gKgYd3BQscnsX4E/
         sYDnGhxu92Mb76eMbxFz71f0MirPkXxkUszrMkTmBbO1rPphRclDeHW66jO/alWO5vX4
         y7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWy6iAEoLiRodS3TFrXDwEQ+Ods5EbbTkxoxwNCwHCnVpZDBMjA2gJMn64jAOdcLh4v5REQDr7bP1/dSMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XzKqL5xZzB8wbOoTUKQR2OBRhtys+mOWNU8Tv0JHXu8kX15x
	biFpHK69uBQw4nXvgnC0ZpxpvutT+UvIc4oy01MypDu71gk0Vg3+IOwpJwGBkn8FDuzz1SF15g5
	Uby0GgxLlH4C0
X-Gm-Gg: ASbGncsHgers/4atgLmpQanK6W+6YaJPGoBGeiQ2fjWLJ0yV7p71mqeXlE4GtR6dK80
	H0Wvwxn9XV7LS0HfIymt3KTDtlAev96MFouNLVpYiXWgwWdkM+50Xq2x673N+GBZGsrpGGvS18q
	JJb4zVszL5m4pYBcIfPrjLtgZyjxZNxdchLC2AAV+XEtDneRW/E+APZm3ytG+b+fIZ8CFlT3dbI
	zOXAuewO6fWTxjdtiiGyIbrUWBnrNiVSTlWtVtdKICiVKL147IuLOK8cs/G9pQCP0rrJTgTz8tp
	oyFo5KEPrrG/78RDIn4aFrvyml4akU/AKt7wrGz8uvqgmMUHQprtvWQoWvMJVRdwprx5Gi27Mr9
	WNi12x1GM/RFbDAlQnMnojmKXLmaJ+E1RY5A5P/B4SclbqSkz0R+t5YNozzm1gtKnmF0sJuY=
X-Google-Smtp-Source: AGHT+IFuRcr6hgmXMe2zsK7e+8P2AmK5zY9xr9VyAWEQkmImnrWVnmovPW/VnBl1d66Hj0mNNBFu+A==
X-Received: by 2002:a05:6a00:8015:b0:776:19f6:5d35 with SMTP id d2e1a72fcca58-77619f66ccbmr12225524b3a.31.1757934472854;
        Mon, 15 Sep 2025 04:07:52 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a3fesm13209375b3a.56.2025.09.15.04.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:07:52 -0700 (PDT)
Message-ID: <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
Date: Mon, 15 Sep 2025 19:07:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] vduse: Use fixed 4KB bounce pages for
 arm64 64KB page size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/15 16:21, Jason Wang 写道:
> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>
>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>
>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>> even small IO requests to occupy an entire bounce page exclusively.
> 
> This sounds more like an issue of the IOVA allocating that use the
> wrong granular?
> 

Sorry, the previous email has a slight formatting issue.

The granularity of the IOVA allocator is customized during the 
initialization of the vduse domain, and this value is also modified in
this commit.

Thanks

>> The
>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>
>> So, optimize it by using fixed 4KB bounce pages.
>>
>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> 
> Thanks
> 


