Return-Path: <linux-kernel+bounces-776648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E67B2CFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AE07A4EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2F257829;
	Tue, 19 Aug 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMin5XGl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979F35336A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645794; cv=none; b=VHGNMeUBmh0mve+cIwSA+JPM8fmFDQS0NkmT+AMY/JMhym8wp23nlAc4o2/d/+2j1Ghm4xYAgrNkZ3M/Kr/AxGUeQ2qMTTFWevxtGhltYmSP2V2UQEP2RQYvxamaF/5sv7oy+9rxHot05bPoNz3rgPRp4Jgz2a7HZ89hwJVoZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645794; c=relaxed/simple;
	bh=FgXbsPON8BjVPusem9QjMh23k1yZqq1A6IIZikaB0S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Swm3azVtHj0v/Fc7MRQ32fJGhC5xADj97v3woZpANfD6n+fijI4quis5slbfoGFYsh7tnvUILvndK5a0mP58Pzg//WUMEma/2QsPyQoCvTZVQUHHwVkWZ3ZbQuNfdgM5LNpV+LGySDxtWwZirFd39LpyH9O891R36FkvHQxrK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMin5XGl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-618076fd48bso1648a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645791; x=1756250591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgXbsPON8BjVPusem9QjMh23k1yZqq1A6IIZikaB0S4=;
        b=tMin5XGlhL3bce/Ermqmj7VllDam3ypeLqlKtip+T1O51UFcplboDAKUiqRm15uIW6
         6n1Wp4Hy8BfPevM/KyWhcNpKLlIqMF2EjCfYNa6hP7rhYuNz9zXWqPPs5uKWx+7dYTfq
         mPBdHKn7ceVw1Pzl/pW+INxVvi3bAvykG7zSDG4bgN1ilCUXDbFCJ4vnyHt2mdMsMqCc
         FW1GWbYCOJY9kmZBdmoB1cOmcE2ZuVs3Utme1Hk6Q/ConSuYc436HRF24xfEd2JCWj8p
         zCi9oZyjboULKQwSGHu3WPprBupT1TNggSJOOJwHZA4wWufr6MF2QUQsiRsj98Yil2cj
         lzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645791; x=1756250591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgXbsPON8BjVPusem9QjMh23k1yZqq1A6IIZikaB0S4=;
        b=wxTN+vOICVD6f1VPAalWqXFkGvDCOtt9yNUAVUONG8hrSV8mMB4v+KbUd5fOrXr9hw
         JqD4Lh1BZSw9fsSbS5dJnmwDPS82oXQ2LUmuHB2b5Y7zaoPDzIRU845lpHsj0zt8DzlO
         ytcye7ZWlaPk1GxpW4WbrOg2RH4nACAlikKhtzihzxTfMgwth4SV+MQnAXq8ykHH4qti
         8jcQnCTkR2JOHYbvhI/QgEo5vFI6LCzFxSescUXmUM5q8NvgEh2PCCFljUNdHaVm/ibZ
         63Isz4Fg2urB7XSHmDZX3YMlQJVtFYqxTCCx9ENDpx39wwWEHDoiLUU89pVjWUDg02sX
         kufA==
X-Forwarded-Encrypted: i=1; AJvYcCVudpfie3cJ1bjh3tOU+rhfwn18+Zn+wSKUIkgF6JnXAVbSOUS6hA7TlV3ZYVySKzkr69U0J1Eayi9R1Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4WDB8jnMkvAqNSUUJMAe8Gz5grdy83rT4g8WDzs7yBFevzxb
	ndmJYzbdcNEdQPaCbI5xAENyZhBsFEi7nZmdGV0rTE5FMst0ORtWWHXxsCPBhmMhzy3vVt5uN0J
	LBgd2Wb2J7WC803K7ddwxLLL443l7ECUuxNpknzFU
X-Gm-Gg: ASbGncvRECiUqtVDUOVMt5YoamOdcVuIDGxtbk2mB+N9v9dG4kF57MxKnICL0lFApVu
	eyB6qEquhxzHZSYakcWq5lKPAEebFuLTqv+WO78CrZ8U7I5vTeXJ3/PHnkf3OcfXey0EuOP37cA
	qFKsFuQSR45wJ/yiKpUFgmSg8WjMlPFEhQj/2T6kvVERsdczjwzyOnLJFmj2G6w5TQ0n3wuT+yB
	L/whoOLRchZ32Mykc1l8751tyeUJJKxv0EUC4yNSQbb
X-Google-Smtp-Source: AGHT+IFSCLPVTfsBiaf24hTwkehzYNAWh1etb+0SGuEqrrfRehL7fLOqvcwLgHZ2cPcFG59kqvBg4cby0Sli6tYfTVc=
X-Received: by 2002:a05:6402:2089:b0:618:a73b:9cfe with SMTP id
 4fb4d7f45d1cf-61a9b2acd4bmr26165a12.3.1755645790860; Tue, 19 Aug 2025
 16:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <20250709-debugfs-rust-v9-3-92b9eab5a951@google.com> <2a0f2965-af37-4ffe-8806-3bb469361b1d@de.bosch.com>
 <CAGSQo03meaA2fmoHqxdcVSXrKdE7yTTK0JfWH28mHZ=0kWoTzA@mail.gmail.com> <CANiq72ks-B--6UxO-VsPAvvqpKap7G7rSHxJs5gam0hjWB+vOg@mail.gmail.com>
In-Reply-To: <CANiq72ks-B--6UxO-VsPAvvqpKap7G7rSHxJs5gam0hjWB+vOg@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 19 Aug 2025 16:22:58 -0700
X-Gm-Features: Ac12FXyOMFlmQPAe103eecrycpXODR3C_02-CqxCcXGkK8czg1euU5bo8OQ405k
Message-ID: <CAGSQo02NP0bBSuPWUXkhz0gh9y5A=X16UkCQb40DTJ6Qkm8avg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] rust: debugfs: Support `PinInit` backing for `File`s.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is resolved in V10 [1], just sent.

[1] https://lore.kernel.org/all/CAGSQo03RGzmP2diL-vvLDZHduu=d4oFy8X46Fc8vg0SzE-XfDw@mail.gmail.com/

