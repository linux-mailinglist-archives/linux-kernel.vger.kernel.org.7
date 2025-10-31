Return-Path: <linux-kernel+bounces-880057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47230C24C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72E24E9EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3F342CB3;
	Fri, 31 Oct 2025 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpxbNlMv"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AF331A44
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909903; cv=none; b=JABbSCMTlZzNOA4nby3Ap42WMDL7AZq2YfCdEphAleZDwJsF4MOPOMN2VhR+Mq53PU01LJ8cGd3VLOn3VPknNugelNr56hyoYuksjrU9dOze0xfhS+w8W8DcpulBb/C14ojW0cHF/WSp6Mh6EzW6KLDBJbfdwNXFAlA9DIGi9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909903; c=relaxed/simple;
	bh=ED9CYwtc6KKHPLkdtVu75+pSx5UxTvz5Uq+mO4bTt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBfpiDsA7Kuxh+PjAJzSHnjKfw8dXvUnb1mF/ID3IfaJmKZB+BuSTL+CcHw9qlv2bzvXD4qNCk0PhGF5cPtmUg7xKMQlFUiFfO71PTREiLbHwmod0Zlaepc2DH6ph0JiyEhm2V1YGAiezf5ITsP8fRTbr8rLhx5LVpDNzQZ+Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpxbNlMv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340564186b9so1579727a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761909901; x=1762514701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXm3bO9CuvHWjin0OmVHBkET2WODgkstHfaKU0r05UU=;
        b=MpxbNlMvlUUm2RDX3JCB4bn4XUSLau7JQsNnr6ABf9Q46OS9BjPZQW0g6Vdr4YrFY3
         WovhjkmA6ncmtLmxkNluRlMxvZas/qii0EuBg+Bf465IKkPU3PXb10ZNNrtEHs90N5U8
         XxFjFC1ZXtbqkZVe3SLK9IB0REglQbrTRRq5evtFwidBcGLDmdDjAvxQrk9j3Xsggx7s
         8op0dKP+C7rFHtQj2bYGtJG+2ZxwV/1EXakCGbjkK1n8pgehq8JMUep0Rkyt01IhdQLQ
         wtTDUiPEpwbCptYaKGj8q/Ensr7j7ekj9DOYy02er6sET5Sptz5aOWLKFdoBvFZ1j69B
         KYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909901; x=1762514701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXm3bO9CuvHWjin0OmVHBkET2WODgkstHfaKU0r05UU=;
        b=lkHVbNRQSJvTpTdmIj51KH8wiVp2SCWGaVLGODlB9bZh+qWu4H9Yiqu9II2kf7T0ie
         VfKCeYV2fonTjMI/N9v2rE2r4wx1Jbd1hCzmJvK6VMO6p05Vi9Q1jFD/EY4ni2tOa33R
         0To4RPqjjL9D+nlkIyFKUYaeWQJuQw659B0vpVwaIG/xo2PWNUu5B8DBZctZUIGaQS6T
         +N/xfztrS1SO4SP0a/pDn996T+Bpk0qTSC12m2q/h6PDxcAEfO8QS8crkMnSheGH726Y
         JnAtCuCZgqV4Rb1onojjPQaY4F7XNQzqOfl66Fw8LmngvKFiZi5u8OSyb+8pzoAab2D/
         DCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXCY4GlM2wwiKlhC/MgrGNP4lImIXvfMRI5gWehLOZNXE+wgXnKi43l5pX2mJ8tb1s7rwcf/Md8gg4nkHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzweflkjr+l8FyDktohfTfZeefga6gHUxF5aX15K0cHnM57yEOL
	jb3JmwsAqI7XVikNU3Ouq8yBwSGGwlh9tftEQmm8ghE176Fz3gtJz3w4WaRxOA==
X-Gm-Gg: ASbGncscp8Atl5Bo5RP2mXshg6+qbtVqo3qgS1y8PckZ0PhLrjUhtxLvILpdfBuI7vi
	0fmLZneLP8vMHTOuL4QGfSh+u4C+CxSu1cY9mIl5yHv9oKzMh5DHOBiZiFlwv7rknuYBnogA0DJ
	0ll/+b61U7FsY6UJKSAsnYcQF3y8bn8607VOvrxvjDk2pOVC4/gpLulE2BJ5RkIJU+UPOYaEDXO
	t024RAGiJI7XbSFnzeN3iPxkWa2K99nWKckI6ebFCdz+Ps9An/GwCXvD/54s9UqFEDttTm2D1yW
	bxEIfwnU3wiXDxNqiFDvD6fAtuVgYk8LggA/buQdh43SHtRH3y8/bDqvok+EiYgoAmRAwfIZL/5
	cjkhjv3+EfnZnuOElz2TBzDrB4aWfDQtoux0n1gNQpddYq9Uplh53cQR8F/LluiEGxsSejhoWYZ
	RRszlkaJW026+CgNxRsCAYwYF80xAZ6Lw1nHCm04U=
X-Google-Smtp-Source: AGHT+IFW7zonB98GVMtn6Q1eg3ObFcodxm82LzNSqRofEjjmFhBJjPRiety0kvFR980xaO4SJ172VQ==
X-Received: by 2002:a17:903:230f:b0:266:3f63:3500 with SMTP id d9443c01a7336-294ed0c53e4mr92340585ad.12.1761909901061;
        Fri, 31 Oct 2025 04:25:01 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d69b89sm1855859a91.20.2025.10.31.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:25:00 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:24:54 +0900
From: Joan Na <joan.na.devcode@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: Add MAX77675 regulator
 binding
Message-ID: <aQSchnNfyluydhq1@HYB-iPCgmhaB8Cy.ad.analog.com>
References: <20251029023253.150257-1-joan.na@analog.com>
 <20251029023253.150257-2-joan.na@analog.com>
 <20251029-festive-solemn-mouse-c7a3cd@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-festive-solemn-mouse-c7a3cd@kuoka>

On Wed, Oct 29, 2025 at 06:52:48AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Oct 29, 2025 at 11:32:52AM +0900, Joan-Na-adi wrote:
> > From: Joan Na <joan.na@analog.com>
> > 
> > Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> > This defines the node properties and supported regulator names for use
> > in device tree sources.
> 
> My comments form v3 were still not applied. I pointed out this at v4.
> 
> You still did not reply to comments. Did not implement them, either.
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>
> 
> Best regards,
> Krzysztof
> 
Thank you for pointing this out. I apologize for missing your comments from v3 and v4.
I’ll make sure to review them carefully and address each point in the next update.
I appreciate your patience.

-- 
Best regards,
Joan Na


