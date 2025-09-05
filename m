Return-Path: <linux-kernel+bounces-803558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD881B4624D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31C11CC7FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE1261B91;
	Fri,  5 Sep 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="FDJHuT0W";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="JL71OQyO"
Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E94305971
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097180; cv=none; b=BWplvenKSFRbIiMcEoilN1zSmgUMXWOu3UP/Y4qSWM6zD64bj9WG9plvStoAuCfeLYTIJgqBlvUj6NTLrnoMTjgk1WONqkgaVs3KpZaN0K4COQ1cwf3ggntqUzrlMBknbNXVlvJKEJP+vhDNSvx7GqT13VTOK6N/60aUsiBTemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097180; c=relaxed/simple;
	bh=OxhKA3Gjzk/xIEHINEHN2GhZdADFRxSA6rz84t6CdvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1kUHxRqpmghAuzs2G1hTNBWEkmfF9nRqQc33nk59KeHb+tLmmkXOJvW9m++sro95XIdg6gK/SpHcRq8r+IbIQD4luGo5b8NDjeTrXeXcA+QJgyNbKNVzNIchcxilX9mMzco5VZvtjb/ubh1IjwAMP8KC8y+5H789MU/XMHRCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=FDJHuT0W; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=JL71OQyO; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757097107; x=1757701907;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=XLrsQjlopOzuKX1/eHehC43L8GgHSisCzYiPyOWGnls=;
	b=FDJHuT0WaJMRjBW8mdLPp3rn7DYJCnm6MmdcaAbqml4Rv+KIqnCfJ1LnGHdg9dHoQrNXkD722CKMa
	 QVpTRQjdnY+4S/AQfwH0mXw3MviObRP2q9yf6li9MJKmtENFaqBLQjEEUjCNKNrOXHRTGlfxRb5LaK
	 I8FlU2ZAENPgWhqjOJFxNzwWs6M2YxgdkcXHjBmSotJnFeDkvH/nVA7P5oPHwHOBmoquJudQN9ZTFE
	 5yQOdfTrZxFBBS3w2hNteMeY9w7vlDQh6vpd3p1CZKE6pq6EUrTGkj59qqA1Rk/IFA4Gj67Bf3EHEO
	 3yS8hrf2OmBR7uODszHLSlJ+QVSYv/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757097107; x=1757701907;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=XLrsQjlopOzuKX1/eHehC43L8GgHSisCzYiPyOWGnls=;
	b=JL71OQyOVlwKXEPCWtIEffYZQ1lig2lzogR5w0MWucQlDvlyaaON6JNLm3HR06Yn9Iv3JwwAO1CeO
	 cOugqiSCg==
X-HalOne-ID: 92b917ff-8a86-11f0-874e-f7376af24660
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 92b917ff-8a86-11f0-874e-f7376af24660;
	Fri, 05 Sep 2025 18:31:46 +0000 (UTC)
Date: Fri, 5 Sep 2025 20:31:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fbcon: Rename struct fbcon_ops to struct fbcon
Message-ID: <20250905183145.GA360685@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818104655.235001-3-tzimmermann@suse.de>

Hi Thomas.

(I needed a distraction - this patchset was my excuse).

On Mon, Aug 18, 2025 at 12:36:37PM +0200, Thomas Zimmermann wrote:
> The type struct fbcon_ops contains fbcon state and callbacks. As the
> callbacks will be removed from struct fbcon_ops, rename the data type
> to struct fbcon. Also rename the variables from ops to confb.
My personal preference would be to name the variable fbcon.
This matches the name of the struct, and I did not see any conflicts
while browsing the diff.
But this is bikeshedding..
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Assuming the bug reported by the kernel robot is fixed.

	Sam

