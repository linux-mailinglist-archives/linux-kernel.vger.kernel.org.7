Return-Path: <linux-kernel+bounces-751222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B63B16689
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420B07A1E32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0752E11DD;
	Wed, 30 Jul 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G57wyzPj"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC322D9EC4;
	Wed, 30 Jul 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901333; cv=none; b=TU3eqTl4enN0p+Hq93ZE/0IGbvUFA3zfaO/Du19yUnArH5GpNhNHwosQpQuW5JoKs3SYPkGvkp/ObYOumPxfz+orgoqF526tWEiVgdhgC0dVMZiRuTqArLIOj21FWdwXoqL8dS8il5Vvg2fN6xAigif1LSi+Tq+iJSXWcQp/Ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901333; c=relaxed/simple;
	bh=7m/Bqt+oHgaR0fkwoXK55FLTHZDtyBRWVCK3oOO33a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmpMPbkoR/PRsIxwdI5f5CvlDBduLW0W8qmJfMCcOv9VPkPrFv7wOoalKdHAYXvPOEut10EVuGNAkATyKSrV8SfSunwYFS5AQTwh2Ke/2/JUgGFY3y00COmNMsYjGHpCXGQoKtlDte54hlkn0C5uX6IJR4vmSTh5dAKEyPAHFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G57wyzPj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-704c5464aecso1362466d6.0;
        Wed, 30 Jul 2025 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901331; x=1754506131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2BOzUYIo1IzA/cmXpLCnED0v1ZYamC5Ieg3goXexMM=;
        b=G57wyzPjToLGPolzT6vkmj5+++9LTYPeMJZ1jjmjAjt6n1o/XYp835X7YNNhFfYtUT
         LAtFfR+FtAmoOzzmPDIT/f7U1y1NuW4GCxvZ3gxJc73Rx91as92csgvKSibu49yggi2D
         0/nIrRjQs83JZj+/NyOIyLbw7WZN4QYiKd+GSPG/FtxuH5PGBUWxvoUPATXrck2GgjGk
         51S/Wu6wJH8FvzfrB/sqmCrLZx5abYE5TgMccCu796IWw4ovy84g/fakHlE80/8Zntei
         jUGjXg8W6Vd6jYcd7R0o4AL4pDyh4Hx3LIvVV96e4ih5LmsHYyySRpde+oHgZflaVdOK
         tVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901331; x=1754506131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2BOzUYIo1IzA/cmXpLCnED0v1ZYamC5Ieg3goXexMM=;
        b=cfbzb+0DX+mQpmfmMY3clnFhCt7Ttyx8P64JlGksQK+TeM6mEukKgusKQpzrJKKTek
         AeAiFfRl2dGmx9jzbOI1FM0DHcfWPdotB0pNt7kV9pMjOdnCSPvtCdJRRHPhTdZa09BA
         w35hXQwc4JtQfgQfuqqmMMt977lFN6rwu2Rf1Q9+NI4ZVUdi7aCrVKtukWv6xYyA6hPZ
         6EjkkOkLE27nY4Y3IN9x/awUKqVcuPO59CZW4SiPbUHEDkLnTkPZiwRYOq05P0ZueoJh
         QRfKJ++px4zInoPOYUbwUlhhk4yiafDbzdd82bDa7G1PkCbeHyKyiKNwqxZZNxVXBlGe
         OgAg==
X-Forwarded-Encrypted: i=1; AJvYcCXI5CjW5UB6SzyDUTGvlaAbTAiELb2KxGZJwAR3JNd8okE+uCWXhj+pUYoOZh4PXCnunuoRLhMVrt3eCFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3hJFHSpslRL4aRqJhILtGixslHEISwHBRpyNu6xDfpVHstRH
	RifQU7XxVOPoU0vrITjbyeEh+VmcwoLvmxtgHrFuZUM8TnYhsSvgfsjOS6meGg==
