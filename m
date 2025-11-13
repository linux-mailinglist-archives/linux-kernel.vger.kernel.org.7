Return-Path: <linux-kernel+bounces-899100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E37AC56C60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8998C3AEBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0742E5437;
	Thu, 13 Nov 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JsmxVOb"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D22E11B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028534; cv=none; b=X557V9wwpsG6DXHIQ4g8tNHS1UAVXd/WMyjqhkSyh47hlR1P4au5bvBhf+z/afhCXDDOqlW+UA9n0EgQX/X3j+ll/FVmpks8DreDRbAhnSHovzams3OX1Dg+quEl2Wg1/Rb0yBEFmMCTpyQY2SbDhCE8Dz+mX3w5lYEJsY2CKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028534; c=relaxed/simple;
	bh=kvt780SIWGzlUvGPwKmsBrmD00+cQaoxOlZ0WaCZarE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4VL8LbOoAKcYYyy8DM7kj7NMiTJYMWNblZAYT9VLvvXjWHKRBUAI4PRqFq4siaGGjcYB8bSbQAB5bXBDjhIe+Quqxhy6WvRf4k7epr/cEPhmpn8dkWwxfv7JzuirpLQJVDxan4Hhyea3/CBO/7IIan2R9GU2uDbg2d0F4JfIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JsmxVOb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so1043979f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763028531; x=1763633331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvt780SIWGzlUvGPwKmsBrmD00+cQaoxOlZ0WaCZarE=;
        b=2JsmxVOboMyheYfOkI2F9uUyPcfHspHuk4AOuOjOuyfxEv5Xv+sAe14kkPEh/R/MHq
         w2yLMRUS3C1yOeomTYCzpDfeyV+8CcWzMdKBS2uzvzBOGq3jc61UWi3ntfCyVkd5LnyF
         hwM+H37eUABCH4mWdT3k4DUKWlwJ3Yyn7JNVMp6so5o8yjBuBBMQmJ4qXOOIrmW4lyz/
         ZoXIcxrZL47y1b11E4+bMpuituV4g1qQ8l64tzN+YdEY94QeFXpNxBheA+7cTPoISNUr
         PI/b1Sc5Iv9DkzESKOnPY860sN328bPSoT/21MsVTS+Y3hKT3N+816+rLYpxohNLnGTt
         3IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028531; x=1763633331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kvt780SIWGzlUvGPwKmsBrmD00+cQaoxOlZ0WaCZarE=;
        b=BclUSZ6HKlt7e+V7U3pkF3q/kxoZRy/WP/wyZZvo5AsK4zapudqlSll+itndH6a+Ym
         3BLTTHNdRVfv8LfQJ5u6HsZG8QWG217jmScxB4QjuJf9rtkCsRAYkLSCa/xwyz//XMaS
         b/7d/sD0w8mvgBpJushHLMIDCFJlna8LBRFIJUK4Onx4hrVJATOBuBNND1VklSxwCKyJ
         67IsibKmOeZJ0wIljmsfFNqbskiNbcNqs9HW4SntxZMlQAAcMc9pFqL+HDdBbUI0Ut1Y
         2B9+Bt/Zde40gEu0xVk7LJCTZK099EAcgJB43mwc7Otzf5/SE5XQDfnlVWca68DBur99
         owmw==
X-Forwarded-Encrypted: i=1; AJvYcCV3d0/TThzl53w3JCRnGLom+97tddJyj79DnPO4lf0eWvPqZx37PSjPWnJOMdRDhzDFaVrR7ERkDYtsZIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq8U4XNuoGaN5YSpxx9nZVs1Ge0dO/sj3+jyhThS2JKCuPLkY
	QP8a1Uhnv6CpMEOsX0GSHN2onqReUt4KHLk1QT7LociBHT413Gb7r5LQlKhuUlK0TukoN2TaxRT
	SqtRR3eHFasE2fN/lifNQjiuBZFpFWpCEMI6Gd4pO
X-Gm-Gg: ASbGncvAcBF077aU72IVdW7mFhZe7Rn3OteWlSTu9pkppZrjUQEn/hi7j6h1oHGpKXy
	vt+ZRSNB+n+TrOjsYr4MKxQb+PVNnWpyq1aD9BbGPgU3AXBCxK6XbxKTy51cpSk+2L+jE2b8cRQ
	2BLsEXK2MIjw5lnrmBwce6n/si5V/150s3scEqcRR5OMdmr6Uqzb6hB+1TTdh66WMKCJ1psr24O
	GJKATs32N2BRD1pHZYivVPyl0hMh/e1ZsFKsR7fsXv08tHVGzMIlTOk/XJixuY7eCQ4XZKoKeSp
	7ksMbrAE0Bdnf48wwBSASMY9Gr0CTk/fJ4Sd
X-Google-Smtp-Source: AGHT+IFhystVj7WTIc2ei7HJTVARjXWLmCYX2E/mWYFTfcgBnm/4nU5LAALUN76YZBGbykrZiWnLxFCjh5F76aExM6I=
X-Received: by 2002:a5d:584a:0:b0:42b:2a41:f2b with SMTP id
 ffacd0b85a97d-42b527bdb33mr2434896f8f.7.1763028531125; Thu, 13 Nov 2025
 02:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
 <20251113-create-workqueue-v2-1-8b45277119bc@google.com> <CANiq72k1VqR7P7tY2V_siBQZrNXf_ck5aBkapo6M_6X=1P+nDA@mail.gmail.com>
In-Reply-To: <CANiq72k1VqR7P7tY2V_siBQZrNXf_ck5aBkapo6M_6X=1P+nDA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 13 Nov 2025 11:08:38 +0100
X-Gm-Features: AWmQ_bkNUOmoUuzC22bTOPSTk97TejvJdNA8Vnk7Dt7jP3D-vmq7dUJSIwMgwfc
Message-ID: <CAH5fLgixPsBwqFdY-ku3AtGQHY+qa9m5oqMUshqdob7nzGQpag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: workqueue: restrict delayed work to global wqs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:06=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Nov 13, 2025 at 11:01=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > When a workqueue is shut down, delayed work that is pending but not
> > scheduled does not get properly cleaned up, so it's not safe to use
> > `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> > restricted `enqueue_delayed` to static queues.
>
> Should this have a Fixes and Cc: stable?

I could go either way. Without the next patch, there's no way to use a
non-global workqueue. But probably is useful to backport anyway and
there's certainly no harm.

Alice

