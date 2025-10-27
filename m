Return-Path: <linux-kernel+bounces-871754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FDC0E44C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ED654FA0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23AE2C0265;
	Mon, 27 Oct 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzKz6nUK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2A2BD5AF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573751; cv=none; b=eXKCzG+1hOsctynPtG+rvC42hr9QXf2+lLTYpSiICbUKxfUSs/T1IFpqAeGPk8QqNsuH8nG8TYcpTPZ/xRwJgWC6HlTpkIoPs/L7Z6jCG29XIBRLruQbhMCz/Myb7/gjTE3oC0+0kv3QO9GtKJ1gz8ZIs/X0JAMdEA4I+RyfUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573751; c=relaxed/simple;
	bh=shyQnY3YHWfiVFVYpdQzZRY/aKcQtMNw7xgIsZxMDkU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AMjPhbYG6i/Lh0PTsXbAKoTbAmsGHMdSYbiqFCcmHPAPpVouH3Y4w5b9pDZkO+1bZYlrbs9MhLFJd+smY1ofi8jxb+e6jjaOsm3T3kp/n9YX0Nlul7Oc9+NXr22fvK+SPGCQVJC2y9bnw3H/ePk/f9WTGB5s+kvOaD7MP6VEeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzKz6nUK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761573749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shyQnY3YHWfiVFVYpdQzZRY/aKcQtMNw7xgIsZxMDkU=;
	b=BzKz6nUKcUHLqAQG17WkfHbpxOAfvbSQq8e7ywRla27vQVzR/ELGcGz2B6M/jrONbWxtnG
	xBQku+QgkqRGlGZ6py3rShCc0fFpe47/nCMnyNWIbOi2vMrDcS69KjZNbkZgx9+1KW8Jba
	l4WMM28on6ISOfStEEB8DmNVzL7rS3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-T8iEzkPENfKs7SQrhgF5Bg-1; Mon, 27 Oct 2025 10:02:26 -0400
X-MC-Unique: T8iEzkPENfKs7SQrhgF5Bg-1
X-Mimecast-MFC-AGG-ID: T8iEzkPENfKs7SQrhgF5Bg_1761573745
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2775943f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573745; x=1762178545;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shyQnY3YHWfiVFVYpdQzZRY/aKcQtMNw7xgIsZxMDkU=;
        b=pYqY/7AnrUEM99OtjuhCVoDxLiLtbHeqLx7mTIlvnmGccotyFDuMwvyvOKTkyx/8fW
         jznPQsoX/h7H7nZctuap6cWHwtA+QweFil7IBKvwEqlJTU3xGI/eattXhEnR7MV34scm
         wwsS/8rezrPtIRO3RkjAtDGBGM8oGYI25RdY2UAaaYXGwllpaxhBRfyEdJqXs2xvTyW5
         D9G2QTFHcLzFhuGOz1V3kvO47A7pDBI+j9Lnoq0/GM4knHhwdEbO/wJPoURBXmD8LbOs
         rxwFMu0awE7lE53S+ZvzTiI2QrACOLHHYAjMwOZRyzpFo0Xt/6iyaZQKwv0qZfUpshEg
         BHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTaUK1JY9+gZsEb+tnJIv3Xv/XP60XCDG3QT9PbDHo/0PEfG9I7Kh/9dgCrFfU2YV0oL5Ps1CRutu31+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1/1h9lo1N1RxxgWEMtJdMF0+PhawFRI8qIe7JsasnrA4SS8u
	a8qPYe2YqJHAWCo0AkK9o5BbackPmoSL9yEvyFCJnDoGWWrBbPugjj4jPYnEQuUX/SNuBPPfBje
	C0uh07lvlTgcsdwbPW+3g11PAfVLpkhB0YpQ7XEhqWJykimZ+Gyq0fUDDjIw7mhYb8/Ts41ksNA
	==
X-Gm-Gg: ASbGncsy4b6fScZ4/ekXbiVYM8wouvEWNyKky5GM5srOR66pJiMA52WMKxokQLE0JNQ
	3CWM85vDTmr9rlrZKd3D+DTK4TXKry5KIs2N6ucfn1D3KD4R3NlqCuB11qCNQ0byXHO3aYAtWP8
	8SxsGSH1HaZ0toV8IDd68VCMO240tj5WgvTgI5c8PrdsjZACuQug1yjiKfwWnaEg8Qv0rQ9iZWa
	0O1pLusGR/ziE2V8cGK5RedTJaR4l4K7KEWaD2DWvoI4Nrafhv0zvRSy2tWYtjQ4OjJMkzeLsGc
	g0SYWbR2wOcVP4TEzm57m/OtwQRAJBy8lq2hwKCzqNEdCG0UM69uQ+nP5aLr5tGpGfWF+sZIFYR
	E3Fj7QtT8gXX3aNmZpVnz4g/JStXxDgCc1eZw48DBe+jsbZD9
X-Received: by 2002:a05:6000:288f:b0:427:a37:ea3e with SMTP id ffacd0b85a97d-42990755b87mr8916536f8f.52.1761573744793;
        Mon, 27 Oct 2025 07:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETyCrcEtLcl3q6Rbfg7qOzwYfycn5fPY5jgI68IwSrW44NCEA1DZHmuz8NQf54cnQJ3dYQ8g==
X-Received: by 2002:a05:6000:288f:b0:427:a37:ea3e with SMTP id ffacd0b85a97d-42990755b87mr8916495f8f.52.1761573744177;
        Mon, 27 Oct 2025 07:02:24 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm14242478f8f.4.2025.10.27.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:02:23 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:02:22 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
    "maz@kernel.org" <maz@kernel.org>, 
    "broonie@kernel.org" <broonie@kernel.org>, 
    "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
    Joey Gouly <Joey.Gouly@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
    "yuzenghui@huawei.com" <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Trap all if no in-kernel irqchip
In-Reply-To: <20251021094358.1963807-1-sascha.bischoff@arm.com>
Message-ID: <e2d3e614-4e5e-7ad9-5cc6-867d85dca5c0@redhat.com>
References: <20251021094358.1963807-1-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Oct 2025, Sascha Bischoff wrote:

> If there is no in-kernel irqchip for a GICv3 host set all of the trap
> bits to block all accesses. This fixes the no-vgic-v3 selftest again.
>
> Fixes: 3193287ddffb ("KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3 or v3 guests")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/23072856-6b8c-41e2-93d1-ea8a240a7079@sirena.org.uk
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


