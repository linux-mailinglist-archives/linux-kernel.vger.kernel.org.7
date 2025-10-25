Return-Path: <linux-kernel+bounces-869796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2DC08C28
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116D53BB026
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC12D7810;
	Sat, 25 Oct 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNzcWh2b"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314272D641C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373447; cv=none; b=TCc2EklA9C+WNIraSD9jqXNsJwiH75Mn7F2Pj6JD2DB8okCqoCYH5HQtEBg8ACUwSw0CrWGIO0m01kRAeEf8OjF1GNpqV7vh8j7FlR9+94h227bqu0UgPPCdf3wqEG1TIAmVOVu5bzhuv11C5nwecERBYvz1yYWjn5ycIz+PnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373447; c=relaxed/simple;
	bh=FMw0+LtxF1XFnxeM6wfrdoWVKBhlpw1rYFoS6IMYePo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opVdpbL4awnJgHlqxGju82n0vhZxeuY/J7IeOvB0QKxK5WPCACyNahX4iNpYOocYruB+Osv6VANtPTJLsV2Y1rHSpWxwfJT4X9a2ZS0DUuX58lT0pyKFVz+0REZ+VGo+/xm3KgZIfHoMSkpkTX0CfVyDcryvMHUk1l0Sp82Tx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNzcWh2b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290ab379d48so26907355ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761373445; x=1761978245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uyn+lqnfj+DF2Mnswe7yP+PmxmYmbtnyxPSWDdj2IYQ=;
        b=XNzcWh2bsHRhXIg5xNeAIKsJqhwchKF8+WPtWD5qzgB821m367N5VOXqOYeVdByUsT
         f21ry8atQ2Z/BMPzisV1yEM5pma5LujBytxUM1X1Nnvn2NWepzUUnP/X6YCAiZ4viYa7
         4ou9prwSwJLccbf3JmbYhKaGuEgiKeW45whAy1pSpbtXjxRnXMnxOzuk/QH7rwypRupH
         tqp2FvRl7v5fP1cmXi+Zt6EzSsTmSRAzSgkP9HZ7mNjHQ0fm0W8e9dl07UdmM6LF5r19
         ld+/wDwtZDehK7hQPL6Ig6kulgA5qKcZUUk2Q8+7Gmzweh0qV+7xgz8/NX//HwwKaHq8
         H3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761373445; x=1761978245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uyn+lqnfj+DF2Mnswe7yP+PmxmYmbtnyxPSWDdj2IYQ=;
        b=cuNh4ADG1Lc7RmhfJ4XZ9PhCTO05Z361o++nP10fwzVO/uFD1LlFYDqh1hGtRmTa8H
         rZfnb+5RnWHM5tN29PsXLovCcHa918mCEtQGehy4SR37tI1tw3goiB2FDAmEstYsXAOn
         VtArCWt6MyHGZSws+1pv7rClaugtxCe8zBnLHmb62fQSlMlLcn9sqJZEBeSPgV+Nkp2e
         qYRHNDpA6qgC5zU8vlNlMd6n0oDrmjlfPEiBz84fbTJh2jgo/i1cyFdGlBnMjjL1RNh5
         DoQC3k7TFrtEpGfu5EVM//sIYjj8ezeNIQCFm8+aZm468z8ttRqFYF6CB6r9UHg7D53X
         NoPA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rqHQG892e4GfjlknXG0NdWG3jDlqHiWKgXw7IxNHl7VQeXdr61BNRyeO32Y/dBOJs5BBlts+6OHKjiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lLzsebNBP6ClQ5YjQUrYpYXULsYBtUVqeiuOrJx3dnLaql5M
	QdP9Tre7VboeM3zauyMw/8c92Mj94p3CFaKVBo2nBDm4NbnWXt+0I5tV
X-Gm-Gg: ASbGncslW6gVAahGTePy3naj0KdjAsNjI0fj0NlBtCrCvOukKKH8Ax41llfqMrp3JSe
	CCWPDHV1UNFRiSBbdqOmSnE6Q9X/A7doOx+GZALU14UoRuic36S0HNWDGeo6dyOjOKwQcV/udsq
	pxrVW3tVXgcPLH7n862a4O/gqTu1v9Dki5ZhsiMdrfdXleSmXae1/407HMIYd5NEHTiHW00qhV5
	yOi5hKsA4R9fYW35rhzMv3G6NVdwNG8a2GNlxkNHugLIIx2gX+lXi3ffyVVv2xMlPbO3iTjaws5
	84s1faoz8v7G4/3G1wFWZ4Qvpc30u/L+rRmPUyKNk6ViVd0BO6w/LmbUamJRtlDIR5oGviBw7ZJ
	YbikmntkUaeTnAVzb848MTEO4uTxExco+S5Xp+JIfY6C5qfacmfddTHpW97CaXpfU7spYclbnc0
	92XoWvbNr4oPLmVnDu9IsztyfIV98c/lSyaMCkcFBX0zYUgHtmLw3nxbbF
X-Google-Smtp-Source: AGHT+IHplQPVfCIQoY8PHDd3B2J4jw0QISC8FZ6gWYBjJGGEKcAtDwmwgPaM4vZb11xkzDseTqP+IA==
X-Received: by 2002:a17:903:249:b0:25c:8005:3efb with SMTP id d9443c01a7336-290cba423a6mr366592795ad.54.1761373445251;
        Fri, 24 Oct 2025 23:24:05 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:443:a828:b6ba:688d? ([2401:4900:88f6:d7b0:443:a828:b6ba:688d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm12204175ad.101.2025.10.24.23.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:24:03 -0700 (PDT)
Message-ID: <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: ally heev <allyheev@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet	
 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 workflows@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Hunter	 <david.hunter.linux@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,  Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm	
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 11:53:56 +0530
In-Reply-To: <aPvAm1E7CvQfOIuS@stanley.mountain>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
	 <aPvAm1E7CvQfOIuS@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 21:08 +0300, Dan Carpenter wrote:
> On Fri, Oct 24, 2025 at 10:59:16PM +0530, Ally Heev wrote:
> > pointers with __free attribute initialized to NULL
> > pose potential cleanup issues [1] when a function uses
> > interdependent variables with cleanup attributes
> >=20
> > Link: https://docs.kernel.org/core-api/cleanup.html [1]
> > Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl=
4.notmuch/
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
>=20
> I don't think this patch is a good idea...  There are two issues to
> consider 1) The absolute number over warnings.  500+ is too high.
> 2) The ratio of bugs to false positives and we don't have any data on
> that but I bet it's low.  It needs to be at least 5%.  For anything
> lower than that, you're better off just reviewing code at random
> instead of looking through warnings.
>=20
> regards,
> dan carpenter

makes sense

General question about the process for my understanding:
Is checkpatch run on full tree by CI or someone and results reported
regularly ? My understanding was that we would run it only on patches
before submitting them Or we just run it on full tree before adding
new checks to understand if they are catching real issues

