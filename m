Return-Path: <linux-kernel+bounces-877729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A74C1EDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D453B4E7306
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DB338599;
	Thu, 30 Oct 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LedfFNCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73964337B90;
	Thu, 30 Oct 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811106; cv=none; b=GLjLO29E6Dr7ZYEjy+SXGz11/xKd2z7Zj9rLhzSLWgGeHn3+PAT2mTtkOJYANAdzctsRyaM2gkjqgNWPe4i93RLnC2AgeadCrELlCeoHVUNxgqatLlJEOg4wTEDoES1lVdG8SJLAsqJ6yDP6Oh1SZlHGQl+7OzGmFD66+lARqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811106; c=relaxed/simple;
	bh=axaYMl2BZHi752hKBoCs6NPlcnIE4Vgc/bSsU1Rej+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJK4TtNgYkTTFsdEG6mnVtAnTOX56hxFgcKIdQJJFfEE4wZfYO6XG+GtrIXudPitE0VsUl0oPAFD73NWqAloTJcrriaPsv9gv+CotnpCEkCsUkTq9V09+qdhmg1fvVrq2W9HnEqBadIHEC/o3wh3DjWEox251AI1Sv+HTxMZmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LedfFNCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456CBC4CEF1;
	Thu, 30 Oct 2025 07:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761811105;
	bh=axaYMl2BZHi752hKBoCs6NPlcnIE4Vgc/bSsU1Rej+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LedfFNCeOuKbKm1BCU55N8502uKCSyEWh7SRScyZz8sc6+wguGZOHGu7+QJdlJY13
	 knzWNDbOHFeQANNsx4C0mbz58DiL5R2aOszlAkTyeRs4p4N1vNIXUZupZXgbpZbmB4
	 bddeOUIyKkFFI2keNRw/VkzZTCg4o89WVo32y7aFj4xK1+asiFLxz3GCGOVFRgKslD
	 w3L+Sfnr8apNz8ZW9lW7ARMNpSgbQL+w6dt+YiNbAQLN//qn+c0h5OsgZpoAlxmXh2
	 k8bRwq0tMhKCF8MNFhWnmBz8Da6k+5T9PxmoIoyIppG/rls2Vpm+lrud1yd9VO5qLL
	 Ff9+Uu/g4fTrA==
Date: Thu, 30 Oct 2025 08:58:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Message-ID: <20251030-wakeful-hospitable-eagle-9dfca1@kuoka>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>

On Thu, Oct 30, 2025 at 11:30:09AM +0800, Khairul Anuar Romli wrote:
> Add the compatible property value so we can reuse Intel Stratix10
> Service Layer driver on Intel Agilex5 SoC platform.
> 
> This addition is an initial Agilex5 service layer driver enablement that
> will involve adding IOMMU changes in the future.

Heh, your bindings said now there is no iommu. Can you please read
writing bindings before you post next version?

Best regards,
Krzysztof


