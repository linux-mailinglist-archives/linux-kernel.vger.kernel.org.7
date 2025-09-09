Return-Path: <linux-kernel+bounces-808757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84EB5045E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133294E343E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA0352FEC;
	Tue,  9 Sep 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD6dKDZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1731D392;
	Tue,  9 Sep 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438566; cv=none; b=hCGhQtWMZT31lG7AggNHZP+94zTGyb6J2g50QC3aWzfmNnKffNZTgA/ifhHEjtAHr2IM9kzx4tg3nGrrIe3W74kgP9bfRolKp2nRCBe5mdhNzgWGB9ue/kIvI8Rzq4An9Yy2h2AB61PJvjbTjklMx1Wb/SpMlRKm1KxY+2J2JOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438566; c=relaxed/simple;
	bh=KPoGmbgwfHdajiS3bTffjxX/R3oDVN1hzDCGybFXOhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQWK1MJRRPH+9fBsPlfbMA0ePrTnQGZGW0vkNPeP75Oh+CQVgnvh98THvV4pMLUNMHqe9AWgz8lTtMWgFu0s+zkBJbJ0C2MEDhHRWer8G7JCXAhyySNin+oYtW/V5OOtqwcj0oEUnZlJPTroBN50a6cn1umTT1nMpsuSogVvXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD6dKDZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1624BC4CEF4;
	Tue,  9 Sep 2025 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757438566;
	bh=KPoGmbgwfHdajiS3bTffjxX/R3oDVN1hzDCGybFXOhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD6dKDZHLlhdLyUOqC+FvDJx99o7FaY9qjkfHQM6/kxXML6ocWFgR8vCkbmfEYgC4
	 fHaMOSidi0o5drt/EfgIe3f0bXDqmYbbzdzPC+LQRpUq8cgCi94MDiwfETdMDPJCOw
	 1Jh12/qzWzX0zWR1018mgIvBDg7MNcUcjyYqr94KJ7cVzdu6K9vB65+bqaLpX2ETHK
	 d3I0KXl0Z++/IDvuxjX+SSEr+nrsV+sZ86KMqHNZwdoYg/+ycqcZp6p6fRn9rgtcjc
	 8WWigibb4pN5i0RCqPB4lefi13yWGlJDxinKTOrrO1VGCEV3q+NG5D3ONYV7gFn6vw
	 HVXeufikDBKXA==
Date: Tue, 9 Sep 2025 12:22:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] dt-bindings: dp-connector: describe separate DP and AUX
 lines
Message-ID: <175743856267.3386260.18336332502383778879.robh@kernel.org>
References: <20250907-dp-conenctor-sbu-v1-1-de79c0fcd64d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907-dp-conenctor-sbu-v1-1-de79c0fcd64d@oss.qualcomm.com>


On Sun, 07 Sep 2025 00:48:52 +0300, Dmitry Baryshkov wrote:
> In some cases it's reasonable to describe DP lanes and AUX signal lines
> separately in the DT. One of the typical reasons is if the source of DP
> signals can support either USB-C or DP connections. In such a case the
> transmitter of DP signals have separate ports: one for SS lanes and
> another one for SBU / AUX signals.
> 
> Instead of leaving AUX signals from the controller unconnected, add an
> option to the DT schema to AUX signal lines separately from the main
> link lanes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/display/connector/dp-connector.yaml   | 52 +++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 

Applied, thanks!


