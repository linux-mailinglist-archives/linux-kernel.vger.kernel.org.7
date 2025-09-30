Return-Path: <linux-kernel+bounces-837102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1DBAB618
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA97C17C1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA612CCC5;
	Tue, 30 Sep 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQEkVyLu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8021C16A;
	Tue, 30 Sep 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206981; cv=none; b=vFHzaOaRIDKMHX6KNlcfYSugQvZNARxV+mq1DIwI5BDdndOeqwLvelX0rbrRFFARd6HbDHImcYzBwEs9bHZjH7WL2LqP1o1S4YQxhpI6Wtvifhzs9QIMhqygZhVqjMEl3mxkRgMrMRp2vqhgoUsrkFBEBSk4Dbv2CuDZSLUCrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206981; c=relaxed/simple;
	bh=YOUg77FB7Xsm2UXs9arHKbD5Bdz5tRGM5gEirnJeFdE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=h6IztfbW3SWigVnxvdRbDkwFXH658qxG29jlDcQ3r+5K0hnkRz57NRpcfbzJRRuoW6fUubFvgLBPj17cRmZ5cREWgzp0lXNRM8CM2zzrPQ2FRjfV1AHC+PDtJL74L+jG9flpXHHfGdXi8nqMe0GfeLa/tsE+c+3Q3B5qFf4HTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQEkVyLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6003C4CEF0;
	Tue, 30 Sep 2025 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759206981;
	bh=YOUg77FB7Xsm2UXs9arHKbD5Bdz5tRGM5gEirnJeFdE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=iQEkVyLu3/LFNOy7g9AbppZPCo7MQsYG/mrwFpcgoJROTkJgCJvumEiBlVwsrJUq+
	 FgYYiBTCLbmKHCs1+ieBhqjONqm/qfnocgvbV6dReKPRS7PZMbT8m3IxKdqy/o+lZ4
	 zNlL9xpORTGMhhXd4nrckOHQB/0oeVUoY5DXW0dZJbCsU7axl8b/sYBhh3OGw7QY1j
	 +2C+aPC0jWvWGn9M4/X1EAH2RhHR8QFCX/mK7iKfPRhQ1BFwmalLLrXy8Ca/KmLhWP
	 DSHrkyrBDH3o1IHpvgy83pa6gONBVv3bzxr6VSTu+JFigQrQLcVaOfnG7B7Jj9CxF+
	 WckMMVarBJsZA==
Date: Mon, 29 Sep 2025 23:36:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, bleung@chromium.org, 
 heikki.krogerus@linux.intel.com, ukaszb@chromium.org, 
 linux-usb@vger.kernel.org, akuchynski@chromium.org, tzungbi@kernel.org, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 abhishekpandit@chromium.org, chrome-platform@lists.linux.dev
To: Jameson Thies <jthies@google.com>
In-Reply-To: <20250930012352.413066-2-jthies@google.com>
References: <20250930012352.413066-1-jthies@google.com>
 <20250930012352.413066-2-jthies@google.com>
Message-Id: <175920697975.1402374.5817792319376446761.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: chrome: Add Cros EC UCSI driver


On Tue, 30 Sep 2025 01:23:46 +0000, Jameson Thies wrote:
> Chrome OS devices with PDCs allow the host to read port status and
> control port behavior with UCSI commands sent to the embedded controller
> (EC). Add documentation for cros-ec-ucsi node which loads the Chrome OS
> UCSI driver.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  .../bindings/chrome/google,cros-ec-ucsi.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.example.dtb: ec@0 (google,cros-ec-spi): typec:compatible:0: 'google,cros-ec-typec' was expected
	from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250930012352.413066-2-jthies@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


