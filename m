Return-Path: <linux-kernel+bounces-723655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606EAFE98F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AD648038D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE22DECAA;
	Wed,  9 Jul 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOLw40w2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F162DBF43
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066118; cv=none; b=kkIWnas30c1/aifAbQoiqFtE/XJoHf7YYvjvkaAOdpezxZN5qLlYXz6w5OVe2wX3S4oT+VvYH0gdJGS7UVm8pvhLqdNieZWlXVWYINK6oc2jv7gXJZUjQknBzMjWaAgyy1KwHiITVH0mJIpuXF0YqTs9GnQkjfFK2Y2BNmiUS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066118; c=relaxed/simple;
	bh=dgldGePdo0xYCQ3xi+K9t7xCMnl8Jb1Lx8R9fGeh2ro=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ngbkoHf473P8XLk96JQoG1yrpjcxJ0vdretipnz3QKt0WOa6M3fhAq+01Qdb3CQcmsB20hc5RuhqAkS606PPDsVrxLQA64Q9vgUZZTE/496wmqONdFWXHhqC0LsP9PzbbcDFb1tgb3ED2lHJebL3zxYGWUSzkSOQ7xxff2eokUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOLw40w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F1C4CEEF;
	Wed,  9 Jul 2025 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066118;
	bh=dgldGePdo0xYCQ3xi+K9t7xCMnl8Jb1Lx8R9fGeh2ro=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=uOLw40w2x4vhX18cvGXbjND6UpMxhTx0tb90K1KNDdtH+Pr8CcxSE20fAKs3+8mJN
	 VE8kvGxD0pQdzJO5fj39D48ciB+7EY3Avi523Fj/JzRyf9zakrwJN7ZMXcHocSS1XQ
	 eQQm9A61bu8HtlJFzOsSynnhp537l+hNgz6JwfXsr8JlviH+dAW+hGAY9Zev4RQsI8
	 lb8jYmDKb07tOFD1fZ5/n+zCzTL40W4//PKNaKJQH28HZoxmmfJZ1X/vAFXihwU0Az
	 QmpjJ9Pr0Q2G1QNNsiMZWN3Q0y7MI+Kfglc9u350PhpURdVPxb/x1JkCl0qKYuDyby
	 v1mainYJeTViw==
Message-ID: <36860f45ff9311707fcf4028217466bf@kernel.org>
Date: Wed, 09 Jul 2025 13:01:56 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 2/6] drm/panel/truly-nt35597: Use refcounted allocation
 in place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-2-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-2-630902123ea1@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Jessica
 Zhang" <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 8 Jul 2025 15:35:14 -0500, Anusha Srivatsa wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