X-Gm-Gg: ASbGnctcyiJgiZ5wP7SfVtk2bgaq07payiRv72YzXsQheTEfOJHGuH3PHkkUkb9O6qa
	irH/xdvjPe19Rc360gllvN4KLkMEm3i4R2cndnNE6Eqn8T8kdWhpOo9iqQz5EK6qOwsTWz+2nZd
	vFsMhsgpVh0nw9t6iLU88cglqkJwVnB6SVka5taCXDcA7ai+uly2THvpYJ42LrIVkUS2woP3529
	ly9yXbEuj9IToAsevWZgXoU01Ysdgxw9+4/IhOzdnBRLQljYjxGPfzEniuYr8aO5pW9a37qatL1
	b7Ej36ijo+7GeHCTT8HCTPdwglu+Wo37MMwyhL5ve3ZN7FO6VNzaWeE12dtP9/Lyb2LSAD6m12Y
	D3acVw3NjLrFHlW0uxw/bZTSbiU54Rkdph5KSoJNeAwwVH965C9uy7Vvf5lB8i0e4Z1tIcVicUL
	xYiorKAbvw3yBWdq/DJ7NIMlE=
X-Google-Smtp-Source: AGHT+IHD2zVccNyjufMlU99/OpGzaxEFiT5Rv4t1UzfzI92q29xmwunZ/msP2RqjPIBRiNcXuDliww==
X-Received: by 2002:ad4:5aaf:0:b0:707:45dc:c36 with SMTP id 6a1803df08f44-7076710ffadmr52145906d6.29.1753901330977;
        Wed, 30 Jul 2025 11:48:50 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7074a1ef567sm44392846d6.7.2025.07.30.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:48:50 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B96B6F40068;
	Wed, 30 Jul 2025 14:48:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Jul 2025 14:48:49 -0400
X-ME-Sender: <xms:EWmKaIPKlHjGfO6IYQxyggJAwhkoajr90q5wGOWnfol39CvJEff1NQ>
    <xme:EWmKaFj1tWX_aL1676dtEKfdsxw6pqQpOyRq6iOLpAC_6egG4Dhwlsdy6Z5GD7EcU
    PltNI4gYHBl6Ognwg>
X-ME-Received: <xmr:EWmKaA_k6Vo-bEFdJDCqM7OqHyynQwLht8v1WCChbfc6Gc1pbFJVM_IDXQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhi
    esghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothho
    nhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EWmKaKLmPspQz78WgHQwhoFzN_Oiy9s4b5-ht2pL9z-19W6fMrjGBg>
    <xmx:EWmKaBb3C974GqzdFSHD48PX4rBNIqKsr8oXaTF2Mh5DguPDZLuG-A>
    <xmx:EWmKaNjsvEHvX70mrNZ9kpmvHmtuxOX9v-o3TbddnEQ9JLZwUAG67g>
    <xmx:EWmKaG6_LN5xrcSMA8ZBqMR-0VLbQBiaFoRxqetvQwi06CcLmvSRqg>
    <xmx:EWmKaFqevt2SWaIsuioVPv3IgEbMPqil1t8qxD1GOIbkdmLZ5AVkOJp5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 14:48:49 -0400 (EDT)
Date: Wed, 30 Jul 2025 11:48:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Alban Kurti <kurti@invicto.ai>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
Message-ID: <aIppECd4QJIz3wbE@tardis-2.local>
References: <20250730163439.50753-1-boqun.feng@gmail.com>
 <CANiq72ntUsB-a3Btf+PwmezqN919FmL_P3g589mVJm+-_h2CcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72ntUsB-a3Btf+PwmezqN919FmL_P3g589mVJm+-_h2CcA@mail.gmail.com>

On Wed, Jul 30, 2025 at 06:38:46PM +0200, Miguel Ojeda wrote:
> On Wed, Jul 30, 2025 at 6:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Miguel, Alice and Tejun, while I'm at it, should we also rename the
> > function to `spawn()` because of the motivation mentioned here [1]?
> 
> Sounds good to me.
> 

Thanks, I will add it in v2 (probably as a separate patch) if no one
shows any objection.

Regards,
Boqun

> Cheers,
> Miguel

