Return-Path: <linux-kernel+bounces-884640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCD1C30A66
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E04A44F631C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2BB2D838A;
	Tue,  4 Nov 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YGrnmVW6"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747F2D6E5C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254162; cv=none; b=DvXgYBc+dABq1YlL6JVovBPrUqwDjeUjTA2O4OOvSKdpd1RCeFZ9kOM3OI+n8VSQEtXF3KX1AKUSpGFRsi242Ko3eBvXgzry4d2TTi0julDMq5PDEF70N6kylzDGIfhssrBAbNOOjJNuCNcOrXYPjiDIa/mGfqCVS8fl9w2suEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254162; c=relaxed/simple;
	bh=T7PqefNfjMYS07MvKDHImPv5OukVJV33UR3vABr4xjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hp+sfOlaD92uWKYdAEQ/byIp3hZ5ArsCFGL60N4rW7Is0Jb6+cNSXoe7KmIuUcijjuwR84gRq2KTt05IhlyaZD5eltfdQ6IEPlpnOSkR4moOh+SnoN5EYE8ix2dm1muYzP4YOnkBMJ+z/oT8afbxwEff01seGo35UOoe49PiiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YGrnmVW6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 180E94E414F2;
	Tue,  4 Nov 2025 11:02:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CACE5606EF;
	Tue,  4 Nov 2025 11:02:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22356102F1CE8;
	Tue,  4 Nov 2025 12:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762254157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2TP6j6kVWFU+uNt/xtNDwC6uqXMzP7Iu2p5iTCWD3KM=;
	b=YGrnmVW6amOtuJg6/NMM2Mqm0I76RF0PzJ3IfIKpU4E35XPiGOL2oiw0jjTNjIoEEEfB7R
	Iy0kllRDfBHPkpJ3WAKcZAij5V4kTAlMT36HkI+o4oKTQ5v7ozqa6stcFG2GUlpyqNQ1+o
	pBpWJ2hSvq/fzo2GE7Km7HRsghIUICZUi4w0pyHlyVA9iBqTYYiq7t5Ms08kwCbyk1issT
	GF6Zo5+61njc+SlhHObWLJ861+kEubv/KAzIREKgHPipxqmOkSEqpqEEwYDUGNt4Bevyim
	yk6CQPc2zYBgLRYixkYOyjvjUxyxBk5WrUb63bk0u0GbESKVQDMwGR9NhPjuRw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com, 
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, corbet@lwn.net, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251024110014.4614-1-jose.exposito89@gmail.com>
References: <20251024110014.4614-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH 1/2] drm/vkms: Fix run-tests.sh script name
Message-Id: <176225415494.422810.7112986302756262297.b4-ty@bootlin.com>
Date: Tue, 04 Nov 2025 12:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 24 Oct 2025 13:00:04 +0200, José Expósito wrote:
> The script is "run-tests.sh", no "run-test.sh".
> 
> 

Applied, thanks!

[1/2] drm/vkms: Fix run-tests.sh script name
      commit: edcdd00099f1b755095dd770c9cd5d3374e49ebc
[2/2] drm/vkms: Update testing with IGT IGT_DEVICE
      commit: b63300ac4095f892a8472a82f465fdc7c63a8c57

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


