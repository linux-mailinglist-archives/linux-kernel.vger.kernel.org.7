Return-Path: <linux-kernel+bounces-828139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D702B94060
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB41D445660
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AF274668;
	Tue, 23 Sep 2025 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="WonmVGXf"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671E26A0EB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595193; cv=none; b=JAQLqEGvehSN+An9hp0ccYlzohrEt5ZHE1AdxlQ+XUoiPqvO3JFZnAnp72tmKa4iHTm2uVFdKp8B1a21TzmKuo6Ww070ijpTjK+h1kmIVo6X4u7epA6zbyuaR/r6aoLpb0LW/DtNK3PtMZ+TRreqgqCCkkyO6nHvImF7YWUDQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595193; c=relaxed/simple;
	bh=1/d2HFVGLGHQMmxjDB/j0xkRdNQfTVZWtuk56ZysKew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj9BOH64meLrV3fTZPrMP9b1cZsJ8uQHPc4JYaZI6d+rrOeuU3zNecnkVvdT5EQNiwjOFXgUGEoP+oTThMU2EjiJTwq5GIn1M+lDjQn74+dcEjQiJHw8rLFf/MXDtBEle5pvifJNvW9Hby17dEvuCZLcdaYFot7jM4i37Sh+u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=WonmVGXf; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42571642aa7so12170745ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1758595190; x=1759199990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEqc5Nhg0kVbwLVE1FmI2uJU0IwqC3G08jt+br7HVvY=;
        b=WonmVGXfwvZKDUjcbmqXNRdxAicq4BOMRxs/cDL4V6VxpKSduGOouaQG3VT2DA/zVe
         cTg3UrxjTIjQzEzXyKxtreKZBtoqkhARwxenByKNDGIDzNXc4OtdwZAEb5m7RgxFbcpY
         UmsCdFlTyHHtkBiPwV2uhLAPMiBJ84v6roekg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758595190; x=1759199990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEqc5Nhg0kVbwLVE1FmI2uJU0IwqC3G08jt+br7HVvY=;
        b=usXL5sx84jPjPuNTGI7NNb/qtxBeHTFB4Xg0WQZ2xVJWX3iqGP6RRqhTjWZ9zCbvet
         c4GhKPYsw1kgZjCginO4tkM5gq8cUDoYc79kFzQVH8vvEsJvYwqnMuFIlnZEvHRq6riR
         H/ep7JIiFqZYfZu1L+4P2F8LRRg2koW0i7sB5pUm+Z7ey/Vf+XxPWaAqPOsUFCGsm1Cn
         RW89cMsLWOVta4rf26WsmkDN+EaQhIkicH3vJtEiyP7N92AmGw7kXAeReE9KQKMA+VVT
         VG7ngz7tAK23OZ2p1u8EwP9NR/jJehXIZlpjbc8eqN1EVkO+gPxiyADEB5+EjgHS5iwh
         k/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVh1Can6sWlvRulnW1z3GBaYEvXEQ/mn2TkfxXhBmxU3q4ImwKXC56qYQCso8FW7ZL1WcAZGHqZTBdZHLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1hXcEHdsswgDimJqR4AC0XqNcotTBwT1ikAn4l2WWtEEtDAs
	TaOIe55ry6/iQujB4Py5dh+vn44MzfTXGFWZ3AcoahyDgN1GFKOxe3SEcG7G/teM+g==
X-Gm-Gg: ASbGncttNqSyQOEtMy3OlriT9FlfkluLLdcpTWRowen+altkGxnFQUrEIbY2b6rDQy6
	N/c+ufga6NyKCP4O9VtNhYTo9dG/ApNeKZempE06k2FAK0nIkDCOmS4E1nft8nFHYFd6dTneEgD
	+9KoJTHczZu5yMqieT6cfKaLoE1ygs/TeNwCj8gbzopNMOYPaYvwgGPzzSGQ+85AKbcANSgpg6a
	UlgqgU1volJS/eZDLZwk7StbFnBY9yxLJXIDDQMf9lCxGfeIcc3l4pdixhS7GchyF862bFPuGgU
	t+DbYHOdJpNKnJ2oYjt5Py1vjuMjXY1yKrOtAkuiEF+E5FrxDr52jP4q2kMm/kxKAGsvW4gBucp
	27P3/eWhbPUZU1y6q+Y3622kowvPJh4ikuyYObmPiimw=
X-Google-Smtp-Source: AGHT+IGG2xktWuC5rnCJ77VprZKayFRcKDJYjnoABifuSNMEumClFcB3oEYBOA6ij/ifYDVwewko4Q==
X-Received: by 2002:a05:6e02:2509:b0:425:79a0:94d3 with SMTP id e9e14a558f8ab-42581e2ddb6mr20016565ab.12.1758595190167;
        Mon, 22 Sep 2025 19:39:50 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.123.46])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b015dd8sm6369599173.13.2025.09.22.19.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:39:49 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 22 Sep 2025 20:39:47 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
Message-ID: <aNIIc9Yf8hfkELs2@fedora64.linuxtx.org>
References: <20250922192412.885919229@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>

On Mon, Sep 22, 2025 at 09:28:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

