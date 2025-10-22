Return-Path: <linux-kernel+bounces-864415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 269A0BFABF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5711352844
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E942FF151;
	Wed, 22 Oct 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOICZfpt"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EC2FD66C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120110; cv=none; b=rKOpg3K7ie42aPYxr0wiT/H9Dhmc5TaXxHbPzWVcvBNGyi2CEs4xHfPqiJ2rAnPmnkBBNCvbPrjSR0Mjej/jp5v4EBdbfIJm6e+00H+KGJFlqC/5JbBR6usEMtR7j/JDT/QiqnJPIhx/nNsEouebRiJ3n+/R2BODNK9HSkOpqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120110; c=relaxed/simple;
	bh=38r9xfZLwLJKROmeDdkyUpNf+YWWc4TDY/dD0X8glqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p8ISGc08Lx6NQqcWVJQBRRV5MdKuwUDtoJCzU8DtAqdhZGPpC5ijrJbjQCaThIVARysvMv+rNg3dmgF4PaeIOsoll225vsvCfu2Pj8dG+VlOv1cxR8E/I9ws3bimjxEtZaG7gPC7jf7nGk/dVseI4+fSrZUfBjdWu1tc+XeBSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JOICZfpt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33d7589774fso4137994a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761120107; x=1761724907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Czcihnqa+RdFrhOYT/oFUcxYUUGz6vVNGz6e5p2QTY=;
        b=JOICZfptOeDc0oAopeMyt6i2KiQgA9iCOI/ghk0QNTKv7fpQd+kooTmTPfQvZEygsR
         LKttUu2VwktFx+LwZixNwRHINIptI+5Qfumv3/Bg1xdg5WQcpyiCSWjKJR3C99ZRDyA/
         cFwHhTMEC8k/NfxrQS7RcmN27YTZV9NQgiEsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120107; x=1761724907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Czcihnqa+RdFrhOYT/oFUcxYUUGz6vVNGz6e5p2QTY=;
        b=OW9BJ3u3LQk33jdjl/KZHL9mIL6u5Vf6mOESM8p+Je1xUVhbSVhjl1bDXJs5z4d+r6
         HFmdZkdAOTvjwTHZBgAiuqeK+lcJXrxX02dSszWoXiaV1U3R17gLnaRbtSHCIv9HANb7
         WsLVSyYf9RBerNbINW6Lhunf+MkBaWQazsp1q5yxn+i4JSe5PUhOlJ7sHMUiDmT9p6mx
         S3bGo/VZYnNDVagXM8w4NuRvjLv/m8s5IxNuNzYXF1r0aoJhVZEB6bFM6/QwplsmHCRE
         gptwPeutv7KbB/25RRVZrosMd80Y/Y7VM/RJWbh1bQ+JbUvSNYcL87yguwvrCwX3dY6s
         IjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJar9pLAFv/26GdF6CRk1tJaA/NzsWP11I1ohJtqOXR3lcfgj+iYV9mb3JmWBavKh4BQ4U61GOjyrYI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18VPwE+oF2jhQpGDGcVLmdfg45tAn6aEbXXdc7wo+RH/79ghi
	QCdAAemLgXRVH68VjRVeX2KVh+Kyo9hOYu/ztWSrIzLVxI0GnbelURvTcJVXQ5qQTA==
X-Gm-Gg: ASbGncvGrpt7OnYTFBMJHEl7gN5PRfpQxo8/q6TnNpXx2QJ3cI0W62ClgSNkCXYjTZ/
	SfpomFoiUuI3TF7fLw/Ft0Qzh5yq3X4Hr070vLtuZLNN0Vh3yLjTthhvYfBIeWc+YCDEotQjkc9
	fkHfH3sKpKIp9aYUaOxsafw6xhqHndMxQxfg05/I64yFYfCLczaFtBSwGLv4t4AoBVvTmTIBQ3V
	DFirLN6+K6AS9JVdWlOz66S3onANYOjsyldYSQH1cNk8QaTd1/HoVgNBqPf/zpJpjFz3rvvHJJX
	hkBxJEIdD0Ya9Vw8VW44xeglXcboiY7l7/xt/YMhJzvgh51UJEGOIdljn9BsYSWMCFnPldJNNd/
	i3jivkZqcdIpWiUhpV5bAti3YTm4z2nIcAULuzut6ZGf7IduZhTvHgVzyNPkJ+1a2EGGDokSvWj
	aEuksWVnDG0IMliTxHLKG5imMam2Fn02MVHb5cJgaBPb7BG9eP7G2v
X-Google-Smtp-Source: AGHT+IEt15ezmGTqR4A8CJGFXTvCgrS4gO8P9rtkeOmGm46bHNcAFHWrZsKB4y1EeUubGMyQT47cig==
X-Received: by 2002:a17:90b:1dcb:b0:33b:b033:d7e5 with SMTP id 98e67ed59e1d1-33bcf9186f0mr29084769a91.35.1761120106936;
        Wed, 22 Oct 2025 01:01:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:5534:56e9:528e:f9b4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dfaacsm1771401a91.10.2025.10.22.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:01:46 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
X-Google-Original-From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020045603.2573544-1-wens@kernel.org>
References: <20251020045603.2573544-1-wens@kernel.org>
Subject: Re: [PATCH resend] MAINTAINERS: Update Chen-Yu's email address
Message-Id: <176112010476.488381.11368848750305962943.b4-ty@kernel.org>
Date: Wed, 22 Oct 2025 16:01:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 20 Oct 2025 12:56:02 +0800, Chen-Yu Tsai wrote:
> The email forwarder I'm using has run into severe problems with Gmail
> lately. Switch over to my kernel.org address for kernel development.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update Chen-Yu's email address
      commit: caa2f6ee91d4e2dab39b30de34d2c74b6f45d0a3

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


