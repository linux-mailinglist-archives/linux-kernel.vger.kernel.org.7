Return-Path: <linux-kernel+bounces-780425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD4B301BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0EB1CE2D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12B434321C;
	Thu, 21 Aug 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9tu73wU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B472E62A4;
	Thu, 21 Aug 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799810; cv=none; b=hdUuYx8pveiji+ShTBWeUS9dvKQ6HQRPR6U80YEi5Ci36XYPAkF2vhLdWgymDsZKh7bYxcNr6IVEjaIn2TdHTvEaqJ/NescRDaBQ7P7i6YgfWV9YqBJKpOZWi4tUsgXtmm7HPmPKGZeMjThGk22b0B0At/Lqi011zbRuenzgwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799810; c=relaxed/simple;
	bh=apD5JO1he70Tjrq7BLkA+rkkDaWLTCsaarVnSINXcLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQXr3paS75w32j0BwaSQuZ6yj7bJbWgaE/eO0yul0RpJZP0imA0qNkG7uSBj5kQjZCy2zhWEpSHEmLFG+wq9bvgpt/KOA9ITM4Bx+GRxlBWybpTyJejsSAztB6uGN4JK28H3/xaaF1uv/a6aA1S/OSAemTyzGjzm7iThBm0wcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9tu73wU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829ADC4CEEB;
	Thu, 21 Aug 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799809;
	bh=apD5JO1he70Tjrq7BLkA+rkkDaWLTCsaarVnSINXcLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9tu73wUuT45h/YwbSsQfEo6m3QDREQEqdymXs8JpkNQJl+TjzyywxnuFvijnkhpE
	 znRCGJtaLpdautPlRkBeYo5CXZjcaJ6Y0YCnykYGflxyQJfvAEaMMBQCv/hnX082n6
	 8s3wHbhtz8eSCZ4sbb7ODm/oHor9Rgztu0/hTDylUui6BifGbsRxgSkNKytTDbUzbj
	 Ej5W6J4ikpFVxEKnQQyVjrfyzbeP1naQ6ng2QujDiWD/WGrYaW9erprEdO8o1q9bnD
	 ghSvrjLgFqYHjNbwI7EOLniiwmk2vhYde2B8eFjZQSwgWDilYA0vmDIi3Yf9E/wOBQ
	 QjAjPruUetCBg==
Date: Thu, 21 Aug 2025 19:10:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR144NVL board
Message-ID: <20250821-contrite-anguished-3098e847bf8f@spud>
References: <20250821051047.3638978-1-donalds@nvidia.com>
 <20250821051047.3638978-2-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ToW9FfKiv1Hf3JrK"
Content-Disposition: inline
In-Reply-To: <20250821051047.3638978-2-donalds@nvidia.com>


--ToW9FfKiv1Hf3JrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ToW9FfKiv1Hf3JrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdg/QAKCRB4tDGHoIJi
0r5eAP0Zi7H3YyCLpeMdEYZeG7CkWWKjGuR+jfMcNRK7sqar0gD/YwgsQHN+pFuo
nzTHksLll+pOzH3rDLm4lkwrCvithg4=
=ApFm
-----END PGP SIGNATURE-----

--ToW9FfKiv1Hf3JrK--

