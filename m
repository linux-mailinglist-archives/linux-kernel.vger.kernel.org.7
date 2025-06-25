Return-Path: <linux-kernel+bounces-702750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B48AE86C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36E93AB926
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525322690D1;
	Wed, 25 Jun 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0WsGl7q"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE09267F4C;
	Wed, 25 Jun 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862456; cv=none; b=X39KZWvREVowdSPCZRWHJ+ZHstkQbzC7+pY4KWfnpwfbjjF7+GJRlgD30t59zdVNPS0ZUsELMT4asGC1mWzJZ76LNZ3fMhokBzAPuPl2W0uPOvZbLM8+s9VSzGerBmZnF8O5dMjT7zjbF9k5g/JHDqSXXoXaLQaqnCosunsDtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862456; c=relaxed/simple;
	bh=VCwdDjOQmBHe8yXyqQFz3eHpuCCMNNC3Yd3vkr5WBEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkwNrbIoeBy1xKYXihbtOdbMLuKYUuQaFevRiYkDuylTWWOBsWZ58v/dIrAzn6vdlg5r45JTI9fusAXT5gSXvDveumA55zQVFkn5CAUNx8w0UXFEeXconxrkq1kn1WUZbf/wEiWkugo5eSt20UlMwTy2l1BdlDIbC0pjSM2koR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0WsGl7q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-711d4689084so18123057b3.0;
        Wed, 25 Jun 2025 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750862454; x=1751467254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCwdDjOQmBHe8yXyqQFz3eHpuCCMNNC3Yd3vkr5WBEE=;
        b=S0WsGl7qOkkHR6TH9pKVs8kIi94O5VQuwUq+lQzx3kbkgMGeYL8Xd58CUM4FeAn3Xt
         KPo3WDwBb9iDzHQDzB0zZkul6CksRqlgt6aQ2+ZORKKZLdf0+3XiWViB6+vZDV/VA3Ng
         ADEGnTu/bwplcLo2c5PEKXdjwH4nJrInhMl/RTDXvh/3a1cv18xCYMWiOtDGShLd+Rgd
         2YvMdBgm+proKcvlZOzMSVLXS75mnHqj99uBAvKvfwhz0nilv+XXBfm/M0oVYUpZ90j6
         gTtNf38f5tQ7Z8ezTi3PbFjBZZhs0mf311KrLlQIDRH5kAM2isnORPFEo2fOfnUaVXDR
         cN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862454; x=1751467254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCwdDjOQmBHe8yXyqQFz3eHpuCCMNNC3Yd3vkr5WBEE=;
        b=IVrCIYfzz514V4eDs7423MpfHbI4/Vi2ZYA1/Sur+q1ZQ7BD3ZQf/xcsycBeEWfA1Z
         UqIl1VMp5fB9bqrEuG/b2hoopLW++5gK1STqmleUISFA9513kn0XdTkjPJVFxC8nnmoF
         O79igv3YW4qpG42cwKcH5SmPW3uGQJ3UbJaPGHQ+euj8zcXBxleoyEYATsPcNKImu/X7
         9MOoB0xRPyF8DLqyxfBBlZniaFrXWlAFRJlrVMEqYu7aVNDA1CeL0cv4Nsm4YmwBnLeY
         L7UsYqbtV65/IbDNM7ye6LkAQb1kiWA5LT2iTpC9urEqAH5Gol1YyQaSkQ0tBugud3MZ
         566w==
X-Forwarded-Encrypted: i=1; AJvYcCV7/lzAJU+TMdvhxR/593LJoMAbDwfW0JV49CHwoE+48Q162SErdyDEKW4n0J5trvybbv90Fdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIHDyAv5rMzV8MRy9Zjm46Wd09MynMaGI2q1BIMxpXfVQqEXY
	oyB2pSGkc/rIyosB2W2v+K+tb52/k/eIxzYJgEenrmjaL7fBIUTI/Si+
X-Gm-Gg: ASbGnctmaoe+sdNb82tvOoPUYbPgbXL3dTueoQ6GYpV/E231lo64ETwgR5UEeFuAYED
	wzhGNl1QpTDS6bj1iSdIIc6gxiM14fq0BEtHTXJm10nmYzxSb/lBtteee8fWaFceXdb0M5D5dCq
	cR20roI2hRKVZuc1mTNhZSQKNiqXwfK9L0yYivd5m/kPHhHG6cMHo5qjNwwv52Tf0UgwlRMsYm2
	Lx+FuVnC1PGRTxF9ZDwDoQQtNjUpl2FThe1nPzcN+wca6U3MNYHXhX/yXq2L7ecgYyADpak6rJe
	Ueb12QH2izfD0kOd8IOIb6Lsl4+hhTLEIAlC6dcsRbrQCh9TPwOBi3vUDXUCsrhfDzjXX9gwApo
	PaSQmxg==
X-Google-Smtp-Source: AGHT+IF6kyRt9MrSsvZWRvwCEdm9wo71TICPccE2cReGQ5iyz1xM8rD9BTvc06vDE57p1urbrN/V5A==
X-Received: by 2002:a05:690c:7242:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-71406c8465bmr46479657b3.3.1750862454370;
        Wed, 25 Jun 2025 07:40:54 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c49c109bsm24884017b3.2.2025.06.25.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:40:53 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:40:51 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [patch V2 00/13] ptp: Belated spring cleaning of the chardev
 driver
Message-ID: <aFwKc5R3uZVc_aoH@hoboy.vegasvil.org>
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625114404.102196103@linutronix.de>

On Wed, Jun 25, 2025 at 01:52:23PM +0200, Thomas Gleixner wrote:
> The code (~400 lines!) is really hard to follow due to a gazillion of
> local variables, which are only used in certain case scopes, and a
> mixture of gotos, breaks and direct error return paths.

But it is 100% organically grown and therefore healthy for you!

Thanks,
Richard

