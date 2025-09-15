Return-Path: <linux-kernel+bounces-817769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DEB5864C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158094C4032
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4F296BDA;
	Mon, 15 Sep 2025 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNUwUXWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA92E63C;
	Mon, 15 Sep 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970236; cv=none; b=W4RVrnMViKfLQq9ENuPK3ip14yW21ul2lAjuFIGOAp1wb3PNGiPo8AxtOxrrmgIAl+qQkqUTl/iEk97+61BUWtb3TejpUcHc3e+wYS++m7gSF1FhwHKPJAMQKHbc4RdV16kg/SfWtdJuDROExzoYyrw/+l/pxBPYdKbDsRwsnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970236; c=relaxed/simple;
	bh=Vl/2UwRLWIc2Twy5cb1SCnv2Oc2q927fYGWoOEiYOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK0I85g9JnwVmlfibrf1BgpaWB7qdfoz8JDNftAzn0LcUlUdu0lX9k9MqBPBLXqf4G9x63cBsKM8177qrgu6PG/sPHkhwNogMtkZ5RWJFqjj/o1bzrXMH9HXsZ13Lcj7qPDSlgXhyu/Iex0KlVM5/WnrJCbhDV+KhBme/FRYyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNUwUXWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52755C4CEF1;
	Mon, 15 Sep 2025 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757970235;
	bh=Vl/2UwRLWIc2Twy5cb1SCnv2Oc2q927fYGWoOEiYOFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNUwUXWBkEU+iT8i7OJG5Z9hBVnQU1tG9eDMvQdeBXCSvX2cd7DsfED8lc6m7LuHz
	 fnSXgMVKG5BodyB+x6YT2qAD/BopRjeYal7uOjK3X/5F16OseQ5hGqLsO5P3IVqJT4
	 Pz+kkBIjJxl3+epvZiKwJD6a2ko6YwDYLjF4DZZ9GmNFII1M3ikF8SamApq1dhuVwl
	 2atQeXv3m5yP6Y1QJn9hbKdcf2sd6ZZ3uPfXAEjdVOb4maSVfFPhWOTzvdmI9AZM6O
	 xUNb07x1xErY/bqsKYWZ1biCdljZXY+n8VgVsL5SJPvj4Z8rHidP6xd5wViAMjR4ZR
	 rYUgd7Yumi/ug==
Date: Mon, 15 Sep 2025 16:03:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: document Sharp
 LQ079L1SX01 panel
Message-ID: <175797023343.3389573.3144162099437423417.robh@kernel.org>
References: <20250912064253.26346-1-clamor95@gmail.com>
 <20250912064253.26346-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912064253.26346-2-clamor95@gmail.com>


On Fri, 12 Sep 2025 09:42:52 +0300, Svyatoslav Ryhel wrote:
> Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/panel/sharp,lq079l1sx01.yaml      | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


