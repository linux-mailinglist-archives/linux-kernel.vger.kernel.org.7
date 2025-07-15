Return-Path: <linux-kernel+bounces-731237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C79B05182
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099334A15B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10AE2D3A86;
	Tue, 15 Jul 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIOLx+tY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29C2D29CF;
	Tue, 15 Jul 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559678; cv=none; b=kePCFjcH+UoUyQVbFcmN1TQKrOjWyMPvDZzJZKUSBZ4HuX+16lMa0AZN9M4kW4wkVejY6hgufzPiWzrGKTCXbxBA2q8EzzySSCrkeRzGFceeKsIwXA9rnwwmhrwuqwjajOS0sSFNzB72PbCIfCqLz7mIjr9y0Pi4Traabc3RHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559678; c=relaxed/simple;
	bh=fHlR8wwEWimYVGcD2Z6AA7c8VByjB9K9B/y2PypuOsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYOi/1ROwOtZlKVF4nsyVj8MGb93njlrud11XlAr7Y9FdaPQRxiGnEAfKmk/+3LJpfHhEBQGMTlRpaPC5k6XC9zfLQalszRnkXhN1LXQmobtgQV4xwY3P1cobzg+poAr6QYs/f8Fr4BLQhVOPI/r6s/EyY2CD7imn1rLIAGtBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIOLx+tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8730C4CEE3;
	Tue, 15 Jul 2025 06:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752559677;
	bh=fHlR8wwEWimYVGcD2Z6AA7c8VByjB9K9B/y2PypuOsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIOLx+tYrxMaIeAz+EOm+/U3nHCr9y2tRl54wQBWAWCoY0KKVP/y/3QPGkn8vih3I
	 xEYqXSVLYOnCz5yOAkZI+h00MDbDv2wh1n8OmT7cW/FkO8K2aszEy3GVypU+xoY+hb
	 kGEtUNDZOA1ytXkitx2eMVOJ/4+/KeHU2CsxzmorwbrSNb3dsqYPzP2UqfRLMxn0Nc
	 L3CsgdPlDqF2wmP318DKuV7351j36oZB1fk80P9rAqEPYTVkHP7nK0URPF0degWjjy
	 HF3aGhW4fRX47VAaa9XDwMjtWy2KqOtGIrS74fuoKgXt0mOoarJkFZyyK7lQiw249X
	 Mqwf24HfY7TzA==
Date: Tue, 15 Jul 2025 06:07:54 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
Message-ID: <aHXwOtrFpn-yRFvs@google.com>
References: <20250711003502.857536-1-raduvele@google.com>
 <20250711003502.857536-2-raduvele@google.com>
 <aHCPDXonAevxkMho@google.com>
 <CACKy9TJHtA5K2YqdNdnMuTvOsz4OCkRds4Hbj8aZdK5VXpMgWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKy9TJHtA5K2YqdNdnMuTvOsz4OCkRds4Hbj8aZdK5VXpMgWw@mail.gmail.com>

On Mon, Jul 14, 2025 at 10:32:03AM +0200, Radu Vele wrote:
> On Fri, Jul 11, 2025 at 6:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Fri, Jul 11, 2025 at 12:35:02AM +0000, Radu Vele wrote:
> > > Add a lock associated to each port to protect port data against
> > > concurrent access. Concurrency may result from sysfs commands
> > > and ec events.
> >
> > I realized the critical sections are way too large.  What exactly data the
> > lock tries to protect?  Is the race possibility introduced by any previous
> > commits?  Please provide more context.
> 
> With the implementation of the role swap operations from the previous
> commit (and also enter usb mode from another recent commit) we
> introduce the possibility of concurrent access to the cros_ec_typec port
> data from the userspace (e.g. trigger a power role swap from sysfs) vs
> from EC events (e.g. partner triggered a role swap that we accept).
> This is the main reason to propose a per-port lock. This way we ensure
> we protect the state of each port in the cros_ec_typec driver.

To make sure I understand, did you mean the lock tries to prevent from
sending multiple commands to EC at a time?  If yes, does it still need
if the underlying ec_dev is guranteed that [1]?

[1] https://elixir.bootlin.com/linux/v6.15/source/drivers/platform/chrome/cros_ec_proto.c#L661

By taking the following hunk the patch adds as an example:

@@ -54,6 +56,7 @@  static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
 		.mode_to_enter = CROS_EC_ALTMODE_USB4
 	};
 
+	guard(mutex)(&port->lock);
 	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
 			  &req, sizeof(req), NULL, 0);

It seems the lock doesn't protect any data but the command transfer.

