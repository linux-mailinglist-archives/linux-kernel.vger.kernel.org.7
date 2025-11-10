Return-Path: <linux-kernel+bounces-894316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF97C49BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4181883F32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74E303A0D;
	Mon, 10 Nov 2025 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUMhSl/y"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECB301707
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817095; cv=none; b=MoGw+b7lhInrAuGNa+h4yFXlnZX5QtvdmQdwtH4FgmpoXC3kX/77qFwF0TZCP30Bi0OY4fud+XeMQNVIeVaFoJY5CkhpckeBnv9K41eUwyMqpGBMEYJAoldYyf/7LOuikjPKY8HGMt77Ko9LcTRujHRDd3PYkNKFx8zXfrA/4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817095; c=relaxed/simple;
	bh=LfgMc321C2gmcbEJ383Vf+rgHpae4BVbOamwU+8oUxk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UuHHuo/yeq47o8wzBDvMothwwECNG6cs/tf4CTNFF3GzNq0wp2+KDIk4nvIFs66YXem3TMdKPddKSMNYUpD6mK4tvmymrGoqXeB5KT5eQSNjdvRElSKTbTSPyKj2nPmW6L8dR+uFAzBSVchv/3hTbinN2ybkw5KJwEag3JCr/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUMhSl/y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297dd95ffe4so26333585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817094; x=1763421894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB+sgp3H4KhlCjjfdfflHKnV1BKdMwtwK7bRa+WX+h8=;
        b=NUMhSl/yWrmfhdHJdX8fih355M0vD3HaxKpbVlgg92iS8OdPmXRoQTxj3Chn08DduF
         fLeJ2Z0hRlSivSJHFLxZq/9jYEf7acz+qIrek/3pBCkBggns2OypGaXQJIOV6zKF2DFD
         3/VyInLtLJbynuXA5BT2nHR03dOhxGIH+u/w23IhcGUlqlnNdww9AGb4AOoQK5Qcf18E
         T9L5mSVa49EdF7y2xTpOujSgjpGyDRPSGzp/6NwwUfGv73tYoSHfeU/afKlvUN3w+c1r
         CbX0vx7U94T+a3o5d2CvwjknEZHNoxAxB8xDwM07ZpWYdPgmpEb+MMYIxStTPNhaYuz0
         OcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817094; x=1763421894;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB+sgp3H4KhlCjjfdfflHKnV1BKdMwtwK7bRa+WX+h8=;
        b=SO18gwlusH8HEnRYJs6u9RIcce1BSBx37crC8AdS1DVVoFx3AwXl9SzNhtngNvgXqu
         a0IS1hR7C3FbHTTNyLSO/OYHe2RsUiTPls3CmucQCARkB0wLgIGlvSi4K7yRbnoOSRh9
         X41CI0XW4s8Wd9wFkFChdPlooY2i7sXD0HnzSabmPGI0ERyIN2/Pw2VGoEMbWheoJ0qi
         A1WA3zuKwXMOhueCIb1ZUN/Vh3o7By1moeHJNTdgMkcJ0by3g38lzuG990LsMlyHws8D
         uaefNpkyCaFCctCEeZcxyKQJi1V5t47f6r3/CwugyeVd8oS5huNJ/fh/y/guIFI+17SF
         EXgg==
X-Forwarded-Encrypted: i=1; AJvYcCV/lKz5N6tGtRgHUBMhK1y88s6KYZEsQVJFktY2pdfuDqOcs01wXywm+RZGSsZyGISaHthUPkU1Qb8/nX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsOrCI1pJidHZnln2QRCACJodXGvh6f0Nk1b8rZ18HjY9wfJg
	3YsSlM+its32firlYygXS6FXytGq8IWToJE4VWBYcEnHEKiHMMvReLwi
X-Gm-Gg: ASbGncsNBkJDX83Aq3J0PZeQxGAtP4zum9QjtZPEk2zzfl2lpP45U/BMtHmB13XWlD5
	V3ia/2Q9OMwfwk3N5Sm5JGm2M36bDguuQbK5ps6PX9jwqdGyOB6NOWiDxPARErHfbrIWrytlUul
	l4/X5Ahg9PeVKAWGznUXdFIzD7Ee5jHPSkHRdYnpnAvB1OWCb1ISbafuDEMyJY8wU1hVizWZ1GJ
	KASK6WKQMZMknGP8OUa+cM+3ekHJu0hTFbp5VZBlNkKNDXNh+qrHa7fm9EqzlsD8UnKNBGZjCb+
	GrbdjZDQ+SqTZxHdEH5JB17dXXrqMqv7jR8iWCt4qQi8l3zWe5TaGzKSfF1OVIH+DH1eXDFeubE
	2pJbK9DB3lSeJ9Zu44DPzPPXfMtneVhk1v7qQShi7lYhhyLXiDc8xDFKOfVqRPk+fkk9Tl3fl81
	1kv3rwNcedPkD1CP8HEn2SqNgSTd5hwamdM0cR6LUnpwdWk0Jrj7x4i3qCUKq96YMx
X-Google-Smtp-Source: AGHT+IGPaBk6e9Khb1yqRKfYMFmfSNYwn1VnFyXe0wXMOkJC9R7tqlKr6n2Ksy2ki1vCKQog9xKolg==
X-Received: by 2002:a17:902:ef02:b0:295:a1a5:bb0f with SMTP id d9443c01a7336-297e565d7aemr118857735ad.18.1762817093570;
        Mon, 10 Nov 2025 15:24:53 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm12092310a91.5.2025.11.10.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:24:53 -0800 (PST)
Date: Tue, 11 Nov 2025 08:24:38 +0900 (JST)
Message-Id: <20251111.082438.1117005832484432168.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: net: phy: fix example's references to
 `C{22,45}`
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-1-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:21 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> The example refers to `phy::C{22,45}`, but there are no such items --
> they are within `reg`.
> 
> Thus fix it.
> 
> Fixes: 5114e05a3cfa ("rust: net::phy unified genphy_read_status function for C22 and C45 registers")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


