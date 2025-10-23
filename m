Return-Path: <linux-kernel+bounces-866899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2070C00F81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9413A3A10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D643D30EF7E;
	Thu, 23 Oct 2025 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="dOC9oOZ3"
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D38298CA6;
	Thu, 23 Oct 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221123; cv=none; b=gfav7/6WwhhKOJpNBQGgBJdqvN60OJFcbJjEe9whBA/78qzTy6Y1wYoFRL8wQc8yD+Syf2RkILE+Yx6k0MIc+Xnlb097heKqEiZu5JgnSe+e0Gtmn58myuObK+6jLsno+ZsmaSqz0Srpmc3+hVbxjB9BV7g7OATGRbe7aEHaH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221123; c=relaxed/simple;
	bh=3k0NUeQDwjZf1pkCpBUsVQA3kbq6yFLrPLifdQ5IT5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApcJm29ihCwrrRRe1C6fxA2sqF0aWCBo9hfVR1eAKV47BsAK1ENk4LycytXU+4IflHir25IeWBWTk9nN0Os2SKwVS46QeQmgD7VmnQC+tL4gFcJdPPYYQSznYFRRofDicvo7tL4ZXHto/816251jtYxGDPAF0eRIDhxQ6+YTf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=dOC9oOZ3; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1761221110; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JTOkdgREhZr6P8sc2B87Q0nNG83Ch+Fq1cqU5rxpBL4=;
	b=dOC9oOZ3uqFX4X/9aAQYCbXNz/zXE6pLfmFKEUUjCTPGI0e0K/MKSXzS7VQeqUaeNt/u1xtRnXu1VOSMxNvmV7vUBXOPKlG2dghtzfV8TG8IOF4OjjecYSVCZ/34Wa/bNkYUR/sJTecw0aNJHD6EK/gBIV5M6T2yESD9aTU9Kdmq6ylZv//zPeznhWWIXbfGyVm+a7Gm9z4HxOdwryRWAauU6pk+An7Y0Gq4MjN3hX7IFmL6LwuJGxLyQIbyiYwJp+kRfYBecmVv3fhGDJhTLrTHsDzftAw1X6bMt3iiukPjLl08MXYtoDDI9jcGdNymzqIwJK5+R7yDg4ZxgC5tog==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f5erwzP_1761221106 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 20:05:08 +0800
From: wangweidong.a@awinic.com
To: broonie@kernel.org
Cc: alexey.klimov@linaro.org,
	ardb@kernel.org,
	arnd@arndb.de,
	cy_huang@richtek.com,
	ebiggers@google.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux@treblig.org,
	nick.li@foursemi.com,
	niranjan.hy@ti.com,
	perex@perex.cz,
	shenghao-ding@ti.com,
	srinivas.kandagatla@oss.qualcomm.com,
	thorsten.blum@linux.dev,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yesanishhere@gmail.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/7] ASoC: codecs:Rework the awinic driver lib
Date: Thu, 23 Oct 2025 20:05:06 +0800
Message-ID: <20251023120506.35628-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ad81a2b7-5df4-4e41-9bf1-6949723d43b8@sirena.org.uk>
References: <ad81a2b7-5df4-4e41-9bf1-6949723d43b8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 23, 2025 at 12:55:49 +0100, broonie@kernel.org wrote:
> On Thu, Oct 23, 2025 at 07:50:37PM +0800, wangweidong.a@awinic.com wrote:
>> On Mon, Oct 20, 2025 at 02:40:32 +0100, broonie@kernel.org wrote:

>>> This doesn't apply against current code, please check and resend.

>> Thank you very much for your review.
>> Could you help me? What caused this?

> Whatever tree you used to base the patch on is different enough to my
> tree that the patches didn't apply.  My tree, as listed in MAINTAINERS,
> is:

>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

OK, I see. Thank you very much
I will replace tree.

Best regards,
Weidong Wang

