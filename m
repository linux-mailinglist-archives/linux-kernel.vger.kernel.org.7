Return-Path: <linux-kernel+bounces-892497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB2C4535F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6465188D7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1462EB87F;
	Mon, 10 Nov 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPW6ZLMG"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3E23D7C8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759648; cv=none; b=PBhr04FA83yw5HbHP77i3wUjM9xtO8EjXw2uYYUuiUhTJuPYvPekdamkY6T8eeaT+D+KoX0ECehAmYxJxXjXDaOmkHzP1vZP0AkZvE0n9OpgzhDDTKPqPKlhfDJt0gcK2ZAuBxBKmN1Sxgz4ZvfemUOgxagJuoOq8R4YgLHhT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759648; c=relaxed/simple;
	bh=zFmRxrbyWI+Xkw+KlL1s3bZGp1Og2TOouxgOW1jpar0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5bTMeS/rQV+ILw1d1RQBApcYtn4gBz8HMv2cpdldT0v/CC+MELAoeqKozlzoMp/MAk9dgdeNb+xaqrFguvCLD9s/1flyr8CAwNJhvCMOBnE8lxrdhQ5drXEiv4p4nq326depazWHucClk1FpQM9FCuJ1w8a9Y793K214UVURiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPW6ZLMG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so2252331e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762759645; x=1763364445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zFmRxrbyWI+Xkw+KlL1s3bZGp1Og2TOouxgOW1jpar0=;
        b=PPW6ZLMGKdQwg7X65igynJLyOb/DV9MWO7k+ZjKp259k+JJ0DNLn1h1NSJl3F1EjBe
         +Y5+eiaKphSv6tccBCP7iUU86JIvwIOywDVUXQNd07qUFNoPlh7vXtZgXENbmtfwy58/
         LnOVqNa7XXhUnitnDGpDpq2sK0MPTsaHGYnx8iACBSOTGGvZ96S1861KNF2PB4WeAkKq
         Ecj6aDdDalVHXuNOinCqYSQ8J9uIKIgIZrvcukXisLNKTvqqeuUNUMqg/tjFRUhiAw5E
         kNDYot8KYa9E1oHX5vIhI+mIjJq1/dMTHKa7rqIsd17eqN11V+7WWkGG46Tu6Yvgpy/+
         HXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759645; x=1763364445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFmRxrbyWI+Xkw+KlL1s3bZGp1Og2TOouxgOW1jpar0=;
        b=XBuVuWTS/d2t+lZ1HDHWmSxFJnsrFNK6ztpgWaW2BDK5vSzCZehS0wax3UdU2HzeQy
         Zy1gftOtPzB/+lNacJ/8+zR1aoqGp6je6TeDX507jFuara7s821qBDIK0FyWpbsbwNA3
         EYWnrt+qZ14wmH6DPFZQYgI5v/YaVUZYfVVzMThGrf0MHnrUAQbTxcX5hXhLI8DPMhTv
         x4p1WrZruyDh6zAJGzi+SF4yii5Kea+6FkDBzResBYpFPBQRnv24ocgrBCWanI09jRxy
         YP9Wn4pA8AAsWDi0OiNI0dybmyzUf3BToJo3GSDW5X7Ld2RfH9M9piLSoZ23yFaTp2f/
         kfxw==
X-Forwarded-Encrypted: i=1; AJvYcCUATMqwrxLgxKMrZ+hkgcMbB9C8nQDOMoEONzlX1XtGUgZvLmUD3FQB6LkybtPIfwEJcd/crX5d0iO7iP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAGOKYNqjGfHjr1kxtmZnXgSsPtarU92qxzQxNehmuFqUA8m3
	Obvf72ikQBOdb4mKgn+/052pAZCNshLS3LK9ORg8iCFGlbb1lNmWk/Yw8wDMubgJrzG4ePgxGec
	xYJP7+Eyeq08+ccN7rMliwcsebX3j3zMAvA4F2nPqWQ==
X-Gm-Gg: ASbGncvBY+H+2z3UpKp+44kt9j71+VHUC9yw6PToGXy017GjZhRmAg+OaEMOhbe6t5h
	pjoMyKPZisx6TwXDtTawNA3OEZDxnVGzwh4y3Gl5Gr304upuejKk3rCEqvSWttwVfsYr8NHh4cm
	yau53Kcd8kPYcyP1g+0HSGltDZbyF3iNm1MCdkRZWYZdw3i3+1pUdR5I9meKhWS56Ht9qJ5qu0V
	kgpGtXotbKUpkjqcTYZBVeaX24zWmyqwaOzQvre+jt1KKeIy5N6jCe/Zf48DM7DNdISHCYP5dBK
	00wVvQ==
X-Google-Smtp-Source: AGHT+IGlioU1T2hP3Cx0sc7+Mr7UkNaal7O9PAL61dndO0rtpsV90YULtsgVShH5vUrfvjL9XfatE7BTdO4oqCTJ9rw=
X-Received: by 2002:a05:6512:158b:b0:594:2d3a:ac3a with SMTP id
 2adb3069b0e04-5945f1cbad0mr2332507e87.50.1762759644829; Sun, 09 Nov 2025
 23:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022021149.1771168-1-huangchenghai2@huawei.com> <20251022021149.1771168-4-huangchenghai2@huawei.com>
In-Reply-To: <20251022021149.1771168-4-huangchenghai2@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 10 Nov 2025 15:27:13 +0800
X-Gm-Features: AWmQ_bk8AETv2C5IZ93gSpurFxtBryq9dpTt1s-OPrxlqyqvEB6Pt4mlGsBJqt4
Message-ID: <CABQgh9ErFGWke8M8oF8eUcgXDfObY613Sb_KeC1R2h_NqXi2hQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] uacce: implement mremap in uacce_vm_ops to return -EPERM
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: gregkh@linuxfoundation.org, wangzhou1@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com, 
	qianweili@huawei.com, linwenkai6@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 10:11, Chenghai Huang <huangchenghai2@huawei.com> wrote:
>
> From: Yang Shen <shenyang39@huawei.com>
>
> The current uacce_vm_ops does not support the mremap operation of
> vm_operations_struct. Implement .mremap to return -EPERM to remind
> users.
>
> The reason we need to explicitly disable mremap is that when the
> driver does not implement .mremap, it uses the default mremap
> method. This could lead to a risk scenario:
>
> An application might first mmap address p1, then mremap to p2,
> followed by munmap(p1), and finally munmap(p2). Since the default
> mremap copies the original vma's vm_private_data (i.e., q) to the
> new vma, both munmap operations would trigger vma_close, causing
> q->qfr to be freed twice(qfr will be set to null here, so repeated
> release is ok).
>
> Fixes: 015d239ac014 ("uacce: add uacce driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks

