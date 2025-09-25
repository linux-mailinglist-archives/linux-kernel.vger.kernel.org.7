Return-Path: <linux-kernel+bounces-833115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E819BBA1409
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D704C8574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257131D73C;
	Thu, 25 Sep 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCJScUX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6931D74E;
	Thu, 25 Sep 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829462; cv=none; b=hW6HAyCzXk0hkot/YlP8FOlTcvI9UoCixFyd9iD66LWHIkYnIePnooF334dAwG0W8Fik/3Dh9nDM0p2L/vNW1u6xQz4GMxRQ4fF+vGsdqcc+5JxjBVHWiZKT9utAAtYJKg3yBPBQD3Bl2cmzCHu5caoglVtdIQ8uHZ1/B+DaRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829462; c=relaxed/simple;
	bh=vghySfSa/y6MmaR36iNIrcLGg9onAQWW93s2ZzdWBcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHkzCmZhWvg3kNjFcc0mdll3Vx+wxCHbAa3ZqqjszETdu6eigX2u92WFFmlxrJxnXuSTCKwWgZ22k6WLtcpoDB0Pw0m/ZsnuNFMHmAID6YdiKmKXcopnjO1LVkiz3VnJg0d0j5uv6QV82JSkvnFGSAz4GNLyCRLligR54NUHMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCJScUX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE56C4CEF0;
	Thu, 25 Sep 2025 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758829462;
	bh=vghySfSa/y6MmaR36iNIrcLGg9onAQWW93s2ZzdWBcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCJScUX8tRRKdtU1+T/o5HRu9r4mTlVPo28Y31GGhsHjOn4qyghUbvQp4rBJ5rWQm
	 /6IBTCvOUyZXX9tD+WOzB5QropFX9bYYmotHKVN29cvZqS4Q8/tUugmMageWGoOFRg
	 QX6V841zzdHFSX9/m29YVP4Z9pQd4LCiMTflSj/oEs0DxXXkz29arXJGSkpRRroLNZ
	 +HzNy47DLWQfq4fdMYZeM0JeMkGosBEe9ybXqBxOIpaillHb2LvgRMlIRZR7TuHSW6
	 6wRUenwQukt4ftH8AyFBdLpXqvzO+cyiDzwSUcSEV1bVUE7B9XU356DtoIMbL8rFfA
	 wvdQS9w8xyo8w==
Date: Thu, 25 Sep 2025 20:44:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: hwmon: (lm75) allow interrupt for
 ti,tmp75
Message-ID: <20250925-granite-pawing-5ee4bb84efaa@spud>
References: <20250925192219.303825-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ONb/nGNj+fiW7Rs6"
Content-Disposition: inline
In-Reply-To: <20250925192219.303825-1-Frank.Li@nxp.com>


--ONb/nGNj+fiW7Rs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ONb/nGNj+fiW7Rs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWbkQAKCRB4tDGHoIJi
0pTzAQCvBS0NjKDWCSDBUuV4a+DVogdoM3u/jzfJdCkHyCal+wEAovVXjIDV7Hnd
rU9GBm+oCUQIJGsny6tl1+M6uvq8qAY=
=rdhU
-----END PGP SIGNATURE-----

--ONb/nGNj+fiW7Rs6--

