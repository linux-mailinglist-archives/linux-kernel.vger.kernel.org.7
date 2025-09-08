Return-Path: <linux-kernel+bounces-805483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C5B48938
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B4C7AD1BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900122F0689;
	Mon,  8 Sep 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7heg0QG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086392EE61D;
	Mon,  8 Sep 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325306; cv=none; b=G4SmpiCezVgVZUjOcPA53lvMnF+PH61e5HOCU5LgpQfK4HlXG0n6F/+9b7r6S6wKFiIcWiw3ByqFFjhJoPJfzdlUOlA50pQVskwt7x7kPJmOxRtlZbV0HLMyYgOuBAJI+eDgQR4eOFDNY6OpCQdHSgcq2vsLMHb1/Q4C0pWp5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325306; c=relaxed/simple;
	bh=Cpf6u8mnULKW8NOv2lWmw4jXSP3ZZJGHV0cvbJrWCUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNyek8b9nkNCDkkMaycH3dp1A6ryBL2N2rXpV7Kn6hLjebgKj5L6yN4QUoMc4+ia4Vd39T7INQop1mpAxmwTEwqAYNKCsdXC/1IvQIQsxNKXSGgl6TVZamRdyowN0NdaZB+REAJts6+KFWZQNGMHorBLJBsozN1GjRvt22HLbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7heg0QG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de56a042dso5810315e9.3;
        Mon, 08 Sep 2025 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325302; x=1757930102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x1Hsp+dpJ5U2ObHkY3BT1x09SwgDYmCzeo6+eGU2wY=;
        b=m7heg0QGSUpn74VniRv2J8Ir8ZjEnLmZSpkzyF7xmuvq4kt014YcpNsYU1lOoT37f5
         3n/m0a1L53mssVLRI2L14VONKbnPPHwGgTGTqoWUr3jjU9CfzKU6Ss3O+2VsyfV6+HnO
         TukinHmmU5J0lPHwKj2tOuQ3/kU6Ynil+e7tM9Ybl0+eFC2Z2Qy9YuaoXvP18BoF9YWz
         SBgapLvs0qESAbrXyfgdaSxdEmQVyWTvbr4wMh4d2cc3e9OlTHiOzIJGQ5XnKC1EQNCD
         0J4odEgDihlz55KteL1IUo0OcNCkIqPn0LGN7py26IKI0flhSBsDL4WYLuytJOqTff0F
         mkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325302; x=1757930102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x1Hsp+dpJ5U2ObHkY3BT1x09SwgDYmCzeo6+eGU2wY=;
        b=iKLopVu5JkbgNi6fKYJokwQ3fEUkM1mt8DQo1gyTgeqFvxDqN5Xc3puC6xbvDmecgU
         KHxPM/1RpmQDh3WVZHCTRIWAvhL/d71EshH2JjCNeODXbRCif6NnFt03hOWW/GbniYKW
         UPG+UzBQqaVtfQFSiHjwortIebrPlWjuQTB+//7FQFUojeOL4f0yU6+yYd+QUM1fUVEE
         dmrOBQgAKDcwsQyEvNXf/YThQtMgCmIGRAUjupiEog1h1I//Vbzi+CU1pX0Eq8iXfenW
         gFuZmvpL/B9g5You9YTNIgxHfguXRXQpZp6m04QqmGF4Nd+otEY6IwmONUWKjDHwuzIv
         LnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGZOZzmIqRqbDNzL0yDeD2HwLI0yiET3ntgQWOEoxRAkqzr8mAQpctpPq/3JALNbB5zNMFb2OZpk=@vger.kernel.org, AJvYcCXhNJ+7zgfY8sOzJJdQvu/w5m0tcIjSEMphTAunUuV02e/8vADp7RDHoNei1UA+f7xyXe3JW/7NLtwMbDjo@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsrB0U/Pw6nzQcqmdFPUopGDICahQKUXEH4fK2FQsMJEJu4ag
	JwH3GVW+RDm+Vo8UZsKXqV7LT4DU29z3MjoJXkWsLFXLS5PqRxgRa8AY
X-Gm-Gg: ASbGncsCj3qeEu1pyHT+wDDdQ2mI/SjUVeThIE4ok1lTDFfXOA01mnZrFFgaos+ttZp
	LSxECdT0zeWbGyVPxE37urdGIYYnBN9AtZJei9nAEmfvI1ZbnUtWRyKwcaXex0qvvFrzxvuZuS/
	Nbgg0CX/4Me7Nyw9IpogglQp1XX93hNNicMZSRyzWc1ywyMjG/5nXRTkayrplKOYYSh/hjdJjUJ
	LX25hlrukEKEvz3ELPS8NXKY3UVaMw09pdKLOkcPxY88Acd+NqTB72apfaqG9VcKDQpDQJ2ARTU
	BLYhOlmFiK2BgLu1+unXSX9JyGIsy9m0bhbQRUpYeHXMHBLoOrk945BAjwHHFSXer85kjf3xQGJ
	zzzh5tnsoVWblraBL9YSOkBbFzchtmW5AdEs6Zr7BYLqfBEY=
