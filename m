Return-Path: <linux-kernel+bounces-808951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B1B506C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379F87A457E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181D32CF74;
	Tue,  9 Sep 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB/TmuGi"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F11D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448894; cv=none; b=QGPf2tYJrm9p/2Vf+ZSMdMHW78kgknjxWx+baVvzOb8e6RcCR+SFstmJIjJNpEJh7PzBN1TMFYiAuS1pi7ZCrKW5Z00fk8B2o01/eGOA58zHfEgquWvpMxNxXeWndmSPO80uCjH6rGMsClmOtW4DADyrjnC7xaAJ/7XbPVOV5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448894; c=relaxed/simple;
	bh=0RsLYpIdBCFq2CXnIllIIUx06sgVvgCrX54kp3Ry6Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ya+2wdHdsg7khScqjX1BClx5n0o8iIms8pPhSrRCscu29En0/I4h+1T5mQPHAuXoGkvEMGaSA7WAKztl7r5qQ41/fEWfzSwKfB7jY4jQUp+XqMA/9lAH8ueCbrffkq8KEoxUCR1JViCZoPNWYrMkza7NAWalhqRgTJf55IPlGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB/TmuGi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248f2da72edso11056005ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757448892; x=1758053692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RsLYpIdBCFq2CXnIllIIUx06sgVvgCrX54kp3Ry6Rk=;
        b=WB/TmuGiRWgLeL+HxKBxEx9Lrl9rg70jzCxSp82/rZODI8A/epK0bddOnTiqMnpJHH
         Qlo3ZdVOJImOsv17+c9MQPmhb1nYYF4XslVlskgIcJD/9PkRBD52Tavz+SK6gDINsUXi
         wMgcnRu7rCGX4PRo7lx9uWtcflDSUznsXEZFGLdbyt6EXIBMNcz6Cewap2XFz7TC2FMr
         lWALxUtqfacWk3BJlKrgkUJ+70Ydrp9Te8/kSnfKU/7rIc1mN5ApjhZkaazD01dH+Szi
         sf3ROAkTACsyo1XbgTiSPlhT6fbZLokBWHnFvgD8zVp9+hOxOFnHVor/WotT+PLVzq4E
         EFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448892; x=1758053692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RsLYpIdBCFq2CXnIllIIUx06sgVvgCrX54kp3Ry6Rk=;
        b=kDU4tahH2IMSM2ViXme/MTOqMs6DTNkOw4T3HaDkqPuI/mv9sOA/YJOtoCcflC4sFK
         dJiNN7aG1AXBt+pfSz++r4V6yQJfLNQdtf41DxtVZicwC6YJqKIGsHFzDg2pMV73e2yp
         sIKg+JnpxMkxhF8KE61E44iiyW5jtejhB+MaqIx3BefB60DvesF0WI/VBx9PKfCioI7T
         DAIJ6gu6XCbWzVxYrLW1EWi4lr8z+lOmaFIqubIGoIk8EtWk9PGD67XxDO0H+qEY0oEM
         polR7N1qvXckqfKb3dPN6QU2a7fQQTqBroHA9SySk/U1sMwYxGJ13XgXjGeeyueTQU5i
         SxDg==
X-Forwarded-Encrypted: i=1; AJvYcCXeYBgi5C8TrQSVZMg+y2onXkfxGaBXhdrEg3dKkZqJ+LvCsCnABkF+TjoIztvTZ5oFJrlYN6MgqfjKyO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KnMhLVuYCEIC9uNoShRm8y3OMCXMEQxbhHxgcNNSq4YxcIKy
	4zCjMXinFQXKFvLfFf5u7hm3e0Zti7lg4krihueDgHDqxJxM9eHOHFOTIJkCz+bvgI8kloGawtz
	XfSMNB3vpSbteJhkekzy48seCwrXzQtI=
X-Gm-Gg: ASbGncvTwoptN4izfdD87zOAYVRKAcaSHPeJRv80aPQptdju85XE/fu9NnuOEMsS1j2
	1q2L1zkbRSOMjufdot94RqsceaztVoLraT8GaRVasWu4f+MNmT6lUdUPIHfrFFn08AVLjGihodM
	OWFrV4OTDLLEsDfl6qxOqBtA7dm/P3hoP5giR4iBDU2W3bwA4g58xeiWi/Yaj9N/rOSPJ8g/78z
	ozaMhabolDKeWHlW4cgd0dHB0qfFDO35dd1as10quKEovJEwzX+I2u+4Eq/K8uS3K0s4Hpzuz1A
	7NPgySYgejBNf+SGvKxBTCIF9A==
X-Google-Smtp-Source: AGHT+IG8l2Cl0crbnUXdUU1gkjVHq4CtZSPylbc0kTpXl7tI3C1ru4Lsu/w7cyIRw74CZbstsu1Z6Dk+uaNPN+HTnJo=
X-Received: by 2002:a17:902:ea01:b0:246:ed8f:c63e with SMTP id
 d9443c01a7336-25168e74592mr84188935ad.0.1757448892145; Tue, 09 Sep 2025
 13:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn> <20250909092707.3127-3-yangtiezhu@loongson.cn>
 <CANiq72n7OSCUzycAQXFybx6BSVnj3MWAXvZj7U=AWf_UQwmO+g@mail.gmail.com> <CAGSQo01mQfcU1EiW53be1hcts0c1p-HQAab_HBk6VcVmhq3n2Q@mail.gmail.com>
In-Reply-To: <CAGSQo01mQfcU1EiW53be1hcts0c1p-HQAab_HBk6VcVmhq3n2Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 22:14:39 +0200
X-Gm-Features: AS18NWDg4ZT2JJKp5Wn_EDsPG-hMufN-5mAXel2614jBzRLlCVd_Ejc82tjlxds
Message-ID: <CANiq72nkim=Nn__xM118Vut-Bhyo6Na3RK-F6a0pCxN-M7Xgsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: Handle jump tables option for RUST
To: Matthew Maurer <mmaurer@google.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:06=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
> I think this isn't needed. I added it initially because Kconfig was
> dying when `rustc` was not on the path, but I'm not sure how I managed
> that, since `success,trap` should guard against that (perhaps I was
> doing something wrong in earlier development, fixed it, and didn't
> remove the restriction). I have tested `rustc-option` with an
> intentionally missing `rustc`, and Kconfig doesn't seem to be taken
> down (and it gets a no answer), so the change to the macro means that
> doc warning should be removed.

Yeah, that matches my test then, thanks! (and for the patch)

Cheers,
Miguel

