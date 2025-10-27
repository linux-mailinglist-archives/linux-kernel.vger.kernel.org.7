Return-Path: <linux-kernel+bounces-871268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE083C0CC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF31F3A4030
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812F32F60CB;
	Mon, 27 Oct 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="JYJ8KZxo"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A512F60A4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558679; cv=none; b=YfANNQeziV0SR3DxE64g8hWHMVTyBSLQcG9UPy/fkpaVdBkwBTP8kZoVjTtXGeiuuQexxDtaPiE27yPfkwV4/L5zoqS9e+lCGR16VsL9t1czN55KuDHZ7rPxanRXdWNsgg3edxhFz0cbMIGXIshFziWkjeNK8OkHmi8/29ahn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558679; c=relaxed/simple;
	bh=KEm4VUNhIRm4CI9cgj3+YaFqPnvC9u9Y16aUqGdcNbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIDi7y3HWMqAuL2k3a+qBX+jKtgoo1txhjb7Jz8fmCigJnI1XObQdjOhop1mZcTvN0gEXPZDrcF1ES4z3FqEYtChjdeziUMj6xnyqp9O76AG0TA0skeUVFaqbTV56akT3o5f2a1jtCWqrt/dUzoGwPJ3GORlaxHduwdHvmjJMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=JYJ8KZxo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89e7a7e0256so319288085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1761558676; x=1762163476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEm4VUNhIRm4CI9cgj3+YaFqPnvC9u9Y16aUqGdcNbA=;
        b=JYJ8KZxoEWbof/UYrnQ9sGCwVHZ78XwxZ4B9RrjB700GnxvX7Jr2jXc5uYJNighWWs
         vxHVBmO3MVfAxP3TRmCxpIMAjIBpWLhWRDEaG1m7LbPsxkb/iwokyEapzNX+f1iGZ9lx
         miqOp0zljT3lk1S7Ih8/L1TtHrGHIHhSR+pnm4wzcg0Yn1aCkdWI2j7KNW2JLpeZmD2G
         7O3MDbFGOxw92mUWpV5qPmsSc1HTRFVeGXEC43/f3nBqpuU89guyS6krjlkYnbr/UICn
         VcBVdI+IpwMbS4NS6+spBJqiMqBYJuiHOReWpktKHlrkC5XSPmXvR0UjNltP5paAQ7m4
         14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558676; x=1762163476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEm4VUNhIRm4CI9cgj3+YaFqPnvC9u9Y16aUqGdcNbA=;
        b=kg4LikQ0tZGv3HWyHxVOOrlL68cYZgSMHnDFSHPQKJraaZVtF8yfphpYhPz9K3mLTb
         i49ySz0SFJFXqE2tnz9S6DRtnl82wOELJvCORz3BPkyqiWeQOHxI3ViWEF0sGEAH106B
         HoALzXv82n+wiPD1pZS8l6HI/CtbGKmTqmhSnr3IKpUSDEl1cNkqys5rxPVPWnrzG8qB
         LSkek+MUx8DxQzy35tRcP+BYHujB87znqdImJCHPTfVRhEza8BHTSy4wcwnkyjYv/7iG
         cE2hTHYSBv7QSLOVY88ZjvK/ijcVWi3S9UekjL2WzATzD1bMvg9Pgup9Zb4aMTaemXQR
         K/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUhkwnf6e6zAKcFxWA1T465Uh3B99nictx9T/lzk8YkqLrK/4kymqIDlaP4lqmnfcZTNKAbw1ZO72V7JvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREk04BeVAC8sZNsISewxL8ZwLM6EsuukJdpH6aEAnifSWO1OQ
	UxzOOFeHdPOAbC57YbeD9sX4x0HWNSKQR2Npz56tXWScHD1SgpBqQqy3aISi5PcAQ6eRSmTc8ZD
	ZP+iphgxggAVWiVIB/VP4TtLgc2LKMOjoPKYIk4BRqQ==
X-Gm-Gg: ASbGnctIIOzJi2Gh1K2fwYfjyma+nl6o0CRG25QwuPcY/S4VtCKc5r87WUzuGjEQWDB
	YRL8eVLVSV2tVAvxH3XSs1KiRk0JAC3K8J3Rp4vWEtK5iQED/J/mAdMevhyXXG5afdiz/RQMYxi
	OOPdttAnfvpIZZo43pQEqRcOHAHxmfULKiBXiJHBhsmXnfWNaXIsYwGfPJjQwaqhRqUsCETut7d
	zcqRsZs6CAWidQymvWlyJVtKEoWrslOQjgQfnYW+ldOxY/WGINurMyJ6B4W
X-Google-Smtp-Source: AGHT+IEmWTiOrlsUD5Hm5bOmrc4XIQtZAwVHNawNjN449YPwWXnSlk4xpszoLq7387lR+vuxodMoY2+83tdmzyojrLY=
X-Received: by 2002:a05:620a:c47:b0:891:a91e:98c8 with SMTP id
 af79cd13be357-891a91e99eamr3319941285a.23.1761558676598; Mon, 27 Oct 2025
 02:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 27 Oct 2025 09:51:05 +0000
X-Gm-Features: AWmQ_bnUJmMH5yn8SNjXD9lhXOuvZ_9iWgyNcdJBRyB2VgWGh475OYJjqyOR-w4
Message-ID: <CAPj87rPTKv=qv_fHTVvymNmi=nZHyxW-PgR1EFQE7T8gV1pNzg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM driver
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, greenjustin@chromium.org, 
	sjoerd@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Oct 2025 at 21:28, Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
> Commit c410fa9b07c32 ("drm/mediatek: Add AFBC support to Mediatek DRM
> driver") added AFBC support to Mediatek DRM and enabled the
> 32x8/split/sparse modifier.
>
> However, this is currently broken on Mediatek MT8188 (Genio 700 EVK
> platform); tested using upstream Kernel and Mesa (v25.2.1), AFBC is used by
> default since Mesa v25.0.
>
> Kernel trace reports vblank timeouts constantly, and the render is garbled:

Reviewed-by: Daniel Stone <daniels@collabora.com>

This is definitely the right thing to do until we can figure out why
the DRM driver doesn't like the GPU's images, and how we can get it
fixed in either DRM or Mesa.

Cheers,
Daniel

