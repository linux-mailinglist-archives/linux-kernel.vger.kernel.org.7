Return-Path: <linux-kernel+bounces-805181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24782B48500
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FFC3C1EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8122E5D2A;
	Mon,  8 Sep 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D8vJzJvK"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA28298CD5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316115; cv=none; b=jnfL6B9/f0IvZuNKgYfMeU33LVColxdx3gx9t50m3Lm6UhCDNT4pFwESyJwl3anfJZQzUAtTdzmdArtKU588BSOX+UNxe0ZC+WCmXArQZDAnbkD38vjuHeTT/1YoXfnf8DtkUi+nLFfz1MvCE9E2+tMh6I7953DFTdhzx+RMSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316115; c=relaxed/simple;
	bh=sydoGYYBrWq/YA+9ysgHv8l73WXm2B/eim2nQHNNGNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0z1YyMeN+TFncmQOQrqjhyC4Ftufpx4NrqLMlh+03N0ks2jSQx2mSzhbevzET+WttiArbWkbnBsZWppBrlP+e6DsIEyvyvfTScbRc5zrNWNFmkd52PVB+WQm6qPgPf8Uwe2eTMpe0wPIHvjmSveJ+XxhMnjEngD2TaQAmXMgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D8vJzJvK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E21CA4E40C5B;
	Mon,  8 Sep 2025 07:21:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EC9D6061A;
	Mon,  8 Sep 2025 07:21:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76E3C102F287D;
	Mon,  8 Sep 2025 09:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757316102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UFbPuS3hzmJpKbl+CTamAVLKJpGuiE0FtQwoUF1Gh3w=;
	b=D8vJzJvK/ysAMWSjxGWa9z6JX7mFlll9Uz4aqe3ECq93Uz1wfREJetUHBUPZgBJ55RCS/J
	x2/BIH86UACVHflCaFFjAFD3YBiEsiL4qPUi8twaBN71IIyq3WDkjfXv7/T5nspGnD8MEE
	5qaxbanDwnOgANriZH9eyCXzGQUuVS8gt4+A9Z/EerZcfXfLJ1jOnC+iV0e/Yn18qg3+29
	TjV1P/VwtNItRr5VZyKTa2kgCkN2A014Tic010poaiPBnJpO+sULpEvyr1QFxOdVsp7vIW
	55vlm/Y1W5PtJ5t/mfJ8aOWDwLkeBtK1PyuM2THdDgPzvq2aKo/rxFUctvddXA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rahul Kumar <rk0006818@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kernel-mentees@lists.linux.dev,
  skhan@linuxfoundation.org,  Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
In-Reply-To: <20250908070124.2647038-1-rk0006818@gmail.com> (Rahul Kumar's
	message of "Mon, 8 Sep 2025 12:31:24 +0530")
References: <20250908070124.2647038-1-rk0006818@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 08 Sep 2025 09:21:22 +0200
Message-ID: <87tt1djtot.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Rahul,

On 08/09/2025 at 12:31:24 +0530, Rahul Kumar <rk0006818@gmail.com> wrote:

> Replace strncpy with memcpy in sm_attr_show and explicitly add a NUL
> terminator after the copy. Also update the return value to reflect the
> extra byte written for the terminator. This aligns with current kernel
> best practices as strncpy is deprecated for such use, as explained in
> Documentation/process/deprecated.rst.

The doc states "strscpy" as a replacement, not memcpy.

> No functional change, only cleanup for consistency.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> ---
> Changes in v1:
> - Update return value to match the extra NUL written.
> Link to v1: https://lore.kernel.org/all/mafs0ms7bvcd2.fsf@kernel.org/T/#t
> ---
>  drivers/mtd/sm_ftl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
> index d28d4f1790f5..3c5d6d0c728f 100644
> --- a/drivers/mtd/sm_ftl.c
> +++ b/drivers/mtd/sm_ftl.c
> @@ -44,8 +44,9 @@ static ssize_t sm_attr_show(struct device *dev, struct =
device_attribute *attr,
>  	struct sm_sysfs_attribute *sm_attr =3D
>  		container_of(attr, struct sm_sysfs_attribute, dev_attr);
>=20=20
> -	strncpy(buf, sm_attr->data, sm_attr->len);
> -	return sm_attr->len;
> +	memcpy(buf, sm_attr->data, sm_attr->len);
> +	buf[sm_attr->len] =3D '\0';
> +	return sm_attr->len + 1;

Are we sure the buffer is always sm_attr->len + 1 long?

Thanks,
Miqu=C3=A8l

