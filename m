Return-Path: <linux-kernel+bounces-748223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D413B13E18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D73540271
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBF270EDF;
	Mon, 28 Jul 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrjdpAJF"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0172621;
	Mon, 28 Jul 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715971; cv=none; b=XO5MtmJdDX26CBKAJqrlmtA50iuyRB4RePPKnphOapyV/3DWlHkJA3e/U85v+2sMffJfFEwhA8LdVHC6Y3KDfcEWgVOwfxAZ/ej33kNZ4gE2Ww4etxExA6FbXWujyIWlthzR87C7bj0nkw+ySXjAFNMomzcbzhAeoRnDOzwYe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715971; c=relaxed/simple;
	bh=JrkaAoJ7Tiknbca8UqI58Je2aCyKbjCi2E75WVbKTd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9S8uf0wS7ppL1OBwCLVuDO+0BFUzxx3K5JBHJdoKAXa5VxkdGV3vrQNPTf4YQJN538+cBtxQPiggKmfQvizupNv63X1avf6jdEhQoOZRYVlZrdgRC8h2UZkMgGrJ4eo9wA/jyvaJqEfe0AKPdE6SjKJryQwBNbK/00W4/fHlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrjdpAJF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso39016496d6.2;
        Mon, 28 Jul 2025 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753715968; x=1754320768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLT/rylW6yNv3R9erMx+Eq7H8Q6DuqgDZ8LW1Wt7U98=;
        b=SrjdpAJFaowmM+2HUMdMNrdN3ixuLbAC4n1DAQG25BAwmk1F2ZAl3MICUVk2eGYOgL
         7+P+1OC8v0rdZfdNczXv7fwdxcfWza1j9xD3ZedM/8sfjCxx8cwDGaN3KTtBOQUpAxn5
         zkGAHgK48kyS6eNNXVtF+vKW4UDOBahzfAbxl60Yz3dIgeHbv5mJm8atZRRd82E0iu8V
         qbswknnIXRBcGr4czW7SVVqRT+Y77uNLDf+CUIHtW9oOiIcDXMEVadC2ulYRVwNqUKdx
         vy4Gh9quLVD9kpFpqjP4Yuj5UvZUO9VT/rDZ6O7uE6GNKBWd0pcblPFmu66MHB3oD2kD
         PM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715968; x=1754320768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLT/rylW6yNv3R9erMx+Eq7H8Q6DuqgDZ8LW1Wt7U98=;
        b=js06bcAiOi92xpWJh54p+OoGn+wBMHQe61MSO29C8RafkIkdk1/qppZPMuO0LnuYHu
         cI3N48NZpvA9/Hb/ZmkPyPb3kGZigDnqJwxgk7321fpWKA82Yrn6j+G5hXSLx2JNlW5i
         esmv1ybFCDRAZ13CO41sVHpY8TdxRBfT90FswgBhnhbYOVUr/Yc0m2JJbvFf6RF03MJj
         b/DmWwneS2Io47io2Lb1EbZcH6ohZQb3q29VXc7+7KpD7A0zmeQ3w/CM3Yvf2kVFk5rt
         RTPG7o2bHaAAfhxjas4ucNHQOfqAyj1ggFCF9g6AuvuNjLua7wUWD6fgcWy1wt5HiPZm
         Ylkg==
X-Forwarded-Encrypted: i=1; AJvYcCWaMAZwoHNmP0FW1DOBpIaKdd3zyKEH0akpdLEPdj+IIv8SBc6j7x4p7Kqzl8YSEJe7hOgl+CHOazXPOAQ=@vger.kernel.org, AJvYcCXh9KXlmxjnypPakaw/7CTFau0PcbLREMciHaa/Gxm9MvHVylPRqYo3QvNx00HLkFZMLOxsveu1vFHAAYQrIeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc618z5821kS5ciQkPNZhxC0Qom8yKLIaiRHkU3s61NSN2cbpH
	KLpiJzA+if9ZSuUyh3YXZ7ZjC0AtaqXCalO73BKk5fE6/yyEfTCqqIC8
