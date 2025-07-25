Return-Path: <linux-kernel+bounces-745791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66821B11EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E149AE20A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAF2ECD38;
	Fri, 25 Jul 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1fcYiMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B223F405;
	Fri, 25 Jul 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447254; cv=none; b=kqqtPt/0TCXyF4LkYdQIAMYivLQyWze4dT6HzhupRtfnh2cv2e/8sXs1F4TzDeBvEB0dmJKYAec3RA8xBmbKO5Pjk0er5FqcW2WzTo1Y3kyfEMzb97X9TpW8Kw6lD8lUNm4ZOTvZHc4tiDK1hwt6tB8tsxLp0h84XZzLWNHi8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447254; c=relaxed/simple;
	bh=ul0VilOygFhHxm/w/hJSXqTGHl6fL3d19lOA7ea522w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc8Yb1ErRijd7MqOHxAee4G3tPA1YJpdgK8Y2m6bl7fg2eZP6jKbtQlOJAB1ZAX/H5TY8FGL86nBwCAv1duv1JT4KdFh/UdscO/4kOkqAz6s3oxXiT7QwwUsH7lrdxkNmvL8ULTnuOGe/4y1266hkI92jZ2z+19GGA8iI97odPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1fcYiMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D74C4CEE7;
	Fri, 25 Jul 2025 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447253;
	bh=ul0VilOygFhHxm/w/hJSXqTGHl6fL3d19lOA7ea522w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1fcYiMWd8UUMjYMHJ3sJBs+IUVbrWMxopVygBl5CX/gm0Wa50pdhv3FJLSqDSKg9
	 urP2AjiRhmG2i9UyQaXgjsgH9FogZb0TX6nv7eVCKmHP2DN4qizqq0YdTMzFLr0Zck
	 oF0WSwhgbH1FsIE5SLaDPc5CPnYxcpeE/WMfbqSg84op1AOr5gwHEjn7CPnUo8jZPw
	 Uu8emJAcqxMUXSHP0dzocbcUut5ptAjsyakhN61JxTkrhDWnYKCJUgBNJ02Oe79nPt
	 kBOtRPvWxOihVBZOwFF/pUPOZ3MosAc/yuUA5JYBcCrCuCQeCUgrosbXIAKvoMO1CW
	 BKYSoYx1RIXCw==
Date: Fri, 25 Jul 2025 13:40:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Joris Verhaegen <verhaegen@google.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@android.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, linux-arm-msm@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] ALSA: compress_offload: Add 64-bit safe timestamp
 API
Message-ID: <aIN7Szen6rTj9iED@finisterre.sirena.org.uk>
References: <20250725114249.2086974-1-verhaegen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZMKo0FCzsB8T8s1S"
Content-Disposition: inline
In-Reply-To: <20250725114249.2086974-1-verhaegen@google.com>
X-Cookie: Do not cut switchbacks.


--ZMKo0FCzsB8T8s1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2025 at 12:42:42PM +0100, Joris Verhaegen wrote:
> The current compress offload timestamping API relies on struct
> snd_compr_tstamp, whose cumulative counters like copied_total are
> defined as __u32. On long-running high-resolution audio streams, these
> 32-bit counters can overflow, causing incorrect availability
> calculations.

Acked-by: Mark Brown <broonie@kernel.org>

--ZMKo0FCzsB8T8s1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiDe0oACgkQJNaLcl1U
h9C9gQf/UjGFlwyQlpmpgnGs/Pd4tXQxorttfUMXCyxLLSNovO5hc+4e/OdRD26t
+BeqXAszotkOyV5zn8Xnclb0wTMBFWYtQdP3bJzE2Gev5xwQzYqDTFToBnj1kRlM
CI0wM+dY2bjygZf7LeOr3vxnPcbPrF98aTDHqPJqjdYIkTNoQ7q7sqlqA3iaY2UT
Slu/dqPRWxbd760lKl6PKli8jtNofmBsi1uf/YZDGnA6PJtgvQYRRbaPdzsXoFHr
Pfe0aEtz7R4rGSuCCSwmAwdzpf488LM18F/NYQ8CwWnBilsUNP6yEev8z8qBmHrb
fXraSLkoQFLKBardB7hKfyuaMhwx9Q==
=G4VO
-----END PGP SIGNATURE-----

--ZMKo0FCzsB8T8s1S--

