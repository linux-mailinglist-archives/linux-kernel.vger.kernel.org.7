Return-Path: <linux-kernel+bounces-887963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B2FC39762
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500EF4F87C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D02E0B47;
	Thu,  6 Nov 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcKsVyii"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C97014F70
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415483; cv=none; b=dUNO1q2tJwAvqO+ZSft2HSLIfDxr1kKdkOYkaJDbDN03tr7PoRBITzBztGYda53a5d6ucVyE9tFUPaQrmSzCAdkKBg/bFwzTwgKqsdj1lmGoC5P4cWfn+Q3GYu0In9RHyZDRvybjv2iOXR8l0wapVzvo09fJjysgEVWb9khi658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415483; c=relaxed/simple;
	bh=V3okf9oIEIU43qw5xYW1BwiN1gJLrWq2sN3TplwqiZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTXxg8kULkM7wRIJb3rcCn4M8HwrbBYtX7vwQHwlf0REgNpZRvqdEG70HWmlVnFPRHz6xwwKenBRhocQRxLdtwuKVNxKIAkdMxOzp4bv+L3YeOGYPLXP2kr1f6xThuJ1BmDsSsJCB5nyzWOtrw8OSRnVA7k6WIRcRUySM+Cl570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcKsVyii; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so912912a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762415480; x=1763020280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7QbmE1T84ff08D3+wx9jlBrqSs8DUW5Q3gCIAzKNPQ=;
        b=lcKsVyiiD6AOqH2GqfPZQVE1DKIKKDtHcvOKJIU8xNp3Tj4x4yVLE+tj5VMQ1pch39
         qJ7iJY3YMryBVwfMWQl5Se9i6ksKa75bCsQTXAB7niCDQmgFOzStXJAVEwxUz1rcClge
         j4XV0U8DjZ2pgWL6lES0F+o+samexitYZUi73camA2v1LpX157rz7ctC2mR4iw9EA9zd
         OklA/1WJMB3DvDUceh+Ocdrhgf4GfKUPKw4hQQJiXoZJtijkT4+WZOwkI/mj1d1GfAkb
         A4ihScjaMVTSYEx5bEmoLYqqF8/TtdSaqkVJYQDHcViWBMCl0VmU9IsBjyCyNVeodi6H
         K07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415480; x=1763020280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7QbmE1T84ff08D3+wx9jlBrqSs8DUW5Q3gCIAzKNPQ=;
        b=fQUum5dP485IY6XKffhu34XvlzJgXVRpu5putUgd/14JpmZvs8HBNCEZnwPVTBzRGD
         Xn3Y32ZSDtBhDGOX6PP8ljRzrT5qazQfc4IMnFjLuTOBjdcxOQ9EzxtWxLQAq4KcgruI
         femk+N9Z5IgAEp6Hp/YXsWTiDfsEcw8QhUQwyWuSPppUg0yEVsAVCOO/uxag158Or3bw
         qvNfgOTfh4XiaRyOFPSyq/Mlw8aa9iGjESTXj3GCmNOus6rYtbSLktIBo2auacY2qRke
         1XJEV+xjLAZFm/qq0lfIejTWMaPFMB8SdY8REHUVJ9XKoEF1o5PjGfeyMLdFr6v03LKI
         CBMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Li6XhezIhg8Zersy56XqPBIPRnVDdjrjQ/pzWokWa3uYGY5eqLIQQD1hZX//Zl/YlxDw0dT6gKnK+D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hJa3KIWHUKqDi4Qr+E27kwaIDj4VNH2bG+vfYuBrO1qPHfRi
	PHSGw2K/hpTUFNFqKahJd3bo5Bj/smA/I9Y0CJbidyvnUboyiCzfqfM7ejepzPJNFMV2WltYJTG
	ndTKSYSm0ON6WPBfV/axNUT6vvHXckZxnckjnPZK1sA==
X-Gm-Gg: ASbGncv5kPLiCHkGGLT5DKmPdvVXDqTZF3q6aIXPnqM0IMeII6oC+eb4mJ83q5rORp7
	34hvcUsAagr0Q9Fcg8h/RMFn/PZn8SWTG7Pq3V5Hc7DEvMByIVOBi3vxhB5iOMqaMp614ApoAfm
	YW/UV3aybeqURhbl1ZUbbmPByG6AUoBF/yO37LV5TESlcvYdj2ru9t0hE7YZjcP9MwziP4tZaTT
	V9dnpPJh4qNIkSIm9p2XqPIAQG6yzUwA3AiOf41qrqUwM2qtyLJTheNaAhMRQ==
X-Google-Smtp-Source: AGHT+IH5mMQNAbO3dsRPBZZKprrZKG8gWiaT6H027FsLcjDm/NMQYqk1ZtvdWqQy6Uf2hPguHqWdFrxhl0EoZUCxvTg=
X-Received: by 2002:a05:6402:20d6:10b0:640:9db5:ba2f with SMTP id
 4fb4d7f45d1cf-64105b8ef06mr4773837a12.30.1762415480479; Wed, 05 Nov 2025
 23:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022174309.1180931-2-vincent.guittot@linaro.org> <20251106000053.GA1932421@bhelgaas>
In-Reply-To: <20251106000053.GA1932421@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 08:51:08 +0100
X-Gm-Features: AWmQ_bki5HMad9R_EvGRCt6ZsgIelgkfzutK5gpeBF-eV1fPQRjJw2903OorBCc
Message-ID: <CAKfTPtBWfuHP2h+7ExJ_mm6zt_DviQTa5KEUwECCzxsLk5=pBg@mail.gmail.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 01:00, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > Describe the PCIe host controller available on the S32G platforms.
>
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>;  /* config space */
>
> Fix comment alignment.

okay

