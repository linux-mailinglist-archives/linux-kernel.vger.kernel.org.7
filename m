Return-Path: <linux-kernel+bounces-888466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37101C3AE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2149F3B166E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA4632B9B7;
	Thu,  6 Nov 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPviaEw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E732B997;
	Thu,  6 Nov 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432470; cv=none; b=ux/HwkujXXvKD/XAgIOLZrpyPy7WdX37pbMz4mm9UFP6rEAR8R220EIT5OJOWZWbdhN4gkDR1Twi/9Ws0LCQU2DGYQaMdeEPtHk5GxODebrx0yR3kxuxe8viox0o+eqrwp/PN2PHkzMfp7o+4dw9GgJU1cO0YPnLmqlL3yW3ITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432470; c=relaxed/simple;
	bh=8lhmA5QvBE+pEK2Dtua8z+UjGJ7SB6l3wwlrOuIyqVo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=g33qFq24GenEIUgHbZb3+j8hPb2fhruFfvzW+kTD678SMHO201GwLzsJdinHVUW3cxMVgHB3ay0MZSC6A5VxPw+HTrvj6vr+dIbRKcYTmTxl9vhHZxXOjaV2NTGjEdHwzt7/cCPI3H2rGpGkq4aee3bcNTe5rrLUNlRoR2pBFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPviaEw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260E5C4CEFB;
	Thu,  6 Nov 2025 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432469;
	bh=8lhmA5QvBE+pEK2Dtua8z+UjGJ7SB6l3wwlrOuIyqVo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CPviaEw6+0KLPztHfnqqcXZ9c7V7vz3rEk5SFwqe3sCZKR2QTynTxBXU2Xku/Dps9
	 YjJSolC4NGAzlYdA6urJXlZOHgHgg5JmotGPbjgUtV6HEKmqPwnpdcwcI0CA2SP3TR
	 Pdk4cX9th7HcgQQTRQ4+pIsfopupJJdHAK0OSpVL8su/xG6th5XWGTE87nF21bpLt2
	 oVzrxompTkhYkqLocpB4LUyF3s+LhDtndX9UWu3KoUp3nsqVjkKXKHWkiIgtqumGFG
	 feYIWZdR/sdbg1tCE9H9ni/y6IUvvpfe6whzhJXkjVffEbAAkezLcbMG7TY5biH9j0
	 IovX9VoTIdSmA==
Date: Thu, 06 Nov 2025 06:34:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linmin@eswincomputing.com, linux-kernel@vger.kernel.org, 
 ningyu@eswincomputing.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de, 
 linux-usb@vger.kernel.org, krzk+dt@kernel.org, 
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
 gregkh@linuxfoundation.org, pinkesh.vaghela@einfochips.com
To: caohang@eswincomputing.com
In-Reply-To: <20251106105029.1400-1-caohang@eswincomputing.com>
References: <20251106104938.1386-1-caohang@eswincomputing.com>
 <20251106105029.1400-1-caohang@eswincomputing.com>
Message-Id: <176243246752.3577633.13564791742117028696.robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB
 controller


On Thu, 06 Nov 2025 18:50:29 +0800, caohang@eswincomputing.com wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251106105029.1400-1-caohang@eswincomputing.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


