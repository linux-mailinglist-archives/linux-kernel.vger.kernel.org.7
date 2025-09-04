Return-Path: <linux-kernel+bounces-801528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC5B4463F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77431C27BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CB26E6E1;
	Thu,  4 Sep 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAQ/matM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEB33997;
	Thu,  4 Sep 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013428; cv=none; b=VPffcZXESrNmFAotMR2mImE9l6lUHgDzDwlg6xVoEsE6f96PH++N31zWzbNQQERx9ILdIs7Nb4Vt4nD4NOqDTEAk+HzAfT6g9lB8R3anVNkV1uhj3PYiN/6avseNcH5pnq8XLEV/3sAVPM874wCy1Mjui3qp0kuJtdh1bQEToR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013428; c=relaxed/simple;
	bh=4cyZJK5eWDP/Os6zTLIOjZf3POA/Dw2ry2+a0/RupNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZLFXJosNutpLjFELQQ5LajhVDMkk7iHrxj8Xyn6LbN+sKIPDfewxEfoXlLIwUTg3Jyvd3Fi313HlU9Ez7S4/p7HWHiWxrdxbTqrbIY5VzcHlvJFzQIvt6eEiRUj/Iod5RJwbgA6U5mSIv4zJYHT7m2QtWLxWBaDYxZzAvB8JQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAQ/matM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A5C4CEF0;
	Thu,  4 Sep 2025 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757013428;
	bh=4cyZJK5eWDP/Os6zTLIOjZf3POA/Dw2ry2+a0/RupNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAQ/matM+PqMMACKj9h7Bzj61ss27I49ThmK0YjHCe39lYfGQ4bTj/nu3jK2yREMt
	 f0DhoPVqOlFzQ/EhJaQM4pQ8pVn9wfMNHSooHmMXZ55RRgmVxLwZZSGEvYhrpmbpX7
	 NS//yBebW+8myAVveojmau8n8ZCLinNGb14vsSzsHmsDvThT/kbVElT7kW1dYarhaU
	 uhBuEWdKiC57zM7jfYPh+LmA8LMQm4BuDO/A4Q91offvA8G4S8HiUWusqDfc/I6CX5
	 +n8vyQcXDLFtsaXzi0cL7HpoEnVs9vHzzor103Thyfh13/RfZj3LdJiGfb/v56z7lf
	 lr99Pg4HaF4bA==
Date: Thu, 4 Sep 2025 20:17:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add compatible for
 STARRY xr109ai2t
Message-ID: <20250904-utopia-boggle-3d26664bbbf0@spud>
References: <20250904002232.322218-1-vovchkir@gmail.com>
 <20250904002232.322218-2-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sAVWlh9d1DjThvII"
Content-Disposition: inline
In-Reply-To: <20250904002232.322218-2-vovchkir@gmail.com>


--sAVWlh9d1DjThvII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--sAVWlh9d1DjThvII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLnlrwAKCRB4tDGHoIJi
0tUnAP9L1WfnoP9hrgMwAnX4lKp7VleNEjUU2M4rmDu17AJbeAD+IFdcN7Kru1QB
/l0Hp/v6QSwcBhJgRdTsZPjmhKxNFwg=
=KRbg
-----END PGP SIGNATURE-----

--sAVWlh9d1DjThvII--

