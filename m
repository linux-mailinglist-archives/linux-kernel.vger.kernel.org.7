Return-Path: <linux-kernel+bounces-744749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98277B11079
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AA8AA7A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE602EBBA8;
	Thu, 24 Jul 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8d55PVo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0F2EAD09;
	Thu, 24 Jul 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378991; cv=none; b=aUBQIgHcHbS4G3L3JKwNHFbecZfIzA/gw0qfIvu1AitzFcHt/9pki+0+A+uTgcrUeumzGe8AdB3Ni0uiDGQKlEY+t7lJmoXMhxauHu4zunTMfeKniUxdrbO3TKCQ+ZtUCVS0e7rYOC+PxyWPXuNYMlDg6+jaqyre+ihsEk0cGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378991; c=relaxed/simple;
	bh=XBj+J3IHgG7t/JlO+SdMmc57hogwgLS7tgmyXFVGizY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5XQ5Tqi905P8n3VzzsSn7oz2B7y1QZf8+2XXVwFCr1O3OeAclw0WAZF7HwgBfl9wbG+f9CtHl6iw3NmvNsYerFPJx609H9xfbbA2xCugAInBfcVdzCmd6PJ7CXO80wbNySKntHIrbxvbCrhD/cFxfo9lyv+G/9z3TuufK4vanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8d55PVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D58C4CEF1;
	Thu, 24 Jul 2025 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753378990;
	bh=XBj+J3IHgG7t/JlO+SdMmc57hogwgLS7tgmyXFVGizY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8d55PVoNTDXwnsE32+FlMm64ukVfbED/wo28dwad5w/vHUCiIJVqvNN0Xz86ABiy
	 cnpjoCHZPdhzyt0S9bq29ejP4cPvXeWQ1lU3WvJBLe2p/wcjibkEtwpfkY7H1s+e8M
	 Geg0uaShbuxDndvVXu0Fog5iVI4h+vFl9kfRZyF9ggTAu9xY/vHewaA4Cs+/RVBn1k
	 wxRJx7TlRGp25VpBZyMjvMim+kN4f9sO4++D5woNayeAYn9Ry4ohebe/Qr5LItm5iW
	 12sOpDmXYvEUUGsmIJ2h6w+A1PNQ8utxxotcsk+dUoyt5u2mzkKSB9Tj9pm+29WR3r
	 udQZZb9imEOew==
Date: Thu, 24 Jul 2025 19:43:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250724194306.27b98194@foz.lan>
In-Reply-To: <875xfhabv0.fsf@trenco.lwn.net>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
	<58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
	<20250712163155.GA22640@pendragon.ideasonboard.com>
	<20250713002517.7f52b0e9@foz.lan>
	<875xfhabv0.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 24 Jul 2025 08:42:59 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Maybe I can place instead CONFIG_DRM_I915_WERROR.
> 
> I've held off on this series on the expectation that a new version would
> come.  I guess, at this point, it will be a post-merge-window thing?

Feel free to postpone. I have already a new version of it here somewhere on
my branches, but I had to take some days off. So, I ended not sending you
the (probably) final version.

I intend to send what I have here during the merge window for you to
review and apply post-merge-window.

Thanks,
Mauro

