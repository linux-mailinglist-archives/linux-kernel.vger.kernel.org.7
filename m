Return-Path: <linux-kernel+bounces-772205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC9B28FE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA3317510A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05E2F6584;
	Sat, 16 Aug 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b/JcHSlp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965922FD7DF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365563; cv=none; b=Ec8Aml6L0WKMPpsspAbnj7YAPI4P77TBiWRRat95AFqIxbakMb+OVamKBeSBwwrL80p8hlBxYj2HHcimjRapXdtIWn1uKKNQKsmT7qrxCMEfTe2c5C4Tlizabg5EQdAO0jq5DhH2rxX+NBHc6ocDGmo8aNqXr/70BFEaO+G5itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365563; c=relaxed/simple;
	bh=WDLPIRj1QKojvvF3Yx7Sb4HKzzmXmbCiB0ikIbNkwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZpv0Tn012ltdmsFvqOFAkEimapjG7D94iKIrEGHa0kKwClfrAD7BgTHauN5dn89JtKtmu7nLhFrIf6loxq6/IfGwwvs2BZU+46TzNyQUzKGubExYmDbhjIBUujN+E3ISXAZs0I7KyVVNqoh3vV77jtUNdsepqv53n+T7DUupic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b/JcHSlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77414C4CEEF;
	Sat, 16 Aug 2025 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755365562;
	bh=WDLPIRj1QKojvvF3Yx7Sb4HKzzmXmbCiB0ikIbNkwv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/JcHSlpo2bxS6qB2Rj4KR7Ih5kDHdFEO2CbLtZVE0i3DdamAofkI3PvSXjew8WZp
	 dQBLuVTgX33Br7exn7slqLqWs6IIpVbu2u/0J0hEpjP6CZ9+6i+51Uw+y1VAbHY1u1
	 K369Li1uA+FmeDepZGjXHBOHgThECmgao9gw3w0Q=
Date: Sat, 16 Aug 2025 19:32:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Todd Kjos <tkjos@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
Message-ID: <2025081612-unpledged-agnostic-7fb3@gregkh>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
 <2025081642-viewpoint-exemption-006f@gregkh>
 <DC3V792JTD1J.LB1A657GBFQA@cknow.org>
 <CAHRSSEyxcqydwbEHHLzHKar9AaQAjACFuM0CnBxN5XrvFQdBcw@mail.gmail.com>
 <DC410TGMPWBO.3CP1NM5WWBEJ0@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC410TGMPWBO.3CP1NM5WWBEJ0@cknow.org>

On Sat, Aug 16, 2025 at 07:26:16PM +0200, Diederik de Haas wrote:
> On Sat Aug 16, 2025 at 6:37 PM CEST, Todd Kjos wrote:
> > This is not feasible since binder relies on many kernel internal functions
> > and data that cannot be exported for loadable module. Patches for this have
> > been attempted in the past, but soundly rejected. You can see some of that
> > discussion at
> > https://lore.kernel.org/lkml/20180730143710.14413-1-christian@brauner.io/.
> 
> That seems to be the upstreaming attempt (or at least trying to start a
> discussion about it) of the initial patch.
> A lot could've happened in these 7 years, but apparently not enough for
> a different outcome. Good to know, thanks :-)
> 
> FWIW these are the current ones:
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.16.1-1_exp1/debian/patches/debian/export-symbols-needed-by-binder.patch

Ah, that makes more sense, that patch is not going to be accepted
upsteam sorry.

greg k-h

