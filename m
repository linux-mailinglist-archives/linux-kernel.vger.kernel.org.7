Return-Path: <linux-kernel+bounces-878427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB91C20911
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2584260BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8425B2F4;
	Thu, 30 Oct 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KGRfSEQ2"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC11A9FB5;
	Thu, 30 Oct 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834168; cv=none; b=UPAsI8siEVGmreLQPOXLN4FBh6ln15A7Vrwc3M1f0AEM2dSauxpfYQiW6ubKDu0598eIzp8fKUfbfcKdAl/2Gi8k7Ah6L2+iT0M6Y/MqTP1JkgjAiFvLO0Dw1Nz9VUgfGuewur55nHvS6SpqkRa1qxmi1r9NkM3Gl1LcHa+GVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834168; c=relaxed/simple;
	bh=nQBSskfH2ELgXa6kPvuWTv0xsHVxBuWS0/JEu7LtRYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSywAXpTeRMoO3QezOid20Vret7fdTl7ZDGcKh38sx5fH/zpGJLX5uchkCYSKfBqF7Iijdbn27a3kkOpUMWHyY8xQ2+OuGpAm/NjWF0l647lX2Q9CaO/Pzx8iMwLHac3ZwOrJ3Xx/+y8Ao42Dfh6FvgnPmZeyUdK1NTl9Y48Y7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KGRfSEQ2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761834163; x=1762438963; i=markus.elfring@web.de;
	bh=nQBSskfH2ELgXa6kPvuWTv0xsHVxBuWS0/JEu7LtRYA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KGRfSEQ2cpp6T/2Dazmw64bF1jHIKcSmT/DbnWStyGV+RFwedl+XmBG2q9qDSqSB
	 hZHQ0/urJ4CL9sWIRZNf2XD9XDVte7SfWKBx+8ueTGoxQyHXZqqI7/KT1usa3Oxb8
	 6HsixA/Vnb34XHXq2h16BeGUFpruF33+4bgjeaTlFGRFJwW7Ahuie+1ze9XUvwuqt
	 8hDTYt9hlvER89h6KfWdSRkWpkOy3PVLHp13/iHZQvzzMHuqOMNLzpOXIAmaw+Eqn
	 YIqXB22OhxvLbtfCaYLqq1Zrdw1r3sPiLKX/Jf/8HZS0JEYXcVgsAg4X2KTy3TFCN
	 SWWucz6D2QNC8oZnmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1vdwuX48p9-00KieH; Thu, 30
 Oct 2025 15:22:43 +0100
