Return-Path: <linux-kernel+bounces-814408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5522B553C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658B6AC6911
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB33112D3;
	Fri, 12 Sep 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM6xK9fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559611DDC2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691406; cv=none; b=GW/AFEmo66HV8kDA7XdgqzatzyE2GYpKX5NjVu0SUs1IQKHp6l+A56E4d4E+cTvVn0ZYEwR/KIYM5Cj75snhzLphZ+VWVxB8aNXyvXmJUy7FKcXLaVzIxhQ/LO1/BFhaCWjXKywQwrudZrISs+2shthJmLSyJ2BjAQIsruKR0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691406; c=relaxed/simple;
	bh=7KIyhXozmO9enB0OmWR+a45UVtnSVzizfyQiyTEx8i4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B4FPVSdiruV5uOofUa3if88bANdSaT/406vQejvIWktwg65kz06Ybbg2LKay0Qm7qENtNdN3VrC364C5HfqvU1q4vANhScGi/uND0zMuidDGTzd3lWoIWX6tTS/5GAPOOGArll7KyxnsGij3Z3xLr6SDNxQzvFY/BRPeCZlRN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM6xK9fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704FDC4CEF1;
	Fri, 12 Sep 2025 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691405;
	bh=7KIyhXozmO9enB0OmWR+a45UVtnSVzizfyQiyTEx8i4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gM6xK9fz6HoG7c1ecSKDNBzxRxe2+ZNhfRuK/1mghc/BpeopZozv13gFj2q8wChyg
	 ujsc/LoZu6OFUQjAnBof3XSs8JDthK4mbL/qUYQCZ2gAMnKsBsQ+a2ixXsilF5CbXt
	 W+tPMJJEdW2wQTUW2suxL88eURtvlA4JbEtMsYxxV64SLO16AS2b5L6TrcnItl+ew5
	 iBI8uDaKqnHcUlK29kdTHD4d2ZkbHRNNmZRvb3n6bYYDsc1QKdHHuhgrbu9188sT1+
	 YX2yQeeZC7oLdOFbuRybz4g2Sp6XbEQFGwLVGUpQkfAiV/I173o05DqdYuVvGsTpXf
	 JG6hAa+b6ChiA==
Date: Fri, 12 Sep 2025 17:36:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: inux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>
Subject: Re: [PATCH v1] HID: Asus: add Z13 folio to generic group for multitouch
 to work
In-Reply-To: <20250814130151.8276-1-lkml@antheas.dev>
Message-ID: <8sn27o0r-60rn-31q3-022p-54848o1ro83p@xreary.bet>
References: <20250814130151.8276-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 Aug 2025, Antheas Kapenekakis wrote:

> The Asus Z13 folio has a multitouch touchpad that needs to bind
> to the hid-multitouch driver in order to work properly. So bind
> it to the HID_GROUP_GENERIC group to release the touchpad and
> move it to the bottom so that the comment applies to it.
> 
> While at it, change the generic KEYBOARD3 name to Z13_FOLIO.
> 
> Reviewed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


