Return-Path: <linux-kernel+bounces-839578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEFBB1F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022F919C3E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4604280A5F;
	Wed,  1 Oct 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2JHhPxn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65326F2BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356738; cv=none; b=PhAreAuVQZJIZPNNOA88XpyhiWTxC4Ap71ahEPSoK3kutL+cARwAdQdDJkTo7c43xomFD75oikI5GF8DawnrA2unqzBnZoboHhq5ygA66OPAzff0Ti4Zw8xoEdqVidTf8eDEvhU5snxl4M6Hz7Uh9orgUoTWWp5SLrsGNxrCRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356738; c=relaxed/simple;
	bh=WrzVffmDsNjJiCDEF5KAcYVwh280/AsFYAlQDRppDys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrbrDbU0wqaANlom2Ud8NuG2O0MxAkH7Efbb8bzBKn8U8zfwXo3xs+OpCawTRRoDfTm2ea2fSpFZR2ghBZLEZMtjQ5ntL0AbhZkoQwqWO+k/Y4+wpasI6eobsP5ncr04buabe361xpXo9lsRxZQVehKpofZnrKk2GiPIZpeiQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2JHhPxn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so561071a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759356735; x=1759961535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+4M0gfdv2LO5VIxrtcNUP3+z5CTBxfNX3uE59t+KH/Q=;
        b=E2JHhPxnJpd+a77zfUhETE5kZshbTFWXz0rprsVqs05eBnEVCMOPs4d65N4xLsqaSo
         A6jjtvImaahNhBbaEFcXsBAYEJQL+5f6Gk9SVUOmRcssL3Vyh3rU3d6UYLqorFDZaDl5
         Vfcs1rSVQwnCRVHYEGanh8EKdMmLB9PwuS7HgDZn6+fFyjnvMvRmqS+rltu+bF1w+q9h
         mhttBwgbwMPneWYvCEUiQRvAr5EP/aYzKPDw9SeXrwDgmXU1Zzc7GS8eCENkM+c51KaA
         /42+fBEYjB8fJYZ7F/j+xBFhFAH8yXtxS4tUjVGkytDQsCz6tstKf4Z4TIB625qG1JcN
         dOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356735; x=1759961535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4M0gfdv2LO5VIxrtcNUP3+z5CTBxfNX3uE59t+KH/Q=;
        b=a1Ykn3cOK7aUlHmhLFDx0i5lrIkW6kS+tDlKLM3+0i5S5jDPC2LtkeIcGjJihCnaUf
         RAhR3DZXZH8/lKuRez9Hkk1DMcwzOal7ocI/Wkti4uZf1XxXQuGRDY70CP9RmT0LO6hX
         mE6Xa0/wWwknVFjnlrf8LTBqLguTHrQV5SNTOtbq/ZAhL5yGCpsx7YfZ4wgX0QDCfp+E
         3GA1mcA9gc6QyakH4sonMVY2Yy+NwXeGOT0VSXyOr+pzCa7u0gdgSCr7oQmz1TSk665A
         crzt2JzQiTTlJGUlPXQKaKj9DiQaoxx777cZnwxMjRMA0thDAgoLPZkrZ+da2iwVMuuY
         2ATA==
X-Forwarded-Encrypted: i=1; AJvYcCUBo27QyV+xyaGfPYzWCeN29We6+Rki0lLS3BZ9Ja+hyC9mk0sZv74sQp730ZzhKlsKVR4GSj+OdGDzocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF+kqgfsvdzT/xSirpg058bY4HDkdjisufUC7Gktlh9ZlEAzL
	7/Yvx2ksVIpjJsbT/dAPkEAscOH89ybgsuJ8Ie8mxTPMKFxWWf8RB3ZWrUWNUYEFbnUa0mk5JSt
	ooDd2fGegjWXSiBoDVxRh6KNcMlXy+/drIJK6
X-Gm-Gg: ASbGncvCGUg5ouTkF3F2eCXwqEphKfJCOX8hVO/felalC+NJH1TMyXqwILc4W5BblnW
	FMrB3Kr/0DUBtIbPQSXzeSJ0C2h+D8ZuAtdaelWm9d5OkzTFQYVUbiACAsEpYoHKqTRGwN86+ol
	K9vGV2q2uMC8LUZe2IOIuWAinSl4pr+GB1JzvvE3yy0J5pwM5c9XMwYmHe5AUMFl/DYfpSHqstl
	DSCi1NaVX9cbMsqLB2wo8v620NgexeiHy+LM4XXz7c=
X-Google-Smtp-Source: AGHT+IGRyaQeOqp1+iTUh7IToyq/JkqeZjebvRFOS8YTTLCI2P+NJylcPhZZZvabKFfY8JxGMtgbEptWC4JSVeRb6NE=
X-Received: by 2002:a05:6402:13ce:b0:634:5381:5301 with SMTP id
 4fb4d7f45d1cf-63678bce51emr5793018a12.3.1759356734605; Wed, 01 Oct 2025
 15:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
 <b6a724419773598d75ace5629bf4b05726d45218.1759347737.git.sam@gentoo.org>
In-Reply-To: <b6a724419773598d75ace5629bf4b05726d45218.1759347737.git.sam@gentoo.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 2 Oct 2025 00:12:03 +0200
X-Gm-Features: AS18NWA38cHrRQFrTLOvXPxXoKh4oNZB8UDWgPCymue5VOHaQKIi0-RE2TAvrCk
Message-ID: <CA+=Fv5R=Gtt2BQqRRQz2tntW4nqTB3d-wb9R-0GjHnm-uXgA6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] alpha: don't reference obsolete termio struct for
 TC* constants
To: Sam James <sam@gentoo.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Stian Halseth <stian@itx.no>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +#define TCGETA          0x5405
> +#define TCSETA          0x5406
> +#define TCSETAW         0x5407
> +#define TCSETAF         0x5408

Hi,

A similar patch aimed for powerpc (commit ab10727) had the following
definitions:

#define TCGETA    0x40147417
#define TCSETA    0x80147418
#define TCSETAW 0x80147419
#define TCSETAF  0x8014741c

On Alpha, if I do something like printf("TCGETA = 0x%08x\n", TCGETA);
I get TCGETA = 0x40127417, but on an intel/x64 I get 0x5405.
Is this something we need to consider here?

Regards

Magnus

