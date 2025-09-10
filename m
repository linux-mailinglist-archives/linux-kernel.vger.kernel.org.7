Return-Path: <linux-kernel+bounces-811027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DEB52313
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F3169C08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D222FB96C;
	Wed, 10 Sep 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwGSBCjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC82D3EC1;
	Wed, 10 Sep 2025 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537708; cv=none; b=AsanvAAh/0RkhSZo4fexsMZkIFG7LfwWHkmFEHRhrJnEAN4XKM5VeQfC7g4J87ivQpEoPLZs5A8z+07lVE40y1FRzKKcMsegiXMxaHveyeNug0XUZSS6xvLCxmtJrXtbfBSiHJUhoIoVGvE79B0En1GvSWrGMsoMVFXSqis4Uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537708; c=relaxed/simple;
	bh=f6q6x2tp7XQqttUmi2HUrOte+WCgdNBRYOWvEA+0dXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTQBDhH1of0hrALgj3oWloDcZcHd/OJEAd88ZjsOzapcXBoLgs8VogfREkVRtD1SysZyjw6ezoWTCvPv63OTxFjRV2/nVy0v+NAnsVW+R6CtOCOMd7L6j6hUZSk+hZ/aGuI+o6s7N2SZGIe7GyWLoGIZtHLBFoJU+QqG/FwrujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwGSBCjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B4DC4CEEB;
	Wed, 10 Sep 2025 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757537708;
	bh=f6q6x2tp7XQqttUmi2HUrOte+WCgdNBRYOWvEA+0dXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwGSBCjNw8EvxRE/u13lIZTcQ9hKCEMMzvlbBvpSH8oeDo/rK4gPzb6F5CHixVYvg
	 hS01zeh2hR2cgLcWa5DwDfcuZNYT2z+/HFMNSt8VmCn1GiyPCqMa+ACiETYbHCm/vM
	 84fNFVLItZPtWGuytLeZAeqMWMa2LMMB6gRenMd6oj7mPwFEZ0QseCbHj8MVg/8Tc4
	 YhhWApsLG+CEZnT6Ie2Y4xrKuM99E5K5+0kTpjqY/m6i7+EbmIe2U0QMwhLfNK0Y6f
	 bW8o7Kc+NsEBo8skviTIM+xh7Bs3HPWaYWj/x90AWis9PZf35fnnF6U2rVerFZFKIx
	 dpYobsUR6lUSA==
Date: Wed, 10 Sep 2025 15:55:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Scott Branden <sbranden@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mailbox: Convert brcm,iproc-flexrm-mbox to
 DT schema
Message-ID: <175753770657.398619.12206824436834292198.robh@kernel.org>
References: <20250812181415.66923-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812181415.66923-1-robh@kernel.org>


On Tue, 12 Aug 2025 13:14:13 -0500, Rob Herring (Arm) wrote:
> Convert the Broadcom FlexRM Ring Manager binding to DT schema format.
> It's a straightforward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../mailbox/brcm,iproc-flexrm-mbox.txt        | 59 -----------------
>  .../mailbox/brcm,iproc-flexrm-mbox.yaml       | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml
> 

Applied, thanks!


