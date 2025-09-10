Return-Path: <linux-kernel+bounces-809476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD68B50E16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8000E4E5BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0A3064AB;
	Wed, 10 Sep 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="UU+x0fu5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677D246788
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486344; cv=none; b=OONcG+4FOAWu+7GZZG0gwQURVyBrcwzuwE9gEoc8zOvbDHtxKAdgXsNgYVUcqEAV407s45Zo8FQoF6yhmyTfp9iVo0QfMvxh+k6gY16Q5sMZk69iXiIsOFjLbFsy7lUDUKA2SKqkzfglErDLoZyIh0FRfkcAit86o+v+jQk/Ldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486344; c=relaxed/simple;
	bh=BiSHJfuoO49NYwm2GbdHcT3STRW877pFDRQF39t5I9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NllnvkNYZ1DUQXmYFIufsqxo1R0Ae0bI27WKGBj9ncmT9H5GxphhPIMlzKiZWMq1+heNR0h1VWYJvluKQcGIeMZamwY5sXgzvM8VINnnzKgw5/L0JQa0rEJx7yYQRwa0HdXbedHh5uOO8D/JwBNZHe7NpBSuuS5nRcv+dE3j9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=UU+x0fu5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757486325; x=1758091125;
	i=markus.stockhausen@gmx.de;
	bh=BiSHJfuoO49NYwm2GbdHcT3STRW877pFDRQF39t5I9w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UU+x0fu5pHx70Oc7x1vVOeu0F7Oi/A8+YFy4+tV1hC+new4vtwvC4yPsxV1ky2eP
	 mr93PibsRhJEvdL3Vwt/ip6DBgK1Ihe6zg14HF790s+0WmjClUVcyUtvEGsj8WCnQ
	 DOIqmUspotC6wzG7PgQBudi9ELzvpEalh/rZryIn6MFXDBcO9AnNZaJdUHC2KIgT9
	 9gnlrSqciErKhiYmCW5QbiheXFrvV9AQz8/xgqe3zKzVjJ+SW9jrBylCprqahmG5G
	 Q0jNvyLtDdKfdy4fKMl2+/QqH8do6HjVM/9kohI5De3XwM1WCnlCkyz9RWZc1UGa2
	 44HpCZtJaIAfyFdArw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1utps41c3l-00ONmM; Wed, 10
 Sep 2025 08:38:45 +0200
