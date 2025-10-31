Return-Path: <linux-kernel+bounces-880823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C84C26A83
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2858F1896D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6142F1FFA;
	Fri, 31 Oct 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v1O/vyF3"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279CD28643D;
	Fri, 31 Oct 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937092; cv=none; b=HaB/0LMg/uum+6uGS6zUyJlSxA3bEgL8+2rxHzqpRk4zhyCxfXr7eDpfNVjWh7Yg0WHr/ncYENKxpdkec9M8paV6VONopGFGZTW1kCiNYdlR+U9WVeo06/+CeSHTZXfd8Bft5ksFzBOuab0nL3yTM8/CbcVybOauOFBJGRDZxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937092; c=relaxed/simple;
	bh=l88U0e6G8AFbeWF8UC9BzljiT8rhkhzT2jh2CXHjuwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tUqCoQrv6NpLVPXZF0TYIk1OJBu/Ewz4pEIPFY8WxBHUBH9qZgCkUQ0Yxk9PUReEKUXFDQwaJsIHlKpQP7okwWW4cLq2+4N0Gl1poFpzcT7NICet4nYWExLFW5zCZSqGBlFJEmbL2GGqmocGvCVLKYh2KHBHhIrZ7t7Vpn48nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v1O/vyF3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761937069; x=1762541869; i=markus.elfring@web.de;
	bh=xCFB1k+U8G/katsdVnXIlr1OsTRxG1sRhgLyFr3nUDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v1O/vyF3rRHt/MIptn692Lw9CDyvezAXkJa5/ErkoXiBWMcMG+jEXjMKuaC71aSt
	 K2lFMssjJK3h5Lm20AkyhEyLOFOrt1AMnlI+01uJ6IdV/x/qWiBv/Mzv5ftvRmRAB
	 fnWLCWYx6DZVH/9i7Uh5MCHM/l/ePSOYr5eH0V7fLyH1NYTa056qWMzEAtpO3sp8B
	 E25BUkauUaCZ/q0bz2mAgXBwUK3b7KPbg4GO19eeTvW3o2A47Yw5FrPo16BSXkZH5
	 aLPI3+MAcLxJ3DFHh8W5xwAAhAFof1Dc/R0jCNi3wHiUr2gFB+fl2iN+u9fLMR+n1
	 5DGnLsKC3Z9bSgaooQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1vxcit08AM-00auDl; Fri, 31
 Oct 2025 19:57:49 +0100
Message-ID: <b542b028-4f9b-44cd-aca7-5d4977c2faa4@web.de>
Date: Fri, 31 Oct 2025 19:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: greybus-dev@lists.linaro.org, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>, Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] greybus: es2: Use pointer from memcpy() call for assignment
 in output_async()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VC/dqoja5zTdKmSiDP35CnR2TVkFTm5rUKklub6tNsfabEo7R1d
 GDWXGjgZizekYES25WstRTaQDY6UzamDlAzdRUTBN8sOQ/zeyGkQcjwxUYojNDyVYkc6mc5
 E4IZl78z98FPP99tI6C85XeJ/sNQHfp6DPNwedkh/Ze4a41tCVrI8Dab17YyQMFiouqRsg2
 /d5EHqqtF9V9Q0ba4ZiTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5BnxZTlOTC4=;WtpIBY5e8lDMCKGS6Qhs/aRHeA7
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 19:50:39 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/greybus/es2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 7630a36ecf81..d71d37b41a66 100644
=2D-- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -194,8 +194,7 @@ static int output_async(struct es2_ap_dev *es2, void *=
req, u16 size, u8 cmd)
 		return -ENOMEM;
 	}
=20
-	buf =3D (u8 *)dr + sizeof(*dr);
-	memcpy(buf, req, size);
+	buf =3D memcpy((u8 *)dr + sizeof(*dr), req, size);
=20
 	dr->bRequest =3D cmd;
 	dr->bRequestType =3D USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE=
;
=2D-=20
2.51.1


