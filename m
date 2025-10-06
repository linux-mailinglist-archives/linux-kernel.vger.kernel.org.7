Return-Path: <linux-kernel+bounces-843442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99462BBF306
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 760314EB9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9A25B1D2;
	Mon,  6 Oct 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSZF/EXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175DA932
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782588; cv=none; b=K3sO7bGIBBPDj0byy/3RNr6duMQfUBNpgzj4G4+H6hdiyjPby1x395VQo8mKSGZXOHPLNoISPjZY3ARwpzHSz+mJYBrTd/G0tu6s6yajymEPfdg1RrRqkMHmuSgztuuXJSyISc2Q50Z/OKCQf4Ifwx7ZwKmPn+q9y5e2fwBas4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782588; c=relaxed/simple;
	bh=y/7OMzRn5Emn0tuB5k5g03xdsBv55C6TulHJkQ+VKnc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=usCGwdvEY5YlGq/SPFBV5bSnR2fTY+XnHXUVuRYcWXy6ojnaZzUM0MU2C5TvoPjhQ7JmI+CxhE/+gFD/Gz4iByHVeGM/9QGVYnom99YfGX64ngcnKrulNtzEZO3vmB+upCaQceMVlp2yYOBjKZblc6a4g1xMnsAQppI+l3yK9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSZF/EXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F4DC4CEF5;
	Mon,  6 Oct 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782587;
	bh=y/7OMzRn5Emn0tuB5k5g03xdsBv55C6TulHJkQ+VKnc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=HSZF/EXwPAWIcHSQ1nHZRon6QmHQEqH/Pf+/Sx2vBDBwHUcDIzDlfS+mp/ds83k4Z
	 Bx7fnV+g96ZKAJH3GYD06SeCQucOx2jWGieNhrAftARr0ldoSWPPDDNZziJDjeVfXS
	 gAA68TW89gVWVz1SJBNlHlZm4MlHiCEVaYZJpdY4FC30UCYVDIy2aKh4gHrWO6WqTc
	 stPAlxvehTg8kdv6SAfDWCB7BIqbZG9q3uo7lBK1idVQi8MV4qGTcDc6vSyEewcsXw
	 PZzE70Li4zIVDa0YzSSBT04RHp0gaVh5xXAZtAgmSGq0nNqlIg6YkJMRdzoetVPzfz
	 VO/z275MhrKag==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 22:29:43 +0200
Message-Id: <DDBIV2C6FH2L.3NH6D76Q26GYD@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Mary
 Guillemard" <mary@mary.zone>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1
 to report new features
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-6-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20251006191329.277485-6-mohamedahmedegypt2001@gmail.com>

On Mon Oct 6, 2025 at 9:13 PM CEST, Mohamed Ahmed wrote:
> This is so that NVK can enable compression for kernels that support it an=
d
> avoid cases where an older kernel would MMU fault when a newer mesa would
> try to use compression.

A slightly more detailed version of this would be great to see in a cover
letter. :)

