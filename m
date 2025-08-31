Return-Path: <linux-kernel+bounces-793467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F183FB3D3E8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762D53B1459
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2A2153EA;
	Sun, 31 Aug 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="n3Vlqj1l"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259B19DF4A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756650337; cv=none; b=QNnKgSzOBPsBbpy0sFuQo9BpzQbVP4t/iMM4BLIjge+R5s+f7fKIVf4Az7SUBBs9Fax2MkgFLh94pcrYmfAtB14P36Hn3idf7wzZfY3Hh7Z8uq1EK5Cad3A0FnIs8yVgGMLxTIpRnFUVJ+khsAyVCNqxPGjsVmTI+d3a7lOD3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756650337; c=relaxed/simple;
	bh=tia0mrGZ7h1NCfPvef4VGNKt1YRomP862h78mFARS1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwPL22Hd71Xz/G/0UhYHV7wdCTfANCBwtsxdxd0Z69Ox8sty4PpfulIL5BwkCr0JUsr18xYn3CkQXWvL/lHTsbL+xRebR87BayYm9ZcK/M1wn1w3UtLff3SK/bS/+gIc8vT6m4q8hfNKtN8Fq0jpnmCWkajVl3n9EC014QkFn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=n3Vlqj1l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77238a3101fso950878b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756650335; x=1757255135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tia0mrGZ7h1NCfPvef4VGNKt1YRomP862h78mFARS1M=;
        b=n3Vlqj1lBNW1z86PHYxUgo0EUmRALAbbQvB013upW56oRHvEExo8MK0m8zlgrE5TVh
         BCmszlWKxfCSFnJWuIZQyeIUBQLYRqqYUE9JSgF9oJW/S/4Qluc0vMxLihHyD+dS0+b/
         ynLdXOpC0F7euJoUBpsxv+MO28rk/LKkYrPWtoijomNhkz1idOXR8Jrn4hQ6D8bBCSbC
         WZr+c7G6oy3TGmlYwyEZTCmzVgKFajjPjvpWkSH22Cniu+xPelwoMsHiA41VI+0BURY+
         ocg659AUe8OZgBWuCV6fqFchjEf9BhbXGOHMEkoFxrEjPd+alwT2AAKws0IES5ENXb86
         TG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756650335; x=1757255135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tia0mrGZ7h1NCfPvef4VGNKt1YRomP862h78mFARS1M=;
        b=wlHijzxCY4F0KZMCSnEhrMKUosL8qtXAeRHYrXnAdb5WExCnPeuppdig3DaHeNiNJH
         Ar7zlfL/IKxUTyrdmdikWfp5SSAq+bcQNd20KaS8DKnGta5J80TX8xFjMV8sN7iDRibg
         a/t3bDeiFQrSmZ42l/lcElpdlW/djFi/b8a5ea7JZR58Ds49x4qKJ2xyQtdV0FKx2Mgg
         CzpmyJbAxwmTkvRaIQVeY2bQVeyvPz/9dMPV5kI9S3v6tZnM0ALAJ8jMF1KWE++a9UhD
         XYwx8V14Z1/nfQliboIZxzWrB6nb9BV/xEdgUTezT3vo31BIrtYyGs8DBM76c2SYBBkt
         9c+w==
X-Forwarded-Encrypted: i=1; AJvYcCVn5IGZW6t7G927EptOcjaWdV/5mOJDLG5OCkKtkiSQAlryQZ+U43lVVx84mqv7X/ZqbRwBTuEhHKW0hjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3EIj0TlR4dL3bxpcTYwN1vuyw7XggiaFLTbPgKQYKKqejA8Nf
	AsexHvz+5WjjfZuDOa/hFJcTOzqLJMnL0g8d01mgGY7AJTNMfakcfbHH9CMGckG5KDmS1rdNrCq
	vkEUSR5U=
X-Gm-Gg: ASbGncvAAcLNifkpgYV6CJgMncAt79lpuLugPlMCdJb48UJcs8BYDUjFgRRdWdagQNf
	VR9xPvha5z4ebrZNotOGnEKcbierIq3nguis7ZASRTTprBwvLhr1W7KSM2o7kA/BuxYhYX4qWvl
	16RnSphXhAVv7sCtO8NDWWqGjKbFRsr/iz5EaHx1ze4NvQCv/Peg2DHO+VoQW6elfUnlayyZv8Y
	8NDpg/UA993DbE3dbGD2N06Q872mlCkDtkJCYQXkWvtug2olh/iQwWZ462nn3rFqCTTimVJFdxz
	eXfa5eyUaljcN0Xpvyr90iyCcuhgQLNYD2b1M1ONMii6n+zkEAo/GZeYlEFQuP6NlSmv1mn+1Mv
	NAsAP0ZRWYGHX09kyqr3lYEU2c1d7lsykdmUaykJ3wByVEyE=
X-Google-Smtp-Source: AGHT+IEzLsF872AQW2WCrkafZsoPe6MW3OMi+DhNMIiv+MgumYXMxcJnQU1vk9tsPiaqMVbYQ3vByw==
X-Received: by 2002:a05:6a00:1945:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7723e33888bmr6988197b3a.18.1756650335482;
        Sun, 31 Aug 2025 07:25:35 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:c382:54ef:4bb4:90ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm7784647b3a.0.2025.08.31.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:25:35 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: linux@weissschuh.net
Cc: 409411716@gms.tku.edu.tw,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH] fscrypt: optimize fscrypt_base64url_encode() with block processing
Date: Sun, 31 Aug 2025 22:25:31 +0800
Message-Id: <20250831142531.16756-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <38753d95-8503-4b72-9590-cb129aa49a41@t-8ch.de>
References: <38753d95-8503-4b72-9590-cb129aa49a41@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

>On 2025-08-30 21:28:32+0800, Guan-Chun Wu wrote:
>> Previously, fscrypt_base64url_encode() processed input one byte at a
>> time, using a bitstream, accumulating bits and emitting characters when
>> 6 bits were available. This was correct but added extra computation.
>
>Can't the custom base64 implementations in fs/ not pass a custom table
>and padding to the generic algorithm in lib/? Then we only need to maintain
>this code once.
>
>
>Thomas

Thanks, that makes sense.

For v2, I’m considering extending the lib/base64 API to support a custom
encoding table and optional padding. That way, the fs/ code can just use
the generic implementation directly, and we only need to maintain the
logic in one place.

