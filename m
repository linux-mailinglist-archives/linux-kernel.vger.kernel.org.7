Return-Path: <linux-kernel+bounces-842150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC16BB916D
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4B4E427B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B22264CB;
	Sat,  4 Oct 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ILaHIF8L"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C42C9D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759607605; cv=none; b=eHGHMDA1XbJWJ08oeopY6+xfX+yDniUDYrbEIlxDWp8IWRFhra5vAuGqDRbZWMtzzuNw5trUOPx7rAJYtyB9LOWwRxJnPy/gVgZc9QaWdB4Okf/r2P4JZdH+AkZpyUtMY8umD4nJBMWVOkSEwnSvMEYcFCQdsAjjz55JGTZxQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759607605; c=relaxed/simple;
	bh=cXxv9oygkgnXgXW7rGttTdR/kUrSYqtw/DdaORWAxBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9bqPg+JTs6f1XG+0gTQDTMWQvzKYgjFmKYh/l341AfjHsOdjF+cU+bpJbLl7MHqcO4S/yN+yDDw/yO9OTP0pUOISm7TO+J6tKqYwnSKY9dL48txy/9AVFeDH2cMtPXG8/AFxZO4b/lYrhz3GjHT+CKVyEQ5zr/UMh6Guh8wVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ILaHIF8L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698384978dso25079545ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759607603; x=1760212403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXxv9oygkgnXgXW7rGttTdR/kUrSYqtw/DdaORWAxBA=;
        b=ILaHIF8L5v1HV3JqQ8YNatrFU6Y0KTly6nnqHNmhc53NyhoFP4E1O64wTlNwOhhlgU
         QH3CSb1aIV3vigcXP3cBEdt/yXVkIAFHyL8aC9UviwHIv+sa8m/zPzizmTqoxV9+T4U+
         rsRP4FUwG3FfcqorWjG+YtD6FZ9Eg4q7RrkacyAcjzhnrRe0v8DiYuXFWChHrW8AgRRb
         Eiz0MZf0C53rejWTQl3JisbxHdDFKtCay7eqhfTTQmHfvVlq8OLGyu6/y0M6V+SqlLv9
         esKZWYgUU3iLwoHHTkRuqVEnxWhOFmHAHFORpE/v75ww7NUmjPk5f1azao6EOi59GpKz
         ALpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759607603; x=1760212403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXxv9oygkgnXgXW7rGttTdR/kUrSYqtw/DdaORWAxBA=;
        b=ChywL56hWm6rPy7xAfqtXIYEyRnVdaecGlwMLUrOCDkFJVnOYEswtEJHIGUyZ5pqYl
         LXAdO9l18TkabjePgUuaawpU0dS093823Dw3/rIS9seJsxr41pjt6ubqAPfdVsg48dyE
         7Or3rT48h47wQpb0YIEo9ihH1erR2CoBNvMT6SfHmLlF6b1+2eX1YsDB2WubqVuxbqmD
         ibcVUjJ+aiM9MLAIxjoBK8+S1ZquyZy9cjqT9phWfPjYX5g9HG3j1411jMYXDoqIosXY
         Ar1S5YOfISPqMRSlOkXokjsOnODTej57APJEdZhLdKv1QOMMZQkoI8eu+/h1F38Yn+oq
         /wXw==
X-Forwarded-Encrypted: i=1; AJvYcCU2GNCwmu3bSz2ONhpgAwkwZcT+I8sEQDDiLaXCNufbesz2nzaXDJ/85DQvbAkqI+3BAxvLm1w1Crq8eZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhMEhUFAUBTOt0XcZ6dwZQ7M2ehpvdfS6GG+dknJQj1ekycro
	6OVX9fDYcCLtGKwLSeL+t72mwgjnYSvQYSsuykUuIDRKEg/r5axdydmYIBvfKZSg4dhV/qxz1ia
	KNCtRtxdbAmWRlrjcbQfme0S4md8If8V/GqUf
X-Gm-Gg: ASbGncs12iLoyGz+wrz11VOPjIIlhztLCIVKq4M8waJhmlwqN+JobTJAC4cePcYHIOl
	cKakKZkYZl/Zzft7koJLD8Kww1SkpR1jW3F269RcYFx3wpQa8qLm0YFOGDp43kTYq3W6nCmCDgg
	TyLRFgQ6JAG7DfP8iT8lsAcWxxnn4HKSEPH09/bctOVjzEWsA90nqpI8FZIhSj0uvqF91rIFjji
	Jv3DKNk4cqc8Wdugnu2EAQZ1+sQVv+Vu3WoN5c2QWdleVaAvYkPPGhdQuLFGtdk
X-Google-Smtp-Source: AGHT+IE5WgEya5mbDL6IucjMhYo+1sNVBm78MZ2ZLWglN0SEnlGhH8rggjUfNn3xPuefRUpxWKZ10+Hdl0ki7DqgsLE=
X-Received: by 2002:a17:902:e5d0:b0:282:2c52:5094 with SMTP id
 d9443c01a7336-28e9a61abb2mr80433455ad.37.1759607603021; Sat, 04 Oct 2025
 12:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926142454.5929-1-johan@kernel.org> <20250926142454.5929-3-johan@kernel.org>
In-Reply-To: <20250926142454.5929-3-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 21:53:12 +0200
X-Gm-Features: AS18NWD95pzK_qqo061ps6RQQpKquYvXdH89bYJG2uaPEGWKLOIyqhi5Q8ZyggE
Message-ID: <CAFBinCAbHR3g5QGdjDjJisdC0y4gPJJA2it9-qt016T4BigGzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: amlogic: canvas: simplify lookup error handling
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:25=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Simplify the canvas lookup error handling by dropping the OF node
> reference sooner.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

