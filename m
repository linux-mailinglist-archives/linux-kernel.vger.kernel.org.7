Return-Path: <linux-kernel+bounces-862855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF01BF660C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81F05502900
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8835502B;
	Tue, 21 Oct 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wDcIHRtd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0879355031
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048661; cv=none; b=YJpfniJmHFI0QoPRJZlSZqiqYqr6ZBIKWY6UJsKndXOmhPIsYmQIsnBqbjOjS7YWGggkiyjB+8efyymNQNymOAE7o+tpKBcoHlbMH4rSaCP34US78XHdPh/asYbdELwRTs/SUzK1PCfoHHJErR3xaGRhQQv33poHOSW7vGEKlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048661; c=relaxed/simple;
	bh=SaL5Hdd+AlAzhu7CLNV0IFeRBUqzc12u5Qcc72oUets=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qhd3C41iTldV1VhSM111Eqodl3ol6wQN57j6ntWv7TrcGLSY62ISMy+J6TB0wpYjun6ni750fcva5kYMvE3edGPAEcvdGuXV2BRf0OBwcqJXkJm+PFdomYRmgVyT1SBVyhJ/QI7Rb83W05eRDWt97U8GZfUCxDwQv/tGSgkllk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wDcIHRtd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471075c0a18so57969265e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761048657; x=1761653457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtxly3kQYxnRyXoIDVW2wTlRezx+MmDctdv2f14Gy50=;
        b=wDcIHRtdz6Eicqkz54qp5JjwZkpVBuKzO3/rfbxH1a7hE5NCere7366EtYn09gLwgq
         XSAjSzEpvvLpxCNsHb3x1tAMDiujVkHaZCZcIY+0iHhQVf5IKwZcpXYTQI/6Ou3L+ltR
         EDmtw1lnNCDoC/8Cb70N9EtKJjchq0roHhmaZu4jsu6Nf1LklfaM4z9pjLw1Xn6ic0cL
         TO9+np3eJUpZ+rvVm4EZSGZp3r7oKSNvdczA29T7S/q2BSeZolq3JZ83rq2SqgRBZ7rr
         tk2kIkRLMCyBfbi8ghalf03jkTwYrT23dyWXe2aAxmIjgTQ/dYGRj4yMw+6b+4wdwgYk
         kwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048657; x=1761653457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtxly3kQYxnRyXoIDVW2wTlRezx+MmDctdv2f14Gy50=;
        b=k9VMPZMF1mov5LXNa1BKkqRJ06IT5xVjIs2E7gWtWJOFVH/vB3DxFaCQqPuALpJ+3G
         XdufpIFqcWi+JS1ptsxmp01xVLFScVTUyVbcsCMYkxFteLgd4/i+RHicbDoo+bMg0CKB
         qU7L6wBnHIpZg83mWYMoYCYLK6UY0xtyUTb5+v50ziFQLAg1mAeRTqK+BZsLaqTnNWad
         Ap8E4CtMPAy6tkJ/ICjGtHNL7k+DMy14tZ86Rw9IpnGhWj0eUpRpDKAXjXqMGiOxVqDQ
         qu+vrljHwgRR9MLa/hLbl40JtM4qEnV53L7U3zti6a7qQ67aKmXgg3khoJfsjtS9fg+s
         YgIA==
X-Gm-Message-State: AOJu0Yxyo9FA++5C5I63MeDtccGXEDKmMCxwhPXXAKDbbxIIL1BqtOop
	mUMw9N78/qBTGoo20IdVqpZJKD23ZLbTh7UwDbqI+YjwbJe3JCtP2EvDJH2DV9XJM0BNpzIK7NJ
	KdgjnHmF9NA==
X-Gm-Gg: ASbGncsG1Yn/L99HHNZsQC0X/jH1WaMukp/n4ON0ReqtnOs7B/ywprLdrvFGFrvRu7L
	iAe8MweP1JVyW10AEzyR1ai+bpucmQV2S1C3dGxn0gdKxrlBsNOsH5x24470zewSstRzRmn+2dD
	Cby9GaYZ/SSvgP43iUs2QgPQJfjYL/7Muy07csTPGIV2MDYWlnWC8pDwjGOE1HIMpXw9p2EoUsr
	ke/Ybq7hREtCI7r+TlO+4gI1w//vIDN/+7VJjtrSa1JDlod/w0n+kx3n1ry5lpH4yWD5JobF71a
	+5wOC3qRORfzPxntrIjsB0a88EM10L0XreZclvD5MUmgNVwdXYJlBB9bG6aVSPj7dpv6pNGtC9z
	oBZL6YZvHs4DkvZniPE3rIt7gvHgqL8O5JuoAQLfD41XDfcgPGAXtub9ZXQ939YEuoRGJSRfWsA
	W6mg==
X-Google-Smtp-Source: AGHT+IHhcHl2PtK3D7ZC0ypOA/rvfMUFfHo341+xc//oeoL6V5waS6eofKQEiAaatQp+riu9Ujue0w==
X-Received: by 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr159636965e9.34.1761048656876;
        Tue, 21 Oct 2025 05:10:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2979:9ff9:6677:97c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496bee326sm15474005e9.3.2025.10.21.05.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:10:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	Mary Strodl <mstrodl@csh.rit.edu>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	tzungbi@kernel.org,
	dan.carpenter@linaro.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 0/4] gpio: mpsse: add support for bryx brik
Date: Tue, 21 Oct 2025 14:10:55 +0200
Message-ID: <176104865318.22669.16904591051236557444.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014133530.3592716-1-mstrodl@csh.rit.edu>
References: <20251014133530.3592716-1-mstrodl@csh.rit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 14 Oct 2025 09:35:26 -0400, Mary Strodl wrote:
> Hey all,
> 
> This series adds support for the Bryx Radio Interface Kit to the gpio-mpsse
> driver
> 
> Here are some of the major differences compared to the sealevel device this
> driver currently supports:
> * Uses an FT232HL chip instead of FT2232HL (this is easy, just populates as
>   only one interface rather than two)
> * There are only two exposed GPIO lines, and each is hardware restricted to
>   a particular direction.
> * This is an external device, therefore hotpluggable. This caused me to
>   discover the race condition in the polling worker teradown, which
>   accounts for the bulk of the changes.
> 
> [...]

Applied, thanks!

[1/4] gpio: mpsse: propagate error from direction_input
      https://git.kernel.org/brgl/linux/c/523ebae1cdcf8056dfe090f31284d1e5f5d1b73f
[2/4] gpio: mpsse: ensure worker is torn down
      https://git.kernel.org/brgl/linux/c/179ef1127d7a4f09f0e741fa9f30b8a8e7886271
[3/4] gpio: mpsse: add quirk support
      https://git.kernel.org/brgl/linux/c/f13b0f72af238d63bb9a2e417657da8b45d72544
[4/4] gpio: mpsse: support bryx radio interface kit
      https://git.kernel.org/brgl/linux/c/03ac8183c9a5f0a635184d3f4eceb47480fcd4a7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

