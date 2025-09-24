Return-Path: <linux-kernel+bounces-831250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F7B9C2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0819B2E5170
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113C8F54;
	Wed, 24 Sep 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG/slZ7l"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DD23B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746830; cv=none; b=K5ByL9hFB7cVyIWxzXXMm+/948irWFNpj36p0mvXQI94V3s3Us5RxwkLR0yFZo/1xA3edWjqh6afQDNBobpVA9qfZce8hjMdakA5ZoCzjwXiNbpODD/fzEJL4ZEtGXAvQRwwkHYdw63FnX1muP8POtSfsVwkrP3ZymOgMQ0v9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746830; c=relaxed/simple;
	bh=/wubRCVudmsrBQ30JtUy96kLo/ANA1UJeqjl03QRQeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laYGF9S3CjWt3UHYNFr4ZhuJTMEkPd9JAM1Z5rCBwK5Td//55cfYQ1o95tV7uDvTpSfG9tt5ArGgrS4IdUUQEuLUIo4UOUL6iTsFUHgWz4p6/ApfS0tcHooZEvtagCz3FN6Hc40Xpdn6ML0B8R1P3yNK2WD2j8CgrCn1beaDxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG/slZ7l; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781001e3846so186873b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746828; x=1759351628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uz5b/SWGJp4PVPnMnGvykn1mjKR+ltxumCbS3PwzZAA=;
        b=iG/slZ7lkyXHk1VVZwD53ZP0ndSkryBkiAjhAYqWSIWQ0l+zBElACOmhDnryNF4Fmw
         a40vvoti9EbK0JRogbKVq/8OWprzajvRbxj5TufMjkltTcsV/6ySitiwViOgKcTIuoUr
         vx73XjTjxUYFuZVtVgTUoHcwmlWjtdbMT4CeHXNvGe3accqV5PbK9APlGFg6oegJZYRu
         sf4xoUwhLxw4bvzYHC5rr4+kQh9ojYelDt6RsVcdz9LgMBdDocAZnd+6hRlvZzB+VX5B
         YMPM1IJenBHowbGABA5EOBjDmCSDtxOi3Po7EE+iN/yTKQuB9eOYOS7gVBG6VoMW0eQQ
         pBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746828; x=1759351628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz5b/SWGJp4PVPnMnGvykn1mjKR+ltxumCbS3PwzZAA=;
        b=uKaq4GPRqVp4VG5IaEjhrOV5SW1NKaU3dm0HJyjsjthLXz6fLyE6iF/bntEcDub2jP
         aJt3VBNzqLBB/on2EnJu2+HsQbORgT9sXzvwk7WqvlZJKu2KftkSJqjijeUlvo4Rsr1Z
         OSOMvQTVaibwW32kPQM19beTVOnD3eIpxc0C+VSCr/wMu/sr6VZpRfwO19EbHjZ2B5OZ
         1WPFKMWSDKk14vj+YE1GGJjLwBJhWJkPE6AZMNIrSzLjK3990SX6n+L7S7GNNqsa6Dy9
         MYofdwREZRtMKAKMCehPxwr/sdWQr68TLEcvD24ttWpkBdAfNMh7NK6Y+uK3Cx6xrCZ3
         9HVA==
X-Forwarded-Encrypted: i=1; AJvYcCViN5LCFU5Cpk9sTEUF4/6e/cbMKm7I5orbpf1cnW58yzlX42IjCfo4/psYBZADF/XzZmQIij9siqD4Zu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyam5JLRMQkXU2asuJNKFBezmiJrNQTsfEGCdmZmw1V9wO6GGJx
	eOZNlAmg1DtPVlOkcrE0qrtP0++Qoygg+dUQnaGf99md7bDOuFq6AOP9
X-Gm-Gg: ASbGncsAZEbcUPmsPNqNRg993rz0pxl/dnE9XtENbHQr/n/fTlCoVQPR3HUGcgcb4lt
	B9S8xJqUUAqMwpcwKx7oKObJCGc2mbZpsoy2W/Okjq9Fb4kHOEECUB0Y0NKcOkPfNW08/lGsjj9
	8J865SyCvII6MnzFSkvO8mgjdP9Jng3khwa2IMSqE5shFNQUieU5T0/XD2bx/yyF5Rrr1Wvz+ku
	qCvNuv2gjuaTu8uNXJ7gKhWTd6AAD9k+T9TT4IqejMIf8OeRRpVq1G86MboFLKMLofA+W4rnwwF
	tyb5VKIRRfw6yXsLAGfCwP4aNvDOBj0RzsE6O6lPS2i/uZX+dL/Ti55CeH33amY6qLdrGlgfZRC
	8cTQdd7kEBFgCy84boTk4XYGhGE1z5oOI4Q==
X-Google-Smtp-Source: AGHT+IFhtij1snqb5YmNiUxxhLFAlPngjUoBWbojYxm4jaQCU68Yvkxe8ZDdSxWBPwsKHM5RwYoZgQ==
X-Received: by 2002:a05:6a20:6a27:b0:2df:37cb:6b7c with SMTP id adf61e73a8af0-2e7c42295fcmr1088119637.3.1758746828457;
        Wed, 24 Sep 2025 13:47:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm180456a12.0.2025.09.24.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:47:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:47:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: j.ne@posteo.net
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ps2-gpio - fix typo
Message-ID: <bcv4wihu47ala7jtv4daczh7olarwdbdbsfpoj4l5yk2dj6vrq@5axihop6vn6w>
References: <20250923-ps2-typo-v1-1-03d2468acc32@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-ps2-typo-v1-1-03d2468acc32@posteo.net>

On Tue, Sep 23, 2025 at 02:14:50AM +0200, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> "The data line must be sampled" makes much more sense than what was
> previously written, and given that "s" and "d" are neighbors on the
> QWERTY keybord, it was probably a typo.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Applied, thank you.

-- 
Dmitry

