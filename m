Return-Path: <linux-kernel+bounces-749878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D6B1541B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389BF18A6F00
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2522BD5B0;
	Tue, 29 Jul 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="vb/LdmXC"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2012BD5B2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819833; cv=none; b=o/7E7LVInECr1j2hr6Bc2bGcXM25oyrj5KKhRqkdCGNnoXRjvOy+LvlRWpvnCs3GFQY4c9vxqJ26q7gHgxg5Iesij4rC8a5UIhh+mIrAZR2cUekgD8FRC0ulgPIPTYbo+PznR9P2LmMEcpWJPSWl4hhxktuYoHUtQjVa79HSAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819833; c=relaxed/simple;
	bh=Ctw7qUs9O5onW4mQa6HCTkye1kUtXx0cLhBA9PrYEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ER2lXuILWRcFWLT66L5vWWqechc3z9LO23heq0FmfZL/iHa0KT99wqIVLE/UGnVAOu+A2MiRXmGdraQvuhoMQeSZuWzki+DpcyCavI2WqcHGbs6HA6YjC56sKdnDUXEAWU3WtZqLciW8SXY+OEinw2QeW9H2EjfnM2lhqmOXbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=vb/LdmXC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so2275863a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1753819829; x=1754424629; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKuOQIUzxLcHTK7W3h1Rqt2SBeSCsDHUPMu2l8U3bnA=;
        b=vb/LdmXCl5o6ChG/pD4fqcc+xsxdzk5s01ySHw/5Gp/O8RPRfO9RQBr/Xeq6eX5HKE
         U4dDir0EW+ueyc80mIBO4o6bAXDL/g7E+2n+RJ6/dcfnkfDaouudPMV3BmcynXCdyP+J
         zLQ58uMz7fLOTEkQ71weOvE0D73fJ/oBi9c2mldzWem/bpEdK9ypTyG0vZAkQ48LCVuZ
         y4HUkD8R24b2rk+073iFICVwNqA/jhyP00o3+97pyV30N3zqs+9hfBBEOGq9T5hvq94G
         ltUcar4CEr1PmdJxt0Iocz7cLzCQk958xSIJQyLKjwyoYO9nxHgqN1wfl9/zWEetS02/
         AFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753819829; x=1754424629;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKuOQIUzxLcHTK7W3h1Rqt2SBeSCsDHUPMu2l8U3bnA=;
        b=KQZhdm3M4q4Bho4G/NtZgsetLJ9uc5Ur4VjsqxVMP4CTUnl7vc5OvX0S84t2DFFvQ5
         SXSKjYeyzfjRd+E3RuZ/6e9eo9KNIoFofw5uT1y3CkSMuIlVFcOvUzqIbvrwJmKSdTJ1
         j2lrxTriwM2SLvtMzooqM/ggTovebXDOR6WA79/kf7iE/XFWehZtf5C0aJ5EH42fZ91P
         gtHaPihLVQrjpJ6+Ux2gqUOXgKWt4G8GfHZCaVtE4TUpq1b+T8eEXGUwJll0vfsfk6pr
         htqfckE+BqfDjxQoRxLCAkgfm4ALcY0EvE8i31Fs81ouA2+Gu0KEJsz4hhn8phKV54lR
         kIIw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GgC3P7Pd5YiVIgqRxZ9gGdMx+Y//iRVYbh3k4D+37lTDwwLRm3Lu8LPLfoar1jYkyOco3UNUxLg41bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTyQEIuiuBUmdb7rMqQccKFy0dN0Yrecuc74xPRFc9fh2XU9f
	pWVYrMIdmpA4jrOzm59Ld+9v5KcCp6VE7q3/R0ba3Oo1KHW/xfHEtsamG8+hYrGZZIA=
X-Gm-Gg: ASbGncvboMatTdfm0cifFCO/ASqARUVbe1P/0xlAf/h9opxHoNDdHoOu6q6PykgK8DC
	Y3qGDm0NvgOiSZQ2VjLGOSr1c+rK4CYDiIZlTZVxniKFpio3OG6vVifvWbFv2PNHy66tEbdTLFz
	3myDLRwKEq+N4cTlX+DE+D23Mm2q+puzU9Xs2XonMyyDyNT1kWbt9De55AF6ZEN9+mO8HrsP2rb
	GW0LKtGvSn62ZesF3XIuCaqDqdJvZBjTY3mTHyx3OnoVhyQJv8mSbooWVio/ZW+j0E33S4nIxVT
	Kg1rIWA2n8YKILHHl1HZn5zor8HD6UDzPYfQdBfExEV2pi4Tnh92tDQun6rNbKNk/wwez1dqGO1
	IYtHtIDddMQp4XlouiSDP6UjtvejEYQUqyelid1mbOSe4yBKO+kfAv0NImCKw8fk=
