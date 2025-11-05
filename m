Return-Path: <linux-kernel+bounces-886453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AFC35A82
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7143A879E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79870313E0E;
	Wed,  5 Nov 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO/3M89k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF321146C;
	Wed,  5 Nov 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345843; cv=none; b=HRpXhJ/48veJucddFuSZLTcppaiSBCHMR8YRnABwRpa6KSGY4sqjnhgL5GiBgXfCmIXp1V5HGwnjYdUvtU4Ged2oXJ/k4gardnuCX9iD4XQxqX0J2NmAbM0apgMxYzZcsGITOBxbPuUUn52qzofoCUo30hcZ8nJHR6Qna0bsnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345843; c=relaxed/simple;
	bh=sOca8qlDfIBDsxvVAIy7C2EdJfQ9Z0/Cd6qn0qL0vGA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=l+T5uJYZh1K1sort/oBSAXReLj4TlUlo22HwP1Nx2kcYR02dSk2usBExQOsommzmO2a6v7Fu5sBSIniLRcSfPHRJcrKXCag+x4Plr9049lfynZthMnHEKxdoHDvJMSIhIGwxVox62DRoJ4C1MYBtwGNQRnOR1A5JxbL9BEkkg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO/3M89k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4F9C4CEFB;
	Wed,  5 Nov 2025 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762345843;
	bh=sOca8qlDfIBDsxvVAIy7C2EdJfQ9Z0/Cd6qn0qL0vGA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aO/3M89k+D6Jfli9zFpP/uHdguxuGFk9TJ4fhmXgVR6oXi1V7UqFQ0N8eeZsXACWi
	 ACGLD5bTZ2vlUaztBCPptZFADukmoXcsaFTcBbZiiV57G/KUvIH29XWZPIfNK1/prG
	 agPGjb8hiZf0Kfz99IIKsgKOGYDIJAzhzEfI3yhU+3O8BdsuomK3CSTRl7t5TtF6t5
	 4J+6EFwuTAWZlJtdiZSPQyTWOTEvWtaAqoIsWHocA0UGZRkAh57lFfD9Wrz7f/jJ1O
	 L2DWX9zWYCF83Lqih5a08c8BUoopZfutNpsOKslICZ6TWsGobmem9nvrWQdmjkLF3S
	 4iA354oZx9ZnA==
Date: Wed, 05 Nov 2025 06:30:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 conor+dt@kernel.org, cy.huang@realtek.com, afaerber@suse.de, 
 linux-arm-kernel@lists.infradead.org, james.tai@realtek.com, 
 linux-realtek-soc@lists.infradead.org, stanley_chang@realtek.com, 
 krzk+dt@kernel.org, lee@kernel.org
To: Yu-Chun Lin <eleanor.lin@realtek.com>
In-Reply-To: <20251105104452.6336-3-eleanor.lin@realtek.com>
References: <20251105104452.6336-1-eleanor.lin@realtek.com>
 <20251105104452.6336-3-eleanor.lin@realtek.com>
Message-Id: <176234584170.562648.2189277623860888038.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system
 controller


On Wed, 05 Nov 2025 18:44:51 +0800, Yu-Chun Lin wrote:
> Add DT binding schema for Realtek system controller.
> 
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
>  .../bindings/mfd/realtek,iso-system.yaml      | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/realtek.yaml:76:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251105104452.6336-3-eleanor.lin@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


