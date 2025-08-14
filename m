Return-Path: <linux-kernel+bounces-769444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D7B26EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8CA1894A46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58464221FB2;
	Thu, 14 Aug 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j67vY8Z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E431984D;
	Thu, 14 Aug 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195820; cv=none; b=soYFj6GMrCZG72SyGGE/V9WHswqg0PPfMoi4X+e6stZUXy5fp2+I1P6TD7v3W+r0vtKUBIihUYUNQ3ti3s6PpailEZBG/lmC9uXwXFza2jTZKfKhpZFXEB9NEk49JP1pTUc/9/c4x5mZPqW2D3WpU+Hvzy7d3Cs2qHlNkceTntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195820; c=relaxed/simple;
	bh=WO4+UD/lbU8EzyXmKM1V6oqWuamoY7Dk2hHoT3ZfT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdAsn2UMNIx3jb9Ln603QpjP+Aa93dzLEqfbr9LPBsUTrOC9Zq+ApQxEG9LBBap9fWEHjlNniCCKho319N2+/1bjOELJD9n1ZbT/pSdqp3xPcUX724s1ukQrNVnLnQjo0GXTTAGu8PbtsPTDY0919wToujf3Tq2FK4IYwG59jYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j67vY8Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08155C4CEED;
	Thu, 14 Aug 2025 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195820;
	bh=WO4+UD/lbU8EzyXmKM1V6oqWuamoY7Dk2hHoT3ZfT6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j67vY8Z0Oe1oEnGlkP97UkIIIvULbVGYHkeoXpdvuAGQ7S5DU+W9qdnfV4WSCjTjO
	 XvJUG9g4OaslM1VRo6GZNYjSGjv0V0Pl2VQA+3R8ghERBqnmEaJS+9X4LjT1VV1mpv
	 RdoTEhAey1+fXhCzJb5bJpqkuNQ0hXYuyz9D+vedn8ZE43x6OleUzteTuu6wFi3Ak+
	 Z0Q6LZyEJT3Lj/Nm3Ngx9CPI6ns8nZooDPrMJsRd+mpUBiZvxkBr0BLNEdpXf7iifW
	 4/YXkFo1PuCFaIk3ImnUoYQv6tjNzVt/gxDoUVrJBHgTKAtDBWbKvsIhrgFcb7/x0e
	 71jUNMHncXX1Q==
Date: Thu, 14 Aug 2025 13:23:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm/cpus: Add missing Applied Micro CPU
 compatibles
Message-ID: <175519581793.3481113.16686734138122924360.robh@kernel.org>
References: <20250812181428.69490-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812181428.69490-1-robh@kernel.org>


On Tue, 12 Aug 2025 13:14:27 -0500, Rob Herring (Arm) wrote:
> "apm,potenza" and "apm,strega" CPU compatibles have been in use for some
> time.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


