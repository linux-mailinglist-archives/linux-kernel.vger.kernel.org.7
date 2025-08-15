Return-Path: <linux-kernel+bounces-771492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797AB287DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD5E5C159D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A20304BCA;
	Fri, 15 Aug 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc1bv74x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D426CE12;
	Fri, 15 Aug 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293948; cv=none; b=hkBOY+GkX2J6m8BufYm+sAsxF1+oTK4oVVinFbMRrDlmgUWfMJS9TufH7c5RDC0wBwTL8+g4ibLuTn+qb595qLUJ8PEMtttQSEL55OBh6DfA+0c93cP7sTCP7h6OPO7r2Vherpvi8dsnUyD7WljYfbyOO/tp1+SKC9Ff2MZJ3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293948; c=relaxed/simple;
	bh=QvlQ0dKddO38NvLD7sJxqDPgQMRtIecb7wvQO5j7XWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAM1vVFPRr2D5kD/4awBXGR1ivTDNwzg+SInIvUCC9UJmMUzgJlWVQ0EVpAMGJ9MAY6m5c4A/5dmKVpCFAaG8AzJJMoBcYw4N4se8ptgfdo7eudPEQbCESknPHjY85t/cMD5L0/1K23hc+6hcqV6r29LBgde1xAUPOXcvH9KC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc1bv74x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A39C4CEEB;
	Fri, 15 Aug 2025 21:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755293947;
	bh=QvlQ0dKddO38NvLD7sJxqDPgQMRtIecb7wvQO5j7XWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc1bv74xUx+2M9Ilm2maSB3Zva+6LCSgcjL6g//Rtyu4Sc35jzSR8tytzirJqNYJM
	 TfPwlebV5RaTF5EVO1yZCpEG5fhmzj7s1dP9Iha43EQpe2Lm9m/FNFrIOXbAIOqJA3
	 OS2bQglc5naRhK1J9kD6Mm9lAWXWUJRAp5gZUNZhSa54k9AMi5xxq9fLI5Dwk0a4In
	 tQIZMe7UYbTB65h2KFveb52Offoiq1f7DhZfQOKFQtvfKUNt/DohrhypUuic+llE3i
	 c7lSxqF9oQTMKpGamIkxvYROl0ug6W48aN612e+h/iQLi/Fa3RSTLRwAaoo2vtxp+r
	 ShS2d6ImT91bA==
Date: Fri, 15 Aug 2025 16:39:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: Convert marvell,berlin to DT schema
Message-ID: <175529394103.3239481.5622777933842112929.robh@kernel.org>
References: <20250806212733.1633662-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806212733.1633662-1-robh@kernel.org>


On Wed, 06 Aug 2025 16:27:32 -0500, Rob Herring (Arm) wrote:
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/arm/marvell,berlin.yaml          | 45 ++++++++++
>  .../devicetree/bindings/arm/syna.txt          | 89 -------------------
>  2 files changed, 45 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/syna.txt
> 

Applied, thanks!


