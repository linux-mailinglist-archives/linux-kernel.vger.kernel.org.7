Return-Path: <linux-kernel+bounces-775479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF440B2BFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC40620EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB7322DD6;
	Tue, 19 Aug 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOMpDl6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C4322DB1;
	Tue, 19 Aug 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601275; cv=none; b=iV8oso7CQAdtd3LASe3EQ5licaYQ40UWSseJg9PhwFIpG7ANx63OzKBw+ak+U8rq1OQRrvGNzBrDXxihqR0tMszt8lcUNFOkkTGy+O6RQQKbTJEI8Vp4KjlrwbqNW6f0MLhxcmi2WKqrIjgQAZj3nEU7mv/SsxKsTqVFkboevp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601275; c=relaxed/simple;
	bh=55YCx4Ic6F/7q7AGUwl1QnZj0i5Qlknaw7+fctybJW8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eIxgKxT1oPNveXA/0VNzLfvGhKnjUM9IPqS+5+EHFB0rpEaP8IsSnri8isA/YbjmoLlx6D0/IGeKkGGWQUaJNlfGRgdPEp+qjgU7DA6ZExJxW/qzXdXW8XCaSQhPZSSsT1U9z0TbafRyY6MVqJqQZus0kR64JamhTUspkX7TgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOMpDl6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30151C113D0;
	Tue, 19 Aug 2025 11:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601275;
	bh=55YCx4Ic6F/7q7AGUwl1QnZj0i5Qlknaw7+fctybJW8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kOMpDl6wCZPTcqSUklmDaJ1BkUfkAvN2tKsQdQR4oU41qK+KQpMOdlJ2OQYhm8nb1
	 BsT0nmWHccyekHWl2ub35xav2wocw59ywWzobyn8fLPymrJXcECAVw5W82UBA/QZJw
	 Q3dzKgFPd3YbTxHOg1xlYMYqgXL/OZkTz0mlVy8mNNTELLdQMpoEtkoAHYyOrGR6iQ
	 hd7Ba4gVDAY3K0UeeDezdNSQ/7oqVe27QhLNy3510uPHaaOWDOsDZj2wpVZ5CQks/7
	 0aWa+vQu5C3s6GGoepUowNeyC81ZtJkzpSLNID1sL63iG9n01W7jw7zAgv2mRtoyZ8
	 TpYRkZSQX9tOA==
Date: Tue, 19 Aug 2025 06:01:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Will Deacon <will@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-2-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-2-04153978ebdb@foss.st.com>
Message-Id: <175560127097.3969141.6615836877357567088.robh@kernel.org>
Subject: Re: [PATCH v3 02/13] dt-bindings: display: st,stm32-ltdc: add
 access-controllers property


On Tue, 19 Aug 2025 11:15:55 +0200, Raphael Gallais-Pou wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then check
> the peripheral accesses before allowing its device to probe.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-2-04153978ebdb@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


