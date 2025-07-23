Return-Path: <linux-kernel+bounces-742058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB3B0EC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC535178950
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E658279788;
	Wed, 23 Jul 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYnkiFGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A985277C98;
	Wed, 23 Jul 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257804; cv=none; b=JGo4MmdkqDiLbF/tDSQD9o4FPD3+vxAL8vmVXU28iLtnuYFiOyZxpn/yz7HmoWFqwbH6EDl3HK2Pz+pu2zw4eDdT90C+vA5pUDlolKNGC3wa2AWUqb5FhiN2d8V7GjvTzDORVa/vgZFQpnOsOBRlVVN5YIoqtxgleXpTIRada74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257804; c=relaxed/simple;
	bh=DZ9PwQBYoEqa9gBIc5ARW3ABA005LYABoXfIdegGZbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNETYi4cOVCtJOJMjM6E/pYPswd+A7TGZzKE0KEIYBGOiYt97ZcbDdrABM0iBZm+7BnP9ZaH0YkdV3A6u9BW+BBnVmbZB8tXtJR7l+9rHjKOmKEb+XYOBQB/n7kg9HiPL/mVJ5YqToD86N6AN7jE86e3VfpERzgoq8VI9gAATrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYnkiFGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9CBC4CEF4;
	Wed, 23 Jul 2025 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257804;
	bh=DZ9PwQBYoEqa9gBIc5ARW3ABA005LYABoXfIdegGZbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYnkiFGQLE1z1N9S1N2HbWs7qM/3m6g05DiejT5t9Q4SbTTpj1a1JuZgFYA/ytMO6
	 AQN7Ox4iETKRel5CvXUe9Q3m3ZdY28WliNgiWId08kyp+3dkB5h2rQRySjzxxzfyeW
	 AohOCn3P+eTLk9bZg6EykMrvw0wE1MCdmCNY/8k17S4OkGr+5y6dJNc9RgV6lwY9Xu
	 v1jPUZNoMKG2ZcCebPB7KF/PF8hDpiKHJd0WWvqF3miPkG0eipWA36kFttA3rnt16U
	 r/RaCxdM6VvevsCUpH4j9kGvXQlGpqBvA1m9S42r7UFrdPtP+NRjsY4JONf8KRhOOd
	 +TrhqVh1W/Ltw==
Date: Wed, 23 Jul 2025 10:03:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: display: sprd: allow attaching a
 DSI panel
Message-ID: <20250723-wine-numbat-of-persistence-bf43f3@kuoka>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-3-054276ec213d@abscue.de>
 <20250723-dark-modest-mole-480bff@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250723-dark-modest-mole-480bff@kuoka>

On Wed, Jul 23, 2025 at 09:54:57AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 22, 2025 at 04:41:05PM +0200, Otto Pfl=C3=BCger wrote:
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/media/video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +            description: The output endpoint, usually connected to the=
 panel
>=20
> I never remember if the output should be a "port" here or a panel@ child
> (as described by dsi-controller.yaml). Various users do it differently.
>=20
> Syntax looks fine to me, so happy to get second opinion on above point.

I got now explanation from Neil, so all is fine.

>=20
> Anyway:
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

