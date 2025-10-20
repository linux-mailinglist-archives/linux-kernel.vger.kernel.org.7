Return-Path: <linux-kernel+bounces-861319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4EBF2629
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A98394F2B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91B6287502;
	Mon, 20 Oct 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vtD6OWsD"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262027466A;
	Mon, 20 Oct 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977418; cv=none; b=c/+uXwKiX+kQk8uJ13Gl4Q2eIzC0m4wNH5ppcMNF9A9gVNkEXq5zpVaf1Y87T6EtZHqdfNCy4F+8A7pvMEu+BYthsyIWoZf/voEK9fTgGdpAPXqO7G9SnbDON1tGu2T0+3NfPzjyfzIdGIjkmfQ6IENC6sUCVJjejJR7bZOMnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977418; c=relaxed/simple;
	bh=JfputTaagyOKyILPWRhpeCfvLuc4tuDus7eBKI4Kz7s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gSY+6PGuhAiEPMg2HYxLP/FOIbYCYAbxSFlkGVilfuWjKKpPc5S3c2+IyZyDgugaVteRTseoryGu33Q7qYekvSh6s43noPuJWpTgcmFJTwOA6HUZZRK+OQF9xuvMqbqcITFVNwu7raXfqvTVFzp860d5NEBKRaMKNMGYG2ClLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vtD6OWsD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760977409; x=1761582209; i=markus.elfring@web.de;
	bh=6kH2p0lzoeA3+NA5VGZgTRxycOBmsbfgJvGwJRzjTXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vtD6OWsD4FUgYci6opjL0GQtm/61X9d1SlZgn8ZhCDgwtjsvb6uMGpbc+vlK5g/o
	 0uR4qqUlC0A8eas0sFt17BUtI1b1j8KPKxLOzE1YQ+mbR8mcjvVWucdzQsc5/+0/+
	 5J4mXRDIp2b8w/mponRcMy/Z8dPDFBSmeDp6SYtzr75w5eZ05rxB2IY1A03SOAWEv
	 A5H9MHlsE6EZkhpDf7swN7vJws5yBEn0v6O6ZHDWkeXUV2XJTt+Z8IG6I9Z52dg72
	 rpEmlm5xc8PtHzNP1h2URW6X22PemVjyw/moHc62Ito16V4n2fFqS+WvV8y08S0Br
	 3FY1RQzunKJR5N6sDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1uiTvs2SPB-00PgpG; Mon, 20
 Oct 2025 18:23:29 +0200
Message-ID: <115fba03-e8ba-4bc1-84d8-7d483c06208c@web.de>
Date: Mon, 20 Oct 2025 18:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sound@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Colin Ian King <colin.king@canonical.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Colin Ian King <colin.i.king@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ASoC: rockchip: i2s-tdm: Omit a variable reassignment in
 rockchip_i2s_tdm_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z3LzQisUERsnXyYbiO6hvRPwUtO9iWWRvFklb3VZzjvW4RFdcFy
 sQcxNdjEujsuob5XI0bNRyY1Vmyi7jO/lDMpY50/LQfj9HwTYEYR3fVgNj/N1HDM4fB6a59
 6a2xAxCEqGWdHJwMaOcjPntobDoQXQctp6YATRM+DiB4aUT39p+Th8FKtotyApTXa/NIclm
 c8b+j9aZfUqTqnX1J8zWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oBK/GTgpnZY=;tIj5SNt0EX2gisqUOYcMJ0dUJ3I
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 18:11:58 +0200

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete a redundant variable reassignment.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/rockchip/rockchip_i2s_tdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/ro=
ckchip_i2s_tdm.c
index d9a1fab7f403..770b9bfbb384 100644
=2D-- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1337,8 +1337,7 @@ static int rockchip_i2s_tdm_probe(struct platform_de=
vice *pdev)
=20
 	ret =3D i2s_tdm_prepare_enable_mclk(i2s_tdm);
 	if (ret) {
-		ret =3D dev_err_probe(i2s_tdm->dev, ret,
-				    "Failed to enable one or more mclks\n");
+		dev_err_probe(i2s_tdm->dev, ret, "Failed to enable one or more mclks\n"=
);
 		goto err_disable_hclk;
 	}
=20
=2D-=20
2.51.1