From: <markus.stockhausen@gmx.de>
To: <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Question about clocksource/drivers/timer-rtl-otto patches
Date: Wed, 10 Sep 2025 08:38:45 +0200
Message-ID: <014201dc221d$8e785900$ab690b00$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwhZ0NKL+kAVgikRh6pep9Qx97ddQ==
Content-Language: de
X-Provags-ID: V03:K1:fUHwXjVwRGDvECj6NziiWeCaQgPwksyZajCGdV8yZ7betl0A1w7
 EV39qE4krbrs7aCAih6rYcSd5/3b8rBcgnrMmRROrEUOS5UxGC1dbtbeJxcUUJ6rMXg+eAq
 8lHCVyCB+vrIhzpa/w/ZhniOb7FiWUFYRLBJzKEMgqslD2KVGYf8Fk4Xne1uG8+wp7+fndV
 Cb5eNXSlF93LHf8LBarjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FkgXn5iBPAI=;lrj9eztmO+dHyhQOiY0pvgdjGE0
 4QNJdV+rnrZYkzbTCo6SIvaAczy7PqER/Jf02575m5tMQCMN298kpW6TDskgYZcbFQfWxcbs1
 w0kqHCXsxP6rcBIvxdSzjKPf9zifpOmSOCkFDyH9CPZJus1tOfSSkJX35DqHcIEuA5ouqs7kW
 RMqfZIlhHI+bOBdUJNQVA//QY1lobRZkQ5x2+THhk9j1L79MBCsBZe43mGTFoGQ8Xkom1kzaD
 t6va7qy+hGJJZ1c8QOp2KY6Ov1SHc/ZONUoVUxmH89aLdEgNXuUJY4EwQmMvmmgr78J5rQ7mj
 lkN3xaRvle33CipCQ0EwsB5pTZBtgCbobUrCYcPAF5Xid9Up69ps3XMUpd4X70eWcgFQZ7I8+
 LbgafjoMxjxMT3DhZbWChqqywKEQERkOMZX56marwnzJJtCiLLrLYwDl2kNeMIHHbXzJVimzn
 AwFZ26/w+FwM4OmTUw283s6HBo9VMy7XeaFkGiZ+ddIcLWE6h98wqPxiCC4Xu2Z+IXGLHZ4PB
 vbn+mASnY8Qt3nglNJoKoUx8CGSuF4sv4pfghIvU80D3jSG7vb+6iEOtx9OWQW2Jmpqm7nr6Y
 PYHGwDUfmOBAAcA086dtEoA42LRxWVWd2Px+u0okZhLXEbFbUXQ7IZbAnqO+hfsYgUTeLfjtT
 f/wQL1uDHg8cF/6vepkZsamIcwzP4jDuGXwQOWxYehq/LmoUpYmiusOqfb7EtsMsT7ycJohGG
 2qx3NLmtHa5wkS1fPf2GCt+qvGzpUn0DGE4JXiP4BTjqk2umsyaDY2ES9zJlflFNsLXeUOy4F
 I4Q9UXEIaBVLzL9RtmDOdBUaNvhZF8cvKDj+CiaUiP/4SW9gwnyhLqQAbFkwVD+gkD+4g3ovt
 IgT8GdIPUhUA8DcglZPgDZm3E7YYgVkBzp4mFy6UDRvpCvQpz+Yx3VtRqr3fN5lyb8Y68Sm3s
 /Hz+KRKGL4skeI1PS2e1Q2UE1bdi+qlNrMFIdmjrmaBknZp0no8xgifMR3dDLznOga6hGEsVz
 l3bMvhD5f9pFC3SyM9QCn7KVhhutzYfM92ZoxYBPfa+3gU/98X6qyQE5Ofx5A0WXESE7zL01c
 UVxc3FRbVen1AebLU8NCviObcTVikyGOnSwM2I1PphkB0GCVlSsu38nQ0hjBilFJ1cUkxuKB7
 QvrqNpGTPHQWE3yNiK9EwFTSfTjS+6RT0lU1A8QJPGG5K9/2mk377URZuJuoGPiDqZsK3mQGN
 /rBt0NDjH6+mjN436p+moXNV95VEnep6YweqmMSdvbTEVZBSNUOCQoRLHawFMaXgBLXH1v0Zt
 dgMbmpb0Lo6zBMyID4TD7MvuDfoOgu96Hj4o5lMt2inIE1cnuqpBBcJG1vYyDCahUVqc2JFnQ
 ZPsKHbxLQ/MHyFOXgd4KwKnUJgMacpW5L4h39uhwdo+2VyN/y8s4VcCrDV3G+T/J/fnFOxW5k
 jaU2uhNHjANDPC/f53ZEpxP7AbDL8ARf+9b0uoD7lvEssbeH5L4WxwUsZ796XVoMWIaXpMlDv
 ZfA+VkamLJ6FI6GBjdcRihqAIao7E2RcACsgeqVfbk37wkpoqnjRH3Pp56rq2r7aZgRO9iuFv
 /rdllMs/9DKZqwjAi5DDyxcqlpHMVfcfWXQOYWYqd+T4mqwpMg1gPd6L22KW6S7Joncb3jyuT
 BlZS4luwPC+JoYfYYzJ2p01QrGDyFpJk2tOhkzJTCYEkuyp5XUCTZHlrbiGJt6MVvPLs66cIB
 XnZqpQpAef1jkg340ER3MKGo9QlqomxbDb2tiV+SwEWPBAMb953yEdhtgZOtcsLhRqgIvEFd4
 zULisCHvpwYYgQXh9/3mUACiVNnF2bmiu6BS/zOU7o0sSZHWRzJhec0hflbPyqYAWWYphMXMC
 pZjonZXfVvdfVO1HnFnqSqJjkydZinEITY2hWVccwQXgEV3oiHVK8nssVj5+dq4kkBTQcB/xR
 01JpQt7PK0F8yDl+RpaLQ2As69Umm+ivGNcaN8fZBZ1paqsugZYVvrubcGCm3djL8Ki1Xmvmx
 HeRJdU8tENDvbHkheS+hIIOlgmNXjf+/LGhxpAEvQSRWXe+coxSkCt0y80GlFQj4A6GOG2G3c
 bKiTl8DjUVUv0VstNGyl+DKajAZ1Z69J665WU93Hua1lZs3vYweQTmgCCFKnea/1L+Q1vcuCp
 G1FEziCjfOGS0qzjdbXTLnQBfxZ7w4lHj8e/blLFNd6i0nh+YDWicuSHfOJailCK2gprp5iXv
 lzK4uopXvgMB64jUQFHYwT5PxydvspwRmfaBSvUwQKupidUGzR01M8/Boy7O0eZFPd04fArJf
 5uBkpPzqIeU4HxT1Vb+nYS9zYyQRRJ+SC9K5ovFjWDOxeG7MOdX26zEMFwf5D//tIeZyolLmc
 KvPxSK2okqeFpR83oVNSDP0Jxj8Z9xfDkAhnPyCQmSEgoV8z/BZGtz4Bwe+1wJa3ZPwQWD3uY
 508n1WcKRV814rdp2cOK9mwWEGh1dTbeplQE1ns8iD7P/bHiYMmj46pFOoVNmR4gLEvxPOFkE
 c+U7Y+IOO1vgNL56/rGJgTXM1dpif67X4GgzcXnLwltxZXpNwwLb9viuSV5b2EFS2QOezPX3U
 rVbZKIHC/l66V/dNPor6jrJEi0jDd1e/aJ/i3wCA04MadNbhSWXAYK2Aghwutfa4iArRHkzjA
 G0PvbeDKwEciIUhvZLqOk7uwyAlpTU3KGoYEMLhKG33zhffQL0k6DuvRhKP1JCfLgcJzXMoMD
 m/fvVtxp6Ffk7Y+vW0uvxn7TlnWUlpjSHZCA4DE97/KIlomEhp95UQfuB5Y16hG5GTTYOxmgX
 KbModuf4fwBFhJidwZBKSxWTtc7NK4MWxRex2749vp4nSK/xk1oQKN+opw8LiYu9ETUOIhxfi
 upffZ3A8lYSPY25b5l98MwmmDd8r46SnZhCoAnddC9pwefURgp+F0Lb3vo66r5gFVQL6mwW8s
 LGD53uH5BPILdaAVkTsZ2+2KNFIAzwGYbFIQToMmhCZ+34aCA1+tHspcb/oJrg8qbpnpIlEOE
 Gp0Mqjvs2Bqx8QDqNktZHiVhdI9vQkwtI1YptTyr/sC+bhAGRlf+ZXSPoYX+Q4uro5y3ZEkJg
 62zo9/ArLobwzPn0a5aPnXHd9EJFpMbPyyKlhZMR21R0jFwT+HIMZVH3EDSgP1zrkgSomHVhl
 +KQarSv0btHu45zpJc6Z8GtvY4Y0R1FR52aGQSZ6mzINSaO14ivO7m7y9XKE0mf7hzUJ0KCx9
 wOkWKxaV11n1OuRwue994cjRSysOdrFagZ0YCjbzBt6GEzBHPHp5/GEaXtBNr7toq4uE4Ary6
 SfGRyEipPznDUTxmSceo8kwPodp6/erb1woHgDFztU/h+8o5K7MzeOUMSbp8YaKdGS5E8j9nP
 m8ZNOUAB2DH3vwg9FLVpD7vjlgrDvEy6olxmbIhIKu3SKcCGnAK9VRFohfLJqHPV1PgUJcgEi
 /uOASKPejnQbrEnpiGkgyDsrYyAkQMSsuPJFM7W/57TDKbQsc10ZE2osFMZMKaUBpqzbObaIz
 VN7v/5nBw1iYP0kGzkSNb10VBWbEQ2jorGJ8spZZUV5wqvbg1tbNBsR3cfQEvkT2CGHJ2uluz
 yJ+s83kQ/LUt3pV7BsldJcWOss0ttKXNIKr5DQAE/ncNIQVn32bGINTF1nP5woBL5CIyxFJmA
 3Zlv7soOH1xpq96gRgyMoKpLd56mBIM+WjvFhLfRcixzZJqyMIqa7KekjCWT3EoZ9fYsJtfn1
 4lbfFme23GQfdnQlpsZgAU8SrZLYvBVaWP7+yRSZ1TWZ0UB0AXZjRF825r7SplHOT0nWHYQ1M
 YbtYn9XLOgJg//ZQYHxV61psZYjra6o5rH0SgLQf39EUdtgNTs7yN50zdKdGhEkxmPkBTMTnI
 eTrtt69DnMSj4DnT4164WC+TO8zOnKO6dsQhZW/C2OmI6Wc1Gczcimdm2Y9YongaRsoVdYjXn
 NGapt1zE7DhB3VOkhvap6uUC5OINeYRP8AdEoQrP8VDvc06Q9q8xuGGibIIQW+Zss19Ln1lFj
 4wU+dzUXaOPNNAthWW+3IDJmwnQV2ATYIqfaMTRpuIH2Fkltl8YiRLn+m4Svfa9KRKxdfthaV
 kbyF5kjRlN/NPwq/qi7VZP6sAAKyy3IsHtxHCN92BA5Z5L3uPg5Z31eq49k2QOyhd0JTUVDG5
 f+HuuYTQ1TdRTT/GY+QFYcR3IFoUdcKU957YJeByNE4RG10q22TJS9HBMuIc9KZr1hi0SstdV
 zEhVnR8YwpQfeSyZwXCMlru7oslW+ylsfLSL9DZjHUWP+25Uj9umLEtbSrC9tiCqw2TA/5P/q
 pnmV3GMYMEkLk9tLFsTqv+fu8pW0KPCgJ2iao67FpPzSF3Wdz+uTGaTH6mQdbWyeq7S2S2Nii
 2P3v0fmy/0AexjBgnfJj2yVgp7hkXFMRLU7sIHIp8OMzc6d7NzjzFIHkqz4J63spkoSJaeEz/
 bVfplYjvyyGttj3EjaeIaay8vn957jc5CIT2f8w7v8h5fdobj8v+O6BFa7Zu+7Me7DXzdXt8T
 WKRsPEJRNlhypXjVvY702yH2iPeYNQd2IafTAY++3B+6aI

Hello Daniel, hello Thomas,

I guess you are very busy with other things and had no time
to have a look at my timer-rtl-otto patches. At least without=20
the first one the driver is buggy and we rely on downstream=20
patches.

In case there is something to fix or the patches must go to=20
different recipients/reviewers, please let me know.

See https://lkml.org/lkml/2025/8/4/239

Thanks in advance.

Markus





