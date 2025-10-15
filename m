Return-Path: <linux-kernel+bounces-854058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF7BDD716
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A96426923
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2AC3019C4;
	Wed, 15 Oct 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tYotcLtk"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC92FF144
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517224; cv=none; b=ZF2m6/LwEGOySu8AkoVKvPe5mUPndbyc503EXilZOjKXEbm3QqpInhvuYrZmX5UxkyNfdPWLxq/8zogwmfUSqLKSF7mE+OvHw6zWSR1grRY5FJlTyJkwnfZm4XtpTCuYKdU1UdCVMMQDo4h70gpzcBCFTGkvtWmwoBDtSyB7W8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517224; c=relaxed/simple;
	bh=HLbScKqfgNU0e8fT2oS720WPgTjPkNXGGW5M1WMsmro=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UK3/x4KEB8o9DsaV31HTtazQcnf4IslgU+2MIH+H2Kjv94t71OEMbgILudSE6mMj17t4F5TFdMwx+B/XWcCrAPuRct7znU4fx8104u/oEAWzfU58ODIAUR8nUrnCXH+HOiZ82sHqoKe1icWgvmBPgwefj6PlmsZJdE/d138bvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tYotcLtk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760517201; x=1761122001; i=markus.elfring@web.de;
	bh=HLbScKqfgNU0e8fT2oS720WPgTjPkNXGGW5M1WMsmro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tYotcLtkUWrj/t2knlwZvvMr7oawRYplCkCtezikj9X9sv7FOo/khfB7jlGG4Ujo
	 OIo3Pu76RyD9r4prCkwbQJUR2PfojpA0Z4SXoGfOOmZf7NbVc1NXfPVn5EMMznaD9
	 hlVwhlv8xB7u1BiyMENeaAxxargrqEFr+4YxXCUuMDc+EDsCjZ9GZzNZxRHKKU3K1
	 /2AszAN0x3nICNE0h7E4vUk6cXx1rGIs2a+c3Vrhkkm+gBW37Vt7SaY3GekYpUgH5
	 y4ND9zH+wy5Wjjd524brhe084H2523U8PIpxFXg+53dXM1EermLE9Lj4aWxPqMdWY
	 9FjQ3hiZ9EisFh0oCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MovjW-1uReBS3oru-00qmAH; Wed, 15
 Oct 2025 10:33:20 +0200
Message-ID: <9e72bcec-cca7-474d-8d89-4dfb1d5267cc@web.de>
Date: Wed, 15 Oct 2025 10:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, support.opensource@diasemi.com
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Lee Jones <lee@kernel.org>
References: <20251010011737.1078-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mfd: da9055: Fix missing regmap_del_irq_chip() in error
 path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251010011737.1078-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t0JHj08ykuRws7sPa0y0w6HROzZRQqZN5PaTx/ZYpHZrFvNlX70
 5+a5HwzgbqoJuL77k674mZS2Iyj0x8LDNqT6qjVQ94JTUtC+umjVYozFzxm92w/UEdXf3ZW
 prwdMNVFyTjE8qCKaOy7xSSx7GBdVAd84RGcRzpJHonMVQyOpnvlPkS7Nre+X9PhdzsxIQI
 f6eb6vuHRpfoIs/t8SUeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QNQcxALASW4=;XilkazN4+ERkWFiDBo6O9xOt4l9
 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
 aeKWg==

> When da9055_device_init() fails after regmap_add_irq_chip()
> succeeds but mfd_add_devices() fails, the error handling path
=E2=80=A6

You may occasionally put more than 61 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n658

Regards,
Markus

