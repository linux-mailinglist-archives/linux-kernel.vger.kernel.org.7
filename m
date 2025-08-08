Return-Path: <linux-kernel+bounces-760531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EBB1EC81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388797AB33D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0B285CB6;
	Fri,  8 Aug 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsQ4J6SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DF23ABB3;
	Fri,  8 Aug 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668455; cv=none; b=MLHvgZw6VHtYOjEbZF4R2pldjE7gCXa3x5zGBEyU8SJhRaerx4kHb0oHIf8j6KGQCtruoKAaKimpI5rqp4Ehfj3d5ANLYMSGTcXim/c0No9O+6AZPcAEBkXUd8XX7a5OPi2duwBAcuXJXHwqqM1X5vI+qvOPyFx3r9tBhBx6rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668455; c=relaxed/simple;
	bh=QkTBeKjoqiTYtsZj4TAvkNckToe61OoBlX9hB16EcL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZziqER/yImEC/D6DswG7S/9J3WegpNhGOLMIkwIbnZUO0qU1vPGZjnSCbiOvo4VRHY3S5+SeOk0UuYMTvxgHZsy8cla9W5VBRc2PcpVDveLyLoAWbpQaS+aHZTkAJsvqsPoyJ//fO1pBv40wS6CT98ORoiq4thAnI0jI7W9CyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsQ4J6SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE23C4CEED;
	Fri,  8 Aug 2025 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668454;
	bh=QkTBeKjoqiTYtsZj4TAvkNckToe61OoBlX9hB16EcL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsQ4J6SPWk8shw4SPDSNN1j4nasGAZUC7D6PsTtOyRs+rN+wfdeW6JPwic5Oa9OVt
	 e1WiPn4zl6o/+8U7JEXVQhIn+KFIqPUeqpK0hq+zEUwDO8GVtT8PIwxsrX5bVi1Yj/
	 rXZDYmbpivaBIOigk9DNDpNHE3ukAGg4LMYz/Z36qjRP91sj/aGXnkKl7w+/5UMtQ/
	 GXNgZSjwqDqAudpB4lvg8lO8C1cCRrHDN176XRECaEURfYrZ9LRpqooi/tLHJONktI
	 WQ1mPa557qJxSWyX7cEQHacJNBa1y2nzcUi6zO+a6SNBqMFpE6XPeH6Y5kQfLMZQV8
	 Ls1+lmCWGu9KA==
Date: Fri, 8 Aug 2025 16:54:07 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] dt-bindings: powerpc: Drop duplicate fsl/mpic.txt
Message-ID: <20250808-sake-specimen-13313160b9a6@spud>
References: <20250807214432.4173273-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sKigfMgF1pPea84g"
Content-Disposition: inline
In-Reply-To: <20250807214432.4173273-1-robh@kernel.org>


--sKigfMgF1pPea84g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 04:44:30PM -0500, Rob Herring (Arm) wrote:
> The chrp,open-pic binding schema already supports the "fsl,mpic"
> compatible. A couple of properties are missing, so add them and remove
> fsl/mpic.txt.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--sKigfMgF1pPea84g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJYdnwAKCRB4tDGHoIJi
0hEfAP9kk4vmVMA5jFwH7XJWvyF6laSF8vCUSKc4JYmZQYyPUgEA746BN1y0RtWR
PAGQ7h3RQWwh8A9hbpKAfs8O7cY2PAE=
=QgBv
-----END PGP SIGNATURE-----

--sKigfMgF1pPea84g--

