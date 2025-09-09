Return-Path: <linux-kernel+bounces-808568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DAB50193
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520B93BB3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2913774D;
	Tue,  9 Sep 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNbdaxaV"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934F146A66;
	Tue,  9 Sep 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432313; cv=none; b=HYgUPT2KiEBsL9EytSqlrhq/Isj9sheUu37pyqPbrvDzLAVZa8cYGwVgTgQYPsMR9lMSv3hP4X+VlYxdTULmU08648h8aOfXaAB5FwvWEGHI4/dg3H9NeO6fe4klaI7/sELkyD/TL7VcZtSGqU1k/d/0Q9eTsUYaZcu0wV1xmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432313; c=relaxed/simple;
	bh=YaSG66NRgKPkQ1bCgScmlkcGm6GefcLnamGKVw31HX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzP9PlIiND8ajI0hW2V8giZWn+psX41aLW2COcQC9QVrwAQppEBVa0VN8dDiaCXRHcwE88rcS7HZ8xQkI/rORIsjSNOj7OODjotI7ilYBvv75Lbi65vRSIHahYVXRo10my6WB+1j04Md7X8oPbcaWw358+RsR6h+KNgnsOYhG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNbdaxaV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ddadde494so49266266d6.1;
        Tue, 09 Sep 2025 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757432310; x=1758037110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jCGWwE0Dfpn0jrzsRy+P5oxdVsQ38mSXaDrR9/FuTMk=;
        b=dNbdaxaVrzzxBkej64eq0avMZUkdGKrlG0sOnt4YIGG1MCEPzloLvzkVlHReEeQEAh
         I2kdUGKzfYs39h3w2K8iWYZtECBhgY5/icYsYbWzvg+xFrmom9ngyxE4UJD0D9TIp5Tb
         G3nmmymCiYJEDXZGWANDMhMWfV2dLdSd2YWTf1VWno9uBD0Qs6rUszgxLQMYpB9OGx+I
         bv3dX6RTrU9Cm+myxTb3jmVJ6hfdl9en/UT0sjJE6U1NNZX17S8+W6qSqQ00C/o8OCq3
         lKotBviJRzkYRlQqOpDQ0cKxwRx3av6K+8Ohb88pyYbUOeekFyyv9bxN2PU4DdW5yPZW
         yr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432310; x=1758037110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCGWwE0Dfpn0jrzsRy+P5oxdVsQ38mSXaDrR9/FuTMk=;
        b=hBt+UEB4aU893Kzm3V+aNq5kNXm5PlgPVOlvouKcCeMtACiyRh8VPZfgPYXMIWTNIT
         55XoRjagnIz2bVxohx9JvBdxkQMMIkLvgpuM+16xgN7p3Xn8NHrIgO17f/ucRUFknb+T
         URQVuG/arDjGVEjzf0Md3yf9dNGw6u0Gy8QnbABTLCalzwFoUGKjFmxmduSnBrnnT677
         CQh0+P32q5IyreIO+JSYjbX1MIJ6wf2FX/O1QhcCSmXjydtda2iRqMzArS8oBFjGwtEd
         KLGK8QKPMFqWDdoVcp3dOpklKu6yUym/Yzy7Xgf3VKk1xaD5ggJbPpDjt12fJbQHb4yp
         GdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UFsjxChMDxdHLxUmHdIipMwrO00MGG3loYjUbAZluOqILW9xDcrlelouEqdup6UJMo+YQ3WZB+EKqutqGGY=@vger.kernel.org, AJvYcCWwL2OgvGw2S5kmkaIlGatUsFP9SVDYDDYDbmzjcxGr4toeElBbFbii8ZRq5iR1E4IWmKnVVnp7GKRePGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGD4+IafAcj9Vl7YsGr+83zN6sy8yZBsG60SoZeyY6LTJYUFS
	C8FZsY2w440S9HieVgKBv3tMjp5jH+kBYbADIkserzkUqC7BJsvagI1m
X-Gm-Gg: ASbGncvbndHAFiv4RycRDpI3qugfXHp1ESQRgNNa7Rhfug8zEASYzWX4m+gRdN5JwYa
	JCHEhOCmdCqytT0nmPSTzfP9d2Gdwjmp5fQZ/0vifX9+IsSO9ExaVxvMJ+UXMzNmxXE4ys7A0PS
	or6wE+CI9OyyynVahe9iONxnbIGEcQDDEHc9PdVjahsPAPTXMasqCufxLXyldKPnJePhw0YVIzi
	oT9K2UYz7ONVA5weYZi7HwrnVpaF6fI36F6NwQApQLJM5pWAimxZMIx89EfTYLWj1eneX+FlbZx
	KJLhxUr1S4v1yqcoGk7hmPnuP19NbaPqtzjgDhq3yPRugPe/Rql/A/YjjGrz8VRN3cKNFjeLK1S
	vbRsRhTKg1vxLQXxyhN7jlu7+5lIl02+6Jds/RCa5fVDLeVOP+ztWxWyTV/sQtUHI9FDQtDALOY
	NCFZgdV8gN/Wj/epNJyZjWSqdUURcHnnJStA==
