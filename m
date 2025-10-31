Return-Path: <linux-kernel+bounces-879664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0514C23BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F1EC4F493A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288D33DECA;
	Fri, 31 Oct 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HGEn4YaI"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A433B6E4;
	Fri, 31 Oct 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897928; cv=none; b=MWiQUIprpCaYo2xdTtjvc1jWq8pbwJLToVMqVQMCeRgoXJeaZDU+4EDQ8RNDfORZQ4QqKDEZni5gHdZZ55MvzPPU7dDbRj/3sMs2NLtJXb56EcocVGukk0zCZLG6L6wvfD/lZGzqI/07A3bFwjiKLd4R7F4aoq/T71RKyhGSkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897928; c=relaxed/simple;
	bh=7lkBjJb6xs93hXD5BWnjrlAxhvj7Jgd2zdEZ0DyQDx4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Z1zhkTf8/oNUMYg6FNLTYSJ152fd3Im8V4ekC8sewQwvJ8vYXOT8ghETC0j+SsNY20MQ3fYT9CrNHicAcDVZhy933I9XNkmRYAR8HeUG7i7M7LQBjRNA3i+vAR5KghTcBS8HXRnTLXoqXut5UlwSdomIRi0doqZBLrXjkD5M0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HGEn4YaI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761897923; x=1762502723; i=markus.elfring@web.de;
	bh=Z7mI9BcntzgVUKh5moz36lXrwspXfS+6u2bbjA0rfUU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HGEn4YaIDnarXowZdr43jslkkDhFK0nRNLJAaLSUTbDTcl22wFqgDkb+BexzeNtf
	 etJPNpkv/D56ak66R1jjKJzlqJtTlgNjC+DOUXcbLfeN3csN7f47g9de6vyIdgAJV
	 z9FKLAEC9WA1XeKhAFeK8sEcY+zebUTIwZCt/CSBMze9htHuwMk+ozuOSPgkSOk8/
	 hgTzFucF7kv3VCJZeaHMB4w/mW0dmu0rHeYxIs9gQ9D1DeSaqKNLlp30oLscUu2X1
	 /yshFfHv+UQX2OQUVcb8jknHA6iswiNUNrV1ngSZvPMfOmJuiJMx5brVk27KYA/IB
	 huuBcvLP17q6+ylGeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfY9-1vdhua2Qzz-00Z92J; Fri, 31
 Oct 2025 09:05:23 +0100
