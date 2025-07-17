Return-Path: <linux-kernel+bounces-734863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA4B0874C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B09C7BBD10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC66256C7E;
	Thu, 17 Jul 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqYvVgxY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793117E0;
	Thu, 17 Jul 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738369; cv=none; b=unVLQRALKA96GfRwrDP+ldmGBkvGPICEayBb1q9FF+de1dzjeAGsgvpUF09wQRnQUAcU4kItWYI5DdRlTEHUGvqwD5hWXewOLbnSNkOmf8RQCCawgPLPLzAIS7eK1BliZ8SUDmhesNF5P2XIsQZ6X3DKLAf3sDU+uv2GVJlLK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738369; c=relaxed/simple;
	bh=FXtHecgjkslmm6Te8ddh6F4hjWk/SLneIUCHaBDGU6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ+plixlnY4YiqytumhTXK0stynqAc+PqvTQbem9rFZNpTneYxAkf0SyVL+Vlc9ZHBV0ltvw+tfiYrETPt0T0ZJGF4Ih92TFDf1/Lv+0ZSlSgJxsgLlFD0WBdWpVHgEuMxrjuxYvHw9fH3YohQPmwYswfP1AayBXbqH4JFk2Sm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqYvVgxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034A0C4CEEB;
	Thu, 17 Jul 2025 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738369;
	bh=FXtHecgjkslmm6Te8ddh6F4hjWk/SLneIUCHaBDGU6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqYvVgxYf0CLHH0IU1OSBjcaH7/z34DorzYCGw/a5sAlf/STLj6pLuS9JInNx61e1
	 huhWwlsyhhQLGceJvGLrbOJHkjliGJCy8+joA4G6ea+m1TY69wElL7Ayk+WZ5OP/kH
	 rdqupTLvhhrWL6nUVTHhvxqOWYT+YqXRtfYytkRdNwK5I4m2rmo7YqHheEIn0FAmlE
	 TQ8WzjuG/dcLAdaL3DZj0IOzTDshfmrnEmdU6qtf7GesWwnz795csQYxTrSgo71tk3
	 /s2veG//qMjOxccYufs4IQBBLO/a4IMwzC33T712jqr3Z7b3b3Tfp8Ed1SOyoMXEhU
	 iusnz3xG18mIQ==
Date: Thu, 17 Jul 2025 07:46:06 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
Message-ID: <aHiqPuBm8Znmph61@google.com>
References: <20250711003502.857536-1-raduvele@google.com>
 <20250711003502.857536-2-raduvele@google.com>
 <aHCPDXonAevxkMho@google.com>
 <CACKy9TJHtA5K2YqdNdnMuTvOsz4OCkRds4Hbj8aZdK5VXpMgWw@mail.gmail.com>
 <aHXwOtrFpn-yRFvs@google.com>
 <CACKy9TJvkx0Bi69pO187dxs8EUt3foc0seNYjn=vK4WCuTHYxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKy9TJvkx0Bi69pO187dxs8EUt3foc0seNYjn=vK4WCuTHYxQ@mail.gmail.com>

On Wed, Jul 16, 2025 at 01:39:53PM +0200, Radu Vele wrote:
> On Tue, Jul 15, 2025 at 8:07 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Mon, Jul 14, 2025 at 10:32:03AM +0200, Radu Vele wrote:
> > > On Fri, Jul 11, 2025 at 6:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 11, 2025 at 12:35:02AM +0000, Radu Vele wrote:
> > > > > Add a lock associated to each port to protect port data against
> > > > > concurrent access. Concurrency may result from sysfs commands
> > > > > and ec events.
> > > >
> > > > I realized the critical sections are way too large.  What exactly data the
> > > > lock tries to protect?  Is the race possibility introduced by any previous
> > > > commits?  Please provide more context.
> > >
> > > With the implementation of the role swap operations from the previous
> > > commit (and also enter usb mode from another recent commit) we
> > > introduce the possibility of concurrent access to the cros_ec_typec port
> > > data from the userspace (e.g. trigger a power role swap from sysfs) vs
> > > from EC events (e.g. partner triggered a role swap that we accept).
> > > This is the main reason to propose a per-port lock. This way we ensure
> > > we protect the state of each port in the cros_ec_typec driver.
> >
> > To make sure I understand, did you mean the lock tries to prevent from
> > sending multiple commands to EC at a time?  If yes, does it still need
> > if the underlying ec_dev is guranteed that [1]?
> 
> Not really, as I noticed that both the ec and Type-C connector class
> use their own mutexes.
> 
> My intention with the mutexes is to avoid race conditions in the case
> when a role swap is in progress but at the same time there is a
> `cros_port_update` that modifies the state of the port. Another
> example I have in mind is when the port is being unregistered and
> a role swap is issued.

The critical section is too large to understand which fields in the data
structure it tries to protect.  Please review again whether the lock is
needed or not and shrink the critical section if possible.

If taking the changes in cros_typec_perform_role_swap() as another example:

    static int cros_typec_perform_role_swap(...)
    {
        ...
        struct ec_params_usb_pd_control req;

        guard(mutex)(&port->lock);

        req...
        cros_ec_cmd(...)

        req...
        cros_ec_cmd(...)

        switch (...) {

            typec_set_data_role...

            typec_set_pwr_role...
        }
    }

The `req` and `cros_ec_cmd` obviously don't need to protect.  Does
typec_set_data_role() and typec_set_pwr_role() need to protect from
concurrent calling?

