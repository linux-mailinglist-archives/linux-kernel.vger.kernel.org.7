Return-Path: <linux-kernel+bounces-726530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C1B00E38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B01C85466
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADB290BA2;
	Thu, 10 Jul 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5wMUN3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAF28C2B1;
	Thu, 10 Jul 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184422; cv=none; b=ni5Z+OgqL3AD+rcQyv5DdcYfxkV2mOuuPr1fonLIk4KFnfqfYBDvZKIkJiFxuDWJC1R4N5Bf9d1XbsHdkT1SeWLCYIsTauelnNTFnJpqVNIORaFJB4NdnxbRoUA9P0YlGRVycvtPT6+5NNwB+pYhptYbnLF1RoGK2AczVHOU3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184422; c=relaxed/simple;
	bh=X6eeIInnUytvuLZAh3GPg03bpF29h9AY5yA3VAqyb5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuJ+IyT8zn/d0+ebjFc+CFU75nrQpNmS4cpa2Mg5wxQrPB0ZYsNn6LLf4eSnbDj72oPkMUVm1VLuBbWHMblO84fMghewnfBBHA12ndU8605UtZyhw+AoHZgkibAkOIRYG/Drcv8ONzcePPjxfNId65DQLibna5ah992WFcCA/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5wMUN3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4DAC4CEE3;
	Thu, 10 Jul 2025 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752184421;
	bh=X6eeIInnUytvuLZAh3GPg03bpF29h9AY5yA3VAqyb5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5wMUN3sk1+V57LjUVqggKZ+eKRkM8Yt5uvwg0ZPJDLMjwru1/2VYN8AEDasJCKss
	 LHC3zu8mKCbziLREXEHib9hEijJHnl5uazEOkZNFYym7oTlEwf7jEkooLuJkIqIts1
	 vaiZfERQ3T5LZmtkMa88h8c/wKHjQHcPa9cvDOOYorzjcx310kuP5xRcuQePB0eNxV
	 8Q8I2PpHOWxPhQ8LI2U8TsYkNOgAxTuln9FkT4ryh0aJflzkShAfY8GunzCqYPSccR
	 CefgU6q0Q5cfhGCFBjUKznJjhSUEQ7mcSixZ5GNcEcCEBo8/R7+dgw9ggIxFXAK9Kk
	 qSl3sWxi1fIqQ==
Date: Thu, 10 Jul 2025 16:53:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/6] dt-bindings: reset: add compatible for bcm63xx ephy
 control
Message-ID: <175218441985.4033541.5986955155296675746.robh@kernel.org>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
 <20250709024740.194520-3-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709024740.194520-3-kylehendrydev@gmail.com>


On Tue, 08 Jul 2025 19:47:26 -0700, Kyle Hendry wrote:
> Add compatible string for bcm63xx ephy control.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


