Return-Path: <linux-kernel+bounces-800962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E5B43E49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A70A7BBF37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40239307AE9;
	Thu,  4 Sep 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmBnFt6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979593074AB;
	Thu,  4 Sep 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995035; cv=none; b=smUhOIZhUwvcMJEVNHBHALhi3OfpxM6EGq5BBRsHaBxruZDpzFlRxvP7ufp5IJZcX2kEeM1vakae1eeGiyxEByjVk4EdJ+w53MZRTVle/lc+wfDPv8v+slLXAjTjyMugR9YEGaNs5+xcK/FFWFX34krCJJxVDuOQIl7Y0LSReVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995035; c=relaxed/simple;
	bh=BACrC4AiIber5Zuuc47irRT/Y/gn7ikQqN2P8YNP+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXReTG4xTKOdGnMFw5EVSHsxMoaVwt8jmqPuZpTNczUYxM12zHd0UNa6YbIBgZ67dVdYpo11/yChXYQjm4PP9BL0xJbBgD4OdItx5AK6jNOnssg1ELG18kr6zBhdEgJ/1uCkZJH2v5+WQRTjSXwHp5QF33cQRAw5nGLgWJjOnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmBnFt6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22715C4CEF0;
	Thu,  4 Sep 2025 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756995035;
	bh=BACrC4AiIber5Zuuc47irRT/Y/gn7ikQqN2P8YNP+DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmBnFt6qcCNecDJsniqr9ZPIsu7/Pd/2R1OkSMO2qR2z7Lv2O+D3rtmESbgjmykE8
	 Q97YJEWYQr9ycAJPaQWWHoiHqDhzHBezJ5ixs5AziCEsl+sUT2zo8Y6R3oBrqOhqc7
	 hNvaC/hA6SY/evpt/ktd+iAIY6gFw3xzjOBi2377XEIOGw1BU++xUmZH0dkkg2AdGC
	 5VRQmTsm/IyVpeCoxMPRyUnHaIK0mJhB3z7h60+TySgtPPUZGZ1UBnvE9PWLvj9/rX
	 z3bJkKideyePJzPLTqUk2Gs4biAtNSMMm0hOQ6NiheHxHe3PaSP/TBVUt6rkukoYUM
	 oC0IbgWxMJtBQ==
Date: Thu, 4 Sep 2025 16:10:32 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 2/2] LoongArch: Remove clockevents shutdown call on
 offlining
Message-ID: <aLmd2KlBzFxJc21r@localhost.localdomain>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904071732.3513694-3-maobibo@loongson.cn>

Le Thu, Sep 04, 2025 at 03:17:32PM +0800, Bibo Mao a écrit :
> The clockevents core already detached and unregistered it at this stage.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

