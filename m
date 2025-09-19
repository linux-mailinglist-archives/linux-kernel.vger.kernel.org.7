Return-Path: <linux-kernel+bounces-824323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC9B88A98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9917AA8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21E265CCB;
	Fri, 19 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZL6MBxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A1814286;
	Fri, 19 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275637; cv=none; b=GvvKCPpgRgDYn4vfzJl2I6RrsnqYRDSOqWiZSPdamQCNfk9q/j6W350amejYxfiGdTDXofB5NldypiH8y00q2IjKjU0G6JLPXlsZz+g3hPepkZv5iHHSoVSnFSem5xN/gbX/oHUYbhV9SDVjQUmmry3xz5hCUdVbD8fID182PwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275637; c=relaxed/simple;
	bh=gwNl5TBzUrRDZwuOF5en27MA27YGZJyIBvwZwwBBrmo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=b+3WXCnUr3teaO+xUKJYYx55lDKCDwvpvDODBvzCgoamNBbDlQCyT+BbmjiUwDztHciWy1juV7MyhCcnOM1pRevu5f+BxWe3Tu1/lHjCfzov1u8VMr6bTQqmp+rAhzp+C00pVlj7V2SFFZpWF+By/hO10FEyUPC56dzkaA0P0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZL6MBxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0685FC4CEF0;
	Fri, 19 Sep 2025 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275637;
	bh=gwNl5TBzUrRDZwuOF5en27MA27YGZJyIBvwZwwBBrmo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MZL6MBxvZ81F8+KqKZ/eY5zpmVo0FpSXO6y/WPaMAg3VgvYacpJJPPzKr7VTeiHmh
	 nQTrtWuCR1Gfj35fYncPVS/gBBQl3uJmWJoPVqVptWXN6TzZJ9XKDvnZWdeJ7LSW/Z
	 A8MWNV0K9uImUWtLKEQO6tbFgfMjTLefWAkQHEdUVTx6pvBlO8vB/CRmlD9bOgDbD0
	 8kOoL5vSTBGXSD+pg6yKjSlB5MBxv3BlpNZMdv57mqucjRRAmBNrGjb/KIA1CZD8FO
	 VPrPgkl3FXIN/4l7Sh/M94X06dtzaNY0HM0tKL/fcNxE4yg9L7gLpc0yb3LW4T3/g5
	 A0TXjL3BhgtfA==
Date: Fri, 19 Sep 2025 04:53:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 lars.povlsen@microchip.com, daniel.machon@microchip.com, 
 benjamin.ryzman@canonical.com, linux-kernel@vger.kernel.org, 
 steen.hegelund@microchip.com, p.zabel@pengutronix.de, 
 luka.perkov@sartura.hr
To: Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20250919082919.19864-1-robert.marko@sartura.hr>
References: <20250919082919.19864-1-robert.marko@sartura.hr>
Message-Id: <175827563611.434564.16492543952928423652.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: microchip: Add LAN969x
 support


On Fri, 19 Sep 2025 10:28:38 +0200, Robert Marko wrote:
> LAN969x also uses the Microchip reset driver, it reuses the LAN966x
> support so use a fallback compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Use a fallback compatible
> 
>  .../devicetree/bindings/reset/microchip,rst.yaml      | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/reset/microchip,rst.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/reset/microchip,rst.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/reset/microchip,rst.yaml:29:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250919082919.19864-1-robert.marko@sartura.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


