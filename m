Return-Path: <linux-kernel+bounces-819374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B513AB59F98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18E51BC00C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E8313D51;
	Tue, 16 Sep 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9g5BGvH"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51D285043
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044413; cv=none; b=iYHc6tjOgMYQQjvn/UCLvcc6vRive9xqKK02RlkZnz0xnpYvLurK7P9DzFsNxJEfF7OIyj6PEUy7AEOb7YK9a40/0D6k5u6jkG8jOPQr+lTNMtdwp/4Eil/JZ0vb1gm2N19exWJ6m67cH+d7aNnH6JG7G7Bsw/YKv2lEX7GY+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044413; c=relaxed/simple;
	bh=PxvetKEOhfVbyfSpwxBKJTHQyvB2pN17CD9NoGUgrms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxMeOeVAodGIyR11IZ5YXThAojdX+0r6VSqmA0wybg3DvSFfBO5GmZ7vAZ+AtSW4qcS/2bNhbCXD32gSA/u0TYH+PlhptuqJMNNs4pOr0XQ0S+2i6VGjUZYIuzK9EB1RkNNzfFVsw0a4ePlVFyl1onhwMJjjwtZjM1SCUgd3414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9g5BGvH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so57681871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758044411; x=1758649211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JHjtAeALUMqVAF+B7s3r/BTz86GftVTXFBmSjBBmByk=;
        b=Y9g5BGvHFJDUpPxjg0B2WJ71FjRwkSo9rlUMqvNyLZv0X4gTU0XSUGYdPZTG+M7DIL
         lpTm1zk/P9aP1XGsnrQf2e6Oy6fxUy18VveNNwosZ10p4/wjmTpSCScN/cEAKL/F/vGq
         uYp1mlPWtCl9L8NhVbuNVUuw5SiXXjitTSbP/QguEMyRRXOXPvw95098LCBi0JbOQDtc
         mnBOzdkm7d7cTZ3YvPao1fgHQOWRm/MwZVhhk1DphAjd2wKsfP2Z9bH/cM4lGwV6eyMQ
         yyLk8OST0ZdupY9Pqod1cbwU8tK2vr6LD+nVQZeKFInfxxAixeb7EGS5fjyKvxdVP8Ot
         ESiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044411; x=1758649211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHjtAeALUMqVAF+B7s3r/BTz86GftVTXFBmSjBBmByk=;
        b=OJfsb35zx0y+LV17qkxOKUaL9P27h6n4CM7h3Li2BHzguuQsZa2n5EQ4SCauMqgBZR
         sjn1MSgINdzgsGC5T8Brg6H2qcHvIel06Kgn6dZAA5aVdIkqqZ7zCdIfIZJ0SDODph6J
         qQsal4JLQRLcp6ZYDoBvF6gbYcg93mhk+J48t8kjjpxagj2Jdeav0F1zsW2XB+SV9DEp
         lk4hn5yzb1Vx5CdkPeP80cmYM6uCniiaLhhlQdX6kkP16Kb+wsC05ichIcy7z8HqX2f2
         epU1ro8w7K2zQkK0siG6P3a4Di492kMhiQyKq4qcA+1tjAx5bRvhrEUXJamVKbVkgrLV
         lxjw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjFtNEZ+DLOSLVFnv5iwI8VZjnlaGjP/JiCpXPRsU3I8kNeF+uuCzJCj+B31kg3tT5LgqJB0WWvtBu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmUTArh+4l/y8oOD9FmitV/ZlQiMppEDKlpskNyVwBAiABUnV
	+nMlXS04uKek7RjK16zJj0Zc7WIxEBRE16eaYFJTqIpTjXXeWRJDRGqh
