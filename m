Return-Path: <linux-kernel+bounces-767210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4DB250D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2457F561AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24B28D8E1;
	Wed, 13 Aug 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By8FiGPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88628A701;
	Wed, 13 Aug 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104426; cv=none; b=hvJme7EKNNonlxtg9udLRDDFoApGVW/RyLqJhg7NhEZVw2hqFN8zf6M0lnvaBpwXuLLwaiSP5jOG9jqT1A91DasS9BccaGT8VWwfuQN4pojfd87sI1tfALP+/STZR9GH1JupptNjiK0ruzFvwGUeMg+dmFv2Gt81Ny+Ha92Xfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104426; c=relaxed/simple;
	bh=3E70uCZdsVlnY5HHNZKc6pAhrrnlA5QbBWcg/yc6aGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G19R1tqbdTbLXZdCsdxHhx7DbUo36PV0Fq1m0CR1aknSkOJEq5PzDqTv1FCji+TawbOooiSttksf+It6MmwlSOtbHBWrJWrraJmMx4uMBmJ3ptENA4AnjKfX9z4Om21lNNgs90F40yihNc+AkP3pqVTbBFWqoCEihOBH8afFJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By8FiGPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69673C4CEEB;
	Wed, 13 Aug 2025 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104426;
	bh=3E70uCZdsVlnY5HHNZKc6pAhrrnlA5QbBWcg/yc6aGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=By8FiGPMEFptGHgQ5TuONHulpMaV9p2sQTpptDgAywUyFdcoQ7+U6GiDN5nhvGueE
	 Owgw+K0YrlNTo/pENceZu+VwGDl78+SiGdyNH4TW6P1zX9IfJu/hEifFtmHl7xGvRs
	 nwQ8WRId3z+pM252k9FKgqVe5/JTFraR9Kh1MLh6s4bxHTSofilB++Ct+4rRT/ijLA
	 qfaHEpzl4IqjrBsEtwrN7SJN9bpVmE+V4JL9cOMi9/Y5a1T/5PX/doNSl7b0M6bOmE
	 gFyg8WSxC/47wxmh5Kclzh/ZnH68ZVx/uCpcr2vfhZQJtklcIUUcoWs1gBMFozF6rb
	 cj5e4Dm3d0Keg==
Date: Wed, 13 Aug 2025 18:00:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8365 SoC
Message-ID: <20250813-tinwork-outfit-ead86c38585d@spud>
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
 <20250813-mt8365-enable-gpu-v1-1-46c44c6c1566@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ST/TrnE4ajryBS2Z"
Content-Disposition: inline
In-Reply-To: <20250813-mt8365-enable-gpu-v1-1-46c44c6c1566@collabora.com>


--ST/TrnE4ajryBS2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:25:42AM +0200, Louis-Alexis Eyraud wrote:
> Add a compatible for the MediaTek MT8365 SoC, that has an integrated
> ARM Mali G52 MC1 GPU and compatible with arm,mali-bifrost.
>=20
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--ST/TrnE4ajryBS2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzEowAKCRB4tDGHoIJi
0sDMAP4+0xSBcmMGGhX5SJe5IJFeOimSGjNftWdRCFtpLo9HWgD8D8T3LnfuaWZf
iFanLD4cGtlfmp+DFdIhwe8VPds0iAs=
=sFgA
-----END PGP SIGNATURE-----

--ST/TrnE4ajryBS2Z--

