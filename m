Return-Path: <linux-kernel+bounces-771368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6FB28626
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394F5562709
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB521FF2D;
	Fri, 15 Aug 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="UA/T/cDr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/c8l/we"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D53AC22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285009; cv=none; b=hjZi+KiFeqUXHNFOWSWuPuHwZ5ay3hYSEU95tzXVfmUyPpQfdWJzuhiLqA6Dr48sp6LO1FssY7higjhpy30/+FAeRKVKAvp0L/O/8juiNi7KmSUquCnBeo+u2ZYxjm3hvEcO3h3wL59t2d+OC49e7GNHReJSHG8nc1vn3H041SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285009; c=relaxed/simple;
	bh=1Z49YMz+x+n56lOkQQ/u60ivtFYNwe1d2XNO3O2oNv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Fvucd0a9L56/H4uKqXCJY7aiUBn+6MZj9CttCVQ+euRzU7zw2m4KStKFNiO6bdkQub6sj2KJD4IBQtMC6tgZmxLllzEuH2k0Y0G+cmi3NMvl5DiCYxsoYc/aPXa0TZ4eyUEhwYp/6PBwtiEf5ffyp6+WA02nLys2Kd50jTL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=UA/T/cDr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/c8l/we; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 925861D00163;
	Fri, 15 Aug 2025 15:10:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Aug 2025 15:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755285004; x=1755371404; bh=pxqReNA3IJ
	xPqGu/JqgnXVBXDvCk2DK0nvhGmp1ZJk0=; b=UA/T/cDr37FNGYcnumZNpvv+Fr
	zs5o+Fjy0T3wZB47MCKqqT722eLqqoVMMt87pkd1yaQk8RIEuxGDwDK5hTvg5L1s
	vKgu9P4B18KP/zpYWPL8QcHn+W2rQo+4AjIlsJqlODt9RRDqKzfRLyc+C5LuznEo
	zkAkhuay2A6SiRJjWs8MKn0jJgltzNI90rGYLbTbn6yPycXZqQezzeetZqane3bN
	ueEScrNB0rHEfuKNbQmXBtKFBmlzyt6BeXn4Xk/V2Gx1gco9zjZI+l1bUF/GVRtZ
	TyZeeMBynH/uwFAQIDrSdkVpO5o59GiAYz00US3OXGcaixwWVge4EZ9i/vjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755285004; x=1755371404; bh=pxqReNA3IJxPqGu/JqgnXVBXDvCk2DK0nvh
	Gmp1ZJk0=; b=k/c8l/weSYcfQ2kSoCKN10TfzNlR80NjS4TI8BQTvvA+AdKGZSW
	oMLhtMVhAIb3tlrJQcWR6I6Nqy6bbsZnLjdbA9BYwTNtN8BK3N3DzmQuDd0Uwt3y
	dcHXYTAF5POXzm2xaPXOtJI2l5dHcZrQ5zClBzTpzfZMmPKb/PzNql5OBcuzDrVJ
	52qaLumEbASlXxvpD45nKb1ywJz+zJLAUFEorZDIEOsU358tMHj1ygtP3KnmjHQT
	gqxEP4CINY9XYTsu87iBvlJq9yNXZ7PgPTWD6+9T3WoikN0FoR9Zd3p4dZ7trAo4
	sTQDTj7/gvlsAw9QdRt3IXdznKRoz+oXZgg==
X-ME-Sender: <xms:C4afaAHz0o1AJntcPu4NAAs1fb_CQJoFL9eGrnqF_q3iAQGuiXVnrQ>
    <xme:C4afaFCWtj95hZ--dyMNw13bzkieXwpItHfoqmCzvfaMpE6nFzAnIS1OCwquaQH3r
    aA3E945HhAbCR81Tg>
