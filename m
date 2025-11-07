Return-Path: <linux-kernel+bounces-890051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAAC3F26C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2304E5541
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24392F6574;
	Fri,  7 Nov 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r4SGVRuo"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177832E229C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507606; cv=none; b=JAlMVUb7+ulNsippEl0ds68gadytWj7mauq29K/mrxaiPiA3dgsWZMvgLhJoANxQeEPsD1BoFcvsWkIzYg+7JoJtasHl3WOjcrsUc1f1IpiIXpn2a8AThQLakRQanqSDW0tmHf6WxEvUEJkWTjMgS3t49OquNqMtZr7BDltJisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507606; c=relaxed/simple;
	bh=td4OKSYMD80/z5WJCXT8z7xuBhE5BGfq1N4Usl4rLM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZBlc56GZ5LVyHJmuejoBtzIN2maMZv8mmtkDHnaM8Zg7TFtjArRZwWTqiJDgcbBVAZakqJ6q9zhX5Eykd+awmnI/L0gBzDtZhP5fikSHohhnPZCagQwIwOnXHL1IFRqKnP+XDj2rf1CExPgIs8VsPT0W5Idi7todFkhzd1Iy2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r4SGVRuo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5A0EA1A1919
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:26:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F644606A6;
	Fri,  7 Nov 2025 09:26:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 481BE11852005;
	Fri,  7 Nov 2025 10:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762507600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=td4OKSYMD80/z5WJCXT8z7xuBhE5BGfq1N4Usl4rLM8=;
	b=r4SGVRuoH670ND8c+kXKTh+Nz8yJs0+6vACVEdgp9LXVs6s48GuylO/0RLlBkzW3wO3O0b
	dR7BXWi+CBkT/k1yc/iM7UTCVpgnxabyhzopk54Yvceg1mfrrlQnScsY5RCmw46+3o80Gp
	VWrkELoH+77Ti+WcZW0/hDwALD5xBRyvLRlKID87+1miwJIOfGd3OF75PWCCD5qzhSAqSS
	tSBuULlBPJbceOEvVIpeI+ptxqIgUWpkhAt26uyEbzIVpC0J8qIfv8nrzaL6lGoZUDjjHc
	1XQ+fOhJRiprJM/p4/s6Z6WxvK5eMzhKTrOH/bIjEwlS9Z7DgFE7xSRdxkBqDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Nov 2025 10:26:39 +0100
Message-Id: <DE2CSTCHSWJS.2QKAHZ1K808VX@bootlin.com>
Cc: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dapm-graph: Handle sourd card with space in name
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Yiwei Lin" <s921975628@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251106165802.3780-1-s921975628@gmail.com>
In-Reply-To: <20251106165802.3780-1-s921975628@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Yiwei,

On Thu Nov 6, 2025 at 5:58 PM CET, Yiwei Lin wrote:
> When the name of the sound card has a space between, the
> script will fail to output the dot file. Consider the
> case to generate it correctly.
>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>

Thanks for your patch!

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

