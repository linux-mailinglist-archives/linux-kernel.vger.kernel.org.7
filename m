Return-Path: <linux-kernel+bounces-872648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC0C11ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B148C3BE4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF932C933;
	Mon, 27 Oct 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKn+D6Zm"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C625F7B9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603736; cv=none; b=rYCZ/m1P62ICIeDt725QRvW9PnbGhqcBdJBV60wtH1dSbxBc344+kRm1jnT9CjPt1l+UukjrkeFPR3rGalXp9gp40WilgMjh5dLgqPmEfZcbvQUkwFI8/HcAhPwQJv1GilPH53I3I+Ic//PeskHgbukDET+r6jArtAfAFYj83tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603736; c=relaxed/simple;
	bh=Egn4cV5CnJgU9OUEpru5VJybNcrGCiO3dvs+v1/WofY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pISjbFM5Wps0uEVLotyUSFiK8anjeBjlnY9/EBQB0QYm1GU9LXwsKK+bKxQS9o7M228i8PL+XM5SJj2R2ew4MggIHdFWIM3DA+T4qbqX9y+onkue+OD+Ze+/dJ2q/t+cQuU93Q0/k4kkieX1SSh4Xvhdz4rkKZWNmw+stzZuvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKn+D6Zm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42992e68ea3so228658f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761603733; x=1762208533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPQWg8YodwV0TasyiuBuXsJUnrrwoBhVKhLf4m0cFkM=;
        b=XKn+D6ZmrbjLYeIS1bPp384GMSDSjoL+g8iKdKDsVAiAIEEGPFrSnY2wHpBgLkKU67
         eiM3Jit2aSSDfo6RY2MOd9AwOqfeJwYCLUaqMa0VsA+fVH2nvMgElFywzPL/t8I6+XaM
         cAhEKh0xQLqrvo93Enns9/FxP2e/xRPyKGixLZTDc0p2K3KpLL8wQJImD562SrH1dFGP
         bfihBsG3hEGSsHRBT+ekebUWcwX//EC7KZZELM10ghtWywr97YLJ4j47y/JnH855EV6u
         JBomQzI0+qbugCP6IZY9sInLVtIeABgZckFjEO1pUH4sFYaZ9cB7FP/xfzG+NTWYitFT
         DWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603733; x=1762208533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPQWg8YodwV0TasyiuBuXsJUnrrwoBhVKhLf4m0cFkM=;
        b=Yhjjk9xTvlKZuzxYEa2pgPbhFCCw6BP6ODcWsPNdkuLQQZsztHTCj89UgIjIMxJMz0
         JjbGF65D9nYMqqiLzaq9BjeeRV9kg8UnBAuTWu6hGqu9ElQMgByclNu7KZ1gTLuFB9bK
         zaFFrq4247C1KU0xN4ilAbGtDH2eJdGutIGqx8nKHZy9PD053wIcLU1/p7Lj0b6IRvqi
         TkTC6gAL4yNYsbZGNEm5wbcpKM6bXLse1C+WhyU3J8EbVvXYH1LQmcaNVYdy84FyzYPA
         KpuWjTRliQGYJDwVRdkL8W4vr0xaWNDojyoEdwIriY3NCHLshUFWBJrHaILilcCmgWyZ
         wmVg==
X-Forwarded-Encrypted: i=1; AJvYcCWn5L65vfrcbfWNTGx+PO8hgESvTKKwhEoEdgiQrDwmFca2kFUiA1Q2bZlr+2l/ZQgzh1fRd0LClh7Awn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrwQdafmsqn8xQID70VNaMB8SS/Gwj/7Jjlf3mznYCJKZBwfZ
	XosOEx25YpsFz1+mRg1cenHIQ9hneKWSjTDSZshYcKf8mkVofDbdmOao
X-Gm-Gg: ASbGncsoDg4earMeAMZsplAAEXHqaqdhutOvNaIhNBgGm/krsVYH2aRToV44rv1NOYF
	028qe/nh3N1Txcg2O6R0cdtmxuEeWmYW0yKeq6i3ECO6QBQDaqYOu8BXLMxkBEG48bz12z2i5Yj
	oEqUeVrl9ngrHs9mvCwqOeedbQhjPvp4J0a7s7BFiFQTcLVlZSFNuDqFXr8upKTuZ4mXL7lOLb8
	PBg7hurk6LbJ0D+9FXwt3Y03TOf2N8ngxakBV9yohX4VtpNDYWYNU2rZnnbsoBdhzDybjwjqVLi
	812bcACwoBSh3kNc45beuDw0tkINXeZGkIRjNydC+g5c+/VHZPteNvCn11tOy2CHp38nR+sP9K0
	fHYZf28OwzoEbn5Yj8OVAmZBBHzW9EEUhDlhliPKBxoJlyPy8mg4Grt2dQM21/Vr8Ql8iHeNq+P
	XSY0U=
X-Google-Smtp-Source: AGHT+IFKML31j6wnI6vGTYle4J1PHdCjOW/A3I5JFdqfSeewCWVjPwljp6TGGzZv8i+BCRDqH3AhJQ==
X-Received: by 2002:a05:600c:1987:b0:471:703:c206 with SMTP id 5b1f17b1804b1-47717e6c391mr5547955e9.5.1761603732680;
        Mon, 27 Oct 2025 15:22:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4924e2sm159570265e9.8.2025.10.27.15.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:22:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:22:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 01/12] net: dsa: lantiq_gswip: split into
 common and MMIO parts
Message-ID: <20251027222208.yrbqt5n3mseslu5d@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>
 <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>
 <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:43:54PM +0000, Daniel Golle wrote:
> Move all parts specific for the MMIO/SoC driver into a module of its own
> to prepare for supporting MDIO-connected switch ICs.
> Modify gswip_probe() functions by splitting it into a common function
> gswip_probe_common() which covers allocating, initializing and registering
> the DSA switch, while keeping transport-specific regmap initialization as
> well as PHY firmware loading in the new MMIO/SoC-specific gswip_probe()
> function.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

