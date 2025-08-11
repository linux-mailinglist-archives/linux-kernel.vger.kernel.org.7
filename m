Return-Path: <linux-kernel+bounces-762601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E6B208D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7AB3B8E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84A2D3A96;
	Mon, 11 Aug 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrKiPp4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBF2D323D;
	Mon, 11 Aug 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915719; cv=none; b=awhLFfwG3sIqAzOB/rlfrHgARDXNLAuAvpAwI9VLmIndqYFlshxUBHkt5YNNUNEKZxaVWk10Cxia9soIvTErNPaeQduWK52EJ0ym+qPkpwTdkI6tGO+QArKD2fHva6I0JTK7kolGaafxRMF8+zBWz1BRacfWvB4A+lQgNDc9j4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915719; c=relaxed/simple;
	bh=xPf4hCC+HgEef5Swn5jiIwNVTgFJh8/Tr7iUx6FhQlg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Y6pbpYvPSel2Dv09ph8GJA4qDlp+lM7jQGwe46KQxrwmfjP7vMJZ+KAdlZy28d9FZeXGq5u/M05WKcfMe3c6mi8DlqRibUzf7zcw5STdg+6YK+F//SgDuIgF85opnUZZooRb/CQpqFRdBxVUrfLGLI965qyVxjC4DzEoaigYnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrKiPp4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEA4C4CEED;
	Mon, 11 Aug 2025 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754915718;
	bh=xPf4hCC+HgEef5Swn5jiIwNVTgFJh8/Tr7iUx6FhQlg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RrKiPp4YR+5UeVQhTjhRrBfrjt3LLrtXkBjI/ArUI8iUHWWLWydGFkIJ0/Ok4C+Hh
	 diETbZpRXWj7m59Or5GQB5aZeUM2gjRskoVrzX9FGYb4sen0D0AqLBwWxjVwoiEnR5
	 fSJtbe7ca9YDDUYe0DqXHEUaPq3kIuqUntxTpKAywwqiH0N0TTNkSU916d5t344/6E
	 I71IpiMPERo83GlO6T5KsAFtykIjAMki2bKfjzu/MWg4yaiklQa6DSS5aZDPOarxnz
	 xWt7ftlMe9SNZjflZNea7+wi/+G9x5StNenrX1yjGZtSmYRDVauwby5kVJGJYyUhNo
	 MbTQntPCDE2DA==
Date: Mon, 11 Aug 2025 07:35:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, alexandre.belloni@bootlin.com, 
 devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@nxp.com, 
 priyanka.jain@nxp.com, vikash.bansal@nxp.com, linux-kernel@vger.kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, broonie@kernel.org, 
 shashank.rebbapragada@nxp.com
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
In-Reply-To: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
References: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
Message-Id: <175491571725.2516426.3535387819811029037.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub
 support


On Fri, 08 Aug 2025 16:20:32 +0300, Aman Kumar Pandey wrote:
> Add bindings for the NXP P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841)
> multiport I3C hub family. These devices connect to a host via
> I3C/I2C/SMBus and allow communication with multiple downstream
> peripherals.
> 
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
> 
> ---
> V1 -> V2: Cleaned up coding style and addressed review comments
> V2 -> V3: Added mfd device support for i3c hub and regulator.
> ---
>  .../bindings/mfd/nxp,p3h2840-i3c-hub.yaml     | 320 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 328 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml:32:4: [warning] wrong indentation: expected 4 but found 3 (indentation)
./Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml:166:111: [warning] line too long (118 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/mfd/i3c.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/i3c.yaml
	/usr/local/lib/python3.11/dist-packages/dtschema/schemas/mfd/i3c.yaml

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
MAINTAINERS: Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250808132033.3996614-1-aman.kumarpandey@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


