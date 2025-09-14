Return-Path: <linux-kernel+bounces-815555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F2B5681B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06639189DFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEE21771C;
	Sun, 14 Sep 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agcatVAn"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010C1C3C11
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850422; cv=none; b=HM7ulExpya82O3GwDLfxON/ibwRjYdEB0nY6VxJXo1yZA6+OVwNpGpTJ38ODfROLfE6fz0QFcEWGHsS8q4ll9mjo6E37Rtn4TZp27pRbvCWobCGZye5eOtjZ+jjKAm3CqrmElwzYjKm41xr30mUUSReL27r2nmwpb7usEQDWDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850422; c=relaxed/simple;
	bh=Vef0/SLB/3XQ2NzY+zZJs5h/v3G/VnhCfqspMhV69LA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XRQRL46sjJ9DQWL0SnlLH28M9fVO8TU6nY0EIG+oPwl9qkZWdthoeT7HMSuV6Y82cFOuDok5cFgPI0CniLRlO+TLgI2qLS2c4KVvKvGwIE6BpnNVa5YAg2WF7UsZicfBMbXy+T/68wgY84lueegVbgC/UhPyCYW1spm3Z7ryqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agcatVAn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so611472a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850419; x=1758455219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KAoKXGVHOziQYjyeD7oskha56VrVUi66sfNUrJXD8k4=;
        b=agcatVAnr2DMQj9ExoTdHZbf/bBzH9UBWAOJ7x/4V5+1zwD0Ia8zoqJuhOnT36ZYbB
         u/ZFr5ZRVUuAO1kNP6hZieta9VILbjcfd2glbwjUXo2PMsimLFf4go7kr00rE5lR5Px8
         MOfdpnKonhmUtOJyDutcI+SukyOYQP3dUqSgE58fFRPCZXjlaDRM5jVfIQtRJIRngFNO
         KynzczucKuy9ptszw0Z7ZLC9uSMThPHa8uDqrqb8STTP8mbXuBkRKV2rN1KWa2XqCkdy
         dTroP4BZV0wT6l5IPlLwdS+wQ7UDJ5RMSvKUvNgrXZJ8h5Goq2hY77vWN5SW/HzDIxhM
         5mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850419; x=1758455219;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAoKXGVHOziQYjyeD7oskha56VrVUi66sfNUrJXD8k4=;
        b=D++KaJyFrgeurSzT8pYCkSt2mcdf23pTBQCDyWDnM0RWl9gjj0qz5rjre15ngJV0hs
         EGCjJO10nddxN7sVrYCJjS6B3/HT3sZm6tTZvbTCQQAEqb2pFkpbQ83T6dDrv21NPNJL
         Df1Zfwf/Gf/auPbggRPOM90KZKvO8sE121GySSenZKy0jmClE61NfdUuoHIECvrb78qr
         k4UyLUnPBYbVo0iPFyagc8U+zQ1dADaq9N8jT9k+3QOxFLQCaAeLSnD0nezv9VEPFsJf
         RnoBfeDTVCzb0NUOlsKuLCe6eoqr6zhWfWaAvahSGsfO+yjdPLSDFSM9kKLZbhVCPSsj
         UniA==
X-Gm-Message-State: AOJu0Yxp6TyPX/+U9fkhCoXlEgO/elcmTYmNTXYy/2yPsHWeHQVs6Onf
	FzuaUdW2Fs7xtRkfwHu4OLyDg+MikRG1mrThcd7vDIeqhhS5i/sqxHVRS1dAqfn92FID2oUROmr
	5bM0WKm6xKtWMyw+2j7rABPPp6tAKijY=
X-Gm-Gg: ASbGncs8mvBf3hmfU8iBxWAaH0v9pTjdg7ZgtuF+GC+2dGtaHnPu2VjOd1AB2d/AF/M
	4Lovyu4W0ZkZV7A7hj+Mu4LCAOggQeV8tUyAzHaUIoJniB1FsuZTp6mz+GlCu3Pfk+6FX/5CEMo
	LVE2d2tkSzNqiTGFtI1jdrVyTKDzy69m3eazPJgPbZhvyO+lTgEsgKacpE08opJNGZu3q7duJJF
	QktGRSLPP+KskJz1+rkVm9DzEj3wQZGpYeF4G8=
