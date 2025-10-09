Return-Path: <linux-kernel+bounces-846739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11454BC8E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D231B4F6570
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6F2DE200;
	Thu,  9 Oct 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D1dYW+iF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351212C15A0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010353; cv=none; b=shDIpPqC6psbTQPoZfRSA5kyZ6q4KTdEDSb8w3ui4sCtzinl0V3oeKROIOFH/OEGErnFI8LxoVshD7kdo/flwpgez7jma3qYVNdU7Xrdv+qvX/jQdAPo5DzWHSKO133oeeHbBwX7ZYMsU0NY6dgsPsYlqzLMFR5Nc/X+0G9b0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010353; c=relaxed/simple;
	bh=ydT5M4LU+rhLL79QpjncBuMwrnRWUgqtMFqnfSJgBRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKbivuydYtt9qQcdA+hAqcJALf9Nkt2OlC3OiWkZFzkcWpn2dLNMzkUMqqHBZnlSgweW4FUfglOekUXyWxQ8l7vNTfKaeRZHrtgC32mXhwWkcD51CANWN2uN01I63x7fVDd6rNd+ueKO1RFHezo5fCdd4cys72P0MdlaojSzO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D1dYW+iF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760010349;
	bh=ydT5M4LU+rhLL79QpjncBuMwrnRWUgqtMFqnfSJgBRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D1dYW+iFyJHdB/WD4vXVwQlfkHSZtxoPucqlTsL3NmAsg/U+0MDRzaxpt+hkytQk0
	 i6JGmp5SurPLwdqlLCZgCmbimiplgLa0y+BgKtKJBNXXBD6B+laBPDTV9+6A3QbEi3
	 pq9tJNTiRQokJ6uICuzIPRTChCx5b1RFg0ZfmJWRXLEk5N6mlwENoB0Yf/KRJLONRv
	 IthPBSH9EYMqesv4Y2vNTFL/GJHLJg1xyfT+F+FRH64Ci0wHJVG0VN1UlhfmExplIQ
	 6pqSfz6y/W9MqmzWdkKaIReMNrzChuyHR690AfCAp1gPEQGNlbj1O/9VxiYrQRhPZX
	 hH8VbgLCMK1uA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00A5F17E1060;
	Thu,  9 Oct 2025 13:45:48 +0200 (CEST)
Date: Thu, 9 Oct 2025 13:45:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Ensure MCU is disabled on suspend
Message-ID: <20251009134544.4502df0d@fedora>
In-Reply-To: <d526aaed-b29d-4e19-aab4-aa735282055e@arm.com>
References: <20251008105112.4077015-1-ketil.johnsen@arm.com>
	<d526aaed-b29d-4e19-aab4-aa735282055e@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 11:29:14 +0100
Steven Price <steven.price@arm.com> wrote:

> On 08/10/2025 11:51, Ketil Johnsen wrote:
> > Currently the Panthor driver needs the GPU to be powered down
> > between suspend and resume. If this is not done, then the
> > MCU_CONTROL register will be preserved as AUTO, which again will
> > cause a premature FW boot on resume. The FW will go directly into
> > fatal state in this case.
> > 
> > This case needs to be handled as there is no guarantee that the
> > GPU will be powered down after the suspend callback on all platforms.
> > 
> > The fix is to call panthor_fw_stop() in "pre-reset" path to ensure
> > the MCU_CONTROL register is cleared (set DISABLE). This matches
> > well with the already existing call to panthor_fw_start() from the
> > "post-reset" path.
> > 
> > Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>  
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Do we need a Fixes tag? Or is this only actually an issue on newer GPUs?

I think it'd be good to have a Fixes tag, if it's known to be the right
thing to do after a HALT, even if it's not needed on the GPUs currently
supported by this driver.

