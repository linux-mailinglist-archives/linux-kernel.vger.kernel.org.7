Return-Path: <linux-kernel+bounces-831990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A73B9E189
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29CC32806A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94727586C;
	Thu, 25 Sep 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoWxT3/o"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB602749C5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789599; cv=none; b=CMaz+K9IUD7FMQ7DeiE//JVTZAu9hBxXYkERZhiHhjS9DttlHFx+GrKpJGzww0YhCh3UPr7QWT3GpS/SMuYoGW4RZ+9hF3OEJYjtaC4vLXeiPFSnGnXtVyGYU9MjeVrEqT/PSG5HAxdGTDx/O+/Lf0L+HDnJwGgF0LG84Ubc4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789599; c=relaxed/simple;
	bh=AjT96+20GcsVWhgMNMhihCW2r6PfyLiHYLGy6V+/pog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD8KO/F3/eSJXKAxTRyt1PWJwZ6fFMMjP1a8LSAlDcqJ8JuvEclXoT3Y/htabU9SUhYg3Xgrrk74IDq0mdkw6789196ZkunMC3miElhf/jddI+Meauefptd7esXE8SdbWTdBFK8zJ/1AuPWCafvKRKeSUdhBh3/kpPOvk4GCthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoWxT3/o; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso6304051fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758789596; x=1759394396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjT96+20GcsVWhgMNMhihCW2r6PfyLiHYLGy6V+/pog=;
        b=BoWxT3/oFwCUH/Q7knf+WDyQFyQ/QVQ+1IVjXh6YqVZTFSCWkFi7lS22bEaivbz3Bn
         aMt6GzDDE68VEOIay2MB84pp4/Jq3+z8lhhZMBzgjeiiAEpZ5yj07Faul4wPHaB2bStc
         Uf0WQymzMCgPvRBfbxAPk7wjBbhRobdCKVcqd2UZKDP/YJgYvy8XENJW/cRfyGBtqbL+
         G0Sl6LiX8cBqcxByZu7Pi39diBHqNkc3mcU6BFakEiQDdZt6iYeLXQtFyuDWTQpIISMq
         98cC7aQZ2HY8kDS+AbGiNeET9WwGgpXY05wEKTLO5vay3fk9juDRS+E+v73NuVk+fkLx
         K/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789596; x=1759394396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjT96+20GcsVWhgMNMhihCW2r6PfyLiHYLGy6V+/pog=;
        b=O6MjgAh2FD/E5y3esDAmS+cMfWaBxNVtqyyhZjbkNt+mIC1+zk00KeR8oH9i1k96xu
         3tuMsq8eYYtN70E1TZHrMO8x/ZyR2Vp6sP6QWbSqu/k6P34Ck6wwLEmEAmh1OHWr6mg3
         qB6bm44f3+Q4oPHf77PrzY0nfAzrk+I+e7xb+d6iZroeVNY0tucCR1+//9CxdvlS7klN
         UMJIsll6PFKnnbnPaxWBQuKxBuQCYlkBhrWZ3GKvDj4mDJ0E6eXCeIZRSw4/RjSZM5iI
         6JrAwrwW3Ivz4XRVddUHOUceBCm0LlqyE8h9eZtCxbBy1ez4Sd+nl8+nDWQBQ9uJfiFh
         sy2A==
X-Forwarded-Encrypted: i=1; AJvYcCWqBoXew1NYLTw6Fj4hOhSBp54EbKsbiw+CGybSsz5b4rnzx0QNlq/XQHoyHtfabFKtc5ep7VclFMWRTFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4ckzto7NX29XfXnNWld6P0+rCAsnamOG80VoU7ax67fyU/oc
	I7yKUOkdZ99WZoZnPjdeqUxaa+batyTnVgXcxBcZuZjPU1GGlv0v2YNqX+A3o5tMgtsOukF5i98
	5z0G7SVr3rBBAZowxsLZQAvJEA1FRpfYRL6msT4pMSQ==
X-Gm-Gg: ASbGnctY8on4ZQvWS377pVIeH+Y//Nd052M39BcUN8pNL3LC0Jvm/PZX5y9y7K40WUw
	t4QRwmE8reZ9GXiResnfR9FnNy6X+SKO2k9wSoGeiv2J4UV7iZX26ivGDUWgfnypAJFK2b8CikZ
	tRftgwtKkFcoMxeKg3RafLy5N62vo3yYstYohMKfm4mC20+jriknYgmdxn2epmr7hpfqIDT5mxB
	M/XHbQ=
X-Google-Smtp-Source: AGHT+IG7SA7kgFu9YK7tZIfH8QWdRLzls5jm/uRCsfbrsbUOkigQRnLDF2PK/zyKGqmGwfzQFwz/hu5kVD7L9V0+lg0=
X-Received: by 2002:a05:651c:35c5:b0:351:10a7:c6ca with SMTP id
 38308e7fff4ca-36f7c8f016cmr7545081fa.7.1758789595775; Thu, 25 Sep 2025
 01:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924064905.276174-1-wei.liu@oss.qualcomm.com>
 <CACRpkdZ49_mo0AN78ri4WTt+V2gNdFOTgxzgfXw+3vd2rNNiJw@mail.gmail.com> <kdpj4yddikjg2cvd7pyzf55udaqrttlyhuwmupmhvrn4jxdjw4@q6pajmr5f3i4>
In-Reply-To: <kdpj4yddikjg2cvd7pyzf55udaqrttlyhuwmupmhvrn4jxdjw4@q6pajmr5f3i4>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Sep 2025 10:39:44 +0200
X-Gm-Features: AS18NWDiOOQNnkPc4afuLtbiStKw0PQnZtHavv8A6AJOThzvhSizooVuso5NT4o
Message-ID: <CACRpkdaPuZzibAkFpPLGBeW5UtRK+edebTQ2Ebdv5nKjws9zbA@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - fix misleading GPIO number
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei <wei.liu@oss.qualcomm.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gatien.chevallier@foss.st.com, 
	namcao@linutronix.de, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:07=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I see vsprintf() has %pC for printing clocks and %pg for block devices,
> maybe we could have %pGD or similar for GPIO descriptors?

I have no idea how that actually works, but I like this general idea!

Yours,
Linus Walleij

