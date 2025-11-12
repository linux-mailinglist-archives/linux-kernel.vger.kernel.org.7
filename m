Return-Path: <linux-kernel+bounces-897976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B672C540EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C50D347456
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764B2E0412;
	Wed, 12 Nov 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PWj4QDuH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F033A026
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974260; cv=none; b=M/m1C6oL8FU+k8N6PtHLCzXOXkA0RgLCpfOVRJMX7dAIEHCt7GNnk8+8tcFi/2cQXO6qe1u1qC3WqeB1ZdVvXl/piEp0sueArBDFBn8eNNwtH8RQb55VfvsqNezM8BaAJDRBgrkNvM9BIun7PAXc/b5mdsB3KXgGUo0F/BYdElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974260; c=relaxed/simple;
	bh=846hT+dGW211Y97I4IbWEBRKXNXlQZwQ9OpEY18U14Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tT2LCgZIvLRt6zg1O5N6hk0YJNOEMeEr1XXJFaig9+GhD6BzZYZw3+dntNV8lW8uRy8xrSCtlhhfsmNxx6OkuFs1R2p+lgbg788xspYOlXzbx8H8MHJryuMbj3b97wKsYWGbPiJAhvUm2pyRaRZ075uGWxwmWNJvWES2TW/VQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PWj4QDuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE58EC4CEF7;
	Wed, 12 Nov 2025 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762974260;
	bh=846hT+dGW211Y97I4IbWEBRKXNXlQZwQ9OpEY18U14Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PWj4QDuHQQgsViPtOYCFo6E5vmELiJv9x6n+wYyYbfFHlfQJFhG+EYSrNdsMG2GDi
	 Qhx5UbFl+KSJoyIW6OdH9919yhJngw2TGV2yUviea2XAyi6L9Nydo+/cW73Cddgtbe
	 lcOMh87/sbxZRNdGl+m9hdzq3xJlgs5shY2+R1No=
Date: Wed, 12 Nov 2025 11:04:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gustavo Padovan <gfpadovan@gmail.com>
Cc: linux-kernel@vger.kernel.org, gustavo@padovan.org,
 dri-devel@lists.freedesktop.org, sumit.semwal@linaro.org
Subject: Re: [PATCH] MAINTAINERS: remove myself from sync framework
Message-Id: <20251112110419.59be3dbb1bb297ef18ed9739@linux-foundation.org>
In-Reply-To: <20251112134330.64130-1-gustavo.padovan@collabora.com>
References: <20251112134330.64130-1-gustavo.padovan@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 10:43:30 -0300 Gustavo Padovan <gfpadovan@gmail.com> wrote:

> From: Gustavo Padovan <gustavo@padovan.org>
> 
> I haven't been involved in the work anymore for some time.
> It is only fair that I remove myself from it and let other
> continue to take care of it.
> 

Thanks.  You could add an entry in CREDITS, if so inclined.

