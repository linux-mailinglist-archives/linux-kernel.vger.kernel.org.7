Return-Path: <linux-kernel+bounces-843653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FFDBBFED1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217D24EFE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96D1F584C;
	Tue,  7 Oct 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs1zL5OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CF1EBFFF;
	Tue,  7 Oct 2025 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799881; cv=none; b=kN6Tn2io6ZV6N8wKDwN6BFP0mqDWpa3ELoMQ20VH9BOw93WS674MLDz82YTTjNeKcVWoTytKNdJGOAga/07t9wxbB5+5kt9s9UmHVADmWz0BYaesAetXgKBkj1gfabqYBnVeW6bbfRElJZ7ZK1Ymfmkz677u7ymZuaIt6HqIMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799881; c=relaxed/simple;
	bh=MbHVwyyU9s+TXbP3LS37mdRoQgCtoUHTvmBIaJc/+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U25NU9bcyag13G4PYpEcTS4PWSJI5lGjI4HGJxbOsWRNggwKNWnMrocIF6GczVqnYaG0Bv0HHjzXpMy2oi4ZntoovLEoMsWrRWgPCkVHBkpQyK5uIoiC9jOpoqTfKjpjVPf4K6jy2qB1xtlnUwfaX6/3jkooBRcX4SW3w2OAIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs1zL5OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD4C4CEF5;
	Tue,  7 Oct 2025 01:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759799881;
	bh=MbHVwyyU9s+TXbP3LS37mdRoQgCtoUHTvmBIaJc/+hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rs1zL5OUSJWIb8gm+jMzQNtPgkDd01zP6ngsoppsvIMfpRiyK4/TN6CyDCjEwbu+O
	 59Oy6WRScR5IgTZXB3VqraoXX1pAxBaIVKvqdd8/eRjlAdjw1gtQhkf1VKaJbza17F
	 0Ifzlxs2BROxHeMWW20nsf1lpiUF3ixfO+yt5nlCeKRLT0PD6l6NfTuQfkrDWRemeg
	 dgQyq08LY1tsXUgY4wMO3WyX5Qz2jMPduWwjP/1JwVqGWFrWIgbzZGTU/bKlj+ys2V
	 oL+WAWnmpmVg7GByjEkp2HZz63WH/nsOUcmyxhjGa8l5n5M83JUNtqZ2AMh1ePSVWi
	 P3Fqe3gPJK1dw==
Date: Mon, 6 Oct 2025 20:18:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: zhengyu@eswincomputing.com, huangyifeng@eswincomputing.com,
	ningyu@eswincomputing.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, dlemoal@kernel.org,
	fenglin@eswincomputing.com, cassel@kernel.org,
	linux-ide@vger.kernel.org, vkoul@kernel.org, krzk+dt@kernel.org,
	linmin@eswincomputing.com, kishon@kernel.org,
	lianghujun@eswincomputing.com, linux-phy@lists.infradead.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC
 ahci
Message-ID: <175979987938.723277.13154386173712928991.robh@kernel.org>
References: <20250930083754.15-1-luyulin@eswincomputing.com>
 <20250930084348.100-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930084348.100-1-luyulin@eswincomputing.com>


On Tue, 30 Sep 2025 16:43:48 +0800, Yulin Lu wrote:
> Document the SATA AHCI controller on the EIC7700 SoC platform,
> including descriptions of its hardware configurations.
> 
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
> ---
>  .../bindings/ata/eswin,eic7700-ahci.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


