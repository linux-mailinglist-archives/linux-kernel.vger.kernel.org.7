Return-Path: <linux-kernel+bounces-861281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F0BF2484
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6533B768F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7341283FCF;
	Mon, 20 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MAZItxP1"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956C280332;
	Mon, 20 Oct 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976022; cv=none; b=o+4U39ho1l/CYrquw/z1SERoPCfRW1fM8sB4+VzQdRSl0IzrCFNQl2jvHty79Jcda3NZ+eOHRgePwNQ5m2gVmamRGFtbnb1V5bv7WZo7aNtHyG5Fb5E0njkaVE+8Jssz3wTxL+633b+QNIphAI+3TQrZnh8TmjjRf8chuejtk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976022; c=relaxed/simple;
	bh=h7k1yPDWabdqTtoG2EnqD7n7OFxarXOU70TTjODpX5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FWMsFnQfes3VaE/D15GWSjqS+ML7lvesPmilbjbzjFwkon0iu4yf+RyoKyaKQ2UG2zX+pX4tLlQUA4DjL/ffzow/HG1iyfjxagNzT9VPuhU9sX9Pt3H64Qf3PiClrEODgeA19Vbwf8eV8dP6L/07WeJMk0kj7BAPFElgZVONqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MAZItxP1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760976009; x=1761580809; i=markus.elfring@web.de;
	bh=LAWUziSKbx0wPaRGxy4vlGz1nfUe2P0aaJSr5/+/rKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MAZItxP1ndJPJ1dQyAj96YuQd2eTZuavy7DuuRSUnyp0JcGUI+ElrjoiGcQNYA5F
	 GmWb6e6jxVS2NDk7Gy0Dlhb5/sEc7Ax3p3tRAhRC4w4iFolXfui2vQ7QoLlYvEqN4
	 k4G84KUpoMijXecBllVqspierpZaOSE7gKL30FHLwyCvb4wB8e9v9twEWDd+cSrRO
	 Z06ds8jYL3D2QjYr2ItbD9Zqr6OqXyo/MSCFvDueeZJo3rB3OeN89voXoDSQteQHp
	 lOVFnH8w7XLo1KrA9/kR901DKEChuD5p18J4/5wSUqCFNnzBiS5HBjNTMRp22hV7Z
	 al0v9eepNKGy0ylx9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1utCvZ0VJg-00Radp; Mon, 20
 Oct 2025 18:00:09 +0200
