Return-Path: <linux-kernel+bounces-849470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89299BD0315
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26753BD05D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADF2777F2;
	Sun, 12 Oct 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzAvT7MF"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D52773E8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277903; cv=none; b=qJzv5N03+UyGRlXpo/tMhLRJiL6K9QTRJDzL7pfkG17S3INbXOA+qFegOSXuqidcJEcdKYuIIkFOqRAHL4nScoUjmKeT7SefmDuPc2rI2Cjku1DXllxHtHbCDjoAtwlUgTbrrRWNo2kgjJrFe7M85T+Q/j435YsgVMeCAde+Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277903; c=relaxed/simple;
	bh=SUCKplIlV9GbXZf1FJNwlR6/8RVMJUgrM/szCfbpnQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5pV+E6LGLqs6uaeDHmnNiXPmPvw+pLj3vqt90TYWSp3CR93+3ribsGHSKJr5PfNx8oj/Ijb/T4QRisgAmYuo4sAr410ypL+CvTlhR4AQNjNT46UUAFacObRueAii8s4u2FDQnK4s+pQgUFC3i1ZUXFLRLQOoBBtO2Cij4zRTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzAvT7MF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-279e2554b5fso26112025ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760277901; x=1760882701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi4T0TH8A0fKPF3Zs0o2a/X6S5Z36f1SXjrYZd4ibpk=;
        b=QzAvT7MFQDWnd6+ebDn9P8mvAQlhCqGZCgvF/XfWUwXBjJRGE28M++c+1qQy07cX/l
         8HCZJTHSvBUvSEqQDb1j5ebax03wetg8ZF8oqQnEKm4cWYXuzD0zGqh91giWFS+zmayq
         dGpmKlz1Cv7v4/RwhgYTDckXhD/715PfCqsNXTuDLmyBLh31887P1EcRNM8cw7LpSJhI
         DmhU1a9JQB2fblefacXZoj2ftFmgMMSjVlafx+0QdeaVQ7UwM9mGp4DJUWYblhYF+Esl
         teVbvddceYsFKPX+OAbyDyTAVczHEGoMotrJrzv8Eb8bSVl6Lj3rijROdoocazGiPoWW
         XUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760277901; x=1760882701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi4T0TH8A0fKPF3Zs0o2a/X6S5Z36f1SXjrYZd4ibpk=;
        b=rVrdHiPV3MiQT9ylWYv45sCJlY8q7WV7eezdKUWbIxuFt2dtk/iec0iahp9ssMoPe2
         XMJe55rq6E3/ByQJOFGld8sFRjAQeNs7UrER6waZC9VOG8WCu4gcy/CUnfUM+4kn4tFR
         gP42alukAbfDyi2dBs7od4cYwo+kgVOpufPYAoKEIawl+18NfB4Y+x4bZLhmEaqlKlAz
         OVMywx707iu02TSjzRtnaFAwMWDU/V3J/WqtkR1+oXbzf4ynCoX8k6n82NpnGaKm4nn9
         RgrBLvar4ceqfkkkpjRrbUS+jJtCa/dyYst+d+VVWHiqOz/5Q+Wbg6kxQMAcwSNGd+O0
         MpXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+1qqhIMDkPTFiwX2gYUe9yP5jXMU4Lvc3nlg7WdArFDicSR8ydU53KjQcETwHfkOwN2fA09odod6bGd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0JDLghVNfulJD60Q7MpnZixMaKcifRKLoVln+wyB3QgVTUiS
	EEuAkHKqIXNvxmN+soBn0h/8p/Qjgs9cq0cWD+ISNZPZ0cUOsTfKeVTRzDuV/dW2
X-Gm-Gg: ASbGncvwDCOOn+zBlEgEs1D7GQsJXXgy4VRZihXQumdD8vECLgHCI9yfqs/xYZkBP/h
	AXp7fWmoPSKwXxGCEsDCH5eB/ZjgKGjE82ZEVzWslwuQmO9/l4vPnJ6hc7M5d1kCMQFXIdb9IDY
	BnrlGq7muvGmCXEvhqVgNWpH1mxlq1XzhyoPBlpYBRfsnJwapWi/ZVy423W6vqht4PPaK2bXD8q
	quoeZ4DuoPN95x+nX4WWdaU1oJe9RSbD4pWU1oJU4V/h2kweaoA6iCpfrPFOWqGa1c39TxVgDPV
	I0gzNjEfnnhpxkjyXj4Ctd8SgCoRxZpI04xgABxjcElvVBUAT/DPkpLT3fz0lJp7JayhdGv6upU
	NekQ7gK1cjursTIWYdsT9OdLRKypytRP6UK2a561XpmOGqzvFipiCdbumc/ohBNqiqepg
X-Google-Smtp-Source: AGHT+IGavuFKFawAItq7cPjSq7/3icbEiNsjEbDay5mb/KvWr80bnaNSCF+3IOgnuF8amEVi9WUINg==
X-Received: by 2002:a17:902:db09:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-29027e788c9mr237734005ad.10.1760277900591;
        Sun, 12 Oct 2025 07:05:00 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm106828495ad.54.2025.10.12.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:04:59 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Sun, 12 Oct 2025 19:34:51 +0530
Message-Id: <20251012140451.155219-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
References: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 30, 2025 at 06:00:41PM +0200, Miguel Ojeda wrote:
>  
> Thanks, that would be appreciated -- if you can, please rebase it and
> send it on top of -rc1 when it gets published in less than 2 weeks,
> then we can apply it soon after.
> 
> Cheers,
> Miguel

Hi Miguel,

I'll resend it on top of -rc1.

I also noticed that several files have received new commits using 
types::ARef or types::AlwaysRefCounted.
I wanted to check if it would make sense to update the documentation
to reflect their new file location.
Without clear documentation, it might become increasingly difficult
to remove the re-export as soon as possible, especially as more such commits are added.

Let me know what you think.

Best regards,
Shankari

