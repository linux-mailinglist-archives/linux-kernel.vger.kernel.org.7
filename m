Return-Path: <linux-kernel+bounces-753826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48527B18894
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D321C857CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E128A724;
	Fri,  1 Aug 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ed3tS5hV"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBB14AD2B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082927; cv=none; b=u4o5W1izbF3CabJJ5cejvj95I1pRshHaPYRYRFVJ9pUa5+LEu9vBDPUWeKsFSFe8HrVusKXLEtCYTY47FcvMEg1kBehwiuHiuo21JNS/TErUqk9vKpyeEi6teUqY31UPiWvflBjpmuNoaoODW1QexOg72ybvJ7Vx62DtaSTHdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082927; c=relaxed/simple;
	bh=8Kri1HoPuh6lwB0F7qiPiOrJzYKY+av4+R1JiwsLGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfXDNOnbLCAyUd6JIulc+HDGLaL70/MEiedG4UIK1sb2sAgV3c2s0NlrWe2RuGQ4WO8TpJftKjsxAnQMCXGwgXwSrpkZNPQTP+I8DXGRBskyJCDNEX+TnE9N0GlPYm2eAi76pSi3ATLJkLBVhn8en8V62BzGIKyyZDZYfCn0fjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ed3tS5hV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3625191a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754082924; x=1754687724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=ed3tS5hVmqg27kcwp9asyn8v6l8kjsZbFtV+T/31MD/k+8EI8GJab5hp0BiLkK67Jw
         /JGfBr2tm9hlPX8uLLEANRha18elStyH2x8Y0ayiNjPefui5stg4D8CobI3v5UMqvqb6
         9wzLq52cMIgUVO7W1+9G/LhRjXzuVqDZAiWoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082924; x=1754687724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=h8NeiWtCx1lA4pzlMDcAXPNaOgsmNxjhu6xYsRfqmsx5fUHiEYJIcW+0fdzW8twTWf
         95CGdebApqPlLj6UK4pvhECRxsgkqIcSUpD8ErxXa1iTsIDHCpVSycw9+nR6xrrpQbWS
         BdMck9Uqat+0jYbdJ+prwNtHJQqvexoBdah3AMEq78bKs4UyC3jdzFetJqxrfeJbx8t3
         vhpaZgLC7ahqP9S/3HT27CH1wKuSu8pl2H5Dy1UQIp0m1VJp4y9osyjPMOS/RrGT8/oe
         8Pvvv4Ssqs7rRqgkYxWdZnqikcG5oa5wRXcqJJRxdqZJLV8UQpD5OTa+1EpPxAV1wgot
         jW2g==
X-Forwarded-Encrypted: i=1; AJvYcCWEEM/MVdxB+BNroyJ96QVepyOXIJ0x9NKUAeL/fhO2PsP7Hk2mLR0e7OhYCeSKzZp8Mic8vwubH5b4P6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtoj5904m5IpHybFUH9SFoUk9lBkVv6oKfrwo5hvovM/bkmgl
	9emqVWlbV+GDdopV6ATZppp0MzvHiVdRPckfBiTd5f1VVx3PC/GV9QrRbho2+BmTrUiIWn4VHuW
	jc/JzD4I=
X-Gm-Gg: ASbGncsLS72craHfnrbMfFNMr78AmQjjc3CybuDggH4AynjpiLByTRPH/HNthB/5lRm
	dJ1vnTpNiv2wdZystzedQxhx7I0uriwYStuRl7rzDcWI8gI04yxwotlW6+9712E1BKJSNqODjym
	4mmzHcHMser8oOm4o76Ijg3Ej4R9cu9dwG9hvI/bWweXKFmxQtBUPXH2nI3j6AFNxtvZ6IQiKie
	hTxbyXp4TFWzUFgZUweXnsjCg9bIEhdzP8QrnEkZGSakY45EG8qdM8asWAPBJDyeg7+gPd2vG7n
	dOA/Y41vobEawWg1a47IGBhTCIdxC4MOe0CbmmKgj+xFublCTgJEpsiLCKKxD1E6QnOhRyJe1+e
	ADjHAy7d8tUTrJtvONClcjK5IqEjnjI7n2HAXFPzHew5M96+eUCVHAxU0cCV3JPWWX6KdCmtV
X-Google-Smtp-Source: AGHT+IFf2t/Z/UV0DUpTJgyoir1jpqOqt5ciw071oJKhlD/YBOvOzCTSn2ubd35B6auZPhMMeUBxow==
X-Received: by 2002:a17:907:3dab:b0:ae3:5e27:8e66 with SMTP id a640c23a62f3a-af9400ccc97mr122936066b.27.1754082924169;
        Fri, 01 Aug 2025 14:15:24 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3149sm335513566b.38.2025.08.01.14.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:15:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af93381a1d2so186778166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGWaRE3K8I/LXBgSlGpma2c5H4B7tMWo7CUdNaobhJh+eixu1e77hd8mGIlgCjDRo0RMy/8yUa6b2RqbA=@vger.kernel.org
X-Received: by 2002:a17:907:3f99:b0:ae3:6657:9e73 with SMTP id
 a640c23a62f3a-af9400844fbmr144333466b.20.1754082923387; Fri, 01 Aug 2025
 14:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com> <aI0rDljG8XYyiSvv@gallifrey>
In-Reply-To: <aI0rDljG8XYyiSvv@gallifrey>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
X-Gm-Features: Ac12FXxTQNyMa37gD218OICz8yv-5X8AXqC2OjqDUUC5iyMABu84wbERpHpCWcY
Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:01, Dr. David Alan Gilbert <linux@treblig.org> wrote:
>
> My notes say that I saw my two vhost: vringh  deadcode patches in -next
> on 2025-07-17.

Oh. My bad.

My linux-next head was not up-to-date: I had fetched the new state,
but the branch was still pointing to the previous one.

My apologies - they are indeed there, and I was simply looking at stale state.

So while it's recently rebased, the commits have been in linux-next
and I was just wrong.

                Linus

