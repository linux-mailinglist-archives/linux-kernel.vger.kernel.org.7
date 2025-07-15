Return-Path: <linux-kernel+bounces-732111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2097B06224
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32DC1AA7591
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9861F463F;
	Tue, 15 Jul 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+vX6L5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F751E531
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591269; cv=none; b=djp0ZbLMkWnVdwImesG/aWuhtR4m7T/3+O+dDeo3okBpdUvGk4vsxuuJhb2up6clmuP5eunowL5L1/qGl/0iAppKCDBhg1ipKdaWIdBspg7OKbAIqYlWAb325h/IbOoiZj4ZeFcncjZC1PKvvOskKfgbOb6mktzx6kEK7LLWqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591269; c=relaxed/simple;
	bh=IyaIAVrRwqjSjx3w+EovwoWjVs8hey8b22zLuQa30+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQPuZgyFOKEuuA3mpsFsqQOxfvKpdmVvknub5hfVoQ2hkVhJlmJCaZitfty16LqDT+5S3RlYxIeV76z7mLanRqlGBNy90m/JeZM7DMPyALKM3pMme3ICYGCSDXxs9edOyH6t2XkrxFRsl1f1DmgG+t62WtA6i5SvIO96PtVGCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+vX6L5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEB1C4CEF1;
	Tue, 15 Jul 2025 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752591268;
	bh=IyaIAVrRwqjSjx3w+EovwoWjVs8hey8b22zLuQa30+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+vX6L5w9IpHySv8e7E8WjLtQrp2XL8l/yGkbPHqTMoyCXbOTz6TwMZNh6aHyAFzg
	 KXVVy2XoZZ76MM/DefwbKm/dEvJnWF/IL6e4sUmos7344qHVB3u2evLDM7MMce+RR/
	 wOLZ8T1qyLsj1Aya3ZQ1FVefbam0TkmBb/BLco5M=
Date: Tue, 15 Jul 2025 16:54:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Meng-Shao.Liu" <sau525@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples/kobject: make attribute_group const
Message-ID: <2025071506-bundle-fondling-6a94@gregkh>
References: <20250715143035.27437-1-sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715143035.27437-1-sau525@gmail.com>

On Tue, Jul 15, 2025 at 10:30:35PM +0800, Meng-Shao.Liu wrote:
> The attr_group structures are allocated once and never modified at
> runtime.  Also to match the const‑qualified parameter of
> sysfs_create_group().
> 
> No functional change.

This line isn't needed, as there is a functional change, it moves it
into read-only memory, right?

thanks,

greg k-h

