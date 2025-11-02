Return-Path: <linux-kernel+bounces-881866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E899C291A1
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE5188BA49
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C6224AF0;
	Sun,  2 Nov 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aog2jowr"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD41F936
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099829; cv=none; b=LM/QAjRAI38sfbS+OvJgSxUaOYsCd/CSkxdbpn7sxrXfmKW7pzWA7tN2QKT1tSplTIrI4SCsibIwDJnueh3F/Rfjz32KjTavnWnYO9WjAgXzHxbUxd6Oiyaqq/9xARp/G7AHePxgJ/9PcsVNQDUUOV7Gp1nAqPPGBEc6bytKi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099829; c=relaxed/simple;
	bh=yvLbOlSfzlu7OO0lCqcD3EPEB62itFwvpwNDXPXQKnE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gjsroA/cuwvKhXJp/YWW0XBOyycQZEA2mBlRAJULhzF19uLhQvALok24DDgTsPwwZhVqrMjBCPzKIJzEGPTzZ3JmUNMdlGSAEZX3Sro6qfUYKbMzcD5ri/I+ORIoTvF1N+a7FdCTiZdvldacUJGFt47WzeXsRb5b4tp/+w58dXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aog2jowr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3696f1d5102so29492661fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762099825; x=1762704625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ip+PNa6DViX5e266FixwtHSs6e54t2XbuEFbHfskKU=;
        b=Aog2jowrguvZnRtw+vKbwIVy7yQVcaZrIHB2WbXddCdGCSoTlz8ao4t9OS4h4QUB2d
         A6si+X7yG572zM9W3c96B17FT5+NfHOZX0WCU2iLtoglqeHmCSm3sITDBHjo5RY7lbNP
         yPY1x/Slm//hNFBWT6H4sYborwB1+/9qhRbTUYxhgrqPSlnD4ucZ6pcx4OgyQFM5yT+7
         F9R7kM8EfUjanwu4sQGcI1CFZxQWRrIIoc57Bh4EEC89CExu4M2ZpcewuWUvEzRU+E19
         NgXGrkLGONlR6/Yxy9O7Ji41M2Aao15UND+VZ9jlXpvZ/6cyisgRrxaWky5H57VgovWM
         IetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762099825; x=1762704625;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ip+PNa6DViX5e266FixwtHSs6e54t2XbuEFbHfskKU=;
        b=AYmfYEyIjjqfjll0cau73vknEdwiat2CjH95UIR2J56xtugn0P4KbpjEhfH6gMCK5Z
         cAhiqbaBQ7HJlxQHH2jrQ8BeqsxjW8S/la2iiPbudAaDPSdsZFyO60SIkTHPELYIVgq8
         gWbkpy7SWSOCTP+IeGKaV2DmH4W5Wpw1bfN8NDdbDOER+vPtJm3ExyU++qerXqMpNdzg
         7/LmDk7fh74A+n1B5G54btg98IvTD5eQMtL8p0DR5QR1xc7Ea7ltd2QTiL0Bsywa/YUT
         25QE/w9DLX61Dv45LIpXAgplgVWa9JxzqhfBbAqEc6of71ZUKEMqbdZClizjmFabKRSu
         oiPA==
X-Gm-Message-State: AOJu0YzQgZIbHuDQD7cif/P70VkxiM+UpHm/KjgJlumF7rlY2l1cXp39
	/JRH8dRHYor+lZOAmnao2+EhGces2r6SAFO3SwU7w7UdHcBEQO/UPSIg5PH7F6M1MgxKiRtbph1
	7XiTeRLy3R06rS3EUmPHYiVlKx45vJ88=
X-Gm-Gg: ASbGnctGDO/plxN3P+q7t+Sc+Jfn81UdEJC+DR5S2p5I+7x/01jZ1G73Z0qpJ/s7Y/S
	CCc7KiXALv5MfsTyvo7asHrO21GfK00zPKK/xnGVCuWN6+FGMlrsStNWEfZbn970R0pH1nh7lkX
	6U5cHERkEpi7frB/MxzoF1fVlQcMYcNUZpG1gddogZQer+etXcNidqZILCY2SBEyVyDskzHU9ac
	NmZpyIleF67rAo4utCTr3gTyOep7SjFCJddyNdKZz+PoWO2EehLmNUpJn7JVmBkcCqwURzavnRH
	dhDsl32ctnppfuXabB1OsF4Y3Had
X-Google-Smtp-Source: AGHT+IEst33v4pnUpHBImRh+pNzYvB/2hoE+X/ileKJK5bcYjG3NDpmibm0soOcgMmWzgFNJj34rEWaj8UZ5BL1JteI=
X-Received: by 2002:a2e:905a:0:b0:36b:e6ab:bd05 with SMTP id
 38308e7fff4ca-37a18d91ab2mr21633881fa.13.1762099825204; Sun, 02 Nov 2025
 08:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 2 Nov 2025 17:09:48 +0100