X-Google-Smtp-Source: AGHT+IFpX5YvuO3ig+/s1rYDvV/s66K6rV4ZFk+aZNpl+OJbyIG/Pd9Xd6ssYqvc8Q1pL8RLNoEYkQ==
X-Received: by 2002:a05:600c:1c08:b0:45b:8600:2bd5 with SMTP id 5b1f17b1804b1-45dddea6002mr65196005e9.5.1757325301945;
        Mon, 08 Sep 2025 02:55:01 -0700 (PDT)
Received: from gmail.com ([147.161.145.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm27797095f8f.7.2025.09.08.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:55:01 -0700 (PDT)
From: hariconscious@gmail.com
To: corbet@lwn.net
Cc: catalin.marinas@arm.com,
	hariconscious@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	will@kernel.org
Subject: 
Date: Mon,  8 Sep 2025 15:24:50 +0530
Message-ID: <20250908095450.42929-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <871pp8a9ze.fsf@trenco.lwn.net>
References: <871pp8a9ze.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m mboxrd@z Thu Jan  1 00:00:00 1970
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286623770B;
	Mon, 18 Aug 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533304; cv=none; b=uzqxObiUW0V5/KwDbGE974y+FjJSI5MFNyebWi2+5q0TOrcLDMz7UaGA7zz0rM3Untp7AnczUbPlO0EA7ijp4VWjKvA/jRHEa1WGY2xCRbl7sgaCW2Jjds9q0+1gZLf0j/daCCEppHrPUjZ8YflPc2iu9lSvMSpKu47NIakpBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533304; c=relaxed/simple;
	bh=ou2NodSL61SjBBx3oNoEL8d9FXu/qhf54SYinlYpEpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgMDNRzIMf6C1EvsD5ClxxovJPOa43e4oQ6VSmdSN6I7NCnbnvwlTuhLwbC7PoGla8+5kqNNoHprCsJFKlmaUz88nO4IC+USEYcRtm/2Bcyxy5Vkovozj6Qt8dT+KI2+uNMueCPw97mRWW184W5bNT6MZmCp0bCVjUVZaMhgFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FS1soXLa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FS1soXLa"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5CE0F40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755533302; bh=PgKB2qnc/bRPAL5RwjdygVePDYnntw4ZWdIavREWLBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FS1soXLa521ujJUbl/402whSSESTHg9tMk1J4yJXD61Dfi279n3ZYdXUxCAqBrXbP
	 7uzuyvggLkYoXlerUj63roxK9vLzAUnVybiJ8ADgblvGi5LkC02Rne6uNwELG05I+6
	 k7OuwJQBxt+73WjptP+fON5qK+HI/wyJ2vePn9MgKDmwsi+JYLLCa/Ou+Yk0IU287M
	 3Bs39RXJcFhH8aA2anPFcTcN3lReE6Ci8Tc22FjnWBpnYKR6l1Y7r40THAF4d2OISs
	 tpNV3csYjY/jWhXXQNvQZbmv84TtmdKAC3lrG0p2OxW0RInDuM1q8EFkKH6kheFgli
	 bhQXe4L9M8KpA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5CE0F40AB4;
	Mon, 18 Aug 2025 16:08:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: hariconscious@gmail.com, shuah@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: HariKrishna <hariconscious@gmail.com>
Subject: Re: [PATCH] documentation/arm64 : kdump fixed typo errors
In-Reply-To: <20250816120731.24508-1-hariconscious@gmail.com>
References: <20250816120731.24508-1-hariconscious@gmail.com>
Date: Mon, 18 Aug 2025 10:08:21 -0600
Message-ID: <871pp8a9ze.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

hariconscious@gmail.com writes:

> From: HariKrishna <hariconscious@gmail.com>
>
> kdump.rst documentation typos corrected
>
> Signed-off-by: HariKrishna <hariconscious@gmail.com>
> ---
>  Documentation/arch/arm64/kdump.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
> index 56a89f45df28..d3195a93a066 100644
> --- a/Documentation/arch/arm64/kdump.rst
> +++ b/Documentation/arch/arm64/kdump.rst
> @@ -5,7 +5,7 @@ crashkernel memory reservation on arm64
>  Author: Baoquan He <bhe@redhat.com>
>  
>  Kdump mechanism is used to capture a corrupted kernel vmcore so that
> -it can be subsequently analyzed. In order to do this, a preliminarily
> +it can be subsequently analyzed. In order to do this, a preliminary
>  reserved memory is needed to pre-load the kdump kernel and boot such
>  kernel if corruption happens.

I don't think this is right.  While reserving judgment on
"preliminarily" as a word, the intended use is adverbial, so this change
does not make things better.  The better fix, perhaps, is to say
"previously" instead.

Should you choose to resubmit this, we'll need your real name in the
Signed-off-by tag, please.

Thanks,

jon

Hi Jon,

Good day.
Thanks for the suggestion, will correct and send the patch again.
And my real name is "HariKrishna" and see that it is mentioned in Signed-off-by tag.
Do I need to add surname as well ? Please let me know.

Thank you.
HariKrishna.


