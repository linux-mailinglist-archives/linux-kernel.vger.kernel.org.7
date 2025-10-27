Return-Path: <linux-kernel+bounces-871806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78843C0E5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B1419A37E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D263093BD;
	Mon, 27 Oct 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHs/7Y0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9A307AC3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574689; cv=none; b=cw3GhVKasUEWjbvCapx2AA6rY9bIabW5nWffjhUW5tbHvS6jbx+Wdxar4ytKF8LzCFqSMoQSoTy9LM1sMZ3dgaRlizfv3z2GTLUqTJLPzjWSL1Sjr+D0eBDJicr0/DVe5LJxw27emnbMfuAyrZqM+Qi4g4r1P5CF3Kdv8yAMyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574689; c=relaxed/simple;
	bh=Dn6kprdecpTUxGqwDMYcg8A0ejBALzUE1/ER6YNvJuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tpr1QYICXHRh9NWcHw0KOrg6VmjaSMp3AkLsO2AghDJXCekS9kZH06ICmB7JIAYy9YTaK+e4ELCkE+ZKu59jt+lJ5UikqTs0zo0y+e+JVF/e/hIyASo8lpRryO1f4zzsAgCBGevb58d5oiz5B9bQcQggcCbkxyYIX8r4WGKJk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAHs/7Y0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso21128695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574685; x=1762179485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OWeVQ4AtgfB93bgZfN+1XmqssXEaSbhn0NZTenNXkU=;
        b=EAHs/7Y0W95u/xuMGDP5awgUUSigL4xdhvGtWOJq2PBc6tOdaUHNfRO1iCqKNIuEKH
         jBt3F1C9qFbyasiK94+aM+DMFQxHV+JeMVPkPST+MYHLEUZK94N2ZOntiMjBHbi/HvJo
         3pRTkdeQbk0se1BLUhKKFHOTBtf1cBa5LMDfQmAF47CPc4gein+Z1iy20yqoYh65N8GT
         YdZa9baC/YBMD+hj89ffnxU7vl/SPSF+8fNKeaMrlY+vlMKCWecoCjz7IJNNHg9tWCO6
         6GUzO4FkpmnB7d3y+dhQXesci45jlprdmlH3jnSftAAAdRolWW/SrO563FS35NYwmvca
         mpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574685; x=1762179485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OWeVQ4AtgfB93bgZfN+1XmqssXEaSbhn0NZTenNXkU=;
        b=SZYEQbojZ6spUZ6i4kZtLvv11XHtclymM7bgrJPY/qGEvbEW1EHIkNftCjYpDzH+Ol
         eaCNsgSKdbZYJL3/ynjspdovOEA98PvfCIHu3ipNESBphH3UzxNBqsY0dtkEHNrpNLBh
         S8FyKQOAhz2EcGbGZLBwXr19ohrSWDgvVF7fRPbNFE5RrGIR7kE/6JFjsHJeUs25Dw5V
         VOR0A7I7gczzB9O5XqD+oJk+GT/sInBG0gBMpURGMyuc4X1WlOYxrT9CVyvL9FfYiRsG
         TA2lafjcG03pnVHuMcxMB9ygQX8KHWD8bEaBn88TZGtwQ+4xCUflaLVDxInoUdcek/Ox
         eIag==
X-Forwarded-Encrypted: i=1; AJvYcCWIVw4BTq6LtxtYu1HXfiMoe2TEx72w2GKKXvgsOXTst0MEDGrorXjAsjHDvWn7BqCutkJPRBAZ4Gt4GR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BylA7nvJwzCsvgQ5MkZcMK7IrGQLMMBDMXDTSOyeguQqEouu
	lR5jq0VlzHYcsE/XXef69WfO8PLMgwLRGNao/trMnltJoP3l7BXbgB/M
X-Gm-Gg: ASbGncswXDa6Z/d77hbvxj9GWCe4BWE7zTEvUHnS3bc6uQXwmsSSM7qH2Y6F4i5jJLI
	ZFk8CLID21znQwWcyEOSpO6BaEdF8kONu+4IDFxy8vGAuFv/kXEQ8Fxws9BEbX1v9JjccgNrTTh
	/MFmY5ewD4ly77MrtoVRQyu0+T65jvQ6Zr/r6BK6MAuki7uN6/4G1jzNv2XG/QyGhnDt67WzPTG
	G/NRcGbcHPBi02Bn4wLLeZsyNk53bWMHYXKImf9skXGwDjfYozGLzelJJ0+TzFj1+0ru8j9LEt4
	bMLxbq9DDkHQeirsyf0tzsCBEch3J2mpYopkVYy4g7QT3KzuWFU1K8hqZmQHu+C+cj6U3l4EuAy
	X9uyVWliaT2BVFYiujf8kT1EDaN1pMJzufv7VnQKQtKCN/8QsBTM1q27V8+Situ4eXtDxj2nN5l
	63HYz2cIzP3BMq0jGsXsWMV1PajIdERg1jleYFY9XXzhQ2aCjB+z3w
X-Google-Smtp-Source: AGHT+IHOC4zgG6OF1kjm4g+wN+sLLGwPrLU1lwZ+ztIlqe61AFOMk+PmnLjf3OTwF1E1sL0nyHsaLg==
X-Received: by 2002:a05:600c:5493:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-475e067f43fmr57939265e9.25.1761574684773;
        Mon, 27 Oct 2025 07:18:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbe5587sm168380565e9.0.2025.10.27.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:18:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:18:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251027141802.61dbfbb2@pumpkin>
In-Reply-To: <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
References: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
	<20251005181803.0ba6aee4@pumpkin>
	<aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
	<CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
	<20251007192327.57f00588@pumpkin>
	<aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
	<20251010105138.0356ad75@pumpkin>
	<aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
	<20251014091420.173dfc9c@pumpkin>
	<aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 21:12:00 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

...
> Hi David,
>=20
> I noticed your suggested approach:
> val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> Per the C11 draft, this can lead to undefined behavior.
> "If E1 has a signed type and nonnegative value, and E1 =C3=97 2^E2 is
> representable in the result type, then that is the resulting value;
> otherwise, the behavior is undefined."
> Therefore, left-shifting a negative signed value is undefined behavior.

Don't worry about that, there are all sorts of places in the kernel
where shifts of negative values are technically undefined.

They are undefined because you get different values for 1's compliment
and 'sign overpunch' signed integers.
Even for 2's compliment C doesn't require a 'sign bit replicating'
right shift.
(And I suspect both gcc and clang only support 2's compliment.)

I don't think even clang is stupid enough to silently not emit any
instructions for shifts of negative values.
It is another place where it should be 'implementation defined' rather
than 'undefined' behaviour.

> Perhaps we could change the code as shown below. What do you think?

If you are really worried, change the '<< n' to '* (1 << n)' which
obfuscates the code.
The compiler will convert it straight back to a simple shift.

I bet that if you look hard enough even 'a | b' is undefined if
either is negative.

	David



	David

