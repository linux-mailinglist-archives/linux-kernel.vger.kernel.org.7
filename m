Return-Path: <linux-kernel+bounces-605081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957AA89CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DCA168FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADB291160;
	Tue, 15 Apr 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/tvx7Sa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933024EA92;
	Tue, 15 Apr 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716994; cv=none; b=pHUpTlOhsme4VY745g0sx+McIUAEzjakexSPzk/jsP0Zz6vTgtIjOUmyLKwjoP1eiv9MkB7X3Yowr7sKjYvti/6X8yr6lTCAP6sDpiAYBOUV4jcTAHvYcyrYMSlDJmlAaM/OZRK0lxdI8EZM4/A2UVznK5/dgejwlfh71BGoYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716994; c=relaxed/simple;
	bh=zYw/vdaimYA3Upb8KBVp137mIE1oGE0jaozGlgSCVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4IulDGE1HcPSKufmZGK3xgsSBICjtO3QRQ8c0dkqZKNzgyy5qiu8lNrjuxQ15uVh8c+s+p4ijQheF3f5oUU9+JAmdcyUoHEt+q2sM64j9AwQ7PmM6pFMfJ4srNE/YbCo03GcFfuZdaBJQpex0cvMbwVb0Dio/pw4WoZvXkZLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/tvx7Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392A5C4CEDD;
	Tue, 15 Apr 2025 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744716993;
	bh=zYw/vdaimYA3Upb8KBVp137mIE1oGE0jaozGlgSCVhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/tvx7Saipwh/ViZ0+Uk1eu4Rwsjf+uyzf29ONH8NM7k0rsVEfEL+c1HRH+VQ0UGN
	 vj6PT3VGxnmDFZ5xArv5HAchUrn2VH1v0Jf7a3hEYZk/kdQrk8hP0nCzaAbltw+n40
	 5wCyjpDQGBCNrnV4ttsHbkrOzt4LuclzMX1H6xrsVreWRgJ/huXeXiSj8TV5rtLSc7
	 2gKDsQhPc8VYFhshqdL5FdvVF9OB2Cdb04WkkUZnr0VQ4oVaWUXa+U23GHAtJ/UC4y
	 /vgY++g7AnXdDczUf5cBzR5mbxffO41Uljh4rudIDmI8qNz8h5zlScIdfDu3PfXLKn
	 Q2ZNF8vFDNvKg==
Date: Tue, 15 Apr 2025 12:36:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ASoC: qcom: qdsp6: Set error code in
 q6usb_hw_params()
Message-ID: <78caae4a-03d1-4992-9a06-1e2a9aef81ce@sirena.org.uk>
References: <Z_442PWaMVoZcbbU@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EtkMv+Yd9poVtEEu"
Content-Disposition: inline
In-Reply-To: <Z_442PWaMVoZcbbU@stanley.mountain>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--EtkMv+Yd9poVtEEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 01:45:44PM +0300, Dan Carpenter wrote:
> Propagate the error code if q6afe_port_get_from_id() fails.  Don't
> return success.

Acked-by: Mark Brown <broonie@kernel.org>

--EtkMv+Yd9poVtEEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf+RLsACgkQJNaLcl1U
h9AXdgf+IwDP2ZCdt/nG4LuHCXIKTYeSCPzb7phKoetBsQzxgY060qKGTzb+hP2m
B4b2qLp/anvUI4vm4PJItrJTZ0TI6jMcRR1KeLp+GAZajhpdvPgDChKSeR+OxPAT
ksup73zUE8UcU/qCuBTod0S8ltsdFGuR92j2Vs+pU9j9wGkggpzUDMb4frP4TdzA
st/81o2uODDR60IcxRXPEcnX042EG7ZYvi1d33HUL2qZ48BbFJ8iVaq4uhu4xTaK
KLjhfojUmIjfQgZ9FGvHkvrH3sXYXAKfxNyCapNB6gMe7Lh+QrXNYg5SOicp0FFw
AW28j3oUVgszTzdoOopsnO54fKDNew==
=A9o9
-----END PGP SIGNATURE-----

--EtkMv+Yd9poVtEEu--

