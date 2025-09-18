Return-Path: <linux-kernel+bounces-822255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF1B8364C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088FB7AE6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A282EB868;
	Thu, 18 Sep 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNOvIoRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF371A9FB8;
	Thu, 18 Sep 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181804; cv=none; b=EUDURvbizqqhsDsreN13tQTh4hfahAYrJewj6CgJhnqbbVfehnKCIEZAp3tGykCLO5DwBZeRUHo75OHfu+67vyFCssPS4qTHyLUozSNVZ0lf90wn4TLH322vFAlWoxI4hhYweL+F27MtoZireSOYYfqlS2jqFVf4HOq9lStO1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181804; c=relaxed/simple;
	bh=lQquor5orXovk+Wpmev2ACmFiEBsjjDCMIqVv9GC+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqCyg2h1jEktCYVifEnAcZcbXbOK7j6MyOThXvVitlc25eumeyDzGNyO04OoKFU89LiNQzqyDsQkPdicZnJs3hADC8cbGEqtMpsDHFkIr9Q+b8X2QrpUvflydCL0bkmG4QolcIyvQ7f+vC446O5SxUIOjIFfps1em2k9BFwdgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNOvIoRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC200C4CEE7;
	Thu, 18 Sep 2025 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758181803;
	bh=lQquor5orXovk+Wpmev2ACmFiEBsjjDCMIqVv9GC+4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNOvIoRLv53SH/m9gN84WWP2gf4RctM4tOm5P6MnkMbWFfmA5QmEaIqXPPFqih0he
	 Hg7caNQOUhmjahoC4NKkInZxdWIv/+s0n3RL587svapvxB/8ZCnvU2h3GqJQaurzAv
	 w/7sQpd2r3GmAdSD9fCMeehswMfJsCCxPOEmPn9c=
Date: Thu, 18 Sep 2025 09:50:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
Message-ID: <2025091821-bony-defame-02f6@gregkh>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
 <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
 <aMqpe68m3rhDYsCt@kuha.fi.intel.com>
 <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
 <CANFp7mVwZksBYBOgPLDDYiynjFDh3jJqY1PFvvBWxtFd8MMYjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANFp7mVwZksBYBOgPLDDYiynjFDh3jJqY1PFvvBWxtFd8MMYjw@mail.gmail.com>

On Wed, Sep 17, 2025 at 05:09:44PM -0700, Abhishek Pandit-Subedi wrote:
> After actually trying to do this today, I think a better approach
> might be to just add a MODULE_SOFTDEP for all the typec altmodes. That
> way, all the modules get loaded together and there's less of a chance
> of waiting for the altmode driver to load when enumerating partners on
> boot.

MODULE_SOFTDEP is going to be nothing but problems going forward, I
wouldn't recommend it at all.  Try it out yourself on your hardware and
see :)

thanks,

greg k-h

