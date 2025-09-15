Return-Path: <linux-kernel+bounces-817908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9DB58867
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B70A3B6DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662952DAFB9;
	Mon, 15 Sep 2025 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF9kcw0E"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E22D238A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979826; cv=none; b=QCtBcj+gxetLKqm9MrKhKhmMi9GFkuykI/LqX5/6a1KgTwfRTmW0iliEs4xsrQZ7lsF4wPzdE1RU+TU9glsl223HEtRqqf1p8BnLeR56TgVpjXSN5pGO425l1fHo4T/ZQVh5QedQPEmGHM501h5fE7xDByuqQJTSkDDLUHpf6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979826; c=relaxed/simple;
	bh=DCeF63tBNbF7HFYiehXMRuKCFYhth2Gi/fMLF+uJEBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta2HYLls47UmuAeputJlcSe9qf2ikAgPB7KSKc3wPRpb2wa2nw2Y/tEmdyBQselElG+q+Z2KrbAnj0m83hQ9x/M8GGQXisws6XYSzhvQdVoEcdSHkfgibo5Ot2ueqmvcn6L5mN7AVIJaTsStPITOJa+7gm5flwWpNSnsA8szWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF9kcw0E; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-828690f9128so321687685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757979824; x=1758584624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdgJHBrB/lzs7soTL/dZrbkv934nXJ2LKfj8nw3fMYE=;
        b=gF9kcw0E/T6NA3uVIqDLVEEGBfPsBwAd2mqvKNK0Kqj9s/VePjTg1imoErNr8c9gUy
         nE388B8mXbR7w3E+ulB0/QRYplUg6R0D7+QIZncrn1pAK4Eown7WHBsspBEtmqe6YlQB
         Y3SSYY3rwPkwOIyjrSKfDKZ6inB2PCInBVSt8kw9rpENV0Us1GWXoFCgO4ND3Rm/j+Tk
         wxYZLZFWW2SOFSGoYih5NIIJNHhKlcrC8ex9g33JVHaeztKj9jvmcoJsxSvsJwqizdzT
         XOHJy6U90GEZSQkjNKQENGm+n2EtGDZtaXh/dkK4iVU8oCrbRhMrSyaIeiAhySKrdUZV
         D7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979824; x=1758584624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdgJHBrB/lzs7soTL/dZrbkv934nXJ2LKfj8nw3fMYE=;
        b=c2la8w8Gmo4DvUrRYQukXUfFJhp5Jk7AUP49q055/RQ35SndHK9B49IdNX9dlMexuG
         muQFNHPS6uqTB0n0G3zUDR9D2r6+KYM/e2VCWWhQiGVRiUfAdW/TdFMGX9CqxEdemWvC
         veo5uG+ZfG1RiztP49WMZJ4JhReLsW1M+uTWCqE+rCCWr3aWeBYR2qEVXxED6w9jdebo
         0Ynrrn4WVCqvT/DIeyQY/rXiEiz6FRqAaOGx+6ah3+KJQIEUmgzM+vrePgx63AXPcyAM
         Jk02/MM7wMxINIFiWwj3PEcllnVGgDUYSQsju+Puq0yPke1V8UHwNZu8NZRuUUS6jAsd
         Bqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVPMwJizJqo4+B2upFpBHpCYXEh2eQ/f+Lu+nrMFMzLiYe78EjAos6xprJbClC439knUSeOwzcFhBn8m9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfaPAo376f9KGPKITznU1Tw0y5S8HHSJJ6lHIMP9aI7AeAOTD
	bEgDHgtiAXft+JgYGp6PykU0duChDQHB35Bw4LPCrtrAiEbI65qNHyd1
