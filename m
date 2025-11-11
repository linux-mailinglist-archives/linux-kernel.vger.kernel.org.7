Return-Path: <linux-kernel+bounces-895009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF476C4CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0CC3BB13D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB712F60B6;
	Tue, 11 Nov 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cADF7BZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9C2F1FF1;
	Tue, 11 Nov 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853540; cv=none; b=EJGH3++ZHfOGMn0y62zaw9w9B4Y3tqVmOGc2R8F57HcSPw0dzUrkaq+oMInmTLcxn4H0cnXYIy4I/85cM1Oebh3/fGlnaPBgd5kVy4WL13i0dS10+Z0bFcu7XTMGPf2lUPpVFwpkUZINY9x5P9hJDk5W0EWFNZyZoo77KTY20ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853540; c=relaxed/simple;
	bh=25mQWYoIA939ku80KYCjFSeypaIGXxI4UJxB/LY8o9M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VJADIEte28II37ysfny263D0tZj9iH8N4bacWi3Z+uJzTulkwYh6/NA0m7KNxtHu8mSv9VcGXNC3uKXSvV+GoSzLW/O/DbGhUzxs90DPAc1mbCNRuHnCWdXUp7sjBXQKDMZUJMgZ/VWkLjve4zx3Gx0QuMAzncuPYBrkEYNmuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cADF7BZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF76C4CEF7;
	Tue, 11 Nov 2025 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853540;
	bh=25mQWYoIA939ku80KYCjFSeypaIGXxI4UJxB/LY8o9M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cADF7BZXi3wl835diwsLESno2PZDjDx73nIda1IeGOzPYFizM/7CwmCg5A72B3zsV
	 P32UWuo7vJzoXYMqqyY7E9saZV28/lm2Rg4RrxmriLLd223AW79dGVfW8S7JBYVOwJ
	 +aewyVPpH0PGfs/XxyAM7RrtX982GnJ3ZZ+4bCpAHoyN8QxQsorw5Wd2XLxS6LD9KV
	 +zAjONBVlIPbqwfISk+keTTxBhchIwKXG1yulDAQCa0YkqHvCzFVh25KQN2ffPFeKn
	 GNCv45UnWRDie+VqGhn+YW5maEQtIKYeU/BdGtW9uI1nmUI4Xz11INVNJUenGqPowc
	 dk6zUhW9f02iA==
Date: Tue, 11 Nov 2025 03:32:18 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
 linux@roeck-us.net, Jean Delvare <jdelvare@suse.com>, corbet@lwn.net, 
 christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
To: Wenliang Yan <wenliang202407@163.com>
In-Reply-To: <20251111080546.32421-2-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
 <20251111080546.32421-2-wenliang202407@163.com>
Message-Id: <176285353822.2206360.4224721052880001451.robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-binding:ti,ina3221:Add SQ52210


On Tue, 11 Nov 2025 03:05:39 -0500, Wenliang Yan wrote:
> Add a compatible string for sq52210, sq52210 is forward compatible
> with INA3221 and add alert register to implement four additional
> alert function.
> 
> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
> ---
>  .../devicetree/bindings/hwmon/ti,ina3221.yaml    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml: alert-type: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251111080546.32421-2-wenliang202407@163.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


