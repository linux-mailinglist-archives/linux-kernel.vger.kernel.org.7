Return-Path: <linux-kernel+bounces-776418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCBBB2CD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28028683004
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8933A018;
	Tue, 19 Aug 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZhvRG9Vl"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173C287246
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632190; cv=none; b=rbDkx2LSa0217G/XsIU9ph75Hex4ehlrOVU3BFoktiZo+IN9wmJofWG+SqdTHP8muc19FW6OgnlyWe/6kQCZjKahKRSnZoCRuokqIpQQzXw/+DpuBoy4KYXSWaqFf2YIgmnsBks5UXRGx6ondqKZKTG1l7nEeCgDnfgux64feZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632190; c=relaxed/simple;
	bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kESLCUZzQVHV9zlA+/dNG6mkbP+VnC5ULp3HjXSHm00oMHpDqftzUcCxFLoaNrcQEKSDbsySfie1ggKRaEOfbPFDPLZFiiEeSC/gb/xW/we7LWZmYbbet0VtO5RetgYRnHAv67t1y+H2pbxQTfjkI2xGag1BjKTNXK7bkUr8wyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZhvRG9Vl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so35349085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755632186; x=1756236986; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
        b=ZhvRG9Vl0pj/TiRwXhF3iSzfCDebouJTmG+cX+DxjORb9DSqD93ZVxRmVEfXrdIvRh
         G/ZYUhmmqt2nGlmjy2UVRbHGEbFG3zI9ADXDQ5COe2vNNdYVtmnFGG8dd9OObciNMKpV
         RMtT7KIH+xz6M3n+5E+rSDLFnndWoVcP6S7OXvf2PQ4TETFdJZQN2qM/BCDNhzigx96V
         AYk8zncvpojcMpVdiGMOekx2ZHq8KpYoKrndMB7GGzure+6vpbBHIDIjL/7kCtwTOb+L
         IzdCy1zd3G491sqEEA8LZgOv4b0wD/eu2fXSB7PQG1ne4WzAEXGf0iXlwlrG0eeUfK6J
         fu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632186; x=1756236986;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
        b=doxtGAM+3ZxTTSQLcesFvKIDmHslu3tEjpayECu21nYjnc8SBOrta1t6VEs/jMU0y7
         hSBPFkK4gfB0YP7tlB9oAVC5/1MRHl47EkdGju25tyNZZ9jOoCNKH4mlEbhRe5aFNKGL
         FD0Yl8ULZqe9/A4k0iIyLDqVEH+BgHo0NJ+4IbzOT3tUQXJyK53aXaWDTgNld18HeNpe
         RqsdMjJXt4j4Q82swVfmVVivUuMLB9hDV+uejJCnt0ybS/ejGxxG16SJiXsDK3u/B6oL
         2CUtt76vsvy2ZSIrbE3jydGIjmMutwoVlYnW26UkS8eIOsDnjO+VjFBlNA6gHNjgYNeY
         n/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX1HjvhZb3rfXU1q9dw1vYYYfVsa7LTZhABsQw8SCoikJ94lcSu0D4yaIDk6GjWF0493PGYXZ47+7SKuBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqwcvsYS5EnlFUbIiIy7aym13pw01raCoBSLXE+dNf/OyxLOb
	xORw64kq4YQgFMJGVx45nZwFfdjN8OKMejCDBPy1ng6PzqYI2rI9TiHtsF3t6eqZ88E=
X-Gm-Gg: ASbGncvcVw2gU2IVzRqGj0mnwg4kj6RsQwRkRAwWq+WZ6zkaMH1VsApTQOAqEAPtK68
	abEH20dnRl5N50uhLvQkqUC8OCtKYTPixQ/McVWEhAHpaebscT6PtesWS72pOlZlRjhY+uWV0V6
	u5ZfYnN6pKRMR0oBLpy7gnspoS5T/k82pH2XVI24xTR/N4zNGbL5RkV/hys2WrnKitCTMZ9FK2W
	417M6AgfJ2pp0nDskDpks2LE3+bhoa8Uv4S9KnfHKRpAc04rRx7lZVaEDcnCE979LaUbr5Bi62h
	U1gyI+Jso5FCdosTMhvMWPfAyneJnOflmGf4Ngst1HDtHA/sWtx5CRLvAzGx6vUpdhW1TD48rtW
	crJaAAKyXIg==
X-Google-Smtp-Source: AGHT+IHBk2tSb5Lmwdms9G3Pkyvfo6Sp5PUfXRSGwyT9Jfwf9OGJ938dge2YMoXl7bFT6nj/p8+rtA==
X-Received: by 2002:a05:6000:26c1:b0:3b9:1109:7064 with SMTP id ffacd0b85a97d-3c32c52f457mr162200f8f.15.1755632185904;
        Tue, 19 Aug 2025 12:36:25 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bddd926sm2708328e0c.14.2025.08.19.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 16:36:20 -0300
Message-Id: <DC6NO1I1LFU4.1G1WPLKTRZGNV@suse.com>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>, "Jiri Kosina"
 <jikos@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, "Petr Mladek"
 <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Shuah Khan"
 <shuah@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Cc: <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Marcos Paulo de Souza"
 <mpdesouza@suse.com>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
In-Reply-To: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>

On Tue Aug 19, 2025 at 2:37 PM -03, Ricardo B. Marli=C3=A8re wrote:
> Some systems might disable unloading a livepatch and when running tests o=
n
> them they fail like the following:

oops, sorry..

Please ignore this patch, this should be handled downstream along with
https://github.com/openSUSE/kernel-source/blob/SL-16.0/patches.suse/livepat=
ch-mark-the-kernel-unsupported-when-disabling.patch
...

