Return-Path: <linux-kernel+bounces-782444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE9B3207C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C242A681831
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6BE22F772;
	Fri, 22 Aug 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npZlEv4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9D111A8;
	Fri, 22 Aug 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879702; cv=none; b=XQkd/NdqkYZBmCQjvYmaGqJtvpS8H3r7m64BrvhoPsXx3o2JX4BzCHlbU0YDDZSSONk6gn8jIFwvqi5CpOZONOW0UwlZk19eQnS+Nrb/U9OakKWnfpZX/nW1cKlMCGgedXbGi8ogw58p6yxlQwGxzcSg+LTxaa4Df8kNQoiQ2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879702; c=relaxed/simple;
	bh=EhUz0WgYcQYVPW2xddPUf5WXnJ6f1YdV83X8PzDG3sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obn556SaddN+0jwEVULtQhqgmgTAqd1crirzsjnUiNOtbeArN+ljM81/nipT5TmNGlEQKZgSOMOb+1BkT1kqNQoJ0mzVm9gouKZP9NzYhCj1em3sE1TAZwqseunedTj5PSty+6W+nNzcDUErAUIJkjJ2HIwdkAbcMA1gP4klMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npZlEv4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C41C4CEED;
	Fri, 22 Aug 2025 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879702;
	bh=EhUz0WgYcQYVPW2xddPUf5WXnJ6f1YdV83X8PzDG3sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npZlEv4o4is9Imqayi3d9m2AHZ5qEsT/swD8pKbbf1PNx0/acROFdl62vZyv/R4mh
	 ii1anT2GW2O0CNhSrGd2CVWfT18Bjxp7pWKbRKB+b/H/cDhoLx0A1285909SSMOvXA
	 ZcqNHb7ms9KV2qyABRHSrZATJrsM6DwnaWDuk59WS1yYWB65wW/iNObiGxSAXGYe6i
	 KpyJH+RiRUSnxoJSWRYYO/jtciaeYOlXvjbYwvUkOJTecBX3XOapXmwpzSx3489fBI
	 sbR7GEevUGBs0qYlPNEQgvWEog7QjcN7G0E2cJq2bFTueRYw85N7oXoBV+v4skKiiv
	 rfTgNBVoBG8QA==
Date: Fri, 22 Aug 2025 11:21:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: eisantosh95@gmail.com
Cc: linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: devicetree: fix typo in writing-schema.rst
Message-ID: <175587970043.3941544.11685597833817175902.robh@kernel.org>
References: <20250820181013.17817-1-eisantosh95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820181013.17817-1-eisantosh95@gmail.com>


On Wed, 20 Aug 2025 23:40:13 +0530, eisantosh95@gmail.com wrote:
> From: Santosh Mahto <eisantosh95@gmail.com>
> 
> Fixes a spelling mistake in writing-schema.rst:
> "interpretted" → "interpreted"
> 
> Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


