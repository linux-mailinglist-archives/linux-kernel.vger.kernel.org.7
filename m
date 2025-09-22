Return-Path: <linux-kernel+bounces-827464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11CBB91D43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C503B0CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FA2D6E7F;
	Mon, 22 Sep 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVpiq3fk"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC902D6E66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553163; cv=none; b=kKz7TeEWfcwHqwaPPKv4rLhJT7XQ5qEcR60rs1teMGl7aCfAmt5G/jEWFTwAGzMJOqajZOHLys7Hj0awkjZvnIKD1tvyvPtarWMzjGB9uagIKTcnkuFhfBl55bG2PRMATgHT57WUhWdVJ5ex7QdQ+kByRE21+F2v2lBysMYNBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553163; c=relaxed/simple;
	bh=1PWtNxvRKbxFPDWc9oK0CqU7hLHwacSNSy72ep3P5sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiDB/Qj/b85/3Un7CJQMrRAlo7qw55qGBaTnUYaw2g/bTHiWsLW8Ugs8kZeLWPmfzJd0bw5O1r1WP6JTAeRzD9g2I+NcqaJvXTwA0zp24wlbnt1AA71S5J3LWj0mmFZcEUTRsNSvg9NecqZG83QJ66m6EBYKhFOlfyOGBba0TkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVpiq3fk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5f7fe502dso24239661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553161; x=1759157961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv0y47723YQXj23skGg2jVTBDdISRK9/QZECA8mOZh8=;
        b=cVpiq3fk2EyvXZXXgHDDak17DkvDlCfBEKfR/qrn0vfDcnJrOOHSvU7mw0Di+wB3t2
         02yE7EzdK/btaVxBBkMLKSI4JpTmteVY0T7EiPBLu+0XoIzJOlec1PnOo6VxRv235WRB
         jd7QD1yZlr66h2eZUt5sgTEAYd0zTJO6kkii8F0wJQVv6YVix1y3SlEoyk6xzb6wnLhj
         HS8Aen2nEqIP5NDUNCMVugp6SS13DlI6zJ1Al95cALM0CvkObuCJc/4bK4i956duCDEf
         WbFLrZW9mejXs5DI/xrvChC6NoED+4XEddViM51T7/LISXGeY2X6Jma/cJQYHv6QueUt
         RCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553161; x=1759157961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv0y47723YQXj23skGg2jVTBDdISRK9/QZECA8mOZh8=;
        b=ESYO40DjOH0n91nI6uT4k2dosWUFfxVN3bW57i3p84y11PnTAYsmZ/Xg68133fOJ3v
         siBpk+S1gDr0YomU8jbX7ZsKwzXnT6J4sVgBXAZ7i1QZNY4PhV8WdMkSNUdmLsPAAB5g
         MlPW5klkdjNsihtzZFohkmK4bS4jb/dhdsyjfRV03uBdFWAMHQS1h9WwMRnV/CdZSpd4
         xe7umWlF2bD0duhMAApBYlkCcScebi1CXGwSD8frNJ3bP3y6xoLOmTIu52I1Kzg4kdUf
         BDQE75AErrd6DAuweQHDEtbZAn0Feta0kjoD5qnpBQkf4x5ID4xTJhboUsqEbvhCeoP5
         qx2g==
X-Forwarded-Encrypted: i=1; AJvYcCXLAwbnfKkJO27/NB0KenFbx6i7hRQueYu1EwJKPMw/fE72KNaJHWx6ZjkHIWh3iO1uzIhcLGckRh86Tmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefRC/1mXNkl2qZGXPqaI0lKL1pb082WC1CM8ziWDMDzJIXfEJ
	2nCoN78ohE0mdA3E0jkjj8eAwbrhTToBgsiKTP40f/oKRlpFTk1DK3d2
