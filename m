Return-Path: <linux-kernel+bounces-878951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C275C21D76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A680400EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABF36E351;
	Thu, 30 Oct 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jicUab6N"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B520013A;
	Thu, 30 Oct 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850630; cv=none; b=npe0rxY9UgPNSWvhmiJ1c7xgc1/8et/6WpZozcaG6lwwkvbgwM0wjFRYToy80CLIrwyHtgP7JEFQies/teuxvu0GxBXdJSjL/s2Zm1vqA+RXdrhdwixQCeMFl/aMDfmyYEvE5WTL0yQmXeal3XPEY5zi8AkpdHISALMZ4D5tTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850630; c=relaxed/simple;
	bh=9RLZj76bWU7BoQNsZJ7og6ajkVKPA/JV10KI7G5ABSo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=usqw6uRVqIEawXkw7wisMsGkytCnhXiQHEgpra2RGZ9Qc+d/bx0E5M9gUTs2+A41GfqQWJS/6WRABo2g2DnuUqNfJufpLMRkY6K6Ne0BQImVrhzewiPJSvtc8ttE3kUF35omn9PVlo4DjYvK3ktDmtW7VijF7yNy7Pl/6mmtp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jicUab6N; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761850616; x=1762455416; i=markus.elfring@web.de;
	bh=ZIPqfelEadpMh/VTbESTkPNkzTQIpzKWSq/pJET2Tnc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jicUab6NiB450e7E5DEqm5csPNXHNzTe69auVyJ8gQs9DfEvKzcJ6YF5X/Ti/QP8
	 JuC/QovtXDhqrX97/x1cQU+CoTY+myKxHG4rR/ldDdIsuXFTYIyT0Qej4NIdZUo5I
	 C6nMIy7682p7Sg9QDV7iVfif8X44ASq7pzGFNqQF+LjSfK8KMLx32FRe7mzUeDCE6
	 qJjVH3Z6cObHK56NLb09mD0u/U33oDoGOZ/nCUNZKZo4AXrpGj1Mx65sDIUpOEYAA
	 gHC3A6SDV0Pp3Bo68ubywp6fBN2zcmAtNUdcijU7miRJsW9OACuMESb531Xr94Dga
	 epfvEDx6OItyJUEwnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHU2-1wBrXc0G2S-017NTA; Thu, 30
 Oct 2025 19:56:56 +0100
