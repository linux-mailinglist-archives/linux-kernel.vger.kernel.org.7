Return-Path: <linux-kernel+bounces-808925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3328B50699
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C258D1C64387
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F435AAD1;
	Tue,  9 Sep 2025 19:50:41 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C0352FE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447441; cv=none; b=gzKaJfaB8PpHsrmcuj2KtofZ265goUV3h+KYb2D1ordnO4J0KkvhCIfUq38tog2s3p3aSR8dIuwh1sRiqBb5jsCrE1q+jH6rQqNEfpRGA2UT/JZqZ1b2Zu+f/8qc81dJ4XKQzIBcxDSW6pqMKvU2RiLZlABKttzkQfi1C0jp1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447441; c=relaxed/simple;
	bh=boebRLjC3MqhTM6FRyewhM4YpgC8hJFcovwAtYZ+hkI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JPsq2ijEm/xtAGv1QZ+1gERmpMMVonZaE23NloOuyaN3FKbRxqIwNJgM5pUb3TGuiHbV4cHeaS5R144Y3lvWPRlLWrRMZyeN01QrpgO5s2gxilEiG2GfLNeD4hHHE7Toey4Kkfdsq9bcghDj6hb7K7zswdQuWQkynKy0nnS56Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3C79D2E52E9;
	Tue,  9 Sep 2025 21:50:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IJOKrqkLy_x5; Tue,  9 Sep 2025 21:50:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DF7D62E5308;
	Tue,  9 Sep 2025 21:50:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rXMUa9oNKVkg; Tue,  9 Sep 2025 21:50:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B79F52E52E9;
	Tue,  9 Sep 2025 21:50:30 +0200 (CEST)
Date: Tue, 9 Sep 2025 21:50:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Rahul Kumar <rk0006818@gmail.com>
Cc: pratyush <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-kernel-mentees <linux-kernel-mentees@lists.linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <589829523.18235.1757447430401.JavaMail.zimbra@nod.at>
In-Reply-To: <CAKY2RybqkE74EADTPnCUHAXpJLJmM9skPXQ6S3UOq8TK_y9EQA@mail.gmail.com>
References: <20250908070124.2647038-1-rk0006818@gmail.com> <87tt1djtot.fsf@bootlin.com> <93578759.11447.1757322260340.JavaMail.zimbra@nod.at> <mafs08qinn92v.fsf@kernel.org> <CAKY2RybqkE74EADTPnCUHAXpJLJmM9skPXQ6S3UOq8TK_y9EQA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF141 (Linux)/8.8.12_GA_3809)
Thread-Topic: sm_ftl: replace strncpy with memcpy
Thread-Index: VA8ZEQcKf8WO20Yg9PP2GrFtA20LJQ==

Rahul,

----- Urspr=C3=BCngliche Mail -----
> Von: "Rahul Kumar" <rk0006818@gmail.com>
> Thanks a lot for the detailed feedback on my patch. I understand now
> that this change does not add much value, and I=E2=80=99ll keep your poin=
ts in
> mind for future contributions. I really appreciate the guidance.

I hope my comment wasn't too demotivating.
You are *very* welcome to improve the code.
One of the major problems in open-source projects is that
we're short on review power. That's why sometimes maintainers (including me=
)
react grumpily when code is changed just for the sake of change.

Thanks,
//richard

