Return-Path: <linux-kernel+bounces-847408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3DBCAC14
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAFD04E0666
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598322638BF;
	Thu,  9 Oct 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfyCDari"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123A26159E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040587; cv=none; b=fSQjNcmkODhez3840//P1tL+rQV3mHLFOOaZVWUXkzSlDVAC7ygvT1lQ0dkKmUf0kxea5yPNnUTQYx7G6ZY1bPOo8pA+oXUJ8fNK8ztv7krv4SRWWOaFl/snLHF6wXf1GHzTa9xGMf3OS1vCoXhLcJXzI5N4DjzMTf7EuSEawok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040587; c=relaxed/simple;
	bh=YpM7f2AlYfeNrk/FXsfKdNh/0ocylryEsJVj0mQ6sAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=hPMqP4e3j4JZ9TSi2dmsxJFI6GuDV5AHZYos7Q+OhSwpthwL3GseBtiDchbvce8+iDvE9UCAyrKEtlDr/WSrqkuv8Vc5wo2cUD0g/qU0gAhWd+Pd4lM2wZAOPeoV3QJukw96nfDEBtrdMR7lcU0iihJy+DKnQmrpTNkkZ125SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfyCDari; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA4CC4CEE7;
	Thu,  9 Oct 2025 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760040587;
	bh=YpM7f2AlYfeNrk/FXsfKdNh/0ocylryEsJVj0mQ6sAE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=jfyCDariiNtG4Mqtxt7MwAqyAC3lb4kqQ6eRDk5MCrWno0Zk9zEF7A1Pl9wvCsFPT
	 XQUw7nE1Ft9umT7IISl/owHkaHS5EtWeglbvfzMNjuuz/gCKYS7IZa7NXOtXgSOJ9o
	 lK7eh7iXQ1dqKR782fSypHMWRRB+pyyu4ICRwGCNE32uvd3cJPafqwNwGiPqvXJubZ
	 +Jn7JwOp85GNZ5QcGBlYyikmhrGdq7IK1vcTnyIktc5pebcTz05OxRcvG+ecHKAocv
	 v5eRgkKJ+gqWrmYFnIvxij0jMTM5uoEmjzlh67THMZl0tW6UXY0hPqX45LPS3U/wV3
	 hv91ume/dFsoQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 22:09:42 +0200
Message-Id: <DDE2BDLEZHBW.253EO66P7ZH2P@kernel.org>
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Mary
 Guillemard" <mary@mary.zone>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com>
 <DDBISJ2DUDF6.150HCB14ZRPH3@kernel.org>
 <CAA+WOBvu2Gq=SM2TBdahsQ-RVi+vn_U-oDa7-DG6kj9Arq5tpA@mail.gmail.com>
In-Reply-To: <CAA+WOBvu2Gq=SM2TBdahsQ-RVi+vn_U-oDa7-DG6kj9Arq5tpA@mail.gmail.com>

On Thu Oct 9, 2025 at 6:51 PM CEST, Mohamed Ahmed wrote:
>> Let's move the call to select_page_shift() into op_map_prepare().
>
> How would this work? Originally when we were working on this, we did
> place it in op_map_prepare() but we ran into the issue where
> nouveau_uvmm_vmm_put() needed the page_shift retrieved (see
> nouveau_uvmm_sm_prepare_unwind()).

-			ret =3D op_map_prepare(uvmm, &new->map, &op->map, args, PAGE_SHIFT);
+			ret =3D op_map_prepare(uvmm, &new->map, &op->map, args,
+					     select_page_shift(uvmm, &op->map));

You can move this call to select_page_shift() into op_map_prepare(), that's=
 not
related to nouveau_uvmm_sm_prepare_unwind(), right?

