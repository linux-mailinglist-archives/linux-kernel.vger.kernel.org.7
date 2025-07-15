Return-Path: <linux-kernel+bounces-731468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20843B054DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D257B7169
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957502750EA;
	Tue, 15 Jul 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DbLxiCOK"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7599226CF3;
	Tue, 15 Jul 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567941; cv=none; b=RUvlDs3+B0DjHhipmJtLqXWIjYxFuyJXqGWBZzuho42D1TkmMRPABAuLE6s5C7fViUGt/sa1cza17VcevHSbABtqcT4/T020cMkH/vI1JFG2gKm9fproajE74dvvOvNTIPRgaKnuQ4BROac14X7P3yB1hSl0GYWWbIoqVcyLRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567941; c=relaxed/simple;
	bh=5xo2ccRAS5XbkDdyTzf+vJYusaDzq7W7Wkx2byXFpaU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ftDelqpr8RrX3t9LEWajFpXVMifVqJ5iuXzX9MDVtro9DjBx/8CXy7keum7ZWte/ZjnjESnjJeUonR9DEFda265E4qtrjuOuKMVmNGDJC1Ck53dCX8fQCpgbXB9qHT/feUVAiZkNagQdP+Nzjh+Is/hZ3vzp3V9xjfvzQpLpjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DbLxiCOK; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752567616; bh=2iIZo/u/jQCMUWuQnvAc1ZZFLmAN7Ex9YCytpWU0UvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbLxiCOK1s2dX93QNPF/DuWrFnBYrUNXSCbW59OGdMVnukW7oncmKUleaIssop82V
	 trbe46IROW1gUzO+Gw3LeByQhFMnjhS8fPkyITc6dC4wTki0knj6TL8iTWvi6Zu30o
	 mgVkFTGyTn+qVlpHvRjAqvjMezK4XNH7z2Mqciho=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.34])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 50F2AE42; Tue, 15 Jul 2025 16:20:15 +0800
X-QQ-mid: xmsmtpt1752567615tiw4fqmjg
Message-ID: <tencent_AC052534ED0C97ED96CDBF2269E71DAE5905@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GfLv3wfAeKBbf/kuv6bg0Mi2JJUhdd/OzPmoj8mRUZAebbGDpms
	 7zmFXvq0EoSmZtzOt0JMHP2b9aqVhmAvEQ4873uslbZHy3iIDUDSfzW8SkQFHYWN0UTrYHcB+7wL
	 KSjwexLdlMZyQjtTA/TB78cgmRZVN/yyb6zzYjpnwtio28og+xi2kz4CDm7djLO4jDlRjE+xPHdk
	 XXcXJ253NkQYNxW6gxbHI9J22SEjsxCmKsraEJ+SLR54Gku3G5+PHuUZnrrf00qPpHLFgfdeySOd
	 W6gNICBPRbiIZcXzunRGyEMcmHWtpPMu6fTmWobV1F0O4/dO7d4tnT+x3LfigjAJsRfaX5mTrzRr
	 lVDIQj6QzAEYdtDTZNwvwFJFwLN3D7Ljup3rpdliZeMy/LQ5lhfxvAwfsb+h9Z0q77ay9Jo9L4lw
	 hMMbGAF9HAlh6uth3pKYBN1YIQktD47NOrSf+DajaqxEY1XuSIQ2iIFZwK0UIxwD4eiX82YP1Hoz
	 pElCoWpSDxxZN9xKkp6jX02DyyUamnAKSRT4muIHGkDhDtM9Msv9aa7hOCGPy9YoKNEO10/r4vJq
	 b/bkmx/NwzvCCg5tBTizj8Eqsp6C3X6plJod5OM/6NFxzessA5NB2u1KlE+xH4Y0lG/1FmhQrDPP
	 Nb8/296I3m4SnKou4pJcmHnJcrPssvhdu9Xiw0huWLjzBfxFmQGr8CsHDRcUFWundx+URVIqIofc
	 +s4vhtyhew8rFldY3+VmtNDJSmPdlmIpeW36Q9ejAg6azve2jXHoqEHPFQZf0yFu/YsobF2YyZMA
	 YWwu553NXLQgXOGYFHqUNf7VKjveaUBMfec77+EwWOt8X5ytyGqtrIsAjwLHuWOV07KvkLzwwkdN
	 Sy0EK0RBjibtj1L0C7blJ5SNyL8mUtOyi/aUnuvS8Bx826TKcRiMqrvnWGg1KxblMFgWplL239Hu
	 HztQbWUim78AwPObg5/miXWF3Z2KJ5Ei5uusCa9Y6Zctfd7uhANZn+LrHjNodaUBGSLu/nC+XZy8
	 tkSDF4GABHw39oPb5Ybz73bokHpsn8mRUZufjxlwkbCi0EmWKyus3YwPooYOM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Date: Tue, 15 Jul 2025 16:20:09 +0800
X-OQ-MSGID: <20250715082009.3136874-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025071116-landline-antelope-5c9f@gregkh>
References: <2025071116-landline-antelope-5c9f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 11 2025 08:51:30 +0200, greg k-h wrote:

>Yes, and then look to see what buf_len (not buflen) in
>gen_ndis_set_resp() is used for.  I'll wait... :)
Oh,my bad.It seem that buf_len will only be used for some debugging code..

>What tool generated this static analysis?  You always have to mention
>that as per our development rules.
The vulnerability is found by  is found by Wukong-Agent, a code security AI agent,
 through static code analysis.But It seems that this is a false positive..

>And what qemu setup did you use to test this?  That would be helpful to
>know so that I can verify it on my end.

I've add some web-usb device to test this model.But seems that I went into a wrong way.

I'll double check my commit in the future
Thanks for your time

Siyang Liu