Message-ID: <2232fb5a-2e5d-48a0-a8f7-97826e0946f5@web.de>
Date: Thu, 30 Oct 2025 15:22:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
 <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NfX8WnPjxKokgpSMU8CrErNXJDXfEOwMizA/0EtVVRtoaz564wF
 MarbB837r2Cs4Ct/jmvCwv/ZMoKbAcf4KsKuQCDiliidal2TPnI6mDbEqu52gqs8tqqrgzo
 3iQhUCCVnC6+W8RLm/ka1crTTjsdvCpAdOhenWVQdhKBtuPJeUxwqTkpFXBGDsSg4z/v1cA
 Nkj1AzxS7edioobgq8GEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j1ZNHeiNWZw=;cRASlzf9s1VsgVNwDwMMR3JMESC
 5zlOQJA+a9Z3ZHzoaKDm9pt9ZKVE5g9vZWHgJEtgUKOcHyrNNwMLzPIdjA+JD+o+Dgw/IJwB2
 49fNPZ7GX4jiJA7Ly6uB5ckewKzSusCkUc0UXkI/S4tUyhYJfs5bEhvFMYJHZEFP5X+t2enr5
 aKAtEhc/WXu1esoiSsYT+AQzlw/pvx0xnKlr5caLuGFLoDRxBd18WFn/dQrWSUeFaW1DUVweJ
 aWDgRdAzxKVbx6ifOnRGNx+WxB3hKNg18LdmTq4u4wyFh8Gr0L6B5KlHD0o+njdy9jyWBN7lS
 75xTU9Q0wP6SnRr9BKEOhKIjIufXXIzHCs3KkTc7p6lN8X1U75HKdIEjlwm4Kmt3ybGV5jnnq
 oBYjjNtA10NGUyh6n51AfEEMp9wO5jTAOcQJ7OK9Y9vYy0wSCqTFw/6fPgEf+fbe7GNirMl32
 ht0qFXriSBmwD4XsCVm/20seudzSs+O+nlxyBOGq/GcbPMwMlNcsv5ODlL5MVyGwQR4/6AL5Z
 8CAZRkM7M8hHjXmDr6oevy1kMUOh7eK8ZSXMAazfBePXXgXHn2hNmXZxqvy2btn74kKPYrutL
 WJy/p8WZZ0mLEuOvqm4KZX+rnd7LDcev01zE790nmYcbXZO2ryp12U4MDMX3djNzFS95SQUab
 ufskYgFxmqwyg+lMOJJ6DF4v+kqyvmK11K7g/a0yehJ9LeTc334xf56ZcYtI3deJTTGWsmemP
 zf4gF/DRvewiGgTEiJ5XltZMiRpl8OxlP5eo3VOHTA8/MX1dmESYhEM04kAWlW4OeVeFA8Xfc
 +ZFZASVsqtYbKWPpd7J9WSfGmm3GSQ5SrmTWIycN/pHnHGs+86wEZ+lHL4J/axeuOhTVhhpSk
 CjLx6IuYp5i0kezFvj5oHh5pb6x7SSmFw8NRIO+nKatXlmiBkzrvn5311nEfQtAOWnQwkORze
 5uv5sOkqD/VYCeY2W/v8GhBVjiyRp/Hx+XqhEJWQYwN/GLlHQxitN8I+tw/fwesrAGI/2NsxD
 jYxzdxjP5+tXTl2tLstgTkg7hEh2z41pBg+AdK4MhX7mCvTn+GriPJEhqO+PzVEGRv6u9avN4
 rgruThS6myD1wDBD7MgiyMAv8LdASZGV7EdkY3bIkgiQ58HOWnrfCBIvis+JaUDNMXoVnftvo
 yAsnQr31pn9yj0gRMH0Rmm8F82Ku6C50fwvxHIPyvUygOB8l9xryMyl3huVx/Dq6CfnHhZnwq
 zvNsPKEEwNjsyoeHiML1XMSz9rA6eUa8xCA++lvIgco0Ms05j6/bKeXhgwgPO9xVK/AOKXqLF
 qk82bsQ9H+mNlxvxvcFotul8i8sQw20GziUfAqesmL8vvOQ4njyZaDlBPysWJ0bGEyp6Hs0VZ
 NYhOT7vGqY5TA5ZBAdPLiQKWvWIvjUw1tujorVmRxM1wO36yAmxtVyUBK8cnLFbgBNehpuOMc
 O+k5tZgCDBoKPw9r47ya8o1Cs77vv2nk9F2Jrjze5ooLHWYnamxWsyQkhOdlQDg3PLfNwBJNh
 XSaAn4ntfYceNUUTOw+ahZx2o8rXGw0Es3JyhwEXVyk4gaARn34V3drwFTxPhXyu6gBOtbP2V
 CgeWX00KtVBE5QG94NVy8plP4rirpIeaLvwMXn3PxVGiElFLMLAS4DGVzEyttE7atMZyKZBdE
 5KPRx4FlWGsEY8yeg3twy9917tITcTKzl/QAtnYreHM3+6MjbwL1KnVbAt8os+Hr6i7E9VSyr
 RMBArFxLUDDdeUzinM24KnOZnQ4HHeFXJGJR5sgR5c93KwRWtCmNrwkR9B2/riuAGV0TV2ALL
 OVKG02Ej8qOgr83RxXsQ1/1r7Owdr8aaTYA0U9HT90xzXaSfR/UpUrlGGJgsXONAVG2IDh0mS
 BrBi3bfO8LMachjvz9vILyceC4UcZtfVM/8mzCErbo+XCxK/1FE4B0HUOH5jJHi5/wgh+Nmh7
 kk5xnOzJ1/4TWRlKHaYNXiKBYEMAzrLUxczHNIkioUNMragfCT+ZX/s6D8LORcq/lx3ReEJkC
 F4nk5QtinR6xikZm7bcjm8otC9A6PK3MajYQx2QNsrvHHm9SaZZ0SL22NlfjyQQn+NzdExLoc
 vYc3d0AxJ9uzYhQSkauRosjpgapZ7KlzUinDA74ciwWiAwyhdjN6r+r1hlJXC3TZOHXM1E2Ih
 KCfUHQlbaBbIkMFMf6iirWhuL3gXZoOx+zwR49uTfDoNfc0xAzxNbtrCTmiBa2y5urh7CpUUs
 O86CFiOnydYcnT9x5blgCutq6LHe3oBVfndB9vej8JKfwd3kJAk2PLuZihM8RETlnpGix7Q6z
 SdOPp/rOg4sSHBi/1UBbyVSgxugdS7fHexoEndYsZxd5zNL4lT+XWYl/qVh2YLbgeROpeZWqp
 ocP7s6KPZUkQVsGDhFtsDvCUyJ30RpJb7PqkBop8MYaOafoWoxViWcj9gywf93gNfxKHd8PlS
 3RXa/Ou0SXOoMNVpVZSXi49vnpPKY5UhbKUK5H4sVdwqS4ASSPDuCMdK0FuCPUIXDCO/qbGjc
 +uuPr3EIeTuuSpqkZcUbOoiUYa4oXWbwf3RQG766C94cNiqB5JK1aic/pWcdt4q/LcLkbKFjd
 coUVAjmmQ81/zzOeFsAaLPPNdfC51XKBVwERvwOq+/YB7yaw2q2+z8cjBJQzFnDJymhLgzrwu
 pyzG5KZOLj+vvGlNXCm6Ff2OykBJkQW7K13DxGkzafOj+9/fSU3ZHQg6DPj9pMHPSZnnNjvA7
 KmtRy2RUuJ9hqaNMdZ5KtIk79rSF886U1g0Z2uLfl6yNVkBVKQlypK+IpGec4/EqMCn8P6HmN
 o9gLkxkic6Ugz57DFYng/wpuUZoxUcLkusao2fBGdqK4vIRjIdFgxhtAcYPs5KvReh84GTJkM
 87pQZIUjGHAxw8f702e3JpNCBdxV1Jqu0ocBpaNFfNmlLAQAW5GAC0EhzBYsrjzBwiLpyM4ql
 oyvl9kbmKuGryR5a8GEu1xPcxgzZHE53rCF/Qf0dYTY8T2vFWmvjqRSFOIrEh8YCv3mO3bQM9
 RKT135JIvN5jorHYzgz9Ak9R+EzhU52QIQDzKZ0MAdpITYiiblwD5LWoiowS1QhP0KPt4wVlS
 6Ihff4X90VKHIM47jxn6zdBV9Rfp6fElvWOKDa7Zf7wbTEtP4naTQM8tO5hCwLOFEBDs/pNHb
 EWPa6P4MPJJlz9nL1qDZoCJcMuwcTqNbdIpwYuYPiUX8w3tAQOPKBO4kvF4t80FJc7O574nnc
 9WK4R8ebDAMesf50oT4VZADxjyu5MPVjqTeJaL4meNp2447w9xItKMi3aOEEwDYEBfYcY/VsW
 g/MZTqxIcvoiBkEmw5htS76ioFjETbCJVU2LtI5p6RiqaAZaDCxD7jMq53YnUIL1LaohZW5t/
 VR69GyH/Z/PITKLOeC7X7KnakG5buZvYEbgZNPWRNIEVeX2ZGmEJOmGzchwUgVS0YlVnV9w/X
 yL0ePS2CuQ0r8da/MiVN/PdfVQUzZ4OnnVo+wh87oMH2nOST9GgGbrhIyuv4cwL5Rsn/2YULZ
 sUAkSzx02cVMB0C+TRe1+nYgtLWn1NSvHPEfiSlrK5pDJi0t9F9S/UTA553yIiq/32pvTQ6FB
 ubRRqh7apC111BmHzSyryBX7+zptZmE635OzR8RNQmh9y199UgI8YroSb3+yl2JFIvGkjMqa4
 imUMtFahYehuH1TZ58wC8qcL/+9yZCMD6GbiY/vCzgWIZtDaUkxC8Dd6iJuY1Y67lxKQtMld4
 N3q2xZ7WJrdQgL1iUmXHmDd9rHEuJx2k6WjyEUNVaDneClf7rn77CH3Cpw9Ge1rLR8cWGS8TR
 4TPrWcm8m13odQZDKTyPVcOR3/iu26LbZllNHxeuC1NR3Un9ACr/Wqk3B6GEr7cExubOKzFpg
 cN9m5gZlRYwF+lXUMwBt4ti4Ca2iZ7zEwgsPQPdbaUbBb8pO3Z+8gC0YvCz1/SAZeZzcpKHfH
 1CvMD8FuyejPnrCTNTQSdsUsvgVTSj+JmEOiO1VRLBy4GLTkSSlmRbIJvNItXu4I5ZQ3xmCSO
 hoGfwpJyV63PguiW3e+GjMzZ/nh/sEIH5GTOjqCuTQqbiqxFjAJ4gsLHl4wNb98BYkCvimqSG
 4RmQURx9tlP63fb7VttJ8IEnS9uQ01hMwFueaL9ov6dFRlrCnbBaXRugKiWxY0MvUzxYyNcLr
 DZKulHqlKHodf/UKiMUjaQ2/TMcja1p8/LC18CSehOdbsjL7BkYKeZWtGUCg7NYocr8hqLxby
 QgLpVI62cdqOFK9c2XjQiuQf3etIAOmbGMHyWjCJTepgEyngThHxMX4bkD8y+ULhEARWOz1AJ
 BQWTYZLtvhmOXVg0gOFaKJYN6fXCrtg04YJhzgItWG2IU71ETK81ALvOYCY3esQP54MuRy6gk
 QakpZ3qvT8kzf5pAzbJbinXRLIuE++PzAUWBr6Uw/XYRcPNZbSGUu4I0hI/iu/iSCRO4RigkS
 vazZylQ0G7LMXCRX6DkzpvTL7C9swUIcE4g97GA9wpEoJMwJQ0IPEAOf9wizemeg1Vrwbcf6x
 GjHWo+FcUM+UaCyE812R3FiFomBYCHG2cptxUSNkSOUpN4eL7svDy/xMavuTtFlzqlHZnm9yn
 igwtq3t51ZJIEAyqswoYYlp36mBtbdeFMkfAJ3Bl7zmvfhaNgyoc9VaZlnWpKjUbuEdjfcAgs
 30r61X7bRdPqiFQU9T35NFjh/j5v2QfOo2v+3OKVvtY1y+95rQ+TOo2G+TPyBT9HyO5o6JLQO
 z8ej0ewmIFSQKChxxpV+pFM3k/mGkouxMpqlOBBsS+NS/cUzTG0jd9X2cotC/bG8ScTtWS7O9
 A+p5HUvIQn1TsnxNHKAjH4vPASJEStDQxq/Nb8IGid8hUpwxpYLenkIv9rRfRNKXpEHzLd1UI
 ks8mi++D8Yzw2FRPGJn+rKzvYh6DYPwrwfVgflHjwLqlMbOdn0Kk9iTCoPH3GB6gvqVuJrRCL
 9xxwEziJzbUaQQaLx3C0eNhTEDj6fgYfTesrdZnv6nl/UAXXqWc4Zwz/

> No chance, given Dan's negative feedback.

Will any additional arguments become more convincing for change possibilities?

Regards,
Markus

