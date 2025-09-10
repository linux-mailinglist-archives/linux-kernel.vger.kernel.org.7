Return-Path: <linux-kernel+bounces-811026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09AB52323
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A9A3A480B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB642F83D9;
	Wed, 10 Sep 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze8vB2Gr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48741F03C9;
	Wed, 10 Sep 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537699; cv=none; b=XU9whxYM0dRc/8hpekhE91LzDWNJMdYg3oh25fEbr7NhVRgVe8MSYgtVHIEW9Pj1XhAibwz9pplvUMSI0tShydrPtmjT5dcXLTqI7omfoYjG7NZF2QVdUX022uIYtJ3WKXmzOTEdbwsm3mZ/9j1CCWjCJSaZM3jDyPh0jVBCoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537699; c=relaxed/simple;
	bh=Qt4PUFPPCFSZ3ZqUW7GmrUb9XiUfrOy8Dqd9Igot5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JopcE2/B5hhCHGaEN+yLnSVipq5AvhU6m8DJYfbbmIB9XHXcgRGaDptkmqyOqbeCF5ODssuSx5MWtmAsKnUOWkCUqHPVqo2bePnAQ+S1VbOU7EQun1pjnuGdY6xCgLY3bw8zV3Ja6F4CL/pmXgFqra/oOAEZ8jYIW1BH5qzooNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze8vB2Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177DCC4CEEB;
	Wed, 10 Sep 2025 20:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757537699;
	bh=Qt4PUFPPCFSZ3ZqUW7GmrUb9XiUfrOy8Dqd9Igot5XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ze8vB2GrHYd3P0VbAM4Iwcxw7X1Qci9aYtDWoc7BtyMTVGTXs1ifku7cr9vCN1q/V
	 fMah2SMryKMzso8jQyaSIMu/Fgae6bEd0XF9Dp5Ba5sfh82CkT/bwCzx/2Y7xyUw16
	 prHhJrNdv3qxnifunhYrPgFA+l0ENLxCRvH1MwgQvQPEyzVEhAdBAsi5G2E2I6zqXI
	 36bXTikeCl47xEp8rbru5e6bRE3bYltk3OPweQ4yd5Z5F+u4MHJOuuBKWbo+GVvgNc
	 n2ZFsGrx/qkGQeLV8NvwCb+XvJiiMIU//BKdMJSmWfiR2SvzeV05N9JikiBvv13tXJ
	 U5IttfR9x3Gkw==
Date: Wed, 10 Sep 2025 15:54:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mailbox: Convert brcm,iproc-pdc-mbox to DT
 schema
Message-ID: <175753769640.397014.8461957797361840700.robh@kernel.org>
References: <20250812181406.65390-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812181406.65390-1-robh@kernel.org>


On Tue, 12 Aug 2025 13:14:04 -0500, Rob Herring (Arm) wrote:
> Convert the Broadcom iProc PDC mailbox binding to DT schema format. It's
> a straightforward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/mailbox/brcm,iproc-pdc-mbox.txt  | 25 -------
>  .../bindings/mailbox/brcm,iproc-pdc-mbox.yaml | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml
> 

Applied, thanks!


