Return-Path: <linux-kernel+bounces-849909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF915BD1436
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5909D4E81AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D995272E63;
	Mon, 13 Oct 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6cNW9zU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EE7263B;
	Mon, 13 Oct 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324251; cv=none; b=Xro70H1Y7sA6vW60x8pgpIjOZrtMUU56wqSXNctZPP+MNNBq8k4dOm76XE9mBDJ8hDH5rmubIqHea+UhIcQUzh096NhJ2vGRzCydESozXa/LhGbcWfeA55rXfwyxP9oDU+SpVhq54H3nFOM7tO9lCr2WVlBPuw5qi/goawHZKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324251; c=relaxed/simple;
	bh=7M49VFFZshmO8Zp+ArkHbwMXChf1r4td5uvO5R/hnWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcQczelyTIq704xkD8CTYZJQe69F81F4fe/aKEfxgZg5/Id8b13+jPzlJtV+fqg5OPBzAh7xhQ7LHgq6y+fob3Vv0CaJtmsJ06Yq3K+5RCXepiG5TcobjwI4nFdBONGV2hx+86TwNsQG7hjEh8t0MvbaK5P2O7k/lGBy7pGdYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6cNW9zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74163C4CEE7;
	Mon, 13 Oct 2025 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760324250;
	bh=7M49VFFZshmO8Zp+ArkHbwMXChf1r4td5uvO5R/hnWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6cNW9zU5kBHJIuexqCHpW1MC1s8O1mkg/BylrGHN7/ySt/O+GvMnOdjijnzTblVX
	 g5sh24S9Gh4zas8m098FBTykinxTmqVOTJJOwqp79ADrR7lXnzDVM69mq1oS/ajTNM
	 KG9O3raE3UrpMn3a2KtLCF5hELsE4jKv0p9v34jb9YzcBuZh/aB1NNEWxiXhM2cgX7
	 d41g7zzO7wdHYipl7FExMLoexDpHdXkkfA7KNoezgjiOMw1ArzwK4+m528nN0whP5p
	 6OkB71BW7J2zbVN79HA6TfMXnmI0/315XOo8XnoKweT7ozD/2DQIWzN0OwId38T9A4
	 wrugRDt0+7KDQ==
Date: Mon, 13 Oct 2025 02:57:27 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, bleung@chromium.org,
	abhishekpandit@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
Message-ID: <aOxql79QEQb0n8Ck@google.com>
References: <20251007004043.4109957-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007004043.4109957-1-jthies@google.com>

On Tue, Oct 07, 2025 at 12:40:43AM +0000, Jameson Thies wrote:
> The cros-usbpd-notify-acpi probe currently does not exit when it fails
> to get a pointer to the ChromeOS EC device. It is expected behavior on
> older devices, where GOOG0004 is not a parent of GOOG0003.
> 
> Update the cros-usbpd-notify-acpi probe to check for a GOOG0004 parent
> fwnode. If the device has correct device hierarchy and fails to get an
> EC device pointer, defer the probe function.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_usbpd_notify: defer probe when parent EC driver isn't ready
      commit: e4ee0bb077cd7d70207647a0106f6ea6a74c2636

Thanks!

