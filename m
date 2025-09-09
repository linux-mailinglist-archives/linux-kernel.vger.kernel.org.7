Return-Path: <linux-kernel+bounces-808278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE87B4FD80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303245E369E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A0343208;
	Tue,  9 Sep 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w7amA2lD"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332A343210
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424904; cv=none; b=q8DEyArN2TpUslPxz2+2ZuaCNBDtpDBAtJl0J/u+IzUfIv5ZqekwAxVBOYRvdguPOkftiNgWwfTrfxjmVRJ0a8rXeY2CUgTahhBne92FBgCSHK0PG8hZimRu078kEBsmObJapayWM4VUKRNakRaJ4yMXmUBjS1YR4t9hFzF0L0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424904; c=relaxed/simple;
	bh=jG8IsDeZwHzxDM7kY62sBf8rnyEt4KzhTm1tx3AAfgA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A40LS1V6/WEWux6U+hT7QEnwgmR1HUkE4VOn62HuJ8VWdA6NDzv/tvlMp1rjkn5V7h4rDkZBh00LKiwJnOCc/qRAkbZN9UzfJTxpZ7oaqivEAaSwnLRr8gMXL/UqgCzvoEOMqfRXzTdU0Kbmhj6PIlj9jtrnpGBwB8vcAapCyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w7amA2lD; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88776dcac7aso68798739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424902; x=1758029702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ppdZ0Xy9oOaMafn5LGvLXBQFRI+nb18VOs5PDZAwRVw=;
        b=w7amA2lD5R/hDxv7mRk/pOn1zY0V9WluNtOEosae/9I9Kq1c51goYOxHl7gtd6SeNp
         edkStITDcXxzUDOe8Vpu4ZC1gG58ZjlvXX7MrVCimXMP1H0gVxPyJL43UqXAjZTV4/yR
         X6ilRJAc0XzNfZzFWusT83QIqSnCiupxWyNpTnM4OtYzKrOEGn/8cEsBEqC4gqwVRqF/
         ZUkKJwv/7OzOF4IX4pO/KP6LZko0miil5VNzPMtghs1/UWxMDSzjwGy/ZWQ2LdUOIZGP
         NrORX3ppVwEtUFVqwpvuNmoI6zFxh0B2Yo4JDRX9tgXq3ZhnTf9+Be7jiG10v1mrEaMH
         i7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424902; x=1758029702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppdZ0Xy9oOaMafn5LGvLXBQFRI+nb18VOs5PDZAwRVw=;
        b=B3TPj5396b1DGYlcz+X96rFSd5kauDsTt4GC1SctEYlwQCJVblGOCwS529RVw4WxPb
         hrv8f4Umb3/Dg6vR35gbuBuOK8AbvemrSL2Ov4jX44eS/PnA4xZnf2vQm16wlRl/pad9
         LMrdaDV3yHF6KXQnuN2yQkeECP4xOROOUwlY8VSsGlwxdeProVmeAe7WT8u0NGhujA7a
         Dr4YYlBz2RdexlCTWB55DfKmlTNMW1td2c6EYMK5rQXkKdgM9Ca1g9eG0REoNpAyKe7O
         RdO5njC0OP11aY+kWmDquISxlfuqK8ZsIDFDXxSoqR49DO950EvAW/bTxM9uzc7Z5OcA
         UeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNzkAPv3ed1Vy/y5PwZbYLbmWEbH5CWg6pzmSHmmYWy5Ud+L1ruLT2T1VkS2Ru8GN8nQ0zSzP7HO9Dz08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsp9k3HDXGJlNTxVae0yf217xjRdAelvxWsvsJR63uwWdl3Jw0
	QBpOQ5IMJ+db2HSdIWu04cHuHo+bjgx9ch56EPKCwBai8L8erqXO7jk8KI/SKOBgeVE=
X-Gm-Gg: ASbGncuol6bD09VS0BG7HZRdoFloK4lQahuKT/QWX9LlXJRGx9+N5tJFFGISaM4LgMt
	jgFEa9gKRQ3VWrCkwSzdkFyL8TQPt054zTrFSpFjjqPTsIh318uc9mtWe8IUxBYJwWduTFdihvh
	VbYa8lSKM7KD+rMqGQZIPvtmeouV4ucfvQmHfkvia9VjVCpyD8Qiadnd3JX5SNGTuAPN+JOO71Q
	NAziXcvLyc3j4poY5ggoEoDwTWgvjCPPqzyob111oL9reZXWBpIVvW8TyZkQmrDseQbV9n80GHp
	D5p6F8/cZhZZN/K9fadwqD3LV7TNdVC/R9JSEJzbfvkbYLoTCTtlGBPx5KxUWmKfzrm0y78Qzdr
	nBZTGO6PxiCkAd+fLpkDLy5AQdcu3Pw==
X-Google-Smtp-Source: AGHT+IHYAqWRD8B4lp34bY+A6dfLaEL5a0CRnFZYCkaDKaJd6hK1XZ6kdNc4mjjiFupMs4Ho0b636A==
X-Received: by 2002:a05:6602:15c6:b0:886:fa71:f544 with SMTP id ca18e2360f4ac-887776af6c4mr1487216139f.17.1757424901753;
        Tue, 09 Sep 2025 06:35:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88765e370c2sm494498739f.12.2025.09.09.06.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:35:01 -0700 (PDT)
Message-ID: <4c322a03-058f-4caa-a741-7dfec0d3c55b@kernel.dk>
Date: Tue, 9 Sep 2025 07:35:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/5] io_uring/rsrc: respect submitter_task in
 io_register_clone_buffers()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904170902.2624135-1-csander@purestorage.com>
 <20250904170902.2624135-3-csander@purestorage.com>
Content-Language: en-US
In-Reply-To: <20250904170902.2624135-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 11:08 AM, Caleb Sander Mateos wrote:
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 2d15b8785a95..1e5b7833076a 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1298,14 +1298,21 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
>  
>  	src_ctx = file->private_data;
>  	if (src_ctx != ctx) {
>  		mutex_unlock(&ctx->uring_lock);
>  		lock_two_rings(ctx, src_ctx);
> +
> +		if (src_ctx->submitter_task && 
> +		    src_ctx->submitter_task != current) {
> +			ret = -EEXIST;
> +			goto out;
> +		}

Spurious end-of-line space detected here, pruned while merging.

-- 
Jens Axboe