X-Google-Smtp-Source: AGHT+IGAB3Sm9mUCHwWW6zyk2l7yM8J/xYP6a7duPO0bIwn42vPWs0GKOe2trIT7jLxE4emgH+9CkA==
X-Received: by 2002:ad4:5ced:0:b0:74b:5d86:7539 with SMTP id 6a1803df08f44-74b5d8675e0mr65695896d6.42.1757432310084;
        Tue, 09 Sep 2025 08:38:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-727b2c047dcsm112993856d6.59.2025.09.09.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:38:29 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 17328F40068;
	Tue,  9 Sep 2025 11:38:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Sep 2025 11:38:29 -0400
X-ME-Sender: <xms:9EnAaObiyHjyF2mgTYX-MFg7x6b78Bh3AeYcKdQPcoxm1AuIY0OQ3g>
    <xme:9EnAaNPfMTbCfjYarXnNz6iS_WofDIAyHL56CGiGyfNPEVxzob97dJXWSsr3VSlQG
    oD3IMkRhyaZ-p-QjQ>
X-ME-Received: <xmr:9EnAaPYCP06nDUMV5Q-z6cM9hLZxOrX_hoPByc3Utb-WubEgTZ5GW-wEhiYb3tciy8OVSJV4THypdzjI12UB6G0-rq1eC-MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprh
    gtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghr
    ohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:9UnAaNVLcJCJMjfDfJq7gKPPqW3EqUo6n85Y-texNoUsFhE50k8sQg>
    <xmx:9UnAaOAa-DWNU7UofhZ3rq_sNJxqeLHt2ApAlAtRi4yCKRkaLEkoYA>
    <xmx:9UnAaJIhLErM1xB2Tn7JO4Y77mPlw1LcO-aBMbhcCUm2OlNOxbPgQQ>
    <xmx:9UnAaMtGHSDlECtVgKueyTAsjbCFBO5ioSZ9ITJnVc41pWPfKewl7g>
    <xmx:9UnAaBWR4GFvw59_R6ULd7-GYvFUvjmzNQ18wUxm52KkkwOfv7wYTjnT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 11:38:28 -0400 (EDT)
Date: Tue, 9 Sep 2025 08:38:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <aMBJ805QjQcPdRol@tardis-2.local>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>

On Tue, Sep 09, 2025 at 12:04:35PM -0300, Daniel Almeida wrote:
> Hi Boqun, thanks for chiming in!
> 
> > On 9 Sep 2025, at 03:57, Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > On Mon, Sep 08, 2025 at 08:10:28PM -0300, Daniel Almeida wrote:
> >> A lot of drivers only care about enabling the regulator for as long as
> >> the underlying Device is bound. This can be easily observed due to the
> >> extensive use of `devm_regulator_get_enable` and
> >> `devm_regulator_get_enable_optional` throughout the kernel.
> >> 
> >> Therefore, make this helper available in Rust. Also add an example
> >> noting how it should be the default API unless the driver needs more
> >> fine-grained control over the regulator.
> >> 
> >> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> ---
> >> rust/helpers/regulator.c | 10 +++++++++
> >> rust/kernel/regulator.rs | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
> >> 2 files changed, 67 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
> >> index cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350ffc045badff9076 100644
> >> --- a/rust/helpers/regulator.c
> >> +++ b/rust/helpers/regulator.c
> >> @@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct regulator *regulator)
> >> return regulator_is_enabled(regulator);
> >> }
> >> 
> >> +int rust_helper_devm_regulator_get_enable(struct device *dev, const char *id)
> >> +{
> >> + return devm_regulator_get_enable(dev, id);
> >> +}
> >> +
> >> +int rust_helper_devm_regulator_get_enable_optional(struct device *dev, const char *id)
> >> +{
> >> + return devm_regulator_get_enable_optional(dev, id);
> >> +}
> >> +
> > 
> > These two functions are already EXPORT_SYMBOL_GPL(), so you won't need
> > to add rust_helper for them. Creating rust_helper_*() for them will just
> > export additional symbols.
> 
> These are inlined (stubbed) if CONFIG_REGULATOR is not set, so we need the
> helpers to get around that, IIUC.
> 

Well, then the question is why we want to compiler regulator.rs if
CONFIG_REGULATOR=n? Shouldn't we do:

#[cfg(CONFIG_REGULATOR)]
pub mod regulator

in rust/kernel/lib.rs?

> In fact, doing the change you proposed will result in Intel´s bot
> complaining. Same for all other functions defined in the helper C file.
> 

With above, we probably can remove the whole helper file for regulator.

Regards,
Boqun

> - Daniel
> 

