Return-Path: <linux-kernel+bounces-872050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46524C0F25B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C61A215FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7230DEA2;
	Mon, 27 Oct 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKOZA2+"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1B158545
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580607; cv=none; b=A+xX84z9/qji9SXxRAn7cBozbbXLiwDPILrv463XYOvxl9h7vTV+xjkgHlOGWRKPBfOW8atoSBu8Kjw5OER4zG7RWoJhDwVrtzk8BGMAf8kFN9OnB/THFVMFg4P0VMzuW1iD4YP6WVn3aeiqzPcZMj7DdkgcffCKybxrdID4LuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580607; c=relaxed/simple;
	bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9cwcVL/o2+9fcnalYcIMuKiiqNaMF3Gl/xqmuhxEWh9Q5I2bzv4v0aIGx6+ieqYxCOR+5xfbtoZjzyYVNfj8mweJJ2y/oCCrFnLJvL5b2B2+k57rX7StmEMs/OhA1W1gTDRVfHH3SoqyF2YtxtuvY7udGUuVvUhpUH07AOtAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flKOZA2+; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-637d39f35ffso849924d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761580605; x=1762185405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
        b=flKOZA2+TFHN8mVHaz+ipuRORQ7XJRibXSU24Zl1QIoHCzrrasv0XXe/A+PLqnOltr
         Gq+W5aP4Ln5hCBMsuPf6rRh7Vn+XfYEwflR3joFscfznk+UFZw/eFfe53YsK8UboPCQV
         Rp9vhaTLk8irNxzMWtewRQJ5P2qkI8Q5FQk6RF3Ah6VsiW23Ihe1DUKdkh2pV18u8usA
         fgR+mMTcnbBVly6v/CtPjEOkpO9tZj5I2zTlCRvxJXnH/MejN4cprHb6MQOHGYNFog9A
         wxiSdyOyVzmu2ZJ6RCKRwOGpvABt6gyP+VMK4Lic/WHnC+FSfp1NEFUx8h22gtsCYcHq
         DS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580605; x=1762185405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiym7E4Dmqh94R6ZPzH9fLGO2aY5UFNCKNdF8kfE4Nk=;
        b=tnL5UlFstcEwCD40T0h4rfLTVoz2orIxeFxisd/02JX4So0yZK7zC2WoJ0RAFgg8es
         1i6Dk/or3Lg4F0B26NfVcoBlK+d4Gc1oWu0muzSYOCfRbgWcpiaG4Ihti6ZBmyGgF5lq
         CwN9rnr+7bH2r0QhOp6QuY5/K+DMzJQ35OVQe7nzpUcI17v3L3rc/czn2hfG+z1/yWh2
         PZFBoxcjmMxg81LIXLQBtsjfoRHM5qsABlaumlDArLsD652SeAzMuDPhpJar1Sw5Kwnw
         XeAc4GBUAW1md8am761Sg+im5gMhys07+fL5qTCsyuzQ/VnYjyEOUKxdqOPcJM9eBs4V
         ZlSw==
X-Forwarded-Encrypted: i=1; AJvYcCVu/Eop+6tYnnGtg2Ra6+8MuDoeLF/suppC2w9W0RwmYlMXScIase0bVaIRt61MVF73tNmHj8EsZfN7dsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNpKFcclXiKfL2ziUlYxOMNT3zG64KCnQs+wxw3kJMXua+Xx7
	1bDsKdgTkJExUxjF1dOyL3p1UdBoL50qN/BA/WdgkXAVtdmVYDYilddUh45mLbEMi7SFEA27H/O
	eQQbgY7lo5kjXTJaiLbrCkyQtJs5cacg=
X-Gm-Gg: ASbGncuTO9aKbICPDGGA7F81RyU+qN0KEcvkek3hq9Nw03H4GMhyH2k2GWAOWMy4BKD
	t/O9QzDjmIcjPHraSkPVii882mGP10CmRFa3EnM5XjNRH3td1bdJlChABaIOpyLlJ16hCZHH/cs
	3kVMDvMOCLybtXtXG/HROJzqrZ5s/HfaeH83yhJbvH7myDCFwnTLfMR0olMWgKM/02+XNI3+/ee
	IBz83AVBqX+JlnWVEUxb8VDCgP+ndRT5GedPKRjr3jqeZnjXFVSJjCf5kOH4/ksR5Q2QFztfa54
	NtAh3To=
X-Google-Smtp-Source: AGHT+IFjOmYnS2xYaM0HCnIHZRcjA28iEqAsz9PYX968JpJQQJnvJYxUKIDW6M7qduZDcvbJ3707IkAmn+4FttWYgBg=
X-Received: by 2002:a05:690c:4b81:b0:781:593:edd1 with SMTP id
 00721157ae682-78617fb4d2amr1702807b3.7.1761580604915; Mon, 27 Oct 2025
 08:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
 <20251022180107.3a7d1198@kernel.org> <CAGSyskWm=jDOSPAh3LWEQQzjAxvc-Od7DkQyP7W9EynoMdDnMg@mail.gmail.com>
 <20251024164207.3062ea9e@kernel.org>
In-Reply-To: <20251024164207.3062ea9e@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 27 Oct 2025 12:56:32 -0300
X-Gm-Features: AWmQ_bmFQCqeshpa-lYwQ-k8GODXN7uKyqnNwg-U_bm1yTiNYDMbv1R8W4iv7rs
Message-ID: <CAGSyskWwDqng6TFGrmr1jWDhS_-PExen+fCVEm-8vDBUEy1uLQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] netconsole: Fix userdata race condition
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Matthew Wood <thepacketgeek@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Frankly I'm not sure this test is worth the compute cycles it will burn.
> It's a direct repro for a very specific problem. The changes it will
> occur again for the same field a pretty low. Maybe just repost patch 1?

Fair enough. I will repost with only patch 1 then.

