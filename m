Return-Path: <linux-kernel+bounces-871706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E226C0E20C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A4A18987C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883BD274FE8;
	Mon, 27 Oct 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXFmk6M9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B641D5151;
	Mon, 27 Oct 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572209; cv=none; b=jO1ASytNDmVmndb+PzHDNOkKaQIYz2Jaxug/s4vxNnMUQuukLQqJ0k2mWGvoFMZ/BgNg1f0ugLOf8B+dyVLxmOyxmvP2E49T6GyM1lqOHWmzR+0gwHDQDGDBds2GSk779TCcHgg4lAypTYk4w4b/ldn57CREX/+fPGAmBofRF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572209; c=relaxed/simple;
	bh=GY/aL2AMd0H3eUL8uupIyL85eFW25cFDmkyRed3//1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unhkFqbl/qUJ76lmqK228+q2bTjR21qG5sHAAaSnl9Hq3OpwlbXH/l4MtPKleDtHFIugxFEqdKDMT2q066p8E1xwRas9EaZt8HGeH9ZQ+64OhjW9Sie1g9Dkk1u3Si0rCiT3pV01Fz39zNQyHOaFr0f4T/ndStbrqEQ6BA5JqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXFmk6M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7D0C4CEF1;
	Mon, 27 Oct 2025 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572207;
	bh=GY/aL2AMd0H3eUL8uupIyL85eFW25cFDmkyRed3//1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXFmk6M9lLvDV7HCzeNoS9jNleVWkInzV6Qgo+oLrGiYl74g7CS/7xZaFm8NZ2xXk
	 xoLNIf8/uKJwtKKScYkc+pXJx3BdX8txLtv2taSHsUWLW+GfHXtpgtpNkQWseuc6AU
	 PCLO9QrjPBVBISy6+ouKzYa+sR02/SCC9nEPWgY4iDG7VLGUDvcW3ax8GXyN16Gmnz
	 JSAxaeFHuPh+BXgWHyexxFNsG99gLbSn+sygaXO565Sv4EdOBwsvvYIIHyqtB4PaET
	 b3fAc8ftulXe55pClawDKlvoF9yhGV+aPhoxN55prclePimbVIU9QWIoSYPDVoJ3Zc
	 XiGZMgJc3Ftnw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNP1-000000000J0-1NJ5;
	Mon, 27 Oct 2025 14:36:51 +0100
Date: Mon, 27 Oct 2025 14:36:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/imx: drop unused module aliases
Message-ID: <aP91c2uZN7fBxtAv@hovoldconsulting.com>
References: <20250924092643.26113-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924092643.26113-1-johan@kernel.org>

On Wed, Sep 24, 2025 at 11:26:39AM +0200, Johan Hovold wrote:
> When fixing up a device reference leak in the tve drivers I noticed it
> had an unused platform alias. This series drops unused aliases from the
> imx drm drivers.

Can these be picked up for 6.19?

Johan

