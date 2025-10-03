Return-Path: <linux-kernel+bounces-840952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DCBB5CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C11D19C6024
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7012D320B;
	Fri,  3 Oct 2025 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGmOkUgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D672D0C8A;
	Fri,  3 Oct 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458314; cv=none; b=IdADJ/S/BeNRABLwk/nJz6Vk3s4rnm4/iNXC4t4e0MaC07YLuGW16fP+fxRtDvlcr/bgAsMr6B4oHWFMUsrIgcs40YydLvcwAmcyRh19z/nWpEfMex6zRwv3TYR5Ta2cn1NqMg/Ntd5mZjhHXTfUp0nWaK3uZX4Kt5Ja5Y/LlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458314; c=relaxed/simple;
	bh=VPFfZTHVwV57MEuG6jO6nWhKwL3NtUZRNiIYJBPdoCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQbogOuwZLNFpitFlE2O57MQTRk2IHiS0JaK9KAzUGaIhK677+aXojocfFxPXm+nJ1qVm5TV3p1aZDxB6ZkGfdst4Hf3GcHF4342zF/TzHB34gGhDZcwClIiew0dZ/3d4b5gbY0pmks1vt9kKpEZ5iwTyWJUY6SXcJRz/1gDUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGmOkUgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A1DC4CEF4;
	Fri,  3 Oct 2025 02:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759458313;
	bh=VPFfZTHVwV57MEuG6jO6nWhKwL3NtUZRNiIYJBPdoCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGmOkUgWzsGgXpNx5gSPsoiWT33dOVvvVxWxAUbXCkUxaKL8Kn8ZGLhlFdKLOXbNy
	 /F43hF+b0FHOczvASYXa5NX3r/OgQZJaT/lObUqaq4qWVLOHJNFOPQTsVEBOSHxNUC
	 j1Qt4Pk2ikDqZwqYj1XmPCya/4I7BOqKkK/3MZvpLnIOZZNE32i2sVJuJoEOocWIhn
	 LoIXC2qvRoYPo+W6M8Vi9tZ5m5x5N3g7hqDqG3bCqkLeXqZsSn5WgzAqtx2KkOw7V/
	 Y5TPCxtDz7pyLkOep5wDq3j9Z/j8RuVHm2/dsHCDMOJUfEA2TLUSxjTYIsxJHn5RCV
	 0WL9WWSq9UuIQ==
Date: Fri, 3 Oct 2025 02:25:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aN80BqZrhisWGY6p@google.com>
References: <20250926202234.3064386-1-jthies@google.com>
 <aN5iyOsHILi40AIp@tzungbi-laptop>
 <CAMFSAReHEt7nUZvsnB5pyPTaddSVSdtiiX-RLpY4MfKq3qfX1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMFSAReHEt7nUZvsnB5pyPTaddSVSdtiiX-RLpY4MfKq3qfX1Q@mail.gmail.com>

On Thu, Oct 02, 2025 at 12:42:09PM -0700, Jameson Thies wrote:
> >
> > Does it make more sense to use fwnode_get_parent()?
> 
> I was initially planning to use fwnode_get_parent(), but calling that
> from cros_usbpd_notify.c would require an ABI update to build for
> android.

It doesn't change the ABI but extend the dependencies.

I think fwnode_get_parent() should be preferred to use from maintenance
aspect.

