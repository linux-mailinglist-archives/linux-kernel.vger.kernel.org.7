Return-Path: <linux-kernel+bounces-786659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18DB36096
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E70F366610
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E13207DF3;
	Tue, 26 Aug 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NndXInUV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305151A00F0;
	Tue, 26 Aug 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213153; cv=none; b=iTNo3V9leDLTm2GB4ElYAAVJ8ELC+6KftTlkduNDO5UhsQLdo2W8DwHlYk/Kn4xaP88znet1yU1NNmM2jlpJGq5majsofe3Tnw5A0xwQ51rO1Zp3BHE9iYdyvvvxrmclYb8f1XCiecpOCjOP7qNR/Fj5/mwW2HXQFATypSZXsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213153; c=relaxed/simple;
	bh=Xv5u9IFdfv4uunaUPbO7ghmuRT2sHv7+Ljf/inGsMdo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TRmdoGmi7tgdeWm3MGUWGrHVbQV7vx9Qi6J1AcPGB8zPvVeSXvFiGGB8ZHKhhpGL0g2VeBGbOtWOzU0kpySoZT0x2JmdtFqub7JM+DTCP1nYlMTXRGJ+zF98ewHIcQHhymqqQiXUPIUSR/oDvVaB61ZWq4Btqi7OvWvtJT4S/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NndXInUV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771fa8e4190so355405b3a.1;
        Tue, 26 Aug 2025 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756213151; x=1756817951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5yWTd5+6nk0AnDl19DQFpHF+OyM78NTkMn6cQGhR6U=;
        b=NndXInUVL1SlsoJhG5m573uHwCQ6OAdcFis3DKUVz9OcSnsHzae0LXeDY2Mz94rJv9
         t7QO/grWp/HjH+RfoPPRZl4JJYxQthefwLK27HgQnO/zFZwhVTD1/ddwkf/Z9FYofImi
         BgAKdzw+doA5emFogE+cdbxZ7Pp7HLTLlWevsjxx+4wPj9OaLDxd2cuuxlKBBa70DA4a
         lV5YAZbukblupKsx0Su6POet3iOkrc2K9Vnv5Eqc5e/YUOJNIkHCwHpn//RRyQOTneFm
         104qn8JRY+H5RHXEi+X+JGrjf2JsaquqXJ+o8E+2WXjWK4mxmZxdK638+5k4caB7XB74
         ZfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213151; x=1756817951;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5yWTd5+6nk0AnDl19DQFpHF+OyM78NTkMn6cQGhR6U=;
        b=jtSHlTwmD9/ehoe9llSj40NfzulzHaKpyhK8Qu4EV2kKJpDo5VLBeUFl5/VQJCZm/f
         5db5HOAA6OnmkWMryz1CfhEWMNAaEmuY2NFgZWUuksCFxs20S5mbFoqHfL/YVZ6vQWQB
         wyG2UThHv82zvzBIfDWSjORM3Ewg9XGNdBzFq0Y6MSnTFSYRr5tgzWZ5FaCCPLxvIm6O
         ntnjoRocUS/VCl/OldBPitQLiHsweIZjg1uT60yZmEVjsbPhUABGwJMoGnZP1DVjOWTy
         aUcKs2+vlVPyEnlkWxk9k/9KeBeU7/ahQMl4Ry/rV7dNB8NKDRwDayq+AWtYwqBc136Q
         bXtw==
X-Forwarded-Encrypted: i=1; AJvYcCWAe4981tHHn/pEIRjgWW0Xt78RMpfnrkSmrVNzqNgFjmu/WyjVkpHZB40cAjDTiVbhwAg1NkpgI95imiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4//TSt14398vwu9Dch/SyIRGgG02y5tBHPuoADCzUpj+R+2xU
	lrb198a3m+KfXAO72Aq27M8o8UdQr74C9A47wAgqVT8jmM+ZGHU5aN2c
X-Gm-Gg: ASbGncuh7ivTnKlpp5PlpIshJnRamFvRPoQi/FhtJZ2mIvFPAF+reUufB9YQ2ASsgUH
	XZDHcDhzoWUvHUbcQo0kd4etoverwlzfjf8QiJFKa+HmJvvte3+DvroEQx+/EquUSICMtd3R50h
	W+qZY5m6g5RXcw/h4Ash86HBKj9Hozk5V5XW4h/V9fae1XYDd2jpKHyB7qZR4xVmqWoNbdWDJRa
	V9eKtPMO0AGD4Umrmt0XmU3bvf41qj1KhjDK64sORRjRNt5yhXhtuzbLhqcbLUAlcxYAV7OY9Ej
	p6Z2RY6XpCQ0VIjQC7icOLm6a+I9p6fs+rApF3EcpBY8DRmx/vP+zVb1SlY3hOyr3yjHxZ8uZfE
	jCIbr0txZimG5+Y8xKY70f7kAdqwNj4BDP873VUutIQpGkC7B9fSI2nqO8HafxkarMmWt3yHES0
	mUhgWGnl4qXfI=
X-Google-Smtp-Source: AGHT+IH5m9fLpKTtFaUY48mP9ZWh24oMPu7CKYn5nEdScs5xyF43lIdEXcCnAT9AnCSG61kSfLfMwQ==
X-Received: by 2002:a17:902:c94c:b0:246:1c6a:7026 with SMTP id d9443c01a7336-2462ef5fceemr219257345ad.40.1756213151434;
        Tue, 26 Aug 2025 05:59:11 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24884a629fcsm4751305ad.19.2025.08.26.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:59:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:58:58 +0900 (JST)
Message-Id: <20250826.215858.1769736032643857907.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, a.hindborg@kernel.org, fujita.tomonori@gmail.com,
 boqun.feng@gmail.com, frederic@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH v3 2/2] rust: time: Implement basic arithmetic
 operations for Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250820203704.731588-3-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
	<20250820203704.731588-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 16:26:44 -0400
Lyude Paul <lyude@redhat.com> wrote:

> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
> 
> Keep in mind there's one quirk here - the kernel has no support for
> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
> simply provide Delta::rem_nanos().
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

