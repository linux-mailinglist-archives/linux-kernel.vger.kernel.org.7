Return-Path: <linux-kernel+bounces-864229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C366BFA397
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D139F4E9513
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49292EDD45;
	Wed, 22 Oct 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baHWjW0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF31284881;
	Wed, 22 Oct 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114560; cv=none; b=YHfMpHsjr0igzcUCBV5V1eKtEwVQY3YAjfJ+Vg8KumzE0Jo+f4G9Hkz8H4uQqQTvYz2cQ0ifnbb9BPbrkbccJXB8dqyxj9WiWJ5U+aIXV0ZhNfwYvEUh8E3/oG1FYjx+ItcqtKx0jbH6bHXuWsto02BW9WdHxAPkMHW2tQ8eq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114560; c=relaxed/simple;
	bh=QXPLGL8pseRCUe8lWHgA9QU+9DwUxuyGw1dXibFDFP4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oLHyqqR1kpcpr2O6aVlZFSVaHJIfkKNE+Ht4sjWKGqgcy9/7MD2yAXrXkfE0j0jONI7/Jx7ohMLUSSdeKALRHIydwNLKWOXCAd3mqLmDBaogC9Nzcj0cUU1GJO7aTgpeL4zxSiYVkm0kWCkYY12ye5kF9jYR2tGqZhTkCUU5lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baHWjW0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F50C4CEE7;
	Wed, 22 Oct 2025 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761114559;
	bh=QXPLGL8pseRCUe8lWHgA9QU+9DwUxuyGw1dXibFDFP4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=baHWjW0CcOnSygw1t8NqGdIOdWWlGNXbYca2Pnxi59xvRuFi2cUZdmBnA6zswRNVc
	 hr8yMEomwnRtI+ybwGepOPUmuKRYmW8NE8EITHCQ4ybEPzcL4X1CsG91/VBYaYUW50
	 TTzTBSQgaqfMA0hHS7ByX360hcPBa8xDdvT7RalT6NI2y+xDz/M57Lq2rjaH1WinHp
	 DHyjr2CcM+Y5qcrdhz12JYWylQfsqzUJa2YF5W6enP23/p0u6Vrr6SSO93DLXKdCpP
	 NnE38RsMfTgsemgv26yKKm2wmfqt9vjYqmv/WbiGQ0fyxUE/tbLVLc9pRusS9ZBMSt
	 1CTfZ2G4S/n9A==
Date: Wed, 22 Oct 2025 01:29:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, david.hunter.linux@gmail.com, 
 skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux@roeck-us.net
To: Igor Reznichenko <igor@reznichenko.net>
In-Reply-To: <20251022044708.314287-6-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251022044708.314287-6-igor@reznichenko.net>
Message-Id: <176111455721.2322150.17932964087857323488.robh@kernel.org>
Subject: Re: [PATCH 5/5] Documentation/devicetree/bindings/hwmon: Add
 TSC1641 binding


On Tue, 21 Oct 2025 21:47:08 -0700, Igor Reznichenko wrote:
> Add a devicetree binding for the TSC1641 I2C power monitor.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>  .../devicetree/bindings/hwmon/st,tsc1641.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml:31:111: [warning] line too long (119 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251022044708.314287-6-igor@reznichenko.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


