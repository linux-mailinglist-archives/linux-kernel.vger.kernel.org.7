Return-Path: <linux-kernel+bounces-779177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF67AB2F01B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6328D723DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285228312B;
	Thu, 21 Aug 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIdEUQve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941F21FF28;
	Thu, 21 Aug 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762594; cv=none; b=RELwmJ7zpMyAFGPY0nE5Bf76lXxWDGPtFe0j974pG1lMcAjlCdwYZJ4ktBAm9gUJ3Pr6jpD7VTCYReAWudTEAZ8JlHnE5mJXCFEtIQ3/t8J4SGjmf3z38xXJaWwZa8XRnP3lxlo63Q7bK33k88sVd3GQR+g1tcaTWPFzp034Er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762594; c=relaxed/simple;
	bh=EPyqC0s/26OqizoQpmqez7kVfjFPxg0Nl0MiV1qYmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj8tdbTURk2bGr65FVupZYaX0frxto3YWPcaR13rt60OEPUbxZ1OWVtZBPOhEJJAjoOUrP+JIoK+Fs6kHPFlzBAze/wJQvXKnnDMo5Wwul0Zc2TlekkPCgdAvNiXmFMx1+O7ORaPhfw6w+EXr9EAvayKRnWA5JvS8wvoW45rF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIdEUQve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0563CC113CF;
	Thu, 21 Aug 2025 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762594;
	bh=EPyqC0s/26OqizoQpmqez7kVfjFPxg0Nl0MiV1qYmzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIdEUQveHZfVUU4/VbsaDLBD9MRJt6XUjS1tFUhNaWF2e/4M4tiGHh27YbnLbrPp8
	 3nCdYVltt5HZbngTjXajE2ZdWMLpav3aLThIDzBVtgpjo6wHfETnM7sHyR2lhaum6b
	 i8n0iOu8417qT/Z1vSYEwQCu8Jj9RBfty8i8M20wXjpTXnLi2uD1fFUbduOk6qUqKo
	 Ixz9xiPat8aK7kuuxCrOGc+ykOV13JXFgTsXLq2AXa79bsui80vl/F9ztoozh2Xfml
	 /7DS7Es3mgDmFosvX48cosd/405VhAJK1hy3J/1TZ8ep/Ayt7l1WTNyl2awe++CCxv
	 HqQl9Xa4tBbRQ==
Date: Thu, 21 Aug 2025 09:49:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Scope the reset controller to
 VO for TH1520
Message-ID: <20250821-delightful-gleaming-myna-f63fa1@kuoka>
References: <20250820074245.16613-1-ziyao@disroot.org>
 <20250820074245.16613-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820074245.16613-4-ziyao@disroot.org>

On Wed, Aug 20, 2025 at 07:42:45AM +0000, Yao Zi wrote:
> @@ -502,8 +502,8 @@ clk: clock-controller@ffef010000 {
>  			#clock-cells = <1>;
>  		};
>  
> -		rst: reset-controller@ffef528000 {
> -			compatible = "thead,th1520-reset";
> +		rst_vo: reset-controller@ffef528000 {
> +			compatible = "thead,th1520-reset-vo";

This breaks all the users. I already commented on NOT DOING this.

Best regards,
Krzysztof


