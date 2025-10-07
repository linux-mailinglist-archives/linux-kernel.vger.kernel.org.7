Return-Path: <linux-kernel+bounces-844192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE20BC1431
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13100189D0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CB2DAFDE;
	Tue,  7 Oct 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvqTm3mR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66135972;
	Tue,  7 Oct 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837926; cv=none; b=RFwGXjDx8wZKK0mgE5z7+QjJqeUiffwlumjng7X+bTRxNnHVd5b87FNo60v93o/5xMVI4HGvVEMs519R8ksobvpOSLqI/f6GuQi8+gcJl3IkDzjivWDRF3YJCZKL61u0XOIu2g7QhMTQxrfJ0KnNvG7yz00+WHLVAy2/5VLtP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837926; c=relaxed/simple;
	bh=fv8kYW58rqJ/7JUDI8cM3BH+XF8NQaOUEMNYw5kqOaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpCj1mc7sc6Sdaqrm/DYooI9H+5ZeY8OTIPqUf9q6zBhX5jQJrfgeTmOjul+bbUJdBCY2X/pQRSma7y74SKZXT7New/TCiLwye3CxoaDzpVMyb8zsG6dP+inEqBz8eEp26V/faLMkX7e5S3X5uq88PNRhIRFtsrRPXkJh53KuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvqTm3mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A2C4CEF1;
	Tue,  7 Oct 2025 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759837924;
	bh=fv8kYW58rqJ/7JUDI8cM3BH+XF8NQaOUEMNYw5kqOaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvqTm3mR1ZXXgE53N8SjqB1xkuqqoIZ7o+zDvkGaWFvHADCgA0b6h5mxAGfjIJGqR
	 6borTvrSnb+k1cB9g237RkElDPaNAONAhYFPpZnOW68MQ3yY6i3O4m/FKEmZHmdvhX
	 RlKPY/yQl/I3GDGEDSTnmEMruCENPloB6whwwStOQIji+h0if63kisZKqqZTAOPRtG
	 uVWUBewNl99ThZpmreb0QP0ZKCC2I7D0v6wwVarxis0IpTJPNlIAyQyZUOXOehus11
	 h9nQ0DOvKokVq4a9fJixwXg1bPvTl/uz8yPmKpEvGPvwwDbGtLYRRRv/94fVHqj0Ll
	 Zay+e2NuiXSWQ==
Date: Tue, 7 Oct 2025 12:52:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <3266559a-8403-4a26-bbd9-c54e27fc59f8@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <20251007113305.1337-1-briansune@gmail.com>
 <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
 <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tuc+nuWIUH+Rsy0n"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
X-Cookie: Teachers have class.


--tuc+nuWIUH+Rsy0n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 07:48:11PM +0800, Sune Brian wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:44=E5=AF=AB=E9=81=93=EF=BC=9A

> > Please don't send new patches in reply to old patches or serieses, this
> > makes it harder for both people and tools to understand what is going
> > on - it can bury things in mailboxes and make it difficult to keep track
> > of what current patches are, both for the new patches and the old ones.

> Sorry for this action. But this patch is just a title fixe according
> to previous comment.
> Patch body is fully aligned to previous revision.

> May I know what is the proper way to amend the title?

The title is fine, the above is about sending the patch as a reply.

--tuc+nuWIUH+Rsy0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjk/t8ACgkQJNaLcl1U
h9BsxAf/XP1ZR+bUWjpFwtoI6mROs5sSEg4IIgyws4hfX3CvMjCP3Rem5o05jQgI
mz8mtnxBwGk77SjYYM2nBQiTtClSjGWO4y5HQMV2hsYcLWPf1PY5Z4Lw9R9vOqyR
YkNUWsKDhaqcXb0csyfafvUO4pZ6grIKc36r/tGw+twSluy2fqJuwpcuACVrXiSu
aX3Je5vpY3xjyB6DrVOhAYMJ6KX4J5nfFFOvyZdbFhIm8fb2lW97Jrt8MCtoeJ58
28xKQsA8kFDKYsXW/+uJg2bb7kvUgO+6oJ8uaimjx58fL3m1kV56A90TzfGYuanG
wksblhBUcbVDizmsurVJhTUSQX9EuA==
=/svS
-----END PGP SIGNATURE-----

--tuc+nuWIUH+Rsy0n--