Message-ID: <b33ac7ab-e66f-4407-ba3e-ec4c70636fcf@web.de>
Date: Mon, 20 Oct 2025 18:00:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: typec-mux: ptn36502: Omit a variable reassignment in
 ptn36502_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D+wY3jkeOj9azC8xpJrk49F2JAJNgErxmsbwrA9hWOet5/dRdiq
 Ck9JMHptUkHL8QQmBXo1kvMQoZK2R01qhTcuVywQ2clA1TpuAH9namykLEj+db+9rslpx2P
 /JwugfTkgeMGvVEQoU/9bvMw75k5PuU23TN0MYPfRKu21sXzrzrxHcrK9PABOQ4kfbTF2Ob
 adhVnuJjQ2qta/uMCwKoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zghbgn7crjw=;DSuY2KvRUey3JPINcnBz9xfOl9/
 QhOkd+mhhqA3hpWtCZdhHA2ymCfDee+8x0o8xNMfuUeLpJsaITI+vgCIr7tLcOe9sySNhxBd5
 qKG4tI7hOFUmASSv69irKl7XdXT2lvdsyvJCG3bCPUCaPApkLYT0cHo0tXuUuly2gvNvKwLjX
 rnCRr2FaJOxXMUlbAV4YOTRJuUuoKbIZpQpFQxdrTo1JPks4rfhO9cvwDtkA5zVYqXmk8S0SB
 NetD1okqG7pH0+t6CcKwlqIZXWPbp5rxfYjmvAUdqKlccog9ZMwY5fpSBjr+XPnldWC6+RuyN
 h8D436yIH/S0E/RxTBHSUubV/nspjb9h4qJ15y25/jeCS3p6EhGMaLLcCjX7+bg6I0cjmB0TX
 Kp7wF4U1zVVjIrEnALtkUTGeQFP3gvlxEZADRnz04Jty7UgkRqk2InOjgRfgQGPi/wp5u7l0I
 un7hqXQ+HceUnicKHTDsfKa3adX6z9hlC8rphQ64h5nbizqfoZplEDNwojqrdIJtlmG4XAiJs
 z+dULVNpFNnXV6dPctZlGOISVhoyJoqcDbsp/O8JcfofJ+QLAlpyms1EXnvImxyTb7t+lOQ++
 37sMnE5x2wi8CQx2dvIfofK/Gl6w5Az10R1s2EjC/ntw22FAYGzYtJ21+b0EN0ty2yvY60eF7
 r4aEkxVMpI0hwE4pe/TOlw+k7SXDOcw+Nii9lVulPMsY7Vak6E0oJLf3Ewpw1BC8DpQ8x4Yz7
 aBZesScMmewfZC8qJM80QpbwTNWljg4nnFKuX2aviKy0fUsZ+GLiYjkg9Zz4EhvA2gg1LwsC3
 6XaY89QomO0uRsyIhCosYdOkOwxfZsH/+4SLcOQgHYlsN2l4tJimjnGEnqDAx+Tvw0MmHrKLv
 djuxoGm5VW+xasPDQUIzdrgZH5kRgLyDsj++Qmn7R4GDYQM49MthgJ/GSIIqlhTiwoFkGkjAg
 HLbMNCCaUmNbabKKFpzNc0NCPpXCAOje51iWMdr3A/2gBagBmQg+OHVLc7BhcHyt4huFqb7Da
 To1PcYw2jCy7HQhl6XVzwK2msujwGPW28OSaCkyojH+jEjOKI0M3tZKYSqiGsyWbAd6T6dDIn
 Gb1qEL8uziIJb2zdNRek/gPr3Aq5UTw7SpjHYqZ60HQOYo+DLWQGLYFNJb+f+gES4aXU/S3L1
 nncAik+mF4/D5ichqdc5o4T3Tz8FHEIEVGlqkGU62le+EkXIIPDERlPOgqqNAeQr7nhFHTw/i
 2/vCSZTxy6uTTIuaZ/KM6LRuYm1HdCThiag3P3tQmj2sLuc1DytjdSXlj0B9riQcgHVJ43Xjr
 ViZNe+ohZIupzDJQMtmvf2JNq/OpNjvDzMJoSWg+WW45nrA4vy3eUp4zGt9z1Hu/Q7AC4/c+6
 MENL1O5RrqF0R+jZLfIh0hqAThnQIYOykiuwuRAr3EV00Js0Pp7AhIeBjt1SyZoLX8/FVCiP6
 YAIxAQ7lVlhHKn3TZaJCOodO2odmkLXsoq/IEykTMkPuc0ddDIIBVeFxeyGiiUMNLGI8Xh23P
 qoLtl89CNtYNOGZJC+VNCy42B375fGBTCwOCjeyna9W/wY3ob7MxEPtUZ1DEQFC0KEBOZhQzv
 NbjezGp3GjTOE5pUMmMjOuapru/IHVorTkNlFXjFkT5a/zkSIoJ9r0DcWyjlINEMHPh5kD3CP
 gKqJk6Nw94EWgW9WKs8eI7pFqcPzEoUcIzMnhnQnM2piCfAureQF7YqfFJ62+D7ArlO4X4S3f
 CvqS6+0NuHGsGJ6irCLxvTsomfTvMEmAeqmPGrv+5z3dA4HT0ZfaVGxG6fzOECLVteOKvl006
 BTwj9Ce2Vwjua7I4OGTxefRNAcjSn2fbtnEn90VXqkTYSfxUxCAZ59GQrrilwgtZrJLZ1cjW8
 baf7MSj/T9oxMCPMsJokqrveH8Dme8A82v3NCC9smTv2jDGZxH2KqMjBKqqcw/PTwZzi/T2e9
 QFijVEgcINAUiLYMvmJkteOFgJ7PBEox/mWFJpM+GeSk39cI8ACieVcvNyJE9JHCqrZ2vwrDC
 VpsPp4A3sL57PP0ptIrZjiX2LcmG+BVG/DBviAlIG4FEkpueJgJInQ7jJ3V32d97AqKdMtnUi
 8R/kyTfWBYmLGIFSIegirplQeRq78WIOBwLJDuC1H9txmr5Bi2rmh133AO4znROFMn1qkho5B
 0/WvQaqHKP5162zaqkqALCqW1ndIAT+qzVjZ9keYk0pkMtLs9aJWUmQ+HLDWxmur0hF06o8UB
 V4WB2fF4s3op6Jwph9RpHuc2WK5ykIdm+4FJY7MqzzFEOfnvzkqtazq5uo5oxFS5QiWKrC0Ca
 WtXiuC8pmUdC4WjFqY8IlWpuaTi2bifY1S66wDRBbWsmIjMgyJN1YwkK6tH1ev5Q3QxQ/cyux
 MOORfFVUJFVjeE6/wvEgjoVrJlRx1sjlc56cxwxxRIsMS7lQwNGleiGctv2R/9eiKGb7tnH+3
 G+B7YsERu/qqVEFakdm/h3XM5K8f/GRJB6pW57T0gcUgkW2MSbKcXpj4msx+WMKFzOxu3Xjbw
 wLrl2YGOysv8Awc7+R/5h5Ad9rQURryeRisAdi6087VMhoasWqkHa1a2vr8ehToZtKsdkztne
 PN3weeLKMYeRy1f/HwlZHsnvGOEHL9pkkC4j2Y9xJDka0CknKI9O759RtPusUo43n17eSNxB+
 HptTSEf3ZXdees0SrNcix3lpvY7gx/ZsPoSQx6FDlw04WRlMm6tN9ViBZvDIoO8QYC5V/FuQO
 QobTZPBTe8HygZjGh7hJ/o5rgrzVIh2umwmPnJciKGAH9Qt4CuIjMh6Z8bdB10X9ONwYmEUNC
 fABRk1IJn7+5vKkN3CiQUj9I+frzBKAxEjjuul5quwLp6I6B7bLjwndpNK0A4afPHBFh0+01B
 +rsaWHIwAoxl2iuLNRrc+5oxN/T7tFHqID+1LiGTmhtRcNCFSWMdHaC+TDU6dy4Wx9lhfNB3J
 XRvGTQc21s0YmRldUqPtVjvrLkVkchzg50IOsC7GtrEw2ilQ/3IDqhOJSngCmy+NLo6ZXYo4h
 CalIlE3EQlSjNYckKU6kahmabCQXhC+MnlLQu21cdm9yvEz6sAvUCxHaFsOlFe9VC+byvgnc5
 rjq8jraYxja4tWqpwivMWCfQGe9qA4feFo/wmhnXyO0IJgoGEfrmT1mSzmOQuWH5Us3INh+jB
 nd6wFvXh7PqCzxPO+JoF/vMLYr21DWrmZLdYz9M8IfxYCe8bEe7kYZWWBQUJuhVwtK3bmbvnn
 De5fAeu2vAVsxgfSJOMFDBNTD8uPZbdOpwzToXtIxnJ0JcfHtuwMrEHEb+l7WZA5FS7gZeUEY
 o/Z4npV/cFvsN3rMWd5OZBjyQcFk+vwii+zyop5S1elN4rvNUzivllP9wiDeE1SLW3E4Y4O9H
 5/LvK4pUyMnSWQHOMP0llYYb/XYvENQbP8kspQAmDxtXtfWKFGLptyH6kY/OFY8kyx+jQsgQN
 HpX8QrOYfmx7ytdT5iRXqnEeeglJon099M2fNDdzuKoGpbkjdBJ24/Ak0CNcNRkpkRBJTkE1z
 GqfHtQ6hxKzsW/VloZQs9QsEqcxNqLlfAScVZXoDlXj+qsxKmC3nqhS2LfvyLZto5GfZzYi9k
 WGPcyfx9+ua1iX+2fzgFM03jroHbFsopjU+3pJ7tTyloRUogcu170ZM2tnhaNohmbtk49DM+J
 bHj1TpM1zrnfwd2w+kxVWtiCYcejvMBo8FtQ9Lk9OHJwI/J2x4lCfQSJTA8bkNeQGKGLDjxzX
 wT1D3GdXtwbr6VNvM9AO8U1s9wXVAucOItGoEejZOUKaAYjhy74BouFTr0EsE2PsvuUVioZcv
 pZk2JNAQ9UvJMTlxO3rLXFtRPNd1pVEwFx34bxniU+W1vMFyqwNIwi7w8lqp+EsoQBBL1tzhg
 1T00vbCu3BBlARyV/nHPPmfONjcTd3H/a17o56KPL6SpW29QA8ka8BaPnt8QCzvFNSCXpm+OL
 xQVtcA3xjccS30A1H3kLScnmMg/Hva3fxy0VzbgDiKjMAa1BbDFDdyddBTwNA/t6bUQ8CQSOC
 Z1I0lr2+aQNgZR4fPBYBQYRVFGU/ghzTjolt2JJmukUyP5epDwqiwRdnpnkyWhDn9C9Bzrz7u
 Nxnt3sRlshD3sRjTdfVN0KnklA7B2/OKORgX/qDKtK7qARiFe7dUsU/9+jfUjhMxeYMp3uCWV
 qO1nmof/3GMk0UPo7rFMX+qZfuyWjAzvyLp1Dsfapsj9IqhVcRcFqdRguUSb+NuaOPjW5MhqE
 8SjrAvhQRNhHB1AafT+tcvMBJNy0VQSBRosFoqGCMCBATw3egy7XKgb/Xqclm4mKO/pmKPsrm
 1QKlUma+LgDIaWZrQ6mCoVKVRzqjdFo/FXh7IkBqVYRfbf3CQgR6wLX2E7h5oE8IjMclnQCrM
 NIMBVn+11KFohZWJ9mG69A2EJUbf0YsD8l8IKz2HyLW43b6bdcs0VuJ5Wlof/2KHPNZ4wOgoW
 9gRKGWB3ez70ezsJX4wMAyC2AiO4mK2pZcKJxscCfzC/7EO7lllXaiwEB2LOXVuJkJW9AdJxu
 IlQtiZ3ELKB6u150exyD9/efMuV2QfIN9SMg7QbGnkdkcNh+dAhBuGmTAK4CUn2SK5cGSZh5c
 PBmL0uCX9rG9RyC8oJDo293/1Ez3I36BWxfv6QCvu9wyrBa16ypoYBKWNocLKCMeM62wWw0u1
 5QlwX3jOdH2T9tjN51Ytx12nHfYj7kwhRKfDgWxD9Nfat9lwOSg1WLSgmVHyRksAIld/LOBkb
 MpZWi1PMccIC92JZIJSSdxTOmqb80xmmcdPduANi7cWGkWPOZCmlTwQCEPppPJv6jVfU7rLdR
 RyNyy+9UIVzIdB+XnyNprjAmg1Qk0/T0AR1RO/ZY2BSmhoCtqzcWbR8KvSq6MCHMwlacZxToS
 6TtSCUumY99j9YTaLa9tP4xsqz5aWyhUJ2OOP+up60dvmxVMHVbZFdtelVnlOChp2dLDtFaas
 tfk+FQPn1PJGjyG36ClAeCJ6GOYAR6ighOK1EdZWnp8HOdX88Nt6cg4Q

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 17:50:12 +0200

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete a redundant variable reassignment.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/typec/mux/ptn36502.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn3=
6502.c
index 129d9d24b932..b1a2977b974c 100644
=2D-- a/drivers/usb/typec/mux/ptn36502.c
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -339,7 +339,7 @@ static int ptn36502_probe(struct i2c_client *client)
=20
 	ret =3D regulator_enable(ptn->vdd18_supply);
 	if (ret) {
-		ret =3D dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+		dev_err_probe(dev, ret, "Failed to enable vdd18\n");
 		goto err_mux_put;
 	}
=20
=2D-=20
2.51.1


