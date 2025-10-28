Return-Path: <linux-kernel+bounces-874261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77DC15E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A6A42268B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C4331A46;
	Tue, 28 Oct 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O178C92k"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8B2853EE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669378; cv=none; b=SGDD4DUEnUXdKBMlfSE8CzWlUY4JiJaf1GT2Qac+q9Fey6ZHZ8tZgpKWwIhR1uoWBegJfEnizxZqQLMPZcFlLK6etYhaFjZPW3KaKy1CC/fW61TxDaQ6IPMxIX651OWPsgyKV3LFB0GoznwpMid2vpby/mGFssdFmNZwmT/3Bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669378; c=relaxed/simple;
	bh=zUMVDa3K0EwPPg9c067nMYCNMAlqQ3g6qoUr+kjAY78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eT9qzd/V+mtxqiVVlYd+ps+vC6yorC/Qw0u5bMXDZl0gj6FwR2QbQNRq0mWFUsp+wt/5CURByyoD/73UCtaENx8jUOKd4uoul2KNhYkM6dWwDr8cpL219YXBOleR15+e4IQjmC32yYZ6P8cgcnC3vUv061x3jk30txXQ4rZp6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O178C92k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A8241A1706;
	Tue, 28 Oct 2025 16:36:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D88BE606AB;
	Tue, 28 Oct 2025 16:36:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4412D102F2428;
	Tue, 28 Oct 2025 17:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761669373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jy+hJl/47FF6YCBFsdI0OKPe5NPf2NSP+WXuhFA827s=;
	b=O178C92kv0neOXHpUUG93PzeK+Yj7CrkAj0A22eXLcL0wouUiRTksR2zSf7SMaJBP+x7Tl
	PCOXlXO1tkF6GXT273wlmPLQj/jNgsQ4L46FnONQEISHtzXJLKpGqQ/pjutEK29/FO00WJ
	bD1VTQ90XeRpwI0YZK8/VXSLeyPzNEPMqZaB9BRbKdhY9kfT4n7jhtIl6Xk1hhPs+RNA5Q
	LG5LvbFlMx9XsOh1h+foQHanN47Y/yF4WQQ7SaSrs4lBEiQE/KVnz5qiH7OPvzFwoSi1bK
	OTM6GmddaysBzYwaIt4U+Fxj8STjINIcEvRbMSOVJ4rM4Q21yiI+ly5alA1DXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Reuven Abliyev <reuven.abliyev@intel.com>
In-Reply-To: <20251023122103.3922113-1-alexander.usyskin@intel.com>
References: <20251023122103.3922113-1-alexander.usyskin@intel.com>
Subject: Re: [PATCH v3] mtd: intel-dg: wake card on operations
Message-Id: <176166936945.372081.4265876378064521705.b4-ty@bootlin.com>
Date: Tue, 28 Oct 2025 17:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 23 Oct 2025 15:21:03 +0300, Alexander Usyskin wrote:
> The Intel DG cards do not have separate power control for
> persistent memory.
> The memory is available when the whole card is awake.
> 
> Enable runtime PM in mtd driver to notify parent graphics driver
> that whole card should be kept awake while nvm operations are
> performed through this driver.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: intel-dg: wake card on operations
      commit: 3e9c49d4c3063dcf7ddcdea4c5e3aa21eae359d0

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


