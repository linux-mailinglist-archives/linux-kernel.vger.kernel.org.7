Return-Path: <linux-kernel+bounces-862178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169CBF49B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 480A34E776D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67E238C29;
	Tue, 21 Oct 2025 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1B7ATjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB98460;
	Tue, 21 Oct 2025 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761022456; cv=none; b=q/PgmH6fhIhR8+Hftl1BaSDOOZ9DyKT5qTQPf3Ex9Sex6MPs3X4zdm/yiOW6LNoYfIYoYlR25Zu5h4DfNA7+TGgR8biccLNSSB3QNWGvEofszzcS3LZ9p45iyG7Y6FgcTb3eMb0EBmtcjV43EOKZh4k1sn0zS7pBy67bXEzvT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761022456; c=relaxed/simple;
	bh=UJ8dZv5bHlZPJQMkZaF2uHRed3zaCZaqouJxTbRtbKk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=I2LbbyIk+qOLwTzI5qFjLq+MMyqiaLRY1iy3DNH9guk4VkNZfgS9uJeIwXW/utoncDHDGv/sD8M6BU3ukHE3PmZx59D8bDu74lHD6mvXKCXls+4CrNmnvPcb0FfVkh0PRN0kA/BrRkjGsUqoKAzDzpN31IaGVmSYk4S60ktWd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1B7ATjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDDC4CEF1;
	Tue, 21 Oct 2025 04:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761022455;
	bh=UJ8dZv5bHlZPJQMkZaF2uHRed3zaCZaqouJxTbRtbKk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=p1B7ATjXuQjDxi8Wih6SciXdIjQSn4W9b3flzgtdqYyDQRCUOJEk8ft+Yln1ba2b+
	 l7LYsMl1Cpij8Y/ay6wYKI4Fnvu9H9c9VkJd4m52DbYgSG/IzYoXfoGaid36/EmAqe
	 YjU9CcujNl8Uo9tfurbZ59fl/RO91gDBLXYGnfwt0R6jX9mTSpUTcjgGEw5CqGlXKm
	 njWia+00P2Wh7cDFM3H6SVGIZMfJ+WopUIFce43gz8H814w1pajC5SO6V0i1t/ORzE
	 mcMj2Nk+9952GdJZbIBeCQfyMvLjs7RwM+YCeBum8FsgvN2o/vmadZyotyBjzUsjpr
	 YUFeCprPUlYag==
Date: Mon, 20 Oct 2025 23:54:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com, 
 huangtao@rock-chips.com, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org, conor+dt@kernel.org, 
 linux-clk@vger.kernel.org, finley.xiao@rock-chips.com, heiko@sntech.de, 
 linux-arm-kernel@lists.infradead.org, sugar.zhang@rock-chips.com, 
 linux-rockchip@lists.infradead.org
To: Elaine Zhang <zhangqing@rock-chips.com>
In-Reply-To: <20251021033834.1390006-5-zhangqing@rock-chips.com>
References: <20251021033834.1390006-1-zhangqing@rock-chips.com>
 <20251021033834.1390006-5-zhangqing@rock-chips.com>
Message-Id: <176102245277.2690154.9518311303158362414.robh@kernel.org>
Subject: Re: [PATCH v4 4/7] dt-bindings: clock: Add support for rockchip
 pvtpll


On Tue, 21 Oct 2025 11:38:31 +0800, Elaine Zhang wrote:
> Add pvtpll documentation for rockchip.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,pvtpll.yaml       | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251021033834.1390006-5-zhangqing@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