Message-ID: <3b2e9b4e-4186-4d05-836f-73e1203f34d7@web.de>
Date: Fri, 31 Oct 2025 09:05:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-um@lists.infradead.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Tiwei Bie <tiwei.btw@antgroup.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] um: virtio-pci: Use pointer from memcpy() call for assignment
 in virtio_pcidev_send_cmd()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XiZ0b6wjUlYkMlDZm4mhQWGgStcS3cU0YyKIoXpLBWUuNWQJNt5
 v0wuNb1CuDsB9UhqoCh0GJE/Y3TveiLweGTv+h4w/pLvhRSXfPiQZbWXOZa7Q5CFtKUE/lI
 4Bi3mbU2JJl4y+gPPnJdLGxx/FFAycPLX+sFgxi5iEsVz5BK+TsGQRrlrmGbrcpJ1ljYqoY
 YvOm01cU3M1cc7enqoEGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xaK+7SCO+TI=;dYn16fC/0PcSdUwZnqz8nRZzdiz
 SOOdFuF7B6Ni9GAZ3WlIyFJlLEy3ZoR1YCJPBfawyIJn0uTJ7xxqpmFgZOur0WfHHT+dqSwki
 RhfwTFJe8LO432KNoVB0zx8Z4/qrZWJ18qEfEKp+aLzndSEcQpsbyL0WReS5AE6MFfuPb7vni
 0fiBhb0p6dyQTBIctbUS+kuPmuwA53UCEG3a5FSVusiNmyU9I67h/M1Wgub5o2/ixHIqgX1K7
 kjHr6C5EEnBrl7gXvTXgbMenIG3HRj4zfFvhavdm/Rz2/jGNh2dhZfvpnqDy7L4r/DV6nwVeL
 u7+S0V9Ow94D4HbNIYpnK4cBztVW19RQiIx1OCNiEby7vPDpr0sJV+nasGDNRS+4O2A/JFzc+
 PaN8P5F5LOdWl/9pzTbFuF9FzM+0ZdQVCuNF6+3iSW+12Z3VkSq2ZxJO2C5TbSMgz43eyIps8
 xyLd9K5wGzYCMqlx4bmU5F5Vi7LkREoHz+g4oNS2sj/vte5k3JjJiZ9mzLNVbAaeeg2kn0FXe
 sKtFjnE6FGaDNKqFx5cb6KDTNXF2JTT4T1YIsbh1VZx4t5acR7QJkkn6g2BXA7Rd6W0oNQqJH
 vxYd2YTOcL3COpQiEI0l3fUp3180942rzOZF5U71gsY5yvXkVYg+cIWgsHH862xvdENWl81dU
 wLIsEzbHtG8y35kpOZVWXu23pgf5IlrpjR4iBTGpKR70iNlJBAZVYdPM7yJT3XiRxk9+hauGP
 XNWDrSBBbKTwSweCPZTvi1uqJP16jG1AhQzLggx5WruUP6agVn7U2fzGfQyPD3xRhRaVdw0fu
 7vSC6MD9SX64+iz0ZS4p/xugTEn9os2LVdI9Uq7QMZxsI8j8Si1yXNJW1nbe7WHULhME2isYK
 xZGwqZbkPArEQyEicJ7qzq8N9errQq/IzZgpWZNY4U5zCbxzz8FBFznfN4hFLyqqlpegHp6Bu
 1DWx/4fkdwTJ/T1GBSa3QIfaFVI82KN7HnvGxZVEVN0nQZVKQLST4r5zkPM/LVkUCWWu8u3CX
 AWWwL+wdJyATGhvQVFbuSimEDavDqvdNVCX8IAWkmLhPRh0eyfzzNn8a/fD/f/eYkIYoAr0yR
 zWboyk3edJiAYuBK6FOe3Xczyb4WTduOTG1WjKIjjVbBw9NKc19m68pnKTPFcxHQMNtrkwABZ
 feh3EHesLgoH/7IHYc+Al5ZN7FLbbvEQ43F2I65/BUbTpGeHWM8yLn0lqmKFNGIEsBUdrympJ
 uH9XmMyMmg8vJkW/09aagPH3tGZr+C2gLGNg2qJ9jDWz4jyZmEXWMJxl2n3mn3EQ1bHLkpibp
 c8qn0w/TSJB52EyoleOG5vN28jPubwtuZSrG4r2Fv4EHXHGjbgLXr8+gr+gR11ZDROPHnffm8
 I8nBMthodV0EuE2z/E86SyYGIWEgyzlQhsyi57ygoSBxmtsf32qALOlyuq27Sy/F9YqxLTZJY
 i8FRwAQYKPFFPB8JV+wghya+LMu6UJLmOXyaB/Y5ngwdAOMxPQyvUONBt8txjR5EeuTTf90El
 VD7zwd3H/AA7BmllUZUkUXtD4Iv2K6DARiRvYotAtKqS6gQUXdv2IS3j9uTOzmco7e/9SkVfd
 qFBazXoKSuhKrwKyAtBL5Oy6uX+m3n6l10UxwZ3cE1vcez70SuRtqyFiAvSEPof1Ybw1TKMc1
 VejMTmAx1dqe3YoP/s7M9oZQ0vTXKz3eOlz7VhiFKWX3UoXAL6gNBVBkIivUVy8fNiTNGNgFn
 +DVcK3EItD+0/9p4SbRzSbr5onzlWbSaRc3aju0QVOU4HQSSpv1LNC3M/BkRwJjFXbnFp/q7D
 NCF6pnHF8wxn0M4BDMeezTHLNwCnyNAKtOAegeYGT+xceslRvgC2B/HHvGF8CPvwjFY/RpRoV
 K7C3o6RPKfy0yka2n9Sa/ZRAw45jU4T+WYmDjaWBpNYRiOH95dk6Hqs1Fujau0GtjH+fbE953
 N+wY6UpziuQPPkN0vlO0kQiibfz/8QiK+zmPUl9EcX3qobJzplV2/XWI5atNVMasnZOl/LV8g
 /gthM3B8/aMvybAIum5Kk9AUvhijcK1wy29hW6w2MOim1nzXHNFYexsVP8KP39f1ja8mceSyo
 5Sz4Ur8a1H+lFtqkBYLiUtoJKIvYTfVyvcZ9jAmys812u+BjthQox4j8IFTPD85IggDLcyK8t
 ZJw/dTYUORQr0s+JnJNSKfl1ZYbT2xRlbWviNo/oK81DDixWOZ52CIm9kQ6L1qrhVBsPI5aA1
 yyW3M/TQubffJ2KnmI2OXPRupHY0Z6p88tkDsPnWQBs2SQPh9NeoNxsX6G0wxstMW9kDigQuM
 Iu44zSM05YzlwdEHARuYU4C04MiiuTnwlqbhR9v+Ha11Yaxry7vWHyQIIqQvzAsBON/nXvPbO
 NHoDVof0uJ5y2+GGsLhm/06w6TpR0L+9kMGaQkwglDfHtlpwffsCZiUKz3WvP7UeMfP0BImME
 cxZwz1JNM183dgJBe8ZzsCvw2+ylnAW6/jKx0zdyzZ/syl7lo1mpoRmUnnG6UoXwEK+HKFj/L
 47WF3d/Yiksw4jLsWS62Z1bfnhj32gcceugWBrbF4cv7Y1V1sKqVjyBNt2kno2U73CZA0BavL
 gT9vselQ+/Jd9jmGGus5+43Q5X8KEsMtgz0ukNDBA6poNqX54S4APyAPOaTvmPrE0OPRr5wbR
 bgQsarimMvSNqlDwSPez6GX0c9Nlu8D2g4zi9oTDQeO71+gxgMwHtKOwknm5aRked/a7I6iZg
 gEcr7cYoWxYVpSZK6gtcY5yBUCantQd6wGGJ+xMfxDv1/o4rmsM6no/+fFi99I/GfCxDUl9ph
 IiH2EHoNGzHoeLoI+zkug3M+m6WDV8riAijBdj4/ayZWjDtbmurLBdnZ1cymbkxuk/zKlgCkw
 eRYP4GIkcV89NDGguswudWaiCCGlSPdxsWWa1m8Y3EBPRHiKpqVyQDXkPhlZZnnTemwKPIDEF
 DzDyItA+dkEotTo4keP/ohYED9JyDxagDGS12lyhgZT3VG3xxzJW4VerTOaImzAIpfuY0cCle
 RNQKLwZZedfE2np8DoboF6WEkE4Iuay3UwKzUbaYgTDMaPUfKA7dBQSKkKC47buKY9GRaGwEs
 5torxmvoCQz8rR8K9EWXGYDSY6a8rFnXYuEFY/dYOcQWcQiDAEkPLxRuxxaZVFg1L5Tn8ruch
 LOSMn53rIg+QY5dUZmpcRQ4Jb3jFjSH39vDZ7lAemq9BplhZp66G3sn4hzCXrHYZYdtoz1Hfl
 24o0g/T+Od4IutfGiP8mRurDYPLRVFngV/J8QUHhG+1PgFSlRRUNoHAUfeHzM5l3jZe3leEiV
 3W2s2qniQWKSL/a2dK2gbyb88/XRGmAzJvg9eSkrlx2O4+50290x6IOYopX/85c/Nl1qdjUCv
 zaSKiYWxlSwzx/4UIkCBWv++bX1deWafu8c0szob6Jcy6u0Fhz3n3urc2LolYpKFK5rTRfG7j
 NfUWn0Rz0MOd1s+zIr4jydykkl6YMSD9IHZHVL0FUFwAqbDVVX5lSpynWclwLjoAJox6HFLW6
 Mtkx8SZVSvtBjj0k122KvdMlpJOSaxPoKbeeHxs1iMnQQo4P+phNm+y9jA1aoAVR/2UIV+9jS
 f4ux6Ym6g+qi7TDYCWBZxiHNnB3dOeQOPUuctcGfDaBdEjdJuT5JaA50BvwnoBHAfKoY9bsqG
 cO+5fFmStIpCmMqoh+SAEq39ov2Mx/2Sx8RUNWffT6p3utdWrGxMoIZwkERdHqhiuVnEpchJ9
 EmryLo0uHaYILhOSbprt9Mc6+QWRrSlO4tVaVxdl3n9cmYAHwMWsNF/tBlked2UspzhZC3Wur
 KRlewiA/ONqZ+4UvGr7JkQnzXIJ3Kni/cauix7XhRMQZceB6ofUmvouMzWbAHJ4i9J0plpWwR
 SKTXXLb0ZmIgKHMXLdm5FHnN0Bl2YTfKHszNSWHzL0XCkMWTEP2MLe9PZBVK7ZmS1J8hqao29
 3Y0yn/kN0IPMytjgKXoowAhLsKnl3uD9zoa230MMMJZQ9ZVg6fWhZ9IRTl+wrGCG4dZhM4G2M
 b8UPatifn4I+lsDAyYK9Ki0T3XM88S9d+O1yOdz7tXlB+qNrJE24ha4W4SRbYsUN0k/34zeZS
 zx4gzE+2pigeOsmkQRHoPC5KlCRJIMkea9QWFAQF4RluubGJ59/8cfQ27MchTybKh52GtaU91
 juB0zRxHZ+xQRIbYRTJ90bmwUgZRZ5cAKdZSL3yVN6QsyWEdpePTMWcV+GrYPb+WAK2nsFnaI
 V6Jtz+1BsJiKwLWslbSxY9hLwAoZd6QuCMtrUWmcJMmQG3MHby/TzdYvzF/JyGNtkw/Q+55QL
 1Ove7PNExH3uUaUPm18q/iF1UNaudWP8rxR+sHQqauF06Rf+VWwGbJ/zReRIjBX5E5xgddg12
 9tlV40uPtSz8LgogQCEfhdaEcvbGewKcoIMyo1pfxkiHHKEqx2NX+ewj67SrwFxgRj62Miwja
 gQRkC51Af0id2LTIH3+p3ED2mUNZrAhgaHNUoHWG5nybYHY2zC4LRv+JAhlalIeRb3Afp1uXn
 bd/TIGdgD9+polmkST3wA/YOkMHmLnoqxfoHFhRB55P7E6ktuL6BgdicaYAwF+d3Y4KIBoCXX
 tea+d6+h2jDBWmQalopjm2cXFFU5as4ytfDgJG/leNmXa9JWION9H/pTdtrKCMnuubm+gcxhy
 NcV2cJO/Ou+oeXS1U08ibWDNNL+OctamqM2iSZyLWmhfsEtUaaBciJmBknYgsIRR58jhT1pk2
 3MKYBsc9U29NgzuUF8lL7MBgQdd95fKaYmM0W7aA6rJjRi/mBbgmhX1+SXSQiiZr/J2o5vtn3
 dbeLVeLs9ZlPXoiS+68nXvv7MLJmNgjmneEQcBUihXszNprvILLbFkuTa++qI51Ism18ilHTy
 K7oq9eUhHYq2lZd6e9MUcJoB+rkvuZPpTJ2WH6+XMyVFXPwwR/59vCDTmXbGRAMagGFSywRKJ
 mon/FOU8nPJo5Yg4R0Q0V1i57LGfOL1iKyULzDIwbb0QIehwRQyp2iX2ToBQa2cblX1E2IwHq
 fF3wnRE+vzbCJy//xUG6w3rIeVrpnNtU5kxR0Cmt6uv9AUKWaL1G2TYeeQo1Irj5Yt8PoFtwh
 wbB3OUEb9micYskNY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 08:58:22 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/um/drivers/virtio_pcidev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_pcidev.c b/arch/um/drivers/virtio_pcid=
ev.c
index f9b4b6f7582c..33f6889cce7b 100644
=2D-- a/arch/um/drivers/virtio_pcidev.c
+++ b/arch/um/drivers/virtio_pcidev.c
@@ -125,8 +125,7 @@ static int virtio_pcidev_send_cmd(struct virtio_pcidev=
_device *dev,
 		     out && out_size <=3D sizeof(buf->data);
=20
 	buf_idx =3D virtio_pcidev_get_buf(dev, &posted);
-	buf =3D &dev->bufs[buf_idx];
-	memcpy(buf, cmd, cmd_size);
+	buf =3D memcpy(&dev->bufs[buf_idx], cmd, cmd_size);
=20
 	if (posted && extra && extra_size > sizeof(buf) - cmd_size) {
 		dev->extra_ptrs[buf_idx] =3D kmemdup(extra, extra_size,
=2D-=20
2.51.1