X-Google-Smtp-Source: AGHT+IHOcV6g/UKdaeOksJAZv8oqi/ykcVNEIP0+IbKecU0CG+YVXXzJt1mG7mOgdrjHD5QqgjsYNA==
X-Received: by 2002:a17:906:f59c:b0:ae9:8cb4:2fe8 with SMTP id a640c23a62f3a-af8fd97327fmr77327966b.37.1753819828620;
        Tue, 29 Jul 2025 13:10:28 -0700 (PDT)
Received: from somecomputer (85-127-105-52.dsl.dynamic.surfer.at. [85.127.105.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a65fffsm622702966b.76.2025.07.29.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:10:28 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBI and UBIFS changes for v6.17-rc1
Date: Tue, 29 Jul 2025 22:10:26 +0200
Message-ID: <7787490.DFzTOozpa1@nailgun>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8201394.atp6XCIr46";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart8201394.atp6XCIr46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Richard Weinberger <richard@sigma-star.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] UBI and UBIFS changes for v6.17-rc1
Date: Tue, 29 Jul 2025 22:10:17 +0200
Message-ID: <7787490.DFzTOozpa1@nailgun>
MIME-Version: 1.0

Linus,

This time I'm sending from my business account because Google still hates
my mail setup at nod.at.

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.17-rc1

for you to fetch changes up to 99dbb2a1bd661418be33b1ff1462c09b7d2221cf:

  ubifs: stop using write_cache_pages (2025-07-24 22:23:14 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UBI and UBIFS:

UBIFS:
	- No longer use write_cache_pages()

UBI:
	- Removal of an unused function

----------------------------------------------------------------
Christoph Hellwig (1):
      ubifs: stop using write_cache_pages

Dr. David Alan Gilbert (1):
      mtd: ubi: Remove unused ubi_flush

 drivers/mtd/ubi/kapi.c  | 27 ---------------------------
 fs/ubifs/file.c         | 10 +++++++---
 include/linux/mtd/ubi.h |  1 -
 3 files changed, 7 insertions(+), 31 deletions(-)
--nextPart8201394.atp6XCIr46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEdgfidid8lnn52cLTZvlZhesYu8EFAmiJKqkACgkQZvlZhesY
u8HUMg/8CFqSNVKYHdzD7cewEieFJ0YNPN+DD0MkgLGoDKfahWzLFN8owTKjEvXV
ScyrVG6gSXuyGkYDIarmmupKnD8YXyNfoLLlVoYDh/LvdJhJNvcYo46jPZoBTmjK
r6oiI1pDdWV60BT1Vx10SJqA+J/xkbyrxlmtVgEeLbhH6SuzzqOxrfrmargK1q6h
TIsbzhK57x1o6DxTB8oFpVSPqmeegNEsuaCZhZ/RwrVUUgADnfImFkjhFafSS41w
IBmTY7NBnEKQVBgCjLBDWAIt0mqxcZsptFaNPe7UJtUk841Ts5kEMIt9B5mlupnC
qQmRGDjDUX8JS/MeMbISqBlp+0JgJLN826lRtD9sli/RFMUhO+d2ONYvGJ1XADl1
zfkITxx2SWQHSmBwe6QUY/OpsgM1eqr2N4PVbPwTDV0266XSrr2CB/uFawbpKWTC
RGCv+8/yxXfI1+yxjpT0HVVT/5YfbMM4Z8nWDK5PAYqJ1GTL+WcYfShE/xke1sos
tKtjIip/zk1MDbCNo0GwVl0wlOJpL5jhwVWdf3HbbDoTRdAuNSov6batWzY9L+EA
aBnrqkK1dgOwnikGLnTACrYsOqYGUEhuLtokFFBQdWSTq3XZP43YRUKmG9umj9bZ
VSYbKZxs6WwUCdRyfIYzF2+OCE3L6C7p6cJcU+TYdqhACSiRJzs=
=3YD8
-----END PGP SIGNATURE-----

--nextPart8201394.atp6XCIr46--




