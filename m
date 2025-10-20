Return-Path: <linux-kernel+bounces-861146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7DEBF1E58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C1144F0807
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083C21D3F6;
	Mon, 20 Oct 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rV0C1+us"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1CDDC5;
	Mon, 20 Oct 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971420; cv=none; b=mbHuN3VnxCS7eyNeI6JMixZ29zpJSFJxO5xfKRvCb5HzEaGrhV5YO7WQWZqLaY8pHFS0ZCSCREiV1Ov2ht/jDFFXel2D/saF7DhjNyw51upPIX+GbQdEyoIdlRvQ9AvolcB8XCHNhcAd05+FAb4bIiXjl3kTp+ypEJ2vIB40eJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971420; c=relaxed/simple;
	bh=ptl3ozHLmvwmDd/VbA9m6Pzuded3yRitwJX+TKCAvNI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LjddNWYpYim502yRJn6EnoSbgEZKCMRyLJrY90uEUsJBT3RkDR6gxKBGFj1gh8LmzkbTKvf8a7MplcMydN0pNW/+biKX/bSTXQAmyIdUgoEFzdFzjtjVU2Dgx9XfUJUuR0Z3OinPVtRCF2Eqd3/UOJX/5XuHsQLUx5coCWD9FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rV0C1+us; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760971399; x=1761576199; i=markus.elfring@web.de;
	bh=8xdTe9FW1DvA2aIEsTsmzVyUb5+VeZG/Zd3SbzDsIJE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rV0C1+usaa1i+7kN/Ya0IEMU17i5I7uiUz/SolLT2Ux+UP5SdDq+Wb3Gi/O304+O
	 SSDS8CYG6QWzXLehZaEdy/aboFU2IW8kOl51985ZmQ6iQQRYabeT4uAMJg9pvNSz5
	 nAJpgBe1cP4+a1jRDop8izA1KomwoX0lycS9x5SmdKlhZpexxZo5laXEdgAWgIcTs
	 CdK9sYgYc0hOjkClgs7jWJfviROPVzOA7RFQoicRleortI5DiOOKfjT/YG5MVTMfE
	 diYOWyewTQiIszZiFZaIa8IAhY5UVEccRKopfDSd1lCMrMEukhnkh6xdMEa3q67xA
	 R5feYylsFrGk5dXpsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1uDpVf3dUX-00rIew; Mon, 20
 Oct 2025 16:43:18 +0200
Message-ID: <b25c9842-7ebc-43f0-a411-8098359f81a6@web.de>
Date: Mon, 20 Oct 2025 16:43:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>,
 Maximilian Luz <luzmaximilian@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/surface: aggregator: Omit a variable reassignment in
 ssam_serial_hub_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OkNUZmpHarUfcPd1i3jBydQN/dhIYt/nLFIS1DnFcn7BmklxItk
 tKyr8YvzXhvl1gp3pm7TuDIjQ7sWvwlDzkblGzIScBFqOuup+yB89kLwpH6Z/QHVh/7MxQi
 IZNBaoTBHIzh1hoqNtamQH6/ovTSmFYBHxvM8yWfk8ok5Zre2JZAHw9GZbcW2FvinEDEdgN
 Oq23ZeliZotSGh6MCsxEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x9i1TclY3xQ=;yTQctJU7Gn/t6ijbm1Lj+m5y+uT
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 16:34:59 +0200

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete a redundant variable reassignment.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/surface/aggregator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform=
/surface/aggregator/core.c
index c58e1fdd1a5f..c7e05f7bc199 100644
=2D-- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -676,7 +676,7 @@ static int ssam_serial_hub_probe(struct serdev_device =
*serdev)
=20
 	status =3D ssam_serdev_setup(ssh, serdev);
 	if (status) {
-		status =3D dev_err_probe(dev, status, "failed to setup serdev\n");
+		dev_err_probe(dev, status, "failed to setup serdev\n");
 		goto err_devinit;
 	}
=20
=2D-=20
2.51.1