X-Google-Smtp-Source: AGHT+IEpP10MNOWGMBt561kTp0QfX0VTRENIU/XkgHJ2PqAPJHdz1SU6ZSejVF2bFKE2L2lOOhFcEwhrYwvbZwVpnCQ=
X-Received: by 2002:a05:6402:5109:b0:62f:166e:5ba6 with SMTP id
 4fb4d7f45d1cf-62f166e68famr3236093a12.37.1757850419147; Sun, 14 Sep 2025
 04:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
Date: Sun, 14 Sep 2025 16:46:46 +0500
X-Gm-Features: AS18NWA5EjUc-m50yG81LE_OKBwsLECpU_sy617z6OLKwThiYyPJI1q_OVGHz8o
Message-ID: <CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com>
Subject: [PATCH] Documentation: staging: fix spelling error in remoteproc.rst
To: andersson@kernel.org, "corbet@lwn.net" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cd7344063ec17161"

--000000000000cd7344063ec17161
Content-Type: multipart/alternative; boundary="000000000000cd7342063ec1715f"

--000000000000cd7342063ec1715f
Content-Type: text/plain; charset="UTF-8"



--000000000000cd7342063ec1715f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--000000000000cd7342063ec1715f--
--000000000000cd7344063ec17161
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Documentation-staging-fix-spelling-error-in-remotepr.patch"
Content-Disposition: attachment; 
	filename="0001-Documentation-staging-fix-spelling-error-in-remotepr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mfjmmnlu0>
X-Attachment-Id: f_mfjmmnlu0

RnJvbSAxMDMyMWM3NWY4ZmMxMjk2Nzc1OTQyZjEzY2IzYWY3OGZkYzhkY2M4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWltb29yIFphZWVtIDx0YWltb29yemFlZW1AZ21haWwuY29t
PgpEYXRlOiBTdW4sIDE0IFNlcCAyMDI1IDE2OjMxOjU2ICswNTAwClN1YmplY3Q6IFtQQVRDSF0g
RG9jdW1lbnRhdGlvbjogc3RhZ2luZzogZml4IHNwZWxsaW5nIGVycm9yIGluIHJlbW90ZXByb2Mu
cnN0CgpGaXggdHlwbyAnaW1wbGVtZW50b3JzJyB0byAnaW1wbGVtZW50ZXJzJyBpbiByZW1vdGUg
cHJvY2Vzc29yIGZyYW1ld29yawpkb2N1bWVudGF0aW9uLgoKU2lnbmVkLW9mZi1ieTogVGFpbW9v
ciBaYWVlbSA8dGFpbW9vcnphZWVtQGdtYWlsLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL3N0YWdp
bmcvcmVtb3RlcHJvYy5yc3QgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3N0YWdpbmcvcmVtb3Rl
cHJvYy5yc3QgYi9Eb2N1bWVudGF0aW9uL3N0YWdpbmcvcmVtb3RlcHJvYy5yc3QKaW5kZXggMzQ4
ZWU3ZTUwOGFjLi41YzIyNmZhMDc2ZDYgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vc3RhZ2lu
Zy9yZW1vdGVwcm9jLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL3N0YWdpbmcvcmVtb3RlcHJvYy5y
c3QKQEAgLTEwNCw3ICsxMDQsNyBAQCBUeXBpY2FsIHVzYWdlCiAJcnByb2Nfc2h1dGRvd24obXlf
cnByb2MpOwogICB9CiAKLUFQSSBmb3IgaW1wbGVtZW50b3JzCitBUEkgZm9yIGltcGxlbWVudGVy
cwogPT09PT09PT09PT09PT09PT09PT0KIAogOjoKLS0gCjIuNTEuMAoK
--000000000000cd7344063ec17161--