Message-ID: <17d0ecdc-9dbc-4f9f-9da1-eb37199060f5@web.de>
Date: Thu, 30 Oct 2025 19:56:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ARM: ecard: Use pointers from memcpy() calls for assignments
 in ecard_init_pgtables()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MgVIDqVC8lq9N/VlWOboI3Y+tkqiCujOOFiyHgeqPxAmJ6FiDBn
 YAf2NrTFCBjGPxA6jqIafBspbcuf6ZzVNHZI6hM3XA2hFJZOFmqGyGG0LI8CIbGIXZ0/v1H
 BuT/lffjSTR96d1IN1OyUkQ36yB6jdgSio1HUtmMoavySd8c7UNSK5J4ZUL4Bsx2iJEC8hw
 YfTWkip6O+mRlnvBam9LQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iViZqzMUTQc=;rlGnofOkQXkTxYKi+R/ezpQ+bR2
 1SmiOTiIDKXVTPgAPyCO5M2ek1W3t70qRMy8pYPK7p4tuc3BKThdX/q6UN8LtdZmw9eCtCUO1
 QLCvOSUvWZAUAZR4qvHBszQXIR1aBnQl3ZcXoqDmTPNBvGbJ4UP4+RMCjquQF0X3qn1CamiKG
 5ECgGY5/dFkH5JZeZ5LBwFGJfbGW6V0zmb+OiHNHGCaqYpDRP7AxjzU1KAFgOjqMCNNH3DjSK
 JRDb9jV0rO1K2P5eA0MKI/BtXIS6kWPlBGERPqB0Ap3l/R0e4oMmXKmz+v4mWCVQcKVacqEND
 tPZxl/CK/3KWoIW3UtNn7mrP0eing0nopUtsKNIvRPbFwZ0M5JyZ8v+glngFyM5QqDlSr+EU7
 CAr9PD+dR+ltGas8PMcT9/keqEJ+VCvHWNA9ISvXyZK+Kmyj1bTyDB7pSOCWENCEEtbNsQ9lq
 IzQQMHU/H5RaVv57BhV1pPnPcj9guOVbelhRL4omK7cbL8FhRP78EXNtCZeEef4aJ0ewjO8ew
 3Hq36TSXEEKMWdwa87zEtL77VPKMdHJOoLjz2QdqVZ6BAOSkWL9LGAGPHnrcGzeSmp+5R1eAn
 4rn4lJ80q/C6Mvm8l0pdPp56t6mQQ18T65cbmkLioFIHaobf0etiXhu8GCMUicAqXqzM/o7pE
 dyLztlpjz/tf+uYSgPSFnOOa2qCfg0x/QhrGReNrTj83iH4/uxWLFyntDQt5Wqs8R8XaXl6HO
 /qvx5k8k0uxLk/kHBMtgR58CYsDucmHW3VIuTH5o+W/A9DLHTmz15bf1qmeEtIKVy9INUW+mV
 L9pYgn8Q62UxVhrpobk9Fk2U/p/bomOqYiSTcPgwznarpJG7Q4eeTGRFg48p25POMt6HVRX5a
 Ier0UXESzD1TO8gHd7jfL6i39L+ic2HnsENHlHQhfszf19m979z/UtbM4Rl9kJuvEnpBLreqa
 CRgg54hZwIg8W7CnmRgNO3SMD83h6UyWxXRsOt18Bz+6k4WMX4QBEKaqSbHh6gUWVNxgXVyA3
 6c85LpdeEHa+raEGp/Ty31dGWwddZWs2vfVTVMEU9NiDuV5YOVNk8h+Q2NcIcLvYa0ZlsKz3g
 ncK/e8ZvkX5pM6Ro/W+lp3wzRUUrcdrOORx/AmWfk4UpOo9sX2pbbMtirsZzzoOyY6a0vuV73
 Ln5LoQtb6Bur49yQ2OZ1DaCaUFaGeCOsGyaKArAzLDPeOBcdey+5RkDHpYVP7aXgSQJf7DC77
 qlMG3pKzf3f9kiUiDosUTfjnHW83qMZQWASX+5IDlXmMFWi166cVCugLVqh4SOI0CllO5ntID
 bL1oQTX7Q1lbukOgN+jMuFybQZ+LG71sHEEtMtxMKWRN+hccZ4PWUvjyHbIbDm5uzWSIo5vWM
 P6ASN8sVMms9YITY7CFlwomflfqxeO4kiWQrn1l858UOPA6jJATxh4WwvysajG+yN/6ASDxVz
 KXDaELfSQ7Nla5VAXAd9gHCB+0CpVHTjq5L8AJysXIeDkmlM5QLaSsmrQOhh1V6cABGz+hwEA
 HF49pn5+kiumZpDi/0UXPLt2Ai+Z1ZJPlHBUajxRJq/lD4bqpWON+0/O111xAcQKNlBCAtgaQ
 v7zcnrc+YwdKtKxUgEa9xTTiDQuI9BBkd4wzwQ50nu4Skx960vIewYOKgulecz4sQ7NjoeK9e
 +ENtOoyXP1qQ1f/En3FSDvBXohjTQVWEGS3XD0/jEeiuXzyIYEKCct4RnKvClO2n9OKCuAOfS
 CixqOgo8KCKo6pQyEarsSCg2Sl0dVYRg104DBVfv2cW6aJhMT+3WePyESrJl9+mH83TtLIWH1
 J+I6BIjwUPkrj1pSYa6w1HuPyDQg1Bh9e0mFUgKrBxAA9aoJua7P+/i0WCrkrII8xUFyOaDeR
 41FD7FTEdFQqSA1ZB4yiGIYM2AcDDCEd5EKAQzCB5DAyYthcdI12JlQVH/9/sfv4X9VhZoKFo
 hOZjkyrb2pLuK8yjaEucUCVqcdHsBAAv/b/eLSVk11YnWTPUeIzEbiYYaL1i/wbeZUqUf1A76
 uQZPDsI7utk2kZ8lr87cXaqDC4y9Xx2uosmQiHxPbJVlJVMZmYq/z05xgHfl6z9ETRwbyx37S
 ftTE/A1gIMyRN71aQB8sgLUYgXJdxDN/Aop2ZCmH/OXX6kO+XHjjT5aMy/eHkj2RpXLL8oGzW
 LgKB0a/gDHND63sI2rTdF8pL4/XMt7g9P0hZHvXoxSjMKelh3W11NS/2SdWcMvZUnOWEDhYGP
 9uGjEZP3VSjALQgHsjLqVC87wQUgYjj08AZaiH7cbaRKzZrKqBWMBFUYkahHh3XdeB+2p+MCE
 rWf/aWACm/WjFR6UeNtHXY33fuauFdCkSugtULND0zBetBS1h0aGzS82RdVkf0DBNALtZ2Uf5
 cSGj3M+pWbR/QcRmBkFbYSvjOZ9PfXos9HIt5e7zlVEuWTbk4qgmkD8UQ+WEcc7VFOr3X8/4F
 7apzXV1IeHeOBZGqptKHWbWBKzdLKh8ePLlv9gwHXCd4Y65GVV4gjHQ8LE3cb3vuqmE9UdK5P
 PruxDsCO4XAfdIf9V24Rtt4XW5RwjszlMIrhNgRkNB99KsHIxb1+eJq6SD8YtXEsIST0xGyIH
 vwZRD/5qWOt0dmFploCH7xppl86r6yNq6R6d8pQNQDu+ZDwtYj9Z9QGHniSex8+AO/qqCiBhU
 mtcgAxTgPWmyf4FWreKJMSz5ozN+a98mRbVYgXy29ZZaS4yuppaoesSQbnSds4YPSArzE73Ps
 rBPRrz8Y11+yZ51xn7yT6j/pmJiFsJbSB8OtPqTYXobueNbTS+mwwESZTaKIvP7ZS6t7pPOPI
 HwuR9Ftd2P/Q7C1RqiLahSv+WxoiKNuDHwkwzNgEcrYDyH2irx1iJRm5H9+68CUncQzvIhLLn
 1Fj5WEVaAkwY/1tpA0SdQGhzdNgZMI6JX41htFv4eHTWVb1COOA1d/2L492mwEnTfVMHSrqUp
 x5Z6m4tSytxHXk5RdjAuazZ9tGoyCKPMjsfE7W0yFcLb2Ipckq2TI+1zSZMs2DjU6roW9dTv+
 in/QtnlKk4thG3CNZuRtgU9pTdOlfPZlBGtTyX/82a7V1haDURUFKg6dTx+1nLKVuWKAjBvnZ
 IEqCS6R+OQEY3+Bf35TgRndu7bM4TbGtwc1qIUOwrV+XSbmbLGhwd3+133TIvNMZpK7byIIDE
 si5081A1Oks/iz3VhTsRiKpUgI+Y6njkYRLSekApflNJvwWvhi9s9ZLn+q8PbugmfXaoiMnZs
 UAgFPR0VYB4mbur5zOI7TQYuEztQ+3BmcJK5og+eqEzmkKaHj+Xd0iGPpoaqZdLFzNbrrzMp/
 iRxVPJ/9rkKBGu/PneDkczqgTJAeAVqJQoX+pc0n/VTVzF4nHjGwnUDGct827VM1dZnDNqehY
 zhgWb/EI1mBB+G6pVHVTDPEhd6bi13OYHDf/H3MFSkEB42E2a5XPbnSy7Fi2f2GQwy5MD0+Uu
 QzeG5e99pUAFWT6fIfqI4Or9X8epgd8OrzESD7+4Gs+Y23uX+DKBHzLGY8D+xIiVNYzpEF2x1
 xwGFoTV5k+25Mw18JjjJ4mBeSHoByIana9wVZ/byqI6ffPXw3OxfZclqrV2+MWU6onsV4vRNq
 sQvIKxDiZf/M4xTMlYsHsDGjybnNYbXkJopj7hQ2cS6PMW8NenVg7SO3/v/a8LlDB+4s/SK7T
 hpmvEv/XBUKn8EqoudGyfelwJbfDgtfZYZRH+3VbwOEHwu3ZnraMrB/QTQ8atXFxnTMU/nWPj
 5v/N/D3Kn5An/E6e7Rm6mec8c48y/gmhGDrh+BYR6ny2XtVjwM+NWiB7Khe2KzVwSNsc/RP/X
 67GVj/h/wVJ0UFDvK8TLYI8bM8L4Zx0X404wHbrZYW/bKDXUk+eTy/aTX7j6z4ju6iCzoF1LD
 9fawmUieA+ySMWNXHkYXeUGN3WHnlV105IkTPZqQW1T8cWureefUucmkU3RhwTTBliyhd/VUI
 aMBQnIrTG/BKrek9Kjl8v0aViuaXr4S5fSS6MHojT1PNpkTsyTtPXhqeJ2L8GxJDp3su4ghKU
 sco+EpgSQIqSV0tcbgYTkhT9HGvW4jgorx/s0Wh+fQf5MMrRHRYC9mdSS3QiqLSgeVyP7plzG
 K7+u/aKlcTNHPhrbFSTFAo6fmsk0kguJFRJMy2WOTW0lktUXYCe7f6uSBOfALp8zNrlkeeOCR
 RI/p50z7tWa4rm/4LKv/0Srkzuhbf4iX/V2h73E/V7FIKRFDmaudvqQXM3EPDJbHIlzYIG/yx
 cdwd96Wc9fEsYvyVPHdkopLNtdbzLzmWk/A3nz/AEqe89JCxGQo4p4BpNrc/7J2QHCaROkVe5
 rPM1I9A1dAEb/jCfCyjQJqUvbILBGw35oEchkBam0oe5ya2EkXTrivqQQ/0YnD4juxskbkzuU
 hdJwtnR/YAhF7TeMHvp06bwW/HZUhivkXcmoswM1MCQcguEOwwpkwv3uQJ3Ufdzk2vRhDpgWx
 +1/vok+mCh+tyG6BW2+dJ8zXKa8Eqyx6VCHvB+8VJ2FOKQMkucwfw1YpLYIOc0iJMbALSUGJ6
 LjYaVOnL0d+NtdDfgsTaFZoXI99vF6NWpVBS0nV7DNEdGZIrsTSBPmmZ+NF+RaEP+kLOhN51n
 yyCJzUCRHv3H1Hl6MU/D2cifqf4fCZWCwMY1B1LwZwKDvNSnYZ0H/qZfYvavTm9lX+H2gEAjS
 qWkX8y/iZcqyNU/u41fM16G5dgP00JuiNMhu5JNjvTAPSzyhDTvuhiVVvnEL4DYKWR4udPBNV
 YG3VRk2JwqSf/DXAdCKrjCao2Cm5B7W49hzKCQmedb0nPL6ZeiXNRQthtLsPjtWwPB0E0AH+e
 Tx9gSHEqY4zo5FB0XnNi7/NdfFACsi8WDiF6T6ujWN95J24KBP3XRzeqGVYQmyZe153gCXCqn
 ILYHowf93vRioacOFAfwBgEUSA9EG1dRkXWu7W1hs78PpZDJfHG8jlc6PVDfQ0RexgMPVx/nJ
 MeCWi1Wx1uuvRkxtzpuZcfOGIcfOuZxta6jmU1DyEecE/Yqjij3oS00tDOrPRZmmIMykHcSp8
 4wVpSfh8EiHFD3xb9EWHSyWI3HGmcZn5BTRbcoiMyn/KI/c1w56LC3Ztk9uxT405Cfv9w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 30 Oct 2025 19:50:08 +0100

