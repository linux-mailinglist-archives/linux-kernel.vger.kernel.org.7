Return-Path: <linux-kernel+bounces-661616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14977AC2DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 08:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB061165CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830B1D86F6;
	Sat, 24 May 2025 06:29:59 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F81C84CE;
	Sat, 24 May 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748068198; cv=none; b=Q4TwQL5m2PbtEBU+S1MlPTV1lEIWVVFfslFzmz2ACRUidbQ0be6cp6/uu6nUjyGYFl71Uc4KqCBAxqPRUqUlh7FeNkwClh5G8lQznPkMY2VOqSnZP0J4bG5+bNoOLUgEEx/4BirTv/9S4N/OJz0ZVhwQGmNy6kF5iVqqrwz3Khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748068198; c=relaxed/simple;
	bh=agcIZIZI1+XOaNaGNuuam42n8Iq8BESe6hRxoNcVXM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFjbDsykPP6y6gRqUZr0aHs4DmH/lIcHv0lD+0my4x+BlLjzml7Rc/Nyd8hd9hyXVI8+1v2stMYKxCKPlCTW7/5nkWnPtBw0djMMVmDzOAVMrwJL3LkXRWtlaZyicd4EXEzY6r9VxIlhuIINYzDIkZFywiLWw3+kQzDySK66WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AE389200919F;
	Sat, 24 May 2025 08:29:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9700222427; Sat, 24 May 2025 08:29:46 +0200 (CEST)
Date: Sat, 24 May 2025 08:29:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Cyril Brulebois <kibi@debian.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <aDFnWhFa9ZGqr67T@wunner.de>
References: <aDDn94q9gS8SfK9_@wunner.de>
 <20250524024207.GA1598583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524024207.GA1598583@bhelgaas>

On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> What I would prefer is something like the first paragraph in that
> section: the #ifdef in a header file that declares the function and
> defines a no-op stub, with the implementation in some pwrctrl file.

pci_pwrctrl_create_device() is static, but it is possible to #ifdef
the whole function in the .c file and provide the stub in an #else
branch.  That's easier to follow than #ifdef'ing portions of the
function.

Thanks,

Lukas

