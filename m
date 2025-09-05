Return-Path: <linux-kernel+bounces-803561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7BB4625D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B8FA45CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135182737E7;
	Fri,  5 Sep 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="bdMLygMy";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="p4922yrA"
Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D7273D68
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097475; cv=none; b=OapBsLA7IzSJFX9MP2DVXR3pNWvliPI8ECq+4qfQfUMXGXpdBY3ASAOOEU3fttR3r5/WAVMkZKg0whF+qzJDv25oEYe7Elrnf0CW0P6XU92EyDsGqUhO6izRerknpWqNNRciGQ3pT4nXbZVt0NEi35djEpAgPKfFhRegLmeFCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097475; c=relaxed/simple;
	bh=AmzYGcVQORtZ5c4apljZBYaDRvLCZWpZz4Bzml7Y1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4tEZHe+Q4T56aVchiyMf96f92FmamlgnavY3XE6MZRIp2mdzVutGrCasDKZbd9sW5eMUo50HBt735CGQ2qav47Y2AfCeOdA2djvi+/gtNWfq4ClAh7/WoPuu05p7dy+l49HgH/pmlpkrnBjUGeSIERddOr2j2A3sp5js2eyYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=bdMLygMy; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=p4922yrA; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757097470; x=1757702270;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=P13HvUfB9+hmK7dH65uYyDJo/LYux5XpE6ItWJpimrM=;
	b=bdMLygMyGMIhkCuvBp42jg3BoSRJQBpxFG3nh1NpU2ZD0+VPm+AWM99dEnv2Gs04DgceNs24HJcM8
	 Pb578XTpbnyU0Yb2QeZo0jxW88ZrUd6rTcQZzKgXIuj+I/juagSXQ/X0SK/oAkkQsBlPAk9EumMqGp
	 BiDQpz5Z/0ItJGT9kHUae0LZzmC1+rHCJnIEpfBVtOOpsO0wRfYlXcq1YplqqwdbVd6/3Tc/oseiq9
	 58MLvlgUuzQNibNXGLhHoBB/tp8953pcbNNBPAGzRKgyifoX6X9gZtgvbxXNgD9wYgEdRe3nzR7fZO
	 XeSG8ExuS5ImH5jbB2FI8SeiscUTetQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757097470; x=1757702270;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=P13HvUfB9+hmK7dH65uYyDJo/LYux5XpE6ItWJpimrM=;
	b=p4922yrA6E3K37M5RVLUEQq0XbmNc/8pNK/JE1XIWurFi5cWJfWi/IGXHCDPAClJVWvY17WJLAfAK
	 3OQXywxCg==
X-HalOne-ID: 6bb947bd-8a87-11f0-9d80-494313b7f784
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 6bb947bd-8a87-11f0-9d80-494313b7f784;
	Fri, 05 Sep 2025 18:37:50 +0000 (UTC)
Date: Fri, 5 Sep 2025 20:37:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fbcon: Set rotate_font callback with related
 callbacks
Message-ID: <20250905183748.GB360685@ravnborg.org>
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818104655.235001-4-tzimmermann@suse.de>

On Mon, Aug 18, 2025 at 12:36:38PM +0200, Thomas Zimmermann wrote:
> The field struct fbcon.rotate_font points to fbcon_rotate_font() if
> the console is rotated. Set the callback in the same place as the other
> callbacks. Prepares for declaring all fbcon callbacks in a dedicated
> struct type.
> 
> If not rotated, fbcon_set_bitops() still clears the callback to NULL.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

