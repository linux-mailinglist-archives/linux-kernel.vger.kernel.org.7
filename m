Return-Path: <linux-kernel+bounces-848195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165CBCCDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062104E2921
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411042EDD53;
	Fri, 10 Oct 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeRIWE7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE22989BA;
	Fri, 10 Oct 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098989; cv=none; b=lNaxIgmy6aKRmi7Pr5PjB/10yZ5Dqn4Wgt39JXPrs5qLTqU6L6lKebTagB29Ly6jKgunTgzsEkHu6PRp/lihxWa7eBeEo0bNKpglu5zFQtVPXKQBw2yy6HsoSOame+DkOBZb0W7KqaoOf6vXmYNg/sTLBtkBYvuYN1tOe3lUEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098989; c=relaxed/simple;
	bh=Ntjn9fyuKnQVUZGVjj8nFGhDuIRoBdlR6hdaZ6+9248=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=O9cN7HHeAQRR3xBUgqLHBCkdgZStKpR88BhJDAXt2cLGJ7G5CWFudlnl3WK150eEVeXE18ucZ3LNhqq6ECIQJlGV2IOObCMajDajq9h2OtueLR7hkk4seSlBhtIfF6cN3bIoWhNKtVASa28J3qYI89grz4+V1hLUE8j8ASSESME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeRIWE7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA1C4CEF8;
	Fri, 10 Oct 2025 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760098989;
	bh=Ntjn9fyuKnQVUZGVjj8nFGhDuIRoBdlR6hdaZ6+9248=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aeRIWE7Nho+YE8ZLRMc6f0tSRqNjyMPiPRmTtbgSzSvoP/GTGAUVqCoyOEiSxwBxn
	 hommapvhNPLPNYQXCQJUI6K//7DBg3KAh3MchfLMURL3H1JJNczCKHViGILZSd3l99
	 nmncKadPtwmja/jWelb8G5M3gsL4G8PbUxj7Zi6qgotCqmfIGXb4tZAl7VnJ7lA8JK
	 8rM1uOm4M7iy38J5GEvmea4HqBEfswmikh896tdKYo/h6dttDwd1kD8WI/uFHycu3j
	 RAOEjhuwMQOV73qaIxPCRwd9oAptkjVpRZf7AdgNylGzDPNotx9plvBhV35neRWMiK
	 B306Xkw9iogrg==
Date: Fri, 10 Oct 2025 07:23:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mripard@kernel.org, devicetree@vger.kernel.org, 
 jessica.zhang@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, airlied@gmail.com, 
 neil.armstrong@linaro.org, tzimmermann@suse.de, dianders@chromium.org, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, conor+dt@kernel.org, 
 krzk+dt@kernel.org
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20251010093751.2793492-2-yelangyan@huaqin.corp-partner.google.com>
References: <20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com>
 <20251010093751.2793492-2-yelangyan@huaqin.corp-partner.google.com>
Message-Id: <176009896093.7733.11526501318381620350.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Tianma
 TL121BVMS07-00 panel


On Fri, 10 Oct 2025 17:37:50 +0800, Langyan Ye wrote:
> Add device tree bindings for the Tianma TL121BVMS07-00 12.1-inch
> MIPI-DSI TFT LCD panel. The panel is based on the Ilitek IL79900A
> controller.
> 
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/ilitek,il79900a.yaml        | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.example.dtb: panel@0 (tianma,il79900a): 'backlight' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/panel/ilitek,il79900a.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251010093751.2793492-2-yelangyan@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


