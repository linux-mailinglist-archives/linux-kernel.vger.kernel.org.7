Return-Path: <linux-kernel+bounces-821569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F8B81A69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C4117D3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DD30C118;
	Wed, 17 Sep 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSfe54/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD430B50F;
	Wed, 17 Sep 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137573; cv=none; b=HrQIiQuYZJCETu8Je/Vkmj0FSRM6V/KDbTEyiYn7Mho6cz48sBNeZQl1s1zOru1L2MtZh67hUGHzj7c+MAXAVsjd/vrarGpUr2X4ZOoWSJB/YHuehsF34eRRNPbhMeyVCnPP1GrGZCVxgj3S8WwnvzMa7StAYo4bcZtbWAdfdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137573; c=relaxed/simple;
	bh=imcT2ZOTLaS7yvZfoNK95wWWHHDAkdQyIpNsoATlBKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqLRrnZ+95wxXNUatYBjblE4dGOuPf2pFa6IU2AvLHgLLLIgrbNVDnecwE8zFvBkJvbifwhHYbaYenVrI4cmvyIh2wPpHKX76h2EQ5XtYF6GLFQhi8Wf68QFTF8GG0lmDcSqNB51ZjCAPnqpsmLAnNRkqoGDmzVdsi0PxS0L1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSfe54/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7053DC4CEE7;
	Wed, 17 Sep 2025 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137573;
	bh=imcT2ZOTLaS7yvZfoNK95wWWHHDAkdQyIpNsoATlBKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSfe54/QJijz7Q3v6gB3iqaExYddqau86ozSqXX0XHJzxRWX4Z59WaGsJNsJpXkCr
	 toQpXTfo31QIQX5N56h1QDTDCJYhPcexVGXO1v8iBmBTMMLLVZuTatTTTjAGXyj+oW
	 mvQR1a/8ahZI2+hyAExlF3xrwCkYTp4V8F5JywIhzNweOOp6PUjoLwqCEni89YFZD5
	 nPp1HObN8exWFGdh6qi6qvNp8Hj1eXQmrioq4KrPZD0SXcpU5ZIiSilDCleJj+LFKz
	 jQgDxOkJLH9rJL+sOdFVYlsMOU3yC1vWj3kqHST4VCWDD4E14OJqa1mFsAgdxvKSbQ
	 mFcWWh2dl5H8Q==
Date: Wed, 17 Sep 2025 20:32:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700
 compatible
Message-ID: <20250917-widow-kebab-1bc45daedbb9@spud>
References: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
 <20250917021926.3692137-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iJfa+WoyWD3gI0j9"
Content-Disposition: inline
In-Reply-To: <20250917021926.3692137-4-ryan_chen@aspeedtech.com>


--iJfa+WoyWD3gI0j9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iJfa+WoyWD3gI0j9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsM4QAKCRB4tDGHoIJi
0u1GAP9CY8qeE6M6Lj03heH2YpGlZEQuTgKsxke3xQFdk22WFgD9GIUKe8VFRv5V
C1iofdh7A+zzI7ODAQWUAaD9g6wlfA4=
=eSPN
-----END PGP SIGNATURE-----

--iJfa+WoyWD3gI0j9--