Pointers were assigned to a variable. The same pointer was used for
the destination parameter of two memcpy() calls.
This function is documented in the way that the same value is returned.
Thus convert separate statements into direct variable assignments for
the return values from memory copy actions.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mach-rpc/ecard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 2cde4c83b7f9..879c201b754e 100644
=2D-- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -229,14 +229,12 @@ static void ecard_init_pgtables(struct mm_struct *mm=
)
 	pgd_t *src_pgd, *dst_pgd;
=20
 	src_pgd =3D pgd_offset(mm, (unsigned long)IO_BASE);
-	dst_pgd =3D pgd_offset(mm, IO_START);
-
-	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (IO_SIZE / PGDIR_SIZE));
+	dst_pgd =3D memcpy(pgd_offset(mm, IO_START), src_pgd,
+			 sizeof(pgd_t) * (IO_SIZE / PGDIR_SIZE));
=20
 	src_pgd =3D pgd_offset(mm, (unsigned long)EASI_BASE);
-	dst_pgd =3D pgd_offset(mm, EASI_START);
-
-	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
+	dst_pgd =3D memcpy(pgd_offset(mm, EASI_START), src_pgd,
+			 sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
=20
 	flush_tlb_range(&vma, IO_START, IO_START + IO_SIZE);
 	flush_tlb_range(&vma, EASI_START, EASI_START + EASI_SIZE);
=2D-=20
2.51.1


