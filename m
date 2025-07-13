Return-Path: <linux-kernel+bounces-729177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15BB032CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FF21898FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B727A477;
	Sun, 13 Jul 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFaZfLJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF019E971
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752436967; cv=none; b=l3bdJK27hLnYWBS1kpy0IFhrYnIdD0XZ7Js6V6UJlIp4Acl4+Kz9eZV0/LJ5zz/qW+BMt0cgxHWGUHIBK15W+L9ITny97zta1Xg/uu6yhXJ32JTDfu4/XVUB+SQvEWFBApIAjB8sYFUh2rAfdb6Ow1EH118BTeLlbefuWABgdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752436967; c=relaxed/simple;
	bh=GNz6GGX7CATQGMZiU2RcEGADzPlhOuUZaXfas8vT0H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoHEfKap5ByrZ6bUrq8CMabDUKCkFEEySX4+zd7pcni3O2hR3iiketIDAk9z9XLy29kQwKpnpNUcpdc6iHea3m3rfPJ5652mI3R8b/Ftn4aOXiV7hbfy9v9KZiBRCaCVyqBWXHtWpDFrap1J546SqojLLfnh+LOl0f0Gwm6xAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFaZfLJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15B3C4CEE3;
	Sun, 13 Jul 2025 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752436966;
	bh=GNz6GGX7CATQGMZiU2RcEGADzPlhOuUZaXfas8vT0H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFaZfLJ6hFPx+/iyBc9KU1epPKGMqBCeKcCS4FXgoVzVIcSKsmX4cixmlcjO9huTu
	 X9YrbyOCxVs9SM7Fa4qm69HBZr2W/osn9pG+KmcoDIgNXhTPsbEDhohu/L6FBKsWNM
	 zCfO8Y1E8SwGbALNNfP3vtlQosWophBVFt284Vi3s2cZHQaXkA8SWz+0wfqI4bo+UI
	 cB4bWZ0FqWuHAiIOrvir53IYmJY9ofhe7sWvq6ik1YfM4RInhKXYiGL9ZY8XcPvNMj
	 oIjoGm/O7B5d6xM5AhrgtRIwOBEpbhGUqYZzFDkMDNrxWrDry3zA/7ZjCfxmkqmMSI
	 meJ/sdEWf8ang==
Date: Sun, 13 Jul 2025 21:02:41 +0100
From: Will Deacon <will@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, mark.rutland@arm.com,
	yangyicong@hisilicon.com, hejunhao3@huawei.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, wangyushan12@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/8] General updates and two new drivers for
 HiSilicon Uncore PMU
Message-ID: <aHQQ4T1aMUazw-Dw@willie-the-truck>
References: <20250619125557.57372-1-yangyicong@huawei.com>
 <c5a99a5a-20d9-ef07-1cc3-cb025f446619@huawei.com>
 <20250713172732.13100182@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713172732.13100182@jic23-huawei>

On Sun, Jul 13, 2025 at 05:27:32PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Jul 2025 20:36:11 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
> > just want to make sure the mail's not lost somehow, it's been skipped for the last cycle and
> > no further comment since v2.
> 
> This one is still outstanding and Yicong mentioned some recent issues with
> some Huawei emails being taken out by spam filters.  As such, a quick
> ping from an account that shouldn't suffer that fate!

No probs, it's on the backlog but we've got lots of patches and not many
reviewers :(

Thanks for checking, though.

Will

