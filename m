Return-Path: <linux-kernel+bounces-855989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3FBE2CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D9D5E03FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6532862D;
	Thu, 16 Oct 2025 10:20:26 +0000 (UTC)
Received: from harvie.cz (harvie.cz [77.87.242.242])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544742571BE;
	Thu, 16 Oct 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.87.242.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610026; cv=none; b=XvowIdVtGJrMrdTWDDCXmnaLkd7ZBp3XFrhjQIR7GjaqsaqjccLeat7rSjesLrpe+Hjc91tsaoELITqDsLMUiMwNEZ+yxHkLwj6xjWLnkaFQBuefatKfcgyL2GemCwOGgtmpZ8jDK0SEH25XS3LpB2mioo96FAFSJA3XLw1BE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610026; c=relaxed/simple;
	bh=agXcdvupcHtoYe4OlnCWGTdViIU+m3roIcFK4YETR7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLqxWsTjR9jES+ubPWn/rb3ozIaJWwu/Zm372M0vCFc3BaFDwCqkUvmogOrCgiu+zcVl0+XBp68wd16gMT+RvIiTILa703hask0sk4EPdukz+1xZyFxBWqs080IeXBxYQ5VwDhkbYQEOKPmimkBDPh8I365u1yx1Pg/xHzJTno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=77.87.242.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by harvie.cz (Postfix) with ESMTPSA id CBBAA18000D;
	Thu, 16 Oct 2025 12:18:16 +0200 (CEST)
From: Tomas Mudrunka <tomas.mudrunka@gmail.com>
To: corbet@lwn.net
Cc: bagasdotme@gmail.com,
	cengiz@kernel.wtf,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	mail@anselmschueler.com,
	tomas.mudrunka@gmail.com
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on extra /proc/sysrq-trigger characters
Date: Thu, 16 Oct 2025 12:17:58 +0200
Message-ID: <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87wm4xbkim.fsf@trenco.lwn.net>
References: <87wm4xbkim.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi. I am author of that sentence and this is NACK from me.

> I'm not sure this is right - there is a warning here that additional
> characters may acquire a meaning in the future, so one should not
> develop the habit of writing them now.

As you've said... I don't see anything confusing about that.
The warning was added for a reason, because there was discussion
about some people writing extra characters in there, which might
cause issues down the line if we refactor the code in future.

> After all these years, I think
> the chances of fundamental sysrq changes are pretty small,

Actualy it is not that long since the underscore mode was added...

> but I still don't see why we would take the warning out?

Exactly. Thank you.