X-Gm-Gg: ASbGncuUmDQN9YjCK1bETAkQdfml9nudTKQv7c53lMk2fd+cVWAFDqxAXMWxmeShVWf
	LacVp0lHkQTuQ/X+Ulx+fKB+387w90PsJakYaH1QBdYxy6PTnJzqhtHgt+qbhhqtVvqJN0+s8KE
	1Ytoht4B1vcRW6lFiVN8yRLyA+UVR0vz1UPAK/8NttNc/tXOOXokGejwdaZ+/hvRhKyMjNObD21
	1gNhn6GmQxQyGtaCGCOiZXjgRJ5jRWhllz1ipQFbtpVxpM11zFTdFRRwrBow+gw+BO8jc9dZjlo
	5XTPKLF4QDrZltCkXYu/ok/Jxcug2ND18AcUEiLrtUB8SZBNJBxDU7joYQLvvhTqBi/Fqeyq7xH
	NNeihO+izkwLvB1pIKx8nyQw9FHvZg/q2rL6kQNWT1wZHXTuvbfwBWkDUP+ndDNJoAruXFqZLEP
	6F/g35Wzovs8cX6hT7S3nJnip/o9k8llbscw==
X-Google-Smtp-Source: AGHT+IELsH96NHZ4V1/i4oKsQYgGeqITcLKs9/I1AQ/N8yOvozUhQxZYMpvNpRkJ5TJD97CuaZUFlQ==
X-Received: by 2002:a05:622a:256:b0:4b5:ecc3:694b with SMTP id d75a77b69052e-4b77d014426mr178894371cf.10.1758044410811;
        Tue, 16 Sep 2025 10:40:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639decd84sm87780841cf.50.2025.09.16.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 10:40:10 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id CA929F40066;
	Tue, 16 Sep 2025 13:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 13:40:09 -0400
X-ME-Sender: <xms:-aDJaN-9Y06rbtghemJtEwjApYjwQXfGadMSyPOwxuN1CrE-iDVteQ>
    <xme:-aDJaF3UlyKibAJUrRZkx6lPGGkY2KZtqke5ygD13MB5J2ezfe9RCez85GaQJ4mvL
    G8zSRjniegfdfk3mQ>
X-ME-Received: <xmr:-aDJaIC4cdi2qF87RhsrJ487cd3nKJbmrClFmVvVw5gkxD7Gjt0nC5l_jymbko_yZU3mO8UnrOUlNxJLAsyLOuxHLCGx97GSo6sDcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvug
    grrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopehnrghrvghshhdr
    khgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvghhrvg
    hsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhfthdq
    thhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:-aDJaMAqEC3lUKTN_LJI3CpkOLGxOZlDBsOzp_gnJe40i0KMGgH7-w>
    <xmx:-aDJaJOM8MF4_xwJEDkyO76VEYI_sVIvpZzwj6o8SJeoVxlKrky0gQ>
    <xmx:-aDJaGOf-8-5ZG8k0o-UXKLyPxL1UtYNwtzqzaV7Zv1IDNR6_oHsMw>
    <xmx:-aDJaNtqwgUjPsWzNHczuxJ21j4b3cRN1Z_E9GZtvXdNZDo0Tdt2ow>
    <xmx:-aDJaL9gS9abOkrDdNam2n-ylBTFpKmvor7Cznxa36tZb6immwH6ujjc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 13:40:09 -0400 (EDT)
Date: Tue, 16 Sep 2025 19:40:07 +0200
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	rust-for-linux@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
Message-ID: <aMmg97aXBLMb_4a-@tardis-2.local>
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
 <CANiq72==_ch0_7ZD8EEc2AOW7Yz1-b8i2ae0X6xDSkLJy=Dm6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72==_ch0_7ZD8EEc2AOW7Yz1-b8i2ae0X6xDSkLJy=Dm6w@mail.gmail.com>

On Tue, Sep 16, 2025 at 06:40:42PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 16, 2025 at 6:26 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Anders bisected this build regressions and found,
> >
> > # first bad commit:
> >  [eb57133305f61b612252382d0c1478bba7f57b67]
> >  rust: sync: Add basic atomic operation mapping framework
> 
> That is very useful, thanks.
> 

Yeah, if this is the bad commit, I believe the issue has been fixed.
Because that commit in linue-next indicated the problematic locking/core
branck of tip was used:

eb57133305f6 rust: sync: Add basic atomic operation mapping framework
76eeb9b8de98 (tag: v6.17-rc5) Linux 6.17-rc5

one patch was missing in that version as I mentioned here [1]

[1]: https://lore.kernel.org/lkml/aMWMVQiZxE_mv7va@tardis.local/

Regards,
Boqun

> We (Boqun and others) are in the middle of Kangrejos now, so we may
> take a bit to reply, sorry.
> 
> Cheers,
> Miguel