X-Gm-Gg: ASbGnctlXc1GNf9hkvaBzactgT1nPA5aJlwHMXNPITTvgqkZLSy68O16euHCrePacsq
	wLyFKc6u03rS37g0sxY6ZC8o0WmvEXL4jFwLBJxTTAvG+d0Lrhze2x4o/SYK3OvgaS/bf3Mos7n
	jUNz7PQ+5NNpfIpMimp+pi9u79U3eyTFuNBXUqFCJng16EygyCAKhYTb/ciFr9vVeJA+hHtjRtl
	HqDpKedSY94k+XxbNmq+DW9ma7nL1HIxhru9r27slOjBjmfvKCd1It/OTCcMvKnp2n2Lv0uirpU
	bYTFRmzEonVLO7vavj6mVcI39uzv3AC1Whv3yIjlVSsxa+GW8O8/kA9aXJC49bLqzeRE94M47dU
	Gwa1TkwJng5oYdra1aqILE5kRdYJxAPjvmb0CwyFU7uLVtWJIbxG2+3fLrkWXJZSUlVu6UlcTQm
	iAL6lzBs5a/lDz
X-Google-Smtp-Source: AGHT+IEppR8/BUusJrUkpOVDQuWIM8gn11kIQwj9+wklEJaFajMHL4d80hJEztBz/owxkkx25oVhlQ==
X-Received: by 2002:a05:622a:420b:b0:4b5:4874:4f95 with SMTP id d75a77b69052e-4c073106965mr117448841cf.51.1758553161139;
        Mon, 22 Sep 2025 07:59:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84bc62df395sm150933285a.40.2025.09.22.07.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:59:20 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D5EAF40066;
	Mon, 22 Sep 2025 10:59:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 10:59:20 -0400
X-ME-Sender: <xms:SGTRaB39ZnwwFUwtXDrVYjLkR44bspUDiU_09_CBFJJFjp-9Q6vmIQ>
    <xme:SGTRaGVZdl50aACB_AczD57iQlPfvkeSYKCpuQ3wqWS3p-7wstnn3nSc-xxckXWyV
    PU4tDG35-_LLdP7sQhjQtXPPxOGl-JdlG7xDSIe9I6ik6cAO9Zi>
X-ME-Received: <xmr:SGTRaLMRH4NGoh4YkDwwt5_W9RVqY-JEA-6CLucqsxocBByhGUTQuNC6Knc8JVORlbbBWiJuClPSKRG4EbYZqxbG5Z7C2_Rj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgse
    hkrhhorghhrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrhgvgh
    hkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghtthhg
    ihhlsghrihguvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:SGTRaB0uCkD8iEUclYwFl55jOeKpFFrtknOapQZpR8qfsliiu-7xIw>
    <xmx:SGTRaHTLSuJKHHPFMveyRR2OZy2wqKZOoqHME3P0hJBvx3Kryl1dIw>
    <xmx:SGTRaElDxHC6nmY00Qmh8kqR1Q1MUKi4zFc8Ykc5Blloe5_q_zK12A>
    <xmx:SGTRaIN1oXV4Q6e1iWSpH5CtTyVM7P52NGjbKlC3TlH40jScLVjUPw>
    <xmx:SGTRaAj4xEaEKV-IXTWGQxd69_X0x6TQl019eVvSKEuvCC6dh2K8HSUR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 10:59:19 -0400 (EDT)
Date: Mon, 22 Sep 2025 07:59:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Matt Gilbride <mattgilbride@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the tip tree
Message-ID: <aNFkRs5_BK4JSQz2@tardis.local>
References: <aNEdWOS8s6U0c5pz@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNEdWOS8s6U0c5pz@finisterre.sirena.org.uk>

On Mon, Sep 22, 2025 at 10:56:40AM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   rust/helpers/helpers.c
> 
> between commit:
> 
>   d9ea5a41cef80 ("rust: sync: Add memory barriers")
> 
> from the tip tree and commit:
> 
>   eafedbc7c050c ("rust_binder: add Rust Binder driver")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc rust/helpers/helpers.c
> index 1c6096f53a6fe,8e8277bdddcae..0000000000000
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@@ -7,9 -7,8 +7,10 @@@
>    * Sorted alphabetically.
>    */
>   
>  +#include "atomic.c"
>   #include "auxiliary.c"
>  +#include "barrier.c"
> + #include "binder.c"
>   #include "blk.c"
>   #include "bug.c"
>   #include "build_assert.c"

LGTM, thanks!

Regards,
Boqun

