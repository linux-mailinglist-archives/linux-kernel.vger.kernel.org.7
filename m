Return-Path: <linux-kernel+bounces-879939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB9C246F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B31C34F34F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854DF33E350;
	Fri, 31 Oct 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BP2RTyp2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397933B96C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906199; cv=none; b=g0BK+wOt5XKZ12C3SxCa4JgWNzscIigKYgEyV6w5bbRFUP4LMHEa5YuTKnn4IuYovtn5vztrxdp+33TuautZa1m8O6ux/z8vh6YBqEaR05j2dJqC7CdCrB7iEaiKi7awPjxo1EBgUVmZODt1oNOHkqY4vUrZ+nvFFsIGKQEHxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906199; c=relaxed/simple;
	bh=s0mJfHAmF5K/DF69vj899rOYl11nAz6rTKz41ii/zGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kMvsnTEmLo7UPd+Qqv24lOfdk4WauvySYKfWOSQ3jSbnDiJxonAsOvoS5jy19db9ztQo0BWrbXALzre3bsHgVcQopRDLZ+xuDe3z8+Mgk3j754NcN/nLH8DIpHL+6tp/hT2TR+abcH8w/U4QoLj0NhBzbmxzKaA/bODsawx/a78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BP2RTyp2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47728f914a4so10212485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761906196; x=1762510996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXMKN/f3hPlGQyBPZaLnadEppjkwbleTDBKw/agnyeU=;
        b=BP2RTyp2bCi/ezZ4l718WESIK/v+hXG5vDNEMv9MAnTvUaPSJ0rTAEnDgHrvKy/cXD
         gIIwwqXOYFF7fraiuKObtiinPdtfAfnF8C9FwE+tcnWz2EcsZQGQkPMFaYFiQisLB93E
         JKegkvnpcaqCFgc34vA8LBxy/45Dk44S5mbiDmPvfQWnEP6o0fgK8b+F0C9IFxaij23R
         Lr4nyAwzypxs/ZGrmHYSdc3rDrrJMXlrrwTzlD+FDCpMx7LQ8dfOQifRZPhsrZzJn33/
         ZvNdkUOnkd2akHX5pqR5/m9HefKq2uLiTxQdYKcq67Vyy4b2iEffT7m2iEMJvnxAPTmp
         M5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906196; x=1762510996;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXMKN/f3hPlGQyBPZaLnadEppjkwbleTDBKw/agnyeU=;
        b=WNwOw8jaR9j3KxG14vhCGpyl4ouufNa27yXbiDRfo1nuPmBC+0fUhV1CRdSFBweD7k
         VMPyrXvuqdKtFSYHGXOUcYEvHBVRJflqmi3ZztEGsEQ6lkv9pNpRjNyZsqTScW0s+b0D
         HW0vEdL47fp05wQMFMcx79TdIOkKc98E8RCl3YBhhRbQ/ECXw3P98FHrHmd0S6Xur47I
         bfzTe/d7HgbGKe1g/taNJThiADns20ZnpDDG2JON/TZNNBQioxvXPUhpzNYQWfQrqlNA
         ZcbzqXdLMRRFUvXRNoxGA2kE4SFIfDp2Uvh3ZB0DHebru68Leb+WTThKFsVcFr7EruOf
         ggQw==
X-Forwarded-Encrypted: i=1; AJvYcCV97SYku8V2FpuVLsyJDzBq1urgj1Np3MS0Fp24zUzbfiRvFYsdhRb6Y70C72E6rOTCoetcWM5OiV/EToE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu40Ww6phIsZolSHIqBYNYXVLqqRo7c/wXRiwGCLuf+GEptKhB
	RCfZrLnZAozuBSMzdZMSKzCoyilmtGdvoWCmEYiyEP1zXJp/ynK9/+lbQm6WR2B+DoE=
X-Gm-Gg: ASbGncuSIUxl1b+VbFXUXh/p0Gm1fIdXbdZ3sBbvWW0CUzQbQttaNdtL9ljyGNuBc8C
	KA4iksjt30O+3ABRGvScB7NGb8dBDI311iuhMt42z4zM8l3NNC2I8qptfkySlSVxbKn7Lr2e0LB
	0vPkt+90WDhQ7v6Ab4dKXu+CK2bClMTcrwEDlpn02NmfGhrB8aLpcqWMu4F+Qi61XYDZExTTsOv
	NKSSK+WCHequsNImVRoEhuxM2xa1ykEP01CUSGMwxLFa+joDMOlZOwfBhHDLgIqWlqrEkXrYto3
	JA/hoi+E2BPGj3lvPFiAZ5ZiGfbXQkcaCBl1qt1d3LAAH6R8zSS89JlifLeXvnaSoQc+ZcQRl0V
	IE6Ha9UfWOOvetO9U7LJYbneFQW+GedwszuMG0bTlTE/BZNLdOdnEcsP1zz+r2BKWNeoFOh0Ac0
	kHUO8EpIj6xD7dZsKf0oHX
X-Google-Smtp-Source: AGHT+IHuvEibfn7tsxClW8DlHuT+oqRrLGx8+6cBjm1BnQcfhVjHOD/UlqB22n8dAmDrfxw2hKQRZg==
X-Received: by 2002:a05:600c:1f91:b0:477:e70:592b with SMTP id 5b1f17b1804b1-477305a7cddmr27504455e9.2.1761906196326;
        Fri, 31 Oct 2025 03:23:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728a96897sm87112355e9.11.2025.10.31.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:23:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dianders@chromium.org, 
 Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
References: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v5 0/2] drm/panel: ilitek-ili9882t: Add support for
 Ilitek IL79900A-based panels
Message-Id: <176190619569.1659489.7212460878951359541.b4-ty@linaro.org>
Date: Fri, 31 Oct 2025 11:23:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Fri, 31 Oct 2025 18:04:45 +0800, Langyan Ye wrote:
> This series adds support for the Tianma TL121BVMS07-00 panel, which uses
> the Ilitek IL79900A display controller.
> 
> Following review feedback from Neil Armstrong, the IL79900A support has
> been merged into the existing `panel-ilitek-ili9882t.c` driver instead of
> creating a new one, since both controllers share similar command sequences
> and initialization behavior.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e147c472fffcdaecf27f4eacdc2ef48623867bdb
[2/2] drm/panel: ilitek-ili9882t: Add support for Ilitek IL79900A-based panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2b1ffe042c4767c569bfff852f34f357817738f2

-- 
Neil


