Return-Path: <linux-kernel+bounces-884327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D135C2FE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AE23AB2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D69311C3B;
	Tue,  4 Nov 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLIcR5Fh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54533115BC;
	Tue,  4 Nov 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244810; cv=none; b=qPtd96YRSQKAlRxJnw/meU8PoJL6XrEi/0ng4g+XJJZ8MvLKHpSnCYUA6jA4RidAeQkSkrY1+oN2tu0DIvlqyjMrsnRvkeTVcXHvh3dmlI0xzZVxkbUC8CBTm+TS4XmIrWs9v7LACV2Qj3SjiuWv3f1FEVqWgZKWdJYSVxc9RNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244810; c=relaxed/simple;
	bh=BkNvFFvMHnJthl1kjY4jk2LuzgNxaXVmHfRYKCvjJCQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nTrDdhHRhXazp9Om1GtCIV2AnL0QTHnacb3aDKGowaP9KN91xmXHK9efu02KqRnWyy+99Ii3DJUSRnc4FMzwFT/CIWJgf4LkuKzgAIno0vJyWWpT+oEX6fJww4K1aSx45p9ZYwBCnU0OJxqaMk4U40E4jg/s5mLPQJXc6auh8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLIcR5Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3582DC4CEF7;
	Tue,  4 Nov 2025 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244810;
	bh=BkNvFFvMHnJthl1kjY4jk2LuzgNxaXVmHfRYKCvjJCQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FLIcR5Fh8shYtq7BDZGzRLuNLLd0kiE5SZefUR0gUb/CiKJOtsY9l0r3aUPSd/JYX
	 Ub3lxUu+yHSM30UNe7uCkgnDo0OOfePSsGJbejJu2JI74VAgtzNDZcjZ4GFj4+fevo
	 z5EaERWHGq7fhCTLDBXrFTc9+splZUTKcg7Ep3pp7D8drmgbDNPywOT/VhW/byPeCg
	 lCsGwqfHacADgztvbo5kNrGgYq0tBNUGFQ1fQ6TMGLdYoLVTPtlFSfvmK4dMLxvZs3
	 9cAlg17F0TiOcNgAtsdq9jXWyzt+/llz5T/JXKi3+8WyrZlBG8bWEZoeDiEijrpmZa
	 IyS2UB+kiVvjw==
Date: Tue, 04 Nov 2025 02:26:48 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linmin@eswincomputing.com, 
 linux-usb@vger.kernel.org, ningyu@eswincomputing.com, 
 pinkesh.vaghela@einfochips.com, p.zabel@pengutronix.de, 
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
 gregkh@linuxfoundation.org, devicetree@vger.kernel.org, 
 Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org, krzk+dt@kernel.org
To: caohang@eswincomputing.com
In-Reply-To: <20251104065202.1496-1-caohang@eswincomputing.com>
References: <20251104065045.1464-1-caohang@eswincomputing.com>
 <20251104065202.1496-1-caohang@eswincomputing.com>
Message-Id: <176224480839.1363206.13532075677416790871.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB
 controller


On Tue, 04 Nov 2025 14:52:02 +0800, caohang@eswincomputing.com wrote:
> From: Hang Cao <caohang@eswincomputing.com>
> 
> Add Device Tree binding documentation for the ESWIN EIC7700
> usb controller module.
> 
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> Signed-off-by: Hang Cao <caohang@eswincomputing.com>
> ---
>  .../bindings/usb/eswin,eic7700-usb.yaml       | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/eswin,eic7700-eth.example.dtb: ethernet@50400000 (eswin,eic7700-qos-eth): eswin,hsp-sp-csr: [[4294967295, 256], [264, 280]] is too short
	from schema $id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251104065202.1496-1-caohang@eswincomputing.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