X-Gm-Features: AWmQ_blmRRzr4Gmdrczq91U8jKDk0fa4nIp24Wd60ytPHw0t5VZzm9uZE4dzpOQ
Message-ID: <CA+icZUUUZScSvNzqgBDyLCEGL0a4cz+EdeKHq3Rdu0QG21=XPQ@mail.gmail.com>
Subject: tools/lib: Use -std=gnu11
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000024072406429ed613"

--00000000000024072406429ed613
Content-Type: text/plain; charset="UTF-8"

Hi,

I am carrying these patches since Arnd made the switch-over to -std=gnu11.

Background was building perf with -std=gnu11.

Refreshed to fit Linux v6.17 and patch-series attached:

0001-tools-libapi-Use-std-gnu11.patch
4:Subject: [PATCH 1/3] tools: libapi: Use -std=gnu11

0002-tools-libbpf-Use-std-gnu11.patch
4:Subject: [PATCH 2/3] tools: libbpf: Use -std=gnu11

0003-tools-libsubcmd-Use-std-gnu11.patch
4:Subject: [PATCH 3/3] tools: libsubcmd: Use -std=gnu11

perf below changed to -std=gnu11 sometimes - that was my 4th patch in series.

OK, tools build-eco-system is different...

We have other places below tools/ directory not using -std=gnu11.

What do you think - comments?

Best thanks and regards,
-Sedat-

P.S.: It looks like there should be an agreement also for -std=gnu++X
(we have X=11 and X=17) in tools-dir.

$ git checkout Linux-v6.17.6

$ head -5 Makefile
# SPDX-License-Identifier: GPL-2.0
VERSION = 6
PATCHLEVEL = 17
SUBLEVEL = 6
EXTRAVERSION =

$ git grep std=gnu tools/ | grep -v 'std=gnu\+\+|std=gnu11' | grep -v
testing | grep -v usbip
tools/lib/api/Makefile:CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99
-U_FORTIFY_SOURCE -fPIC
tools/lib/bpf/Makefile:override CFLAGS += -std=gnu89
tools/lib/subcmd/Makefile:CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC

--00000000000024072406429ed613
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-tools-libapi-Use-std-gnu11.patch"
Content-Disposition: attachment; 
	filename="0001-tools-libapi-Use-std-gnu11.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhhwdfgx0>
X-Attachment-Id: f_mhhwdfgx0

RnJvbSBjMzAxMjdiZTVkYWRkMzhkM2IwMzJjOTBlZmMzNWZkYTk3ZTYxYmE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDE1IE9jdCAyMDI0IDEwOjE4OjQzICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzNd
IHRvb2xzOiBsaWJhcGk6IFVzZSAtc3RkPWdudTExCgpTaWduZWQtb2ZmLWJ5OiBTZWRhdCBEaWxl
ayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgotLS0KIHRvb2xzL2xpYi9hcGkvTWFrZWZpbGUgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS90b29scy9saWIvYXBpL01ha2VmaWxlIGIvdG9vbHMvbGliL2FwaS9NYWtlZmlsZQpp
bmRleCA4NjY1Yzc5OWUwZmEuLjFkZWY2NzNmNjkyNSAxMDA2NDQKLS0tIGEvdG9vbHMvbGliL2Fw
aS9NYWtlZmlsZQorKysgYi90b29scy9saWIvYXBpL01ha2VmaWxlCkBAIC0yOCw3ICsyOCw3IEBA
IERFU1RESVJfU1EgPSAnJChzdWJzdCAnLCdcJycsJChERVNURElSKSknCiBMSUJGSUxFID0gJChP
VVRQVVQpbGliYXBpLmEKIAogQ0ZMQUdTIDo9ICQoRVhUUkFfV0FSTklOR1MpICQoRVhUUkFfQ0ZM
QUdTKQotQ0ZMQUdTICs9IC1nZ2RiMyAtV2FsbCAtV2V4dHJhIC1zdGQ9Z251OTkgLVVfRk9SVElG
WV9TT1VSQ0UgLWZQSUMKK0NGTEFHUyArPSAtZ2dkYjMgLVdhbGwgLVdleHRyYSAtc3RkPWdudTEx
IC1VX0ZPUlRJRllfU09VUkNFIC1mUElDCiAKIGlmZXEgKCQoREVCVUcpLDApCiAgIENGTEFHUyAr
PSAtTzMKLS0gCjIuNTEuMgoK
--00000000000024072406429ed613
Content-Type: text/x-patch; charset="US-ASCII"; name="0002-tools-libbpf-Use-std-gnu11.patch"
Content-Disposition: attachment; 
	filename="0002-tools-libbpf-Use-std-gnu11.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhhwdiut1>