X-Gm-Gg: ASbGncuwenfv62E7w8ungeNdIfx2vaEJWlhAtbifNrkWu7klZDLmrMsUKMA8cUsiZ+y
	cmwmwwduOrw75he7CBEhdVcVyl27NZgT23Xdrr5RJRQ9d+J3CcPGFgPq1TydJnzxyGN6DDbtqI1
	ib6ISYCVg53Ykh3KVJ+ES/yBh6ReF9Uur6HhJyVaRchYH/RpI1zT+3oL1E17vANEtehu10E/Qrj
	2bw7tZurT/jradoDRmoHpjYYxPSDujCWZ6WZOfAes9UnEm8uoni77cIgPkZXHbMCxQ4IcpGtA61
	IUlgUXQQ4BOgunw4vItdKBS8q3u+mxsBstyNXFE6p0iuO+R3HhR9qYzszByYAQyCoHF4MpqOnR+
	AIu2ZDcZp1z+1lW4UFBXKmniSgM4BrbZqXRin78F9LpBfz4mnBFzgF281+gnvMOBfw3zHsXtCRs
	sBuDwJSaI4HH/HuD4zzZVT75o=
X-Google-Smtp-Source: AGHT+IGlEJGZ736lYuT3B+uy3e0pPQZ8PHcz1E+GfL3FCPBW2RqUS72ySe2W7OLoiC9aSxN8YKFZKg==
X-Received: by 2002:a05:6214:27c7:b0:704:f4bf:10a7 with SMTP id 6a1803df08f44-70720603914mr182929196d6.45.1753715968021;
        Mon, 28 Jul 2025 08:19:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6438a480asm301681785a.86.2025.07.28.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:19:27 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E887F40066;
	Mon, 28 Jul 2025 11:19:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 28 Jul 2025 11:19:27 -0400
X-ME-Sender: <xms:_pSHaIbdbrYl57tQvKWYOj0saP_1jp8hOg5MIVwDdeaJBi6NO-Q20Q>
    <xme:_pSHaOG7b5JC8MgVxjUC39REkmRzyQK1X19Mv_8DACg9OvDZSW4dd2rXoxWfGnrGq
    EH3sTlnzXvziasTkQ>
X-ME-Received: <xmr:_pSHaLruTLuLJa7mISvctoGZKXpGFnFPSX7MkDC38L81e0p6DIH_3xOnlEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihgrmhdr
    hhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrsh
    htohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrvgifjhgsrghllhgrnhgtvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehloh
    hsshhinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_pSHaJxjqves7SvCOVB5W0svb2kBRDx4hpkRHAlGKUsSt8VOg0dLcQ>
    <xmx:_pSHaFNQH-49n3B8FAYoApumrgOka9W_QZQ5YEBsDTWCq4WEBzGukw>
    <xmx:_pSHaJdh5U712kScNCplLzjihOk5lpkQ-qSBepqxGXdggUDw_rcWPw>
    <xmx:_pSHaB4QMrmZImaBIdmJmE_aTpAzegTkSAuuWkaLtfG4oaQckOfRMw>
    <xmx:_5SHaJKDM8G_V5eGDKe16kbM0YYLdIbGCkGvymkagbV2FTuSXTddRCzi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:19:26 -0400 (EDT)
Date: Mon, 28 Jul 2025 08:19:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
Message-ID: <aIeU_RSpDYr8eYLz@tardis-2.local>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>

On Sat, Jul 26, 2025 at 01:23:23PM +0000, Alice Ryhl wrote:
[...]
> +/// A reference to a [`MapleTree`] that owns the inner lock.
> +///
> +/// # Invariants
> +///
> +/// This guard owns the inner spinlock.
> +pub struct MapleLock<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);

So it's a guard, how about we name it `MapleGuard`, or `MapleLockGuard`,
or just `Guard`?

Regards,
Boqun

> +
> +impl<'tree, T: ForeignOwnable> Drop for MapleLock<'tree, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we hold this spinlock.
> +        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +    }
> +}
> +
[...]

