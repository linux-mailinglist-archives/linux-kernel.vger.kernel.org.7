Return-Path: <linux-kernel+bounces-777790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CBB2DDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722C47A5C64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1A320395;
	Wed, 20 Aug 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxhfX2eJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB22DECDF;
	Wed, 20 Aug 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696734; cv=none; b=LVQAbC0mo3DOganmgCTcWmQlfFupI/166hDjvCoFC9U+UricJelIyRiJp+EfcOqlJYJXLHUxnJVTHyj4FEHo0MDWCY3DjEetF2HfPe1QlIfV9h+suOOS57+wm8qSXmCOq57pQot5j1WcK+14YFZ5lsItncjAIG3/8qVsrrYhzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696734; c=relaxed/simple;
	bh=VmC64I3c//25kcKmSiyTSzAZcozMKfr1010PUjIHDRU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=QvgJurgiN8fbvJlXfLy6xrcXai5oSTfUJGwPzed9bMnCqlaKucAwEUqjjRf6au+2LlDh6hyPI2oOLjN6plKyZRORhLzwCBQd9u+xsXPpUWcSSpcT/mxTmu3kk0btg2bOVJd5pAAIcgZFRCxzSDIQQYJGyx+0w2AHK6cUL/TItdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxhfX2eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A84C4CEED;
	Wed, 20 Aug 2025 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755696734;
	bh=VmC64I3c//25kcKmSiyTSzAZcozMKfr1010PUjIHDRU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bxhfX2eJTx39hAXzOH8F7an19eyMbxkzJjHMdJmpy3TQOhp97PD3lpExGPEnpy3PD
	 wRYx/EhkPiuSGlKTgwFN2tNTfvc7q9v2W+iQaLR7U+qxX8GkFwSC2im0jYMPQJjwpD
	 zASTRNomGiOlZvb7bTvBShGhDS7ngEunfL/Aplp2tUQhaUFys4g93u9yg4sZ3+LqoT
	 OQgPnyYIP8K4whbPTyzcwZBN/qb/RdF4RiRS91O7Zpct+DMDFgU96I4QecIhfi76bQ
	 P9ojNjlIscgmedSHc1f+6uNK1IghdLvp5A1gBaRWWl7Xy0aHpXaQnVhQBdTZHR1KPb
	 J0UT4fxB3QGeA==
Date: Wed, 20 Aug 2025 08:32:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jjian Zhou <Jjian.Zhou@mediatek.com>, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>
To: Jjian Zhou <jjian.zhou@mediatek.com>
In-Reply-To: <20250820094545.23821-2-jjian.zhou@mediatek.com>
References: <20250820094545.23821-1-jjian.zhou@mediatek.com>
 <20250820094545.23821-2-jjian.zhou@mediatek.com>
Message-Id: <175569669451.3275225.15370422405683288436.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document


On Wed, 20 Aug 2025 17:45:37 +0800, Jjian Zhou wrote:
> The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
> messages through 64 32-bit wide registers. It has 32 interrupt vectors in
> either direction for signalling purposes.
> 
> This adds a binding for Mediatek VCP mailbox.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  .../mailbox/mediatek,mt8196-vcp-mbox.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/mailbox/mtk,mt8196-vcp-mbox.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250820094545.23821-2-jjian.zhou@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