X-Attachment-Id: f_mhhwdiut1

RnJvbSAxOTc0YzVjZTQwM2U2YjI3MWRiYTIyMGI2MzI3MTY4ZTE0ZTZmZTJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBGcmksIDQgTWFyIDIwMjIgMTk6MzQ6MzEgKzAxMDAKU3ViamVjdDogW1BBVENIIDIvM10g
dG9vbHM6IGxpYmJwZjogVXNlIC1zdGQ9Z251MTEKClNpZ25lZC1vZmYtYnk6IFNlZGF0IERpbGVr
IDxzZWRhdC5kaWxla0BnbWFpbC5jb20+Ci0tLQogdG9vbHMvbGliL2JwZi9NYWtlZmlsZSB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL3Rvb2xzL2xpYi9icGYvTWFrZWZpbGUgYi90b29scy9saWIvYnBmL01ha2VmaWxlCmlu
ZGV4IDE2ODE0MGY4ZTY0Ni4uYTY4Nzg2Nzk5ZjAyIDEwMDY0NAotLS0gYS90b29scy9saWIvYnBm
L01ha2VmaWxlCisrKyBiL3Rvb2xzL2xpYi9icGYvTWFrZWZpbGUKQEAgLTc4LDcgKzc4LDcgQEAg
ZWxzZQogZW5kaWYKIAogIyBBcHBlbmQgcmVxdWlyZWQgQ0ZMQUdTCi1vdmVycmlkZSBDRkxBR1Mg
Kz0gLXN0ZD1nbnU4OQorb3ZlcnJpZGUgQ0ZMQUdTICs9IC1zdGQ9Z251MTEKIG92ZXJyaWRlIENG
TEFHUyArPSAkKEVYVFJBX1dBUk5JTkdTKSAtV25vLXN3aXRjaC1lbnVtCiBvdmVycmlkZSBDRkxB
R1MgKz0gLVdlcnJvciAtV2FsbAogb3ZlcnJpZGUgQ0ZMQUdTICs9ICQoSU5DTFVERVMpCi0tIAoy
LjUxLjIKCg==
--00000000000024072406429ed613
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-tools-libsubcmd-Use-std-gnu11.patch"
Content-Disposition: attachment; 
	filename="0003-tools-libsubcmd-Use-std-gnu11.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhhwdnpd2>
X-Attachment-Id: f_mhhwdnpd2

RnJvbSBmNWViNDkyZDlhNGQ3OTYwYTQ3Mzc1NDA3OTEwYzk5NWM2YTA5ZjY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBTYXQsIDUgTWFyIDIwMjIgMDM6NTU6NDkgKzAxMDAKU3ViamVjdDogW1BBVENIIDMvM10g
dG9vbHM6IGxpYnN1YmNtZDogVXNlIC1zdGQ9Z251MTEKClNpZ25lZC1vZmYtYnk6IFNlZGF0IERp
bGVrIDxzZWRhdC5kaWxla0BnbWFpbC5jb20+Ci0tLQogdG9vbHMvbGliL3N1YmNtZC9NYWtlZmls
ZSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9zdWJjbWQvTWFrZWZpbGUgYi90b29scy9saWIvc3ViY21k
L01ha2VmaWxlCmluZGV4IDg3MDNhYjQ4N2I2OC4uNWE0YTYzNjkzYTI5IDEwMDY0NAotLS0gYS90
b29scy9saWIvc3ViY21kL01ha2VmaWxlCisrKyBiL3Rvb2xzL2xpYi9zdWJjbWQvTWFrZWZpbGUK
QEAgLTI4LDcgKzI4LDcgQEAgREVTVERJUl9TUSA9ICckKHN1YnN0ICcsJ1wnJywkKERFU1RESVIp
KScKIAogTElCRklMRSA9ICQoT1VUUFVUKWxpYnN1YmNtZC5hCiAKLUNGTEFHUyA6PSAtZ2dkYjMg
LVdhbGwgLVdleHRyYSAtc3RkPWdudTk5IC1mUElDCitDRkxBR1MgOj0gLWdnZGIzIC1XYWxsIC1X
ZXh0cmEgLXN0ZD1nbnUxMSAtZlBJQwogCiBpZmVxICgkKERFQlVHKSwwKQogICBpZmVxICgkKGZl
YXR1cmUtZm9ydGlmeS1zb3VyY2UpLCAxKQotLSAKMi41MS4yCgo=
--00000000000024072406429ed613--

