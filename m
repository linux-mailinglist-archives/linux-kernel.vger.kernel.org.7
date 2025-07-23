Return-Path: <linux-kernel+bounces-741832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C41FB0E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50733176ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1B212F89;
	Wed, 23 Jul 2025 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7soUqhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369E1DA23;
	Wed, 23 Jul 2025 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243961; cv=none; b=IVi/hbWjyGfbScwYqL8d9a69JZDQeNZIG5m2BGubwBqOzZG/VFNABVr0qEkcaLTUpteTYd+UyTSBqp3tCQ2o+tnUEBvJasTEE5wg+feVxzrvfID2r9XU0yvnx3YFQkpHt6sdDvCvWjkWVw5vf+Spq672bnsr6qer4+HEYN3WPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243961; c=relaxed/simple;
	bh=eVTqUw0f7/1nbbH+ENzIvcMr4jRuFi04bWinogCv0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWV7IWYW9LQS7+o92kzRQHRP92E2Fj4/0LSt83Zmx0mBf/H9cskJZ39UXNzgFxPURwFWv2dNSukm/105KpOq8ufkXJLm7Sx/nFm6MAKX3sPG/xpdXvzPLuMLFoFi9dNEWlGiv908vIABhiX6HL4VZqHGblLtj7B/XpZC78fJozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7soUqhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C4C4CEE7;
	Wed, 23 Jul 2025 04:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753243961;
	bh=eVTqUw0f7/1nbbH+ENzIvcMr4jRuFi04bWinogCv0LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7soUqhS33sWbErFUno1ZIAuuM4oKiJqTr3uQC1Gr/8lfj/V5e899lLDMvCx1qvZ+
	 P2BC+xDPIlyDS8C/d2a2zMC4CC+Y30mNeHmSdUYQos+1omuWpjNhZSLU84nbCCwQHm
	 mFEK/pmAeezYduQBC4+ru667WR9ynBv0x5TtKyqlekWOJqCm4dA/UWBmK7GvbgpAIf
	 CwC41H7A+7D30R+UVbRtZKI126fuk+ZsqKLhtQEcOI/umfWc5IVN19giVe13jCDg8V
	 P1uQMJaxTP+zWhdvenr8cAdhEVefHxtnjuXjSAayTErQ+UxuHcIBhy4/PlGYxe9aG5
	 eR4ScutldhOjg==
Date: Tue, 22 Jul 2025 23:12:40 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [RESEND v2 1/1] dt-bindings: display: imx: convert fsl,dcu.txt
 to yaml format
Message-ID: <20250723041240.GA1085293-robh@kernel.org>
References: <20250616182439.1989840-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616182439.1989840-1-Frank.Li@nxp.com>

On Mon, Jun 16, 2025 at 02:24:38PM -0400, Frank Li wrote:
> Convert fsl,dcu.txt to yaml format.
> 
> Additional changes:
> - remove label in example.
> - change node to display-controller in example.
> - use 32bit address in example.
> - add interrupts property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> ---
> Change from v1 to v2
> - add Reviewed-by: Stefan Agner <stefan@agner.ch> review tag
> - add interrupt
> ---
>  .../devicetree/bindings/display/fsl,dcu.txt   | 34 ---------
>  .../bindings/display/fsl,ls1021a-dcu.yaml     | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 72 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/fsl,dcu.txt
>  create mode 100644 Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml

Applied, thanks.

Rob

