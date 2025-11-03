Return-Path: <linux-kernel+bounces-883657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EBBC2DFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA413BA772
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D2829AAF7;
	Mon,  3 Nov 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pv+l/PiT"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DB298CCF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200429; cv=none; b=U/C33fJFx3yCoVpkq8Io25amEh8U8WMrU0VICoN3r5AYddRg40xNZVGxASCuWzdktjrcY1peUbkCRu+Wm6tCWDDPtlPSsUjcf0OQK+g4QB2hRgS5CJDr4KjYhCIz+N99iWJ78gwAQOpp0RsvbeDLq17abY81hnNjs8vAkDHjXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200429; c=relaxed/simple;
	bh=GiKgec7ngTikHOHSjKx6BwDm2EjHZWFr9d2CqhfP/bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi2Vl7Az98T+DG4bxSsXve3yxSCA1HL/ZDX46BrTDaLHuAzFi22Hp05LAG5pRZLKPezFKaufbiAuufhKfMK1MVKTGS0KKFk7kaFnFt1H5YYF25+e9n9Mn0Jb0LQ1lR7PrRJc8vqMMDrhehUGfiMkevFW61leDfIuk6RL8kv+q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pv+l/PiT; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-92aee734585so206391139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762200426; x=1762805226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAEX0koCAPFxvjYuXW2W3bjaZICrr2wnGcmP7E7k/4s=;
        b=Pv+l/PiTGUgNeBNreiSgWtwrhMmv1fFl5o8MtdFj1py1JGjm5DjFtIFCE/da1AQrCN
         2CKlumMP5ofoqP8Qay7Q0MCQtrqKXNRRDjQ8wdo/cokvb06ecQdg/394/Dtn4Mc6rKe0
         E8E7d+Nbf1W4wcK8ZPSsUsI+HM+ZywO2TuwxwDxJWxCsEPznWe6gKoQU9wsbrkgXIclO
         clgY6DtvGcTUv9CZeNk9hV5QGefwj8BLLBy9smG7kt9sCz6Dg5KsDqy2RboFLzEjB4ZX
         AX4PF9nywL9iIB7eNG4sWwNtgY8sC2f70/kBvHOP+ULS0QsDzidfqAeXmw0AhG2c7RnO
         WSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200426; x=1762805226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAEX0koCAPFxvjYuXW2W3bjaZICrr2wnGcmP7E7k/4s=;
        b=uO+qRfSseLTjPWmjnWoQZF6GSlikfuxZ20sFL6exvFOiQJcl1f+PlyR5yiRE9ECexp
         wG5OocdmX1zW9PZ6R/a78Sc3Totu3PBFaX0VZfkVV9rKDIBW+7JvRJUsCdig4I2KwiMg
         OV8Zr//SI4YkCHovOVcwrl89qqyc5TNLx6MHCTHQxCOVJo5uDHH+pnTWTYZ8IU8iKhhP
         7fBbOk/rbHs9IxS482QrH7dPmKxRIOBqstkQCcHVHge5TsCCkAFzNprlyw0BnaQoBgsV
         GJ8iEe7oknwPp9EyS3RiGkb2qWSiJVNNqTzfqwqPLHIf367Pi1/qdcZgazx6BNjzF/ME
         xwCw==
X-Forwarded-Encrypted: i=1; AJvYcCXPkBuPtdGws/1jXqHqWOPX5B9SDysqnzq4x/fMJHilMLMLBt/FbFN6leQXU8/RA50Gs1GnqsY6VSLfVLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/Uv4THs6fyCRLDAWIP1IyKVMOAKcFj2SKuurwryl+vlhCj22
	k4YwmdTH759Rc2i+MvR03I+7HnJ+5wOd+UVxMSsp8VvwKV5kFtHvDdbnxKuU23fH/v9BxH7gOvN
	Kuqwy
X-Gm-Gg: ASbGncugZQYvztUrKD9qfxL2EwMwihVGM2fCYsLy47UYtHtZ79vceqQtk9o7GxauqDp
	M/w18IkLpGQLMzAIqhZKIHqdap8smqrR8yEemewY0EdCIdRIg/AWq7EwraQDOqGx2kGA2ZwuUoG
	LUsIf8pld6SLq7/HSTTQJ+XhYANS/NwubQrKziv62zI5Ql1S5jQR6ZFYF6h1KA87mkGo73dgl1+
	dos9b+Lfuz0vpTL1acDVrXq8z5O+yWxdJz0scciF5Ij6k1RWKC2YfbCwVl33iMQtfhZi7hmX10A
	i2/QUNbwUD0QK/1dFYsmJfraxx9H691wGbG4qgPiYm3AzH1reYGLd/SWzLMLFrzliGOcK3I8Zfb
	d0gIo0w4ZYuQrIxrY6zD0BOLcec83jpJpGIbLZ+CvlnCpfD09e6mBHKYlzFPfj+BPUhqKr9pO
X-Google-Smtp-Source: AGHT+IGH8toKxw75e9lks1D1eLczCWJzuOJzKorNF7XgrQzKNt3gJl8ETsv0rH+NVLYkwtk59SitZA==
X-Received: by 2002:a92:ca49:0:b0:433:2df8:5dcb with SMTP id e9e14a558f8ab-4332df85f7fmr61837955ab.17.1762200426405;
        Mon, 03 Nov 2025 12:07:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335a91913sm5061305ab.3.2025.11.03.12.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 12:07:05 -0800 (PST)
Message-ID: <2352e59f-0555-4318-820f-4d075acdda07@kernel.dk>
Date: Mon, 3 Nov 2025 13:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/memmap: return bool from io_mem_alloc_compound()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015172555.2797238-1-csander@purestorage.com>
 <CADUfDZq807sZ5ZMeX3adbV70Pjjbn299kTwyADhEiJqcxMO6xA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZq807sZ5ZMeX3adbV70Pjjbn299kTwyADhEiJqcxMO6xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 1:03 PM, Caleb Sander Mateos wrote:
> Hi Jens,
> Any comments on this minor cleanup?

Looks fine, arrived while I was on PTO and apparently got lost in
the noise... Applied now.

-- 
Jens Axboe


