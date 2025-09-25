Return-Path: <linux-kernel+bounces-832350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A16B9F0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48159321D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC652FC02B;
	Thu, 25 Sep 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4c47W8C"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314F25B67D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801410; cv=none; b=Ml48ZtQp+BlY0XqRfphmxcTlpi9nwcyOodu9QGSYnajRDBO4i4Lc6/ZiIhkXiexqdoStkMG56eMSNrUgBtQtf3nN1gsSNUw1k7eV3sNVLjSR6S+jm0AkK1manp2JRpQdB/IWuhIs7RImyXq1awlLha/3xjHOlXPEV57ZGhfcsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801410; c=relaxed/simple;
	bh=GJqh7hJapGBjQaVVqH90RWbwEo9sgfEH5QNd0R5I1Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLZdr4DYYjW5koYPTpLfzn8ZS5NxkxU3UpwrPcvgwciKXYtqcLKoasVo4TQoeQXcirhqnjXrkEmZrwRNpj8uMpS+gedBVecwrU9+o0TzLvBjgijGYmlyrExJz7cuaysJHDW8tL+Ki7hiT0MYaHp3iHqnSDLU91DrLrLEufqQris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4c47W8C; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-eb3835bb2bbso411524276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758801407; x=1759406207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJqh7hJapGBjQaVVqH90RWbwEo9sgfEH5QNd0R5I1Z4=;
        b=J4c47W8CzN19jRSCP1kROotg1gGJpctg+1Gn06so9yWuaDGu2d0rdaFyphGI7DoQNP
         uRl4O5wPLWlb1UGg8BmZE3+S+BlPM3BTWMg2KaTeeG9ne9BhOysKTMnTpqrU4P+YQLyU
         sKOjr53gE6HehkJl/ZY457Q8XdDdtgrrDXMqDZ6NS2c44Nz1n71jasEZvS9D8xd4hEhY
         8UurttWVQ9Z17zYTJ9yG8tZy6Py0iYfbL6uXo3R5xky+fKAnYFoWISfe18D86VJzux90
         faSE1Fy1YBXxK6VjTbrjQXLM5Wv4kf5Snd3/B61HFiAFp14QdckYOIJogMPDYUXOk8AU
         1h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801407; x=1759406207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJqh7hJapGBjQaVVqH90RWbwEo9sgfEH5QNd0R5I1Z4=;
        b=Cuc5YyUi+7SSUP0stvs/ByIUDNwM4b87YZeRMfOZp72QqFxNKNqmN9Z36Q3Dr57iMA
         3GuWFY15wKkRd6p5Yy+KkAFSuaulh6r0Kus9HqvHALEygeu1sFRFfIH2jBmEDyAgv1UN
         crKgaF8h8zip2ypgmd5sozsR17kqFZbGWEemNCL0jrSLfHZOYcyWeico6gJNufwAc9Cl
         EZUvUTk3cA7wLGa6fhTPWv6fnjBnDpyr53q9i31BtKwYX7naLYUnzOTbTnACatu99Y7H
         WFln9TndYz83i/me/yanFv3Y/djXX7GDddon35DTy+Eh17EyCIm2yjx0nk75DQawUHpu
         tkXw==
X-Forwarded-Encrypted: i=1; AJvYcCUpoA3OptdPG8lYc22J9slSdZI0W6FY2Flc6nsE7JZNTYiWITPsIAveL7M2koxdeJ29qvWxEFB7/+ANp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7YNuxTTEn+iJoT5f73741SLZ4/QPjzhUuV6wQYCsyZ205Ya3
	VFVij5weMrPXIJWGze8SgQJdxJHoIKdS5uUatsm/MKsglvP3hQTSywfHFXNI5o0GRkIqgI4kG7+
	dPWObr9OYwANcf3VPS18U6aEJwg0N0FA=
X-Gm-Gg: ASbGncu+seFTyX5p125H0wKgFF6hKBAw8cDNdip//JxoxdK16c7Z0+Hx539E/nxdfk1
	tyOOukb2gDOBMjCtDtyzFQNIjJPCq/sLfvCM81hsJfuSqwG01d5eSA9rHgZYT+hxRfhgAmsmnIp
	vqNpuBDgH9XkQiY68C6fJFsfjdDskC3iuVjHYbLOqwvS9DmQZPhQxiDW/cw1s/SUOci2Qtvbdb2
	CF2FW5XjanLEYk+9+4=
X-Google-Smtp-Source: AGHT+IEplHgtgh30Y5yODVkCJBqFWZlXiCiCnMqESCH3VBptjDoczSPmQ6R3E/qNth8EPp0gEWOe5B85dha6Ng7giHk=
X-Received: by 2002:a05:690c:6087:b0:721:10a3:6584 with SMTP id
 00721157ae682-763f7ce0a9cmr27606027b3.11.1758801407524; Thu, 25 Sep 2025
 04:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907114557.15453-1-chiru.cezar.89@gmail.com>
 <20250917133524.85063-1-chiru.cezar.89@gmail.com> <20250917133524.85063-2-chiru.cezar.89@gmail.com>
 <aNUa-9HcQzyjZkvE@shikoro>
In-Reply-To: <aNUa-9HcQzyjZkvE@shikoro>
From: Cezar Chiru <chiru.cezar.89@gmail.com>
Date: Thu, 25 Sep 2025 14:56:57 +0300
X-Gm-Features: AS18NWBcWGXPf8-vty6zQqZyFzkeQoggcj9f0bDrT04xHEPfn-LMcx_PIT8Wmxg
Message-ID: <CANvS2vUHZ4zVLwhPyr6oPkAXuVcd3zn+8narVzMuoUoP+uxZDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] i2c: pcf8584: Fix debug macros defines of if statements
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

> > -#define DEB2(x) if (i2c_debug >= 2) x
> > -#define DEB3(x) if (i2c_debug >= 3) x /* print several statistical values */
> > -#define DEBPROTO(x) if (i2c_debug >= 9) x;
>
> Given that nobody updated the code in the last 16 years, I think it is
> safe to simply remove these debug macros. Are you open to do that?

I can do the removal of debug macros. Also for the other changes you
requested I will submit new patches with changes requested soon.
Expect my work by start of next week.

/Cezar Chiru

