Return-Path: <linux-kernel+bounces-875531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F7C1922C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 803CC3551A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AA313277;
	Wed, 29 Oct 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv9o0zfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4E15855E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727437; cv=none; b=Yp1HJFp5AFYSQbqXGNZPt5NLKqJdSfpEEFpTX0kwerbYN3pbTnx7GZ69HYXJNKt48qgTa96S7QmxLRf4uazWFIpTDv4lrDioZlRQMmCTK6PzYzMWePTN6h6vMSXe7Dnwm5Z/VN4izubIv6mKN+6/3TKgPiRLnMosIEGE6CyMmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727437; c=relaxed/simple;
	bh=ONMwA4zKSeuT5luKodY68l2KloetemK0znnfCIwveUM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=NBVpm+QlbQeqb7qVj15nyyvEmGdlooWKadBPNmDyWv+DPttmdpap5Nf5FyhLrCAZ9v0mO7DrJdYkuXX16JFyk9HBFPAJq5IZsvb0TGypOGJcNV5OsvKjFurzdIhaa04XSHZRGXrDXCTAzb98xADJbjYTsqVw4JuttJh/QpjSRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv9o0zfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759D2C4CEF7;
	Wed, 29 Oct 2025 08:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727437;
	bh=ONMwA4zKSeuT5luKodY68l2KloetemK0znnfCIwveUM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Bv9o0zfGTgirAcTG6e5kzLH4DInJgVwZS2kx6TGbc+8HGmbwETzq64y2Zq3RP3uqR
	 wRHuEGDAlrqJ/Gln8L3YFwAp1oSpu1b98vJuUgN/Ok/WggqLTpNLKE7wGTX22MxCJo
	 Q62kqivuVJqOYGTX5upobvky1vMLBsu24WfhXXIj6BdsaLc+s95ewPqQXmgXl/A5BU
	 4+ilz6KSiEWjivo11kiWUinFJp/OZOOrwQz/016b5xzLWfwQjeOksLRi1YESZxusnL
	 pmoY5KdyveteRdPaZwP+cNxRaNCckN+kPCh4rJjbtr90peNIH1jAO3uZFtcjhb2r3c
	 ZE7O3W/F4EwjA==
Message-ID: <1776f9d77b2c670c77fc52ae73b22d58@kernel.org>
Date: Wed, 29 Oct 2025 08:43:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 4/6] drm/bridge: add warning for bridges attached
 without being added
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-4-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-4-bb8611acbbfb@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Alain
 Volmat" <alain.volmat@foss.st.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Andy
 Yan" <andy.yan@rock-chips.com>, "David Airlie" <airlied@gmail.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 28 Oct 2025 11:15:45 +0100, Luca Ceresoli wrote:
> DRM bridges must be added before they are attached. Add a warning to catch
> violations.
>=20
> The warning is based on the bridge not being part of any list, so it will
> trigger if the bridge is being attached without ever having been added.
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

