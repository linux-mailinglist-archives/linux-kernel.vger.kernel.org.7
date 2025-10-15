Return-Path: <linux-kernel+bounces-853564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B805FBDBFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 440D84E5169
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300D2FA0ED;
	Wed, 15 Oct 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqrlZUQe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B7270568
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491996; cv=none; b=WPAAXR2/ifdKBxz+CLbmU6scubIhuqU2xp6RhyBmHxXnVF9SHOH7WFP4zTm3R/PckHl7QpHRXUjN8e0Kjid7lRWH5ZnaUc1hkCkZB//wDYk5MiJRoVlYIsbkWpaqRfo+10VC6HlfjiXcIWOG/Y0xX5RibzBX54mIa1PeoZ58e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491996; c=relaxed/simple;
	bh=6badzYk/nvV1acB3qT5JfVBXT+d6ShZ1CA6n3TANN74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntwXhAnmRRGNaQIeBaNcOQdu6ziiQiu+6NaEKRxQwlYYplb03xbvNuMeZ1sM7F5PZojtIdJbrNDwvnLg/2sYm1nHhWmXgJ1UI2Sos2yCuUen60QZgOhhnsSUPzErrf6fkHRDNrUd57TVxV5lIh6ZJsLIc1gNqQ7brKLI/bAq6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqrlZUQe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26983b5411aso41278035ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760491993; x=1761096793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=RqrlZUQehIfOhLtXDcrF4zHpE464kqdimoU8IDP4E0qhj2tBPPFRJLz63CPLQu1Kw8
         Vqr/11r62TZEwFvPc3AKoQUTiLlFEMYRjqbUUEfUgOQOIYEAHBGhOfcZ0tZkp2lzEeES
         ykLWornCkt7hBdEBSM1Kjv8DkemDhQJuOej0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491993; x=1761096793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=H9+lv4bqR6MIggtw0spRx24w9iv9/MmKa0fiTeTwIL5l4Zb3DK/ikDgfl8U6vbp0Dr
         KPUZvvAkPXQWzlTLCHJENyOVhb5uV1KZJRlm1IQhL6Fx0vMmNKnH8EIxCOllbQbcTyhe
         1RrzlCi7S2vr9xxBftVumj+59DZOMqOC4BYwMbgAckgynJUqjFrLfa7Ybfgomxb5ZPmu
         kBaHUoNMDxKwl8e31uUJAYBR4HBQGHCY09JqRiUyPGRPd0ojQpbk6LHTnOCfaxF3xnF6
         Bg9FW/nYZI5IahdG6EqjPrdUoceYo5fWbD82bc9qbvGShZpFhqtl2x59WZ/9/ycsq9ms
         SJuw==
X-Forwarded-Encrypted: i=1; AJvYcCWzXp5OkIzl/ZU+AThCmnpxxPjm5ysIFctz/99xvbJhpcZLklGNU868z2nefh44AV0b32w66fAb8BZxyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawMiNkXuQBaDYkmlburMrzw/aHyAnFnG8EZ2KT3PsJ4cnnkfS
	OxB3YK6tMHK5L5jKOSBTI1EXHLYBjM3Vg4ZGs3jm1shkU95seBaJi0HRSleqXA/g6Q==
X-Gm-Gg: ASbGncuOOVaWO2a65qh3sL6zDqVg7jy/oB045q0JvLOl8YVdJS+Y5LrdOiCiSDFOzWl
	dbL2gNh7BlNfU7VYwqUqdyab8pasSONHgT/JuZ/4Yugnvwx0PgZbybgLMW51uzWxmlkKhYM+SQT
	kadR77459csxHSE3n+O6V7xsOYmjnIZW2Vv8Om9f7Ivn4HcNRK3ShzKeIVRuokzz6c5AL4MgTaF
	n1xBB/dT4i/xCsZNOR8Up1zhvgp56IklbBhuYmuCp1r2l+AlQUhtsgq88hgNy9TQ6c7WIUh+i2u
	GE+N2Os2M69+Arin8ECECa7bUPPwWdZ4t29fZYG65u6b8r9xFbCZcurp3aYM1DFZTCS54wI+W56
	0zDTh3k1tyETz9KnAwkIRLuUqkOUTAwrywkcslatbnt9p0GYlU4JoNOo/fXEiLhkH
X-Google-Smtp-Source: AGHT+IG40gAg1zdLGZmMjI5naqJD7ijTD6o4+KRe8hXPev+79JqTTzIKatX374QnWR6oHoZ6OkEh7Q==
X-Received: by 2002:a17:902:f693:b0:267:bd66:14f3 with SMTP id d9443c01a7336-29027402ed5mr309800405ad.51.1760491993114;
        Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29084e1709fsm13104905ad.2.2025.10.14.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:33:12 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:33:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <yapeufdqxobl7yn2ylmtktyon55nofcpwujnwjjrwol37pxw4t@wv3akoz5w6f2>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>

On (25/10/14 16:11), Christian Loehle wrote:
> (Also I can't send this email without at least recommending teo instead of menu
> for your platform / use-cases, if you deemed it unfit I'd love to know what
> didn't work for you!)

I can't tell for sure, I see a number of bugs evaluating teo vs menu,
one of which mentions the following:

    on Tigerlake/Alderlake hardware [..] TEO leads to higher power
    consumption (130mw more power usage in video conferencing) when
    compared to menu.