X-ME-Received: <xmr:C4afaGnh_k2tAFij3Wf-FxysjqZHaTnkOtTbd6Zr9TRLyyEo17LiW12pW8yfpwH5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsre
    dttdejnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucggtffrrghtthgvrhhnpeevudejudeuffevveehjeehhfekheeuveeffeehgfetvd
    evtddulefgueeftdeijeenucffohhmrghinheptghrohhsvhhmrdguvghvpdhgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrmhhiuhguughinhhsrghmihdrmhgurdhkohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghmihdrmhgurdhkohesghhmrghilhdrtghomhdp
    rhgtphhtthhopeiguhgrnhiihhhuoheslhhinhhugidrrghlihgsrggsrgdrtghomhdprh
    gtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhsthesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C4afaLMn9GoeJtDXKfsopI2TE__gcZn4bjsehXeBcOvLhWbcUNElJg>
    <xmx:C4afaL8wppF0SIXBh9adbYXcdwRoVYzrME-bwfRi8pvDUOTDfs9F6A>
    <xmx:C4afaFHEYnnF9e16GxwymV8T6evy2ACCv7xLx0EUGRqnJ9kDddtFsQ>
    <xmx:C4afaChtjGbOCQjPYzgGCjwhDyTcPVGlF4weatp20UVOnHGCX1B58A>
    <xmx:DIafaJ6cBYMYp0drXd32cyl6r_N3_Wyc0SVZk3033H0KduIT7osMzQxR>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 15:10:03 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 20FAB13E30DE; Fri, 15 Aug 2025 21:09:52 +0200 (CEST)
Date: Fri, 15 Aug 2025 21:09:52 +0200
From: Alyssa Ross <hi@alyssa.is>
To: SamiUddinsami.md.ko@gmail.com
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sami Uddin <sami.md.ko@gmail.com>, regressions@lists.linux.dev
Subject: [REGRESSION] virtio: reject shm region if length is zero
Message-ID: <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4y3e2fzrotorljo"
Content-Disposition: inline
In-Reply-To: <20250511222153.2332-1-sami.md.ko@gmail.com>


--z4y3e2fzrotorljo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION] virtio: reject shm region if length is zero
MIME-Version: 1.0

On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.com wro=
te:
> From: Sami Uddin <sami.md.ko@gmail.com>
>
> Prevent usage of shared memory regions where the length is zero,
> as such configurations are not valid and may lead to unexpected behavior.
>
> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> ---
> v3:
> - Use idiomatic 'if (!region->len)' as suggested by reviewer
> v2:
> - Fixed coding style issue: added space after 'if' statement
>
>  include/linux/virtio_config.h | 2 ++
>  1 file changed, 2 insertions(+)

Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
no longer works.  The system is running wayland-proxy-virtwl[1] inside
a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
Wayland forwarding.

Since this change, wayland-proxy-virtwl crashes with the following log
message:

	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVAL, "D=
RM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")

I'm pretty confused by what this change was supposed to do in the first
place=E2=80=A6  Looking at how virtio_get_shm_region() is used in
virtio_gpu_init(), it's called with a pointer to zeroed memory, and then
the get_shm_region() implementation is supposed to write to the region,
without ever reading from it as far as I can tell.  Why is the initial
value of an out parameter being checked at all?  How does this prevent
using zero-length shared memory regions?

[1]: https://crosvm.dev/
[2]: https://github.com/talex5/wayland-proxy-virtwl

#regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367fac..b3e1d30c765b 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,6 +329,8 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>  			   struct virtio_shm_region *region, u8 id)
>  {
> +	if (!region->len)
> +		return false;
>  	if (!vdev->config->get_shm_region)
>  		return false;
>  	return vdev->config->get_shm_region(vdev, region, id);
> --
> 2.34.1
>

--z4y3e2fzrotorljo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaJ+F/gAKCRBbRZGEIw/w
onfOAQCEOi6uKxTF6PWuIIw9HkZxiJuKfBRHUz19kyO2nCIAPQEA73nNJQUuI9k/
ElbbTM8Hw1NFf1MjCOt5Pai14WqpIQM=
=F2x7
-----END PGP SIGNATURE-----

--z4y3e2fzrotorljo--

