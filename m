Return-Path: <linux-kernel+bounces-818875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BAB59788
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA731BC5DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F59311963;
	Tue, 16 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcxw3LjC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7781D7E26;
	Tue, 16 Sep 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029116; cv=none; b=VfaYVL09wU5odNlNW8y6YRwrwjY8FtYoKxqVvRbMIK6MmnX0GEkDlbBFUtme/z7iNSHkur0S/L421v0zDaJtz6vzn1gZneZyi2daaGp7JfV+7d+0fF87z1qdsK6DTMqi+54wmU8H8BVyhiKC+M5NLwsF/13Fed96PzLjlrCCu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029116; c=relaxed/simple;
	bh=TnWVqJu7+bSzvUH6klH4pCKIBwlLZnLJ30RdHCvcXpI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KzSXga2G0+jeLAv9ILSj86u0xRh0fXOO4xbNsxMomH9VamjMdRwsSNsgAdAZQyMkD5uo92GWkXkB7uwAUXSzmmqXFe8vBytVumzEcd/M+rhWclQiHL6IeZuJnhsTJTyPePOZEfdPCBMPEzkuzHBoZ/3aC9bes3lvywSH/5smZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcxw3LjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A71FC4CEF0;
	Tue, 16 Sep 2025 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029115;
	bh=TnWVqJu7+bSzvUH6klH4pCKIBwlLZnLJ30RdHCvcXpI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Lcxw3LjCuB4qNqHjRm2+ofuatX9CR3D1fdfUaY+ANH1VM+E6Jj8u+OoSCrSRO3/J8
	 IMBUlCTYnlFQ0tZvKbUfUIHDfhCkYIak3x+XiSLbj48RW5ErX1bQjlKLcaOl7xwQ7b
	 1zFYnysLUWaJarrgwbpxGYZ6EndgDWBzdfWRVtOhYZ03qKv0XuckObDb05F3uc8GEz
	 DVouY/XqJT3pO2ACpmEYeOn0/ACJwmoQPsh9MswEtAY0WaiAbSFOlf3IQtqy1re8fQ
	 0XWihOjUttpgpBZTdZtkWrVDwfvv6aU25+REfjk8YF6LtJw3x/dvMGfqu3a08aNbwY
	 2+fYwKWNApwhQ==
Date: Tue, 16 Sep 2025 08:25:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>
To: Troy Mitchell <troy.mitchell@linux.dev>
In-Reply-To: <20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev>
Message-Id: <175802889714.3636283.16878564061648936522.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add CTF2301 devicetree bindings


On Tue, 16 Sep 2025 12:46:45 +0800, Troy Mitchell wrote:
> Add dt-binding for the hwmon driver of Sensylink's CTF2301 chip.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>  .../bindings/hwmon/sensylink,ctf2301.yaml          | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml:18:111: [warning] line too long (161 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml: properties:compatible:const: ['sensylink,ctf2301'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml: properties:compatible:const: ['sensylink,ctf2301'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.example.dtb: /example-0/i2c/ctf2301@4c: failed to match any schema with compatible: ['sensylink,ctf2301']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


