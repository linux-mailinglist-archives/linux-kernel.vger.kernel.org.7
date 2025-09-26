Return-Path: <linux-kernel+bounces-834272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EAFBA4514
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E31740302
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F81E25EB;
	Fri, 26 Sep 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bkVHthXZ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE838DE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898763; cv=none; b=fBdJMq9+w0WhnIa7oFTfk9qVv7tf/3b1CHeWdiUM3tcW5jkzQXUK6CPfTKXSxxwtjDJbv7vbGpCwoTU/gjLzUl/owVPzeRTJmGZW4tl9cCPQD6Oz0EKCEPBbswcamWLZdggoEF1UszpnxfZ2JT4PV0N4dcxDn4JEBH7RXVEvecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898763; c=relaxed/simple;
	bh=cpi+tktLDlympylmruyNUEDUWW5i2EItawMWgKbUj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1K/QVtow7y6qEj3niuffZsrXZdDJRnA8pXJfHgEtAglXyfp+jwrR8zSFT1aXXNXtXADcHGHfQ0ThKBAd/WkxgwDtPfWcepzidhGkzj12ZpNKV9ggktK7/1LnW1L8vUtUxFbEjhtoMOJLBmGYe9k83kavDd57cYaAHqMJJGv29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bkVHthXZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1617D4E40DFE;
	Fri, 26 Sep 2025 14:59:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C575E606B5;
	Fri, 26 Sep 2025 14:59:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 394F7102F1917;
	Fri, 26 Sep 2025 16:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758898750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g/Kz1ie9dmVYwimov0wPhzbQRXu3e/N/BUHb33lb4LI=;
	b=bkVHthXZkidYzbifdV9SltyAzV3an0uOebGZlXz1RdqZY6tM780H+p54jSeD3ReMauLCwv
	YFBs1dtpS1qWvPTpvXq1qbMRg3w0ltTpupARRkyFT6/U24rFUmxckxyl3aZfn/3FafmHiB
	2KgWSFSRnWoKIuonMAGPDRZxpm24xyaHittPgHRs/pU7kvolDiD2Ee5aOQEoYZ4EFSN/bi
	MSzeR0ADdCjcnWgI04/E9lXI6rZR1dhbKOkbxP8GVjJzSBajx857QzZ61E7NU6HOtnm3a4
	ER0pCMdWies6+KfYMfVAKVDpg5luyBzGUW75Sxyw/ogoyEfa7j/qYp+vxVAnZA==
Date: Fri, 26 Sep 2025 16:58:47 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/connector: allow a .destroy callback for
 drmm-allocated connectors
Message-ID: <20250926165847.51f69473@booty>
In-Reply-To: <ycbx4fxqppxuopcd64i6lt7qlcsa75iv4z6q4aka7igt7pntc7@bf3toot46wxo>
References: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
	<20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
	<ycbx4fxqppxuopcd64i6lt7qlcsa75iv4z6q4aka7igt7pntc7@bf3toot46wxo>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Dmitry,

On Fri, 26 Sep 2025 01:07:26 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> On Thu, Sep 25, 2025 at 07:19:49PM +0200, Luca Ceresoli wrote:
> > Some code is going to need connector-specific cleanup actions (namely
> > drm_bridge_connector will need to put refcounted bridges).
> > 
> > The .destroy callback is appropriate for this task but it is currently
> > forbidden by drmm_connector_init(). Relax this limitation and document it.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > The other obvious approach would be adding a separate .cleanup callback for
> > the cleanup-only actions. I tried both, they both apparently work, so any
> > arguments and opinions on which approach is best within the overall DRM
> > design would be very useful here.  
> 
> Would it be better to use drmm-reset actions. I think the check here
> makes much more help overall than harm in your case, so I'd suggest
> leaving it in place.

Thanks for the feedback!

I think using drmm_add_action[_or_reset]() here makes sense indeed.

As I understand it, both .destroy and drmm_add_action[_or_reset]()
actions will trigger when the drm_device is removed. This is not ideal
for hotplugging because one would add/remove bridges while the
drm_device is persistent, so on multiple hot plug/unplug loops stale
resources would accumulate until the final card removal, perhaps at
system shutdown. However for now my goal is to have bridges refcount in
place to avoid use-after-free. Releasing resources for hot-unplugged
bridges for this case is a further step.

Bottom line: same drawback for both solutions, but the drmm action is
cleaner. v2 incoming with a drmm action.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

