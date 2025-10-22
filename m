Return-Path: <linux-kernel+bounces-865251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA16BFCB91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8446250DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F05323411;
	Wed, 22 Oct 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM0sIJO9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A635BDDB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144175; cv=none; b=GvYryg5mCpMkUSDnpr4HiQlBKGXFWHI8728vzOtWZ69Z+At8MTKRcPCz1Mntle24ZSYzDxpAVWRGayOaM6mzdO6CcaxuT/IaGPWTOR5jlI9mW2k73PAu0Mc3/yVYGcDxUP7pHo7coj/Sp4i/C656qMYbs7Kx0gvwwHwuFs3Qzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144175; c=relaxed/simple;
	bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhNxtM7c+2ELOzqUAt2dg2Oa4lIl9lP/l2CzAQq/cHti9ixpNXvxWEgGqz7m0p3aNCBDf4VguH6hnWetD2NY+CrGIC/zLGOCHmBKsUjm8zmtNBePubF4m1Cqv5Gov/7lbeU17uOQCqJSYyanVcNPhLDoDGAHh/21sZ6dDl9+XYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM0sIJO9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso548449a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144174; x=1761748974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
        b=QM0sIJO94C2ZgElJUunuEmp+k2yxRo96skeqEaS50lUIAckKVlWK9oJVlPzAYybRGA
         fdaR3Qb4lSjjIBdrI7von+o6a50ITjgxMPrnTeSIkgMo1hAePVwEuTqH/ps09IvQlQ73
         qH/nwxA9e4DnApvCFqcKUvEFj5M1Qj3IcIPz7JBQ2T/z95ydOK9YFneSaYndF8xy8E2f
         PU6SlbQrMKppx4CtS2miHH0cD6QCL/NuB9FdVocDIPAmZnTwl3hFD8r/4RLDXafNTGmm
         ajowQJRC+48wqWaPmYwR4If5x2j0Faih8lZjzEp9kvdzQr72sCYrjJ8okbKmYDf7Z6bF
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144174; x=1761748974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
        b=C7DPHxvPqYfRLXqf7K8i0V7wPo5sQOoP+eiRIuRdlrIJB2JbwvbYNs/w86wH2ZRoUa
         uFKbn3542YA5ArGXDBB+9z54WDJ1M3rHBuCMrYzJT54rFclnMM8R1KHf1LUF5yTZOu4C
         iEfYOt26DAOe/7LgouKpFNAl/hANWpv0votR3eruOl2VwQlAMKUnfobpp9ih1AMyVVEX
         dVHG66XVWUp75Co4vYm38+Rs1Xf7+FoWXLao2Fqn9UK2Jv5ewTXXUONqJqYkes38CahI
         wXrum5XMR1kSX3WgrBUeMR0Iayu5yJNbVWmJxFj8RTv6DmfCZT2aaNZX5/+XdtVtbcIx
         HmBg==
X-Forwarded-Encrypted: i=1; AJvYcCV6f9QKGet638kAigNBvPldyWpEbGLEPsqqi7sogeGj0lfTxTvRxNRLh+Kdlt79jZPboblHdpVBNEam8ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNtGgQZIuvCmRfohyCCk0+ajnwSslVFAppMemL2DAaD5NM6qu
	fmmwI+IKwdCdwAgWsGrhWRSpEXnO5tRehCvadN0alnLGlwt6sWRcH+Xl1JLYg7RGwu5dpYn9BIY
	qIFKEaaDhhoOZ41Me6BVtPAig5tDqAD8=
X-Gm-Gg: ASbGncv92Il7qDUum3SDacLdLqReBk5qrqJHJ69PskAo7hihZoObn2M8vuMkToBzxOn
	BvTwY2dobNMUoZWgYkvEJRELX7paq/8UNNFmYwITrN5mguGIJwTqRIQok290GJ2UROZSNutIJW3
	NS/HP39r4kZkhCwWz7+IbEL9VK5x1Z0Ct3PzJRKzvA9i4vpQzvUNV0oeiWpkUNSxZIeIZOSZJB+
	di4o9QJAKGAkbU853rkmGP4e+RrLr8c1Vi5yZyRCSE/2CwUuwdHwW010+S+NBXM4qcJKNIY8LD3
	7hQ50wwsSKFhB3UkPMuOYXFYOWMMkVPFe76uXe06W5Y8wHumWUG1nrHwkDbgsQS3/H8fYoycbrK
	e7BSuZtF23464sQ==
X-Google-Smtp-Source: AGHT+IF0dLkMwF0C67XY0F31H5GqaR1j33ZTT0zRopJ3lXzaqdzE6cfhE7MiQK1KOT8lNdOakdaI73cMWJN4Y9UAbrA=
X-Received: by 2002:a17:903:1105:b0:290:b524:ec80 with SMTP id
 d9443c01a7336-292d3ff86f5mr56183865ad.10.1761144173719; Wed, 22 Oct 2025
 07:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-2-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Oct 2025 16:42:40 +0200
X-Gm-Features: AS18NWC_EFQnXFqlR8pd3BpYF88Juy0VblqECc1zdm3U_MxrNHSthFGuCElfR3U
Message-ID: <CANiq72mUauK+Z1nqU-m9LeY4mn2NQPHKNY9Psvfcbw+Axbrhhg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] rust: fs: add new type file::Offset
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
> using raw bindings types, this seems to be the better alternative
> compared to just using i64.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks a lot for this!

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1198

Cheers,
Miguel