X-Gm-Gg: ASbGncu8aP+cpBI0Pnevc1AH0i2ft4FXuHlIAedn48cfyQqcSy2yVvLUwf0gxuMHprh
	SjLn87dl3aZVgUYBpM9g8I4DP2idbHsBWH0+tlrXZLRGIAxeY0LFkGvFNaPsJaMYpGQxoe0keio
	YFlSEAwayXrQSUC4Heb7nVTrWcE3DaVSSXsa3cBn79Lrh9oH6oTU2M+pRFgEpvN6W1h7Vb2J7tu
	llPzpsNXipYdDQi/h/r2M98KKaEs/y2J7CSs1W3P8fQKVo4Au9pAM/GjsGeUFHP4QSgWjMuG89A
	caH86tmqGl+Nb1FiiAXg/Ma3e/lRkL+AVPacLc8SAGcw+73kNMlVl1vZgqQbOhKWq0avynGWC/W
	J0j9v7z0jwVD5dZ49XI4lZEtu6HKmRz3jM1Jj5WDJAC/iJmG3VX/bUx9Qk8dt2qvJUkTtfLuPBf
	H6qX0fpuoBgDbeUKYZO9Sg/KeMIIDS8UMlaw==
X-Google-Smtp-Source: AGHT+IFtU7EGaYy0d2f1MqC/XVc068eWREOrfFX9Dv4w/usYLmOlLWrTddm+QEvCMQWyuJIKoB/FxQ==
X-Received: by 2002:a05:620a:4007:b0:82b:46c7:7249 with SMTP id af79cd13be357-82b46c775f8mr200373185a.24.1757979824066;
        Mon, 15 Sep 2025 16:43:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19d151sm845214485a.50.2025.09.15.16.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:43:43 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05368F4006A;
	Mon, 15 Sep 2025 19:43:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 19:43:43 -0400
X-ME-Sender: <xms:rqTIaB7li7PgqrH7NwXXHRXivw9ArLOXOkLAg10qfyk5tGPbct3M6A>
    <xme:rqTIaMRZL7pu93dT-F1XvsEGskZbOO01vKYJskWVv6_13OrSfvMIgAAXXwFqZTQSI
    DjbgezHbITPkBtefg>
X-ME-Received: <xmr:rqTIaPzHgWL5aNPd3Ufxtd5nQgtWWyxHmyHY45ZJ4eH_bq5SCQjYjjqxCoau>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefhheeukedtvefhtedtvdetvedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihurhihrd
    hnohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghqvgesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqnhgvgihtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rqTIaEr3_gJg8HWvzMmd_0jIi2Ve2bxMZbqOshVQqxL0a2H25a0Nhw>
    <xmx:rqTIaC3XZT8VHt8KZm5uylFi3x041uV9UThQ6dZi4U7YtOAZP-UJBA>
    <xmx:rqTIaEzOpWpLmoMcJ7XUbUp5P0_LrsqRlGpTlzlLlK-1-ttTu3-T3g>
    <xmx:rqTIaGikediGB-Qqun_LVTco-H5WrpEBjscboLri0PpDSrHqwUTJjA>
    <xmx:rqTIaPqzriwvZVqjYr7Xvt7sPgvS56CSQh7QoGI8wexHn7Of28d8H0xm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:43:42 -0400 (EDT)
Date: Mon, 15 Sep 2025 19:43:41 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the tip tree
Message-ID: <aMikrcaVbSYdkdmW@tardis-2.local>
References: <aMiZpcBu2LDzwCje@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMiZpcBu2LDzwCje@sirena.org.uk>

[Cc Ingo, Thomas and Miguel for their awareness]

On Mon, Sep 15, 2025 at 11:56:37PM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bitmap tree got a conflict in:
> 
>   rust/helpers/helpers.c
> 
> between commit:
> 
>   ed17707bd8f33 ("rust: sync: Add memory barriers")
> 
> from the tip tree and commits:
> 
>   ae384a4623fc3 ("rust: add bindings for bitops.h")
>   78d9de4ca3474 ("rust: add bindings for bitmap.h")
> 

Thank you for reporting and your resolution looks good to me.

Regards,
Boqun

> from the bitmap tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc rust/helpers/helpers.c
> index a16758a6ef395,abff1ef14d813..0000000000000
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@@ -8,7 -8,8 +8,9 @@@
>    */
>   
>   #include "auxiliary.c"
>  +#include "barrier.c"
> + #include "bitmap.c"
> + #include "bitops.c"
>   #include "blk.c"
>   #include "bug.c"
>   #include "build_assert.c"



